.PHONY: build
build:
	docker build \
		-t ghcr.io/quantumsheep/hytale-docker:latest \
		 --label "org.opencontainers.image.source=https://github.com/quantumsheep/hytale-docker" \
		--label "org.opencontainers.image.description=Hytale server in a Docker container" \
		--label "org.opencontainers.image.licenses=MIT" \
		.
	docker run ghcr.io/quantumsheep/hytale-docker:latest --version | tail -n 1 | awk '{print $$2}' > /tmp/hytale_version
	docker tag ghcr.io/quantumsheep/hytale-docker:latest ghcr.io/quantumsheep/hytale-docker:$$(cat /tmp/hytale_version)

.PHONY: push
push: build
	docker push ghcr.io/quantumsheep/hytale-docker:latest
	docker push ghcr.io/quantumsheep/hytale-docker:$$(cat /tmp/hytale_version)
