FROM adobe/java8
MAINTAINER Dominik Foerderreuther <df@adobe.com>

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install less -y

ENV localdir files
ENV cqjar aem6-author-p4502.jar

RUN mkdir /opt/aem

WORKDIR /opt/aem

ADD ${localdir}/${cqjar} /opt/aem/${cqjar}
ADD ${localdir}/license.properties /opt/aem/license.properties

EXPOSE 4502

CMD java -jar ${cqjar}  -Xmx1524M -Xms512M -XX:MaxPermSize=512M
