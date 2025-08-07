package v1

import (
	"github.com/kharf/cue-eval-regression/kubernetes"
	apps "cue.dev/x/k8s.io/api/apps/v1"
)

#Deployment: kubernetes.#Namespaced & apps.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
}
