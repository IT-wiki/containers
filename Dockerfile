FROM docker.io/bitnami/mediawiki:1.39.3

## Install some more packages
USER 0
RUN install_packages curl graphviz imagemagick
RUN cd /tmp && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
# Revert to the original non-root user
USER 1001

## Install some more Mediawiki extension from here: https://extdist.wmflabs.org/dist/extensions/
RUN cd /opt/bitnami/mediawiki/extensions && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Elastica-REL1_39-c45dc17.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/MsUpload-REL1_39-f4941a8.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/intersection-REL1_39-f12d735.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_39-68bec9b.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_39-120f269.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/SimpleSAMLphp-REL1_39-dcf0acb.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/VEForAll-REL1_39-0de7158.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/HeaderTabs-REL1_39-9673754.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_39-6b196cb.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/LabeledSectionTransclusion-REL1_39-205ed12.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PageForms-REL1_39-89665fd.tar.gz | tar -xzf -

## Install more extensions using 'composer'
RUN cd /opt/bitnami/mediawiki && \
    # composer -q -n require --no-update mediawiki/semantic-bundle && \
    composer -q -n require --no-update mediawiki/semantic-media-wiki "~4.0" && \
    composer -q -n require --no-update mediawiki/semantic-result-formats "~4.0"  && \
    composer -q -n require --no-update phpoffice/phpspreadsheet "~1" && \
    composer -q -n require --no-update mediawiki/validator "2.2.*" && \
    composer -q -n update --no-dev

## Add some more stuff to the file system
COPY rootfs /
