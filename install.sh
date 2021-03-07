set -e

sudo bash -c 'echo "xvfb-run -a $PWD/clone/submodules/openscad/openscad/openscad \$@" > /usr/local/bin/openscad'

sudo chmod +x /usr/local/bin/openscad
