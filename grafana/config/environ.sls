# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}


grafana-config-file-file-managed-environ_file:
  file.recurse:
    - name: {{ grafana.service.config_path }}/
    - source: salt://{{ files_switch(['grafana.ini.jinja'],
                              lookup='grafana-config-files'
                 )
              }}
    - file_mode: "0644"
    - user: {{ grafana.service.user }}
    - group: {{ grafana.service.group }}
    - makedirs: True
    - template: ''
    - context:
        config: {{ grafana.config | json }}
