# Inputs of this script:

# 1. moduleFile: absolute path to the model file, which could be find in the model sub-directory where WatDiv was installed
# e.g.: /xxx/watdiv/model/wsdbm-data-model.txt
# 2. templateDir: absolute path to the query template directory, which could be find in the testsuite sub-directory where WatDiv was installed
# e.g. /xxx/watdiv/testsuite
# 3. queryCount: specify the number of queries that would be generated by each query template
# e.g. 5000
# 4. output_seperate: the directory that store generated queries in seperate files under subquery
#e.g. "/xxx/watdiv/bin/Release/queries"

moduleFile="$1"
templateDir="$2"
queryCount="$3"
queriesPerTemp="queriesTemp"
outputList_seperate="$4"

mkdir -p ${queriesPerTemp}
rm -r ${queriesPerTemp}/*

# generate query instances for each query template, output generated queries in single file for each query template

#mkdir -p $output

for file in `ls $templateDir`
do
    echo $file
    if [ -d ${templateDir}/${file} ];
    then
    	subDir=$templateDir"/"$file
        for queryT in `ls $subDir`
        do
        	if [[ $queryT =~ \.txt$ ]];then
        		queryTName=`basename $queryT .txt`
                echo $queriesPerTemp/${queryTName}.txt
				./watdiv -q $moduleFile ${subDir}/${queryT} $queryCount 1 > ${queriesPerTemp}/${queryTName}.txt
				echo "The queries for "${queryTName}" has been generated"
			fi
		done
    else
        fileName=`basename $file .txt`
		./watdiv -q $moduleFile ${templateDir}/${file} $queryCount 1 > ${queriesPerTemp}/${fileName}.txt
		echo "The queries for "${fileName}" has been generated"
    fi
done



echo "Start issue queries in seperate files..."

# Create subqueries for each query template, and issue individual queries in seperate files under the subquery

# firstly clear the directory
mkdir -p ${outputList_seperate}
rm -r ${outputList_seperate}/*

# Use the files that contains all individual queries for each query tempalte
queryList=`ls $queriesPerTemp`
for query in $queryList
do
    # Seperate queries based on the number of lines (all individual queries of the same query tempalte has the same number of lines)
    
    # count the total number of lines in one file
    totalLine=`wc -l $queriesPerTemp/${query}|awk -F ' ' '{print $1}'`
    # calculate the count of lines of each query
    lineCountEachQuery=`expr $totalLine / $queryCount`
    queryTemp=`basename $query .txt`
    # create subdirectories for each query template
    mkdir -p ${outputList_seperate}/${queryTemp}

    # split queries into seperate files
    split -a 4 -l $lineCountEachQuery ${queriesPerTemp}/${query} ${outputList_seperate}/${queryTemp}/${queryTemp}_
    echo "The queries for "${queryTemp}" has been seperated"
done