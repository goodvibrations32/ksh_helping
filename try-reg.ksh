#!/bin/ksh

base="/home/gv32/work/site/website"
cd $base

# 
cd generated/
print
print "Error files"
print "~~~~~~~~~~~"
print @([3-5]*html)   # match errors for errdocs
print
print "pages and sylesheet"
print "~~~~~~~~~~~~~~~~~~~"
print @([a-z]*html|*css)
cd ../

#            cp generated/@(*html|*css) $base/../

print
print "the base folder needs to be accessed and then we have the patern matching"
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
print "$base"
