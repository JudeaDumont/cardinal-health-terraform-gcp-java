
1. install gcloud cli
2. install terraform
3. extract to a location
4. add that location to PATH
5. you must go to the service accounts page to add a key
6. this key will allow you download a json file
7. this json file should be stored under infra/keys/sa.json
8. you should be able to run terraform commands now

- Once you build the jar file for the simple service you will need to do this:
`gsutil cp services/simpleService/target/simpleService-0.0.1-SNAPSHOT.jar gs://springboot-service-bucket-festive-nova-435200-h4/`
  

- `gcloud projects add-iam-policy-binding <project-id> \
  --member "serviceAccount:<your-service-account>" \
  --role "roles/storage.admin"`

- `docker build -t gcr.io/<your-gcp-project>/calculation-service:latest .`

