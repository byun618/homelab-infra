# homelab-infra

Mac Mini 홈서버 인프라 구성 레포.

## Stack

- Docker Compose (단일 compose.yaml)
- MySQL 8 — 단일 인스턴스, 서비스별 user/database 분리
- Redis 7
- Cloudflare Tunnel (네트워크)

## 구조

```
docker/compose.yaml    # 모든 서비스 정의
docker/.env            # 시크릿 (gitignore)
db/scripts/            # MySQL 초기화 스크립트 (docker-entrypoint-initdb.d)
```

## 컨벤션

- DB 초기화: `db/scripts/` 에 번호 프리픽스 shell script (`00-init.sh`)
- 서비스 추가 시: compose.yaml에 서비스 + env var 추가 → `00-init.sh`에 CREATE DATABASE/USER 블록 추가
- 데이터 볼륨: `~/.db/{mysql,redis}` (호스트 바인드 마운트)
- SQL alias 사용 금지 — 테이블 풀네임 사용
