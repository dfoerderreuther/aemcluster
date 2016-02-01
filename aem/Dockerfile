FROM adobe/java8
MAINTAINER Dominik Foerderreuther <df@adobe.com>

ENV localdir files
ENV cqjar cq-quickstart-6.1.0.jar

RUN mkdir /opt/aem

WORKDIR /opt/aem

ADD ${localdir}/${cqjar} /opt/aem/${cqjar}
ADD ${localdir}/license.properties /opt/aem/license.properties

RUN java -XX:MaxPermSize=256m -Xmx1024M -jar ${cqjar} -unpack -v

EXPOSE 4502

ENV CQ_FOREGROUND y
ENV CQ_VERBOSE    y
ENV CQ_NOBROWSER  y
ENV CQ_RUNMODE    "dev,author"
ENV CQ_JVM_OPTS   "-server -Xmx1524M -Xms512M -XX:MaxPermSize=512M"

CMD crx-quickstart/bin/quickstart
