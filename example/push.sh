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
SVN=${HOME}/s12/005/svn/users/atw/ps3

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
