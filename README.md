# Flatpak-sync

Automate flatpak installation and repo setup

## About

`flatpak-sync` is a tool for automating flatpak installation via yaml files,
either as system or user installs.
By default, the config is read from `/usr/lib/flatpak-sync/config.yaml`, but
different configs can be specified via the `-f`/`--file` flags.

Intended for use in custom fedora atomic distros, but can be used elsewhere.
It uses a subset of the format used by bluebuild's `default-flatpak v2` module.

## Usage

`flatpak-sync -f <config.yaml> init` will generate a template config file.

`flatpak-sync -f <config.yaml> [--system|--user] install` will configure the
remotes and install the flatpaks specified in the config(s). Multiple configs
can be specified by passing `-f`/`--file` multiple times.

The systemd unit can be enabled with `systemctl enable flatpak-sync-install.service`
