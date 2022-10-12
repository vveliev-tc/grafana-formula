# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as grafana with context %}

grafana-service-clean-service-dead:
  service.dead:
    - name: {{ grafana.service.name }}
    - enable: False
