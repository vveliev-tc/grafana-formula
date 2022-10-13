# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}


grafana-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ grafana.service.environ_file }}
    - source: {{ files_switch(['grafana.sh.jinja'],
                              lookup='grafana-config-file-file-managed-environ_file'
                 )
              }}
    - mode: "0644"
    - user: {{ grafana.service.user }}
    - group: {{ grafana.service.group }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ grafana.environ|json }}
