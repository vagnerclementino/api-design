include MakefileDocumentation

.PHONY: build-artifact
build-artifact: ##@helpers Build the artifact.
	@mvn clean package -DskipTests -Dquarkus.profile=staging

.PHONY: run
run: ##@application Run quarkus in dev mode.
	@mvn clean compile quarkus:dev

.PHONY: stop
stop: ##@application Stop all containers.
	docker compose down

.PHONY: code-analysis
lint: ##@quality Run maven code analysis
	@mvn ktlint:check

.PHONY: test
test: ##@quality Run all tests
	@mvn clean test -Dquarkus.profiles=test

.PHONY: smoke
smoke: build-artifact ##@quality Run all tests
	@sam local invoke --template sam.jvm.yaml --event src/test/resources/payloads/api-gateway/eventWithValidBody.json

.PHONY: code-analysis
code-analysis: ##@quality Run sonar linter
	@mvn sonar:sonar -Dsonar.projectKey=com.hotmart.paymentintent:lambda-payment-intent-receiver -Dsonar.token=${SONAR_TOKEN} -Dsonar.host.url=https://sonarqube.devops.hotmart.com -DskipTests

.PHONY: quality
quality: test lint code-analysis smoke ##@quality Run all quality steps

