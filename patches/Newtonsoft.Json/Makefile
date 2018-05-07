all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/Newtonsoft.Json
	install -m 644 net45/Newtonsoft.Json.dll /usr/lib/mono/Newtonsoft.Json/
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net45/Newtonsoft.Json.dll -package Newtonsoft.Json -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 Newtonsoft.Json.pc /usr/share/pkgconfig/
