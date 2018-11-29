#!/usr/bin/env bash

add_changes_if_exist() {
  git remote add origin-auto \
      https://${GH_TOKEN}@github.com/DaiHasso/certy.git > /dev/null 2>&1
  git fetch origin-auto master
  echo "Checking for changes in generated code..."
  if git diff-index --quiet remotes/origin-auto/master --; then
    echo "Nothing to commit, skipping push-back."
  else
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
    git add generated_certs.go .certshash
    git commit --message "Automated Travis Build: $TRAVIS_BUILD_NUMBER"
    git push --set-upstream origin-auto master
    echo "Finished pushing back changes to GitHub."
  fi
}

add_changes_if_exist
