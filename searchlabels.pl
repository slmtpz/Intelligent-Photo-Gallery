#!/usr/bin/perl

### SEARCH FOR IMAGES ON BING.COM AND RETURNS URL'S IN A FILE.

### Using bing.com, search for images as to given parameter "tag".
### The following HTML source code (grepped) is stored in a file in temp folder named
### source.txt
### Using regex, URL's is being found and written in a file in temp folder named
### imagessearched.txt

@bing = split(/ /, $ARGV[1]);
foreach $ele (@bing)
{
	$search .= $ele."%20";
}
system("curl -s https://www.bing.com/images/search?q=$search | grep 'imgurl:' > temp/source.txt");
system("> temp/imagessearched.txt");
open(input, "temp/source.txt");
while(<input>)
{
	for($i=0; $i<$ARGV[0]; $i++)
	{
		if(/imgurl:&quot;[^&]*/)
		{
			@ok = split(/;/, $&, 2);
			system("echo $ok[1] >> temp/imagessearched.txt");
			$_ = $';
		}
	}

}