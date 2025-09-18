target = firmware.elf
src_C = main.c
src_S = startup.S
src_ld = linker.ld

cc = arm-none-eabi-gcc
ld = arm-none-eabi-ld 
cflags = -mcpu=cortex-m3 -mthumb -O2 -Wall -ffreestanding -nostartfiles -nostdlib
ldflags = -T $(src_ld) --gc-section
obj = $(src_C:.c=.o)
obj += $(src_S:.S=.o)

$(target): $(obj)
	$(ld) $(ldflags) $(obj) -o $@
%.o: %.c
	$(cc) $(cflags) -c $< -o $@
%.o: %.S
	$(cc) $(cflags) -c $< -o $@
clean:
	rm -rf *.o *.elf