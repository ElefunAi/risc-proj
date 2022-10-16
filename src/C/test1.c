int main() {
    volatile int a = 10;
    volatile int b = 8;
    volatile int c;
    c = a + b;
    return c;
}