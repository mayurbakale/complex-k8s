docker build -t mayurbakale/fibo-multi-client:latest -t mayurbakale/fibo-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mayurbakale/fibo-multi-server:latest -t mayurbakale/fibo-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mayurbakale/fibo-multi-worker:latest -t mayurbakale/fibo-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mayurbakale/fibo-multi-client:latest
docker push mayurbakale/fibo-multi-server:latest
docker push mayurbakale/fibo-multi-worker:latest
docker push mayurbakale/fibo-multi-client:$SHA
docker push mayurbakale/fibo-multi-server:$SHA
docker push mayurbakale/fibo-multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=mayurbakale/fibo-multi-server:$SHA
kubectl set image deployment/client-deployment client=mayurbakale/fibo-multi-client:$SHA
kubectl set image deployment/worker-deployment worker=mayurbakale/fibo-multi-worker:$SHA