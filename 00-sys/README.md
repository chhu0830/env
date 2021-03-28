## 00-system
This installation guide is for ArchLinux.

1. Partition the disks

   `# cgdisk /dev/sda`
   1. Create EFI

      Size: 256M  
      GUID: ef00  
      Name: EFI

   2. Create filesystem

      Size: 250G  
      GUID: 8300  
      Name: ArchLinux

   3. Create swap

      GUID: 8200

2. Enable swap

   `# mkswap /dev/sda3`  
   `# swapon /dev/sda3`

3. `# ./install.sh`
