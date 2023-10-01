# vnc_screenshot
A script that takes a screenshot from a list of IP addresses.

You will need: tigervnc, xdotool.

# Why

You can obtain a lot of IP addresses with unconfigured VNC using **Shodan**. This allows attackers to monitor users, install malwares, compromise VPS (by editing the GRUB record), and disrupt HMI operations.

# How to use
First, download a fresh list of IP addresses using: 
>shodan search "RFB 003.008"  "Authentication disabled"  --limit  1000  --fields ip_str,port > .\Desktop\ips.txt
 
 Then, edit the file in the format ip:port.
 Place ips.txt file in the **vnc_screenshot** directory and run the script using the following command
 >bash main.sh
 
In the **out** directory, you will find screenshots named after the remote VNC server's IP address and port.

```
All the information provided in this repo is for educational purposes only.
It is strongly recommended to review the laws of your country before using the information provided.
```
![alt ips](https://github.com/Nougat-User/vnc_screenshot/blob/main/ips.jpg)
![alt out](https://github.com/Nougat-User/vnc_screenshot/blob/main/out.jpg)
![alt working](https://github.com/Nougat-User/vnc_screenshot/blob/main/working.jpg)
