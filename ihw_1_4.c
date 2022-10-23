#include <stdio.h>

static int ARRAY_A[1048576];
static int ARRAY_B[1048576];

int main() {
    int n, i, x, average, sum;
    scanf("%d", &n);
    average = 0;
    for (i = 0; i < n; ++i) {
        scanf("%d", &x);
        ARRAY_A[i] = x;
        average += x;
    }
    average /= n;
    sum = ARRAY_A[0];
    for (i = 0; i < n && ARRAY_A[i] <= average;) {
        ARRAY_B[i] = sum;
        printf("%d", ARRAY_B[i]);
        printf(" ");
        sum += ARRAY_A[++i];
    }
    if (i != n) {
        ARRAY_B[i] = sum;
        printf("%d", ARRAY_B[i]);
    }
    return 0;
}
