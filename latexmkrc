#!/usr/bin/env perl

$latex = 'xelatex -synctex=1 -halt-on-error -file-line-error %O %S';
$latex_silent = 'xelatex -synctex=1 -halt-on-error -file-line-error -interaction=batchmode %O %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$max_repeat = 5;
$pdf_mode = 1; # XeLaTeX directly generates PDF 