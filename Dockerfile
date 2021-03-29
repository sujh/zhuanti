FROM ruby:2.7.2-alpine

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \
 && apk add --no-cache build-base tzdata git shared-mime-info

ARG RAILS_ENV=development

ENV LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    RAILS_ENV=${RAILS_ENV} \
    APP_DIR=/zhuanti_app \
    ZHUANTI_DATABASE_PASSWORD=d245Deba \
    SECRET_KEY_BASE=6c4a5b185f552350b5d79b0bce51027daa1976779ba8b4325a1d3dea3bc6241a80896f003ae70f316db9b877bbc01eebe4e5e71c03784221c2cd939ef1f1b897 \
    HOME_DIR=/root \
    RAILS_LOG_TO_KIBANA=true

WORKDIR $APP_DIR

COPY Gemfile* $APP_DIR/

RUN if [ "$RAILS_ENV" == "production" ]; then bundle config set without 'development test'; fi
RUN bundle install --jobs=8

COPY . $APP_DIR

RUN mkdir -p tmp/pids log

RUN chmod +x entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]

CMD ["puma", "-C", "config/puma.rb", "-S", "tmp/puma_stats.txt", "--control-url", "tcp://0.0.0.0:9191"]