#!/bin/bash -ex
# Copyright 2015 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

TOOLSDIR=$(dirname $0)

# NOTE(pabelanger): Check if we are running in the gate, if so use cached repos
# to avoid hitting the network.
if [ -d /etc/dib-manifests/ ]; then
    # TODO(pabelanger): Have molecule support existing shell variables.
    HOME=${HOME:-/home/zuul}
    sed -e "s|https://|file://${HOME}/src/|g" -i $TOOLSDIR/../requirements.yml
fi

# NOTE(pabelanger): We should make this role path less hardcoded, however we
# first need to patch molecule.
ansible-galaxy install -v -r $TOOLSDIR/../requirements.yml -p ~/.cache/molecule/ids_config/default/roles $@
