set -e

cd clone
git submodule update --init --recursive --depth 1 submodules/openscad/openscad
cd ..

rm -rf ./test/actual
mkdir -p ./test/actual

openscad ./clone/submodules/openscad/openscad/examples/Basics/logo_and_text.scad --render -o ./test/actual/mesh.stl
openscad ./clone/submodules/openscad/openscad/examples/Basics/logo_and_text.scad --render -o ./test/actual/direct.png
openscad ./test/from-stl.scad --render -o ./test/actual/from-stl.png
openscad ./test/2d-example.scad --render -o ./test/actual/2d-example.png
openscad ./test/2d-example.scad --render -o ./test/actual/2d-example.svg

npm ci

npx svg2png ./test/actual/2d-example.svg --output ./test/actual/2d-example.svg.png

cmp <(npx ts-node ./test/convert-image.ts ./test/actual/direct.png) <(echo "512x512")
cmp <(npx ts-node ./test/convert-image.ts ./test/actual/from-stl.png) <(echo "512x512")
cmp <(npx ts-node ./test/convert-image.ts ./test/actual/2d-example.png) <(echo "512x512")
cmp <(npx ts-node ./test/convert-image.ts ./test/actual/2d-example.svg.png) <(echo "10x10")

cmp ./test/expected/direct.rgba ./test/actual/direct.rgba
cmp ./test/expected/from-stl.rgba ./test/actual/from-stl.rgba
cmp ./test/expected/2d-example.rgba ./test/actual/2d-example.rgba
cmp ./test/expected/2d-example.svg.rgba ./test/actual/2d-example.svg.rgba
