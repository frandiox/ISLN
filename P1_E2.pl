#!/usr/bin/perl -w

use strict;

my %frases = (
	"hola" => "Hola, ¿qué tal?\n",
	"padre" => "Háblame mas de tu padre\n",
	"madre" => "Háblame mas de tu madre\n",
	"padres" => "Háblame mas de tu padres\n",
	"hermano" => "Háblame mas de tu hermano\n",
	"hermana" => "Háblame mas de tu hermana\n",
	);

print "Bienvenido, cuéntame qué te preocupa\n";
print "Diálogo> ";
while(<STDIN>){
	chomp;
	if($_ eq "adios"){
		die "Hasta otra\n";
	}
	my $respuesta = 0;
	foreach my $palabra (split(/ /, $_)){
		$palabra = lc($palabra);
		if (defined $frases{$palabra}){
			print $frases{$palabra};
			$respuesta = 1;
			last;
		}
	}
	if ($respuesta == 0){
		print "Muy interesante, sigue contando\n";
		$respuesta = 1;
	}
	print "Diálogo> ";
}