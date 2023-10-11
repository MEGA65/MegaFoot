pushdat: layers.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete layers.bin -write layers.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete pal.bin -write pal.bin

getdat:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -read layers.bin

getbas:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -read grab grab.prg
	petcat -65 -o grab.bas -- grab.prg

tod81:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete foot.el -write foot.el foot.el,s
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete grabber.el -write grabber.el grabber.el,s
