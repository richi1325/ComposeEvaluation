FROM ubuntu:21.10

RUN ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    tzdata \
    python3-venv \
    python3-pip \
    xvfb \
    git \
    gpg-agent \
    software-properties-common \
    && echo "America/Mexico_City" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV musescoreDirectPNGPath /usr/bin/mscore
ENV directoryScratch /tmp

RUN add-apt-repository ppa:mscore-ubuntu/mscore3-stable

RUN apt-get update

RUN apt-get install -y musescore3

RUN apt-get install -y lilypond > /dev/null
RUN apt-get install -y fluidsynth > /dev/null

COPY ["requirements.txt", "/tsc/"]

WORKDIR /tsc

RUN cp /usr/share/sounds/sf2/FluidR3_GM.sf2 ./font.sf2 

RUN apt-get install -y graphviz

RUN pip install -r requirements.txt

RUN pip install git+https://github.com/louisabraham/python3-midi.git

#COPY [".", "/tsc/"]

EXPOSE 80

CMD ["jupyter-lab", "--ip=*", "--port=80","--no-browser", "--allow-root"]