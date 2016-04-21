BootstrapSolaris() {
  if hash /opt/csw/bin/pkgutil 2>/dev/null; then
    echo "Using openCSW pkgutil to install dependencies..."
    pkgman=/opt/csw/bin/pkgutil
  else
    echo "No openCSW found; installing it ..."
    pkgadd -d http://get.opencsw.org/now
    /opt/csw/bin/pkgutil -U
    pkgman=/opt/csw/bin/pkgutil
  fi
  PATH=/opt/csw/bin/:/opt/csw/sbin/:$PATH

  pkgcmd="$pkgman -i"
  $pkgcmd augeas
  $pkgcmd dialog
  $pkgcmd python
  $pkgcmd curl
  $pkgcmd gcc4g++
  $pkgcom gcc5g++

  if ! hash pip 2>/dev/null; then
      echo "pip not installed"
      echo "Installing pip..."
      curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python
  fi

  if ! hash virtualenv 2>/dev/null; then
      echo "virtualenv not installed."
      echo "Installing with pip..."
      pip install virtualenv
  fi
}
