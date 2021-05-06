CC=elixirc
SRC=life.ex

.PHONY: main clean
main: clean
	@elixirc life.ex
	@elixir -e Game.main
clean:
	@-rm *.beam
