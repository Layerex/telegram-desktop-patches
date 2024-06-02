# telegram-desktop-patches

Patches disabling some anti-features of [Telegram Desktop](https://desktop.telegram.org/).

## Installation

### Arch Linux

```sh
makepkg -si
```

Or if you want to regenerate `PKGBUILD` for current patches in the directory (don't use spaces in patch filenames):

``` sh
make
```

You may also install a prebuilt package published in releases.

### Nix

May be unmaintained.

- [Overrides](https://github.com/Layerex/telegram-desktop-patches/issues/4#issue-2124576494)
- [Flake](https://github.com/shwewo/telegram-desktop-patched)

**TODO:** generate overrides and flake automatically.

### Other systems

Download source code of Telegram Desktop and run commands from `prepare()`, `build()` and `package()` in `PKGBUILD` manually.

## Patches

### 0001-Disable-sponsored-messages.patch

### 0002-Disable-saving-restrictions.patch

Enables saving media, selecting and copying messages in channels, which disallow doing so.

### 0003-Disable-invite-peeking-restrictions.patch

Disables restrictions for viewing and exporting private chats and channels you didn't join but are able to view.

### 0004-Disable-accounts-limit.patch

### 0005-Option-to-disable-stories.patch

Toggle is in experimental settings.

## Contributing

Feel free to contibute patches and means of packaging and installation.

## Updating

If you want to update `PKGBUILD`, make changes in `PKGBUILD.m4` instead and generate `PKGBUILD` with `make`.

See `PKGBUILD.m4` for update instuctions.

## See also

[Killergram](https://github.com/shatyuka/Killergram) - Xposed module featuring some patches with similar functionality for Telegram for Android.

## Credits

[telegram-desktop-no-ads-pkgbuild](https://github.com/vehlwn/telegram-desktop-no-ads-pkgbuild)
