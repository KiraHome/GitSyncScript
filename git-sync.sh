#!/bin/bash
#
# One line version:
#
# git branch | awk 'BEGIN {FS=""; cmd = "git branch | wc -l"; cmd | getline branchCount;base_branch = "master";} {print "\033[92mNumber of branches: " NR "/" branchCount;print "\033[94m" $0 "\033[39m"; for(i=1; i<=NF; ++i){if($i!=" " && $i!="*")var=var""$i;}} {	if("$(git st|grep \"Changes not staged for commit:\")") {system("git stash"); wasStashed=1;} print var;	system("git co " var); system("git pull"); if(wasStashed==1){system("git stash pop"); wasStashed=0;} var="";} END{wasStashed=0;print "\033[92mReturn to original branch: " base_branch "\033[39m"; if("$(git st|grep \"Changes not staged for commit:\")"){system("git stash");wasStashed=1;} system("git co " base_branch); if(wasStashed==1){system("git stash pop");wasStashed=0;}}'
#
# Beautified version:
git branch | awk 'BEGIN {
	FS=""
	cmd = "git branch | wc -l";
	cmd | getline branchCount;
	base_branch = "master";
}

{
	print "\033[92mNumber of branches: " NR "/" branchCount;
	print "\033[94m" $0 "\033[39m";
	for(i=1; i<=NF; ++i)
	{
		if($i!=" " && $i!="*")
			var=var""$i;
	}
	if(NR == 1)
		base_branch = var;
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
}

END {
	#return to base branch and pop the stack content that belongs to it
	wasStashed=0;
	print "\033[92mReturn to original branch: " base_branch "\033[39m";  
	if("$(git st|grep \"Changes not staged for commit:\")") {
		system("git stash");
		wasStashed=1;
	}
	
	system("git co " base_branch);
	
	if(wasStashed==1) {
		system("git stash pop");
		wasStashed=0;
	}
}'
