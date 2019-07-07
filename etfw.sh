#!/bin/bash
filename=`tempfile`
tmp=`tempfile`

if curl -f -o $filename https://rules.emergingthreats.net/fwrules/emerging-IPTABLES-AL$
        echo "#!/bin/bash">>$tmp
        echo "IPTABLES='iptables '">>$tmp
        echo "iptables -F ETBLOCKLIST">>$tmp
        echo "iptables -F LOGNDROP">>$tmp
        echo "iptables -F">>$tmp
        echo "iptables -A LOGNDROP -j LOG --log-prefix 'ET BLOCK: '">>$tmp
        cat $filename >> $tmp
        rm $filename
        cp $tmp /root/etfw_cache.sh
        . $tmp
        rm $tmp
else
        . /root/etfw_cache.sh
fi

