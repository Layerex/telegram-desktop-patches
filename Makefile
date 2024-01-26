package: PKGBUILD
	makepkg -si

PKGBUILD: PKGBUILD.m4 $(wildcard *.patch) .
	m4 PKGBUILD.m4 > PKGBUILD
