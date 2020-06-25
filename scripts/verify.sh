#!/bin/sh

$1=besu-xt
file1=`md5 -q $1`
file2=`cut -d* -f1 $1.md5`

echo "Checking file: $1"
echo "Using MD5 file: $1.md5"
echo $file1
echo $file2

if [ $file1 != $file2 ]
then
  echo "md5 sums mismatch"
else
  echo "checksums OK"
fi

echo "GPG verification output"
gpg --verify $1.asc $1
