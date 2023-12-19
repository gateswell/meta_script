my @b = ("00","01","10","11");
my @nt = ("A","C","G","T");
for my $i (0..$#b){
	$nt{$b[$i]} = $nt[$i];
}

open IB,"gzip -dc $ARGV[0]|" or die "$ARGV[0] unexists\n";
while(<IB>){
	chomp;
	next unless ($_ =~ /^@/);
	my($reads,$bar,$umi) = split /\s+/;
	$dec = hex($bar);
	$bin = sprintf("%048b",$dec);
	@arr = $bin =~ /../g;
	my $barcode;
	for my $arr (@arr){
		my $nt = $nt{$arr};
		$barcode .= $nt;
	}
	$barcode{$barcode} = "$reads\t$umi";
}
close IB;

open IC,"gzip -dc $ARGV[1]|" or die "$ARGV[1] unexists\n"; ###### chip.txt
while(<IC>){
	chomp;
	my($bar,$x,$y) = split /\t/;
	$bar =~ s/^.//;
	next unless (exists $barcode{$bar});
	my($reads,$umi) = split /\t/,$barcode{$bar};
	print "$reads|||CB:Z:$x\_$y|||UR:Z:$umi\n";
}
close IC;











