#!/usr/bin/perl
use imagga;

### LABELS AN IMAGE AND STORES THE INFORMATION.

### Labels the image using imagga.
### Stores the information about the images in the gallery in temp folder as
### -> labelimage.txt which stores unique tags.
### -> imagelabel.txt which stores image names and their tags.
### Updates these files every time this script runs.

open(getkeys, "keys.txt");
<getkeys>; <getkeys>;
$_ = <getkeys>;
chomp;
@keyarr = split(/=/, $_, 2);
$apiKey = $keyarr[1];

$_ = <getkeys>;
chomp;
@keyarr = split(/=/, $_, 2);
$apiSecret = $keyarr[1];

$filePath = $ARGV[1];

$imagga = new imagga($apiKey, $apiSecret);

my( $err, $hash ) = $imagga->tag_image($filePath);

open(label, "temp/labelimage.txt");
while(<label>)
{
	chomp;
	push @labels, $_;
}
open(image, "temp/imagelabel.txt");
$i=0;
while(<image>)
{
	chomp;
	@{$images[$i]} = split(/ /, $_);
	if($images[$i][0] eq $filePath)
	{
		splice @images, $i--;
	}
	$i++;
}
@{$images[$i]} = ($filePath);
$i=0;
for $tag(sort { $hash->{$b} <=> $hash->{$a} } keys(%$hash))
{
	if($i==$ARGV[0])
	{
		last;
	}

	if (grep {$_ eq $tag} @labels)
	{
	}
	else
	{
		push @labels, $tag;
	}

	$imagessize = @images;
	push @{$images[$imagessize-1]}, $tag;
	$i++;
}
system("> temp/labelimage.txt");
foreach $tag (@labels)
{
	system("echo $tag >> temp/labelimage.txt");
}
system("> temp/imagelabel.txt");
foreach $sub (@images)
{
	foreach $ele (@$sub)
	{
		system("printf $ele' ' >> temp/imagelabel.txt");
	}
	system("printf '\n' >> temp/imagelabel.txt");
}