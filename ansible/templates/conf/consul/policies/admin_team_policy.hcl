# These control access to the key/value store.
# https://www.consul.io/docs/acl/acl-rules#rule-specification
key_prefix "" {
  policy = "read"
}
key_prefix "team/admin" {
  policy = "write"
}
# The acl resource controls access to ACL operations in the ACL API.
# https://www.consul.io/docs/acl/acl-rules#acl-resource-rules
acl = "write"

# This controls access to cluster-wide Consul operator information.
# https://www.consul.io/docs/acl/acl-rules#operator-rules
operator = "read"
