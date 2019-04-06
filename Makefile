KEYWORD=FIXED

run: build
	docker run --rm -it keyword-releaser $(KEYWORD)

build:
	docker build -t keyword-releaser .

test:
	./entrypoint.sh $(KEYWORD)
