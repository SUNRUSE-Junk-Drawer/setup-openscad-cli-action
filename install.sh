set -e

if [ "$(uname)" == "Darwin" ]; then
  find $PWD/clone/submodules/openscad/openscad
  sudo ln -s $PWD/clone/submodules/openscad/openscad/OpenSCAD.app/Contents/MacOS/OpenSCAD /usr/local/bin/openscad
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo bash -c 'echo "xvfb-run -a $PWD/clone/submodules/openscad/openscad/openscad \$@" > /usr/local/bin/openscad'
  sudo chmod +x /usr/local/bin/openscad
else
  echo TODO
fi
