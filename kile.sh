#!/bin/sh -e

if [ -d /app/texlive/bin ] && [ -d /app/texlive/lib ]; then
    arch=$(uname -m)

    # Find the Perl version of the TeX Live Flatpak extension
    perl_version=$(find /app/texlive/lib/perl5 -type f -name libperl.so | head -1 | awk -F/ '{print $6}')
    if [ -z "$perl_version" ]; then
        echo "error: unable to resolve org.freedesktop.Sdk.Extension.texlive perl5 version" >&2
	exit 1
    fi

    # Add paths of TeX Live binaries
    export PATH="$PATH":/app/texlive/bin:/app/texlive/bin/"$arch"-linux

    # Add library paths
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/app/texlive/lib:/app/texlive/lib/perl5/"$perl_version"/"$arch"-linux/CORE

    # Add Perl paths
    export PERL5LIB=/app/texlive/lib/perl5/"$perl_version":/app/texlive/lib/perl5/site_perl
else
    echo "warning: missing required extension: org.freedesktop.Sdk.Extension.texlive" >&2
fi

cd # This is required to avoid Kile closing with "Program to run not set."
exec kile "$@"
