FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGE_ARCH = "${MACHINE_ARCH}"

UCOM_IMX93_DTB_NAME = "imx93-11x11-evk-ucom-imx93"
UCOM_IMX93_DTS_PATH = "${S}/arch/arm64/boot/dts/freescale"
UCOM_IMX93_DTB_MAKEFILE = "${S}/arch/arm64/boot/dts/freescale/Makefile"

UCOM_IMX93_KERNEL_CONFIG = "${WORKDIR}/ucom-imx93-kernel.cfg"

# Common kernel configuration for all uCOM-iMX93 machines
SRC_URI:append:ucom-imx93 = " \
    file://ucom-imx93-kernel.cfg \
"

add_ucom_imx93_dtb_to_makefile() {
    if ! grep -q "^dtb-\$(CONFIG_ARCH_MXC) += ${UCOM_IMX93_DTB_NAME}.dtb" \
        ${UCOM_IMX93_DTB_MAKEFILE}; then

        if grep -q "^dtb-\$(CONFIG_ARCH_MXC) += imx93-11x11-evk-pmic-pf0900-rpmsg-lpv.dtb" \
            ${UCOM_IMX93_DTB_MAKEFILE}; then

            sed -i \
                '/^dtb-\$(CONFIG_ARCH_MXC) += imx93-11x11-evk-pmic-pf0900-rpmsg-lpv.dtb/a dtb-$(CONFIG_ARCH_MXC) += '"${UCOM_IMX93_DTB_NAME}"'.dtb' \
                ${UCOM_IMX93_DTB_MAKEFILE}
        else
            echo "dtb-\$(CONFIG_ARCH_MXC) += ${UCOM_IMX93_DTB_NAME}.dtb" \
                >> ${UCOM_IMX93_DTB_MAKEFILE}
        fi
    fi
}

merge_ucom_imx93_kernel_config() {
    bbnote "Merging uCOM-iMX93 kernel config: ${UCOM_IMX93_KERNEL_CONFIG}"

    ${S}/scripts/kconfig/merge_config.sh -m -O ${B} \
        ${B}/.config \
        ${UCOM_IMX93_KERNEL_CONFIG}

    oe_runmake -C ${S} O=${B} olddefconfig
}

do_configure:append:ucom-imx93() {
    merge_ucom_imx93_kernel_config
}

# uCOM-iMX93 V1, uCOM-IMX93 V3
SRC_URI:append:ucom-imx93-a10-0001 = " \
    file://imx93-11x11-evk-ucom-imx93-a10-0001.dts \
"

do_configure:prepend:ucom-imx93-a10-0001() {
    install -m 0644 \
        ${WORKDIR}/imx93-11x11-evk-ucom-imx93-a10-0001.dts \
        ${UCOM_IMX93_DTS_PATH}/${UCOM_IMX93_DTB_NAME}.dts

    add_ucom_imx93_dtb_to_makefile
}

# uCOM-iMX93 V2
SRC_URI:append:ucom-imx93-a10-0002 = " \
    file://0002-ucom-imx93-0002-kernel.patch \
    file://imx93-11x11-evk-ucom-imx93-a10-0002.dts \
"

do_configure:prepend:ucom-imx93-a10-0002() {
    install -m 0644 \
        ${WORKDIR}/imx93-11x11-evk-ucom-imx93-a10-0002.dts \
        ${UCOM_IMX93_DTS_PATH}/${UCOM_IMX93_DTB_NAME}.dts

    add_ucom_imx93_dtb_to_makefile
}

SRC_URI:append:srg-imx8pl-4g = " ${EXTRA_KERNEL_PATCHES}"
SRC_URI:append:srg-imx8pl-2g = " ${EXTRA_KERNEL_PATCHES}"
SRC_URI:append:ucom-imx8p-4g = " ${EXTRA_KERNEL_PATCHES}"
SRC_URI:append:ucom-imx8p-2g = " ${EXTRA_KERNEL_PATCHES}"