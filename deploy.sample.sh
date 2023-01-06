APP_NAME=""
GCP_PROJECT_ID=""
GCP_REGION=""

eval "docker build -t $APP_NAME-builder-image -f builder.Dockerfile ."
eval "docker build -t $APP_NAME-run-image -f run.Dockerfile ."

eval "pack build $APP_NAME \
  --builder $APP_NAME-builder-image \
  --run-image $APP_NAME-run-image \
  --tag gcr.io/$GCP_PROJECT_ID/$APP_NAME:latest"

eval "gcloud config set project $GCP_PROJECT_ID"
eval "gcloud auth configure-docker"
eval "docker push gcr.io/$GCP_PROJECT_ID/$APP_NAME:latest"

eval "gcloud run deploy $APP_NAME \
  --image=gcr.io/$GCP_PROJECT_ID/$APP_NAME \
  --region $GCP_REGION \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars RACK_ENV=production"
