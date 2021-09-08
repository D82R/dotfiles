#!/usr/bin/env bash

declare -A gotools
gotools["fff"]="go get -u github.com/tomnomnom/fff"
gotools["hakrawler"]="go get github.com/hakluke/hakrawler"
gotools["gowitness"]="go get -u github.com/sensepost/gowitness"
gotools["naabu"]="GO111MODULE=on go get -v github.com/projectdiscovery/naabu/cmd/naabu"
gotools["hakcheckurl"]="go get -u github.com/hakluke/hakcheckurl"
gotools["shuffledns"]="GO111MODULE=on go get -v github.com/projectdiscovery/shuffledns/cmd/shuffledns"
gotools["gron"]="go get -u github.com/tomnomnom/gron"
gotools["html-tool"]="go get -u github.com/tomnomnom/hacks/html-tool"
gotools["Chaos"]="GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos"
gotools["gf"]="go get -v github.com/tomnomnom/gf"
gotools["qsreplace"]="go get -v github.com/tomnomnom/qsreplace"
gotools["Amass"]="GO111MODULE=on go get -v github.com/OWASP/Amass/v3/..."
gotools["ffuf"]="go get -u github.com/ffuf/ffuf"
gotools["assetfinder"]="go get -v github.com/tomnomnom/assetfinder"
gotools["github-subdomains"]="go get -u github.com/gwen001/github-subdomains"
gotools["waybackurls"]="go get -v github.com/tomnomnom/hacks/waybackurls"
gotools["nuclei"]="GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei"
gotools["anew"]="go get -v github.com/tomnomnom/anew"
gotools["notify"]="GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify"
gotools["dirdar"]="go get -u github.com/m4dm0e/dirdar"
gotools["unfurl"]="go get -v github.com/tomnomnom/unfurl"
gotools["httpx"]="GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx"
gotools["github-endpoints"]="go get -u github.com/gwen001/github-endpoints"
gotools["dnsx"]="GO111MODULE=on go get -v github.com/projectdiscovery/dnsx/cmd/dnsx"
gotools["subfinder"]="GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder"
gotools["gauplus"]="GO111MODULE=on go get -u -v github.com/bp0lr/gauplus"
gotools["subjs"]="GO111MODULE=on go get -u -v github.com/lc/subjs"
gotools["crobat"]="go get -v github.com/cgboal/sonarsearch/crobat"
gotools["puredns"]="GO111MODULE=on go get github.com/d3mondev/puredns/v2"
gotools["resolveDomains"]="go get -v github.com/Josue87/resolveDomains"
gotools["interactsh-client"]="GO111MODULE=on go get -v github.com/projectdiscovery/interactsh/cmd/interactsh-client"
gotools["kxss"]="go get -u github.com/tomnomnom/hacks/kxss"
gotools["GetJs"]="go get github.com/003random/getJS"

declare -A repos
repos["403bypaser"]="yunemse48/403bypasser"
repos["dnsvalidator"]="vortexau/dnsvalidator"
repos["arjun"]="s0md3v/Arjun"
repos["dirsearch"]="maurosoria/dirsearch"
repos["dnsgen"]="ProjectAnte/dnsgen"
repos["gf"]="tomnomnom/gf"
repos["Gf-Patterns"]="1ndianl33t/Gf-Patterns"
repos["h2csmuggler"]="irsdl/h2csmuggler"
repos["iis-shortname-scanner"]="irsdl/IIS-ShortName-Scanner"
repos["kite runner"]="assetnote/kiterunner"
repos["LinkFinder"]="dark-warlord14/LinkFinder"
repos["Interlace"]="codingo/Interlace"
repos["massdns"]="blechschmidt/massdns"
repos["GitDorker"]="obheda12/GitDorker"
repos["cloud_enum"]="initstring/cloud_enum"
repos["JSScanner"]="0x240x23elu/JSScanner"
repos["sqlmap"]="sqlmapproject/sqlmap"
repos["whatweb"]="urbanadventurer/WhatWeb"

if [[ $(id -u | grep -o '^0$') == "0" ]]; then
    SUDO=" "
else
    if sudo -n false 2>/dev/null; then
        printf "${bred} Is strongly recommended to add your user to sudoers${reset}\n"
    fi
    SUDO="sudo"
fi

dir="$HOME/Tools"

mkdir -p ~/.gf
mkdir -p ~/Tools/
mkdir -p ~/.config/notify/
mkdir -p ~/.config/amass/
mkdir -p ~/.config/nuclei/
mkdir -p ~/Lists/

printf "${bblue} Running: Installing Golang tools (${#gotools[@]})${reset}\n\n"
go env -w GO111MODULE=auto
go_step=0
for gotool in "${!gotools[@]}"; do
    go_step=$((go_step + 1))
    eval ${gotools[$gotool]} $DEBUG_STD
    exit_status=$?
    if [ $exit_status -eq 0 ]
    then
        printf "${yellow} $gotool installed (${go_step}/${#gotools[@]})${reset}\n"
    else
        printf "${red} Unable to install $gotool, try manually (${go_step}/${#gotools[@]})${reset}\n"
        double_check=true
    fi
done

eval wget -nc -O ~/Lists/XSS-OFJAAAH.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/XSS/XSS-OFJAAAH.txt
eval wget -nc -O ~/Lists/params.txt https://raw.githubusercontent.com/s0md3v/Arjun/master/arjun/db/params.txt
eval wget -nc -O https://gist.githubusercontent.com/mswell/1070fae0021b08d5e5650743ea402b4b/raw/589e669dec183009f01eca2c2ef1401b5f77af2b/regexJS

eval wget -N -c https://bootstrap.pypa.io/get-pip.py $DEBUG_STD && eval python3 get-pip.py $DEBUG_STD
eval rm -f get-pip.py $DEBUG_STD
eval ln -s /usr/local/bin/pip3 /usr/bin/pip3 $DEBUG_STD
eval pip3 install -I -r requirements.txt $DEBUG_STD

eval wget -nc -O ~/.gf/potential.json https://raw.githubusercontent.com/devanshbatham/ParamSpider/master/gf_profiles/potential.json $DEBUG_STD


printf "${bblue}\n Running: Installing repositories (${#repos[@]})${reset}\n\n"

cd "$dir" || { echo "Failed to cd to $dir in ${FUNCNAME[0]} @ line ${LINENO}"; exit 1; }


# Standard repos installation
repos_step=0
for repo in "${!repos[@]}"; do
    repos_step=$((repos_step + 1))
    eval git clone https://github.com/${repos[$repo]} $dir/$repo $DEBUG_STD
    eval cd $dir/$repo $DEBUG_STD
    eval git pull $DEBUG_STD
    exit_status=$?
    if [ $exit_status -eq 0 ]
    then
        printf "${yellow} $repo installed (${repos_step}/${#repos[@]})${reset}\n"
    else
        printf "${red} Unable to install $repo, try manually (${repos_step}/${#repos[@]})${reset}\n"
        double_check=true
    fi
    if [ -s "setup.py" ]; then
        eval $SUDO python3 setup.py install $DEBUG_STD
    fi
    if [ "massdns" = "$repo" ]; then
            eval make $DEBUG_STD && strip -s bin/massdns && eval $SUDO cp bin/massdns /usr/bin/ $DEBUG_ERROR
    elif [ "gf" = "$repo" ]; then
            eval cp -r examples ~/.gf $DEBUG_ERROR
    elif [ "Gf-Patterns" = "$repo" ]; then
            eval mv *.json ~/.gf $DEBUG_ERROR
    fi
    cd "$dir" || { echo "Failed to cd to $dir in ${FUNCNAME[0]} @ line ${LINENO}"; exit 1; }
done
