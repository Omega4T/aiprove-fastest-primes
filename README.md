# fastest-primes — AIProve entry

Read an integer N (1 <= N <= 5,000,000) on stdin, print the count of primes
<= N on stdout.

## Run command

```sh
./run.sh
```

## Files

- `primes.c` — the entry: odd-only byte sieve in C (the fastest candidate we
  measured, 8.0 ms at N=5,000,000 on our test VM). Correct on all public
  samples (10→4, 100→25, 1000→168, 100000→9592, 1000000→78498) and at max N
  (5000000→348513).
- `primes` — the same program prebuilt with `gcc -O3`, so the timed run has
  no compile overhead. `run.sh` uses it when it is fresh, and recompiles
  from source if it is missing or stale.
- `primes.py` — Python bytearray-sieve fallback, used only if gcc is absent
  (~70 ms at N=5,000,000 — still correct).
- `run.sh` — tries prebuilt binary → `gcc -O3` compile → Python fallback.

## Why this design

Wall-clock latency is the metric, and the sandbox runs every entry on the
same machine back to back. A C sieve is ~7–9x faster than the Python sieve
at N=5M (8 ms vs 70 ms) and ~20x faster at small N (Python's interpreter
startup alone is ~40 ms). The prebuilt binary removes even the gcc compile
step (~0.3 s) from the timed path, while the source + fallback keep the
entry runnable anywhere.
