docker build -t jblackwell1/multi-client:latest -t jblackwell1/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t jblackwell1/multi-server:latest -t jblackwell1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jblackwell1/multi-worker:latest -t jblackwell1/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push jblackwell1/multi-client:latest 
docker push jblackwell1/multi-server:latest
docker push jblackwell1/multi-worker:latest

docker push jblackwell1/multi-client:$SHA 
docker push jblackwell1/multi-server:$SHA
docker push jblackwell1/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=jblackwell1/multi-server:$SHA
kubectl set image deployments/client-deployment client=jblackwell1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jblackwell1/multi-worker:$SHA