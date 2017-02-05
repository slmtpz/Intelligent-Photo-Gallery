#!/usr/bin/perl

### UPLOADS FILE/FOLDER FROM LOCAL TO REMOTE MACHINE/INSTANCE.

### Using SFTP to create the corresponding folder in the instance.
### Using SCP to upload files.

open(getaddress, "temp/address.txt");
$address = <getaddress>;
chomp($address);

open(input, "keys.txt");
while(<input>)
{
	$keypair = $_;
}

$startftp = "| sftp -o IdentityFile=$keypair $address";
open(FH, $startftp);

my $size = @ARGV;

$directory = $ARGV[$size-1];
print FH "mkdir $directory\n";
sleep(5);
for($i=0; $i<$size-2; $i++)
{
	system("scp -i $keypair -r $ARGV[$i] $address:$directory\n");
}