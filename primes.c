#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    int n;
    if (scanf("%d", &n) != 1) return 0;
    if (n < 2) { printf("0\n"); return 0; }
    /* odd-only sieve: index i represents 2*i+1 */
    int half = (n - 1) / 2; /* odds 3..n -> indices 1..half */
    unsigned char *s = calloc(half + 2, 1);
    for (int i = 1; ; i++) {
        long p = 2L * i + 1;
        if (p * p > n) break;
        if (!s[i]) {
            for (long j = (p * p - 1) / 2; j <= half; j += p)
                s[j] = 1;
        }
    }
    int count = 1; /* prime 2 */
    for (int i = 1; i <= half; i++)
        count += !s[i];
    printf("%d\n", count);
    return 0;
}
