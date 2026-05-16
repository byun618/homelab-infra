# services/

Mac mini에서 운영하는 application service들의 docker-compose 정의.

## 구조

```
services/
├── _runner/                  GitHub Actions self-hosted runner (myoung34/github-runner)
│   ├── docker-compose.yml
│   ├── .env.example
│   └── .env                  (gitignored)
└── home-coffing/             home-coffing API
    ├── docker-compose.yml
    ├── .env.example
    └── .env                  (gitignored)
```

각 디렉토리는 독립된 docker-compose 단위. `cd services/<name> && docker compose up -d`로 개별 운영.

## 컨벤션

- `_<name>/`: 인프라성 서비스 (runner, monitoring 등) — 정렬 우선
- `<name>/`: application service
- `.env`는 gitignored. 신규 셋업 시 `.env.example` 복사 + 값 채움
- `docker-compose.yml`은 runtime config만. 시크릿은 `.env`에

## 운영 명령

### 시작
```bash
cd services/<name>
docker compose up -d
```

### 재기동
```bash
cd services/<name>
docker compose pull          # 외부 이미지 사용 시
docker compose up -d
```

### 로그
```bash
cd services/<name>
docker compose logs -f
```

### 정지
```bash
cd services/<name>
docker compose down
```

## 신규 서비스 추가

1. `services/<name>/` 디렉토리 생성
2. `docker-compose.yml` 작성
3. `.env.example` + `.env`(gitignored) 작성
4. `cd services/<name> && docker compose up -d`
5. (선택) Cloudflare Tunnel ingress 추가 — `/etc/cloudflared/config.yml`

## 서비스별 메모

### home-coffing
- 이미지는 mac mini local docker daemon 안에서 관리 (외부 레지스트리 X)
- `byun618/home-coffing` repo의 GHA self-hosted runner가 `home-coffing-api:<branch>-<sha7>` 태그로 빌드
- deploy 시 워크플로가 `API_IMAGE_TAG` env로 override해서 `docker compose up -d api` 실행
- 디스크 정리: 주기적으로 `docker image prune -af --filter "until=720h"` 권장 (30일 보관)

### _runner
- `byun618/home-coffing` repo 전용 self-hosted runner
- `/var/run/docker.sock` 마운트해서 host docker daemon 조작 (build/push/compose 모두 host에서 실행)
- `services/` 디렉토리 bind mount — 워크플로의 `cd services/home-coffing` 명령이 host와 컨테이너에서 동일 효과
