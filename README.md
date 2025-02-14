# Create secure python environment

## Build or rebuild the secure-python Docker image

    cd secure-python
    docker build -t secure-python .

## Usage example

    timeout 10s docker run --network none --rm --memory=256m --cpus="0.5" --ulimit nproc=2000:2000 --ulimit stack=67108864 -v "$(pwd)/script.py:/sandbox/script.py" secure-python

## Command description

    timeout 10s

Ensures the container runs for a maximum of 10 seconds.
If the script exceeds this duration, it is forcibly terminated.
Prevents runaway processes from consuming excessive system resources.

    docker run

Creates and runs a new Docker container from the specified image (secure-python).

    --network none

Disables all network access inside the container.
Prevents the script from making external API calls, downloading files, or communicating with other containers.
Enhances security and isolation.

    --rm

Automatically removes the container after execution.
Ensures that no files, logs, or changes persist for future runs.
Prevents disk clutter by eliminating unnecessary containers.
(If omitted, the container remains and can be restarted, potentially causing persistent file issues.)

    --memory=256m

Restricts RAM usage inside the container to 256MB.
Prevents memory-hungry scripts from consuming too many system resources.
If memory usage exceeds this limit, the process is terminated.

    --cpus="0.5"

Limits the container to use half of a single CPU core.
Helps ensure fair resource distribution and prevents CPU-intensive scripts from slowing down the system.

    --ulimit nproc=2000:2000

Restricts the number of processes inside the container to 2000.
Prevents fork bombs or excessive process creation that could crash the system.
Ensures better process management.

    --ulimit stack=67108864

Limits the stack size to 64MB.
Prevents excessive memory allocation for deep recursive calls.
Helps control stack overflows and runaway memory usage.

    -v "$(pwd)/script.py:/sandbox/script.py"

Mounts the local Python script (script.py) from the current directory ($(pwd)) into the container at /sandbox/script.py.
This allows the script to be accessible and executable inside the container.
Ensures that code changes on the host reflect inside the container without rebuilding the image.

    secure-python

Specifies the secure-python Docker image used to run the container.
