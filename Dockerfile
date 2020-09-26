FROM alpine

WORKDIR /tmp

RUN apk add --update --no-cache alpine-sdk php7-dev php-mbstring bash && \
    wget https://github.com/taku910/mecab/archive/master.zip && unzip master.zip && \
    cd mecab-master/mecab && ./configure --with-charset=utf8 && make && make check && make install && \
    cd ../mecab-ipadic && ./configure --with-charset=utf8 && make && make install && \
    cd /tmp && \
    wget https://github.com/rsky/php-mecab/archive/v0.6.0.zip && unzip v0.6.0.zip && \
    cd php-mecab-0.6.0/mecab && phpize && ./configure && make && make test && make install && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
    rm -rf /tmp/* && \
    echo "extension=mecab.so" > /etc/php7/conf.d/mecab.ini

CMD ["/bin/sh"]
