#!/bin/sh

set -e

: ${USERNAME:=root}
: ${OC_VERSION:=4.9}
: ${SDK_CACHE_DIR:=/var/cache/bitski-internal-sdk}

mkdir -p "$SDK_CACHE_DIR/oc"
cd "$SDK_CACHE_DIR"

# Install OpenShift CLI
# https://github.com/openshift/oc

mkdir -p /tmp/oc
cd /tmp/oc

if [[ ! -d oc ]]; then
    git clone --depth 1 -b "release-${OC_VERSION}" \
        https://github.com/openshift/oc.git
fi

cd oc

make oc
cp oc /usr/local/bin

mkdir -p /etc/bash_completion.d /usr/local/share/zsh/site-functions
cp contrib/completions/bash/oc /etc/bash_completion.d
cp contrib/completions/zsh/oc /usr/local/share/zsh/site-functions

cd /
rm -rf "$SDK_CACHE_DIR" || true
