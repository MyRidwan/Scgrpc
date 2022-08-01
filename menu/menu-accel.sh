#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Gettingecho -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
clear
echo "${CYAN}╔═════════════════════════════════════════════════════════════════╗\033[0m${NC}"
echo "${CYAN}║                   ┃ SSTP / PPTP / L2TP MENU ┃                   ║\033[0m${NC}" 
echo "${CYAN}╚═════════════════════════════════════════════════════════════════╝\033[0m${NC}" 
echo "║ 1.Create Account L2TP                                           ║"
echo "║ 2.Create Account PPTP                                           ║"
echo "║ 3.Create Account SSTP                                           ║"
echo "║ 4.Delete Account L2TP                                           ║"
echo "║ 5.Delete Account PPTP                                           ║"
echo "║ 6.Delete Account SSTP                                           ║"
echo "║ 7.Renews Account L2TP                                           ║"
echo "║ 8.Renews Account SSTP                                           ║"
echo "║ 9.Renews Account PPTP                                           ║"
echo "║ 10.Exit Menu                                                    ║"
echo "${CYAN}╚═════════════════════════════════════════════════════════════════╝\033[0m${NC}" 
read -p "     Select From Options [1-10 or x] :  " menu
case $menu in 
1)
addl2tp
;;
2)
addpptp
;;
3)
addsstp
;;
4)
dell2tp
;;
5)
delpptp
;;
6)
delsstp
;;
7)
renewl2tp
;;
8)
renewsstp
;;
9)
renewpptp
;;
10)
exit
;;
*)
echo "Input The Correct Number !"
;;
esac
