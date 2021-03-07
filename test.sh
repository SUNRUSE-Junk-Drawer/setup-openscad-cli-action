set -e

if [ "$(uname)" == "Darwin" ]; then
  brew install imagemagick
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get install imagemagick -y
else
  echo TODO
fi

rm -rf ./test/actual
mkdir -p ./test/actual

openscad ./clone/submodules/openscad/openscad/examples/Basics/logo_and_text.scad --render -o ./test/actual/mesh.stl
openscad ./clone/submodules/openscad/openscad/examples/Basics/logo_and_text.scad --render -o ./test/actual/direct.png
openscad ./test/from-stl.scad --render -o ./test/actual/from-stl.png
openscad ./test/2d-example.scad --render -o ./test/actual/2d-example.png
openscad ./test/2d-example.scad --render -o ./test/actual/2d-example.svg

npm ci

npx svg2png ./test/actual/2d-example.svg --output ./test/actual/2d-example.svg.png

mogrify -resize 25% test/actual/*.png

npx pixelmatch ./test/expected/direct.png ./test/actual/direct.png ./test/actual/direct-difference.png 0.1
npx pixelmatch ./test/expected/from-stl.png ./test/actual/from-stl.png ./test/actual/from-stl-difference.png 0.1
npx pixelmatch ./test/expected/2d-example.png ./test/actual/2d-example.png ./test/actual/2d-example-difference.png 0.1
npx pixelmatch ./test/expected/2d-example.svg.png ./test/actual/2d-example.svg.png ./test/actual/2d-example-difference.svg.png 0.1
