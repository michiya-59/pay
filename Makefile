default: up

up:
	docker-compose up -d && docker-compose rm -f

s:
	foreman start -f Procfile.local
