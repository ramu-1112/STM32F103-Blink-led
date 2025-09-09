.syntax unified
.cpu cortex-m3
.thumb

.global Default_Handler
.global vector_table
.word _sidata
.word _sdata 
.word _edata
.word _sbss
.word _ebss

.type Reset_Handler, %function
Reset_Handler:
ldr r0, =_sdata
ldr r1, =_edata
ldr r2, =_sidata
movs r3, #0
b LoopCopyDataInit

CopyDataInit:
ldr r4, [r2, r3]
str r4, [r0, r3]
adds r3, r3, #4

LoopCopyDataInit:
adds r4, r0, r3
cmp r4, r1
bcc CopyDataInit

ldr r2, =_sbss
ldr r4, =_ebss
movs r3, #0
b LoopFillZerobss

FillZerobss:
str r3, [r2]
adds r2, r2, #4

LoopFillZerobss:
cmp r2, r4
bcc LoopFillZerobss

bl main
b .
.size Reset_Handler, .-Reset_Handler

.type Default_Handler, %function
Default_Handler:
Infinite_Loop:
b Infinite_Loop
.size Default_Handler, .-Default_Handler

.section .isr_vector,"a", %progbits 
.align 2
.type vector_table, %object
.size vector_table, .-vector_table

vector_table:
.word _estack 
.word Reset_Handler
.rept 14
.word Default_Handler
.endr 