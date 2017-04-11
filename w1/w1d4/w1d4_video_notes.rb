## Video 1
# Why use GIT?
# => to keep track of changes
# => to work on projects in parallel

## Video 2
# Working Directory - where current status lives and is changed

# Staging Area - 'git add' places the changes to wkdr to the staging area,
#                where it is 'to be commited'. 'git diff --stage' to show

# Committing - "git commit -m 'msg'" saves snapshot of project and clears the
#              staging area. any non-added changes remain in the working dir

# Git Branch - 'git branch' shows all of the branches the team is working on
#              'git checkout -b branchname' creates a new branch

# Merging branches - 'git checkout master' => 'git merge branchname' this
#                    commits the changes on the sub brach to the master branch

# Pushing online - 'git remote add origin <paste url>'
#                  'git push -u origin master' pushes the master branch to internet
#                  'push heroku master' code can be pushed to mult spots

# Prev commits - 'git log' copy the hash of the desired commit
#                'git checkout <paste hash>' moves the 'head' back in time


## Video 2
# 'git reset --hard' resets file system to its state at the last commit
#
