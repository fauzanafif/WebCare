#!/bin/bash

echo "[+] Update Repository"

sudo apt update

echo "[+] Install Dependencies"

sudo apt install -y \
git \
curl \
wget \
nmap \
sqlmap \
nikto \
gobuster \
whois \
whatweb \
dnsenum \
ffuf \
golang-go \
python3-pip \
seclists

echo "[+] Install GO Tools"

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

go install github.com/lc/gau/v2/cmd/gau@latest

echo "[+] Install Python Tools"

pip3 install arjun

echo "[+] Setup PATH"

echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc

source ~/.bashrc

echo "[+] Download Nuclei Templates"

~/go/bin/nuclei -update-templates

echo "[+] Create Wordlist Folder"

mkdir -p wordlist

echo "[+] Download Wordlists"

wget -O wordlist/common.txt \
https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt

wget -O wordlist/admin.txt \
https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt

wget -O wordlist/sensitive.txt \
https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-medium-files.txt

echo "[+] Permission"

chmod +x webcare.sh

echo ""
echo "[✓] INSTALLATION COMPLETE"
echo ""
echo "Run Tool :"
echo "sudo ./webcare.sh"