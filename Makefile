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

all: $(BOOT_IMG) # Finish the *all* job, make sure the floppy image exists

prepare: 
  $(MKDIR) -p $(BUILD_DIR) # it creates build folder, -p means it's okay if the folder already exists

$(BOOT_BIN) : $(BOOT_SRC) | prepare # this says how it make build/boot.bin:
# - it needs boot/boot.asm
# - it also needs the prepare job to happen first, so the build folder exist
# - THE '|' means prepare is just somthing must happen first, it isn't a part of the bootloader itself 
  
  $(NASM) -f bin $(BOOT_SRC) -o $(BOOT_BIN) # This runs NASM, Read the assembly source and save the translated bytes as build/boot.bin
  # - '-f bin' asks for a plain binary file
  # - 'o' tells NASM the name of the output file

  test "$$(wc -c < $(BOOT_BIN))" -eq 512 # This checks that the bootloader is exactly 512 bytes
  # - 'wc -c' counts bytes
  # - '-eq 512' means is equal to 512
  # - The doubled '$$' is make's way of letting the shell receive $ for its own command substituion

  test "$$(od -An -tx1 -j510 -N2 $(BOOT_BIN) | tr -d ' \n')" = "55aa" # If the file isn't exactly 512 bytes, this check fails and Make stops
  # - 'od' looks at bytes in the file
  # - '-j510' starts at byte number 510
  # - 'N2' reads two bytes
  # - 'tr -d ' \n' remove spaces and newlines from the printed result
  # - Finaly it checks that bytes are equal to '55aa', they're the special marker BIOS expects at the end of a boot sector


