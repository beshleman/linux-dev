#!/bin/bash
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"
#git="git am --whitespace=fix"

if [ -f ${DIR}/system.sh ] ; then
	source ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

am33x () {
	echo "dir: dma"
	${git} "${DIR}/patches/dma/0001-Without-MACH_-option-Early-printk-DEBUG_LL.patch"
	${git} "${DIR}/patches/dma/0002-ARM-OMAP-Hack-AM33xx-clock-data-to-allow-JTAG-use.patch"
	${git} "${DIR}/patches/dma/0003-fb-Rework-locking-to-fix-lock-ordering-on-takeover.patch"
	${git} "${DIR}/patches/dma/0004-video-st7735fb-add-st7735-framebuffer-driver.patch"
	${git} "${DIR}/patches/dma/0005-mfd-tps65910-Select-REGMAP_IRQ-in-Kconfig-to-fix-bui.patch"
	${git} "${DIR}/patches/dma/0006-dmaengine-add-helper-function-to-request-a-slave-DMA.patch"
	${git} "${DIR}/patches/dma/0007-of-Add-generic-device-tree-DMA-helpers.patch"
	${git} "${DIR}/patches/dma/0008-of-dma-fix-build-break-for-CONFIG_OF.patch"
	${git} "${DIR}/patches/dma/0009-of-dma-fix-typos-in-generic-dma-binding-definition.patch"
	${git} "${DIR}/patches/dma/0010-dmaengine-fix-build-failure-due-to-missing-semi-colo.patch"
	${git} "${DIR}/patches/dma/0011-dmaengine-edma-fix-slave-config-dependency-on-direct.patch"
	${git} "${DIR}/patches/dma/0012-dmaengine-add-dma_get_channel_caps.patch"
	${git} "${DIR}/patches/dma/0013-dma-edma-add-device_channel_caps-support.patch"
	${git} "${DIR}/patches/dma/0014-mmc-davinci-get-SG-segment-limits-with-dma_get_chann.patch"
	${git} "${DIR}/patches/dma/0015-ARM-davinci-move-private-EDMA-API-to-arm-common.patch"
	${git} "${DIR}/patches/dma/0016-ARM-edma-remove-unused-transfer-controller-handlers.patch"
	${git} "${DIR}/patches/dma/0017-ARM-edma-add-AM33XX-support-to-the-private-EDMA-API.patch"
	${git} "${DIR}/patches/dma/0018-dmaengine-edma-enable-build-for-AM33XX.patch"
	${git} "${DIR}/patches/dma/0019-dmaengine-edma-Add-TI-EDMA-device-tree-binding.patch"
	${git} "${DIR}/patches/dma/0020-ARM-dts-add-AM33XX-EDMA-support.patch"
	${git} "${DIR}/patches/dma/0021-dmaengine-add-dma_request_slave_channel_compat.patch"
	${git} "${DIR}/patches/dma/0022-mmc-omap_hsmmc-convert-to-dma_request_slave_channel_.patch"
	${git} "${DIR}/patches/dma/0023-mmc-omap_hsmmc-set-max_segs-based-on-dma-engine-limi.patch"
	${git} "${DIR}/patches/dma/0024-mmc-omap_hsmmc-add-generic-DMA-request-support-to-th.patch"
	${git} "${DIR}/patches/dma/0025-ARM-dts-add-AM33XX-MMC-support.patch"
	${git} "${DIR}/patches/dma/0026-spi-omap2-mcspi-convert-to-dma_request_slave_channel.patch"
	${git} "${DIR}/patches/dma/0027-spi-omap2-mcspi-add-generic-DMA-request-support-to-t.patch"
	${git} "${DIR}/patches/dma/0028-ARM-dts-add-AM33XX-SPI-DMA-support.patch"
	${git} "${DIR}/patches/dma/0029-ARM-dts-Add-SPI-Flash-support-to-am335x-evm.patch"
	${git} "${DIR}/patches/dma/0030-Documentation-bindings-add-spansion.patch"
	${git} "${DIR}/patches/dma/0031-ARM-dts-enable-spi1-node-and-pinmux-on-BeagleBone.patch"
	${git} "${DIR}/patches/dma/0032-ARM-dts-add-BeagleBone-Adafruit-1.8-LCD-support.patch"
	${git} "${DIR}/patches/dma/0033-misc-add-gpevt-driver.patch"
	${git} "${DIR}/patches/dma/0034-ARM-dts-add-BeagleBone-gpevt-support.patch"
	${git} "${DIR}/patches/dma/0035-ARM-configs-working-dmaengine-configs-for-da8xx-and-.patch"
	${git} "${DIR}/patches/dma/0036-ARM-dts-Add-UART4-support-to-BeagleBone.patch"

	echo "dir: rtc"
	${git} "${DIR}/patches/rtc/0001-rtc-OMAP-Add-system-pm_power_off-to-rtc-driver.patch"
	${git} "${DIR}/patches/rtc/0002-ARM-dts-AM33XX-Set-pmic-shutdown-controller-for-Beag.patch"
	${git} "${DIR}/patches/rtc/0003-ARM-dts-AM33XX-Enable-system-power-off-control-in-am.patch"

	echo "dir: pinctrl"
	${git} "${DIR}/patches/pinctrl/0001-i2c-pinctrl-ify-i2c-omap.c.patch"
	${git} "${DIR}/patches/pinctrl/0002-arm-dts-AM33XX-Configure-pinmuxs-for-user-leds-contr.patch"
	${git} "${DIR}/patches/pinctrl/0003-beaglebone-DT-set-default-triggers-for-LEDS.patch"
	${git} "${DIR}/patches/pinctrl/0004-beaglebone-add-a-cpu-led-trigger.patch"

	echo "dir: cpufreq"
	${git} "${DIR}/patches/cpufreq/0001-am33xx-DT-add-commented-out-OPP-values-for-ES2.0.patch"

	echo "dir: adc"
	${git} "${DIR}/patches/adc/0001-input-ti_am335x_tsc-Make-steps-enable-configurable.patch"
	${git} "${DIR}/patches/adc/0002-input-ti_am335x_tsc-Order-of-TSC-wires-connect-made-.patch"
	${git} "${DIR}/patches/adc/0003-input-ti_am335x_tsc-Add-variance-filters.patch"
	${git} "${DIR}/patches/adc/0004-ti_tscadc-Update-with-IIO-map-interface-deal-with-pa.patch"
	${git} "${DIR}/patches/adc/0005-ti_tscadc-Match-mfd-sub-devices-to-regmap-interface.patch"

	echo "dir: pwm"
	${git} "${DIR}/patches/pwm/0001-ARM-OMAP3-hwmod-Corrects-resource-data-for-PWM-devic.patch"
	${git} "${DIR}/patches/pwm/0002-pwm_backlight-Add-device-tree-support-for-Low-Thresh.patch"
	${git} "${DIR}/patches/pwm/0003-Control-module-EHRPWM-clk-enabling.patch"
	${git} "${DIR}/patches/pwm/0004-pwm-pwm_test-Driver-support-for-PWM-module-testing.patch"
	${git} "${DIR}/patches/pwm/0005-ARM-OMAP2-PWM-limit-am33xx_register_ehrpwm-to-soc_is.patch"
	${git} "${DIR}/patches/pwm/0006-pwm-export-of_pwm_request.patch"

	echo "dir: i2c"
	${git} "${DIR}/patches/i2c/0001-pinctrl-pinctrl-single-must-be-initialized-early.patch"
	${git} "${DIR}/patches/i2c/0002-Bone-DTS-working-i2c2-i2c3-in-the-tree.patch"
	${git} "${DIR}/patches/i2c/0003-am33xx-Convert-I2C-from-omap-to-am33xx-names.patch"
	${git} "${DIR}/patches/i2c/0004-am335x-evm-hack-around-i2c-node-names.patch"

	echo "dir: da8xx-fb"
	${git} "${DIR}/patches/da8xx-fb/0001-da8xx-Allow-use-by-am33xx-based-devices.patch"
	${git} "${DIR}/patches/da8xx-fb/0002-da8xx-De-constify-members-in-the-platform-config.patch"
	${git} "${DIR}/patches/da8xx-fb/0003-da8xx-Add-standard-panel-definition.patch"
	${git} "${DIR}/patches/da8xx-fb/0004-da8xx-Add-CDTech_S035Q01-panel-used-by-LCD3-bone-cap.patch"
	${git} "${DIR}/patches/da8xx-fb/0005-da8xx-fb-add-panel-definition-for-beaglebone-LCD7-ca.patch"
	${git} "${DIR}/patches/da8xx-fb/0006-video-da8xx-fb-fb_check_var-enhancement.patch"
	${git} "${DIR}/patches/da8xx-fb/0007-Update-to-latest-PSP-kernel-changes.patch"

	echo "dir: mmc"
	${git} "${DIR}/patches/mmc/0001-am33xx.dtsi-enable-MMC-HSPE-bit-for-all-3-controller.patch"
	${git} "${DIR}/patches/mmc/0002-omap-hsmmc-Correct-usage-of-of_find_node_by_name.patch"

	echo "dir: crypto"
	${git} "${DIR}/patches/crypto/0001-ARM-OMAP2xxx-hwmod-Convert-SHAM-crypto-device-data-t.patch"
	${git} "${DIR}/patches/crypto/0002-ARM-OMAP2xxx-hwmod-Add-DMA-support-for-SHAM-module.patch"
	${git} "${DIR}/patches/crypto/0003-ARM-OMAP3xxx-hwmod-Convert-SHAM-crypto-device-data-t.patch"
	${git} "${DIR}/patches/crypto/0004-ARM-OMAP2-Remove-unnecessary-message-when-no-SHA-IP-.patch"
	${git} "${DIR}/patches/crypto/0005-ARM-OMAP2-Only-manually-add-hwmod-data-when-DT-not-u.patch"
	${git} "${DIR}/patches/crypto/0006-ARM-AM33XX-Add-sha0-crypto-clock-data.patch"
	${git} "${DIR}/patches/crypto/0007-ARM-AM33XX-hwmod-Update-and-uncomment-SHA0-module-da.patch"
	${git} "${DIR}/patches/crypto/0008-ARM-dts-Add-SHAM-data-and-documentation-for-AM33XX.patch"
	${git} "${DIR}/patches/crypto/0009-ARM-OMAP2xxx-hwmod-Convert-AES-crypto-devcie-data-to.patch"
	${git} "${DIR}/patches/crypto/0010-ARM-OMAP3xxx-hwmod-Convert-AES-crypto-device-data-to.patch"
	${git} "${DIR}/patches/crypto/0011-ARM-OMAP2-Remove-unnecessary-message-when-no-AES-IP-.patch"
	${git} "${DIR}/patches/crypto/0012-ARM-OMAP2-Only-manually-add-hwmod-data-when-DT-not-u.patch"
	${git} "${DIR}/patches/crypto/0013-ARM-AM33XX-Add-aes0-crypto-clock-data.patch"
	${git} "${DIR}/patches/crypto/0014-ARM-AM33XX-hwmod-Update-and-uncomment-AES0-module-da.patch"
	${git} "${DIR}/patches/crypto/0015-ARM-dts-Add-AES-data-and-documentation-for-AM33XX.patch"
	${git} "${DIR}/patches/crypto/0016-crypto-omap-sham-Remove-unnecessary-pr_info-noise.patch"
	${git} "${DIR}/patches/crypto/0017-crypto-omap-sham-Convert-to-use-pm_runtime-API.patch"
	${git} "${DIR}/patches/crypto/0018-crypto-omap-sham-Add-suspend-resume-support.patch"
	${git} "${DIR}/patches/crypto/0019-crypto-omap-sham-Add-code-to-use-dmaengine-API.patch"
	${git} "${DIR}/patches/crypto/0020-crypto-omap-sham-Remove-usage-of-private-DMA-API.patch"
	${git} "${DIR}/patches/crypto/0021-crypto-omap-sham-Add-Device-Tree-Support.patch"
	${git} "${DIR}/patches/crypto/0022-crypto-omap-sham-Convert-to-dma_request_slave_channe.patch"
	${git} "${DIR}/patches/crypto/0023-crypto-omap-sham-Add-OMAP4-AM33XX-SHAM-Support.patch"
	${git} "${DIR}/patches/crypto/0024-crypto-omap-sham-Add-SHA224-and-SHA256-Support.patch"
	${git} "${DIR}/patches/crypto/0025-crypto-omap-aes-Remmove-unnecessary-pr_info-noise.patch"
	${git} "${DIR}/patches/crypto/0026-crypto-omap-aes-Don-t-reset-controller-for-every-ope.patch"
	${git} "${DIR}/patches/crypto/0027-crypto-omap-aes-Convert-to-use-pm_runtime-API.patch"
	${git} "${DIR}/patches/crypto/0028-crypto-omap-aes-Add-suspend-resume-support.patch"
	${git} "${DIR}/patches/crypto/0029-crypto-omap-aes-Add-code-to-use-dmaengine-API.patch"
	${git} "${DIR}/patches/crypto/0030-crypto-omap-aes-Remove-usage-of-private-DMA-API.patch"
	${git} "${DIR}/patches/crypto/0031-crypto-omap-aes-Add-Device-Tree-Support.patch"
	${git} "${DIR}/patches/crypto/0032-crypto-omap-aes-Convert-to-dma_request_slave_channel.patch"
	${git} "${DIR}/patches/crypto/0033-crypto-omap-aes-Add-OMAP4-AM33XX-AES-Support.patch"
	${git} "${DIR}/patches/crypto/0034-crypto-omap-aes-Add-CTR-algorithm-Support.patch"

	echo "dir: 6lowpan"
	${git} "${DIR}/patches/6lowpan/0001-6lowpan-lowpan_is_iid_16_bit_compressable-does-not-d.patch"
	${git} "${DIR}/patches/6lowpan/0002-6lowpan-next-header-is-not-properly-set-upon-decompr.patch"
	${git} "${DIR}/patches/6lowpan/0003-6lowpan-always-enable-link-layer-acknowledgments.patch"
	${git} "${DIR}/patches/6lowpan/0004-mac802154-turn-on-ACK-when-enabled-by-the-upper-laye.patch"
	${git} "${DIR}/patches/6lowpan/0005-6lowpan-use-short-IEEE-802.15.4-addresses-for-broadc.patch"
	${git} "${DIR}/patches/6lowpan/0006-6lowpan-fix-first-fragment-FRAG1-handling.patch"
	${git} "${DIR}/patches/6lowpan/0007-6lowpan-store-fragment-tag-values-per-device-instead.patch"
	${git} "${DIR}/patches/6lowpan/0008-6lowpan-obtain-IEEE802.15.4-sequence-number-from-the.patch"
	${git} "${DIR}/patches/6lowpan/0009-6lowpan-add-a-new-parameter-in-sysfs-to-turn-on-off-.patch"
	${git} "${DIR}/patches/6lowpan/0010-6lowpan-use-the-PANID-provided-by-the-device-instead.patch"
	${git} "${DIR}/patches/6lowpan/0011-6lowpan-modify-udp-compression-uncompression-to-matc.patch"
	${git} "${DIR}/patches/6lowpan/0012-6lowpan-make-memory-allocation-atomic-during-6lowpan.patch"
	${git} "${DIR}/patches/6lowpan/0013-mac802154-make-mem-alloc-ATOMIC-to-prevent-schedulin.patch"
	${git} "${DIR}/patches/6lowpan/0014-mac802154-remove-unnecessary-spinlocks.patch"
	${git} "${DIR}/patches/6lowpan/0015-mac802154-re-introduce-MAC-primitives-required-to-se.patch"
	${git} "${DIR}/patches/6lowpan/0016-serial-initial-import-of-the-IEEE-802.15.4-serial-dr.patch"

	echo "dir: capebus"
	${git} "${DIR}/patches/capebus/0001-gpio-keys-Pinctrl-fy.patch"
	${git} "${DIR}/patches/capebus/0002-tps65217-Allow-placement-elsewhere-than-parent-mfd-d.patch"
	${git} "${DIR}/patches/capebus/0003-pwm-backlight-Pinctrl-fy.patch"
	${git} "${DIR}/patches/capebus/0004-ARM-CUSTOM-Build-a-uImage-with-dtb-already-appended.patch"
	${git} "${DIR}/patches/capebus/0005-beaglebone-create-a-shared-dtsi-for-beaglebone-based.patch"
	${git} "${DIR}/patches/capebus/0006-beaglebone-enable-emmc-for-bonelt.patch"
	${git} "${DIR}/patches/capebus/0007-Fix-appended-dtb-rule.patch"
}

arm () {
	echo "dir: arm"
	${git} "${DIR}/patches/arm/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"

	#Status: v2 Review:
	#http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/112440.html
	${git} "${DIR}/patches/arm/0002-arm-add-definition-of-strstr-to-decompress.c.patch"
	${git} "${DIR}/patches/arm/0003-Without-MACH_-option-Early-printk-DEBUG_LL.patch"
}

omap () {
	echo "dir: omap"
	#Fixes 800Mhz boot lockup: http://www.spinics.net/lists/linux-omap/msg83737.html
	${git} "${DIR}/patches/omap/0001-regulator-core-if-voltage-scaling-fails-restore-orig.patch"
	${git} "${DIR}/patches/omap/0002-omap2-twl-common-Add-default-power-configuration.patch"

	echo "dir: omap/sakoman"
	${git} "${DIR}/patches/omap_sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo.patch"
	${git} "${DIR}/patches/omap_sakoman/0002-video-add-timings-for-hd720.patch"

	echo "dir: omap/beagle/expansion"
	${git} "${DIR}/patches/omap_beagle_expansion/0001-Beagle-expansion-add-buddy-param-for-expansionboard-.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0002-Beagle-expansion-add-zippy.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0003-Beagle-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0004-Beagle-expansion-add-trainer.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0005-Beagle-expansion-add-CircuitCo-ulcd-Support.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0006-Beagle-expansion-add-wifi.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0007-Beagle-expansion-add-beaglefpga.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0008-Beagle-expansion-add-spidev.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0009-Beagle-expansion-add-Aptina-li5m03-camera.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0010-Beagle-expansion-add-LSR-COM6L-Adapter-Board.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0011-Beagle-expansion-LSR-COM6L-Adapter-Board-also-initia.patch"

	echo "dir: omap/beagle"
	#Status: for meego guys..
	${git} "${DIR}/patches/omap_beagle/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"

	${git} "${DIR}/patches/omap_beagle/0002-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/omap_beagle/0003-tlc59108-adjust-for-beagleboard-uLCD7.patch"

	#Status: not for upstream
	${git} "${DIR}/patches/omap_beagle/0004-zeroMAP-Open-your-eyes.patch"

	${git} "${DIR}/patches/omap_beagle/0005-ARM-OMAP-Beagle-use-TWL4030-generic-reset-script.patch"

	echo "dir: omap/panda"
	#Status: not for upstream: push device tree version upstream...
	${git} "${DIR}/patches/omap_panda/0001-panda-fix-wl12xx-regulator.patch"
	#Status: unknown: cherry picked from linaro
	${git} "${DIR}/patches/omap_panda/0002-ti-st-st-kim-fixing-firmware-path.patch"
}

am33x_after () {
	echo "dir: net"
	${git} "${DIR}/patches/net/0001-am33xx-cpsw-default-to-ethernet-hwaddr-from-efuse-if.patch"
	${git} "${DIR}/patches/net/0002-Attempted-SMC911x-BQL-patch.patch"
	${git} "${DIR}/patches/net/0003-cpsw-Fix-interrupt-storm-among-other-things.patch"

	echo "dir: not-capebus"
	${git} "${DIR}/patches/not-capebus/0001-drm-cma-add-debugfs-helpers.patch"
	${git} "${DIR}/patches/not-capebus/0002-drm-small-fix-in-drm_send_vblank_event.patch"
	${git} "${DIR}/patches/not-capebus/0003-add-dvi-pinmuxes-to-am33xx.dtsi.patch"
	${git} "${DIR}/patches/not-capebus/0004-add-defconfig-file-to-use-as-.config.patch"
	${git} "${DIR}/patches/not-capebus/0005-am33xx-musb-Add-OF-definitions.patch"
	${git} "${DIR}/patches/not-capebus/0006-Mark-the-device-as-PRIVATE.patch"
	${git} "${DIR}/patches/not-capebus/0007-omap_hsmmc-Bug-fixes-pinctl-gpio-reset.patch"
	${git} "${DIR}/patches/not-capebus/0008-tps65217-bl-Locate-backlight-node-correctly.patch"
	${git} "${DIR}/patches/not-capebus/0009-arm-Export-cache-flush-management-symbols-when-MULTI.patch"
	${git} "${DIR}/patches/not-capebus/0010-am335x-bone-dtsi-Clean-up.patch"
	${git} "${DIR}/patches/not-capebus/0011-am335x-bone-dtsi-Introduce-new-I2C-entries.patch"
	${git} "${DIR}/patches/not-capebus/0012-am335x-dt-Add-I2C0-pinctrl-entries.patch"
	${git} "${DIR}/patches/not-capebus/0013-omap3beagle-compile-fix.patch"
	${git} "${DIR}/patches/not-capebus/0014-Cleanup-am33xx.dtsi.patch"
	${git} "${DIR}/patches/not-capebus/0015-Fix-platform-device-resource-linking.patch"
	${git} "${DIR}/patches/not-capebus/0016-Link-platform-device-resources-properly.patch"
	${git} "${DIR}/patches/not-capebus/0017-Properly-handle-resources-for-omap_devices.patch"
	${git} "${DIR}/patches/not-capebus/0018-omap-DT-node-Timer-iteration-fix.patch"
	${git} "${DIR}/patches/not-capebus/0019-omap-Avoid-crashes-in-the-case-of-hwmod-misconfigura.patch"
	${git} "${DIR}/patches/not-capebus/0020-i2c-EEPROM-In-kernel-memory-accessor-interface.patch"
	${git} "${DIR}/patches/not-capebus/0021-Fix-util_is_printable_string.patch"
	${git} "${DIR}/patches/not-capebus/0022-fdtdump-properly-handle-multi-string-properties.patch"
	${git} "${DIR}/patches/not-capebus/0023-dtc-Dynamic-symbols-fixup-support.patch"
	${git} "${DIR}/patches/not-capebus/0024-dtc-Add-DTCO-rule-for-DTB-objects.patch"
	${git} "${DIR}/patches/not-capebus/0025-OF-Compile-Device-Tree-sources-with-resolve-option.patch"
	${git} "${DIR}/patches/not-capebus/0026-firmware-update-.gitignore-with-dtbo-objects.patch"
	${git} "${DIR}/patches/not-capebus/0027-OF-Introduce-device-tree-node-flag-helpers.patch"
	${git} "${DIR}/patches/not-capebus/0028-OF-export-of_property_notify.patch"
	${git} "${DIR}/patches/not-capebus/0029-OF-Export-all-DT-proc-update-functions.patch"
	${git} "${DIR}/patches/not-capebus/0030-OF-Introduce-utility-helper-functions.patch"
	${git} "${DIR}/patches/not-capebus/0031-OF-Introduce-Device-Tree-resolve-support.patch"
	${git} "${DIR}/patches/not-capebus/0032-OF-Introduce-DT-overlay-support.patch"
	${git} "${DIR}/patches/not-capebus/0033-capemgr-Capemgr-makefiles-and-Kconfig-fragments.patch"
	${git} "${DIR}/patches/not-capebus/0034-capemgr-Beaglebone-capemanager.patch"
	${git} "${DIR}/patches/not-capebus/0035-capemgr-Add-beaglebone-s-cape-driver-bindings.patch"
	${git} "${DIR}/patches/not-capebus/0036-capemgr-am33xx-family-DT-bindings.patch"
	${git} "${DIR}/patches/not-capebus/0037-bone-geiger-Geiger-bone-driver.patch"
	${git} "${DIR}/patches/not-capebus/0038-capemgr-firmware-makefiles-for-DT-objects.patch"
	${git} "${DIR}/patches/not-capebus/0039-capemgr-emmc2-cape-definition.patch"
	${git} "${DIR}/patches/not-capebus/0040-capemgr-DVI-capes-definitions.patch"
	${git} "${DIR}/patches/not-capebus/0041-capemgr-Geiger-cape-definition.patch"
	${git} "${DIR}/patches/not-capebus/0042-capemgr-LCD3-cape-definition.patch"
	${git} "${DIR}/patches/not-capebus/0043-capemgr-Add-weather-cape-definition.patch"
	${git} "${DIR}/patches/not-capebus/0044-drm-tilcdc-add-TI-LCD-Controller-DRM-driver-v3.patch"
	${git} "${DIR}/patches/not-capebus/0045-RFC-drm-tilcdc-add-support-for-LCD-panels-v3.patch"
	${git} "${DIR}/patches/not-capebus/0046-drm-i2c-encoder-helper-wrappers.patch"
	${git} "${DIR}/patches/not-capebus/0047-drm-i2c-nxp-tda998x-v2.patch"
	${git} "${DIR}/patches/not-capebus/0048-RFC-drm-tilcdc-add-encoder-slave.patch"
	${git} "${DIR}/patches/not-capebus/0049-of-add-helper-to-parse-display-timings.patch"
	${git} "${DIR}/patches/not-capebus/0050-video-add-display_timing-struct-and-helpers.patch"
	${git} "${DIR}/patches/not-capebus/0051-OF-display-timings-helper-convert-to-get-child-node.patch"
	${git} "${DIR}/patches/not-capebus/0052-am33xx-Add-clock-for-the-lcdc-DRM-driver.patch"
	${git} "${DIR}/patches/not-capebus/0053-lcd3-cape-Change-into-using-the-lcdc-DRM-driver-inst.patch"
	${git} "${DIR}/patches/not-capebus/0054-ehrpwm-add-missing-dts-nodes.patch"
	${git} "${DIR}/patches/not-capebus/0055-ARM-am33xx-Fix-the-PWM-clocks-mess.patch"
	${git} "${DIR}/patches/not-capebus/0056-am33xx-DT-Update-am33xx.dsi-with-the-new-PWM-DT-bind.patch"
	${git} "${DIR}/patches/not-capebus/0057-geiger-cape-Update-to-using-the-new-PWM-interface.patch"
	${git} "${DIR}/patches/not-capebus/0058-am33xx-Add-default-config.patch"
	${git} "${DIR}/patches/not-capebus/0059-am33xx_tsc_adc-DTify-all-the-drivers.patch"
	${git} "${DIR}/patches/not-capebus/0060-lcd3-cape-Convert-to-using-the-proper-touchscreen-dr.patch"
	${git} "${DIR}/patches/not-capebus/0061-geiger-cape-Convert-to-using-the-new-ADC-driver.patch"
	${git} "${DIR}/patches/not-capebus/0062-drm-lcdc-Power-control-GPIO-support.patch"
	${git} "${DIR}/patches/not-capebus/0063-cape-dvi-Convert-DVI-capes-to-the-new-LCDC-DRM-drive.patch"
	${git} "${DIR}/patches/not-capebus/0064-omap-Don-t-bother-with-freqsel-on-am33xx.patch"
	${git} "${DIR}/patches/not-capebus/0065-boneblack-Add-default-HDMI-cape.patch"
	${git} "${DIR}/patches/not-capebus/0066-cape-bone-dvi-Use-720p-mode-as-default.patch"
	${git} "${DIR}/patches/not-capebus/0067-am33xx.dtsi-Make-the-MUSB-not-crash-on-load.patch"
	${git} "${DIR}/patches/not-capebus/0068-regulator-DUMMY_REGULATOR-should-work-for-OF-too.patch"
	${git} "${DIR}/patches/not-capebus/0069-OF-Overlay-Remove-excessive-debugging-crud.patch"
	${git} "${DIR}/patches/not-capebus/0070-of-i2c-Export-single-device-registration-method.patch"
	${git} "${DIR}/patches/not-capebus/0071-OF-Overlay-I2C-client-devices-special-handling.patch"
	${git} "${DIR}/patches/not-capebus/0072-omap-Fix-bug-on-partial-resource-addition.patch"
	${git} "${DIR}/patches/not-capebus/0073-ASoC-davinci-mcasp-Add-pinctrl-support.patch"
	${git} "${DIR}/patches/not-capebus/0074-ASoC-Davinci-machine-Add-device-tree-binding.patch"
	${git} "${DIR}/patches/not-capebus/0075-am33xx-Add-mcasp0-and-mcasp1-device-tree-entries.patch"
	${git} "${DIR}/patches/not-capebus/0076-ASoC-dts-OMAP2-AM33xx-HACK-Add-missing-dma-info.patch"
	${git} "${DIR}/patches/not-capebus/0077-ASoC-Davinci-McASP-remove-unused-header-include.patch"
	${git} "${DIR}/patches/not-capebus/0078-ASoC-AM33XX-Add-support-for-AM33xx-SoC-Audio.patch"
	${git} "${DIR}/patches/not-capebus/0079-am33xx-mcasp-Add-dma-channel-definitions.patch"
	${git} "${DIR}/patches/not-capebus/0080-ARM-OMAP2-AM33xx-removed-invalid-McASP-HWMOD-data.patch"
	${git} "${DIR}/patches/not-capebus/0081-davinci-evm-Header-include-move-fix.patch"
	${git} "${DIR}/patches/not-capebus/0082-bone-dvi-cape-Add-DT-definition-for-00A2-revision.patch"
	${git} "${DIR}/patches/not-capebus/0083-bone-dvi-cape-Update-A1-cape-definition-with-sound.patch"
	${git} "${DIR}/patches/not-capebus/0084-sndsoc-mcasp-Get-DMA-channels-via-byname.patch"
	${git} "${DIR}/patches/not-capebus/0085-drm-tilcdc-Remove-__devinit-__devexit.patch"
	${git} "${DIR}/patches/not-capebus/0086-sound-soc-Davinci-Remove-__devinit-__devexit.patch"
	${git} "${DIR}/patches/not-capebus/0087-st7735fb-Remove-__devinit-__devexit.patch"
	${git} "${DIR}/patches/not-capebus/0088-capemgr-Remove-__devinit-__devexit.patch"
	${git} "${DIR}/patches/not-capebus/0089-capes-fw-target-firmware-directory-change.patch"
	${git} "${DIR}/patches/not-capebus/0090-am33xx-edma-Always-update-unused-channel-list.patch"
	${git} "${DIR}/patches/not-capebus/0091-defconfig-Update-bone-default-config.patch"
	${git} "${DIR}/patches/not-capebus/0092-capes-add-dvi-a2-and-lcd3-a2-dts-files.patch"
	${git} "${DIR}/patches/not-capebus/0093-capemgr-catch-up-with-lcdc-tilcdc-rename.patch"
	${git} "${DIR}/patches/not-capebus/0094-firmware-fix-dvi-a1-target.patch"
	${git} "${DIR}/patches/not-capebus/0095-capes-remove-tda-from-hdmi-cape-lcdc-handles-it-by-t.patch"
	${git} "${DIR}/patches/not-capebus/0096-tilcdc-magic-debug-statement-makes-power-gpio-work-o.patch"
	${git} "${DIR}/patches/not-capebus/0097-capemgr-add-dts-overlay-for-LCD7-00A2-cape.patch"
	${git} "${DIR}/patches/not-capebus/0098-HACK-am33xx.dtsi-enable-all-PWMs.patch"
	${git} "${DIR}/patches/not-capebus/0099-drm-merge-fix.patch"
	${git} "${DIR}/patches/not-capebus/0100-beaglebone-Add-nixie-cape-prototype-driver.patch"
	${git} "${DIR}/patches/not-capebus/0101-beaglebone-Add-nixie-cape-device-tree-entry.patch"
	${git} "${DIR}/patches/not-capebus/0102-am335x-bone-common.dtsi-Cleanup-test-remnants.patch"
	${git} "${DIR}/patches/not-capebus/0103-omap_hsmmc-Add-ti-vcc-aux-disable-is-sleep-DT-proper.patch"
	${git} "${DIR}/patches/not-capebus/0104-bone-common-ti-vcc-aux-disable-is-sleep-enable.patch"

	echo "dir: pru"
	${git} "${DIR}/patches/pru/0001-uio-uio_pruss-port-to-AM33xx.patch"
	${git} "${DIR}/patches/pru/0002-ARM-omap-add-DT-support-for-deasserting-hardware-res.patch"
	${git} "${DIR}/patches/pru/0003-ARM-dts-AM33xx-PRUSS-support.patch"

	echo "dir: iio"
	${git} "${DIR}/patches/iio/0001-staging-iio-add-lsm303dlh-magnetometer-driver.patch"
	${git} "${DIR}/patches/iio/0002-staging-iio-update-lsm303dlh-to-new-IIO-API.patch"

	echo "dir: pm"
	${git} "${DIR}/patches/pm/0001-mailbox-OMAP-introduce-mailbox-framework.patch"
	${git} "${DIR}/patches/pm/0002-mailbox-split-internal-header-from-API-header.patch"
	${git} "${DIR}/patches/pm/0003-mailbox-rename-omap_mbox-in-mailbox.patch"
	${git} "${DIR}/patches/pm/0004-mailbox-create-opened-message-type.patch"
	${git} "${DIR}/patches/pm/0005-mailbox-change-protection-mechanisms.patch"
	${git} "${DIR}/patches/pm/0006-mailbox-add-shared-memory-mailbox-type.patch"
	${git} "${DIR}/patches/pm/0007-mailbox-add-IRQF_NO_SUSPEND-flag.patch"
	${git} "${DIR}/patches/pm/0008-mailbox-add-no_irq-send-message.patch"
	${git} "${DIR}/patches/pm/0009-mailbox-create-dbx500-mailbox-driver.patch"
	${git} "${DIR}/patches/pm/0010-mailbox-replace-plat-cpu.h-with-corresponding-soc.h.patch"
	${git} "${DIR}/patches/pm/0011-mailbox-OMAP2-Add-support-for-AM33XX.patch"
	${git} "${DIR}/patches/pm/0012-mailbox-Add-an-API-for-flushing-the-FIFO.patch"
	${git} "${DIR}/patches/pm/0013-ARM-OMAP2xxx-powerdomain-core-powerdomain-missing-lo.patch"
	${git} "${DIR}/patches/pm/0014-ARM-OMAP3xxx-CPUIdle-simplify-the-PER-next-state-cod.patch"
	${git} "${DIR}/patches/pm/0015-ARM-OMAP3xxx-CPUIdle-optimize-__omap3_enter_idle.patch"
	${git} "${DIR}/patches/pm/0016-ARM-OMAP4-MPUSS-PM-remove-unnecessary-shim-functions.patch"
	${git} "${DIR}/patches/pm/0017-ARM-OMAP2-powerdomain-fix-powerdomain-trace-integrat.patch"
	${git} "${DIR}/patches/pm/0018-ARM-OMAP3-4-cpuidle-fix-sparse-and-checkpatch-warnin.patch"
	${git} "${DIR}/patches/pm/0019-ARM-OMAP2-clockdomain-add-pwrdm_state_switch-call-to.patch"
	${git} "${DIR}/patches/pm/0020-ARM-OMAP2xxx-PM-clean-up-some-crufty-powerstate-prog.patch"
	${git} "${DIR}/patches/pm/0021-ARM-OMAP2-PM-powerdomain-drop-unnecessary-pwrdm_wait.patch"
	${git} "${DIR}/patches/pm/0022-ARM-OMAP2-PM-powerdomain-move-omap_set_pwrdm_state-t.patch"
	${git} "${DIR}/patches/pm/0023-ARM-OMAP2-powerdomain-clockdomain-add-a-per-powerdom.patch"
	${git} "${DIR}/patches/pm/0024-ARM-OMAP2xxx-CM-remove-autodep-handling.patch"
	${git} "${DIR}/patches/pm/0025-ARM-OMAP2-clockdomain-work-on-wkdep-sleepdep-functio.patch"
	${git} "${DIR}/patches/pm/0026-ARM-OMAP2-clockdomain-convert-existing-atomic-usecou.patch"
	${git} "${DIR}/patches/pm/0027-ARM-OMAP2-powerdomain-fix-whitespace-improve-flag-co.patch"
	${git} "${DIR}/patches/pm/0028-ARM-OMAP2-powerdomain-add-functions-that-report-on-p.patch"
	${git} "${DIR}/patches/pm/0029-ARM-OMAP2-PM-introduce-power-domains-functional-stat.patch"
	${git} "${DIR}/patches/pm/0030-ARM-OMAP2-PM-debug-trace-the-functional-power-domain.patch"
	${git} "${DIR}/patches/pm/0031-ARM-OMAP2xxx-PM-convert-to-use-the-functional-power-.patch"
	${git} "${DIR}/patches/pm/0032-ARM-OMAP3xxx-PM-convert-to-use-the-functional-power-.patch"
	${git} "${DIR}/patches/pm/0033-ARM-OMAP44xx-PM-convert-to-use-the-functional-power-.patch"
	${git} "${DIR}/patches/pm/0034-ARM-OMAP2-PM-use-power-domain-functional-state-in-st.patch"
	${git} "${DIR}/patches/pm/0035-ARM-OMAP2-powerdomain-drop-many-low-level-powerdomai.patch"
	${git} "${DIR}/patches/pm/0036-ARM-OMAP2-powerdomain-add-ability-to-test-for-suppor.patch"
	${git} "${DIR}/patches/pm/0037-ARM-OMAP2-powerdomain-PM-only-program-supported-powe.patch"
	${git} "${DIR}/patches/pm/0038-ARM-OMAP2-powerdomain-program-memory-bank-next-power.patch"
	${git} "${DIR}/patches/pm/0039-ARM-OMAP2-powerdomain-assume-memory-bank-power-state.patch"
	${git} "${DIR}/patches/pm/0040-ARM-OMAP2-powerdomain-consolidate-arch_pwrdm-check-c.patch"
	${git} "${DIR}/patches/pm/0041-ARM-OMAP2-PM-powerdomain-move-the-power-state-time-t.patch"
	${git} "${DIR}/patches/pm/0042-ARM-OMAP2-powerdomain-split-pwrdm_state_switch.patch"
	${git} "${DIR}/patches/pm/0043-ARM-OMAP2-PM-clean-up-some-debugfs-functions.patch"
	${git} "${DIR}/patches/pm/0044-ARM-OMAP2-powerdomain-remove-some-redundant-checks-a.patch"
	${git} "${DIR}/patches/pm/0045-ARM-OMAP2-CM-use-the-cached-copy-of-the-clockdomain-.patch"
	${git} "${DIR}/patches/pm/0046-ARM-OMAP2-powerdomain-cache-the-powerdomain-next-pow.patch"
	${git} "${DIR}/patches/pm/0047-ARM-OMAP2-powerdomain-cache-the-powerdomain-s-previo.patch"
	${git} "${DIR}/patches/pm/0048-ARM-OMAP2-powerdomain-skip-register-reads-for-powerd.patch"
	${git} "${DIR}/patches/pm/0049-ARM-OMAP2-powerdomain-skip-previous-power-state-read.patch"
	${git} "${DIR}/patches/pm/0050-ARM-OMAP2xxx-powerdomain-add-previous-power-state-tr.patch"
	${git} "${DIR}/patches/pm/0051-ARM-OMAP2xxx-PM-add-pwrdm_-pre-post-_transition-call.patch"
	${git} "${DIR}/patches/pm/0052-memory-emif-Move-EMIF-related-header-file-to-include.patch"
	${git} "${DIR}/patches/pm/0053-ARM-OMAP2-AM33XX-CM-Get-rid-of-unncessary-header-inc.patch"
	${git} "${DIR}/patches/pm/0054-ARM-OMAP2-AM33XX-CM-PRM-Use-__ASSEMBLER__-macros-in-.patch"
	${git} "${DIR}/patches/pm/0055-ARM-OMAP2-AM33XX-hwmod-Register-OCMC-RAM-hwmod.patch"
	${git} "${DIR}/patches/pm/0056-ARM-OMAP2-AM33XX-hwmod-Update-TPTC0-hwmod-with-the-r.patch"
	${git} "${DIR}/patches/pm/0057-ARM-OMAP2-AM33XX-hwmod-Fixup-cpgmac0-hwmod-entry.patch"
	${git} "${DIR}/patches/pm/0058-ARM-OMAP2-AM33XX-hwmod-Update-the-WKUP-M3-hwmod-with.patch"
	${git} "${DIR}/patches/pm/0059-ARM-OMAP2-AM33XX-Update-the-hardreset-API.patch"
	${git} "${DIR}/patches/pm/0060-ARM-DTS-AM33XX-Add-nodes-for-OCMC-RAM-and-WKUP-M3.patch"
	${git} "${DIR}/patches/pm/0061-ARM-OMAP2-timer-Add-suspend-resume-callbacks-for-clo.patch"
	${git} "${DIR}/patches/pm/0062-ARM-OMAP2-AM33XX-timer-Interchance-clkevt-and-clksrc.patch"
	${git} "${DIR}/patches/pm/0063-ARM-OMAP2-AM33XX-control-Add-some-control-module-reg.patch"
	${git} "${DIR}/patches/pm/0064-ARM-OMAP2-AM33XX-Add-assembly-code-for-PM-operations.patch"
	${git} "${DIR}/patches/pm/0065-ARM-OMAP2-AM33XX-Basic-suspend-resume-support.patch"
	${git} "${DIR}/patches/pm/0066-ARM-OMAP2-AM33XX-Select-Mailbox-when-PM-is-enabled.patch"
	${git} "${DIR}/patches/pm/0067-ARM-OMAP2-AM33XX-Hookup-AM33XX-PM-code-into-OMAP-bui.patch"
	${git} "${DIR}/patches/pm/0068-Makefile-scripts-package-builddeb-HACK-Force-xargs-m.patch"
	${git} "${DIR}/patches/pm/0069-Makefile-HACK-Install-device-trees-with-modules_inst.patch"

	echo "dir: usb"
	${git} "${DIR}/patches/usb/0001-drivers-usb-phy-add-a-new-driver-for-usb-part-of-con.patch"
	${git} "${DIR}/patches/usb/0002-drivers-usb-start-using-the-control-module-driver.patch"
	${git} "${DIR}/patches/usb/0003-usb-otg-Add-an-API-to-bind-the-USB-controller-and-PH.patch"
	${git} "${DIR}/patches/usb/0004-usb-otg-utils-add-facilities-in-phy-lib-to-support-m.patch"
	${git} "${DIR}/patches/usb/0005-ARM-OMAP-USB-Add-phy-binding-information.patch"
	${git} "${DIR}/patches/usb/0006-drivers-usb-musb-omap-make-use-of-the-new-PHY-lib-AP.patch"
	${git} "${DIR}/patches/usb/0007-usb-otg-add-device-tree-support-to-otg-library.patch"
	${git} "${DIR}/patches/usb/0008-USB-MUSB-OMAP-get-PHY-by-phandle-for-dt-boot.patch"
	${git} "${DIR}/patches/usb/0009-MUSB-Hack-around-to-make-host-port-to-work.patch"

	echo "dir: PG2"
	${git} "${DIR}/patches/PG2/0001-beaglebone-black-1ghz-hack.patch"

	echo "dir: rcu-cpufreq"
	${git} "${DIR}/patches/rcu-cpufreq/0001-cpufreq-OMAP-use-RCU-locks-around-usage-of-OPP.patch"
	${git} "${DIR}/patches/rcu-cpufreq/0002-cpufreq-cpufreq-cpu0-use-RCU-locks-around-usage-of-O.patch"
	${git} "${DIR}/patches/rcu-cpufreq/0003-PM-devfreq-add-locking-documentation-for-recommended.patch"

	echo "dir: hacks"
	${git} "${DIR}/patches/reboot/0001-ARM-AM33xx-Add-SoC-specific-restart-hook.patch"
}

am33x
arm
omap
am33x_after

echo "patch.sh ran successful"
