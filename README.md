# k3s-certs

Helm chart for managing certificates lifecycle in a k3s cluster. The chart can either be used to only provide certs to the local cluster but is also capable of managing the lifecycle of certificates in a remote cluster using the cert-manager and external-secrets.

## Features

- Certificate management using cert-manager
- Certificate storage local and/or remote using external-secrets
- Support for multiple domains
- Supports pushing single certificates to multiple external secret stores or a single one.

## Gotchas

The chart does not include the secret-store needed to retreive the issuer credentials. The chart assumes this vault is already created and configured, if not the user should use a pre-existing secret in the deployment namespace.
