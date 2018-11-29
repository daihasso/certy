#!/usr/bin/env bash

add_changes_if_exist() {
  if ! git diff-index --quiet HEAD --; then
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
    git add generated_certs.go .certshash
    git commit --message "Automated Travis Build: $TRAVIS_BUILD_NUMBER"
    git remote add origin-auto \
        https://${GH_TOKEN}@github.com/daihasso/certy.git > /dev/null 2>&1
    git push --quiet --set-upstream origin-auto master
  fi
}

add_changes_if_exist
