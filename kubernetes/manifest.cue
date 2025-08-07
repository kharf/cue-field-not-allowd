package kubernetes

import (
	"strings"
)

_gvk: {
	apiVersion!: string & strings.MinRunes(1)
	kind!:       string & strings.MinRunes(1)
}

#Namespaced: {
	_gvk
	metadata: {
		namespace!: string & strings.MinRunes(1)
		name!:      string & strings.MinRunes(1)
		...
	}
	...
}

#NonNamespaced: {
	_gvk
	metadata: {
		name!:      string & strings.MinRunes(1)
		namespace?: _|_
		...
	}
	...
}

#Manifest: #Namespaced | #NonNamespaced
