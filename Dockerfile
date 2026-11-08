# 베이스: 공식 nginx:alpine 이미지 (방식 A: 웹 서버 베이스 + 정적 콘텐츠/설정 교체)
FROM nginx:1.27-alpine

# 1) 메타데이터: 이미지 출처/설명을 남겨 관리성 향상
LABEL org.opencontainers.image.title="e1-1-custom-nginx" \
      org.opencontainers.image.description="Codyssey E1-1 dev workstation mission web server"

# 2) 환경 변수: 실행 환경 구분용 (코드와 설정 분리)
ENV APP_ENV=dev

# 3) 설정 교체: /health 엔드포인트가 추가된 서버 설정
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# 4) 정적 콘텐츠 교체: 기본 Welcome 페이지 대신 직접 만든 페이지
COPY app/ /usr/share/nginx/html/

# 5) 헬스체크: 컨테이너 상태를 docker ps에서 healthy/unhealthy로 확인
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1/health || exit 1

EXPOSE 80
