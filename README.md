# OTel LGTM

OpenTelemetry and LGTM (Loki, Tempo, Grafana, Prometheus) observability stack
deployed by FluxCD.

## Prerequisites

- Commonly used Kubernetes commands (e.g. `flux`, `helm`, `kubectl`) are installed.
- A Kubernetes cluster that has already [flux bootstrap](https://fluxcd.io/flux/installation/bootstrap/).
  (Check bootstrap status by running `flux check`).

## Get Started

Make sure your current working directory is what created by `flux bootstrap`.
The file structure looks like:

```txt
my-dev-k8s
└── flux-system
    ├── gotk-components.yaml
    ├── gotk-sync.yaml
    └── kustomization.yaml
```

Run the following conmmands to create flux configuraitons for this repo:

```sh
mkdir -p otel-lgtm

flux create source git otel-lgtm \
  --url=https://github.com/whisperpine/otel-lgtm \
  --branch=main \
  --export >otel-lgtm/git-repository.yaml

flux create kustomization otel-lgtm \
  --source=GitRepository/otel-lgtm \
  --path="./overlays/dev" \
  --interval=1m \
  --prune=true \
  --wait=true \
  --export >otel-lgtm/flux-kustomization.yaml
```

Now the file structure should be something like:

```txt
my-dev-k8s
├── flux-system
│   ├── gotk-components.yaml
│   ├── gotk-sync.yaml
│   └── kustomization.yaml
└── otel-lgtm
    ├── flux-kustomization.yaml
    └── git-repository.yaml
```

Commit changes, push to remote repository, and wait for the reconciliation of flux.

```sh
# Run this command and the "READY" column should be "True".
flux -n monitoring get helmrelease
```

## Renovate

Dependencies, including chart versions in HelmRelease resources, are
automatically updated by [Renovate](https://github.com/renovatebot/renovate).

Chart versions are precisely configured (e.g. `"9.3.2"`, not `"9.*"`) for safety
and reproducibility, while they are kept up-to-date without hassle by Pull
Requests created by Renovate.

Refer to [Automated Dependency Updates for Flux - Renovate Docs](https://docs.renovatebot.com/modules/manager/flux/).
