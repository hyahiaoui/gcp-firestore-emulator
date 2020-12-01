FROM    google/cloud-sdk:alpine

ENV     CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV     HOST_PORT 8086

# The Pub/Sub emulator requires Java 8
RUN     apk --no-cache add openjdk8-jre

# Install the Firestore emulator, then cleanup the (>400 MB) backup directory
RUN     gcloud config set disable_usage_reporting true && \
        gcloud components install -q \
            beta \
            cloud-firestore-emulator && \
        rm -rf /google-cloud-sdk/.install/.backup

# Expose the default emulator port
EXPOSE  8086

ADD     start_emulator.sh /
RUN     chmod +x /start_emulator.sh

CMD     ["/start_emulator.sh"]
