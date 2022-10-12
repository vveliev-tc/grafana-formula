# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}

{%- if grafana.pkg.use_upstream_repo %}
include:
  - .repo
{%- endif %}

grafana-package-install-pkg-installed:
  pkg.installed:
    - name: {{ grafana.pkg.name }}
