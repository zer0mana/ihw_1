#include <stdio.h>

static int ARRAY_A[1048576];
static int ARRAY_B[1048576];

int createArray(int n) {
    int i, average, x;
    average = 0;
    for (i = 0; i < n; ++i) {
        scanf("%d", &x);
        ARRAY_A[i] = x;
        average += x;
    }
    average /= n;
    return average;
}

int main() {
    int n, i, average, sum;
    scanf("%d", &n);
    average = createArray(n);
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
