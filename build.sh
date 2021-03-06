set -e

cd clone
git checkout temp

git submodule update --init --recursive --depth 1 submodules/openscad/openscad

cd submodules/openscad/openscad

if [ "$(uname)" == "Darwin" ]; then
  source setenv_mac.sh
  ./scripts/macosx-build-dependencies.sh
  qmake openscad.pro
  make
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get install libglew-dev libxmu-dev libxi-dev qt5-default qtmultimedia5-dev libboost-filesystem-dev libeigen3-dev -y
  source ./scripts/setenv-unibuild.sh
  ./scripts/check-dependencies.sh
  qmake openscad.pro
  make
else
  source ./scripts/setenv-mingw-xbuild.sh 64
  ./scripts/mingw-x-build-dependencies.sh 64
  ./scripts/release-common.sh mingw64
  cd mingw64
  qmake ../openscad.pro CONFIG+=mingw-cross-env
  make
fi
