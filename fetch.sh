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

# mons_range="1 2810"
mons_range="1 1024"
cards_range="1 26"
exlist="http://dl-na.padsv.gungho.jp/ext/mon1610180054502732762995805e35ac4386"
mons_outdir="asset/mons"
cards_outdir="asset/cards"
raw_mons_dir='raw/mons'
raw_cards_dir='raw/cards'
mkdir -pv $mons_outdir
mkdir -pv $cards_outdir
mkdir -pv $raw_mons_dir
mkdir -pv $raw_cards_dir

for mon_id in `seq $mons_range`
do
	mons_file=$(printf "mons_%03d.bc" "$mon_id")
    mon_url="$exlist/$mons_file"
    output_file="$raw_mons_dir/$mons_file"
    res_file=$(printf "$mons_outdir/MONS_%05d.PNG" "$mon_id")
    if ! (ls "$res_file" 1> /dev/null 2>&1;) then
        echo "fetch $mons_file"
        curl -# --output "$output_file" "$mon_url"
        python "PADTextureTool.py" "$output_file" --outdir "$mons_outdir"
    else
        echo "ignore $mons_file"
    fi
done

for card_id in `seq $cards_range`
do
    card_file=$(printf "cards_%03d.bc" "$card_id")
    card_url="$exlist/$card_file"
    output_file="$raw_cards_dir/$card_file"
    res_file=$(printf "$cards_outdir/CARDS_%03d.png" "$card_id")
    if ! (ls "$res_file" 1> /dev/null 2>&1;) then
        echo "fetch $card_file"
        curl -# --output "$output_file" "$card_url"
        python "PADTextureTool.py" "$output_file" --outdir "$cards_outdir"
    else
        echo "ignore $card_file"
    fi
done
