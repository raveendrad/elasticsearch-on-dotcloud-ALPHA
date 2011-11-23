#!/bin/sh

dotcloud_get_env() {
    sed -Ene "/$1/ s/.*: ([^,]*)(,|$)/\1/p" < ~/environment.json | cut '-d ' -f 1
}

slowbuild () {
    # unsupported
    true
}

fastbuild () {
    port_www=`dotcloud_get_env PORT_WWW`

    curl -L https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.17.7.tar.gz |
    tar -zxf-
    grep ^http.port elasticsearch-0.17.7/config/elasticsearch.yml ||
        echo "http.port: $port_www-$port_www" >> elasticsearch-0.17.7/config/elasticsearch.yml
}

cd
fastbuild
