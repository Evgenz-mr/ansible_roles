# Ansible Infrastructure Automation Lab

Reusable Ansible roles and playbooks for infrastructure automation, configuration management and repeatable server provisioning.

## Engineering goals

- idempotent configuration
- role-based structure
- inventory separation
- handlers for controlled restarts
- linting in CI
- clear distinction between defaults and environment-specific variables
- safe secret handling via Ansible Vault or external secret stores

## Repository structure

```text
roles/              reusable roles
playbooks/          orchestration playbooks
inventories/        environment inventories
ansible.cfg         project configuration
.github/workflows/  CI validation
```

## Existing roles

The repository contains Java/Jenkins-oriented automation and supporting test roles. The new portfolio structure keeps those examples while adding a clearer entry point for infrastructure orchestration.

## Example

```bash
ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml --check
ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml
```

## Idempotency

A role should converge without reporting changes on a second run when the target system is already in the desired state. CI runs syntax and lint checks; runtime idempotency testing should be performed in disposable VMs/containers or Molecule scenarios.

## Security

Do not commit passwords, tokens or private keys. Use Ansible Vault, CI secret stores or an external secrets manager. Privilege escalation should be scoped only to tasks that require it.
