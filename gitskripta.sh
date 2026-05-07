#!/bin/bash

# 1. Generiši SSH ključ (ako već postoji, preskoči)
KEY_PATH="$HOME/.ssh/id_ed25519"
if [ -f "$KEY_PATH" ]; then
  echo "SSH ključ već postoji na $KEY_PATH"
else
  echo "Generišem novi SSH ključ..."
  ssh-keygen -t ed25519 -C "tvoj_email@example.com" -f "$KEY_PATH" -N ""
fi

# 2. Pokreni ssh-agent i dodaj ključ
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# 3. Prikaži javni ključ da ga možeš dodati na GitHub/GitLab
echo "Dodaj ovaj javni ključ na svoj GitHub/GitLab profil:"
cat "$KEY_PATH.pub"

# 4. Promijeni remote URL na SSH
echo "Unesi ime repozitorija u formatu korisnik/repo (npr. mojuser/mojrepo):"
read REPO
git remote set-url origin git@github.com:$REPO.git

# 5. Testiraj konekciju
ssh -T git@github.com
