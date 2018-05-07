all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib
	install -m 644 Microsoft.Web.Services3.dll /usr/lib/
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net461/SealApi.dll -package SealApi -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 SealApi.pc /usr/share/pkgconfig/
