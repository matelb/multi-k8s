docker build -t matelb/multi-client:latest -t matelb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matelb/multi-server -t matelb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matelb/multi-worker -t matelb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push matelb/multi-client:latest
docker push matelb/multi-server:latest
docker push matelb/multi-worker:latest

docker push matelb/multi-client:$SHA
docker push matelb/multi-server:$SHA
docker push matelb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matelb/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=matelb/multi-worker:$SHA
kubectl set image deployments/client-deployment client=matelb/multi-client:$SHA