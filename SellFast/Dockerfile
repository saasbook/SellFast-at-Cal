FROM ruby:2.6.5
RUN apt-get update && apt-get install -y postgresql

# install yarn
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn

RUN yarn install --check-files
RUN yarn check --integrity

RUN mkdir /SellFast
WORKDIR /SellFast
COPY Gemfile /SellFast/Gemfile
COPY Gemfile.lock /SellFast/Gemfile.lock
RUN gem update --system
RUN gem install bundler -v 2.0.2
RUN bundle install
RUN bundle update --bundler
COPY . /SellFast

EXPOSE 3000