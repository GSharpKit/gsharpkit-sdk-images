all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i ServiceStack.dll -package ServiceStack -root /usr/lib -gacdir mono/gac
	gacutil -i ServiceStack.Common.dll -package ServiceStack.Common -root /usr/lib -gacdir mono/gac
	gacutil -i ServiceStack.Client.dll -package ServiceStack.Client -root /usr/lib -gacdir mono/gac
	gacutil -i ServiceStack.Text.dll -package ServiceStack.Text -root /usr/lib -gacdir mono/gac
	gacutil -i ServiceStack.Interfaces.dll -package ServiceStack.Interfaces -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 ServiceStack.pc /usr/share/pkgconfig/
	install -m 644 ServiceStack.Interfaces.pc /usr/share/pkgconfig/
