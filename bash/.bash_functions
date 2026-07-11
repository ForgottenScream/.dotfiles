#!/usr/bin/env bash
#
# .bash_functions


mkcd() {
    mkdir -p -- "$1" && cd -- "$1"
}

copytodom0() {
    local src_vm="$1"
    local src_path="$2"
    local dest_path="$3"

    if [[ -z "$src_vm" || -z "$src_path" || -z "$dest_path" ]]; then
        echo "Usage: copytodom0 <src-vm> <path/in/src-vm> <dest/path/in/dom0>"
        return 1
    fi

    if ! command -v qvm-run >/dev/null 2>&1; then
        echo "Error: qvm-run not found."
        return 1
    fi

    qvm-run --pass-io "$src_vm" "cat $(printf '%q' "$src_path")" > "$dest_path"
}

rootTerminal() {
    local vm="$1"

    if [[ -z "$vm" ]]; then
        echo "Usage: rootTerminal <vm>"
        return 1
    fi

    if ! command -v qvm-run >/dev/null 2>&1 || ! command -v qubes-run-terminal >/dev/null 2>&1; then
        echo "Error: Qubes tools not found."
        return 1
    fi

    qvm-run -u root "$vm" qubes-run-terminal
}
