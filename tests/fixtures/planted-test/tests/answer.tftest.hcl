# PLANTED DEFECT: the module answers 41 and this test expects 42, so `terraform test` must fail.
run "the_answer_is_42" {
  command = plan

  assert {
    condition     = output.answer == 42
    error_message = "The answer is not 42."
  }
}
