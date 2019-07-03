docker build -t plgingembre/multi-client:latest -t plgingembre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t plgingembre/multi-server:latest -t plgingembre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t plgingembre/multi-worker:latest -t plgingembre/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push plgingembre/multi-client:latest
docker push plgingembre/multi-server:latest
docker push plgingembre/multi-worker:latest
docker push plgingembre/multi-client:$SHA
docker push plgingembre/multi-server:$SHA
docker push plgingembre/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=plgingembre/multi-client:$SHA
kubectl set image deployments/server-deployment server=plgingembre/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=plgingembre/multi-worker:$SHA