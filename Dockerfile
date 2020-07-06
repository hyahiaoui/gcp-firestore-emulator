# The Firestore emulator requires Java 8
FROM	java:jre-alpine

ENV	CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV	HOST_PORT 8086

RUN	apk add --no-cache curl bash python

# Install Google Cloud SDK
RUN	curl https://sdk.cloud.google.com | bash

# Install the Firestore emulator
RUN	/root/google-cloud-sdk/bin/gcloud config set disable_usage_reporting true && \
	/root/google-cloud-sdk/bin/gcloud components install -q cloud-firestore-emulator beta

# Expose the default emulator port
EXPOSE	8086

ADD start_emulator.sh /
RUN	chmod +x /start_emulator.sh

CMD ["/start_emulator.sh"]
