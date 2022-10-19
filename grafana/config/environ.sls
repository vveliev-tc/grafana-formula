# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}


grafana-config-file-file-managed-config_file:
  file.serialize:
    - name: {{ grafana.config_path }}/grafana.ini
    - source: {{ files_switch([''],
                              lookup='grafana-config-files'
                 )
              }}
    - file_mode: "0644"
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
