
- Once you build the jar file for the simple service you will need to do this:
`gsutil cp services/simpleService/target/simpleService-0.0.1-SNAPSHOT.jar gs://springboot-service-bucket-festive-nova-435200-h4/`
  

- `gcloud projects add-iam-policy-binding <project-id> \
  --member "serviceAccount:<your-service-account>" \
  --role "roles/storage.admin"`

- `docker build -t gcr.io/<your-gcp-project>/calculation-service:latest .`