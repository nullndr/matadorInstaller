#! /usr/bin/env sh

installMantine() {
  remixRootDir=$1
  cd $remixRootDir
  
  if [[ -f "package-lock.json" ]]; then
    if ! npm --version > /dev/null 2>&1; then
      echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] found package-lock.json but I can't run \x1b[36mnpm\x1b[39m\x1b[0m"
      exit 1
    fi

    echo -e "\x1b[1m[ ℹ️  ] installing \x1b[36m@mantine/core\x1b[39m package with npm\x1b[0m"
    npm install @mantine/core
  else
    if [[ -f "yarn.lock" ]]; then
      if ! yarn --version > /dev/null 2>&1; then
        echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] found yarn.lock but I can't run \x1b[36myarn\x1b[39m\x1b[0m"
        exit 1
      fi

      echo -e "\x1b[1m[ ℹ️  ] installing \x1b[36m@mantine/core\x1b[39m package with yarn\x1b[0m"
      yarn add @mantine/core
    else
      echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] I dont know how to install the \x1b[36m@mantine/core\x1b[39m package\x1b[0m"
      exit 1
    fi
  fi

  if [[ $? -ne 0 ]]; then
    echo -e -n "\x1b[1m[ ❌ ] something went wrong while installing the package, aborting\x1b[0m "
    exit 1
  fi

}

checkRemixDir() {
  remixRootDir=$(realpath $1)
  if ! [[ -f "${remixRootDir}/remix.config.js" ]]; then
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] the $remixRootDir directory does not look like a Remix project, aborting\x1b[0k"
    exit 1
  fi
}

checkAppDir() {
  isError=0
  remixAppDir=$1
  if [[ ! -d "$remixAppDir" ]]; then
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] directory \"$remixAppDir\" not found\x1b[0m"
    isError=1
  fi

  if [[ -f "$remixAppDir/routes/matador.tsx" ]]; then
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] file \"$remixAppDir/routes/matador.tsx\" already exists\x1b[0m"
    isError=1
  fi

  if [[ -d "$remixAppDir/routes/matador" ]]; then
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] directory \"$remixAppDir/routes/matador\" already exists\x1b[0m"
    isError=1
  fi

  if [[ -d "$remixAppDir/lib/matador" ]]; then
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] directory \"$remixAppDir/lib/matador\" already exists\x1b[0m"
    isError=1
  fi

  if [[ isError -eq 1 ]]; then
    echo -e -n "\x1b[1m[ ❌ ] aborting \x1b[36mMatador\x1b[39m installation for the above reasons\x1b[0m "
    exit 1
  fi
}

main() {
  if [[ $# -gt 2 ]]; then 
    echo -e "\x1b[1m[ \x1b[31mError\x1b[39m ] invalid arguments, aborting\x1b[0m"
    exit 1
  fi

  checkRemixDir $1
  remixAppDir=$(realpath "$1/$([[ $2 != "" ]] && echo $2 || echo "app")")
  checkAppDir $remixAppDir


  echo -e "\x1b[1m[ ℹ️  ] Matador needs the \x1b[36m@mantine/core\x1b[39m package, the script is gonna install it\x1b[0m"
  echo -e -n "\x1b[1m[ ❔ ] are you okay with this? [y/n]\x1b[0m "
  read -n 1
  echo

  case $REPLY in 

    y | Y ) 
    installMantine $remixRootDir 
    echo 
    echo -e "\x1b[1m[ ℹ️  ] I successfully installed the \x1b[36m@mantine/core\x1b[39m package\x1b[0m"
    ;;

    n | N )
      echo -e -n "\x1b[1m[ ❌ ] aborting \x1b[36mMatador\x1b[39m  installation on $remixRootDir dir\x1b[0m "
      exit 1
    ;;

    * ) exit 1 ;;
  esac
}

echo
main $@