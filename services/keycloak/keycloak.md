# Keycloak
## Installation
- <https://www.keycloak.org/guides#getting-started>
- install Docker (`docker.io`) or Podman
    + `x86-64-v2` is not supported on older CPUs
    + `sudo usermod -aG docker $USER && newgrp docker`

```sh
docker run -p 8080:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:26.1.3 start-dev
```

- [direct installation](https://www.keycloak.org/getting-started/getting-started-zip)

## Accounts Setup
```sh
# start production server (need to provide TLS certs)
bin/kc.sh start --bootstrap-admin-username admin --bootstrap-admin-password admin

# start development server
bin/kc.sh start-dev --bootstrap-admin-client-id tmpadm --bootstrap-admin-client-secret secret

# create temporary admin user (done without server running)
bin/kc.sh bootstrap-admin user # --username tmpadm --password:env PASS_VAR (optional)

# create temporary service user
bin/kc.sh bootstrap-admin service # --client-id tmpclient --client-secret:env=SECRET_VAR (optional)
```

## Authentication & Usage of Keycloak
- general configuration: <https://www.keycloak.org/server/all-config>
- provider configuration: <https://www.keycloak.org/server/all-provider-config>

- <https://www.keycloak.org/guides#server>
- can be an [OpenID Connect Provider](https://www.keycloak.org/securing-apps/oidc-layers)
- can secure JS applications [on client-side with `keycloak-js`](https://www.keycloak.org/securing-apps/javascript-adapter) and [on server-side with `keycloak-connect`](https://www.keycloak.org/securing-apps/nodejs-adapter)
- new clients can integrate with Keycloak through client registration [on CLI](https://www.keycloak.org/securing-apps/client-registration-cli) or [through the service endpoint](https://www.keycloak.org/securing-apps/client-registration)
