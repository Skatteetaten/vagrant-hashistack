# These control access to the key/value store.
key_prefix "" {
  policy = "read"
}
key_prefix "foo/" {
  policy = "write"
}
key_prefix "foo/private/" {
  policy = "deny"
}
# Or for exact key matches
key "foo/bar/secret" {
  policy = "deny"
}

# This controls access to cluster-wide Consul operator information.
operator = "read"
