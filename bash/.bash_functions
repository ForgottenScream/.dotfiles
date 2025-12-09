cal

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function copytodom0() {
    local src_vm="$1"
    local src_path="$2"
    local dest_path="$3"

    if [[ -z "$src_vm" || -z "$src_path" || -z "$dest_path" ]]; then
        echo "Usage: qcp <src-vm> <path/in/src-vm> <dest/path/in/dom0>"
        return 1
    fi

    qvm-run --pass-io "$src_vm" "cat '$src_path'" > "$dest_path"
}
