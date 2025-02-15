# Create secure python environment

Some instruction on how to create a secure python environment using Docker.

This can be used for running untrusted Python scripts (hopefully).

If it is insecure in any way please let me know. 

## Build or rebuild the secure-python Docker image

    git clone https://github.com/diversen/docker-secure-python.git
    cd docker-secure-python
    docker build -t secure-python .

## Usage example

    timeout 10s docker run --network none --init --rm --memory=256m --memory-swap=256m --cpus="0.5" --ulimit nproc=2000:2000 --ulimit stack=67108864 -v "$(pwd)/script.py:/sandbox/script.py" secure-python script.py

## Command description

    timeout 10s

Ensures the container runs for a maximum of 10 seconds.
If the script exceeds this duration, it is forcibly terminated.
Prevents runaway processes from consuming excessive system resources.

    docker run

Creates and runs a new Docker container from the specified image (secure-python).

    --network none

Disables all network access inside the container.

    --init

Enables the use of an init process inside the container. This process helps manage child processes and ensures proper signal handling.

    --rm

Automatically removes the container after execution.
Ensures that no files, logs, or changes persist for future runs.

    --memory=256m

Restricts RAM usage inside the container to 256MB.

    --memory-swap=256m

Sets the total memory limit (RAM + swap) to 256MB.

    --cpus="0.5"

Limits the container to use half of a single CPU core.

    --ulimit nproc=2000:2000

Restricts the number of processes inside the container to 2000.

    --ulimit stack=67108864

Limits the stack size to 64MB.

    -v "$(pwd)/script.py:/sandbox/script.py"

Mounts the local Python script (script.py) from the current directory ($(pwd)) into the container at /sandbox/script.py.
This allows the script to be accessible and executable inside the container.
Ensures that code changes on the host reflect inside the container without rebuilding the image.

    secure-python

Specifies the secure-python Docker image used to run the container.

## Tests

Network:

    docker run --network none --rm -v "$(pwd)/test_network.py:/sandbox/test_network.py" secure-python /sandbox/test_network.py

Memory:

    docker run --memory=256m --memory-swap=256m --rm -v "$(pwd)/test_memory.py:/sandbox/test_memory.py" secure-python /sandbox/test_memory.py

CPU limit:

    docker run --cpus="0.5" --rm -v "$(pwd)/test_cpu.py:/sandbox/test_cpu.py" secure-python /sandbox/test_cpu.py

In order to check run:

    docker stats

Timeout:

    timeout 2s docker run --init --rm -v "$(pwd)/test_timeout.py:/sandbox/test_timeout.py" secure-python /sandbox/test_timeout.py

Malware:

    docker run --rm --memory=256m --cpus="0.5" --network none -v "$(pwd)/test_malware.py:/sandbox/test_malware.py" secure-python /sandbox/test_malware.py

