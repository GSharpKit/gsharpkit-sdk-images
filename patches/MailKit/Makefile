all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net45/MailKit.dll -package MailKit -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 MailKit.pc /usr/share/pkgconfig/
