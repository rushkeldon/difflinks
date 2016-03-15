#!/usr/bin/env bash
# don't copy the line above into your .bash_profile

# put the function below in your .bash_profile to have a handy function
# keep 'projectPath' up-to-date to your most current project
# copy the 'doc' directory containing the 'diff_links' directory into your project
# add 'doc' to your .gitignore if you like...


# EDIT : important! keep this path updated to your most current project
export projectPath="/Users/kvr/Desktop/working/difflinks"

# diffLinks
# • gets a list of all files that are different between branches and writes them to fileListPath
# • opens the webpage which reads fileListPath and creates a list of files with links that open in your IDE
# usage :
# $ diffLinks branchname
function diffLinks(){
	cd $projectPath
	local projectName=${PWD##*/}
	local currentBranch=$(git rev-parse --abbrev-ref HEAD);
	local defaultBranch="develop"
	local relativeURL="doc/diff_links/diff_links.html"
	local fileListPath="doc/diff_links/file_list.txt"
	# assume defaultBranch since we have no parameter
	if [ -z "$1" ]; then
		git diff --name-only develop > $fileListPath
		open "http://localhost:8080/$projectName/$relativeURL?currentBranch=$currentBranch&diffBranch=$defaultBranch"
	# branch name was passed in - use it
	else
		git diff --name-only "$1" > $fileListPath
		open "http://localhost:8080/$projectName/$relativeURL?currentBranch=$currentBranch&diffBranch=$1"
	fi
}

