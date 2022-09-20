Asm := nasm
BuildDir := Build
BootloaderDir := Bootloader
KernelDir := Kernel
ProgramsDir := Programs
BootloaderDirStable := Stable/Bootloader
KernelDirStable := Stable/Kernel
BootloaderFlags := -IBootloader/
KernelFlags := -IKernel/
all: CheckUser CreateBuildDir main

main:
	@echo -e "\n\e[0;32m==> Compiling bootloader...\e[0m"
	$(Asm) -f bin $(BootloaderFlags) $(BootloaderDir)/Bootloader.asm -o $(BuildDir)/Bootloader.bin
	@echo -e "\n\e[0;32m==> Compiling kernel and programs...\e[0m"
	$(Asm) -f bin $(KernelFlags) $(KernelDir)/Kernel.asm -o $(BuildDir)/Kernel.bin
	# $(Asm) -f bin $(ProgramsDir)/Edit.asm -o $(BuildDir)/Edit.bin
	
	@echo -e "\n\e[0;32m==> Creating image...\e[0m"
	rm -rf $(BuildDir)/NabOS.flp
	dd if=/dev/zero of=$(BuildDir)/NabOS.flp bs=512 count=2880


	@echo -e "\n\e[0;32m==> Mount and format image...\e[0m"
	losetup /dev/loop8 $(BuildDir)/NabOS.flp
	mkdosfs -F 12 /dev/loop8
	mount /dev/loop8 /mnt -t msdos -o "fat=12"


	@echo -e "\n\e[0;32m==> Copying kernel and files to image...\e[0m"
	cp $(BuildDir)/Kernel.bin /mnt
	cp Test.txt  /mnt


	@echo -e "\n\e[0;32m==> Unmount image...\e[0m"
	umount /mnt
	losetup -d /dev/loop8

	
	@echo -e "\n\e[0;32m==> Copying bootloader to image...\e[0m"
	dd status=noxfer conv=notrunc count=1 if=$(BuildDir)/Bootloader.bin of=$(BuildDir)/NabOS.flp

stable: CheckUser CreateBuildDir
	@echo -e "\n\e[0;32m==> Compiling bootloader...\e[0m"
	$(Asm) -f bin $(BootloaderFlags) $(BootloaderDirStable)/Bootloader.asm -o $(BuildDir)/Bootloader.bin

	@echo -e "\n\e[0;32m==> Compiling kernel...\e[0m"
	$(Asm) -f bin $(KernelFlags) $(KernelDirStable)/Kernel.asm -o $(BuildDir)/Kernel.bin

	@echo -e "\n\n\e[0;32m==> Finishing up...\e[0m"
	cat $(BuildDir)/Bootloader.bin $(BuildDir)/Kernel.bin > $(BuildDir)/NabOS.img
	qemu-system-i386 -fda "Build/NabOS.img" -M smm=off -no-shutdown -no-reboot -d int -full-screen

CreateBuildDir:
	@mkdir -p $(BuildDir)/

	test -f $(BuildDir)/NabOS.flp || mkdosfs -C $(BuildDir)/NabOS.flp 1440
	
CheckUser:
	@if ! [ "$(shell id -u)" = 0 ]; then \
		echo -e "\e[0;31mKamu harus mode root untuk mount image.\n\e[0mGuanakan perintah \"sudo su\" \n"; \
		exit 1; \
	fi


clean:
	rm -rf $(BuildDir)/*
