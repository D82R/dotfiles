    #ZSH PATH
export ZSH="/home/ds82/.oh-my-zsh"

    #ACCESS TOKENS
export GITHUB_TOKEN=""
export GITROB_ACCESS_TOKEN=""
export CHAOS_KEY=""
export SLACK_TOKEN=""

    #ZSH THEME
ZSH_THEME="robbyrussell"
export TERM=xterm-256color

    #ZSH PLUGS
plugins=(git virtualenv virtualenvwrapper)
source $ZSH/oh-my-zsh.sh

    #UNALIAS
source ~/go/src/github.com/tomnomnom/gf/gf-completion.zsh
unalias gau
unalias gf

    #GO PATH
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

    #JAVA PATH
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export PATH=$JAVA_HOME/bin:$PATH

    #ALIASES
alias ..="cd .." # Back one directory
alias change_python_version="sudo update-alternatives --config python"
alias cls="clear"
alias hm="cd ~"
alias open_ports="sudo lsof -i -P -n | grep LISTEN"
alias projects="cd ~/go/src/github.com/dshiver82"
alias py="python3"
alias tkill="tmux kill-server" #kill all tmux sessions
alias tls="cd ~/tools"
alias zedit="vim ~/.zshrc"  # Edit .zshrc
alias zsource="source ~/.zshrc"  #Source .zshrc

    #CUSTOM FUNCTIONS

    #HTTPX

xhttpx-csp(){   # gather subdomains through csp
assetfinder $1 -subs-only |httpx -csp-probe -status-code -title
}

    #NUCLEI

xnuclei-req-method(){   # check request methods accepted on list of domains
    nuclei -l $1 -t /home/ds82/nuclei-templates/miscellaneous/detect-options-method.yaml -tags misc
}

    #RECON COMMANDS
    
xarjun(){   # run arjun on single target
	arjun -u $1 --headers "X-Hackerone: ds82" 
}

xcidr(){    # get cidr range using ASN
    whois -h whois.radb.net -- '-i origin' $1 | grep -Eo "([0-9.]+){4}/[0-9]+" | sort -u
}

xdirsearch(){   # run dirsearch on single target
	python3 ~/tools/dirsearch/dirsearch.py -u $1 -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,sql,log,xml,js,json,cache,wdsl\ 
    -t 40 -w $2 -s $3 --simple-report dirsearch.data
}

xdnsvalidator(){    # run Dnsvalidator and obtain list of valid DNS resolvers
	dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 20 -o resolvers.txt
}

gaujson() {  # get waybackurls for .json
    gau $1 |grep ".json"|httpx -status-code
}

xgitrob(){  # check for sensitive data leaks on a github repository
	gitrob -bind-address "vps ip goes here" -port 10001 $1
}

xgowitness_gather(){    # pass in list of domains and gather screenshots
	rm ~/recon/gowitness.sqlite3 && gowitness file -f $1 --delay 2 -D ~/recon/gowitness.sqlite3
}

xgowitness_serve(){     # start gowitness server      
	gowitness report serve -a "vps ip:port go here" -D ~/recon/gowitness.sqlite3
}

xiisscan(){     # scan iis server for shortname files
	cd ~/tools/iis-shortname-scanner && java -jar iis_shortname_scanner.jar 2 20 $1
}

xinteractsh(){  # check for DNS pingback from host
	curl "$1" --request-target Http://$2 -v -k --path-as-is --max-time 2
}

xpuredns-resolve(){     # pass in list of subdomains and see if they resolve
    cat $1 |puredns resolve -r /home/ds82/recon/resolvers.txt --write resolved.txt
}

xsmuggler(){    # check for CL/TE dsync on target domain
	python3 ~/tools/smuggler/smuggler.py -u $1
}

xtrufflehog(){      # scan github repo for data leaks
    truffleHog --regex --entropy=False $1
}

xwaybackurls(){     # pass in list of subdomains and pull old urls from waybackmachine 
	cat $1 |waybackurls |unew -combine |sort -u |grep -v -i '.ttf\|.eot\|.otf\|.jpeg\|.woff\|.woff2\|.css\|.jpg\|.svg\|.js\|.mpeg\|.mp4\|.png\|.ico\|.gif' |tee wayback.data
}

xwhatweb(){     # enumerate server details on given domain
	whatweb -H -v --log-verbose whatweb.data $1
}

    #SQLMAP

xsqlmap(){  # sqlmap 
	python3 ~/tools/sqlmap/sqlmap.py --url=$1 --user-agent=SQLMAP --delay=1 --timeout=15 --retries=2 --keep-alive --threads=5 --eta --dbms=MySQL --os=Linux --level=5 --risk=3 --banner --is-dba --dbs --tables --technique=BEUST -s /tmp/scan_report.txt --flush-session -t /tmp/scan_trace.txt --fresh-queries
}

    #UTILITY

xcheckbind(){   # check nameserver bind version
	dig -t txt -c chaos VERSION.BIND @$1
}

xcheckssl(){    # check SSL for alternate names
	openssl s_client -connect $1:443 </dev/null 2>/dev/null | openssl x509 -noout -text | grep DNS:
}

xcustom(){  # print list of custom functions
	/usr/bin/zsh /home/ds82/documents/xcustomfunctions.sh
}

xdecode(){  # quick base64 decode
	echo -n $1 |base64 -d
}

gocopy() {  # copy Go bonary to bin
    cp $1 /home/ds82/go/bin
}

goremove(){  # remove go binary from bin
    rm /home/ds82/go/bin/$1
}

xgrep(){    # quickly grep a directory
	grep -Hnri "$1"
}

xsort(){    # sort and unique file
    cat $1 |sort -u|tee sorted.txt && mv sorted.txt $1 && wc $1
}

xstriphttp(){   # strip http(s) from list of hosts
	cat $1 |sed 's~http[s]*://~~g' |tee stripped.txt
}

xzonetransfer(){    # check for zone transfers
	dig NS $1 +short | sed -e "s/\.$//g" | while read nameserver; do echo "Testing $1 @ $nameserver"; dig AXFR $1 "@$nameserver"; done
}
