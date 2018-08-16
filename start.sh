#!/bin/bash

_BASE_DIR=$(dirname $0)
_BENCHMARK_TOOLS_HOME="${_BASE_DIR}/benchmark-tools"
_TIME_SLEEP=3
_CMD=$1

#start benchmark-tools 
Start_Benchmark_Tools() {

    /bin/bash ${_BENCHMARK_TOOLS_HOME}/benchmark.sh $@ & 

    #create benchmark-tools pid file
    if [ $? -eq 0 ]; then
        while [ -z $(pgrep -f java) ]; do
            sleep ${_TIME_SLEEP}
        done
        echo $(pgrep -f java) > ${_BENCHMARK_TOOLS_HOME}/benchmark-tools.pid
    fi
    
}


#exec trap and bash 
Trap_And_Bash() {

    #trap terminal signal when docker stop
    case ${_CMD} in
        exec)
         echo "trap 'pkill -SIGTERM -F ${_BENCHMARK_TOOLS_HOME}/benchmark-tools.pid; sleep ${_TIME_SLEEP}; exit 0' TERM" >> /.bashrc
         exec /bin/bash
         ;;
        daemon)
         trap "pkill -SIGTERM -F ${_BENCHMARK_TOOLS_HOME}/benchmark-tools.pid; sleep ${_TIME_SLEEP}; exit 0" TERM
         #loop...
         while : ; do
             :
         done
         ;;
        *)
         Error
         ;;
    esac


}


Error() {
    echo -e "Usage: $0 [ exec | daemon ] \nexec is to start benchmark-tools in bg\ndaemon is to start benchmark-tools in daemon"
    exit 1
}

if [ $# -lt 1 ] || [ $1 != "exec" -a $1 != "daemon" ] ; then
    Error
fi

shift

Start_Benchmark_Tools $@
Trap_And_Bash

exit $?
