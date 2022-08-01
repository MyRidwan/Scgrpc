#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

clear
domain=$(cat /etc/v2ray/domain)
tls=$(cat /etc/xray/vmessgrpc.json | grep port | awk '{print $2}' | sed 's/,//g')
vl=$(cat /etc/xray/vlessgrpc.json | grep port | awk '{print $2}' | sed 's/,//g')
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/vmessgrpc.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
read -p "SNI (bug) : " sni
read -p "Subdomain (EXP : manternet.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/vmessgrpc.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlessgrpc.json
cat > /etc/xray/$user-tls.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "GunService",
      "type": "none",
      "host": "${sni}",
      "tls": "tls"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmesslink1="vmess://$(base64 -w 0 /etc/xray/$user-tls.json)"
vlesslink1="vless://${uuid}@${dom}:${vl}?mode=gun&security=tls&encryption=none&type=grpc&serviceName=GunService&sni=$sni#$user"
systemctl restart vmess-grpc.service
systemctl restart vless-grpc.service
service cron restart
clear
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m          ⇱ Xray Grpc ⇲          \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
sleep 5
echo -e "⛅Remarks           : ${user}"
echo -e "⛅Domain            : ${domain}"
echo -e "⛅SNI               : $sni"
echo -e "⛅Port VMess        : ${tls}"
echo -e "⛅Port VLess        : $vl"
echo -e "⛅ID                : ${uuid}"
echo -e "⛅Alter ID          : 0"
echo -e "⛅Mode              : Gun"
echo -e "⛅Security          : TLS"
echo -e "⛅Type              : grpc"
echo -e "⛅Service Name      : GunService"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "🌀Link VMess GRPC  : "
echo -e "${vmesslink1}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "🌀Link VLess GRPC  : "
echo -e "${vlesslink1}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "⏳Expired On     : $exp"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
