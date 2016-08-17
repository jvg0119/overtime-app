# Overtime App

## Key requirement: company need documentation that salaried employees did or did not get overtime each week

## Models
- x Post -> date:date rationale:text
- x User -> Devise
- x AminUser -> STI

## Features:
- Approval Workflow
- SMS Sending -> link to approval or overtime input
- Administrate admin dashboard
- Block non admin and guest users
- Email summary to manager for approval
- Needs to be documented if employee did not log overtime

## UI:
- x Bootstrap -> formatting
- Icons from Front Awesome
- x Update the styles for forms

## Refactor TODOS:
- x Add full_name method for users
- Refactor user association integration test in  post_spec
