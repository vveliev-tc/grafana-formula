# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}


# Create directories

grafana-config-create-config-dir:
  file.directory:
    - name: {{ grafana.config_path }}
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - mode: '0750'


grafana-config-create-data-dir:
  file.directory:
    - name: {{ grafana.data_dir }}
    - makedirs: True
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - mode: '0750'
