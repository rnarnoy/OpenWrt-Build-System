#!/bin/bash
#=================================================
# 自定义
#=================================================
#1. 修改默认登录地址
sed -i 's/192.168.1.1/10.1.1.254/g' ./package/base-files/files/bin/config_generate

#2. 修改默认登录密码
sed -i 's/$1$5mjCdAB1$Uk1sNbwoqfHxUmzRIeuZK1//g' ./package/base-files/files/etc/shadow

#更换插件名称
#sed -i 's/ShadowSocksR Plus+/科学上网/g' feeds/small8/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/("iStore"),/("应用中心"),/g' feeds/store/luci/luci-app-store/luasrc/controller/store.lua

#修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.15/KERNEL_TESTING_PATCHVER:=5.10/g' ./target/linux/x86/Makefile

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 添加项目地址
cp -f ../customize/diy/istoreos_10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

#修改默认设置
mkdir -p files/etc/uci-defaults
cp  ../customize/diy/default-settings files/etc/uci-defaults/99-init-settings


# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

#修改镜像源
#sed -i 's#mirror.iscas.ac.cn/kernel.org#mirrors.edge.kernel.org/pub#' scripts/download.pl

# 修改版本为编译日期
#date_version=$(date +"%y.%m.%d")
#orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
#sed -i "s/${orig_version}/R${date_version} by Linpc/g" package/lean/default-settings/files/zzz-default-settings

# 移除要替换的包
#rm -rf feeds/packages/net/mosdns
#rm -rf feeds/packages/net/msd_lite
#rm -rf feeds/packages/net/smartdns
#rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-mosdns
#rm -rf feeds/luci/applications/luci-app-netdata

# Git稀疏克隆，只克隆指定目录到本地
#function git_sparse_clone() {
#  branch="$1" repourl="$2" && shift 2
#  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
#  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
#  cd $repodir && git sparse-checkout set $@
#  mv -f $@ ../package
#  cd .. && rm -rf $repodir
#}

#luci-app-adguardhome
#git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome

# 科学上网插件
#git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
#git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# 更改 Argon 主题背景
#cp -f $GITHUB_WORKSPACE/images/bg.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg.jpg

# MosDNS
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# 删除冲突包
rm -rf feeds/small8/shadowsocks-rust

#替换 luci-app-netdata
#rm -rf feeds/small8/luci-app-netdata
#git clone --depth=1 https://github.com/Jason6111/luci-app-netdata feeds/luci/applications/luci-app-netdata
#sed -i 's/"status"/"system"/g' feeds/luci/applications/luci-app-netdata/luasrc/controller/*.lua
#sed -i 's/"status"/"system"/g' feeds/luci/applications/luci-app-netdata/luasrc/model/cgi/*.lua
#sed -i 's/admin\/status/admin\/system/g' feeds/luci/applications/luci-app-netdata/luasrc/view/netdata/*.htm

#替换 ddns-go
rm -rf feeds/small8/ddns-go feeds/small8/luci-app-ddns-go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/ddnsgo

#替换 mosdns
rm -rf feeds/small8/mosdns feeds/small8/v2dat feeds/small8/luci-app-mosdns
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/mosdns

#替换 golang
rm -rf feeds/packages/lang/golang
cp -rf ../customize/diy/golang feeds/packages/lang/
