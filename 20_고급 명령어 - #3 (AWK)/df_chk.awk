{
	gsub(/%/,"")
	PER=0;MNT=""
	if ( NF == 6 ) PER=$5
	if ( PER > 30 ) MNT=$6
	printf "%d%\t%s\n",PER,MNT
}
