# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}


# Create grafana user
grafana-package-user-create-group:
  group.present:
    - name: {{ grafana.service.group }}
    {% if grafana.service.get('group_gid', None) != None -%}
    - gid: {{ grafana.service.group_gid }}
    {%- endif %}

grafana-package-user-create-user:
  user.present:
    - name: {{ grafana.service.user }}
    {% if grafana.service.get('user_uid', None) != None -%}
    - uid: {{ grafana.service.user_uid }}
    {% endif -%}
    - groups:
      - {{ grafana.service.group }}
    - home: {{ salt['user.info'](grafana.service.user)['home']|default(grafana.service.data_dir) }}
    - createhome: False
    - system: True
    - require:
      - group: grafana-package-user-create-group
