FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

UCOM_IMX93_UBOOT_CONFIG = "${WORKDIR}/ucom-imx93-uboot.cfg"
UCOM_IMX93_UBOOT_BUILD_DIR = "${B}/imx93_11x11_evk_defconfig"

SRC_URI:append:ucom-imx93 = " \
    file://ucom-imx93-uboot.cfg \
"

merge_ucom_imx93_uboot_config() {
    bbnote "Merging uCOM-iMX93 U-Boot configuration"

    ${S}/scripts/kconfig/merge_config.sh -m \
        -O ${UCOM_IMX93_UBOOT_BUILD_DIR} \
        ${UCOM_IMX93_UBOOT_BUILD_DIR}/.config \
        ${UCOM_IMX93_UBOOT_CONFIG}

    oe_runmake \
        -C ${S} \
        O=${UCOM_IMX93_UBOOT_BUILD_DIR} \
        olddefconfig
}


do_configure:append:ucom-imx93() {
    merge_ucom_imx93_uboot_config
}


SRC_URI:append:ucom-imx93-v1 = " \
    file://005-ucom-imx93-2gddr-0001-uboot.patch \
"

SRC_URI:append:ucom-imx93-v2 = " \
    file://006-ucom-imx93-2gddr-0002-uboot.patch \
"

SRC_URI:append:ucom-imx93-v3 = " \
    file://007-ucom-imx93-4gddr-0001-uboot.patch \
"

SRC_URI:append:srg-imx8pl-4g = " ${EXTRA_UBOOT_PATCHES}"
SRC_URI:append:srg-imx8pl-2g = " ${EXTRA_UBOOT_PATCHES}"
SRC_URI:append:ucom-imx8p-4g = " ${EXTRA_UBOOT_PATCHES}"
SRC_URI:append:ucom-imx8p-2g = " ${EXTRA_UBOOT_PATCHES}"
