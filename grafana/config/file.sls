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
    - name: {{ grafana.service.config_path }}
    - user: {{ grafana.service.user }}
    - group: {{ grafana.service.group }}
    - mode: '0750'


grafana-config-create-data-dir:
  file.directory:
    - name: {{ grafana.service.data_dir }}
    - makedirs: True
    - user: {{ grafana.service.user }}
    - group: {{ grafana.service.group }}
    - mode: '0750'

# {%- if 'config' in grafana and grafana.config %}

# grafana-config-file-file-managed-config_file:
#   file.managed:
#     - name: {{ grafana.service.config_path }}
#     - source: {{ files_switch(['grafana.ini.jinja'],
#                               lookup='grafana-config-files'
#                  )
#               }}
#     - mode: "0640"
#     - user: root
#     - group: {{ grafana.service.group }}
#     - makedirs: True
#     - template: jinja
#     - context:
#         config: {{ grafana.config|json }}
#     - require:
#       - sls: {{ sls_package_install }}

# {%- endif %}
