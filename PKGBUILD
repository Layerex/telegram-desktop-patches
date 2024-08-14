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
pkgver=5.3.2
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
sha512sums=('594c6c9664b52b7eb5bbd2a1f052ddacee0e689b8f6553f332d126add37dc931d4ff7cd68911f709e16cb5f02ecc0d1f27bfc9bc2a92c83f856a43e7d1b554fa'
            "2b7759cd90f82c2ab3ca079d89bcc6063d632cd184d276956c076fec20e26ae5de671c462485a0ba0dd2d1aeb2c76bb450fdf138ea41d2019f82d4c572ccfa49"
            "8e519b0b6fd13bc630a1a298e4a6d16b11032949c2577b7b9897baaed28e3b8178a2ed18ebdcde6feaa8d5736fe72dd3a33070b38fddde796a5af1022108f293"
            "2c19b303ce77aa5b92dcbc46e61c0f45a5eb5fdb8810bd5f86a5d51acc4a79d6c41742d5197a0d72a6224e5f26855ab74ed35b5d085e8ba713cc9c87d8f54897"
            "cba09b95960960f5657b5482389deb75abad8f4200f4809943e1ca873c19cf4caa99ef79f0ff32ecb17337e1b375523e310bc5e8843d13c8b3a5dff705ca9218"
            "cee677660077dcea32d7b89a9f440edbb90abb92d4b0205b03d6bc33906c2f9f952ff070284649a0158bc4d6e7f52a9d17497c49d6782adf50c4da140586090f")

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
