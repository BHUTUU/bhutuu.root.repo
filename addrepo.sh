#!/usr/bin/env bash
CWD=$(pwd)
var1="$1"
var2="$2"
var3="$3"
#<<<-----colors----->>>#
S0="\033[1;30m" B0="\033[1;40m"
S1="\033[1;31m" B1="\033[1;41m"
S2="\033[1;32m" B2="\033[1;42m"
S3="\033[1;33m" B3="\033[1;43m"
S4="\033[1;34m" B4="\033[1;44m"
S5="\033[1;35m" B5="\033[1;45m"
S6="\033[1;36m" B6="\033[1;46m"
S7="\033[1;37m" B7="\033[1;47m"
R0="\033[00m"   R1="\033[1;00m"
#<---x--->#
addrepo() {
  sudo apt install gnupg -yq --silent
  if [[ ! -d "/etc/apt/sources.list.d" ]]; then
    sudo mkdir -p /etc/apt/sources.list.d
  fi
# sudo cat <<- CONF > /etc/apt/sources.list.d/bhutuu.root.repo.list
echo "deb [arch=amd64,arm64,aarch64,arm,i686 signed-by=/etc/apt/keyrings/bhutuu.gpg] https://bhutuu.github.io/bhutuu.root.repo/ bhutuu main" | sudo tee "/etc/apt/sources.list.d/bhutuu.root.repo.list" >/dev/null 2>&1
# CONF
  wget -q https://raw.githubusercontent.com/BHUTUU/bhutuu.root.repo/main/bhutuu.key
  # sudo apt-key add bhutuu.key
  sudo install -D -o root -g root -m 644 bhutuu.key /etc/apt/keyrings/bhutuu.gpg
  sudo apt-get update -yq --silent
  # cp -r $PREFIX/etc/apt/trusted.gpg $PREFIX/etc/apt/trusted.gpg.d/trusted.bhutuu.gpg
  printf "\n${S2}BHUTUU APT REPOSITORY IS SUCCESSFULLY ADDED${R0}\n"
  printf "\n\n${S6}just run '${B1}apt install PROGRAM_NAME${R1}${S6}' to install a valid program!${R0}\n"
}
rmrepo() {
  sudo rm -rf /etc/apt/sources.list.d/bhutuu.root.repo.list > /dev/null 2>&1
  sudo rm -rf /etc/apt/keyrings/bhutuu.gpg > /dev/null 2>&1
  printf "\n${S2}BHUTUU APT REPOSITORY IS REMOVED FROM YOUR DEVICE${R0}\n"
}
helprepo() {
  echo -e "
  USAGE:
        -i    --install      to install bhutuu.root.repo in you Device.

        -r    --remove       to remove bhutuu.root.repo from your Device.
  "
}
main() {
  if [[ $var1 == '-i' || $var1 == '--install' ]]; then
    if [[ ! -f "$PREFIX/etc/apt/sources.list.d/bhutuu.root.repo.list" ]]; then
      addrepo
    else
      printf "\n${S2}[${S1}!${S2}]${S4} BHUTUU APT REPOSITORY IS ALREADY ADDED!${R0}\n"
      printf "\n\n${S6}just run '${B1}apt install PROGRAM_NAME${R1}${S6}' to install a valid program!${R0}\n"
    fi
    if [[ ! -z "${var2}" ]]; then
      sudo apt install "${var2}" -y
    fi
  elif [[ $var1 == '-r' || $var1 == '--remove' ]]; then
    rmrepo
  else
    helprepo
  fi
}
main
