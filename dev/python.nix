{ config, pkgs, lib, ... }:
let
# TODO: this file is not included right now, it needs to be debugged.
  pyPkgList = (with lib.python3Packages; [
    coverage
    ipython         # IPython: Productive Interactive Computing
    # ipywidgets      # IPython HTML widgets for Jupyter
    jupyterlab
    jupyterlab_launcher
    pep8
    pip             # The PyPA recommended tool for installing Python packages
    pipenv
    prompt_toolkit
    pyflakes
    pygments        # A generic syntax highlighter
    pylint
    pytest
    requests        # An Apache2 licensed HTTP library, written in Python, for human beings
    setuptools
  ]);

  mapPkg = (p: p.overrideAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
  }));

in pkgs.python3Full.buildEnv.override {
  extraLibs = (map mapPkg pyPkgList);
  ignoreCollisions = true;
}