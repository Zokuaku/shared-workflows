variables {
  name = "world"
}

run "greeting_is_built_from_the_name" {
  command = plan

  assert {
    condition     = output.greeting == "hello, world"
    error_message = "The greeting was not built from var.name."
  }
}

run "an_invalid_name_is_refused" {
  command = plan

  variables {
    name = "Not Valid"
  }

  expect_failures = [var.name]
}
