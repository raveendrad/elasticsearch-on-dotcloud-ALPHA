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

    curl -L https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.18.4.tar.gz |
    tar -zxf-

    # http-basic authentication plugin
    curl --create-dirs https://github.com/downloads/Asquera/elasticsearch-http-basic/elasticsearch-http-basic-1.0.1.jar -o elasticsearch-0.18.4/plugins/http-basic/elasticsearch-http-basic-1.0.1.jar

    # configure
    current_path=`pwd`
    config_path="elasticsearch-0.18.4/config/elasticsearch.yml"

    echo "" >> $config_path
    echo "# Dotcloud configuration" >> $config_path
    echo "http.port: $port_www-$port_www" >> $config_path
    echo "path.plugins: ${current_path}/elasticsearch-0.18.4/plugins" >> $config_path
    mkdir data
    echo "path.data: ${current_path}/data" >> $config_path
    mkdir logs
    echo "path.logs: ${current_path}/logs" >> $config_path

    # authentication plugin
    echo "http.basic.enabled: false" >> $config_path
}

cd
fastbuild
