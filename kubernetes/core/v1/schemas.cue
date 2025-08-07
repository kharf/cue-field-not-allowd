package v1

import (
	"github.com/kharf/cue-eval-regression/kubernetes"
	core "cue.dev/x/k8s.io/api/core/v1"
)

#Namespace: kubernetes.#NonNamespaced & core.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"
}
