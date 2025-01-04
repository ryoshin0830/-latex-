#!/usr/bin/env perl

$latex = 'uplatex -synctex=1 -halt-on-error -file-line-error %O %S';
$latex_silent = 'uplatex -synctex=1 -halt-on-error -file-line-error -interaction=batchmode %O %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -U -o %D %S';
$max_repeat = 5;
$pdf_mode = 3; 