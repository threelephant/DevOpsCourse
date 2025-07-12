# Login once
docker login

# Tag & push backend
docker tag devopscourse-api:latest  plunev/notes-api:v1
docker push plunev/notes-api:v1

# Tag & push frontend
docker tag devopscourse-web:latest plunev/notes-web:v1
docker push plunev/notes-web:v1
