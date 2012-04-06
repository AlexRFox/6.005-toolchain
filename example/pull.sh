#! /bin/sh

FORCE=0
while getopts ":f" opt; do
    case $opt in
	f)
	    FORCE=1
	    ;;
	\?)
	    echo "usage: pull.sh [-f]"
	    ;;
    esac
done

echo "===="

FILES=`cat SVN-FILES`
NOTUP=""
SVN=${HOME}/s12/005/svn/users/atw/ps3

for f in ${FILES}
do
    echo -n "copying $f from svn to git..."
    if [ ${FORCE} -eq 0 ]
    then
	rsync -uL ${SVN}/$f $f
	diff -q ${SVN}/$f $f > /dev/null
	if [ $? -eq 1 ]
	then
	    echo "failed"
	    if [ -z ${NOTUP} ]
	    then
		NOTUP=svn/$f
	    else
		NOTUP="${NOTUP}\nsvn/$f"
	    fi
	else
	    echo "done"
	fi
    else
	echo -n "forcing..."
	rsync -L ${SVN}/$f $f
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
    echo "not pulled. newer versions exist in git repo. run"
    echo "make forcepull"
    echo "to overwrite files in git repo"
fi
echo "===="

echo "done!"
