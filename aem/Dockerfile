FROM java
MAINTAINER Dominik Foerderreuther <df@adobe.com>

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install less -y

ENV localdir files
ENV cqjar cq-quickstart-6.1.0.jar

RUN mkdir /opt/aem

WORKDIR /opt/aem

ADD ${localdir}/${cqjar} /opt/aem/${cqjar}
ADD ${localdir}/license.properties /opt/aem/license.properties

EXPOSE 4502

CMD java -jar ${cqjar} -r author -p 4502 -Xmx1524M -Xms512M -XX:MaxPermSize=512M
