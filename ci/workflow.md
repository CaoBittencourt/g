# Example Workflow
## With Git
```bash
git add "$(pwd)"/** # 1. add all changed files in current working directory recursively
git commit -m 'my commit message' # 2. create a commit with message 'my commit message'
git push # 3. push changes to remote dev
git checkout -b temp origin/HEAD # 4. checkout to a temporary copy of the remote master branch
git merge origin/dev # 5. merge latest changes in remote dev branch
git push origin HEAD:master # 6. push changes to remote master branch
git checkout dev # 7. go back to local dev branch
git branch -D temp # 8. delete temporary local master branch
```

## With g
```bash
g my commit message # steps 1 and 2
g p # step 3
g mm # steps 4, 5, 6, 7, 8
```
