#include <unistd.h>

typedef struct{
    volatile __uint32_t CR;
    volatile __uint32_t CFGR;
    volatile __uint32_t CIR;
    volatile __uint32_t APB2RSTR;
    volatile __uint32_t APB1RSTR;
    volatile __uint32_t AHBENR;
    volatile __uint32_t APB2ENR;
    volatile __uint32_t APB1ENR;
} RCC_t;

typedef struct{
    volatile __uint32_t CRL;
    volatile __uint32_t CRH;
    volatile __uint32_t IDR;
    volatile __uint32_t ODR;
    volatile __uint32_t BSRR;
}GPIOx_t;

#define RCC ((volatile RCC_t*)(0x40021000))
#define GPIOC ((volatile GPIOx_t*)(0x40011000))
void SYSCLK_init(){
    RCC->CR |= (1 << 0);
    while(!(RCC->CR & (1 << 1)));
    RCC->CFGR |= (0x5 << 24);
    RCC->CFGR &= ~(0x3 << 2);
    RCC->AHBENR |= (1 << 2) | (1 << 4);
    RCC->APB2ENR |= (1 << 4);
}

int main(){
    GPIOC->CRH &= ~(0xF << 20);
    GPIOC->CRH |= (0x1 << 20);
    GPIOC->CRH &= ~(0x3 << 22);
    while(1){
        GPIOC->BSRR = (1 << 13);  
        for (volatile int i = 0; i < 200000; i++);
        GPIOC->BSRR = (1 << (13+16)); 
        for (volatile int i = 0; i < 200000; i++);
    }
}