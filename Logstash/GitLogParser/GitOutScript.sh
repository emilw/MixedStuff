mkdir -p /tmp/git
rm -f /tmp/git/mixedstuff.gitlog
touch /tmp/git/mixedstuff.gitlog
git log --pretty=format:"<commit><committer>%cn</committer><email>%ae</email><message>%s</message><commitId>%H</commitId></commit>" > /tmp/git/mixedstuff.gitlog