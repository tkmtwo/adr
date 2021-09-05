FROM asciidoctor/docker-asciidoctor AS with-gnuplot

#
# Add gnuplot
#

RUN apk add --update gnuplot \
        fontconfig \
        ttf-ubuntu-font-family \
        msttcorefonts-installer && \
    update-ms-fonts && \
    fc-cache -f && \
    rm -rf /var/cache/apk/*


#
# Add npm
#

FROM with-gnuplot AS with-npm

RUN apk add --update npm


FROM with-npm AS with-vegas

#
# Add vega and vegalite
#
RUN apk --no-cache --virtual .canvas-build-deps add \
  build-base \
  cairo-dev \
  jpeg-dev \
  pango-dev \
  giflib-dev \
  pixman-dev \
  pangomm-dev \
  libjpeg-turbo-dev \
  freetype-dev \
  && apk --no-cache add \
       pixman \
       cairo \
       pango \
       giflib

    

RUN npm -g config set user root \
    && npm install --build-from-source -g canvas \
    && npm install -g vega vega-lite vega-cli



FROM with-vegas AS with-svgbob

#
# Add rust
#
RUN apk update &&\
    apk add git build-base openssl-dev \
    rust cargo

#
# Update rust and add svgbob
#
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
 && . $HOME/.cargo/env \
 && rustup toolchain install stable \
# && rustup default stable \
 && rustup update stable \
 && cargo install --git https://github.com/ivanceras/svgbob.git



FROM with-svgbob AS main

#
# Configure the initial environment
#
VOLUME ["/src", "/build"]
WORKDIR /src

COPY src/bin/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
