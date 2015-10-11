#Note 1 = Win PC : eth0 192.168.0.12 & wlan0 192.168.0.11 (Think to use nmap)
#Note 2 = SMB Folders : SMB_PC=Documents & SMB_WD=WDHDD 
sudo smbmount //192.168.0.11/Documents ~/server_security/debug/ -o credentials=/home/reeeemk/server_security/tmp/file_smb

pushd ~/workspace/debug

rsync -arv --force --ignore-errors --delete debug/CV root@IP_SRV_SSH:project/

ssh-add to hold private passphrase
