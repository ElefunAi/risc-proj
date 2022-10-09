int main() {
    volatile int a = 3;
    volatile int b = 5;
    volatile int c;
    c = a + b;
    return c;
}