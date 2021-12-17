ENV=staging
PROJECT=some-service-a
COMPONENT=backend

.PHONY: deploy-all
deploy-all: verify-backend verify-batch deploy-backend deploy-batch

.PHONY: verify-backend
verify-backend:
	ecspresso verify --config=backend/config.yml

.PHONY: verify-batch
verify-batch:
	ecspresso verify --config=batch/config.yml

.PHONY: deploy-backend
deploy-backend:
	ecspresso deploy --config=backend/config.yml

.PHONY: deploy-batch
deploy-batch:
	ecspresso register --config=batch/config.yml

.PHONY: show-backend
show-backend:
	ecspresso status --config=backend/config.yml

.PHONY: diff-all
diff-all: diff-backend diff-batch

.PHONY: diff-backend
diff-backend:
	ecspresso diff --config=backend/config.yml
.PHONY: diff-batch
diff-batch:
	ecspresso diff --config=batch/config.yml
