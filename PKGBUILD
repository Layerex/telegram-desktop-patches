pkgname=telegram-desktop-patched
pkgdesc='Telegram Desktop client with some anti-features (sponsored messages, saving restrictions and other) disabled.'
url="https://github.com/Layerex/telegram-desktop-patches"
conflicts=("telegram-desktop")
provides=("telegram-desktop")
pkgrel=1

prepare() {
    cd tdesktop-$pkgver-full
    patch --forward --strip=1 --input "${srcdir}/0001-Disable-sponsored-messages.patch"
    patch --forward --strip=1 --input "${srcdir}/0002-Disable-saving-restrictions.patch"
    patch --forward --strip=1 --input "${srcdir}/0003-Disable-invite-peeking-restrictions.patch"
    patch --forward --strip=1 --input "${srcdir}/0004-Disable-accounts-limit.patch"
    patch --forward --strip=1 --input "${srcdir}/0005-Option-to-disable-stories.patch"
}
# To bump Telegram version, selectively paste upstream PKGBUILD below, retaining PATCH_FILENAMES and PATCH_HASHES
# https://gitlab.archlinux.org/archlinux/packaging/packages/telegram-desktop/-/blob/main/PKGBUILD
# Make sure you are modifying PKGBUILD.m4, not PKGBUILD, or your changes will be overwritten by make
pkgver=5.10.3
arch=('x86_64')
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash' 'ada'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'libxcomposite' 'libxdamage' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0' 'kcoreaddons' 'openh264')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser' 'python-packaging'
             'glib2-devel')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        "0001-Disable-sponsored-messages.patch"
        "0002-Disable-saving-restrictions.patch"
        "0003-Disable-invite-peeking-restrictions.patch"
        "0004-Disable-accounts-limit.patch"
        "0005-Option-to-disable-stories.patch")
sha512sums=('02a5db9b53309bd859aa7aa3400d8fc35873bb49f34395541c6d0ebfc41d90dc406844489d6f22afc5ea9d11bb3625c7715cb6de56f428e0957dfaae3c495431'
            "b46c115b1284ba3fb99f3ce1c77725f2943befc5d3e1c169a740e9dcdccd1412a87126bf055d91417759f6b078562072d6825311cce1c5f09b13cd59031c4626"
            "c2bc9f7ed6f2b691a2092c8984c5b90ddf0c84442a670de7b9c3f738947df2a00af22f91723a42aea5bd8ee8e8a9a8b30784f5046b9a7dc54297ce71bf661c2b"
            "2c19b303ce77aa5b92dcbc46e61c0f45a5eb5fdb8810bd5f86a5d51acc4a79d6c41742d5197a0d72a6224e5f26855ab74ed35b5d085e8ba713cc9c87d8f54897"
            "cba09b95960960f5657b5482389deb75abad8f4200f4809943e1ca873c19cf4caa99ef79f0ff32ecb17337e1b375523e310bc5e8843d13c8b3a5dff705ca9218"
            "7baa131e9704057875e67c70d09c5d7eefa673f91cb6271a719a9f8897025a136ee88e55773bc506c992ecace9c48c85a246cc7821a7915e4d548a840b0e5366")

build() {
    CXXFLAGS+=' -ffat-lto-objects'

    cmake -B build -S tdesktop-$pkgver-full -G Ninja \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_INSTALL_PREFIX="/usr" \
        -DCMAKE_BUILD_TYPE=Release \
        -DTDESKTOP_API_ID=611335 \
        -DTDESKTOP_API_HASH=d524b414d21f4d37f08684c1df41ac9c
    cmake --build build
}

package() {
    DESTDIR="$pkgdir" cmake --install build
}
