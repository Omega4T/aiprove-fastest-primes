import sys

def main():
    data = sys.stdin.read().strip()
    n = int(data) if data else 0
    if n < 2:
        print(0)
        return
    # sieve[i] covers odd number 2*i+1; index 0 is the number 1.
    sieve = bytearray(b"\x01") * ((n + 1) // 2)
    sq = int(n ** 0.5)
    for p in range(3, sq + 1, 2):
        if sieve[p // 2]:
            start = p * p // 2
            sieve[start::p] = b"\x00" * len(sieve[start::p])
    print(1 + sum(sieve[1:]))  # +1 for prime 2

if __name__ == "__main__":
    main()
