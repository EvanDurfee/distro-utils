# Distrobox Auto

Automate distrobox assemble and image updates

## About

`distrobox-auto` is a tool for automating `distrobox assemble` and image
updates.

Reads standard distrobox assemble .ini files from `$XDG_DATA_HOME/distrobox-auto/boxes.d/`.

The `assemble` command rebuilds all specified distroboxes.

The `pull` command pulls all images specified in the .ini files.

Systemd user units are provided for automatically pulling image updates
on unmetered networks, and re-assembling the boxes on reboot.
