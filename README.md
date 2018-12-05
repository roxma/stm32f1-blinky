# A Minimal Project Template for STM32F10x Development on Linux

I'm using this template for a small STM32F103C8T6 board. But it should be easy
to port this template for other STM32F10xx devices.

## Hardware Requirements

- [Minimal STM32 development board](https://s.click.taobao.com/t?e=m%3D2%26s%3DY6W3wkF%2FFjwcQipKwQzePOeEDrYVVa64K7Vc7tFgwiHjf2vlNIV67hwrwZVSl7xqr8hK%2FDw%2Bbm3xVF%2BAEuiPkjdUuUl9i6eU1ijycbEkuLdZ%2Bl4uDFWmOO82nBLZmVkpR41ovUvqtYsLN%2Fu2F67KzLsuYk4al%2FmLwMXLwUacQ4aiZ%2BQMlGz6FQ%3D%3D&pvid=12_183.131.116.211_8564_1581243671903)
- [ST-Link debugger](https://s.click.taobao.com/t?e=m%3D2%26s%3DfAk3NCwoC6UcQipKwQzePOeEDrYVVa64K7Vc7tFgwiHjf2vlNIV67hwrwZVSl7xqNq%2BDna%2F8eQfxVF%2BAEuiPkjdUuUl9i6eU1ijycbEkuLdZ%2Bl4uDFWmOO82nBLZmVkpR41ovUvqtYu0ZSjkNvCT9qh%2BwyR80Rd1YSqNIRO6vnI%3D&pvid=12_183.131.116.211_8564_1581243671903)
- [RGB LED module](https://s.click.taobao.com/t?e=m%3D2%26s%3D%2BwzlEFp1a6ocQipKwQzePOeEDrYVVa64K7Vc7tFgwiHjf2vlNIV67gAy%2F%2Bhyc4TIn7yqOUL3SI3xVF%2BAEuiPkjdUuUl9i6eU1ijycbEkuLdZ%2Bl4uDFWmOO82nBLZmVkpR41ovUvqtYu0ZSjkNvCT9jM7m6G%2F4ZGWQgzh%2BHmhp4M%3D&pvid=12_183.131.116.211_8564_1581243671903)

## Software Requirements

### For Debian/Ubuntu Linux

```
sudo apt install -y make

# The C compiler for stm32
# See https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
sudo apt install -y gcc-arm-none-eabi

# The standard C/C++ library for stm32
sudo apt install -y libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib

# stlink - Read https://github.com/texane/stlink
# If apt install failed, use the following commands to install stlink manually
#   git clone https://github.com/texane/stlink stlink.git
#   cd stlink
#   make
#   sudo cp build/Debug/st-* /usr/local/bin
#   # Install udev rules and restart udev
#   sudo cp etc/udev/rules.d/49-stlinkv* /etc/udev/rules.d/
#   sudo udevadm control --reload
sudo apt install -y stlink-tools
```

### For Arch/Manjaro Linux

```
sudo pacman -S make
sudo pacman -S arm-none-eabi-gcc
sudo pacman -S arm-none-eabi-newlib
sudo pacman -S stlink-tools
```

## Build and Run

```
make
make burn
```

## References:

- [How to compile and burn the code to STM32 chip on Linux (Ubuntu)](http://blog.podkalicki.com/how-to-compile-and-burn-the-code-to-stm32-chip-on-linux-ubuntu/)

