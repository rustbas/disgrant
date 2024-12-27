#/usr/bin/bash

# set -xe

N=20000
SRC_DIR="src"
OBJ_DIR="obj"
MAKEFILE="makefile"
SLEEP_TIME="3"

rm -rf $SRC_DIR
rm -rf $OBJ_DIR

mkdir --parents $SRC_DIR
mkdir --parents $OBJ_DIR

##########
# MAIN.C #
##########

cat > $SRC_DIR/main.c << EOF
#include <stdio.h>

int main() {
    printf("Hello, world!\n");

    return 0;
}
EOF

##########
# LIBS.C #
##########

for i in $(seq $N)
do
    file="$SRC_DIR/lib$i.c"

    cat > $file << EOF
    int add$i(int x, int y) {
        return x + y;
    }
EOF
done

############
# MAKEFILE #
############

echo "CC=distcc" > $MAKEFILE
echo -n "all:" >> $MAKEFILE

for i in $(seq $N)
do
    echo -n " $OBJ_DIR/lib$i.o" >> $MAKEFILE
done

echo "" >> $MAKEFILE

echo "\t\$(CC) $SRC_DIR/main.c $OBJ_DIR/*.o -o res.o" >> $MAKEFILE


for i in $(seq $N)
do
    src_file="$SRC_DIR/lib$i.c"
    obj_file="$OBJ_DIR/lib$i.o"

    echo "$obj_file:" >> $MAKEFILE
    echo "\t\$(CC) $src_file --shared -o $obj_file" >> $MAKEFILE
    echo "\tsleep $SLEEP_TIME" >> $MAKEFILE

done

echo "clean:" >> $MAKEFILE
echo "\trm obj/*" >> $MAKEFILE
