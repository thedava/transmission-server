DC = docker-compose
EXEC = $(DC) exec -u 1000 transmission

exec:
	$(EXEC) /bin/bash


# make create-from-url -e URL="http://www.example.com/file.zip" -e FILE="file.zip"
create-from-url:
	$(EXEC) /bin/bash /custom/bin/create-from-url.sh "$(URL)" "$(FILE)"
