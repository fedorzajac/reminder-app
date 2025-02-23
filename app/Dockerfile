FROM ruby:3.3.5-alpine

ARG WORKDIR
ARG FRONT_PORT

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Europe/Bratislava

RUN echo ${HOME}

WORKDIR ${HOME}

COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
