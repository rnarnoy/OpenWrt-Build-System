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
#rm -rf feeds/small8/shadowsocks-rust

#luci-theme-argone
#git_sparse_clone main https://github.com/kenzok8/small-package luci-theme-argone
#git_sparse_clone main https://github.com/kenzok8/small-package luci-app-argone-config

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
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-openclash
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-passwall
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ssr-plus
#更换插件名称
#sed -i 's/ShadowSocksR Plus+/科学上网/g' feeds/small8/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua

# git_sparse_clone master https://github.com/kiddin9/openwrt-packages brook
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages chinadns-ng
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages dns2socks
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages dns2tcp
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages gn
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages hysteria
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages ipt2socks
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages microsocks
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages naiveproxy
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages pdnsd-alt
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadowsocksr-libev
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadowsocks-rust
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages simple-obfs
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages sing-box
git_sparse_clone master https://github.com/kiddin9/openwrt-packages ssocks
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages tcping
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan-go
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages trojan-plus
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages tuic-client
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-core
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-geodata
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2ray-plugin
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages xray-core
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages xray-plugin
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages lua-neturl
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages mosdns
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages redsocks2
git_sparse_clone master https://github.com/kiddin9/openwrt-packages shadow-tls
# git_sparse_clone master https://github.com/kiddin9/openwrt-packages lua-maxminddb
git_sparse_clone master https://github.com/kiddin9/openwrt-packages v2dat


#luci-app-turboacc
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-turboacc

#ddns-go
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages ddns-go
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-ddns-go
# rm -rf feeds/small8/ddns-go feeds/small8/luci-app-ddns-go
# git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/ddnsgo

#Netdata
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages netdata
#git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/linpc/luci-app-netdata
# 调整 netdata 到 服务 菜单
#sed -i 's/"system"/"services"/g' feeds/luci/applications/luci-app-netdata/luasrc/controller/*.lua
#sed -i 's/"system"/"services"/g' feeds/luci/applications/luci-app-netdata/luasrc/model/cgi/*.lua
#sed -i 's/admin\/system/admin\/services/g' feeds/luci/applications/luci-app-netdata/luasrc/view/netdata/*.htm

#mosdns
git_sparse_clone master https://github.com/kiddin9/openwrt-packages mosdns
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-mosdns
# 修复插件冲突
#rm -rf feeds/small8/luci-app-mosdns/root/etc/init.d

#zerotier
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-zerotier
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages zerotier

#luci-app-autotimeset
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-autotimeset

##########################################其他设置##########################################

# 修改默认登录地址
sed -i 's/192.168.1.1/10.1.1.254/g' ./package/base-files/files/bin/config_generate

# 修改默认登录密码
#sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' ./package/base-files/files/etc/shadow



# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.15/KERNEL_TESTING_PATCHVER:=5.10/g' ./target/linux/x86/Makefile

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config


#添加项目地址
sed -i 's/cpuusage\.cpuusage/cpuusage.cpuusage,/g' feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
sed -i -f ../customize/diy/immortalwrt_10_system.sed feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

#修改镜像源
sed -i 's#mirror.iscas.ac.cn/kernel.org#mirrors.edge.kernel.org/pub#' scripts/download.pl

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

#修改默认设置
cp -f ../customize/diy/default-settings package/emortal/default-settings/files/99-default-settings


