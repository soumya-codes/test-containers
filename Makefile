.PHONY: up down down-v redis redis-down postgres postgres-down mysql mysql-down redis-client redis-client-down postgres-client postgres-client-down mysql-client mysql-client-down dice-cli dice-cli-host dice-cli-down dice dice-down

IP ?= host.docker.internal # DNS name of the host machine on MAC and Windows
PORT ?= 7379
HOST_TYPE ?= macos # Allowed HOST_TYPEs = linux, macos, windows

# Bring up all services
up:
	docker-compose up -d

# Bring down all services
down:
	docker-compose down

# Bring down all services and remove volumes
down-v:
	docker-compose down -v

# Bring up Redis
redis:
	docker-compose up -d redis

# Bring down Redis and remove volumes
redis-down:
	docker-compose down -v redis

# Bring up PostgreSQL
postgres:
	docker-compose up -d postgres

# Bring down PostgreSQL and remove volumes
postgres-down:
	docker-compose down -v postgres

# Bring up MySQL
mysql:
	docker-compose up -d mysql

# Bring down MySQL and remove volumes
mysql-down:
	docker-compose down -v mysql

# Bring up only Redis client and log into its shell
redis-client:
	docker-compose up -d redis-client
	docker exec -it redis-client redis-cli -h redis

# Bring down only Redis client and remove volumes
redis-client-down:
	docker-compose down -v redis-client

# Bring up only PostgreSQL client and log into its shell
postgres-client:
	docker-compose up -d postgres-client
	docker exec -it postgres-client psql -h postgres -U user -d testdb

# Bring down only PostgreSQL client and remove volumes
postgres-client-down:
	docker-compose down -v postgres-client

# Bring up only MySQL client and log into its shell
mysql-client:
	docker-compose up -d mysql-client
	docker exec -it mysql-client mysql -h mysql -u user -p password testdb

# Bring down only MySQL client and remove volumes
mysql-client-down:
	docker-compose down -v mysql-client

# Bring up Dice DB CLI container and connect to Dice-DB 
dice-cli:
	HOST_TYPE=$(HOST_TYPE) docker-compose up -d dice-cli
	docker exec -it dice-cli /bin/bash -c "/app/connect.sh $(IP) $(PORT)"

# Bring up Dice DB CLI container and connect to Dice-DB running on host machine, port 7379
dice-cli-host:
	HOST_TYPE=$(HOST_TYPE) docker-compose up -d dice-cli
	docker exec -it dice-cli /bin/bash -c "/app/connect.sh"

# Bring down dice-cli container
dice-cli-down:
	docker-compose down -v dice-cli

# Bring up Dice DB and Dice CLI containers and connect to DICE DB from Dice CLI container
dice:
	docker-compose up -d dice dice-cli
	docker exec -it dice-cli /bin/bash -c "/app/connect.sh dice 7379"

# Bring down Dice DB and Dice CLI containers 
dice-down:
	docker-compose down -v dice-cli dice
