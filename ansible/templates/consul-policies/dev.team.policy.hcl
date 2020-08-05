# These control access to the key/value store.
key_prefix "" {
  policy = "read"
}
key_prefix "team/dev" {
  policy = "write"
}
key_prefix "team/admin/" {
  policy = "deny"
}
# Or for exact key matches
key "foo/bar/secret" {
  policy = "deny"
}
operator = "read"
