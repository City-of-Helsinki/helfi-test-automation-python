FROM python:3

MAINTAINER Many Kasiriha <manykarim@users.noreply.github.com>
LABEL DocTest Library for Robot Framework in Docker

ARG release_name=gs952
ARG archive_name=ghostpcl-9.52-linux-x86_64

RUN mkdir robotframework-doctestlibrary
WORKDIR robotframework-doctestlibrary
RUN git clone https://github.com/manykarim/robotframework-doctestlibrary.git

#COPY requirements.txt /tmp/requirements.txt
#COPY ./ /tmp/robotframework-doctestlibrary
RUN pip install --no-cache-dir numpy
#RUN pip install --no-cache-dir -r /tmp/requirements.txt
WORKDIR robotframework-doctestlibrary
RUN python setup.py install
WORKDIR    /
RUN apt-get update && apt-get install -y \
    imagemagick \
    tesseract-ocr \
    ghostscript \
    wget \
    libdmtx0b \
    software-properties-common \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/${release_name}/${archive_name}.tgz \
  && tar -xvzf ${archive_name}.tgz \
  && chmod +x ${archive_name}/gpcl6* \
  && cp ${archive_name}/gpcl6* ${archive_name}/pcl6 \
  && cp ${archive_name}/* /usr/bin

RUN pip install --upgrade robotframework-seleniumlibrary


#COPY policy.xml /etc/ImageMagick-6/
COPY ./ /helfi-robotframework
RUN apt-get update
# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 90.0.4430.24
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

WORKDIR    /

