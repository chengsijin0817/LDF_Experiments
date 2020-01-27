#1. Directory for total Workloads
#e.g. /xxx/watdiv/bin/Release/workloads_singleClient
#2. Directory for the divided workloads
#/xxx/watdiv/bin/Release/workloads_multiClients
#3. nr of clients:
# 2/ 8/ 16/ 32/ 64 


if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    exit
fi

inputdir="$1"
outputdir="$2"
number_of_subdirs="$3"

mkdir -p ${outputdir}
rm -r ${outputdir}/*

for (( c=1; c<=${number_of_subdirs}; c++ ))
do
   echo "Creating subdir $c"
   mkdir -p ${outputdir}/client_$c
done

subdircnt=1
querycnt=0

queryLoadList=`ls $inputdir`
for queryW in $queryLoadList
do
    if [ -d ${inputdir}/${queryW} ];
    then
        queryList=$inputdir"/"$queryW
        for query in `ls $queryList`
        do
            mkdir -p ${outputdir}/client_${subdircnt}/$queryW
            cp $queryList/$query $outputdir/client_${subdircnt}/$queryW/$query
            ((subdircnt++))
            if [ "$subdircnt" -gt "$number_of_subdirs" ];then
                subdircnt=1;
            fi
        done
        echo $queryW" has been divided"
    fi
done

echo "The workloads for "$number_of_subdirs" clients has been prepared"