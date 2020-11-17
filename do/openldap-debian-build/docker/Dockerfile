FROM debian:10.4

MAINTAINER Lubomir Sladok <ten.lubo@hotmail.com>

RUN apt-get update && \
    echo "slapd slapd/root_password password password" |debconf-set-selections && \
    echo "slapd slapd/root_password_again password password" |debconf-set-selections && \
    echo "slapd slapd/internal/adminpw password password" |debconf-set-selections && \
    echo "slapd slapd/internal/generated_adminpw password password" |debconf-set-selections && \
    echo "slapd slapd/password2 password password" |debconf-set-selections && \
    echo "slapd slapd/password1 password password" |debconf-set-selections && \
    echo "slapd slapd/domain string fixu.online" |debconf-set-selections && \
    echo "slapd shared/organization string Bikefresco" |debconf-set-selections && \
    echo "slapd slapd/backend string HDB" |debconf-set-selections && \
    echo "slapd slapd/purge_database boolean true" |debconf-set-selections && \
    echo "slapd slapd/move_old_database boolean true" |debconf-set-selections && \
    echo "slapd slapd/allow_ldap_v2 boolean false" |debconf-set-selections && \
    echo "slapd slapd/no_configuration boolean false" |debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils

COPY modules/ /etc/ldap.dist/modules

EXPOSE 389

RUN slapadd -v -l /etc/ldap.dist/modules/basedn.ldif

CMD ["slapd", "-d", "32768", "-u", "root", "-g", "root"]
