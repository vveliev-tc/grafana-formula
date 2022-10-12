# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import grafana with context %}

grafana-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ grafana.pkg.repo.name }}

# grafana-cli-package-archive-clean-file-absent:
#   file.absent:
#     - names:
#       - {{ grafana.pkg.archive.name }}
