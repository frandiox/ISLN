#!/usr/bin/perl -w

use strict;

my %frases = (
	"hola" => "Hola, ¿qué tal?\n",
	"padre" => "Háblame más de tu padre\n",
	"madre" => "Háblame más de tu madre\n",
	"padres" => "Háblame más de tu padres\n",
	"hermano" => "Háblame más de tu hermano\n",
	"hermana" => "Háblame más de tu hermana\n"
	);

print "Bienvenido, cuéntame qué te preocupa\n";
print "Diálogo> ";
while(<STDIN>){
	chomp;
	if(m/adios/i){
		die "Hasta otra\n";
	}
	my $respuesta = 0;
	for my $palabra (keys %frases){
		if (m/$palabra/i){
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