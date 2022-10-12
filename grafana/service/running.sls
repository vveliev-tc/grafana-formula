# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as grafana with context %}

include:
  - {{ sls_config_file }}

grafana-service-running-service-unmasked:
  service.unmasked:
    - name: {{ grafana.service.name }}
    - onlyif: systemctl list-unit-files | grep {{ grafana.service.name }} >/dev/null 2>&1

grafana-service-running-service-running:
  service.running:
    - name: {{ grafana.service.name }}
    - enable: True
  {%- if 'config' in grafana and grafana.config %}
    - watch:
      - file: grafana-config-file-file-managed-config_file
    - require:
      - sls: {{ sls_config_file }}
  {%- endif %}
    - onlyif: systemctl list-unit-files | grep {{ grafana.service.name }} >/dev/null 2>&1
