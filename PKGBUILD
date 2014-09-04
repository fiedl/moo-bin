# Maintainer: pdq <pdq@localhost>
pkgname=moo-scripts
pkgver=0.2
pkgrel=9
pkgdesc="mooOS binaries/scripts"
arch=(any)
url="https://github.com/idk/bin.git"
license=('GPL3')
makedepends=('git')
depends=('dialog' 'rsync' 'update-mirrorlist' 'arch-install-scripts' 'hicolor-icon-theme' 'desktop-file-utils')
optdepends=('grake' 'youtube-viewer')
groups=moo
#conflicts=('abc' 'xyz')
source=('git://github.com/idk/bin.git')
sha512sums=('SKIP')

#install=$pkgname.install

package() {
	msg2 "Installing copies of mooOS scripts ${pkgver}."
    install -d "${pkgdir}/usr/share/$pkgname"
    cp -r $srcdir/bin/* "${pkgdir}/usr/share/$pkgname/"
	msg2 "Installing mooOS executables."
	install -D -m 755 "$srcdir/bin/2038" "$pkgdir/usr/bin/2038"
	install -D -m 755 "$srcdir/bin/autocutsel_launcher" "$pkgdir/usr/bin/autocutsel_launcher"
	install -D -m 755 "$srcdir/bin/cfg_2_src" "$pkgdir/usr/bin/cfg_2_src"
	install -D -m 755 "$srcdir/bin/check_url" "$pkgdir/usr/bin/check_url"
	install -D -m 755 "$srcdir/bin/cpu_freq" "$pkgdir/usr/bin/cpu_freq"
	install -D -m 755 "$srcdir/bin/cpus_temp" "$pkgdir/usr/bin/cpus_temp"
	install -D -m 755 "$srcdir/bin/create_e17_background" "$pkgdir/usr/bin/create_e17_background"
	install -D -m 755 "$srcdir/bin/create_e17_theme" "$pkgdir/usr/bin/create_e17_theme"
	install -D -m 755 "$srcdir/bin/gpu_detect" "$pkgdir/usr/bin/gpu_detect"
	install -D -m 755 "$srcdir/bin/gpu_mon" "$pkgdir/usr/bin/gpu_mon"
	install -D -m 755 "$srcdir/bin/killit" "$pkgdir/usr/bin/killit"
	install -D -m 755 "$srcdir/bin/lamp" "$pkgdir/usr/bin/lamp"
	install -D -m 755 "$srcdir/bin/more_logs" "$pkgdir/usr/bin/more_logs"
	install -D -m 755 "$srcdir/bin/network_notify" "$pkgdir/usr/bin/network_notify"
	install -D -m 755 "$srcdir/bin/pacupdater" "$pkgdir/usr/bin/pacupdater"
	install -D -m 755 "$srcdir/bin/pkgsinfo" "$pkgdir/usr/bin/pkgsinfo"
	install -D -m 755 "$srcdir/bin/scr" "$pkgdir/usr/bin/scr"
	install -D -m 755 "$srcdir/bin/flashsucks" "$pkgdir/usr/bin/flashsucks"
	install -D -m 755 "$srcdir/bin/screenfetch" "$pkgdir/usr/bin/screenfetch"
	install -D -m 755 "$srcdir/bin/startup_hint" "$pkgdir/usr/bin/startup_hint"
	install -D -m 755 "$srcdir/bin/sudo_subl3" "$pkgdir/usr/bin/sudo_subl3"
	install -D -m 755 "$srcdir/bin/bc1" "$pkgdir/usr/bin/bc1"
	install -D -m 755 "$srcdir/bin/bc2" "$pkgdir/usr/bin/bc2"
	install -D -m 755 "$srcdir/bin/bc3" "$pkgdir/usr/bin/bc3"
	install -D -m 755 "$srcdir/bin/bcusb" "$pkgdir/usr/bin/bcusb"
	install -D -m 755 "$srcdir/bin/tc1" "$pkgdir/usr/bin/tc1"
	install -D -m 755 "$srcdir/bin/tc2" "$pkgdir/usr/bin/tc2"
	install -D -m 755 "$srcdir/bin/tc3" "$pkgdir/usr/bin/tc3"
	install -D -m 755 "$srcdir/bin/e19_startups" "$pkgdir/usr/bin/e19_startups"
	install -D -m 755 "$srcdir/bin/transmission-unrar" "$pkgdir/usr/bin/transmission-unrar"
	install -D -m 755 "$srcdir/bin/updates_notifier" "$pkgdir/usr/bin/updates_notifier"
	install -D -m 755 "$srcdir/bin/urlLauncher" "$pkgdir/usr/bin/urlLauncher"
}