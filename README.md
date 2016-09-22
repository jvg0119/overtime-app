# Overtime App

## Key requirement: company need documentation that salaried employees did or did not get overtime each week

## Models
- [x] Post -> date:date rationale:text
- [x] User -> Devise
- [x] AminUser -> STI
- [x] Auditlog

## Features:
- [x] Approval Workflow
- [x] SMS Sending -> link to approval or overtime input
- [x] Administrate admin dashboard
- [x] Block non admin and guest users
- [x] emailsummary to managers fo approval
- [x] Administrate admin dashboard
- [x] Block non admin and guest users
- [x] Email summary to manager for approval
- [x] Needs to be documented if employee did not log overtime
- [x] Create audit log for each text message
- [x]  Need to update end_date when confirmed
- [] Need to update audit log status when an overtime is rejected
- [x] Home icon
- [] Update buttons on employee homepage so they show on mobile
- [] Update buttons to include time span (date range)
- [] Update button sort order on employee homepage
- [] Remove unecessary navbar buttons for managers (entries & Req OT)
- [x] Admin dashboard bug; employee path missing (fixed already)
- [] Implement Honeybadger for error reporting
- [] Implement relic for keeping the site alive

## UI:
- [x] Bootstrap -> formatting
- [x] Icons from Front Awesome - skipped
- [x] Update the styles for forms

## Refactor TODOS:
- [x] Add full_name method for users
- [x] Refactor user association integration test in  post_spec
- [x] Refactor post/_form for admin user with status
