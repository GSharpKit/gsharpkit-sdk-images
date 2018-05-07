all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net45/RestSharp.dll -package RestSharp -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 RestSharp.pc /usr/share/pkgconfig/
