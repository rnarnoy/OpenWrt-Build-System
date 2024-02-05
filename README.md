# 默认配置

- IP: `10.1.1.254`
- 用户名: `root`
- 密码: `无`
- 插件:
```
ShadowSocksR Plus+
PassWall
Openclash
Netdata
Auto time set
AdGuard Home
Mosdns
DDNS-go
ZeroTier
Openvpn
应用中心(iStore)
```

# 使用说明
   
## Fork 本项目  ==>  Actions  ==>  选择项目  ==>  Run Workflow

###### 没时间弄目前就写了一个lede_x86_64所以暂时没得选
  
   


## >>>[![Manually with SSH](https://github.com/lmxslpc/openwrt-build/actions/workflows/Manually%20with%20SSH.yml/badge.svg?branch=master&event=workflow_dispatch)](https://github.com/lmxslpc/openwrt-build/actions/workflows/Manually%20with%20SSH.yml)<<<
#####  可用于修改编译内容或手动编译,不同项目请自行修改[环境变量](https://github.com/lmxslpc/openwrt-build?tab=readme-ov-file#%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E8%AF%B4%E6%98%8E)
  
   


# 如何使用SSH连接Action
  
#### 开启ssh调试功能
修改.github/workflows/xxx.yml
```
env:
  SSH_DEBUG: 'false'  #false修改为true
```
```
SSH_TIME    设置开始编译前暂停时间,可用pkill sleep命令提前继续工作流
SSH_TIME2  设置编译报错后暂停时间,可用pkill sleep命令提前继续工作流
```
   
   

#### ssh连接命令

在工作流的setup ssh for debug步骤中会显示
```
============frpc启动成功!===========
==========以下是SSH连接命令==========
ssh root@xxx -p xxxx
```
密码为SSH_PW定义的密码,不设置则为123
   


#### 自定义选项
```
1.点击仓库的"Settings"

2.选择 "Actions secrets and variables"

3.点击 "New repository secret"

4.填写 Secret 信息：
  Name（名称）：
  Value（值）：
```
```
SSH_PW     # 用于定义ssh访问的root密码,不设置默认123
```

```
FRPC_CONFIG  # 用于定义frpc的配置文件,不设置将自动尝试使用公共frp服务器并生成SSH连接命令
```
   
   

#### FRPC_CONFIG示例
###### frp.freefrp.net是个公共服务器,所以可能会与他人配置冲突,默认会随机生成端口并尝试连接
```
[common]
server_addr = frp.freefrp.net  #备选frp1.freefrp.net;frp2.freefrp.net
server_port = 7000
token = freefrp.net

[ssh2action]     #改成不与他人相同的唯一值,随便写就行
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 22222   #改成不与他人相同的唯一值,端口范围10001 - 50000
```
   
   

# 添加新项目
   

#### 配置文件说明
| 目录         |         作用        |格式                   |
| ------------| --------------------| --------------------|
| config      | 放置.config配置文件   |   项目名称_编译目标.config              |
| customize   | 放置自定义脚本及文件    |   项目名称_编译目标.sh             |
| feeds       | 放置feeds源           |    项目名称_编译目标            |
| patches     | 放置补丁文件           |                |
   
   
#### 环境变量说明
|变量 |说明|
|----------|--------------------------------------------------|
|BD_PROJECT|   项目名称|
|  BD_TARGET|  编译目标|
| REPO_URL| 项目地址|
| REPO_BRANCH|  项目分支|
| TARGET_PLATFORM|  平台架构(amd64/arm64)|
| SSH_DEBUG| 是否开启ssh功能(true/false)|
| SSH_TIME|    设置开始编译前暂停时间,可用pkill sleep命令提前继续工作流|
|SSH_TIME2|   设置编译报错后暂停时间,可用pkill sleep命令提前继续工作流|
| CACHE_CCACHE  |    是否开启ccache缓存功能,不开启则只缓存工具链(true/false)|
| CACHE_CLEAN  |    是否清除缓存(true/false)|
| UPLOAD_ARTIFACT|   是否上传到ARTIFACT(true/false)|
| UPLOAD_RELEASE|    是否上传到RELEASE(true/false)|
