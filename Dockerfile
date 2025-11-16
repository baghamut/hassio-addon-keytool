FROM eclipse-temurin:17-jdk

WORKDIR /addon

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
