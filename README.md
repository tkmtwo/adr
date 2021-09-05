# adr
Asciidoctor image with some helpers




docker build -t adr .

docker image tag
docker image tag myimage registry-host:5000/myname/myimage:latest

docker image tag adr tkmtwo/adr:latest
docker image tag adr tkmtwo/adr:v1

docker image push --all-tags tkmtwo/adr
