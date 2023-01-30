FROM ruby:3.2.0-slim

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem update --system && gem install bundler

RUN bundle install

# Just for a better reading
COPY . /app

RUN mkdir -p /app/health_check_files/pids

COPY /docker/startup.sh /usr/bin/
RUN chmod +x /usr/bin/startup.sh

COPY /docker/prepare-db.sh /usr/bin/
RUN chmod +x /usr/bin/prepare-db.sh

ENTRYPOINT ["/usr/bin/startup.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
