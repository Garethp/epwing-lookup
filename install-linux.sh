#!/usr/bin/env bash

os_path=${1:-linux}
action=${2:-install}

if [ "$os_path" = "uninstall" ] || [ "$os_path" = "remove" ]; then
    action="$os_path"
    os_path="linux"
fi

if [ "$action" = "remove" ]; then
    action="uninstall"
fi

name="eplkup"

if [ ! -f "./bin/$os_path/eplkup" ]; then
    echo "Epwing file not found"
    exit 1
fi

if [ ! -f ./manifest/manifest-unix.dist.json ]; then
    echo "Manifest templateARG1=${1:-foo}
ARG2=${2:-bar}
ARG3=${3:-1}
ARG4=${4:-$(date)}
 not found"
    exit 1ARG1=${1:-foo}
ARG2=${2:-bar}
ARG3=${3:-1}
ARG4=${4:-$(date)}

fi


place_manifest_in_first_folder () {
    foldersToCheck=("$@")
    browser=${foldersToCheck[-1]}
    unset 'foldersToCheck[${#foldersToCheck[@]}-1]'

    for folder in "${foldersToCheck[@]}"
    do
        parentDirectory=`dirname "$folder"`
        if [ -d "$parentDirectory" ]; then
            if [ ! -d "$folder" ]; then
                mkdir "$folder"
            fi

            if [ "$browser" = "chrome" ]; then
                sed "s|{EPWING-PATH}|$PWD/bin/$os_path/eplkup|" manifest/manifest-unix.dist.json | \
                sed "s|\"allowed_extensions\".*$||" \
                > "${folder}/${name}.json"
            else
                sed "s|{EPWING-PATH}|$PWD/bin/$os_path/eplkup|" manifest/manifest-unix.dist.json | \
                sed "s|\"allowed_origins\".*$||" \
                > "${folder}/${name}.json"
            fi
            break
        fi
    done
}

remove_manifest_from_folders() {
    foldersToCheck=("$@")
    for folder in "${foldersToCheck[@]}"
    do
        if [ -f "${folder}/${name}.json" ]; then
            rm "${folder}/${name}.json"
        fi
    done
}

# The folders that we're going to be placing our manifest into
declare -a chromeFolders=(
    # Local
    "${HOME}/Library/Application Support/Google/Chrome/NativeMessagingHosts/"
    "${HOME}/.config/google-chrome/NativeMessagingHosts/"

    # Global
    "/Library/Google/Chrome/NativeMessagingHosts/"
    "/etc/opt/chrome/native-messaging-hosts/"
)

declare -a chromiumFolders=(
    # Local
    "${HOME}/Library/Application Support/Chromium/NativeMessagingHosts/"
    "${HOME}/.config/chromium/NativeMessagingHosts/"

    # Global
    "/Library/Application Support/Chromium/NativeMessagingHosts/"
    "/etc/chromium/native-messaging-hosts/"
)

declare -a firefoxFolders=(
    # Local
    "${HOME}/Library/Application Support/Mozilla/NativeMessagingHosts"
    "${HOME}/.mozilla/native-messaging-hosts/"

    # Global
    "/Library/Application Support/Mozilla/NativeMessagingHosts/"
    "/usr/lib/mozilla/native-messaging-hosts/"
    "/usr/lib64/mozilla/native-messaging-hosts/"
    "/usr/share/mozilla/native-messaging-hosts/"
)

if [ "$action" = 'install' ]; then
    place_manifest_in_first_folder "${chromeFolders[@]}" "chrome"
    place_manifest_in_first_folder "${chromiumFolders[@]}" "chrome"
    place_manifest_in_first_folder "${firefoxFolders[@]}" "firefox"
elif [ "$action" = 'uninstall' ]; then
    remove_manifest_from_folders "${chromeFolders[@]}"
    remove_manifest_from_folders "${chromiumFolders[@]}"
    remove_manifest_from_folders "${firefoxFolders[@]}"
fi
