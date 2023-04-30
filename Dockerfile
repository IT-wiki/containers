FROM docker.io/bitnami/mediawiki:1.39.3

## Change user to perform privileged actions
USER 0

RUN install_packages curl

## Revert to the original non-root user
USER 1001

## Install some more Mediawiki extension from here: https://extdist.wmflabs.org/dist/extensions/
RUN cd /opt/bitnami/mediawiki/extensions && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Elastica-REL1_39-c45dc17.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/MsUpload-REL1_39-f4941a8.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/intersection-REL1_39-dbb8cfd.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_39-68bec9b.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_39-120f269.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/SimpleSAMLphp-REL1_39-dcf0acb.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/VEForAll-REL1_39-0de7158.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/HeaderTabs-REL1_39-9673754.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/Lockdown-REL1_39-6b196cb.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/LabeledSectionTransclusion-REL1_39-205ed12.tar.gz | tar -xzf - && \
    curl -s -L https://extdist.wmflabs.org/dist/extensions/PageForms-REL1_39-3b8fd04.tar.gz | tar -xzf -


## Add some more stuff to the file system
COPY rootfs /
