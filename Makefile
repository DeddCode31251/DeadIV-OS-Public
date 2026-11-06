# Tools name
NASM := nasm # NASM reads /boot/boot.asm and creates build/boot.bin. It translates ASM instructions into a form the computer can run
QEMU := qemu-system-i386 # QEMU acts like a pretend computer
DD := dd # DD Creates /build/boot.img, a file that acts like an old floppy disk. It fills it with zeros, then puts your 512-byte bootloader at very beginning. That first spot is where the computer looks when it tries to start from the floppy
MKDIR := mkdir # Creates a folder 

# Paths
BOOT_DIR := boot # Holds original bootloader code
BUILD_DIR := build # Holds the files the makefile creates

# Soruce & generated files
BOOT_SRC :=  $(BOOT_DIR)/boot.asm # written bootloader code
BOOT_BIN :=  $(BOOT_BUILD)/boot.bin # is that code after NASM translate it into computer-readable bytes
BOOT_IMG :=  $(BOOT_BUILD)/boot.img # it acts like a floppy disk 

# 1.44 MB
FLOPPY_SECTORS := 2880 # floppy disk is split into little pieces called sectors. This says the prtetend floppy has 2880 sectors, each one is 512 bytes

.DEFAULT_GOAL := all # When we type make, start with *all* job
