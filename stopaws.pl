#!/usr/bin/perl

##### STOPS A RUNNING INSTANCE #####

use enterkeys;

open(getID, "temp/instanceID.txt");
$id = <getID>;
system("ec2-stop-instances $id");