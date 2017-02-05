#!/usr/bin/perl

### STARTS THE INSTANCE.

### Creates some files in temp directory called
### -> instanceID.txt which stores instance id.
### -> describe-instances.txt which stores information about the instance.
### -> address.txt which stores address of the instances including its DNS.

use enterkeys;

system("ec2-describe-instances | grep 'INSTANCE' > temp/describe-instances.txt");
open(input, "temp/describe-instances.txt");

@words = split(" ", <input>);
system("echo $words[1] > temp/instanceID.txt");
system("ec2-start-instances $words[1]");
sleep(15);
system("ec2-describe-instances | grep 'INSTANCE' > temp/describe-instances.txt");
open(input, "temp/describe-instances.txt");

@words = split(" ", <input>);
system("echo ubuntu\\\\@"."$words[3] > temp/address.txt");
