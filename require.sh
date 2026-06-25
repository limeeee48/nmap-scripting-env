
#!/usr/bin/bash
# بسم الله الرحمن الرحيم .
# السلام عليك ياابا عبدالله الحسين

green='\e[0;32m'
red='\e[0;31m'
end_line='\e[0m'
source /etc/os-release

if [ $(id -u) -ne 0 ] ; then echo 'Use Sudo : sudo bash '$0  ; exit 1  ; fi

check_lua=$(command -v lua5.4)
check_nmap=$(command -v nmap)

[ ${check_nmap} ] &&\
echo -e "${green}[+] Nmap Installed${end_line}" ||\
echo -e "${red}[-] Nmap Uninstalled${end_line}"
[ ${check_lua} ] &&\
echo -e "${green}[+] lua Installed${end_line}"||\
echo -e "${red}[-] lua Uninstalled${end_line}"




[ ${check_lua} ]||\
if [ "$ID" = "kali" ] || [ "$ID" = "parrot" ] || [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] ; then apt-get update && apt-get install -y lua5.4 && echo -e "${green}[+] Lua5.4 Installed ${end_line}"

elif [ "$ID" = "arch" ] ;then
    pacman -Syu lua5.4
fi



[ ${check_nmap} ]||\
if [ "$ID" = "kali" ] || [ "$ID" = "parrot" ] || [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ] ; then apt-get update && apt-get install -y nmap && echo -e "${green}[+] nmap Installed ${end_line}"

elif [ "$ID" = "arch" ] ;then
    pacman -Syu nmap
fi

if [[ $(command -v nmap) && $(command -v lua 5.4) ]] ;then


cat << EOF > /usr/share/nmap/scripts/first_nmap_script.nse

description=[[
LLLLLLLLLLLLLLLLLLLLLLLLLLLL
]]

author= "lime"

categories = {"scan" , "discovery"}

portrule = function(host,port)
    return true
end

function action(host,port)
	return  "Your first script is running successfuly"

end

EOF
echo -e "\n=========Nmap Result========="
nmap_result=$(mktemp)
nmap -p 80 --script="first_nmap_script" goole.com > $nmap_result

sed "s/Your first script is running successfuly/\x1b[30;42m&\x1b[0m/g" $nmap_result
fi


