# tc-root
Tests constructor demo app

# Docker deployment

- `./backend/docker-build.sh`
- `./frontend/docker-build.sh production`
- `docker-compose up -d`
- Navigate to localhost:8082 and create tstore_dev database using utf8
- `$GOPATH/bin/goose -path $GOPATH/src/github.com/jho4us/tc/testdb/sqlite up`
- Navigate to localhost:8080
