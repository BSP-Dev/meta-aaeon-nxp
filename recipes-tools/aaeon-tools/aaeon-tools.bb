SUMMARY = "tools required for service"
LICENSE = "CLOSED"

SRC_URI = "\
	file://srgimx8cfg \
    file://mdio-tool \
"

S = "${WORKDIR}"

do_install () {
    install -d ${D}/home/srt/eeprom
    install -m 0755 ${WORKDIR}/srgimx8cfg ${D}/home/srt/eeprom/srgimx8cfg

    install -d ${D}/usr/sbin
    install -m 0755 ${WORKDIR}/mdio-tool ${D}/usr/sbin/mdio-tool
}
 
do_package_qa[noexec] = "1"

FILES:${PN} += " /home/srt/eeprom/srgimx8cfg"
FILES:${PN} += " /usr/sbin/mdio-tool"
