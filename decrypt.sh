#!/bin/bash
cat id_rsa|gpg --batch --yes --passphrase-fd 0 -o decrypt.tar.gz  -d encrypt.tar.gz.gpg

