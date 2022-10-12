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
    - name: {{ grafana.config.data_dir }}
    - makedirs: True
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - mode: '0750'

{%- if 'config' in grafana and grafana.config %}

grafana-config-file-file-managed-config_file:
  file.managed:
    - name: {{ grafana.config_file }}
    - source: {{ files_switch(['grafana.ini.jinja'],
                              lookup='grafana-config-file-file-managed-config_file'
                 )
              }}
    - mode: 640
    - user: root
    - group: {{ grafana.group }}
    - group: {{ grafana.rootgroup if grafana.pkg.use_upstream_archive else grafana.group }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ grafana.config|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
