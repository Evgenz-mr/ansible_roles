# Ansible Infrastructure Automation Lab

Reusable Ansible roles and playbooks for infrastructure automation, configuration management and repeatable server provisioning.

## Engineering goals

- idempotent configuration
- role-based structure
- inventory separation
- handlers for controlled restarts/reloads
- linting and syntax validation in CI
- clear distinction between defaults and environment-specific variables
- safe secret handling via Ansible Vault or external secret stores

## Portfolio entry points

```text
roles/baseline/           baseline OS packages/directories
roles/nginx_hardened/     reusable NGINX configuration example
playbooks/site.yml        baseline orchestration
playbooks/nginx.yml       NGINX orchestration
inventories/dev/          example environment inventory
```

The repository also contains older Java/Jenkins roles. They are retained as historical automation examples rather than presented as current production defaults.

## Example

```bash
ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml --check
ansible-playbook -i inventories/dev/hosts.yml playbooks/nginx.yml --check
```

## Role design example

`nginx_hardened` demonstrates a reusable role contract: tunable values live in `defaults`, configuration is generated from a Jinja template, and NGINX reload happens only through a handler when the template changes.

## Idempotency

A role should converge without reporting changes on a second run when the target system is already in the desired state. CI runs syntax and lint checks; runtime idempotency should be tested in disposable VMs/containers or Molecule scenarios.

## Security

Do not commit passwords, tokens or private keys. Use Ansible Vault, CI secret stores or an external secret manager. Privilege escalation should be scoped only to tasks that require it.
