# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- if grafana.get('enabled', True) %}
include:
  - {{ tplroot }}.package
  - {{ tplroot }}.config
  - {{ tplroot }}.service
{%- endif %}
