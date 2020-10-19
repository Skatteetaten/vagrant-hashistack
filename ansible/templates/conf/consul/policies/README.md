# Consul policies (additional)
Three custom policies - `admin/consumer/producer`, are provided as an example.

Notes:
- Policies have different access level to `consul` API
- If `consul_acl=enable`, there are also `admin/consumer/producer` roles in vault which are mapped to these consul policies
- Token examples (for roles) are stored in vault K/V at path `secret/consul-token-example`
- User can generate new token from concrete role, example `vault read consul/creds/producer-role` (cli command require vault token - VAULT_TOKEN)
