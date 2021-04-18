docker build -t mboulon/multi-client:latest -t mboulon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mboulon/multi-server:latest -t mboulon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mboulon/multi-worker:latest -t mboulon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mboulon/multi-client:latest
docker push mboulon/multi-server:latest
docker push mboulon/multi-worker:latest

docker push mboulon/multi-client:$SHA
docker push mboulon/multi-server:$SHA
docker push mboulon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=mboulon/multi-client:$SHA
kubectl set image deployments/server-deployment server=mboulon/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mboulon/multi-worker:$SHA