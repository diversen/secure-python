import os

memory_hog = []
size = 0

try:
    while True:
        # Allocate ~10MB and force memory to be used
        chunk = bytearray(10**7)  # Raw memory allocation (not Python string)
        memory_hog.append(chunk)
        size += 10
        print(f"Allocated {size}MB", flush=True)
except MemoryError:
    print("Memory limit reached!")