#!/bin/bash
#=================================================
# 自定义
#=================================================
##########################################添加额外包##########################################

# Git稀疏克隆，只克隆指定目录到本地
mkdir -p package/linpc

function git_sparse_clone() {
 branch="$1" repourl="$2" && shift 2
 git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
 repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
 cd $repodir && git sparse-checkout set $@
 mv -f $@ ../package/linpc
 cd .. && rm -rf $repodir
}


# 移除冲突包
rm -rf feeds/packages/net/mosdns
#rm -rf feeds/packages/net/msd_lite
#rm -rf feeds/packages/net/smartdns
#rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
#rm -rf feeds/small8/shadowsocks-rust

#luci-theme-argone
git_sparse_clone main https://github.com/kenzok8/small-package luci-theme-argone
git_sparse_clone main https://github.com/kenzok8/small-package luci-app-argone-config

#luci-app-store
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-store
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-lib-taskd
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-lib-xterm
git_sparse_clone master https://github.com/kiddin9/openwrt-packages taskd
#更换插件名称
sed -i 's/("iStore"),/("应用中心"),/g' package/linpc/luci-app-store/luasrc/controller/store.lua

#adguardhome
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adguardhome
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages adguardhome

#科学上网
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-openclash
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-passwall
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ssr-plus
#更换插件名称
#sed -i 's/ShadowSocksR Plus+/科学上网/g' feeds/small8/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua

#ddns-go
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ddns-go
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ddns-go
# rm -rf feeds/small8/ddns-go feeds/small8/luci-app-ddns-go
# git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/ddnsgo

#Netdata
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages netdata
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/linpc/luci-app-netdata
sed -i 's/"status"/"system"/g' package/linpc/luci-app-netdata/luasrc/controller/*.lua
sed -i 's/"status"/"system"/g' package/linpc/luci-app-netdata/luasrc/model/cgi/*.lua
sed -i 's/admin\/status/admin\/system/g' package/linpc/luci-app-netdata/luasrc/view/netdata/*.htm

#mosdns
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages mosdns
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-mosdns

#zerotier
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-zerotier
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages zerotier

#luci-app-autotimeset
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-autotimeset


########依赖包########
git_sparse_clone master https://github.com/kiddin9/openwrt-packages brook
git_sparse_clone master https://github.com/kiddin9/openwrt-packages chinadns-ng
git_sparse_clone master https://github.com/kiddin9/openwrt-packages dns2socks
git_sparse_clone master https://github.com/kiddin9/openwrt-packages dns2tcp
git_sparse_clone master https://github.com/kiddin9/openwrt-packages gn
git_sparse_clone master https://github.com/kiddin9/openwrt-packages hysteria
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ipt2socks
git_sparse_clone master https://github.com/kiddin9/openwrt-packages microsocks
git_sparse_clone master https://github.com/kiddin9/openwrt-packages naiveproxy
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages pdnsd-alt
git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadowsocksr-libev
git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadowsocks-rust
git_sparse_clone master https://github.com/kiddin9/openwrt-packages simple-obfs
git_sparse_clone master https://github.com/kiddin9/openwrt-packages sing-box
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ssocks
git_sparse_clone master https://github.com/kiddin9/openwrt-packages tcping
git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan
git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan-go
git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan-plus
git_sparse_clone master https://github.com/kiddin9/openwrt-packages tuic-client
git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-core
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-geodata
git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-plugin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages xray-core
git_sparse_clone master https://github.com/kiddin9/openwrt-packages xray-plugin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages lua-neturl
git_sparse_clone master https://github.com/kiddin9/openwrt-packages mosdns
git_sparse_clone master https://github.com/kiddin9/openwrt-packages redsocks2
git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadow-tls
git_sparse_clone master https://github.com/kiddin9/openwrt-packages lua-maxminddb

##########################################其他设置##########################################

# 更改 Argon 主题背景
#cp -f $GITHUB_WORKSPACE/images/bg.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg.jpg


# 修改默认登录地址
sed -i 's/192.168.1.1/10.1.1.254/g' ./package/base-files/files/bin/config_generate

#2. 修改默认登录密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' ./package/lean/default-settings/files/zzz-default-settings

# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.15/KERNEL_TESTING_PATCHVER:=5.10/g' ./target/linux/x86/Makefile

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

#添加项目地址
sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a <tr><td width="33%"><%:Github项目%><\/td><td><a href="https:\/\/github.com\/lmxslpc\/OpenWrt-Build-System" target="_blank">云编译系统<\/a><\/td><\/tr>' ./package/lean/autocore/files/x86/index.htm

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

#修改镜像源
sed -i 's#mirror.iscas.ac.cn/kernel.org#mirrors.edge.kernel.org/pub#' scripts/download.pl

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Linpc/g" package/lean/default-settings/files/zzz-default-settings

#删除无效opkg源
sed -i '/exit 0/i sed -i "/kiddin9/d" /etc/opkg/distfeeds.conf' ./package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i sed -i "/kenzo/d" /etc/opkg/distfeeds.conf' ./package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i sed -i "/small/d" /etc/opkg/distfeeds.conf' ./package/lean/default-settings/files/zzz-default-settings

#删除多余文件
sed -i '/exit 0/i\rm -f /etc/config/adguardhome\nrm -f /etc/init.d/adguardhome' ./package/lean/default-settings/files/zzz-default-settings



# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}
