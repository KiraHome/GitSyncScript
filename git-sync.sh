#!/bin/bash
#
# One line version:
#
# git branch | awk 'BEGIN {FS=""; cmd = "git branch | wc -l"; cmd | getline branchCount;} {print "Number of branches: " NR "/" branchCount; print $0; for(i=1; i<=NF; ++i){if($i!=" " && $i!="*")var=var""$i;}} {	if("$(git st|grep \"Changes not staged for commit:\")") {system("git stash"); wasStashed=1;} print var;	system("git co " var); system("git pull"); if(wasStashed==1){system("git stash pop"); wasStashed=0;} var="";}'
#
# Beautified version:
git branch | awk 'BEGIN {
	FS=""
	cmd = "git branch | wc -l";
	cmd | getline branchCount
}

{
	print "Number of branches: " NR "/" branchCount;
	print $0
	for(i=1; i<=NF; ++i)
	{
		if($i!=" " && $i!="*")
			var=var""$i;
	}
}

{
	if("$(git st|grep \"Changes not staged for commit:\")") {
		system("git stash");
		wasStashed=1;
	}
	
	print var;
	system("git co " var);
	system("git pull");
	
	if(wasStashed==1) {
		system("git stash pop");
		wasStashed=0;
	}
	var="";
}'
