# exec
curl -X POST http://localhost:3000/exec --data '{"command": "ls -la"}' | jq
curl -X POST http://localhost:3000/exec --data '{"command": "cd documents && ls -la"}' | jq
curl -X POST http://localhost:3000/exec --data '{"command": "echo aeee > newfile.txt"}' | jq
curl -X POST http://localhost:3000/exec --data '{"command": "mv newfile.txt documents/"}' | jq
curl -X POST http://localhost:3000/exec --data '{"command": "cd documents/ && cat newfile.txt"}' | jq
curl -X POST http://localhost:3000/exec --data '{"command": "ls -la ~"}' | jq

# 
curl -X POST http://localhost:3000/spawn --data '{"command": "ls -la"}' | jq
curl -X POST http://localhost:3000/spawn --data '{"command": "ls -la /Users"}' | jq


# docker cmd
docker run -it \
    -v "$PWD"/documents:/documents \
    node:14-alpine sh

docker run --rm \
    -v "$PWD"/documents:/documents \
    node:14-alpine node -e 'console.log("aeeee")'

# docker
curl --silent -X POST http://localhost:3000/docker --data '{"command": "ls"}' | jq
curl --silent -X POST http://localhost:3000/docker --data '{"command": "ls -la /"}' | jq
curl --silent -X POST http://localhost:3000/docker --data '{"command": "cat abc.txt"}' | jq