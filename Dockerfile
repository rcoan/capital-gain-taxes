FROM ruby:2.6.8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR .

COPY . .

RUN gem build capital-gain-taxes.gemspec && gem install ./capital-gain-taxes-0.0.1.gem

RUN bundle install
