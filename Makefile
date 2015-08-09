# -*- mode: Makefile; fill-column: 80; comment-column: 75; -*-

# =============================================================================
# Use approved HTTPS proxy for Github access
# =============================================================================
export HTTPS_PROXY=www-proxy.wetafx.co.nz:3128
export GIT_SSL_NO_VERIFY=true

# =============================================================================
# Set pythonpath so Eunit tests complete
# =============================================================================
env PYTHONPATH="priv"

# =============================================================================
# Verify that the programs we need to run are installed on this system
# =============================================================================

ERL = $(shell which erl)

ifeq ($(ERL),)
$(error "Erlang not available on this system")
endif

REBAR=$(shell which rebar3)

ifeq ($(REBAR),)
$(error "Rebar not available on this system")
endif

ERLDOCS=$(shell which erldocs)

.PHONY: all deps update-deps compile docs erldocs dialyzer typer ct clean clean-doc distclean

# =============================================================================
# Rules to build the system
# =============================================================================

all: compile dialyzer eunit

update-deps:
	$(REBAR) upgrade
	$(REBAR) compile

compile:
	$(REBAR) compile

docs:
	$(REBAR) edoc

dialyzer:
	$(REBAR) dialyzer

eunit:
	$(REBAR) eunit

release: compile dialyzer eunit docs
	$(REBAR) as prod release

# =============================================================================
# Clean
# =============================================================================

clean:
	$(REBAR) clean

distclean: clean
	$(REBAR) clean --all
	rm -vf $(CURDIR)/rebar.lock
	rm -rvf $(CURDIR)/_build
