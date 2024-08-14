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
pkgver=5.1.1
arch=('x86_64')
license=('GPL3')
depends=('hunspell' 'ffmpeg' 'hicolor-icon-theme' 'lz4' 'minizip' 'openal'
         'qt6-imageformats' 'qt6-svg' 'qt6-wayland' 'xxhash'
         'rnnoise' 'pipewire' 'libxtst' 'libxrandr' 'libxcomposite' 'libxdamage' 'abseil-cpp' 'libdispatch'
         'openssl' 'protobuf' 'glib2' 'libsigc++-3.0' 'kcoreaddons')
makedepends=('cmake' 'git' 'ninja' 'python' 'range-v3' 'tl-expected' 'microsoft-gsl' 'meson'
             'extra-cmake-modules' 'wayland-protocols' 'plasma-wayland-protocols' 'libtg_owt'
             'gobject-introspection' 'boost' 'fmt' 'mm-common' 'perl-xml-parser' 'python-packaging')
optdepends=('webkit2gtk: embedded browser features'
            'xdg-desktop-portal: desktop integration')
source=("https://github.com/telegramdesktop/tdesktop/releases/download/v${pkgver}/tdesktop-${pkgver}-full.tar.gz"
        "0001-Disable-sponsored-messages.patch"
        "0002-Disable-saving-restrictions.patch"
        "0003-Disable-invite-peeking-restrictions.patch"
        "0004-Disable-accounts-limit.patch"
        "0005-Option-to-disable-stories.patch")
sha512sums=('4d33dc4e18651e17449c20f82b29dc1268b77f661d0791f33c45d5b5d00af73dca66b0849ef9711f40648132a265db5eec5f2c2aaca87aeae5df3e48d9c09f69'
            "2b7759cd90f82c2ab3ca079d89bcc6063d632cd184d276956c076fec20e26ae5de671c462485a0ba0dd2d1aeb2c76bb450fdf138ea41d2019f82d4c572ccfa49"
            "4072e1c304fbb699d0d0cc42070480a3ac5580ba57bbc9b66debc030b04724fe5e7d02105c8ab270de2c4d3c58c1890040a03fe42cd329c934cfb087c1fab360"
            "2c19b303ce77aa5b92dcbc46e61c0f45a5eb5fdb8810bd5f86a5d51acc4a79d6c41742d5197a0d72a6224e5f26855ab74ed35b5d085e8ba713cc9c87d8f54897"
            "cba09b95960960f5657b5482389deb75abad8f4200f4809943e1ca873c19cf4caa99ef79f0ff32ecb17337e1b375523e310bc5e8843d13c8b3a5dff705ca9218"
            "5f8ecc256ead7060b82cd21af47430dd36592ce413613f2cc1360c7e81655365376cfa4e5d233a53fa6ae9a52eb05f1426ffeb6e0d90e71bbccfa85e9cc78f53")

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
