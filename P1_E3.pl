#!/usr/bin/perl -w

#use strict;

if ($#ARGV < 0){
	die "Uso:  $^X $0 <archivo de entrada> [<archivo de salida>]\n";
}


### PREPARAR VARIABLES

open INPUT, "<".$ARGV[0] or die "No se pudo abrir $ARGV[0]\n";
my $texto = join '', <INPUT>;
close (INPUT);

open(OUTPUT, '>&', \*STDOUT) or die;

if ($#ARGV >= 1){
	my $output = $ARGV[1];
	if ($output) {
		open(OUTPUT, '>', $output) or die "No se pudo abrir $ARGV[1]";
	}
}


my %palabrasHash;
my %bigramasHash;
$palabrasHash{lc $1}++ while $texto =~ m/(\w+)/g;
$bigramasHash{lc $1}++ while $texto =~ m/(?=(\w+ \w+))\w+/ig;

my @funciones = qw(mostrarRecuentoPalabras mostrarRecuentoBigramas mostrarHashFrecuenciasPalabras mostrarHashFrecuenciasBigramas mostrarHashRimasPalabras mostrarHashRimasBigramas listarPalabrasNletras listarPalabrasSinVocales listarPalabrasConUnaVocal listarPalabrasConDosVocales);
my @parametros = (\$texto, \$texto, \%palabrasHash, \%bigramasHash, \%palabrasHash, \%bigramasHash, \$texto, \$texto, \$texto, \$texto);
my $dialogo = "Introduce el número de función a ejecutar (o cualquier otro valor para salir): \n";
my $indice = 0;
foreach (@funciones){
	$dialogo .= ($indice++).": ".$_."  ";
}
$dialogo .= "\n--------------\n\nInput> ";



### BUCLE DIALOGO

print $dialogo;
while(<STDIN>){
	if (/\d/ and $_ >= 0 and $_ <= $#funciones){
		print $funciones[$_];
		print OUTPUT "\n\nOutput> ";
		$funciones[$_]($parametros[$_]);
	}
	else{
		close(OUTPUT);
		die "Bye\n\n";
	}
	print "\n".$dialogo;
}



### FUNCIONES

sub mostrarRecuentoPalabras{
	my $textoRef = shift;
	my $recuento = () = $$textoRef =~ m/\w+/ig;
	print OUTPUT $recuento."\n";
}

sub mostrarRecuentoBigramas{
	my $textoRef = shift;
	my $recuento = () = $$textoRef =~ m/(?=(\w+ \w+))\w+/ig;
	print OUTPUT $recuento."\n";
}

sub mostrarHashFrecuenciasPalabras {
	mostrarHashFrecuencias(shift);
}

sub mostrarHashFrecuenciasBigramas {
	mostrarHashFrecuencias(shift);
}

sub mostrarHashFrecuencias {
	my $elementosHash = shift;
	print "\n";
	foreach my $elemento ( sort { ${elementosHash}->{$b} <=> ${elementosHash}->{$a} } keys %{$elementosHash}) {
	    print OUTPUT $elemento." - ".${elementosHash}->{$elemento}."\n";
	}
}

sub mostrarHashRimasPalabras {
	mostrarHashRimas(shift);
}

sub mostrarHashRimasBigramas {
	mostrarHashRimas(shift);
}

sub mostrarHashRimas {
	my $elementosHash = shift;
	my $rima = shift || 2;
	#my ($elementosHash, $rima) = @_;
	print "\n";
	foreach my $elemento ( sort { substr($a,-$rima,$rima) cmp substr($b,-$rima,$rima) } keys %{$elementosHash}) {
	    print OUTPUT $elemento." - ".${elementosHash}->{$elemento}."\n";
	}
}

sub listarPalabrasNletras {
	my $textoRef = shift;
	my $nLetras = shift || 4;
	#my ($textoRef, $nLetras) = @_;
	my $recuento = () = $$textoRef =~ m/\b\w{$nLetras}\b/ig;
	print OUTPUT "$recuento palabras encontradas:\n\t=> ";
	print OUTPUT "$1 " while $$textoRef =~ m/\b(\w{$nLetras})\b/ig;
	print OUTPUT "\n";
}

sub listarPalabrasSinVocales {
	my $textoRef = shift;
	my $recuento = () = $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]+\b)\b\w+\b/ig;
	print OUTPUT "$recuento palabras encontradas:\n\t=> ";
	print OUTPUT "$1 " while $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]+\b)\b(\w+)\b/ig;
	print OUTPUT "\n";
}

sub listarPalabrasConUnaVocal {
	my $textoRef = shift;
	my $recuento = () = $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*\b)\b\w+\b/ig;
	print OUTPUT "$recuento palabras encontradas:\n\t=> ";
	print OUTPUT "$1 " while $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*\b)\b(\w+)\b/ig;
	print OUTPUT "\n";
}

sub listarPalabrasConDosVocales{
	my $textoRef = shift;
	my $recuento = () = $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*\b)\b\w+\b/ig;
	print OUTPUT "$recuento palabras encontradas:\n\t=> ";
	print OUTPUT "$1 " while $$textoRef =~ m/(?=\b[b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*[aeiou][b-df-hj-np-tv-z]*\b)\b(\w+)\b/ig;
	print OUTPUT "\n";
}
