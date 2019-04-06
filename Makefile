KEYWORD=FIXED

run: build
	docker run --rm -it keyword-releaser "FIXED"
build:
	docker build -t keyword-releaser .
test:
	./entrypoint.sh $(KEYWORD)
