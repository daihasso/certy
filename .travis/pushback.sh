#!/usr/bin/env bash

add_changes() {
  echo "Committing any changes back to repo..."
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
  git remote set-url origin \
      https://${GH_TOKEN}@github.com/DaiHasso/certy.git > /dev/null 2>&1
  git fetch
  git add generated_certs.go .certshash
  git commit --message "Automated Travis Build: $TRAVIS_BUILD_NUMBER"
  git push origin HEAD:master
  echo "Finished pushing back changes to GitHub."
}

add_changes
