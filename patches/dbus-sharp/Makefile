all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i dbus-sharp.dll -package dbus-sharp-2.0 -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 dbus-sharp-2.0.pc /usr/share/pkgconfig/
