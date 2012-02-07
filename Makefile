
SRC = lib/events.js lib/tiagent.js

TESTS = test/node/*.js
REPORTER = dot

all: tiagent.js tiagent.min.js

test:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require should \
		--reporter $(REPORTER) \
		--timeout 100 \
		--growl \
		$(TESTS)

tiagent.js: $(SRC)
	cat $^ > $@

tiagent.min.js: tiagent.js
	uglifyjs --no-mangle $< > $@

test-server:
	@node test/server

docs: lib test-docs

test-docs:
	make test REPORTER=doc \
		| cat docs/head.html - docs/tail.html \
		> docs/test.html

clean:
	rm -f tiagent{,.min}.js

.PHONY: test docs test-docs clean