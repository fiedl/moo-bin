# Maintainer: pdq <pdq@localhost>
pkgname=moo-scripts
pkgver=0.10
pkgrel=1
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
	install -D -m 755 "2038" "$pkgdir/usr/bin/"
	install -D -m 755 "cfg_2_src" "$pkgdir/usr/bin/"
	install -D -m 755 "check_url" "$pkgdir/usr/bin/"
	install -D -m 755 "cpu_freq" "$pkgdir/usr/bin/"
	install -D -m 755 "cpus_temp" "$pkgdir/usr/bin/"
	install -D -m 755 "create_e17_background" "$pkgdir/usr/bin/"
	install -D -m 755 "create_e17_theme" "$pkgdir/usr/bin/"
	install -D -m 755 "gpu_detect" "$pkgdir/usr/bin/"
	install -D -m 755 "gpu_mon" "$pkgdir/usr/bin/"
	install -D -m 755 "killit" "$pkgdir/usr/bin/"
	install -D -m 755 "lamp" "$pkgdir/usr/bin/"
	install -D -m 755 "mkiso" "$pkgdir/usr/bin/"
	install -D -m 755 "moo" "$pkgdir/usr/bin/"
	install -D -m 755 "moo_config" "$pkgdir/usr/bin/"
	install -D -m 755 "moo_functions" "$pkgdir/usr/bin/"
	install -D -m 755 "more_logs" "$pkgdir/usr/bin/"
	install -D -m 755 "network_notify" "$pkgdir/usr/bin/"
	install -D -m 755 "packerupdater" "$pkgdir/usr/bin/"
	install -D -m 755 "pacupdater" "$pkgdir/usr/bin/"
	install -D -m 755 "pkgsinfo" "$pkgdir/usr/bin/"
	install -D -m 755 "scr" "$pkgdir/usr/bin/"
	install -D -m 755 "screenfetch" "$pkgdir/usr/bin/"
	install -D -m 755 "startup_hint" "$pkgdir/usr/bin/"
	install -D -m 755 "sudo_subl3" "$pkgdir/usr/bin/"
	install -D -m 755 "tc1" "$pkgdir/usr/bin/"
	install -D -m 755 "tc2" "$pkgdir/usr/bin/"
	install -D -m 755 "tc3" "$pkgdir/usr/bin/"
	install -D -m 755 "transmission-unrar" "$pkgdir/usr/bin/"
	install -D -m 755 "updates_notifier" "$pkgdir/usr/bin/"
	install -D -m 755 "urlLauncher" "$pkgdir/usr/bin/"
}