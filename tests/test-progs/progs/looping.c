
//#include <stdio.h>

int main(int argc, char **argv) {
    unsigned int sumi = 0;
    float sumf = 0.0;
    
    for (int i = 0; i < 10000; i++) {
        if (i % 3 == 0) {
            sumi++;
        }
        else if (i % 7 == 0) {
            sumf += 0.75;
        }
        else if (i % 17 == 0) {
            sumf += 0.33;
            sumi += 3;
        }
    }
    //printf("hello rv.\n");
}
