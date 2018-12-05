#include "stm32f10x.h"

void delay(int ms)
{
    while (ms-- > 0) {
        volatile int x = 5971;
        while (x-- > 0)
            __asm("nop");
    }
}

void GPIO_init(GPIO_TypeDef *GPIOx, u16 GPIO_Pin, GPIOMode_TypeDef Mode)
{
    GPIO_InitTypeDef GPIO_InitStruct;
    GPIO_InitStruct.GPIO_Mode = Mode;
    GPIO_InitStruct.GPIO_Pin = GPIO_Pin;
    GPIO_InitStruct.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOx, &GPIO_InitStruct);
}

int main(void)
{
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    GPIO_init(GPIOA, GPIO_Pin_0, GPIO_Mode_Out_PP);
	GPIO_ResetBits(GPIOA,GPIO_Pin_0);
    for (;;) {
        delay(500);
		GPIO_ResetBits(GPIOA,GPIO_Pin_0);
        delay(500);
		GPIO_SetBits(GPIOA,GPIO_Pin_0);
    }
}
