# homelab-infra

Mac Mini 홈서버 인프라 구성.

## Stack

- **Network**: Cloudflare Tunnel
- **Container**: Docker Compose
- **Database**: MySQL — 단일 인스턴스, 서비스별 user/database

## Structure

```
docker/          # Docker Compose 정의
db/init/         # MySQL 초기화 SQL (서비스별 user + database)
```

## Getting Started

```bash
cp docker/.env.example docker/.env
# .env 값 채우기
docker compose -f docker/compose.yaml up -d
```
