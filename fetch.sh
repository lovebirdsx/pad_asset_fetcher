# 1) Get extlist from:
# 	http://patch-na-pad.gungho.jp/base-na-adr.json (USA/EU, Android),
# 	http://patch-na-pad.gungho.jp/base-na.json (USA/EU, iOS)
# 	http://patch-pad.gungho.jp/base_adr.json (JP, Android)
# 	http://dl.padsv.gungho.jp/base.json (JP, iOS)
# 	http://dl.padsv.gungho.jp/base.ht-adr.json (CH, Android)
# 	http://dl.padsv.gungho.jp/base.ht-ios.json (CH, iOS)
# 	http://patch-kr-pad.gungho.jp/base.kr-adr.json (KR, Android)
# 	http://patch-kr-pad.gungho.jp/base.kr-ios.json (KR, iOS)
# 2) Using that extlist URL, append mons_*.bc, where * is a number that is zero padded to 3 digits, eg: 001, 999, 1000
# 3) Also using the extlist URL, append cards_*.bc, where * is a number that is zero padded to 3 digits, max atm is 026.

mons_range="2800 2810"
cards_range="1 2"
exlist="http://dl-na.padsv.gungho.jp/ext/mon1610180054502732762995805e35ac4386"
mons_outdir="asset/mons"
cards_outdir="asset/cards"

for mon_id in `seq $mons_range`
do
	mons_file=$(printf "mons_%03d.bc" "$mon_id")
    mon_url="$exlist/$mons_file"
    output_file="raw/mons/$mons_file"
    curl --output "$output_file" "$mon_url"
    python "PADTextureTool.py" "$output_file" --outdir "$mons_outdir"
done

for card_id in `seq 1 $cards_range`
do
	card_file=$(printf "cards_%03d.bc" "$card_id")
    card_url="$exlist/$card_file"
    output_file="raw/cards/$card_file"
    curl --output "$output_file" "$card_url"
    python "PADTextureTool.py" "$output_file" --outdir "$cards_outdir"
done

