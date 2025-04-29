include MakefileDocumentation

.PHONY: build
build: ##@build Build the application
	@mvn clean package

.PHONY: run
run: ##@run Run locally in development mode
	@mvn spring-boot:run -Dspring-boot.run.profiles=local

.PHONY: test
test: ##@test Run all tests
	@mvn test

.PHONY: test-coverage
test-coverage: ##@test Run tests with coverage report
	@mvn test jacoco:report

.PHONY: lint
lint: ##@quality Run code style checks
	@mvn checkstyle:check

.PHONY: docker-build
docker-build: ##@docker Build Docker image
	@docker build -t api-holiday .

.PHONY: docker-run
docker-run: ##@docker Run in Docker container
	@docker run -p 8080:8080 api-holiday

.PHONY: lambda-local
lambda-local: build ##@aws Test Lambda function locally
	@test -f src/test/resources/lambda/payload.json || { echo "Creating default payload file"; mkdir -p src/test/resources/lambda && echo '{"body":"test"}' > src/test/resources/lambda/payload.json; }
	@test -f target/sam.yaml || { echo "SAM template not found at target/sam.yaml"; exit 1; }
	@chmod 644 target/api-holiday-0.0.1-SNAPSHOT-aws.jar
	@sam local invoke --template target/sam.yaml --event src/test/resources/lambda/payload.json

.PHONY: deploy
deploy: build ##@aws Deploy to AWS Lambda
	@sam deploy --guided

.PHONY: clean
clean: ##@clean Remove build artifacts
	@mvn clean
	@rm -rf target

.PHONY: all
all: clean build test ##@build Run full build pipeline

