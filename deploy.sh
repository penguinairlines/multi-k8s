docker build -t penguinairlines/multi-client:latest -t penguinairlines/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t penguinairlines/multi-server:latest -t penguinairlines/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t penguinairlines/multi-worker:latest -t penguinairlines/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push penguinairlines/multi-client:latest
docker push penguinairlines/multi-server:latest
docker push penguinairlines/multi-worker:latest

docker push penguinairlines/multi-client:$SHA
docker push penguinairlines/multi-server:$SHA
docker push penguinairlines/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=penguinairlines/multi-server:$SHA
kubectl set image deployments/client-deployment client=penguinairlines/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=penguinairlines/multi-worker:$SHA
