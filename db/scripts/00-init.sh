#!/bin/bash
# 서비스별 user + database 생성
# 새 서비스 추가 시 아래 패턴으로 추가
# 환경변수는 compose.yaml에서 주입

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS home_inventory;
    CREATE USER IF NOT EXISTS 'home_inventory'@'%' IDENTIFIED BY '${HOME_INVENTORY_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON home_inventory.* TO 'home_inventory'@'%';
    FLUSH PRIVILEGES;
EOSQL
