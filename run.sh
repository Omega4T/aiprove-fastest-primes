#!/bin/sh
# fastest-primes entry — run command: ./run.sh
# Reads N on stdin, prints the count of primes <= N on stdout.
# Kept minimal (no subshells): shell-startup overhead is part of the
# timed path, so every fork counts.
#
#   1. Fresh prebuilt binary -> run it directly (zero compile overhead).
#   2. Otherwise compile primes.c with gcc -O3 and run it.
#   3. If gcc is missing, fall back to the Python sieve (still correct).
D=${0%/*}
[ "$D" = "$0" ] && D=.
if [ -x "$D/primes" ] && [ "$D/primes.c" -ot "$D/primes" ]; then
    "$D/primes" && exit 0
fi
if command -v gcc >/dev/null 2>&1; then
    gcc -O3 -o "$D/primes" "$D/primes.c" 2>/dev/null && exec "$D/primes"
fi
exec python3 "$D/primes.py"
