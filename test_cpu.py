import multiprocessing

def stress_cpu():
    while True:
        pass  # Keeps the CPU busy

if __name__ == "__main__":
    for _ in range(multiprocessing.cpu_count()):
        multiprocessing.Process(target=stress_cpu).start()

