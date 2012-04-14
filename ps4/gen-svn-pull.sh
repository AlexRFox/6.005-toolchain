#! /bin/sh

if [ -L svn ]
then
    echo "found symbolic link svn"
    echo "assuming it is a link to ps4 in svn repo"
else
    echo "requires symbolic link called svn to ps4 directory in svn repository"
    exit 1
fi

echo "===="

echo "adding all files from svn to SVN-FILES, attempting to skip svn files."
echo "this is dangerous, you should hand check the result."

find svn/. -type f -print | grep -v \.svn | grep -v \.classpath | grep -v \.project | sed 's#svn/./##g' >> SVN-FILES

echo "===="

echo "removing repeated lines in SVN-FILES"
sort -u SVN-FILES -o SVN-FILES
echo "remember to remove any nonexistent files from SVN-FILES manually!"
