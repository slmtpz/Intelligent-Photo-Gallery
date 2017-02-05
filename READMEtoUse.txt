-In the first upload, scp may ask yes/no question. Answer it yes and go.
-When uploadaws.pl and downloadaws.pl running, if a directory already exists in remote, 
	sftp> mkdir firstupload
	Couldn't create directory: Failure
 will be given as a temporary output. But it is handled, it is no problem.
-uploadaws.pl and downloadaws.pl use sleep function so they may give output a few seconds later.
-Output of script 3 labelimage.pl is in temp folder as "imagelabel.txt" "labelimage.txt"
-Output of script 4 searchlabels.pl is in temp folder as "imagessearched.txt"
-If you upload or download a folder to a folder, it will pass the input folder to inside of output folder.
	means that after the execution of
      # perl downloadaws.pl folder-to-be-downloaded -o folder-to-be-uploaded
	The files in the folder-to-be-downloaded are in the directory
	folder-to-be-uploaded/folder-to-be-downloaded/
-In script 4, searchlabels.pl can only take arguments like
	-> one word "sky"
	or
	-> multiple words "mountain love"
 Since giving arguments to bing in javascript form. ("%20" for blanks, etc.)
-keys.txt should also include your key pair name at last. It should be like
	key
	key
	key
	key
	name-of-key-pair.pem
 and it also should be "chmod 400"
-How many tags an image has and url's shown is determined as 5 when the commands
	"perl gallery.pl --add "dirname"
	"perl gallery.pl --listsamples "labelname"
 I did not add such a parameter in keys.txt or something just because it is an enough number for the purpose.
 This number is arrangable through other scripts of course.
-I assumed the given directory does not include any subdirectories when command called
	"perl gallery.pl --add "dirname""
