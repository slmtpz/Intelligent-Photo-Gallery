#!/usr/bin/perl

### DOWNLOADS FILE/FOLDER FROM REMOTE MACHINE/INSTANCE TO LOCAL.

### Download process is being handled with SCP.

open(getaddress, "temp/address.txt");
$address = <getaddress>;
chomp($address);

open(input, "keys.txt");
while(<input>)
{
	$keypair = $_;
}

my $size = @ARGV;

$directory = $ARGV[$size-1];
system("mkdir $directory");
sleep(5);
for($i=0; $i<$size-2; $i++)
{
	system("scp -i $keypair -r $address:$ARGV[$i] $directory\n");
}