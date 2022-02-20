FROM ruby:2.7.3
RUN apt-get update && apt-get install -y \
    locales \
    locales-all \
    libopus-dev \
    libopus0 \
    libsodium-dev
WORKDIR /app
COPY Gemfile /app/
ENV LANG ja_JP.UTF-8
RUN bundle install
COPY app.rb /app/
COPY views/ /app/views/
COPY public/ /app/public/
COPY db/ /app/db/
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0"]