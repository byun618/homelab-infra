#!/bin/bash
# 서비스별 user + database 생성
# 새 서비스 추가 시 아래 패턴으로 추가
# 환경변수는 compose.yaml에서 주입

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER ai_life_coach WITH PASSWORD '${AI_LIFE_COACH_DB_PASSWORD}';
    CREATE DATABASE ai_life_coach OWNER ai_life_coach;
    GRANT ALL PRIVILEGES ON DATABASE ai_life_coach TO ai_life_coach;
EOSQL
