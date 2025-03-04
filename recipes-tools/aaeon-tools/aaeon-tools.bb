SUMMARY = "tools required for service"
LICENSE = "CLOSED"

SRC_URI = "\
	file://imx8_plus_emmc_flasher.sh \
"
SRC_URI += "${EXTRA_UBOOT_BOOTLOADER_FILE}"

S = "${WORKDIR}"


do_install () {
	install -d ${D}/usr/sbin
	install -m 0755 ${WORKDIR}/imx8_plus_emmc_flasher.sh ${D}/usr/sbin/imx8_plus_emmc_flasher.sh
	
	install -d ${D}/opt/images/yocto
	install -m 0755 ${WORKDIR}/${EXTRA_UBOOT_BOOTLOADER} ${D}/opt/images/yocto/imx-boot-srg-imx8p-flash_evk
}
 
do_package_qa[noexec] = "1"

FILES:${PN} += " /usr/sbin/imx8_plus_emmc_flasher.sh"
FILES:${PN} += " /opt/images/yocto/imx-boot-srg-imx8p-flash_evk"
