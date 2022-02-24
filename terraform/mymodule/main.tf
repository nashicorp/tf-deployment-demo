resource "local_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/foo.file"
}

resource "local_file" "bar" {
  content  = "bar!"
  filename = "${path.module}/bar.file"
}

resource "local_file" "baz" {
  content  = "baz!"
  filename = "${path.module}/baz.file"
}

resource "local_file" "quux" {
  content  = "quux!"
  filename = "${path.module}/quux.file"
}

resource "local_file" "m" {
  content  = "m!"
  filename = "${path.module}/m.file"
}
