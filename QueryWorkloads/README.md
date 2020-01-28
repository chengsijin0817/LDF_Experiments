# Scripts to generate workloads for the experiments

The experiments are based on the [Waterloo SPARQL Diversity Test Suite (WatDiv)](https://dsg.uwaterloo.ca/watdiv/). As a consequence, creating the workloads requires the WatDiv tools. Hence, as a preparation for using the workload-generation shell scripts in this repository, it is necessary to compile the WatDiv tools. Then, the shell scripts can be used, which includes four modules.

## Preparation step (compiling WatDiv tools)
To compile the WatDiv tools, as [described on the WatDiv Website](https://dsg.uwaterloo.ca/watdiv/#installation),

1. install the [Boost libraries](https://www.boost.org/),

2. download the [latest version of the WatDiv source code package](https://dsg.uwaterloo.ca/watdiv/#download), and

3. execute the following commands:

```
- tar xvf watdiv_v05.tar
- cd watdiv
- setenv BOOST_HOME <BOOST-INSTALLATION-DIRECTORY>
	- export BOOST_HOME=<BOOST-INSTALLATION-DIRECTORY> (in bash)
- make
- cd bin/Release
```

## Step 1. Generate queries from the Watdiv query templates
The script **queryGen.sh** traverses all WatDiv query templates and produces one sub-directory of queries per query template. Each such query is stored in a separate file. The script can be used as follows.

`./queryGen.sh <model-file> <query-Template-dir> <query-count> <outputQueries-dir>`

You will find a model file in the 'model' sub-directory where WatDiv was installed. The basic testing query templates can be found in the 'testsuite' sub-directory where WatDiv was installed.

e.g. `./queryGen.sh /PathTo/watdiv/model/wsdbm-data-model.txt /Pathto/watdiv/testsuite/ 5000 queries`


## Step 2. Remove duplicate queries

The script **removeDuplicate.sh** removes all the duplicates among the queries written in the previous step. Additionally, the script generates a unique name for each query. These names consist of a random 5-digit prefix. The ZIP package **'queries.zip'** is an example set of queries without duplicates, which was generated on setting the 'query-count' parameter to 5000.

To run the script, issue the following command:

`./removeDuplicate.sh <queryies-dir>`

e.g. `./removeDuplicate.sh /xxxx/queries`

## Script 3. generate workloads for the single client:

**genWorkLoad.sh**: it retrieves all the query instances of each query template and copies the queries into the corresponding workloads directory. 

To run the script, issue the following command:

`./genWorkLoad.sh <queries-dir> <workloads-dir>`

e.g. `./genWorkLoad.sh queries workloads_singleClient`

## Script 4. divide workloads for multiple clients:
**divideWorkloads.sh**: divides workloads into sub workloads according to the given number of clients.

To run the script, issue the following command:

`./divideWorkloads.sh <workload_singelClient_dir> <workload_multiple_dir> <numberOfClients>`

e.g. `./divideWorkloads.sh workloads_singleClient workloads_multiClients 4`
