#!/usr/bin/env bash

cd `dirname $0`/..

bundle exec middleman build
mkdir -p $HOME/.ssh
chmod go-rwx $HOME/.ssh
cp misc/travis_rsa $HOME/.ssh

rsync --delete-excluded -Pacv \
  -e "ssh -o 'StrictHostKeyChecking no' -i $HOME/.ssh/travis_rsa" \
  build/ alex@alexn.org:/var/www/alexl.ro/
