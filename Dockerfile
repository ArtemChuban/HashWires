FROM ubuntu:noble

RUN apt-get update -q \
    && apt-get install -qy build-essential wget libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

COPY fonts/TimesNewRoman.ttf /usr/local/share/fonts/

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir /install-tl-unx && \
    tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1 && \
    echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile && \
    /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile && \
    rm -r /install-tl-unx install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/2024/bin/x86_64-linux:${PATH}"

RUN tlmgr update --self && \
    tlmgr update --all && \
    tlmgr install latexmk fontspec etoolbox polyglossia setspace

WORKDIR /app

VOLUME ["/data", "/cache"]
