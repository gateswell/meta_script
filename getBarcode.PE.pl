open IA,"gzip -dc $ARGV[0]|" or die "$ARGV[0] unexists\n";
while(<IA>){
	chomp;
	my @F = split /\t/;
	next unless ($_ =~ /^@/);
	print "$_\n";
}
close IA;
