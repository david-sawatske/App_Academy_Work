## Reading 1
# Git is a Version Control System.
# => Keeps a log of changes made to a project
# => Revert the project back to a previous state if we mess something up
# => Git also provides us an easier workflow to develop as a team


# Only when we want to push our changes up to the remote "master copy" or
# grab other people's changes do we fetch from or push to Github.

# A typical Git workflow
# => You make changes in your working directory. Your files are now modified.
# => You decide which files you want to add to your next commit and add them to the
#    staging area. Your files are now staged. Don't want a change to be committed?
#    Simple - don't stage that file.
# => You commit all of the files in your staging area and create a snapshot
#    which permanently lives in your local Git directory. Your files are now committed.


## Reading 2
# When STARTING YOUR PROJECT, there are two essential commands.
# => git init #  creates an empty repo in the current directory
# => git remote add your_alias https://github.com/your_username/your_repo_name

# git remote accesses the git commands that interact with remote repos
# add (not to be confused with git add) is a git remote command that adds a remote
# repo to the current repo
# your_alias sets a name you can use locally to refer to the remote repo; use origin
# unless you have a reason not to
# https://github.com/your_username/your_repo_name sets the location of the repo
# (this example is for HTTPS; for SSH, it will look different). You will have to
# create this separately, either in the browser or through the command line.

# WORKING ON PROJECT
# Now you've written some code and are ready to commit. You need three commands:
# git add <files>   add/update specific files
# git add -A # add/update all files
#
# git commit -m "Some comment"
#
# git push
