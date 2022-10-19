# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}

{%- if grafana.pkg.use_upstream_repo %}
include:
  - .repo
{%- endif %}



grafana-package-install-bin-dir:
  file.directory:
    - name: {{ grafana.bin_dir }}
    - makedirs: True


grafana-package-install-pkg-install-dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - software-properties-common
  pip.installed:
    - name: pytoml

grafana-package-install-pkg-installed:
  pkg.installed:
    - name: {{ grafana.pkg.name }}
