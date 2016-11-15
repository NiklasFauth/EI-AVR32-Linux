INCLUDE = -I$(HOME)/avr32-tools/avr32/include/avr32
MPART = -mpart=uc3b0512
TARGET = at32uc3b0512

default: test.hex

%.elf: %.c trampoline.o
	avr32-gcc $(INCLUDE) -Wl,-e,_trampoline,-Map,$*.map $(MPART) trampoline.o $*.c -o $*.elf

%.o: %.s
	avr32-gcc -x assembler-with-cpp $(INCLUDE) $(MPART) -c $*.s

%.hex: %.elf
	avr32-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature $*.elf $*.hex

clean:
	rm *.hex *.elf *.o *.map 2>/dev/null || true

test:
	dfu-programmer $(TARGET) get bootloader-version

.PHONY: %.up

%.up: %.hex
	dfu-programmer $(TARGET) erase
	dfu-programmer $(TARGET) flash --suppress-bootloader-mem $*.hex
	dfu-programmer $(TARGET) reset  #`launch` for newer dfu-programmer

# vim: noexpandtab

