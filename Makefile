# vanity
GREEN = \033[0;32m
MAGENTA = \033[0;35m
BLUE = \033[0;34m
RESET = \033[0;0m

# setup
.PHONY: setup
setup: install-golint

.PHONY: install-golint
install-golint:
	@echo "$(MAGENTA)installing golint...$(RESET)"
	@go install golang.org/x/lint/golint

.PHONY: test
test:
	@echo "$(MAGENTA)running go tests...$(RESET)"
	@go test -v ./...

.PHONY: lint
lint: install-golint
	@echo "$(MAGENTA)linting...$(RESET)"
	# TODO: lint errors should fail this step (use -set_exit_status)
	@golint ./...

# releasing
.PHONY: release-%
release-%:
	@echo "$(BLUE)staging for a new release$(RESET)"
	go run ./internal/cmd/cmd.go release $(@:release-%=%)
	@echo "$(BLUE)the package has been prepared for release, please review the changes made to"
	@echo "the git repo by inspecting 'git log' and 'git tag --list | tail -n 5'"
	@echo "before pushing the changes with 'git push --follow-tags'$(RESET)"
