#! /bin/sh

echo "adding all *.java files from svn to SVN-FILES"
find src -name "*.java" -print >> SVN-FILES
echo "removing repeated lines in SVN-FILES"
sort -u SVN-FILES -o SVN-FILES
echo "remember to remove any nonexistent files from SVN-FILES manually!"
