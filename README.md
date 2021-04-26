# ProctorMe
_A cheap knockoff of ProctorU_

ProctorMe is a REST API that provides the ability to CRUD Colleges, Exams, and Users.

### Requirements
> A client can send the above request and expect the following behavior
>* A successful (200 OK) response if:
>    * the request data is valid and sanitized
>    * a college exists in the database (college_id)
>    * an exam exists and belongs to the college (exam_id)
>    * a user is successfully found or created, and assigned to the exam
>    * the start_time of the request falls within an Exam's time window
>
>* A bad request (400) response with appropriate error message if:
>    * the request data is invalid or not clean
>    * a college with the given college_id is not found
>    * an exam with the given exam_id is not found or does not belong to the college
>    * a user fails to be found or created, or failed to get associated with the exam
>    * a requested start_time does not fall with in an exam's time window

## Setup
1. Use the ruby version specified in `.ruby-version`. If using rvm, this can be achived by running `rvm use` in your terminal.
1. Set up the app by running `bin/setup`
1. Seed the database with some test data by running `rake db:seed`

## Testing
To execute unit tests, run `rake test`

## Postman
Import [this postman collection](./proctorme.postman_collection.json) to get started making requests.