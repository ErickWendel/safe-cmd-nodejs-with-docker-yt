
curl -X POST "http://localhost:3000/exec" -d '{"command": "ls -la"}' | jq
curl -X POST "http://localhost:3000/exec" -d '{"command": "cd documents && echo aeee > newfile.txt && cat newfile.txt"}' | jq
curl -X POST "http://localhost:3000/exec" -d '{"command": "cd documents && rm newfile.txt"}' | jq
curl -X POST "http://localhost:3000/exec" -d '{"command": "cd ~ && ls -la"}' | jq


# spawm
curl -X POST "http://localhost:3000/spawn" -d '{"command": "ls -la"}' | jq
curl -X POST "http://localhost:3000/spawn" -d '{"command": "ls -la && rm -rf ."}' | jq
curl -X POST "http://localhost:3000/spawn" -d '{"command": "ENV"}' | jq

# vm2

curl --silent -X POST "http://localhost:3000/docker" -d '{"command": "ls -la "}' | jq
curl --silent -X POST "http://localhost:3000/docker" -d '{"command": "cat abc.txt "}' | jq



