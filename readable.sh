IFS=$'\n'
P=""
F=""
for i in $(find . -type f -printf "%U %m %k %A+ " -exec md5sum {} \; | awk '{printf "%s %5s %5s %s %s %s\n", $5, $1, $2, $4, $3, $6}' | sort -r | uniq -D -w 43) ; do

    IFS=' ' && ARRAY=($i)

    if [ "$P" == "${ARRAY[0]}" ] ;
    then
        rm ${ARRAY[5]}
        ln $F ${ARRAY[5]}
        SIZE=$(($SIZE + ${ARRAY[4]}))
    else 
        echo space saved $SIZE
        P=${ARRAY[0]} && F=${ARRAY[5]} && SIZE=0
    fi

done
