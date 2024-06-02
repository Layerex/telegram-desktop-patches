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
pkgver=4.15.0
arch=('x86_64')
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal' 'ttf-opensans'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'libxcomposite' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0' 'glibmm-2.68' 'kcoreaddons')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        "0001-Disable-sponsored-messages.patch"
        "0002-Disable-saving-restrictions.patch"
        "0003-Disable-invite-peeking-restrictions.patch"
        "0004-Disable-accounts-limit.patch"
        "0005-Option-to-disable-stories.patch")
sha512sums=('95aa5f14a9a88b9c6421049445f59f1c5c5d7ab4ca4e8b8f4ab7389bdb8f3cc6b29fea270574881633035acec769ba271261f84ec269010c63af28a03719da98'
            "d5898c0f12a90c39f277b874d9650b7e9ebea224f49e635c0c4275801d228a435b6b1ba0614ade1ade7eca63c4a4434779f056dd8950e2cb1c1ed9438adaa904"
            "4072e1c304fbb699d0d0cc42070480a3ac5580ba57bbc9b66debc030b04724fe5e7d02105c8ab270de2c4d3c58c1890040a03fe42cd329c934cfb087c1fab360"
            "2c19b303ce77aa5b92dcbc46e61c0f45a5eb5fdb8810bd5f86a5d51acc4a79d6c41742d5197a0d72a6224e5f26855ab74ed35b5d085e8ba713cc9c87d8f54897"
            "cba09b95960960f5657b5482389deb75abad8f4200f4809943e1ca873c19cf4caa99ef79f0ff32ecb17337e1b375523e310bc5e8843d13c8b3a5dff705ca9218"
            "5e237b291116cefc44c02025e15f6e173d1dc503c87927a38e2b0b9db1778aacbee2d76a23d3967ae4c2c5954bf197c4407c1de4e6a4efb0f7bcc72090946e01")

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
