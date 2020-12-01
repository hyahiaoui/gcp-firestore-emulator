#!/bin/sh

gcloud \
	beta emulators firestore start \
	--host-port "0.0.0.0:${HOST_PORT}"
