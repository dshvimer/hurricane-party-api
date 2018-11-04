FROM ruby:2.5.3

RUN apt-get update && apt-get install -y \
  build-essential \
  locales \
  nodejs

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /app
WORKDIR /app

#RUN gem install rails --version 5.1.5
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

CMD ["rm", "-f", "tmp/pids/server.pid", "&&", "bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
