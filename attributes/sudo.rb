# Allow passwordless sudo
sudoers_defaults = [
  'env_reset',
]

node.set["authorization"] = {
  "sudo" => {
    "include_sudoers_d" => true,
    "sudoers_defaults" => sudoers_defaults,
    "passwordless" => true,
  }
}
