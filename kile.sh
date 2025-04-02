#!/bin/sh -e

if [ -d /app/texlive/bin ] && [ -d /app/texlive/lib ]; then
    arch=$(uname -m)
    # Add paths of TeX Live Flatpak extension binaries
    export PATH=$PATH:/app/texlive/bin:/app/texlive/bin/$arch-linux
    # Add library paths
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/texlive/lib
else
    echo "warning: missing required extension: org.freedesktop.Sdk.Extension.texlive"
fi

cd # This is required to avoid Kile closing with "Program to run not set."
exec kile "$@"
