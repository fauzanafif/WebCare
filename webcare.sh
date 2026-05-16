# ================= MENU =================

while true
do

banner

echo -e "${YELLOW}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│ ${WHITE}[1] Subdomain Scanner      ${WHITE}[2] Port Scanner           ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[3] Directory Bruteforce  ${WHITE}[4] SQL Injection       ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[5] Whois Lookup           ${WHITE}[6] Technology Detect   ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[7] Nikto Scan             ${WHITE}[8] DNS Enumeration     ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[9] Header Scanner         ${WHITE}[10] CMS Detection      ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[11] XSS Scanner           ${WHITE}[12] Admin Finder      ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[13] Sensitive Finder      ${WHITE}[14] URL Collector     ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[15] Parameter Discovery   ${WHITE}[16] Nuclei Scan      ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[17] FFUF Fuzzing          ${WHITE}[18] Full Auto Recon  ${YELLOW}│${NC}"
echo -e "${YELLOW}│ ${WHITE}[19] Exit                                               ${YELLOW}│${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"

echo ""

read -p "Pilih menu : " menu

# ================= MENU =================

case $menu in

1)
    check_tool subfinder

    echo ""
    echo -e "${CYAN}Example : target.com${NC}"
    echo ""

    read -p "Masukkan domain : " target

    echo ""
    echo -e "${GREEN}[+] Starting Subdomain Scan...${NC}"
    echo ""

    subfinder -d $target | tee hasil/subdomain.txt

    echo ""
    echo -e "${GREEN}[✓] Saved : hasil/subdomain.txt${NC}"
;;

2)
    check_tool nmap

    echo ""
    echo -e "${CYAN}Example : target.com${NC}"
    echo ""

    read -p "Masukkan target : " target

    echo ""
    echo -e "${GREEN}[+] Starting Port Scan...${NC}"
    echo ""

    nmap -sV -A $target | tee hasil/nmap.txt

    echo ""
    echo -e "${GREEN}[✓] Saved : hasil/nmap.txt${NC}"
;;

3)
    check_tool gobuster

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    gobuster dir \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/gobuster.txt
;;

4)
    check_tool sqlmap

    echo ""
    echo -e "${CYAN}Example : https://target.com/product.php?id=1${NC}"
    echo ""

    read -p "Masukkan URL vulnerable : " target

    sqlmap -u "$target" \
    --batch \
    --random-agent \
    --dbs
;;

5)
    check_tool whois

    echo ""
    echo -e "${CYAN}Example : google.com${NC}"
    echo ""

    read -p "Masukkan domain : " target

    whois $target | tee hasil/whois.txt
;;

6)
    check_tool whatweb

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    whatweb $target | tee hasil/whatweb.txt
;;

7)
    check_tool nikto

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan target : " target

    nikto -h $target | tee hasil/nikto.txt
;;

8)
    check_tool dnsenum

    echo ""
    echo -e "${CYAN}Example : target.com${NC}"
    echo ""

    read -p "Masukkan domain : " target

    dnsenum $target | tee hasil/dnsenum.txt
;;

9)

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    curl -I $target | tee hasil/header.txt
;;

10)
    check_tool whatweb

    echo ""
    echo -e "${CYAN}Example : https://wordpresssite.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    whatweb $target | tee hasil/cms.txt
;;

11)

    echo ""
    echo -e "${CYAN}Example : https://target.com/search?q${NC}"
    echo ""

    read -p "Masukkan URL parameter : " target

    payload="<script>alert(1)</script>"

    curl "$target=$payload"
;;

12)

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    ffuf \
    -u $target/FUZZ \
    -w wordlist/admin.txt \
    | tee hasil/admin.txt
;;

13)

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    ffuf \
    -u $target/FUZZ \
    -w wordlist/sensitive.txt \
    | tee hasil/sensitive.txt
;;

14)
    check_tool gau

    echo ""
    echo -e "${CYAN}Example : target.com${NC}"
    echo ""

    read -p "Masukkan domain : " target

    gau $target | tee hasil/gau.txt
;;

15)
    check_tool arjun

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan URL : " target

    arjun -u $target | tee hasil/arjun.txt
;;

16)
    check_tool nuclei

    echo ""
    echo -e "${CYAN}Example : https://target.com${NC}"
    echo ""

    read -p "Masukkan target : " target

    nuclei -u $target | tee hasil/nuclei.txt
;;

17)
    check_tool ffuf

    echo ""
    echo -e "${CYAN}Example : https://target.com/FUZZ${NC}"
    echo ""

    read -p "Masukkan URL : " target

    ffuf \
    -u $target \
    -w wordlist/common.txt \
    | tee hasil/ffuf.txt
;;

18)

    echo ""
    echo -e "${CYAN}Example : target.com${NC}"
    echo ""

    read -p "Masukkan target : " target

    echo ""
    echo -e "${GREEN}[+] Starting Full Recon...${NC}"
    echo ""

    subfinder -d $target | tee hasil/subdomain.txt

    nmap -sV $target | tee hasil/nmap.txt

    whatweb $target | tee hasil/whatweb.txt

    nikto -h $target | tee hasil/nikto.txt

    gau $target | tee hasil/gau.txt

    nuclei -u $target | tee hasil/nuclei.txt

    echo ""
    echo -e "${GREEN}[✓] Full Recon Complete${NC}"
;;

19)

    echo ""
    echo -e "${RED}Keluar...${NC}"
    exit
;;

*)

    echo ""
    echo -e "${RED}[!] Menu tidak tersedia${NC}"
;;

esac

# ================= BACK MENU =================

echo ""
echo -e "${YELLOW}[1]${WHITE} Kembali ke Menu Utama"
echo -e "${YELLOW}[2]${WHITE} Exit"
echo ""

read -p "Pilih : " pilih

if [ "$pilih" == "2" ]; then
    echo ""
    echo -e "${RED}Keluar...${NC}"
    exit
fi

done