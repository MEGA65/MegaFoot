megafoot.d81: getdat getbas getelevensrc
	c1541 -format megafoot,mf d81 megafoot.d81 -attach megafoot.d81 -write foot.prg foot -write pal.bin -write level1-bg.bin -write level1-bg.dat -write player.bin -write player.dat -write duck.bin -write duck.dat -write grab.prg grab -write foot.el foot.el,s -write grabber.el grabber.el,s -write boxtest.el boxtest.el,s -write 11.defaults -write 11.edit -write 11.parse -write 11.post -write 11.settings -write autoboot.c65 -write 11.tokenize -write b65support.bin -write readme readme,s

getelevensrc:
	cp /c/Users/gurcei/AppData/Roaming/xemu-lgb/mega65/hdos/11.D81 .
	c1541 -attach 11.D81 -read 11.defaults -read 11.edit -read 11.parse -read 11.post -read 11.settings -read autoboot.c65 -read 11.tokenize -read readme,s -read b65support.bin

pushdat: layers.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete layers.bin -write layers.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete pal.bin -write pal.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete level1-bg.bin -write level1-bg.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete level1-bg.dat -write level1-bg.dat
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete player.bin -write player.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete player.dat -write player.dat
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete duck.bin -write duck.bin
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete duck.dat -write duck.dat

getdat:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -read layers.bin -read foot foot.prg -read "level1-bg.bin" -read "level1-bg.dat" -read "player.bin" -read "player.dat" -read "duck.bin" -read "duck.dat"

getbas:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -read grab grab.prg
	petcat -65 -o grab.bas -- grab.prg

tod81:
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete foot.el -write foot.el foot.el,s
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete grabber.el -write grabber.el grabber.el,s
	c1541 -attach "C:\Users\gurcei\AppData\Roaming\xemu-lgb\mega65\hdos\11.D81" -delete boxtest.el -write boxtest.el boxtest.el,s
