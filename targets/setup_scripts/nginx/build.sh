WORKDIR="$PWD/../build/nginx"

ROOT=$PWD
CC=$ROOT/../../../packer/packer/compiler/afl-clang-fast
CPP=$ROOT/../../../packer/packer/compiler/afl-clang-fast++

error () {
  echo "$0: <asan/no_asan>"
  exit 0
}

if test "$#" -ne 1; then
  error
fi

if [ "$1" != "asan" ] && [ "$1" != "no_asan" ] ; then
  error
fi

if test -f "$CC" && test -f "$CPP"; then

  if [ "$1" = "asan" ]; then
    ASAN="-fPIE -fsanitize=address"
  else 
    ASAN="-fPIE "
  fi

  rm -rf $WORKDIR

  mkdir $WORKDIR 

  cd $WORKDIR && \
  wget  http://nginx.org/download/nginx-1.20.0.tar.gz && \
  tar -zxvf nginx-1.20.0.tar.gz && \
  cd nginx-1.20.0 && \
  CC="$CC $ASAN" ./configure && \
  CC="$CC $ASAN" make && \
  echo "SUCCESS"
else
  echo "Error: AFL clang compiler not found:\n\t$CC\n\t$CPP"
fi


