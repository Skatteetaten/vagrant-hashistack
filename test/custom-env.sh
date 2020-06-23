# Example of environmental variables to override default startup.yml

######### Build #########

# environment ["dev", "test"]
# "test" will trigger run tests
export VAR_ENVIRONMENT=test

######### Consul #########

## consul ACL default_policy ["allow", "deny"]
## https://www.consul.io/docs/acl/acl-system#configuring-acls
export VAR_CONSUL_ACL="deny"
