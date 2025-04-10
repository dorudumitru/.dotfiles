APP_NAME := $(shell basename $(CURDIR))

# ==================================================================================== #
# VARIABLES - You can change these variables to suit your needs
# ==================================================================================== #

# Go binary that you want to use. Example: go1.21.10
# To use the default version installed on your system, use "go" without any version number
GO := go
# Absolute path of the go clidriver. Example: /home/doru.dumitru/Documents/go_ibm_db
GO_IBM_DB_PATH := /home/doru.dumitru/Documents/go_ibm_db


# Local development variables
# --------------------------
# Accepted Values
# - darwin
# - linux
OS := linux
ARCH := amd64
MAIN_PACKAGE := github.com/hartehanks-iasi/$(APP_NAME)
# The path to the folder where main.go resides. Example: ./cmd/my-app
MAIN_PACKAGE_PATH := .
# Absolute path of the .arm certificate
CERTIFICATE_PATH := /home/doru.dumitru/Documents/TrustStore/etl.arm

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

ifeq ($(OS),darwin)
	DEV_BINARY_NAME := $(APP_NAME)
	DEV_CLIDRIVER_NAME := macos64_odbc_cli.tar.gz
else ifeq ($(OS),linux)
	DEV_BINARY_NAME := $(APP_NAME)
	DEV_CLIDRIVER_NAME := linuxx64_odbc_cli.tar.gz
else
	$(error OS is not supported)
endif

ifeq ($(GOOS),windows)
	BINARY_NAME := $(APP_NAME).exe
	CLIDRIVER_NAME := ntx64_odbc_cli.zip
	START_SCRIPT_NAME := run.bat
else ifeq ($(GOOS),darwin)
	BINARY_NAME := $(APP_NAME)
	CLIDRIVER_NAME := macos64_odbc_cli.tar.gz
	START_SCRIPT_NAME := run.sh
else ifeq ($(GOOS),linux)
	BINARY_NAME := $(APP_NAME)
	CLIDRIVER_NAME := linuxx64_odbc_cli.tar.gz
	START_SCRIPT_NAME := run.sh
else
	$(error GOOS is not supported)
endif

CLIDRIVER_URL := https://public.dhe.ibm.com/ibmdl/export/pub/software/data/db2/drivers/odbc_cli

export IBM_DB_HOME := ${CURDIR}/clidriver
export CGO_CFLAGS := -I${IBM_DB_HOME}/include
export CGO_LDFLAGS := -L${IBM_DB_HOME}/lib
ifeq ($(OS),darwin)
	export DYLD_LIBRARY_PATH := $(DYLD_LIBRARY_PATH):${IBM_DB_HOME}/lib
else ifeq ($(OS),linux)
	export LD_LIBRARY_PATH := $(LD_LIBRARY_PATH):${IBM_DB_HOME}/lib
endif
export PATH := $(PATH):${IBM_DB_HOME}/bin

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## go/version/sync: syncronyze go binary with the version specified in the Makefile
.PHONY: go/version/sync
go/version/sync:
	@if [ ! "${GO}" == "go" ]; then \
		echo "Syncing Go version..."; \
		go install golang.org/dl/${GO}@latest; \
		${GO} download; \
	fi

.PHONY: ibmdb
ibmdb:
	@if [ ! -d ${GO_IBM_DB_PATH} ]; then \
		mkdir -p ${GO_IBM_DB_PATH}; \
		echo -e "\nDownloading IBM DB2 CLI driver..."; \
		curl -o ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME} ${CLIDRIVER_URL}/${DEV_CLIDRIVER_NAME}; \
		echo -e "\nExtracting IBM DB2 CLI driver..."; \
		tar -xvf ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME} -C ${GO_IBM_DB_PATH}; \
		rm ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME}; \
	fi

## ibmdb/latest: download latest version of IBM DB2 CLI driver
.PHONY: ibmdb/latest
ibmdb/latest:
	@echo "Downloading latest IBM DB2 CLI driver..."
	@rm -rf ${GO_IBM_DB_PATH}
	@mkdir -p ${GO_IBM_DB_PATH}
	@curl -o ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME} ${CLIDRIVER_URL}/${DEV_CLIDRIVER_NAME}
	@echo -e "\nExtracting IBM DB2 CLI driver..."
	@tar -xvf ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME} -C ${GO_IBM_DB_PATH}
	@rm ${GO_IBM_DB_PATH}/${DEV_CLIDRIVER_NAME}

.PHONY: print/init
print/init:
	@echo "Initializing project..."
	@echo "Project name: ${APP_NAME}"
	@echo "OS: ${OS}"
	@echo "ARCH: ${ARCH}"
	@echo "MAIN_PACKAGE: ${MAIN_PACKAGE}"
	@echo "MAIN_PACKAGE_PATH: ${MAIN_PACKAGE_PATH}"
	@echo "GOOS: ${GOOS}"
	@echo "GOARCH: ${GOARCH}"

## init: initialize the project
.PHONY: init
init: print/init ibmdb go/version/sync
	@echo -e "\nIBM DB2 CLI driver info:"
	@echo "$$(${GO_IBM_DB_PATH}/clidriver/bin/db2level)"
	@echo -e "\nInitializing git repository..."
	@git init
	@touch .gitignore
	@echo "certs/" >> .gitignore
	@echo "clidriver/" >> .gitignore
	@echo "dist/" >> .gitignore
	@echo ".idea/" >> .gitignore
	@echo ".vscode/" >> .gitignore
	@echo -e "\nInitializing Go module..."
	@${GO} mod init ${MAIN_PACKAGE}
	@${GO} get -d github.com/ibmdb/go_ibm_db
	@mkdir -p certs
	@cp ${CERTIFICATE_PATH} certs
	@mkdir -p ${MAIN_PACKAGE_PATH} && touch ${MAIN_PACKAGE_PATH}/main.go
	@echo -e "\nDownloading golangci-lint config..."
	@curl -O https://gist.githubusercontent.com/maratori/47a4d00457a92aa426dbd48a18776322/raw/ae78780d0653027c1c83d3a705cfda028afc1a5b/.golangci.yml
	@echo -e "\nDone."

.PHONY: clean
clean:
	@if [ ! -d "$(CURDIR)/dist/${GOOS}_${GOARCH}/${APP_NAME}/clidriver" ]; then \
		rm -rf dist; \
	else \
		mkdir -p /tmp/${GOOS}_${GOARCH}/${APP_NAME}; \
		cp -r ./dist/${GOOS}_${GOARCH}/${APP_NAME}/clidriver /tmp/${GOOS}_${GOARCH}/${APP_NAME}/clidriver; \
		rm -rf dist; \
		mkdir -p dist/${GOOS}_${GOARCH}/${APP_NAME}; \
		cp -r /tmp/${GOOS}_${GOARCH}/${APP_NAME}/clidriver ./dist/${GOOS}_${GOARCH}/${APP_NAME}/clidriver; \
		rm -rf /tmp/${GOOS}_${GOARCH}; \
	fi

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

## test: run all tests
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
build: ibmdb
	@${GO} build -o /tmp/bin/${DEV_BINARY_NAME} ${MAIN_PACKAGE_PATH}

## run: run the  application
.PHONY: run
run: lint build
	@/tmp/bin/${DEV_BINARY_NAME} ${RUNARGS}

## watch: run the application with reloading on file changes
.PHONY: watch
watch: lint
	@${GO} run github.com/cosmtrek/air@latest \
		--build.cmd "make build" --build.bin "/tmp/bin/${DEV_BINARY_NAME} ${RUNARGS}" --build.delay "100" \
		--build.exclude_dir "certs,clidriver,dist" \
		--build.include_ext "go, tpl, tmpl, html, css, scss, js, ts, sql, jpeg, jpg, gif, png, bmp, svg, webp, ico" \
		--misc.clean_on_exit "true"

# ==================================================================================== #
# OPERATIONS
# ==================================================================================== #

## push: push changes to the remote Git repository
.PHONY: push
push: lint tidy audit no-dirty
	git push

## prod: create a production build of the application
.PHONY: prod
prod: clean lint tidy audit no-dirty
	GOOS=${GOOS} GOARCH=${GOARCH} ${GO} build -ldflags='-s' -o dist/${GOOS}_${GOARCH}/${APP_NAME}/${BINARY_NAME} ${MAIN_PACKAGE_PATH}
	upx -5 ./dist/${GOOS}_${GOARCH}/${APP_NAME}/${BINARY_NAME}
	@echo -e "\nCopying certificates..."
	@cp -r ./certs ./dist/${GOOS}_${GOARCH}/${APP_NAME}/
	
	@if [ ! -d "$(CURDIR)/dist/${GOOS}_${GOARCH}/${APP_NAME}/clidriver" ]; then \
		if [ "${OS}" == "${GOOS}" ]; then \
			echo -e "\nCreating clidriver for production..."; \
			cp -r ${GO_IBM_DB_PATH} ./dist/${GOOS}_${GOARCH}/${APP_NAME}/; \
		else \
			echo -e "\nDownloading IBM DB2 CLI driver..."; \
			cd dist/${GOOS}_${GOARCH}/${APP_NAME}; \
			curl -O ${CLIDRIVER_URL}/${CLIDRIVER_NAME}; \
			echo -e "\nExtracting IBM DB2 CLI driver..."; \
			if [ "${GOOS}" == "windows" ]; then \
				unzip ${CLIDRIVER_NAME}; \
			else \
				tar -xvf ${CLIDRIVER_NAME}; \
			fi; \
			rm ${CLIDRIVER_NAME}; \
		fi; \
	fi

	@echo -e "\nCreating run script..."
	@if [ "${GOOS}" == "windows" ]; then \
		echo "@echo off" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "cd clidriver" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "set clidrvpath=%cd%" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "set IBM_DB_HOME=%clidrvpath%" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "set PATH=%PATH%;%IBM_DB_HOME%\bin" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "set PATH=%PATH%;%clidrvpath%\bin\amd64.VC12.CRT" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "cd ../" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "cmd /k ${BINARY_NAME}" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
	else \
		echo "if [ \"\$$IBM_DB_HOME\" == \"\" ]" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "then" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "    IBM_DB_HOME=\`pwd\`/clidriver" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "fi" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "OS=\`uname\`" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "export CGO_CFLAGS=-I\$$IBM_DB_HOME/include" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "export CGO_LDFLAGS=-L\$$IBM_DB_HOME/lib" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "if [ \"\$$OS\" == \"Darwin\" ]" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "then" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "    export DYLD_LIBRARY_PATH=\$$DYLD_LIBRARY_PATH:\$$IBM_DB_HOME/lib" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "else" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "    export LD_LIBRARY_PATH=\$$LD_LIBRARY_PATH:\$$IBM_DB_HOME/lib" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "fi" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "export PATH=\$$PATH:\$$IBM_DB_HOME/bin" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "./${BINARY_NAME}" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "echo -e \"\\n\"" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
		echo "read -p \"Press any key to continue\" x" >> dist/${GOOS}_${GOARCH}/${APP_NAME}/${START_SCRIPT_NAME}; \
	fi
	@echo -e "\nDone."

## deploy: deploy the application to production
.PHONY: deploy
deploy:
	# include deployment steps here...
