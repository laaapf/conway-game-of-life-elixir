CC=elixirc
SRC=life.ex
DOCKER_IMAGE_TAG=conway-game-of-life-elixir
EXAMPLE_FILES=$(wildcard examples/*.txt)

.PHONY: run clean test docker-build docker-run docker-test
run: clean
	@elixirc $(SRC)
	@elixir -e Game.main

clean:
	@-rm *.beam

test:
	@elixirc $(SRC)
	@for filename in $(EXAMPLE_FILES); do \
		n_iterations=$$(echo -e "$${filename}\n100" | elixir -e Game.main | tail -n 1 | grep -o "[[:digit:]]*"); \
		if [[ "$$filename" = "examples/beehive.txt" && "$$n_iterations" != "2" ]]; then exit 1; fi; \
		if [[ "$$filename" = "examples/empty.txt" && "$$n_iterations" != "15" ]]; then exit 1; fi; \
		if [[ "$$filename" = "examples/expansion_and_blinkers.txt" && "$$n_iterations" != "100" ]]; then exit 1; fi; \
		if [[ "$$filename" = "examples/glider.txt" && "$$n_iterations" != "61" ]]; then exit 1; fi; \
		if [[ "$$filename" = "examples/gun.txt" && "$$n_iterations" != "100" ]]; then exit 1; fi; \
		if [[ "$$filename" = "examples/zombie.txt" && "$$n_iterations" != "3" ]]; then exit 1; fi; \
	done

docker-build:
	docker build -t $(DOCKER_IMAGE_TAG) .

docker-run:
	docker run --rm -ti $(DOCKER_IMAGE_TAG)

docker-test: docker-build
	docker run --rm $(DOCKER_IMAGE_TAG) sh -c "make test"
