package v1

import (
	"github.com/kharf/cue-eval-regression/kubernetes"
	batch "cue.dev/x/k8s.io/api/batch/v1"
)

#Job: kubernetes.#Namespaced & batch.#Job & {
	apiVersion: "batch/v1"
	kind:       "Job"
}
