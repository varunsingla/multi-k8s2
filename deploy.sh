docker build -t varunsingla1982/multi-client:latest -t varunsingla1982/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t varunsingla1982/multi-server:latest -t varunsingla1982/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t varunsingla1982/multi-worker:latest -t varunsingla1982/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push varunsingla1982/multi-client:latest
docker push varunsingla1982/multi-server:latest
docker push varunsingla1982/multi-worker:latest

docker push varunsingla1982/multi-client:$SHA
docker push varunsingla1982/multi-server:$SHA
docker push varunsingla1982/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=varunsingla1982/multi-server:$SHA
kubectl set image deployments/client-deployment client=varunsingla1982/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=varunsingla1982/multi-worker:$SHA