# build with:
# docker build -t openupgrade .
FROM odoo:14

USER root

RUN apt-get update && \
  apt-get install -y git libsasl2-dev libldap2-dev libssl-dev && \
  pip3 install git+https://github.com/OCA/openupgradelib.git@master#egg=openupgradelib
COPY openupgrade_framework /mnt/extra-addons/openupgrade_framework
COPY openupgrade_scripts /mnt/extra-addons/openupgrade_scripts

USER odoo
ENTRYPOINT []
CMD []
# Usage:
# Start a container and bind-mount your modules in /opt/OpenUpgrade/addons
# docker run --rm -ti --network $DB_NETWORK -p 8069:8069 -v $MODULE_PATH/$MODULE_NAME:/opt/OpenUpgrade/addons/$MODULE_NAME openupgrade:13.0 bash
# Variables used:
# - DB_NETWORK: run your container in the same network as a running docker-compose to be able to easily connect to the db.
# - MODULE_PATH: absolute path to your module parent folder
# - MODULE_NAME: name of a module to import
#
# Run the migration inside the container
# export SKIP_MIGRATION=true && ./odoo-bin -d $DB_NAME -r $DB_USER -w $DB_PASSWORD --db_host=$DB_HOST --addons-path=addons --update=all --stop-after-init
