# README

This is test API according to challenge below.

" You are responsible for implementing a new API. The customer requires an app that
handles learning paths, courses, course authors and talents. The API includes CRUD
operations for all these items. The development team already established which
language/platform is going to be used, the app should use Ruby on Rails 6.0 on the
backend and access a Postgres database. Since it is a prototype, no frontend is
required."

Requirements:
1. No authentication methods for this prototype
2. A talent can be assigned to 0 to n courses
3. A talent can be assigned to 0 to n learning paths
4. An author can have 0 to n courses
5. A talent in one course can be the author of another course
6. When deleting an author, the course has to be transferred to another author
7. A learning path can have 1 to n courses, which are ordered in sequence
8. A course can have 0 to n talents and must have 1 author
9. When a talent completes a course in a learning path, they get assigned the
next course in the learning path

Definition of done for this challenge:
- Client can CRUD the data on the API
- Client can mark a course completed for a talent
- No errors
- Rspec for testing
- Documentation where applicable

# INSTALLATION

-
-
-
-
-

# API ENDPOINTS

- Author's endpoints
    * GET /api/v1/authors.json # JSON response with all authors of courses
    * GET /api/v1/authors/:id.json # JSON response with author of courses by id
    * POST /api/v1/authors.json # To create a new author. Data scheme in params:
    {
        "author": {
            "name": "Author New"
        }
    }
    * POST /api/v1/authors/:id.json # To update an author by id. Data scheme in params:
    {
        "author": {
            "name": "Author New"
        }
    }
    * DELETE /api/v1/authors/:id.json # To destroy an author by id. You must send in params data with ID of another author for courses of  author that will be destroyed. Data scheme in params:
    {
        "new_author_id": "ID OF NEW AUTHOR"
    }

# TEST

RSpec CRUD tests are implemented and successfully passed. Run in project folder to check:
- rspec spec/requests/api/v1/authors_controller_spec.rb
- rspec spec/requests/api/v1/courses_controller_spec.rb
- rspec spec/requests/api/v1/learning_paths_controller_spec.rb
- rspec spec/requests/api/v1/study_lps_controller_spec.rb
- rspec spec/requests/api/v1/study_units_controller_spec.rb
- rspec spec/requests/api/v1/talents_controller_spec.rb







------------------------------------------
Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* Services (job queues, cache servers, search engines, etc.)

