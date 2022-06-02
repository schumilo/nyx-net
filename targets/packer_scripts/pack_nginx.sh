#!/bin/bash
set -e
source ./config.sh

SHAREDIR="../packed_targets/nyx_nginx/"

if [ "$1" = "docker" ]; then
  DEFAULT_CONFIG="--path_to_default_config ../default_config_kernel.ron"
else 
  DEFAULT_CONFIG=""
fi

python3 $PACKER ../setup_scripts/build/nginx/nginx-1.20.0/objs/nginx $SHAREDIR m64 \
--afl_mode \
--purge \
--nyx_net \
--nyx_net_port 8080 \
-spec ../specs/http \
-args " -c /tmp/nginx.conf -g 'daemon off;master_process off;'" \
--setup_folder ../extra_folders/nginx  && \
python3 $CONFIG_GEN $SHAREDIR Kernel -s ../specs/http/ $DEFAULT_CONFIG

