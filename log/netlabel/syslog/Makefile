SHELL=/bin/bash
MACADDR_FILE=macaddr.txt
MACADDR_BY_VENDOR_FILE=macaddr_by_vendor.txt
IX2015LOG=ix2015.log

$(MACADDR_BY_VENDOR_FILE): $(MACADDR_FILE)
	echo "progress...take a minute."
	perl searchMacOUI.pl > $(MACADDR_BY_VENDOR_FILE)


$(MACADDR_FILE): $(IX2015LOG)
	awk '/send\ ack/{print substr($$12,5)}' < $(IX2015LOG)|sort -n|uniq > $(MACADDR_FILE)


$(IX2015LOG): syslogs.tar.gz.crypt
	openssl enc -d -aes-128-cbc -in syslogs.tar.gz.crypt -out syslogs.tar.gz
	tar -zxvf syslogs.tar.gz


enc: syslogs.tar.gz
	openssl enc -e -aes-128-cbc -in syslogs.tar.gz -out syslogs.tar.gz.crypt

clean:
	rm -f $(MACADDR_FILE) $(MACADDR_BY_VENDOR_FILE)
