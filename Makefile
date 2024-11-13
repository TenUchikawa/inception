NAME = inception
SRC_DIR = srcs
DOCKER_COMPOSE = docker compose -f $(SRC_DIR)/docker-compose.yml
ENV_FILE = $(SRC_DIR)/.env

DB_DATA_DIR = volumes/db_data
SSL_CERTS_DIR = volumes/ssl_certs
WORDPRESS_DATA_DIR = volumes/wordpress_data


# デフォルトターゲット
all: create_volumes up

# Docker コンテナをビルドして起動
build: create_volumes
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
clean: remove_volumes
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
fclean: clean remove_volumes
	@echo "Performing full cleanup..."
	docker system prune -af


remove_volumes:
	@echo "Removing volume directories..."
	@sudo rm -rf $(DB_DATA_DIR) $(SSL_CERTS_DIR) $(WORDPRESS_DATA_DIR)

# 必要なボリュームディレクトリの作成
create_volumes:
	@echo "Checking if volume directories exist..."
	@if [ ! -d "$(DB_DATA_DIR)" ]; then \
		echo "Creating volume directory: $(DB_DATA_DIR)"; \
		mkdir -p $(DB_DATA_DIR); \
	fi
	@if [ ! -d "$(SSL_CERTS_DIR)" ]; then \
		echo "Creating volume directory: $(SSL_CERTS_DIR)"; \
		mkdir -p $(SSL_CERTS_DIR); \
	fi
	@if [ ! -d "$(WORDPRESS_DATA_DIR)" ]; then \
		echo "Creating volume directory: $(WORDPRESS_DATA_DIR)"; \
		mkdir -p $(WORDPRESS_DATA_DIR); \
	fi

.PHONY: all build up docreate_volumeswn clean re logs healthcheck fclean create_volumes