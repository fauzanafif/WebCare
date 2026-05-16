#!/bin/bash

# =====================================================
# WebCare - Website Pentest Toolkit
# Developer : Fauzan AfifLutiansah
# Github    : fauzan123456.github.com
# =====================================================

# ================= COLOR =================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# ================= CHECK ROOT =================

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Jalankan sebagai root${NC}"
   exit 1
fi

# ================= FUNCTION =================

pause(){
    echo ""
    read -p "Tekan ENTER untuk kembali..."
}

save_folder(){
    mkdir -p hasil
}

check_tool(){
    if ! command -v $1 &> /dev/null
    then
        echo -e "${RED}[!] Tool $1 belum terinstall${NC}"
        pause
        exit
    fi
}

banner(){

clear

echo -e "${CYAN}"

cat << "EOF"

██╗    ██╗███████╗██████╗  ██████╗ █████╗ ██████╗ ███████╗
██║    ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
██║ █╗ ██║█████╗  ██████╔╝██║     ███████║██████╔╝█████╗
██║███╗██║██╔══╝  ██╔══██╗██║     ██╔══██║██╔══██╗██╔══╝
╚███╔███╔╝███████╗██████╔╝╚██████╗██║  ██║██║  ██║███████╗
 ╚══╝╚══╝ ╚══════╝╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

             🔨 WEBSITE PENTEST TOOLKIT 🔨

EOF

echo -e "${GREEN}Developer : Fauzan AfifLutiansah${NC}"
echo -e "${GREEN}Github    : fauzan123456.github.com${NC}"

echo ""
echo -e "${YELLOW}[1]${WHITE} Subdomain Scanner"
echo -e "${CYAN}    Example : tesla.com${NC}"

echo -e "${YELLOW}[2]${WHITE} Port Scanner"
echo -e "${CYAN}    Example : tesla.com${NC}"

echo -e "${YELLOW}[3]${WHITE} Directory Bruteforce"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[4]${WHITE} SQL Injection Scanner"
echo -e "${CYAN}    Example : https://target.com/product.php?id=1${NC}"

echo -e "${YELLOW}[5]${WHITE} Whois Lookup"
echo -e "${CYAN}    Example : google.com${NC}"

echo -e "${YELLOW}[6]${WHITE} Technology Detection"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[7]${WHITE} Nikto Scan"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[8]${WHITE} DNS Enumeration"
echo -e "${CYAN}    Example : target.com${NC}"

echo -e "${YELLOW}[9]${WHITE} Header Scanner"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[10]${WHITE} CMS Detection"
echo -e "${CYAN}    Example : https://wordpresssite.com${NC}"

echo -e "${YELLOW}[11]${WHITE} XSS Scanner"
echo -e "${CYAN}    Example : https://target.com/search?q${NC}"

echo -e "${YELLOW}[12]${WHITE} Admin Finder"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[13]${WHITE} Sensitive File Finder"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[14]${WHITE} URL Collector"
echo -e "${CYAN}    Example : tesla.com${NC}"

echo -e "${YELLOW}[15]${WHITE} Parameter Discovery"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[16]${WHITE} Nuclei Scan"
echo -e "${CYAN}    Example : https://target.com${NC}"

echo -e "${YELLOW}[17]${WHITE} FFUF Fuzzing"
echo -e "${CYAN}    Example : https://target.com/FUZZ${NC}"

echo -e "${YELLOW}[18]${WHITE} Full Auto Recon"
echo -e "${CYAN}    Example : tesla.com${NC}"

echo -e "${YELLOW}[19]${WHITE} Exit"
echo ""

}

# ================= START =================

save_folder
banner

read -p "Pilih menu : " menu

# ================= MENU =================

case $menu in

1)
    check_tool subfinder
    read -p "Masukkan domain : " target

    echo -e "${GREEN}[+] Starting Subdomain Scan...${NC}"

    subfinder -d $target | tee hasil/subdomain.txt

    echo -e "${GREEN}[✓] Saved : hasil/subdomain.txt${NC}"

    pause
;;

2)
    check_tool nmap
    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Port Scan...${NC}"

    nmap -sV -A $target | tee hasil/nmap.txt

    echo -e "${GREEN}[✓] Saved : hasil/nmap.txt${NC}"

    pause
;;

3)
    check_tool gobuster
    read -p "Masukkan URL : " target

    gobuster dir \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/gobuster.txt

    pause
;;

4)
    check_tool sqlmap
    read -p "Masukkan URL vulnerable : " target

    sqlmap -u "$target" \
    --batch \
    --random-agent \
    --dbs

    pause
;;

5)
    check_tool whois
    read -p "Masukkan domain : " target

    whois $target | tee hasil/whois.txt

    pause
;;

6)
    check_tool whatweb
    read -p "Masukkan URL : " target

    whatweb $target | tee hasil/whatweb.txt

    pause
;;

7)
    check_tool nikto
    read -p "Masukkan target : " target

    nikto -h $target | tee hasil/nikto.txt

    pause
;;

8)
    check_tool dnsenum
    read -p "Masukkan domain : " target

    dnsenum $target | tee hasil/dnsenum.txt

    pause
;;

9)
    read -p "Masukkan URL : " target

    curl -I $target | tee hasil/header.txt

    pause
;;

10)
    check_tool whatweb
    read -p "Masukkan URL : " target

    whatweb $target | tee hasil/cms.txt

    pause
;;

11)
    read -p "Masukkan URL parameter : " target

    payload="<script>alert(1)</script>"

    curl "$target=$payload"

    pause
;;

12)
    read -p "Masukkan URL : " target

    ffuf \
    -u $target/FUZZ \
    -w wordlist/admin.txt \
    | tee hasil/admin.txt

    pause
;;

13)
    read -p "Masukkan URL : " target

    ffuf \
    -u $target/FUZZ \
    -w wordlist/sensitive.txt \
    | tee hasil/sensitive.txt

    pause
;;

14)
    check_tool gau
    read -p "Masukkan domain : " target

    gau $target | tee hasil/gau.txt

    pause
;;

15)
    check_tool arjun
    read -p "Masukkan URL : " target

    arjun -u $target | tee hasil/arjun.txt

    pause
;;

16)
    check_tool nuclei
    read -p "Masukkan target : " target

    nuclei -u $target | tee hasil/nuclei.txt

    pause
;;

17)
    check_tool ffuf

    read -p "Masukkan URL (gunakan FUZZ) : " target

    ffuf \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/ffuf.txt

    pause
;;

18)

    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Full Recon...${NC}"

    subfinder -d $target | tee hasil/subdomain.txt

    nmap -sV $target | tee hasil/nmap.txt

    whatweb $target | tee hasil/whatweb.txt

    nikto -h $target | tee hasil/nikto.txt

    gau $target | tee hasil/gau.txt

    nuclei -u $target | tee hasil/nuclei.txt

    echo -e "${GREEN}[✓] Full Recon Complete${NC}"

    pause
;;

19)

    echo -e "${RED}Keluar...${NC}"
    exit
;;

*)

    echo -e "${RED}Menu tidak tersedia${NC}"

;;

esac