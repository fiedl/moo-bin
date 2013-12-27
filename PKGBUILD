# Maintainer: pdq <pdq@localhost>
pkgname=moo-scripts
pkgver=0.10
pkgrel=2
pkgdesc="mooOS binaries/scripts"
arch=(any)
url="https://github.com/idk/bin.git"
license=('GPL3')
makedepends=('git')
depends=('bash' 'dialog' 'rsync' 'arch-install-scripts' 'update-mirrorlist' 'efl-git' 'gtk3' 'hicolor-icon-theme' 'desktop-file-utils')
#conflicts=('abc' 'xyz')
#source=("")
#md5sums=('SKIP')

_gitroot="git://github.com/idk/bin.git"
_gitname="moo-scripts"

#install=$pkgname.install

build() {
	cd "$srcdir"
	msg "Connecting to GIT server...."

	if [ -d $pkgname ] ; then
		cd $pkgname && git pull origin
		msg "The local files are updated."
	else
		git clone $_gitroot $pkgname
		cd $pkgname
	fi
	msg "GIT checkout done or server timeout"
}

package() {
	cd "$srcdir/$pkgname/"
	msg2 "Installing copies of mooOS scripts ${pkgver}."
    install -d "${pkgdir}/usr/share/$pkgname"
    cp -r "$srcdir/$pkgname/" "${pkgdir}/usr/share/"
	msg2 "Installing mooOS executables."
	install -D -m 755 "2038" "$pkgdir/usr/bin/2038"
	install -D -m 755 "cfg_2_src" "$pkgdir/usr/bin/cfg_2_src"
	install -D -m 755 "check_url" "$pkgdir/usr/bin/check_url"
	install -D -m 755 "cpu_freq" "$pkgdir/usr/bin/cpu_freq"
	install -D -m 755 "cpus_temp" "$pkgdir/usr/bin/cpus_temp"
	install -D -m 755 "create_e17_background" "$pkgdir/usr/bin/create_e17_background"
	install -D -m 755 "create_e17_theme" "$pkgdir/usr/bin/create_e17_theme"
	install -D -m 755 "gpu_detect" "$pkgdir/usr/bin/gpu_detect"
	install -D -m 755 "gpu_mon" "$pkgdir/usr/bin/gpu_mon"
	install -D -m 755 "killit" "$pkgdir/usr/bin/killit"
	install -D -m 755 "lamp" "$pkgdir/usr/bin/lamp"
	install -D -m 755 "more_logs" "$pkgdir/usr/bin/more_logs"
	install -D -m 755 "network_notify" "$pkgdir/usr/bin/network_notify"
	install -D -m 755 "packerupdater" "$pkgdir/usr/bin/packerupdater"
	install -D -m 755 "pacupdater" "$pkgdir/usr/bin/pacupdater"
	install -D -m 755 "pkgsinfo" "$pkgdir/usr/bin/pkgsinfo"
	install -D -m 755 "scr" "$pkgdir/usr/bin/scr"
	install -D -m 755 "screenfetch" "$pkgdir/usr/bin/screenfetch"
	install -D -m 755 "startup_hint" "$pkgdir/usr/bin/startup_hint"
	install -D -m 755 "sudo_subl3" "$pkgdir/usr/bin/sudo_subl3"
	install -D -m 755 "tc1" "$pkgdir/usr/bin/tc1"
	install -D -m 755 "tc2" "$pkgdir/usr/bin/tc2"
	install -D -m 755 "tc3" "$pkgdir/usr/bin/tc3"
	install -D -m 755 "transmission-unrar" "$pkgdir/usr/bin/transmission-unrar"
	install -D -m 755 "updates_notifier" "$pkgdir/usr/bin/updates_notifier"
	install -D -m 755 "urlLauncher" "$pkgdir/usr/bin/urlLauncher"
}