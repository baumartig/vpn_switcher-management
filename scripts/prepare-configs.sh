#! /bin/sh

cp -f $1/*.ovpn $2

# umbenennen der konfigurationen
rename -v 's/\.ovpn$/\.conf/' $2/*.ovpn

cd $2
rename -v 's/^ipvanish-//' *.conf
for f in *.conf
do
	# einstellen der authentifizierung
	sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/user.txt/g' $f
	# setzen des tunel device
	sed -i 's/dev tun/dev tun0/g' $f
	# redirect gateway hinzufügen
	echo 'redirect-gateway' >> $f
	echo 'ca /etc/openvpn/ca.ipvanish.com.crt' >> $f
done
