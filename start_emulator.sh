#!/bin/sh

/root/google-cloud-sdk/bin/gcloud \
	beta emulators firestore start \
	--host-port "0.0.0.0:${HOST_PORT}"
