#!/usr/bin/perl
$args = @ARGV;

##### LETS USER CONTROL THE GALLERY #####

### Labels are stored in temp/labelimage.txt. Just prints them.
if($ARGV[0] eq "--listlabels")
{
	open(input, "temp/labelimage.txt");
	while(<input>)
	{
		print $_;
	}
}
### Image names are stored in temp/imagelabel.txt with their tags.
### Gets only the names and prints them.
elsif(($ARGV[0] eq "--listimages") and ($args eq 1))
{
	open(input, "temp/imagelabel.txt");
	while(<input>)
	{
		@arr = split(/ /,$_);
		print $arr[0]."\n";
	}
}
### Finds the corresponding images with tagged "labelname" given as parameter.
elsif(($ARGV[0] eq "--listimages") and ($args eq 2))
{
	open(input, "temp/imagelabel.txt");
	while(<input>)
	{
		chomp;
		@arr = split(/ /,$_);
		if(grep {$_ eq $ARGV[1]} @arr)
		{
			print $arr[0]."\n";
		}
	}
}
### For every tag of a given image name, tries to find another image/s that have/has
### same tag/s and prints them.
elsif(($ARGV[0] eq "--listimages") and ($ARGV[1] eq "--similar") and ($args eq 3))
{
	open(input, "temp/imagelabel.txt");
	while(<input>)
	{
		chomp;
		@arr = split(/ /,$_);
		if($arr[0] eq $ARGV[2])
		{
			@tags = @arr;
			foreach $tag (@tags)
			{
				close(input);
				open(input, "temp/imagelabel.txt");
				while(<input>)
				{
					chomp;
					@arr2 = split(/ /,$_);
					if(grep {$_ eq $tag} @arr2)
					{
						if($arr2[0] ne $arr[0])
						{
							push @arr3, $arr2[0];
						}
					}
				}
			}
		}
	}
	sub uniq {
		my %seen;
		grep !$seen{$_}++, @_;
	}
	@imagenames = uniq(@arr3);
	foreach (@imagenames)
	{
		print $_."\n";
	}
}
### Calls searchlabels.pl script and asks for 5 url's from bing.com corresponding to "labelname"
elsif(($ARGV[0] eq "--listsamples") and ($args eq 2))
{
	$script = `perl searchlabels.pl 5 "$ARGV[1]"`;
	print $script;
	open(input, "temp/imagessearched.txt");
	while(<input>)
	{
		print $_;
	}
}
### For every image in the given directory call labelimage.pl script
### and label them with corresponding tags.
elsif(($ARGV[0] eq "--add") and ($args eq 2))
{
	$pwd = qx(pwd);
	chomp($pwd);
	chdir "$ARGV[1]";
	@files = qx(ls);
	chdir "$pwd";
	foreach $image (@files)
	{
		chomp($image);
		$script = `perl labelimage.pl 5 "$ARGV[1]/$image"`;
		print $script;
	}
}