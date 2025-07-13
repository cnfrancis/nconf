# nconf

## Fresh install

Assuming boot from USB and computer is connected to internet via ethernet
```
sudo -i
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -8GB
parted /dev/sda -- mkpart swap linux-swap -8GB 100
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

mount /dev/disk/by-label/nixos /mnt

mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

nixos-generate-config --root /mnt

nixos-install

reboot
```

## Ship config
Set of config for setting a machine for various usecases

```
./deploy.sh <HOST>
```

## PG
```
sudo -u postgres psql -c "ALTER USER XXXX PASSWORD 'XXXX';"
psql --host=XXX --port=5432 --username=XXX --password --dbname=XXX
```