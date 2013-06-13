#!/bin/bash
#
# Script to update git completion script.

function git_completion_commit {
  echo "Commiting..."
  COMMIT_MSG="Update git-completion.bash"
  git add git-completion.bash >/dev/null
  git commit -m "${COMMIT_MSG}" >/dev/null
  echo "Done."

  echo ""

  echo "Remember to push."
}

if [ -f git-completion.bash ]; then
  echo "Backing up git-completion.bash ..."
  cp git-completion.bash git-completion.bash.bk >/dev/null
  echo "Done."

  echo "";
fi

echo "Downloading git-completion.bash ..."
curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
echo "Done."

echo ""

if [ -f git-completion.bash.bk ]; then
  echo "Comparing ..."
  if diff git-completion.bash git-completion.bash.bk >/dev/null; then
    echo "Nothing new."
    rm git-completion.bash.bk
  else
    echo "Got a new version!"
    rm git-completion.bash.bk >/dev/null

    echo "";

    git_completion_commit
  fi
else
  git_completion_commit
fi

echo ""
echo "Bye."

