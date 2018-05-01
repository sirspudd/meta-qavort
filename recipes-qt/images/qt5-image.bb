# Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd
# Released under the MIT license (see COPYING.MIT for the terms)

IMAGE_FEATURES += "\
    package-management \
	splash	\
"

LICENSE = "MIT"

inherit core-image

TASK_INSTALL = " \
    96boards-tools \
    dvfs-rules \
"

RF_INSTALL = " \
    brcm-patchram-plus \
    firmware-rk-wifi \
    firmware-rk-bt \
"

CORE_IMAGE_EXTRA_INSTALL += " \
    io \
    ${TASK_INSTALL} \
    ${RF_INSTALL} \
"

do_rootfs[depends] += "virtual/kernel:do_populate_sysroot"

COMMON_INSTALL = " \
	qtbase	\
	qtdeclarative \
	qtwayland \
"

IMAGE_INSTALL += " \
    openssh-sshd \
    openssh \
	${COMMON_INSTALL} \
	autostart \
	packagegroup-fonts-truetype \
"
