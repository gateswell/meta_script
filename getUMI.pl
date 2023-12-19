open IA,"gzip -dc $ARGV[0]|" or die "$ARG[0] unexists\n";
while(<IA>){
	chomp;
	my @F = split /\t/;
	$info{$F[0]} = "$F[2]\t$F[1]";
}
close IA;

open IB,"gzip -dc $ARGV[1]|" or die "$ARGV[1] unexists\n";
while(<IB>){
	chomp;
	my @F = split /\|\|\|/;
	$F[0] =~ s/^@//;
	next unless (exists $info{$F[0]});
	print "$info{$F[0]}\t$F[1]\t$F[2]\t$F[0]\n";
}
close IB;
