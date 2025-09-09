TARGET = firmware
C_SOURCES = main.c
ASM_SOURCES = startup.S
LD_SCRIPT = linker.ld

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m3 -mthumb -O2 -Wall -ffreestanding -nostdlib
LDFLAGS = -T $(LD_SCRIPT) -nostdlib -Wl,--gc-sections

OBJ = $(C_SOURCES:.c=.o) $(ASM_SOURCES:.S=.o)

all: $(TARGET).elf

$(TARGET).elf: $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o *.elf
