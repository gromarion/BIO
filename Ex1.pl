use Bio::SeqIO;
# get command-line arguments, or die with a usage statement
my $usage    = "Ex1.pl infile informat outfile\n";
my $infile   = shift or die $usage;
my $informat = shift or die $usage;
my $outfile  = shift or die $usage;
 
# create one SeqIO object to read in, and another to write out
my $seqin = Bio::SeqIO->new(
                            -file   => "<$infile",
                            -format => $informat,
                            );
 
my $seqout = Bio::SeqIO->new(
                             -file   => ">$outfile",
                             -format => 'Fasta',
                             );
 
# write each entry in the input to the output file
while (my $inseq = $seqin->next_seq) {
    $seqout->write_seq($inseq);
}
