open IA,"gzip -dc $ARGV[0]|";
while(<IA>){
	chomp;
	my @F = split /\t/;
	next unless ($_ =~ /^@/);
	print "$_\n";
}
