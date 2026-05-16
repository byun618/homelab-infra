# homelab-infra

Mac Mini 홈서버 인프라 구성.

## Stack

- **Network**: Cloudflare Tunnel
- **Container**: Docker Compose
- **Database**: MySQL — 단일 인스턴스, 서비스별 user/database
- **CI/CD**: GitHub Actions self-hosted runner (`services/_runner/`)

## Structure

```
docker/          # Data layer (MySQL/Redis/Postgres) compose 정의
db/              # 초기화 SQL
services/        # Application services + CI runner — 각 서비스별 docker-compose + .env
```

## Getting Started

### Data layer (1회)
```bash
cp docker/.env.example docker/.env
# .env 값 채우기
docker compose -f docker/compose.yaml up -d
```

### Application service 운영
[services/README.md](./services/README.md) 참고. 각 서비스 디렉토리에서 `docker compose up -d`.
