tar cvzf encrypt.tar.gz encrypt
cat id_rsa|gpg --batch --yes --passphrase-fd 0 -c encrypt.tar.gz 
git add encrypt.tar.gz.gpg
git commit
git push


