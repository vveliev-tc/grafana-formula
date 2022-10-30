# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_config_file }}

grafana-subcomponent-config-file-file-managed:
  file.recurse:
    - name: {{ grafana.paths.etc }}
    - source: {{ files_switch(['provisioning'],
                              lookup='grafana-subcomponent-config-file-file-managed',
                              use_subpath=True
                 )
              }}
    - mode: "0644"
    - dir_mode: "0775"
    - user: root
    - group: {{ grafana.rootgroup }}
    - makedirs: True
    - require_in:
      - sls: {{ sls_config_file }}


move_dashboards:
  file.recurse:
    - name: {{ grafana.paths.etc }}/dashboards
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - file_mode: 664
    - dir_mode: 775
    - makedirs: True
    - source: salt://{{ slspath }}/files/dashboards
