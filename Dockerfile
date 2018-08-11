FROM httpd:2.4

RUN apt-get update && apt-get upgrade
RUN apt-get -y install curl git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get upgrade
RUN apt-get -y install --no-install-recommends yarn nodejs phantomjs
RUN cd / && git clone https://github.com/allenday/kiwiirc-1.git kiwiirc
RUN cd /kiwiirc ; QT_QPA_PLATFORM=offscreen yarn install
RUN cd /kiwiirc ; QT_QPA_PLATFORM=offscreen yarn run build
RUN mkdir -p /usr/local/apache2/htdocs/widget
RUN cp -pr /kiwiirc/dist/* /usr/local/apache2/htdocs/
