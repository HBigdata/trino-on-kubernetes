#!/usr/bin/env sh

wait_for() {
    if [ -n "$1" -a  -z -n "$2" ];then   
       echo Waiting for $1 to listen on $2...
       while ! nc -z $1 $2; do echo waiting...; sleep 1s; done
    fi
}

start_trino() {
    
   wait_for $1 $2

   ${TRINO_HOME}/bin/launcher run --verbose

}

case $1 in
        trino-coordinator)
                start_trino coordinator $@
                ;;
        trino-worker)
                start_trino worker $@
                ;;
        *)
                echo "请输入正确的服务启动命令~"
        ;;
esac
