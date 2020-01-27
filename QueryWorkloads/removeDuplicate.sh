#directory of the queries
#e.g. /XXX/watdiv/bin/Release/queries
query_dir="$1"

rm ${query_dir}/numberOfUniqQue.txt

for file in `ls $query_dir`
do
	if [ -d ${query_dir}/${file} ];
    then
    	subDir=$query_dir"/"$file
    	#fdupes -S $subDir
    	fdupes -d -N $subDir

    	echo "The duplicates queries in "$file" has been deleted"
    	number=`ls $subDir| wc -l`
    	echo "The number of unique queries in "$file" is: "$number
    	echo "The number of unique queries in "$file" is: "$number >> ${query_dir}/numberOfUniqQue.txt

    	cnt=0
    	for query in `ls $subDir`
        do
        	((cnt++))
        	mv ${subDir}/${query} ${subDir}/${RANDOM}\_${file}\_${cnt}
		done
    fi
done