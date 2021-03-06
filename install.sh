set -e

sudo bash -c 'echo "xvfb-run $PWD/submodules/openscad/openscad/openscad \$@" > /usr/local/bin/openscad'

sudo chmod +x /usr/local/bin/openscad
