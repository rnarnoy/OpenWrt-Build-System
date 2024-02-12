if [ ! -f /usr/bin/gogogo ]; then   #  插入gogogo命令
    echo '#!/bin/bash' > gogogo
    echo 'sudo touch /home/runner/stop_signal' >> gogogo
    sudo chmod a+x gogogo && sudo cp gogogo /usr/bin/
    echo "================gogogo命令已加载!================"
    echo "                                                "
    echo "                                                "
else
    echo "================gogogo命令已存在!================"
    echo "                                                "
    echo "                                                "
fi

send_message() {
    if [ -n "${{ secrets.IYUU_TOKEN }}" ]; then
        # 发送消息到 IYUU 接口
        curl -X POST \
        "https://iyuu.cn/${{ secrets.IYUU_TOKEN }}.send" \
        -H 'Content-Type: application/json' \
        -d '{"text": "'"${1}"'", "desp": "'"${2}"'"}' > /dev/null 2>&1
        echo "=======已通过IYUU接口发送通知======="
    fi

    if [ -n "${{ secrets.SERVERCHAN_SCKEY }}" ]; then
        # 发送消息到 Server酱
        curl -X POST \
        "https://sc.ftqq.com/${{ secrets.SERVERCHAN_SCKEY }}.send" \
        -H 'Content-Type: application/json;charset=utf-8' \
        -d '{"text": "'"${1}"'", "desp": "'"${2}"'"}' > /dev/null 2>&1
        echo "=======已通过Server酱发送通知======="
    fi
}

# check_compile_result() {
#     if [ -f /home/runner/stop_signal ]; then
#         if ls $GITHUB_WORKSPACE/${{ env.BD_PROJECT }}/bin/targets/*/*/ | grep -q '\.img\.gz$'; then
#             echo "BD_COMPILE=success" >> $GITHUB_ENV
#             echo "FIRMWARE_PATH=$PWD" >> $GITHUB_ENV
#             echo "DATE=$(date +"%Y.%m.%d")" >> $GITHUB_ENV
#             echo "KERNEL=$(cat *.manifest | grep ^kernel | cut -d- -f2 | tr -d ' ')" >> $GITHUB_ENV
#             uppercase_string=$(echo "${{ env.BD_PROJECT }}" | tr '[:lower:]' '[:upper:]')
#             echo "Uppercase_String=$uppercase_string" >> $GITHUB_ENV
#             tar -czvf packages.tar.gz packages
#             rm -rf packages
#             echo "===========编译成功,准备上传===========" | sudo wall
#             send_message "编译成功,准备上传" "编译成功,准备上传"
#             break
#         else
#             rm -f /home/runner/stop_signal
#             echo "===========编译失败,继续暂停===========" | sudo wall
#             echo "BD_COMPILE=failure" >> $GITHUB_ENV
#             send_message "编译失败,继续暂停" "编译失败,继续暂停"
#         fi
#     fi
# }

echo "================= 通知模块已加载 ================="
#echo "================= 校验模块已加载 ================="


# count=0
# progress_bar_format=$(tput sgr0)  # 清除所有属性
# progress_bar_format+=$(tput bold)  # 设置为粗体
# progress_bar_format+=$(tput setaf 2)  # 设置为亮绿色
# while [ $count -lt $((60 * ${{ env.SSH_TIME }})) ] ; do
# # 每秒钟增加内部计数器
#     while ! test -f /home/runner/stop_signal; do
#         # 计算当前时间
#         elapsed_minutes=$(date +%M)
#         elapsed_seconds=$(date +%S)
#         elapsed_time="$elapsed_minutes分钟$elapsed_seconds秒"

#         # 更新进度条
#         progress_bar_length=10
#         progress_bar=$(printf "%${progress_bar_length}s" "[$(tput setaf 2);$(tput sgr0)]" | sed "s/ *$/${count}/")
#         printf "%s\r" "$progress_bar"

#         # 每秒钟增加内部计数器
#         count=$((count + 1))
#         sleep 1
#     done

#     if ls $GITHUB_WORKSPACE/${{ env.BD_PROJECT }}/bin/targets/*/*/ | grep -q '\.img\.gz$'; then
#         cd bin/targets/*/*/
#         echo "BD_COMPILE=success" >> $GITHUB_ENV
#         echo "FIRMWARE_PATH=$PWD" >> $GITHUB_ENV
#         echo "DATE=$(date +"%Y.%m.%d")" >> $GITHUB_ENV
#         echo "KERNEL=$(cat *.manifest | grep ^kernel | cut -d- -f2 | tr -d ' ')" >> $GITHUB_ENV
#         uppercase_string=$(echo "${{ env.BD_PROJECT }}" | tr '[:lower:]' '[:upper:]')
#         echo "Uppercase_String=$uppercase_string" >> $GITHUB_ENV
#         tar -czvf packages.tar.gz packages
#         rm -rf packages
#         echo "===========编译成功,准备上传==========="
#         send_message "编译成功,准备上传" "编译成功,准备上传"
#         break
#     else
#         rm -f /home/runner/stop_signal
#         echo "===========编译失败,继续暂停==========="
#         echo "BD_COMPILE=failure" >> $GITHUB_ENV
#         send_message "编译失败,继续暂停" "编译失败,继续暂停"
#     fi
# done
# # 清除进度条格式
# printf "%s\n" "$progress_bar_format"