#!/bin/sh

find ./ -name '*.[ch]' -o -name '*.[ch]pp' -o -name '*.cc' -o -name '*.py' > ./cscope.files
cscope -bqk
ctags --fields=+liaS --extra=+q -L cscope.files