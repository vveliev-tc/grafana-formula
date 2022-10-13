# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- set sls_package_clean = tplroot ~ '.package.clean' %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- set sls_alternatives_clean = tplroot ~ '.config.alternatives.clean' %}

  {%- if grains.kernel|lower == 'linux' and grafana.linux.altpriority|int > 0 %}

include:
  - {{ sls_service_clean }}
  - {{ sls_alternatives_clean }}

grafana-config-clean-file-absent:
  file.absent:
    - names:
      - {{ grafana.service.config_file }}
      - {{ grafana.service.environ_file }}
    - require:
      - sls: {{ sls_alternatives_clean }}

  {%- endif %}
