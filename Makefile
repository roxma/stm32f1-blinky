PROJ_NAME := blinky

# STM32F10x, STM32L1xx and STM32F3xx USB full speed device library (UM0424)
# https://www.st.com/content/st_com/en/products/embedded-software/mcu-mpu-embedded-software/stm32-embedded-software/stm32-standard-peripheral-library-expansion/stsw-stm32121.html
STM_COMMON := STM32_USB-FS-Device_Lib_V4.1.0

BUILD := build

BUILD_ELF := $(BUILD)/$(PROJ_NAME).elf
BUILD_HEX := $(BUILD)/$(PROJ_NAME).hex
BUILD_BIN := $(BUILD)/$(PROJ_NAME).bin

# lazy evaluation
OBJS = $(addsuffix .o, $(addprefix $(BUILD)/,$(SRCS)))

INC_DIRS +=src
SRCS     += $(wildcard src/*.c)

CFLAGS += -g -O2 -Wall -Wextra

# core_cm3.h
INC_DIRS += $(STM_COMMON)/Libraries/CMSIS/Include

# stm32f10x.h system_stm32f10x.h system_stm32f10x.c
INC_DIRS += $(STM_COMMON)/Libraries/CMSIS/Device/ST/STM32F10x/Include
SRCS  += $(STM_COMMON)/Libraries/CMSIS/Device/ST/STM32F10x/Source/Templates/system_stm32f10x.c

# # USB
# INC_DIRS += $(STM_COMMON)/Libraries/STM32_USB-FS-Device_Driver/inc
# SRCS   += $(wildcard $(STM_COMMON)/Libraries/STM32_USB-FS-Device_Driver/src/*.c)

# startup_stm32f10x_md.s
SRCS  += $(STM_COMMON)/Libraries/CMSIS/Device/ST/STM32F10x/Source/Templates/gcc/startup_stm32f10x_md.s
# Required by stm32f10x.h
CFLAGS += -DSTM32F10X_MD

# StdPeriph
CFLAGS += -DUSE_STDPERIPH_DRIVER
STM_STDPERIPH_PATH=$(STM_COMMON)/Libraries/STM32F10x_StdPeriph_Driver
INC_DIRS += $(STM_STDPERIPH_PATH)/inc -DUSE_STDPERIPH_DRIVER
SRCS   += $(wildcard $(STM_STDPERIPH_PATH)/src/*.c)

CC := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy

# Only Thumb-1 and Thumb-2 instruction sets are supported in Cortex-M architectures
CFLAGS += -mthumb -mcpu=cortex-m3
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += $(addprefix -I,$(INC_DIRS))

LDFLAGS += -mthumb -mcpu=cortex-m3
LDFLAGS += -Wl,-gc-sections
LDFLAGS += -Tstm32_flash.ld 

all: .clang_complete cscope.out $(STM_COMMON) $(BUILD) \
	| $(BUILD_ELF) $(BUILD_HEX) $(BUILD_BIN)

.clang_complete: Makefile
	@echo -- $(CFLAGS) > $@

cscope.out: Makefile $(SRCS) $(wildcard $(addsuffix /*.h,$(INC_DIRS)))
	@echo $(SRCS) $(wildcard $(addsuffix /*.h,$(INC_DIRS))) > cscope.files
	@cscope -b

cscope.files: Makefile
	@echo $(SRCS) > cscope.files

$(BUILD):
	@mkdir -p $@

$(BUILD_ELF): $(OBJS) stm32_flash.ld
	$(CC) $(LDFLAGS) $(OBJS) -o $@ 

$(BUILD_HEX): $(BUILD_ELF)
	$(OBJCOPY) -O ihex $^ $@

$(BUILD_BIN): $(BUILD_ELF)
	$(OBJCOPY) -O binary $^ $@

clean:
	rm -rf $(BUILD)

burn: $(BUILD_BIN)
	st-flash --reset write $(BUILD_BIN) 0x8000000

$(OBJS): $(MAKEFILE_LIST)
$(OBJS): $(BUILD)/%.o: %
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MP -MMD -c -o $@ $<

# generated by $(CC) -MP -MMD
sinclude $(OBJS:.o=.d)
