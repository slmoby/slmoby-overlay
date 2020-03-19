# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit unpacker
DESCRIPTION="Windscribe VPN"
HOMEPAGE="https://windscribe.com/"
# https://assets.staticnetcontent.com/desktop/linux/windscribe-cli_1.4-51_amd64.deb
SRC_URI="https://assets.staticnetcontent.com/desktop/linux/windscribe-cli_${PV}-51_amd64.deb"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
    net-vpn/openvpn
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
    if [ "${A}" != "" ]; then
        unpack ${A}
	unpack ${WORKDIR}/data.tar.xz
    fi
    S=${WORKDIR}
}


src_install(){
	insinto /usr/bin/
	doins usr/bin/windscribe
	fperms 0755 /usr/bin/windscribe
	
	insinto /etc/bash_completion.d/
	doins etc/bash_completion.d/windscribe_complete
	newinitd "${FILESDIR}/windscribe-cli.initd" windscribe-cli
	
}
