if ! command -v gogogo > /dev/null; then
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