#!/bin/bash

# 设定时区
timedatectl set-timezone "Asia/Singapore"

# 当前时间
current_time=$(date +%H:%M:%S)

# 定义任务的时间
task1="00:01:23"
task2="01:02:34"
task3="02:03:45"
task4="03:04:56"
task5="04:02:34"
task6="05:03:45"
task7="06:12:18"
task8="11:23:45"
task9="14:45:56"
task10="22:34:56"

# 检查并等待到达下一个任务时间
function wait_for_next_task {
    local next_task_time=$1
    local sleep_seconds

    while true; do
        current_time=$(date +%H:%M:%S)

        if [[ $current_time > $next_task_time ]]; then
            break
        fi

        sleep_seconds=$(( $(date -d "$next_task_time" +%s) - $(date -d "$current_time" +%s) ))
        sleep $sleep_seconds
    done
}

# 执行任务
function run_task {
    local command=$1

    eval "$command"
}

# 等待并执行任务
wait_for_next_task "$task1"
run_task "cd /root && curl -sL yabs.sh | bash && rm -rf /root/geekbench*"

wait_for_next_task "$task2"
run_task "cd /root && wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh && rm -rf /root/unix*"

wait_for_next_task "$task3"
run_task "cd /root && wget -qO- bench.sh | bash && rm -rf /root/.abench"

wait_for_next_task "$task4"
run_task "cd /root && curl -fsL https://ilemonra.in/LemonBench-Beta | bash -s -- --full && rm -rf /root/Lemon* /root/2023* /root/*@* /root/.LemonBench"

wait_for_next_task "$task5"
run_task "cd /root && wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh && rm -rf /root/unixbench*"

wait_for_next_task "$task6"
run_task "cd /root && wget -qO- bench.sh | bash"

wait_for_next_task "$task7"
run_task "cd /root && rm -rf /root/keepalive* && wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && bash keepalive.sh"

wait_for_next_task "$task8"
run_task "systemctl stop cpur"

wait_for_next_task "$task9"
run_task "cd /root && rm -rf /root/keepalive* && wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && bash keepalive.sh"

wait_for_next_task "$task10"
run_task "systemctl stop cpur"

# 停止脚本服务：
# sudo systemctl stop oracle_keep_alive

# 重启脚本服务：
# sudo systemctl restart oracle_keep_alive

# 查看服务状态：
# sudo systemctl status oracle_keep_alive

# 卸载并完全清除本脚本服务：
# sudo systemctl stop oracle_keep_alive
# sudo systemctl disable oracle_keep_alive
# sudo rm /etc/systemd/system/oracle_keep_alive.service
# sudo systemctl daemon-reload
# rm /root/oracle_keep_alive.sh
