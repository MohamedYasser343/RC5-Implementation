# MCU type
MCU = atmega328p

# Source file
SRC = main.cpp

# Output base name
TARGET = main

# Compiler flags
CFLAGS = -mmcu=$(MCU) -Os

# Tools
CC = avr-gcc
OBJCOPY = avr-objcopy

# Default target
all: $(TARGET).hex $(TARGET).S

# Build the ELF file
$(TARGET).elf: $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET).elf $(SRC)

# Convert ELF to HEX
$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $(TARGET).elf $(TARGET).hex

# Generate Assembly file
$(TARGET).S: $(SRC)
	$(CC) $(CFLAGS) -S $(SRC) -o $(TARGET).S

# Clean everything
clean:
	rm -f *.o *.elf *.hex *.S
