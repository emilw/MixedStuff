#!/bin/bash 
function quit {
    exit
}  

function my_write {
    echo "$@"
}  

text="Hello world from variable"

my_write $text
my_write "Hello world"
quit