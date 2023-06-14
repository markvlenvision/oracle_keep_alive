#!/bin/bash

# 设定时区
timedatectl set-timezone "Asia/Singapore"

# 当前时间
current_time=$(date +%H:%M:%S)

# 定义任务的时间和命令
tasks=(
  ["00:01:23"]="cd /root && curl -sL yabs.sh | bash && rm -rf /root/geekbench**"
  ["01:02:34"]="cd /root && wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh && rm -rf /root/unixbench**"
  ["02:03:45"]="cd /root && wget -qO- bench.sh | bash"
  ["03:04:56"]="cd /root && curl -fsL https://ilemonra.in/LemonBench | bash -s -- --full && rm -rf /root/LemonBench* 2023-*"
  ["04:02:34"]="cd /root && wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh && rm -rf /root/unixbench**"
  ["05:03:45"]="cd /root && wget -qO- bench.sh | bash"
  ["06:12:18"]="cd /root && rm -rf /root/keepalive** && wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && bash keepalive.sh"
  ["11:23:45"]="systemctl stop cpur"
  ["14:45:56"]="cd /root && rm -rf /root/keepalive** && wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && bash keepalive.sh"
  ["22:34:56"]="systemctl stop cpur"
)

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
for task_time in "${!tasks[@]}"; do
    wait_for_next_task "$task_time"
    run_task "${tasks[$task_time]}"
done

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
