# difflinks
#### a bash function that works with a txt file and an html page to create a list of links to files that are different between branches in a git repo

## Prerequistes
* git
* an IDE (such as IntelliJ IDEA 15) that a) creates a web server on port 8080 and b) supports the file protocol for links such as `http://localhost:63342/api/file/projectroot/.../filename.ext`

## Getting Started
* download the ZIP or fork / clone this repo to your local machine
* put the function below in your ~/.bash_profile
* keep 'projectPath' up-to-date to your most current project
* copy the 'doc' directory containing the 'diff_links' directory into your current project
* add 'doc' to your .gitignore if you like... (I do!)
* on `line 257` in `diff_links.html` there is an array of file extensions to ignore - you may want to edit this

### Current excludeExtensions
```javascript
var excludeExtensions = [
    '.css',
    '.js',
    '.project'
];
```

### Function for your ~/.bash_profile

```bash
    # EDIT : important! keep this path updated to your most current project
    export projectPath="/Users/kvr/Desktop/working/difflinks"
    
    # diffLinks
    # • gets a list of all files that are different between branches and writes them to fileListPath
    # • opens the webpage which reads fileListPath and creates a list of files with links that open in your IDE
    # usage :
    # $ diffLinks [branchname]
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
```
### Example of Web Page Link List
![Example List](http://appcloud9.com/img/diff_links.png)

