# adr
Asciidoctor image with some helpers


<version> =
git describe --abbrev=4 --dirty --always --tags

docker build -t adr .

docker image tag adr tkmtwo/adr:latest
docker image tag adr tkmtwo/adr:<version>

docker image push --all-tags tkmtwo/adr
