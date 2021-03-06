.PHONY: default clean validate

default: requirements.txt requirements-dev.txt validate

.terraform:
	terraform init terraform

Pipfile.lock: Pipfile
	pipenv lock

requirements.txt: Pipfile.lock
	pipenv lock -r > $@

requirements-dev.txt: Pipfile.lock
	pipenv lock -r -d > $@

clean:
	rm -rf terraform/.terraform

validate: | .terraform
	terraform validate terraform
