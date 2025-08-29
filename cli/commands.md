# `g` commands
```bash
g --help # `git`, `git --help`

g # `git status`

g repo repoName # initializes git and github/gitlab repo with very reasonable defaults 

g m my commit message # equivalent to `git commit -am 'my commit message'`

g p # `git push && git push --tags`
g pl # `git pull`

g s # `git stash`

g undo

g mm # equivalent to `git checkout master && git merge dev && git push` + only merges if tests pass
g mm --yolo # same as `g mm`, but ignores tests
g mm --friendly # `--force` flag in `git merge`
g mm -f # `--force` flag in `git merge`

g cl url-to-git-repo.git # `git clone --depth 1 --recurse-submodules url-to-git-repo.git repo && cd repo` (also, automatically creates the same branch structure locally as in the remote repo)
g sm url-to-git-repo.git sub/modules/path # `git submodule add --depth 1 url-to-git-repo.git sub/modules/path`

g branchName # git checkout branchName and conditionally creates branchName if it doesn't exist
g b # `git brach -a`

g r # `git reset --hard HEAD`
g r branchName # `git reset --hard branchName`
g r commitHash # `git reset --hard commitHash`

g ls # `git ls-files`
g loc # `git ls-files | xargs wc -l`

g d # `git diff`

# `g` autotags any commit incrementing the patch version using semantic versioning
# it also automatically pushes tags
# to change the status of the current commit to a minor or major version update use the following commands
g f # to tag as a feature (i.e. increment the minor version)
g breaking # to tag as a breaking change (i.e. increment the major version)
```
