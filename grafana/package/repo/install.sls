# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}


grafana-package-pkgrepo-manage:
  pkgrepo.managed:
    - humanname: {{ grafana.pkg.repo.humanname }}
    - name: deb https://packages.grafana.com/oss/deb stable main
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packages.grafana.com/gpg.key
    - refresh_db: true
