#1. directory of the queries
#e.g. /xxx/watdiv/bin/Release/queries
# 2. directory of the workload
#/xxx/watdiv/bin/Release/workloads_singleClient
query_dir="$1"
workload_dir="$2"

mkdir -p ${workload_dir}
rm -r ${workload_dir}/*

nrQueW=9
for (( i=1; i <= $nrQueW; i++ ))
do
    mkdir -p ${workload_dir}/QW_$i
done


for file in `ls $query_dir`
do
    if [ -d ${query_dir}/${file} ];
    then
        case $file in
            "L1" | "L2" | "L5" )
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_5/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_8/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "L3" | "L4" )
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_1/$queryT
                    cp $subDir/$queryT $workload_dir/QW_5/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_9/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "S1" | "S2" | "S3" | "S5" )
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_1/$queryT
                    cp $subDir/$queryT $workload_dir/QW_4/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_9/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "S4")
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_4/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_9/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "S6")
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_1/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_9/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "S7")
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_9/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "F1" | "F3" | "F5" )
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_6/$queryT
                    cp $subDir/$queryT $workload_dir/QW_8/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "F2")
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_4/$queryT
                    cp $subDir/$queryT $workload_dir/QW_6/$queryT
                    cp $subDir/$queryT $workload_dir/QW_8/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "F4")
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_3/$queryT
                    cp $subDir/$queryT $workload_dir/QW_4/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_8/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
            "IL-1"* | "IL-2"* | "IL-3"* | "ML-1"* | "ML-2"* )
                subDir=$query_dir"/"$file
                for queryT in `ls $subDir`
                do
                    cp $subDir/$queryT $workload_dir/QW_2/$queryT
                    cp $subDir/$queryT $workload_dir/QW_5/$queryT
                    cp $subDir/$queryT $workload_dir/QW_7/$queryT
                    cp $subDir/$queryT $workload_dir/QW_8/$queryT
                done
                echo "The queries of template "$file" has been copied to the workload directory"
                ;;
        esac
    fi
done

rm ${workload_dir}/nrOfQuePerWL.txt

for (( i=1; i <= $nrQueW; i++ ))
do
    number=`ls ${workload_dir}/QW_$i| wc -l`
    echo "The number of unique queries in QW_"$i" is: "$number
    echo "The number of unique queries in QW_"$i" is: "$number >> ${workload_dir}/nrOfQuePerWL.txt
done