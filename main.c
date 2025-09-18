#include <stdint.h>

typedef struct{
    volatile uint32_t CR;
    volatile uint32_t CFGR;
    volatile uint32_t CIR;
    volatile uint32_t APB2RSTR;
    volatile uint32_t APB1RSTR;
    volatile uint32_t AHBENR;
    volatile uint32_t APB2ENR;
    volatile uint32_t APB1ENR;
} RCC_t;

typedef struct{
    volatile uint32_t CRL;
    volatile uint32_t CRH;
    volatile uint32_t IDR;
    volatile uint32_t ODR;
    volatile uint32_t BSRR;
} GPIO_t;

#define RCC   ((RCC_t*)  0x40021000)
#define GPIOA ((GPIO_t*) 0x40010800)

int main(void) {
    RCC->APB2ENR |= (1 << 2);
    GPIOA->CRL &= ~(0xF << (4 * 4));   
    GPIOA->CRL |=  (0x1 << (4 * 4));    
    GPIOA->CRL |=  (0x0 << (4 * 4 + 2));
    while(1){
        GPIOA->BSRR |= (1 << 4);
        for(volatile int i=0; i < 2000000; i++);
        GPIOA -> BSRR |= (1 <<(4+16));
        for(volatile int i=0; i < 2000000; i++);
    }
}
