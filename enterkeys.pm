#!/usr/bin/perl

##### ENTERS KEYS AS ENVIRONMENT VARIABLES #####

open(getkeys, "keys.txt");
$_ = <getkeys>;
chomp;
@keyarr = split(/=/, $_, 2);
$ENV{AWS_ACCESS_KEY}="$keyarr[1]";

$_ = <getkeys>;
chomp;
@keyarr = split(/=/, $_ ,2);
$ENV{AWS_SECRET_KEY}="$keyarr[1]";

$ENV{JAVA_HOME}="/usr/lib/jvm/java-7-openjdk-amd64/jre";

$ENV{EC2_HOME}="/usr/local/ec2/ec2-api-tools-1.7.3.2";

$ENV{EC2_URL}="ec2.us-west-2.amazonaws.com";