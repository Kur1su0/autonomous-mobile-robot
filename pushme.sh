COMMIT=$1
echo $COMMIT


git add --all
git commit -m "$COMMIT"

git push
