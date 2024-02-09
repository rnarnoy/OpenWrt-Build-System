function gogogo() {
    touch ~/stop_signal
    echo "================gogogo命令已执行!================"
}

function send_message() {
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

function check_compile_result() {
    if [ -f ~/stop_signal ]; then
        if [ -n "$(ls ${{ env.BD_PROJECT }}/bin/targets/*/*/*.img.gz)" ]; then
            echo "BD_COMPILE=success" >> $GITHUB_ENV
            echo "FIRMWARE_PATH=$PWD" >> $GITHUB_ENV
            echo "DATE=$(date +"%Y.%m.%d")" >> $GITHUB_ENV
            echo "KERNEL=$(cat *.manifest | grep ^kernel | cut -d- -f2 | tr -d ' ')" >> $GITHUB_ENV
            uppercase_string=$(echo "${{ env.BD_PROJECT }}" | tr '[:lower:]' '[:upper:]')
            echo "Uppercase_String=$uppercase_string" >> $GITHUB_ENV
            tar -czvf packages.tar.gz packages
            rm -rf packages
            echo "===========编译成功,准备上传===========" | sudo wall
            send_message "编译成功,准备上传" "编译成功,准备上传"
        else
            rm -f ~/stop_signal
            echo "===========编译失败,继续暂停===========" | sudo wall
            echo "BD_COMPILE=failure" >> $GITHUB_ENV
            send_message "编译失败,继续暂停" "编译失败,继续暂停"
        fi
    fi
}

echo "================ gogogo命令已加载 ================"
echo "================= 通知模块已加载 ================="
echo "================= 校验模块已加载 ================="