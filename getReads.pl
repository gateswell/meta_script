die "perl $0 <kraken report> <kraken table>" if(@ARGV != 2);
#open IA,"/zfssz2/ST_STOMICS/P21Z10200N0096/LC_ST/qiaositan/Stereo_Meta/08.DataBase/k2_standard_20210517/taxid.name.txt";
open IA,"/meta_script/taxid.name.txt" or die "/meta_script/taxid.name.txt unexist!\n";	#modified at 2023-10-25 for image container
while(<IA>){
	chomp;
	my @F=split /\t/;
	my $taxid= $F[0];
	my $genus = $F[6];
	$genus =~ s/g__//;
	$genus{$taxid} = $genus;
}
close IA;

open IB,"gzip -dc $ARGV[0]|" or die "$ARGV[0] unexists\n";
while(<IB>){
	chomp;
	my @F = split /\t/;
	next unless($F[5] =~ /G|S/);
	next if($F[6]==9605 || $F[6] == 9606);
	$kraken{$F[6]}= 1;
}
close IB;

open IC,"gzip -dc $ARGV[1]|" or die "$ARGV[1] unexists\n";
while(<IC>){
	chomp;
	my @F=split /\t/;
	($taxid) = $F[2] =~ /taxid (\d+)/;
	next unless (exists $kraken{$taxid});
	print "$F[1]\t$taxid\t$genus{$taxid}\n";
}
close IC;
