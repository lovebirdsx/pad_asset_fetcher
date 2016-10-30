cards_outdir="cards"
tmp_dir="tmp"

mkdir $cards_outdir
mkdir $tmp_dir
cards_range="1 26"

for cards_id in `seq $cards_range`
do
	from=$(printf "asset/cards/CARDS_%03d.png" "$cards_id")
	echo $from
	convert "$from" -crop 102X102 "$tmp_dir/%02d.png"
	for id in `seq 0 99`
	do
		card_from=$(printf "$tmp_dir/%02d.png" $id)
		let card_id=($cards_id-1)*100+$id+1
		card_to=$(printf "$cards_outdir/card_%04d.png" $card_id)
		echo $card_from $card_to
		mv $card_from $card_to
	done
done

