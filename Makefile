NAME = inception
SRC_DIR = srcs
DOCKER_COMPOSE = docker compose -f $(SRC_DIR)/docker-compose.yml
ENV_FILE = $(SRC_DIR)/.env

# デフォルトターゲット
all: up

# Docker コンテナをビルドして起動
build:
	@echo "Building Docker containers..."
	$(DOCKER_COMPOSE) build

# Docker コンテナをバックグラウンドで起動
up: build
	@echo "Starting Docker containers..."
	$(DOCKER_COMPOSE) up -d

# Docker コンテナを停止
down:
	@echo "Stopping Docker containers..."
	$(DOCKER_COMPOSE) down

# Docker コンテナを停止して、ボリュームとネットワークも削除
clean:
	@echo "Cleaning up Docker containers, networks, and volumes..."
	$(DOCKER_COMPOSE) down -v --rmi all

# 完全に再構築
re: clean all

# ログの表示
logs:
	@echo "Showing logs..."
	$(DOCKER_COMPOSE) logs -f

# ヘルスチェック
healthcheck:
	@echo "Checking container health..."
	$(DOCKER_COMPOSE) ps

# クリーンアップして Docker システムを最適化
fclean: clean
	@echo "Performing full cleanup..."
	docker system prune -af


.PHONY: all build up down clean re logs healthcheck fclean help