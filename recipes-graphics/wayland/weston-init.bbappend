FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append() {
    echo "\n[output]\nname=HDMI-A-1\nmode=1280x720@60\n\n[output]\nname=LVDS-1\nsame-as=HDMI-A-1" >> ${D}${sysconfdir}/xdg/weston/weston.ini
}