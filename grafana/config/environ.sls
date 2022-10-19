# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}
{%- from tplroot ~ "/jinja/libtofs.jinja" import files_switch with context %}


grafana-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ grafana.environ_file }}
    - source: {{ files_switch(['grafana.sh.jinja'],
                              lookup='grafana-environ-files'
                 )
              }}
    - mode: "0644"
    - user: {{ grafana.user }}
    - group: {{ grafana.group }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ grafana.environ|json }}
    - require:
      - user: grafana-package-user-create-user
    {%- if grafana.service.enabled %}
    - watch_in:
       - service: grafana-service-running-service-running
    {%- endif %}
