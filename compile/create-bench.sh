#/usr/bin/bash

# set -xe

N=2

cat > main.c << EOF
#include <stdio.h>

int main() {
    printf("Hello, world!\n");

    return 0;
}
EOF

mkdir --parents src 

for i in $(seq $N)
do
    touch src/lib$i.c
done
