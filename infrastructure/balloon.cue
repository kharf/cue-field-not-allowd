package infrastructure

import (
	"github.com/kharf/cue-eval-regression/kubernetes"
	core "github.com/kharf/cue-eval-regression/kubernetes/core/v1"
	apps "github.com/kharf/cue-eval-regression/kubernetes/apps/v1"
	batch "github.com/kharf/cue-eval-regression/kubernetes/batch/v1"
)

manifests: [...kubernetes.#Manifest]
manifests: [
	ns,
	for balloon in balloons {
		balloon
	},
]

balloons: [
	consistent,
	event,
]

ns: core.#Namespace & {
	metadata: name: "reservation"
}

consistent: apps.#Deployment & {
	metadata: {
		name:      "consistent-capacity-reservation"
		namespace: ns.metadata.name
	}
	_labels: app: "consistent-reservation"

	spec: {
		replicas: 0
		selector: matchLabels: _labels
		template: {
			metadata: labels: _labels
			spec: {
				priorityClassName:             "lowprio"
				terminationGracePeriodSeconds: 0
				securityContext: runAsNonRoot: true
				containers: [{
					name:  "ubuntu"
					image: "ubuntu"
					command: ["sleep"]
					args: ["infinity"]
					resources: requests: {
						cpu:    "0.5"
						memory: "500Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						readOnlyRootFilesystem:   true
						capabilities: {
							drop: [
								"ALL",
							]
						}
					}
				}]
			}
		}
	}
}

event: batch.#Job & {
	metadata: {
		name:      "event-capacity-reservation"
		namespace: ns.metadata.name
	}
	_labels: app: "event-reservation"

	spec: {
		parallelism:  0
		backoffLimit: 0
		template: spec: {
			priorityClassName:             "lowprio"
			terminationGracePeriodSeconds: 0
			securityContext: runAsNonRoot: true
			containers: [{
				name:  "ubuntu"
				image: "ubuntu"
				command: ["sleep"]
				args: ["36000"] // time in seconds to reserve the capacity
				resources: requests: {
					cpu:    "0.5"
					memory: "500Mi"
				}
				securityContext: {
					allowPrivilegeEscalation: false
					readOnlyRootFilesystem:   true
					capabilities: {
						drop: [
							"ALL",
						]
					}
				}
			}]
			restartPolicy: "Never"
		}
	}
}
