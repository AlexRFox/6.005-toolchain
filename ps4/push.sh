#! /bin/sh

FORCE=0
while getopts ":f" opt; do
    case $opt in
	f)
	    FORCE=1
	    ;;
	\?)
	    echo "usage: install.sh [-f]"
	    ;;
    esac
done

echo "===="

FILES=`cat SVN-FILES`
NOTUP=""
SVN=svn

echo "mirroring directory tree from svn to git"
DIRS=`find src -type d -print`

for d in ${DIRS}
do
    echo svn/$d
    mkdir -p svn/$d
done

echo "===="

for f in ${FILES}
do
    echo -n "copying $f to svn..."
    if [ ${FORCE} -eq 0 ]
    then
	rsync -uL $f ${SVN}/$f
	diff -q $f ${SVN}/$f > /dev/null
	if [ $? -eq 1 ]
	then
	    echo "failed"
	    NOTUP="${NOTUP}$f "
	else
	    echo "done"
	fi
    else
	echo -n "forcing..."
	rsync -L $f ${SVN}/$f
	echo "done"
    fi
done

echo "===="
if [ -z ${NOTUP} ]
then
    echo "all files updated"
else
    echo "files:"
    echo "${NOTUP}"
    echo "not updated. newer versions exist in svn repo. run"
    echo "make force"
    echo "to overwrite files in svn repo"
fi
echo "===="

echo "done!"
