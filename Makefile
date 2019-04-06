KEYWORD=FIXED

run: build
	docker run --rm keyword-releaser $(KEYWORD)

build:
	docker build --tag keyword-releaser .

test:
	./entrypoint.sh $(KEYWORD)
