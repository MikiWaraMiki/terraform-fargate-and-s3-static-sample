ENV=staging

.PHONY: set-required-tfstate-outputs
set-required-tfstate-outputs:
	subnet_ids=$(tfstate-lookup -s="s3://${TERRAFORM_STATE_BUCKET_NAME}/some-service-a/backend/data.terraform_remote_state.network.outputs.ecs_web_subnet_ids")
	export SUBNET_IDS=$(subnet_ids)
	security_group_id=$(tfstate-lookup -s="s3://$TERRAFORM_STATE_BUCKET_NAME/some-service-a/backend" data.terraform_remote_state.security_group.outputs.ecs_batch_security_group_id)
	export SECURITY_GROUP_ID=$(security_group_id)

.PHONY: diff
diff:
	ecshedule diff -conf ./$(ENV)-events-rules.yaml -all

.PHONY: apply
apply:
	ecshedule apply -conf ./$(ENV)-events-rules.yaml -all
