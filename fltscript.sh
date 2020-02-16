
files=`ls`
for file in $files
do
	if getfattr -n user.flt --only-values $file > /dev/null 2>&1
	then
		flt=`getfattr -n user.flt --only-values $file`
		num="$(echo $flt | cut -d' ' -f1)"
		unit="$(echo $flt | cut -d' ' -f2)"
		now=`date +"%c"`
		fad1=`stat -c %x $file | cut -d' ' -f 1-2`		
		fad2=`date -d "$fad1" +"%c"`
		newdate=`date --date="$fad2 +$num $unit" +"%c"`
		d1=`date -d"${newdate}" +%Y%m%d%H%M%S`
		d2=`date -d"${now}" +%Y%m%d%H%M%S`
		if [ $d1 -lt $d2 ]
		then `rm $file`
		fi
	fi
done


