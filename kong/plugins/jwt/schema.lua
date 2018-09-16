return {
  name = "jwt",
  fields = {
    config = {
      type = "record",
      nullable = false,
      fields = {
        { uri_param_names = {
            type = "set",
            elements = { type = "string" },
            default = { "jwt" },
        }, },
        { cookie_names = {
            type = "set",
            elements = { type = "string" },
            default = {}
        }, },
        { key_claim_name = { type = "string", default = "iss" }, },
        { secret_is_base64 = { type = "boolean", default = false }, },
        { claims_to_verify = {
            type = "set",
            elements = {
              type = "string",
              one_of = { "exp", "nbf" }
        }, }, },
        { anonymous = { type = "string", uuid = true }, },
        { run_on_preflight = { type = "boolean", default = true }, },
        { maximum_expiration = {
          type = "number",
          default = 0,
          between = { 0, math.huge },
        }, },
      },
    },
  },
  entity_checks = {
    { conditional = {
        if_field = "config.maximum_expiration",
        if_match = { gt = 0 },
        then_field = "config.claims_to_verify",
        then_match = { contains = "exp" },
    }, },
  },
}
