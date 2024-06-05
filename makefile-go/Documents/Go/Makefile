APP_NAME := $(shell basename $(CURDIR))

# ==================================================================================== #
# VARIABLES - You can change these variables to suit your needs
# ==================================================================================== #

# Go binary that you want to use. Example: go1.21.10. Default: go
GO := go

# Local development variables
# --------------------------
# Accepted Values
# - windows
# - darwin
# - linux
OS := linux
ARCH := amd64
MAIN_PACKAGE := github.com/hartehanks-iasi/$(APP_NAME)
# The path to the folder where main.go resides. Example: ./cmd/my-app
MAIN_PACKAGE_PATH := .

# Use if the app requires flags (ex: -u username -p password)
RUNARGS := 

# Production build variables
# --------------------
# Accepted Values
# - windows
# - darwin
# - linux
GOOS := linux
# Run "go tool dist list" for all possible values
GOARCH := amd64

# ==================================================================================== #
# VARIABLES - Do not change these variables
# ==================================================================================== #

ifeq ($(OS),windows)
	DEV_BINARY_NAME := $(APP_NAME).exe
else ifeq ($(OS),darwin)
	DEV_BINARY_NAME := $(APP_NAME)
else ifeq ($(OS),linux)
	DEV_BINARY_NAME := $(APP_NAME)
else
	$(error OS is not supported)
endif

ifeq ($(GOOS),windows)
	BINARY_NAME := $(APP_NAME).exe
else ifeq ($(GOOS),darwin)
	BINARY_NAME := $(APP_NAME)
else ifeq ($(GOOS),linux)
	BINARY_NAME := $(APP_NAME)
else
	$(error GOOS is not supported)
endif

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## init: initialize the project
.PHONY: init
init:
	@echo "Initializing project..."
	@echo "Project name: ${APP_NAME}"
	@echo "OS: ${OS}"
	@echo "ARCH: ${ARCH}"
	@echo "Main package: ${MAIN_PACKAGE}"
	@echo "Main package path: ${MAIN_PACKAGE_PATH}"
	@echo "GOOS: ${GOOS}"
	@echo "GOARCH: ${GOARCH}"
	@echo -e "\nInitializing git repository..."
	@git init
	@touch .gitignore
	@echo "dist/" >> .gitignore
	@echo ".idea/" >> .gitignore
	@echo ".vscode/" >> .gitignore
	@echo -e "\nInitializing Go module..."
	@${GO} mod init ${MAIN_PACKAGE}
	@mkdir -p ${MAIN_PACKAGE_PATH} && touch ${MAIN_PACKAGE_PATH}/main.go
	@echo -e "\nDownloading golangci-lint config..."
	@curl -O https://gist.githubusercontent.com/dorudumitru/f6207afab6e41ebbc5b3ef6dcc2c354e/raw/0705a77825bec3628f6f0343af44eee09fabf8ec/.golangci.yml
	@echo -e "\nDone."

.PHONY: clean
clean:
	@rm -rf dist

.PHONY: no-dirty
no-dirty:
	git diff --exit-code

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## lint: run golangci-lint
.PHONY: lint
lint:
	@golangci-lint run

## tidy: format code and tidy modfile
.PHONY: tidy
tidy:
	${GO} fmt ./...
	${GO} mod tidy -v

## audit: run quality control checks
.PHONY: audit
audit:
	${GO} mod verify
	${GO} vet ./...
	${GO} run honnef.co/go/tools/cmd/staticcheck@latest -checks=all,-ST1000,-U1000 ./...
	${GO} run golang.org/x/vuln/cmd/govulncheck@latest ./...
	${GO} test -race -buildvcs -vet=off ./...

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## test: run all unit tests
.PHONY: test
test:
	${GO} test -v -race -buildvcs ./...

## test/integration: run all tests including integration
.PHONY: test/integration
test/integration:
	# include integration tests steps here...

## test/cover: run all tests and display coverage
.PHONY: test/cover
test/cover:
	${GO} test -v -race -buildvcs -coverprofile=/tmp/coverage.out ./...
	${GO} tool cover -html=/tmp/coverage.out

## build: build the application
# include additional build steps, like TypeScript, SCSS or Tailwind compilation here...
.PHONY: build
build:
	@${GO} build -o /tmp/bin/${DEV_BINARY_NAME} ${MAIN_PACKAGE_PATH}

## run: run the  application
.PHONY: run
run: lint build
	@/tmp/bin/${DEV_BINARY_NAME} ${RUNARGS}

## watch: run the application with reloading on file changes
.PHONY: watch
watch: lint
	@${GO} run github.com/cosmtrek/air@latest \
		--build.cmd "make build" \
		--build.bin "/tmp/bin/${DEV_BINARY_NAME} ${RUNARGS}" \
		--build.delay "100" \
		--build.exclude_dir "dist" \
		--build.include_ext "go, tpl, tmpl, html, css, scss, js, ts, sql, jpeg, jpg, gif, png, bmp, svg, webp, ico" \
		--misc.clean_on_exit "true"

# ==================================================================================== #
# OPERATIONS
# ==================================================================================== #

## push: push changes to the remote Git repository
.PHONY: push
push: lint tidy audit no-dirty
	git push

## production: create a production build of the application
.PHONY: prod
prod: clean lint tidy audit no-dirty
	GOOS=${GOOS} GOARCH=${GOARCH} ${GO} build -ldflags='-s' -o dist/${GOOS}_${GOARCH}/${APP_NAME}/${BINARY_NAME} ${MAIN_PACKAGE_PATH}
	upx -5 ./dist/${GOOS}_${GOARCH}/${APP_NAME}/${BINARY_NAME}

## deploy: deploy the application to production
.PHONY: deploy
deploy:
	# include deployment steps here...
