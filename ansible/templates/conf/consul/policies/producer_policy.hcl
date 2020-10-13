# DENY access to the k/v store
key_prefix "" {
  policy = "deny"
}

# WRITE access to prefix team/
key_prefix "team/" {
  policy = "write"
}

# WRITE
# 1. Service-level registration
# 2. Catalog API
# 3. Service discovery with the Health API
# 4. Intentions
service_prefix "" {
  policy = "write"
}

# DENY any access acl
acl = "deny"

# READ access to cluster-wide Consul operator information.
operator = "read"
