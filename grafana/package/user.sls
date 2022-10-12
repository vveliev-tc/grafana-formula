# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/jinja/map.jinja" import mapdata as grafana with context %}


# Create grafana user
grafana-package-user-create-group:
  group.present:
    - name: {{ grafana.group }}
    {% if grafana.get('group_gid', None) != None -%}
    - gid: {{ grafana.group_gid }}
    {%- endif %}

grafana-package-user-create-user:
  user.present:
    - name: {{ grafana.user }}
    {% if grafana.get('user_uid', None) != None -%}
    - uid: {{ grafana.user_uid }}
    {% endif -%}
    - groups:
      - {{ grafana.group }}
    - home: {{ salt['user.info'](grafana.user)['home']|default(grafana.config.data_dir) }}
    - createhome: False
    - system: True
    - require:
      - group: grafana-group
