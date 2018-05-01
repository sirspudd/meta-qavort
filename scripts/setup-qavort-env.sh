#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit
#set -o xtrace

script_dir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
qavort_dir=$(cd $script_dir/.. && pwd)
bsp_dir=$(cd $qavort_dir/../.. && pwd)
build_dir=${bsp_dir}/build

local_conf=${build_dir}/conf/local.conf
orig_local_conf=${build_dir}/conf/local.conf.orig

bblayers_conf=${build_dir}/conf/bblayers.conf
orig_bblayers_conf=${build_dir}/conf/bblayers.conf.orig

export PATH=${script_dir}/hack:$PATH

cd ${bsp_dir}

#beyond our control
set +o nounset
SDKMACHINE=amd64 MACHINE=tinker-rk3288 DISTRO=qavort . ./setup-environment -b build
set -o nounset

if [[ -f ${orig_local_conf} ]]; then
    cp ${orig_local_conf} ${local_conf}
else
    cp ${local_conf} ${orig_local_conf}
fi

if [[ -f ${orig_bblayers_conf} ]]; then
    cp ${orig_bblayers_conf} ${bblayers_conf}
else
    cp ${bblayers_conf} ${orig_bblayers_conf}
fi

cat >> ${local_conf} << EOF
EXTRA_IMAGE_FEATURES = ""
PACKAGE_CLASSES = "package_rpm"
EOF

sed -i "21i\ \ \${BSPDIR}/sources/meta-qavort \\\\" ${bblayers_conf}

zsh
