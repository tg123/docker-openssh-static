#!/bin/bash

for tag in $(curl -s https://api.github.com/repos/openssh/openssh-portable/tags | jq -r '.[].name'); do
    echo $tag
    if docker pull "farmer1992/openssh-static:$tag" 2>/dev/null; then
        echo "Image for tag $tag already exists on Docker Hub, skipping build."
        continue
    fi
    docker build -t "farmer1992/openssh-static:$tag" --build-arg openssh_url="https://github.com/openssh/openssh-portable/archive/$tag.tar.gz" .
    docker push "farmer1992/openssh-static:$tag"
done