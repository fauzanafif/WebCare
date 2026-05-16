#!/bin/bash

# =====================================================
# WebCare - Website Pentest Toolkit
# Developer : Fauzan Afif Lutfiansah
# Github : https://github.com/fauzanafif
# Version : v0.1
# =====================================================


RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
MAGENTA='\033[1;35m'
NC='\033[0m'


if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[!] Jalankan sebagai root${NC}"
    exit 1
fi


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

pause(){
    echo ""
    line
    echo -e "${YELLOW}[1]${WHITE} Kembali ke Menu Utama"
    echo -e "${YELLOW}[2]${WHITE} Exit"
    line
    echo ""

    read -p "╭─ Pilih : " pilih

    case $pilih in
        1)
            exec "$0"
            ;;
        2)
            echo -e "\n${RED}Keluar dari WebCare...${NC}"
            exit
            ;;
        *)
            echo -e "\n${RED}[!] Pilihan tidak valid${NC}"
            sleep 1
            exec "$0"
            ;;
    esac
}

line(){
    echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"
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
EOF

    echo ""
    echo -e "${GREEN}              🔨 WEBSITE PENTEST TOOLKIT 🔨${NC}"
    echo ""

    line

    printf "${WHITE} %-12s : ${GREEN}%s${NC}\n"  "TOOLS"     "WEBCARE"
    printf "${WHITE} %-12s : ${GREEN}%s${NC}\n"  "DEVELOPER" "Fauzan Afif Lutfiansah"
    printf "${WHITE} %-12s : ${CYAN}%s${NC}\n"  "GITHUB"    "github.com/fauzanafif"
    printf "${WHITE} %-12s : ${YELLOW}%s${NC}\n" "VERSION"   "v0.1"

    line
    echo ""

    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[1]"  "Subdomain Scanner"      "[11]" "XSS Scanner"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[2]"  "Port Scanner"           "[12]" "Admin Finder"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[3]"  "Directory Bruteforce"   "[13]" "Sensitive File Finder"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[4]"  "SQL Injection Scanner"  "[14]" "URL Collector"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[5]"  "Whois Lookup"           "[15]" "Parameter Discovery"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[6]"  "Technology Detection"   "[16]" "Nuclei Scan"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[7]"  "Nikto Scan"             "[17]" "FFUF Fuzzing"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[8]"  "DNS Enumeration"        "[18]" "Full Auto Recon"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[9]"  "Header Scanner"         "[19]" "Exit"
    printf "${YELLOW} %-4s${WHITE} %-28s ${YELLOW}%-4s${WHITE} %-28s\n" "[10]" "CMS Detection"          ""     ""

    echo ""
    line
    echo ""
}


save_folder
banner

read -p "╭─ Pilih menu : " menu
echo ""

# ================= MENU =================

case $menu in

1)
    check_tool subfinder
    read -p "Masukkan domain : " target

    echo -e "${GREEN}[+] Starting Subdomain Scan...${NC}"
    line

    subfinder -d $target | tee hasil/subdomain.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/subdomain.txt${NC}"

    pause
;;

2)
    check_tool nmap
    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Port Scan...${NC}"
    line

    nmap -sV -A $target | tee hasil/nmap.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/nmap.txt${NC}"

    pause
;;

3)
    check_tool gobuster
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Starting Directory Bruteforce...${NC}"
    line

    gobuster dir \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/gobuster.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/gobuster.txt${NC}"

    pause
;;

4)
    check_tool sqlmap
    read -p "Masukkan URL vulnerable : " target

    echo -e "${GREEN}[+] Starting SQL Injection Scan...${NC}"
    line

    sqlmap -u "$target" \
    --batch \
    --random-agent \
    --dbs

    pause
;;

5)
    check_tool whois
    read -p "Masukkan domain : " target

    echo -e "${GREEN}[+] Starting Whois Lookup...${NC}"
    line

    whois $target | tee hasil/whois.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/whois.txt${NC}"

    pause
;;

6)
    check_tool whatweb
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Detecting Technology...${NC}"
    line

    whatweb $target | tee hasil/whatweb.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/whatweb.txt${NC}"

    pause
;;

7)
    check_tool nikto
    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Nikto Scan...${NC}"
    line

    nikto -h $target | tee hasil/nikto.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/nikto.txt${NC}"

    pause
;;

8)
    check_tool dnsenum
    read -p "Masukkan domain : " target

    echo -e "${GREEN}[+] Starting DNS Enumeration...${NC}"
    line

    dnsenum $target | tee hasil/dnsenum.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/dnsenum.txt${NC}"

    pause
;;

9)
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Scanning Headers...${NC}"
    line

    curl -I $target | tee hasil/header.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/header.txt${NC}"

    pause
;;

10)
    check_tool whatweb
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Detecting CMS...${NC}"
    line

    whatweb $target | tee hasil/cms.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/cms.txt${NC}"

    pause
;;

11)
    read -p "Masukkan URL parameter : " target

    payload="<script>alert(1)</script>"

    echo -e "${GREEN}[+] Testing XSS Payload...${NC}"
    line

    curl "$target=$payload"

    pause
;;

12)
    check_tool ffuf
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Searching Admin Panel...${NC}"
    line

    ffuf \
    -u $target/FUZZ \
    -w wordlist/admin.txt \
    | tee hasil/admin.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/admin.txt${NC}"

    pause
;;

13)
    check_tool ffuf
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Searching Sensitive Files...${NC}"
    line

    ffuf \
    -u $target/FUZZ \
    -w wordlist/sensitive.txt \
    | tee hasil/sensitive.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/sensitive.txt${NC}"

    pause
;;

14)
    check_tool gau
    read -p "Masukkan domain : " target

    echo -e "${GREEN}[+] Collecting URLs...${NC}"
    line

    gau $target | tee hasil/gau.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/gau.txt${NC}"

    pause
;;

15)
    check_tool arjun
    read -p "Masukkan URL : " target

    echo -e "${GREEN}[+] Discovering Parameters...${NC}"
    line

    arjun -u $target | tee hasil/arjun.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/arjun.txt${NC}"

    pause
;;

16)
    check_tool nuclei
    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Nuclei Scan...${NC}"
    line

    nuclei -u $target | tee hasil/nuclei.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/nuclei.txt${NC}"

    pause
;;

17)
    check_tool ffuf
    read -p "Masukkan URL (gunakan FUZZ) : " target

    echo -e "${GREEN}[+] Starting FFUF Fuzzing...${NC}"
    line

    ffuf \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/ffuf.txt

    line
    echo -e "${GREEN}[✓] Saved : hasil/ffuf.txt${NC}"

    pause
;;

18)
    read -p "Masukkan target : " target

    echo -e "${GREEN}[+] Starting Full Auto Recon...${NC}"
    line

    subfinder -d $target | tee hasil/subdomain.txt
    nmap -sV $target | tee hasil/nmap.txt
    whatweb $target | tee hasil/whatweb.txt
    nikto -h $target | tee hasil/nikto.txt
    gau $target | tee hasil/gau.txt
    nuclei -u $target | tee hasil/nuclei.txt

    line
    echo -e "${GREEN}[✓] Full Recon Complete${NC}"

    pause
;;

19)
    echo -e "${RED}Keluar dari WebCare...${NC}"
    exit
;;

*)
    echo -e "${RED}[!] Menu tidak tersedia${NC}"
;;

esac