.PHONY: check-ready check-live

host ?= localhost
port ?= 5672
max_try ?= 1
wait_seconds ?= 1
delay_seconds ?= 0

default: check-ready

check-ready:
	wait_for_rabbitmq $(host) $(port) $(max_try) $(wait_seconds) $(delay_seconds)

check-live:
	@echo "OK"
