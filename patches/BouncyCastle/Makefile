all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i BouncyCastle.Crypto.dll -package BouncyCastle.Crypto -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 BouncyCastle.pc /usr/share/pkgconfig/
