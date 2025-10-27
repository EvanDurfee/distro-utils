# Flatpak-sync

Automate flatpak installation and repo setup

## About

`flatpak-sync` is a tool for automating flatpak installation via yaml files,
either as system or user installs.
By default, the config is read from `/usr/lib/flatpak-sync/config.yaml`, but
different configs can be specified via the `-f`/`--file` flags.

Intended for use in custom fedora atomic distros, but can be used elsewhere.
It uses a format based on bluebuild's `default-flatpak v2` module, but not
identical.

## Usage

`flatpak-sync -f <config.yaml> init` will generate a template config file.

`flatpak-sync -f <config.yaml> [--system|--user] install` will configure the
remotes and install the flatpaks specified in the config(s). Multiple configs
can be specified by passing `-f`/`--file` multiple times.

The systemd unit can be enabled with `systemctl enable flatpak-sync-install.service`

## Caveats

To keep dependencies to a minimum, this script uses only bash and gnu version of
utils like sed and grep. The yaml parser is not at all robust, and should be
treated gently. Json-style objects and lists are not supported. Anything after a
"#" is treated as a comment and ignored, without regards for quoting.
Indentation is used for list parsing but not strictly observed.
