all:
	echo "Building Done"


install:
	install -d -m 755 /usr/lib/mono/gac
	gacutil -i net20/MigraDoc.DocumentObjectModel.dll -package PDFsharp-MigraDoc -root /usr/lib -gacdir mono/gac
	gacutil -i net20/MigraDoc.Rendering.dll -package PDFsharp-MigraDoc -root /usr/lib -gacdir mono/gac
	gacutil -i net20/MigraDoc.RtfRendering.dll -package PDFsharp-MigraDoc -root /usr/lib -gacdir mono/gac
	gacutil -i net20/PdfSharp.Charting.dll -package PDFsharp-MigraDoc -root /usr/lib -gacdir mono/gac
	gacutil -i net20/PdfSharp.dll -package PDFsharp-MigraDoc -root /usr/lib -gacdir mono/gac
	install -d -m 755 /usr/share/pkgconfig/
	install -m 644 PDFsharp-MigraDoc.pc /usr/share/pkgconfig/

