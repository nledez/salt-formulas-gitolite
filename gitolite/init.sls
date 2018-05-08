{%- set packages_upgrade = salt['pillar.get']('packages_upgrade', False) %}
{%- if packages_upgrade %}
  {%- set pkg_install_or_latest = 'pkg.latest' %}
{%- else %}
  {%- set pkg_install_or_latest = 'pkg.installed' %}
{%- endif %}
{%- set gitolite_user = salt['pillar.get']('gitolite:user', 'git') %}

gitolite_requirements:
  {{ pkg_install_or_latest }}:
    - pkgs:
      - git

gitolite:
  git.latest:
    - name: https://github.com/sitaramc/gitolite
    - target: /usr/local/gitolite
    - require:
      - pkg: gitolite_requirements
  user.present:
    - name: {{ gitolite_user }}
    - system: True
    - home: /var/lib/gitolite

/var/lib/gitolite/bin:
  file.directory:
    - user: {{ gitolite_user }}
    - group: {{ gitolite_user }}
    - dir_mode: 755
    - require:
      - user: {{ gitolite_user }}

/var/lib/gitolite/.gitolite:
  file.directory:
    - user: {{ gitolite_user }}
    - group: {{ gitolite_user }}
    - dir_mode: 755
    - require:
      - user: {{ gitolite_user }}

/var/lib/gitolite/.gitolite/logs:
  file.directory:
    - user: {{ gitolite_user }}
    - group: {{ gitolite_user }}
    - dir_mode: 755
    - require:
      - file: /var/lib/gitolite/.gitolite

/var/lib/gitolite/bin/gitolite:
  file.symlink:
    - target: /usr/local/gitolite/src/gitolite
    - require:
      - file: /var/lib/gitolite/bin
      - git: gitolite
