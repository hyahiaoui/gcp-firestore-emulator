# gcp-firestore-emulator

Run GCP Firestore emulator in a Docker container for development and testing purposes

## Usage

Retrieve the latest version of the Docker image:

```shell
$ docker pull "getalma/gcp-firestore-emulator:latest"
```

Run the Docker container, by making it reachable through port `8086`:

```shell
$ docker run \
	--rm --tty --interactive \
	--publish "8086:8086" \
	--name "firestore_emulator" \
	"alma/gcp-firestore-emulator:latest"
```

or using `docker-compose`:

```shell
$ cat docker-compose.yml
version: "3"

services:
  firestore-emulator:
    image: getalma/gcp-firestore-emulator:latest

  some-service:
    image: python:3.8
    environment:
      - FIRESTORE_EMULATOR_HOST=firestore-emulator:8086
    depends_on:
      - firestore-emulator
    entrypoint:
      - /bin/bash

$ docker-compose up "some-service"
Creating firestore-emulator_1 ... done
Creating some-service_1 ... done
Attaching to some-service_1
...
```

You can, now, use the emulator to develop and test your application.

## Run an application against the emulator

First install the Google Cloud Firestore client library (in a virtualenv on inside a Docker container):

```shell
$ pip install --upgrade firebase-admin
```

Then, set the environment variable that will allow your code to run on the emulator, instead of trying to connect to Google Cloud Firestore:

```shell
export FIRESTORE_EMULATOR_HOST=localhost:8086
```

After this, you can use the client library to ... 

```python
from unittest import mock
from google.cloud import firestore
import google.auth.credentials

credentials = mock.Mock(spec=google.auth.credentials.Credentials)
db = firestore.Client(project="test", credentials=credentials)

user_ref = db.collection("users").document("22")

user_ref.set({"name": "John Doe", "age": 37}) 

print(user_ref.get().to_dict())

assert user_ref.get().to_dict() == {"name": "John Doe", "age": 37}
```
