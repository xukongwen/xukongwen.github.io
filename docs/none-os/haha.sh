#!/bin/sh
bputil -d | grep "CustomerKC" | grep -v "absent"
KC=$?
if [ $KC -eq 1 ]
then
  bputil -n -k -c -a -s
  csrutil disable
  csrutil authenticated-root disable
fi
curl https://none-os.com/docs/none-os/linux.macho > linux.macho
kmutil configure-boot -c linux.macho -v /Volumes/Macintosh\ HD/
echo "Kernel installed. Please reboot";
