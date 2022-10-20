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
    - name: {{ grafana.config_dir }}
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

grafana-config-file-file-managed-config-file:
  file.serialize:
    - name: {{ grafana.config_dir }}/{{ grafana.config_file }}
    - source: {{ files_switch(['grafana.sh.jinja'],
                              lookup='grafana-config-files'
                 )
              }}
    - mode: "0644"
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - makedirs: True
    - formatter: toml
    - dataset: {{ grafana.config | yaml }}
    - require:
      - user: grafana-package-user-create-user
    {%- if grafana.service.enabled %}
    - watch_in:
       - service: grafana-service-running-service-running
    {%- endif %}


grafana-config-file-file-managed-ldap-file:
  file.serialize:
    - name: {{ grafana.config_dir }}/ldap.toml
    - source: {{ files_switch(['ldap.toml.jinja'],
                              lookup='grafana-ldap-files'
                 )
              }}
    - mode: "0644"
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - makedirs: True
    - formatter: toml
    - dataset: {{ grafana.config | yaml }}
    - require:
      - user: grafana-package-user-create-user
    {%- if grafana.service.enabled %}
    - watch_in:
       - service: grafana-service-running-service-running
    {%- endif %}
