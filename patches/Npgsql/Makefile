all:
	echo "Building Done"

install:
	install -d -m 755 /usr/lib/mono/Npgsql
	install -m 644 net451/Npgsql.dll /usr/lib/mono/Npgsql/
	install -d -m 755 /usr/lib/System.Threading.Tasks.Extensions
	install -m 644 System.Threading.Tasks.Extensions.dll /usr/lib/System.Threading.Tasks.Extensions/
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net451/Npgsql.dll -package Npgsql -root /usr/lib -gacdir mono/gac
	gacutil -i System.Threading.Tasks.Extensions.dll -package System.Threading.Tasks.Extensions -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 Npgsql.pc /usr/share/pkgconfig/
