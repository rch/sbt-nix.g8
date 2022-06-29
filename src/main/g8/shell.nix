{ jdk ? "jdk11" }:

let
  pkgs = import nix/pkgs.nix { inherit jdk; };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.coursier
      pkgs.${jdk}
      pkgs.sbt
      pkgs.python39
      pkgs.python39Packages.virtualenv
    ];
  shellHook = ''
    # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
    # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
    # export PIP_PREFIX=$(pwd)/tools/build/pip_packages
    # export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
    # export PATH="$PIP_PREFIX/bin:$PATH"
    if [ ! -d .venv ]
    then
      python3 -m venv .venv && source .venv/bin/activate
    else
      echo "Found existing Python virtual environment." && source .venv/bin/activate
    fi
    unset SOURCE_DATE_EPOCH
  '';
  }
