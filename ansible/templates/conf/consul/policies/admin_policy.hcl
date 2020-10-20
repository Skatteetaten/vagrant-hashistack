# WRITE access to the k/v store
key_prefix "" {
  policy = "write"
}

# WRITE
# 1. Service-level registration
# 2. Catalog API
# 3. Service discovery with the Health API
# 4. Intentions
service_prefix "" {
  policy = "write"
  intentions = "write"
}

# WRITE any access acl
acl = "write"

# READ access to cluster-wide Consul operator information.
operator = "read"
