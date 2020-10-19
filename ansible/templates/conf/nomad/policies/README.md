# Nomad policies (additional)
The following three custom policies are provided as an example:
- `admin`
- `consumer`
- `producer`

Notes:
- Policies have different access level to `nomad` API
- If `nomad_acl=enable`, there are also `consumer/producer` roles in vault which are mapped to these consul policies
- Token examples (for roles) are stored in vault K/V at path `secret/nomad-token-example`
- User can generate new token from concrete role, example `vault read nomad/creds/producer-role` (cli command require vault token - VAULT_TOKEN)
