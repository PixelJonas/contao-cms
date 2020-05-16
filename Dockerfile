FROM registry.redhat.io/ubi8/php-73

ENV COMPOSER_MEMORY_LIMIT -1
ENV CONTAO_PROJECT_DIR="/opt/app-root/src"
ENV APP_SRC_DIR="/tmp/src"


# Since the Contao Manager is initializing the application during build-time environment variables to be used for the configuration (e.g Databases)
# need to be set here. The defaults provided in this files correlate to the ones provided in the docker-compose.yaml and should be overwritten during runtime
ENV DATABASE_HOST="mariadb" \
  DATABASE_PORT="3306" \
  DATABASE_NAME="contao" \
  DATABASE_USER="contao" \
  DATABASE_PASSWORD="contao"

USER 0

RUN INSTALL_PKGS="mod_php php-bcmath php-cli php-gd php-intl php-json php-mbstring php-mysqlnd php-opcache php-snmp php-soap php-xml php-pecl-zip" && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  yum clean all

ADD composer.json composer.json


# as long as https://github.com/sclorg/s2i-php-container/pull/246 is not merged we need to patch the assemble script
ADD s2i /usr/libexec/s2i

ADD system system

ADD config app/config

ADD src src

ADD .htaccess /opt/app-root/src/.htaccess

RUN  chmod +x ${STI_SCRIPTS_PATH}/assemble \
  && mkdir -p "$APP_SRC_DIR" \
  && touch "${APP_SRC_DIR}/.gitkeep"

RUN  chgrp -R 0 "${CONTAO_PROJECT_DIR}" \
  && chmod -R g=u "${CONTAO_PROJECT_DIR}" \
  && chgrp -R 0 "${APP_SRC_DIR}" \
  && chmod -R g=u "${APP_SRC_DIR}"

USER 1001

RUN "${STI_SCRIPTS_PATH}/assemble"

RUN curl -sSL https://download.contao.org/contao-manager/stable/contao-manager.phar -o ${CONTAO_PROJECT_DIR}/web/contao-manager.phar

USER 1001

VOLUME [ "${CONTAO_PROJECT_DIR}/templates", "${CONTAO_PROJECT_DIR}/files", "${CONTAO_PROJECT_DIR}/assets/images" ]

CMD [ "/usr/libexec/s2i/run" ]
