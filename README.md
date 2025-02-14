# Create secure python environment

See the chat:

https://chatgpt.com/share/67af7aee-1800-800c-bfc9-878f0cf415af

Generate secure-docker

    cd tools
    docker build -t secure-python .

Execute with timeout, memory and cpu limits:

    timeout 10s docker run --rm --network none --memory=256m --cpus="0.5"  --ulimit stack=67108864  secure-python

    docker run \
        --rm  \
        --network none \
        --memory=256m \
        --cpus="0.5" \
        --ulimit nproc=1000:1000 \
        --ulimit stack=67108864 \
        -v "$(pwd)/script.py:/sandbox/script.py" \
        secure-python
