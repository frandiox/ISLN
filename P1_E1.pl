#!/usr/bin/perl -w

use strict;

my $numero = int(rand(101));
my $i = 11;
while($i = $i-1){
	print "Introduce un numero: ";
	$_ = <STDIN>;
	chomp;
	if ($_ > $numero){
		print "El numero buscado es menor\n";
	}elsif ($_ < $numero){
		print "El numero buscado es mayor\n";
	}else{
		die "Has encontrado el numero: $numero\n";
	}
}
print "Has superado los 10 intentos\n";