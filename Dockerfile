FROM legalio/alpine-ruby:2.3
MAINTAINER hosh@legal.io

EXPOSE 1080 1025

# Set mailcatcher to listen to all interfaces
# Use docker network portmapping to restrict access
CMD ["/usr/bin/mailcatcher", "--ip", "0.0.0.0", "-f", "-v"]

# Permently add sqlite-libs
# Use --virtual to stage build deps and then delete them
RUN apk --update add sqlite-libs \
  && apk --update add --virtual build_deps \
   build-base ruby-dev libc-dev linux-headers \
   sqlite-dev \
   openssl-dev postgresql-dev libxml2-dev libxslt-dev \
  && gem install mailcatcher \
  && rm -r /root/.gem \
  && find / -name '*.gem' | xargs rm \
  && apk del  build_deps

