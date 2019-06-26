FROM bitnami/ruby:2.6.3

ARG DEBIAN_VERSION="stretch"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
      tee /etc/apt/sources.list.d/yarn.list && \
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-$DEBIAN_VERSION main" | \
      tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && \
    apt-get -y --no-install-recommends install \
      google-cloud-sdk \
      libpq-dev \
      nano \
      nodejs \
      procps \
      yarn \
      && \
    apt-get clean && \
    rm -f /var/lib/apt/lists/*_*;

EXPOSE 8080

WORKDIR /usr/src/app

ENV PORT=8080 \
    RACK_ENV=production \
    RAILS_ENV=production \
    APP_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true
