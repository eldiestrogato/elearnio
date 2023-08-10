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
    * POST /api/v1/authors.json # To create new author. Data scheme example of params:
    ```
    {
        "author": {
            "name": "AUTHOR's NAME"
        }
    }
    ```
    * PATCH /api/v1/authors/:id.json # To update author by id. Data scheme example of params:
    ```
    {
        "author": {
            "name": "ANOTHER AUTHOR's NAME"
        }
    }
    ```
    * DELETE /api/v1/authors/:id.json # To destroy author by id. You must send in params data with ID of another author for courses of  author that will be destroyed. Data scheme example of params:
    ```
    {
        "new_author_id": "ID OF NEW AUTHOR"
    }
    ```

- Course's endpoints
    * GET /api/v1/courses.json # JSON response with all courses
    * GET /api/v1/courses/:id.json # JSON response with course by id
    * POST /api/v1/courses.json # To create new course. Send in params title,body,ID of it author, IDs of associated Learning Paths is optional. Data scheme example of params:
    ```
      {
          "course": {
              "title": "Course 1",
              "body": "Course number 1 interesting", 
              "author_id": 1, 
              "learning_path_ids":[]
          }
      }
    ```
    * PATCH /api/v1/courses/:id.json # To update course by id. Data scheme example of params:
    ```
      {
          "course": {
              "title": "Course 1",
              "body": "Course number 1 interesting", 
              "author_id": 1, 
              "learning_path_ids":[]
          }
      }
    ```
    * DELETE /api/v1/courses/:id.json # To destroy course by id.

- Learning Path's endpoints
    * GET /api/v1/learning_paths.json # JSON response with all learning paths
    * GET /api/v1/learning_paths/:id.json # JSON response with learning path by id
    * POST /api/v1/learning_paths.json # To create new learning path. Send in params ID of at least 1 course of this Learning Path and it order number. Data scheme example of params:
    ```
      {
          "learning_path": {
              "title": "Learning Path of Math",
              "lp_courses_attributes": [
                  {
                      "course_id": 1,
                      "course_number": 1
                  },
                  {
                      "course_id": 2,
                      "course_number": 2
                  },
                  {
                      "course_id": 3,
                      "course_number": 3
                  },
                  {
                      "course_id": 4,
                      "course_number": 4
                  }
              ]
          }
      }
    ```
    * PATCH /api/v1/learning_paths/:id.json # To update learning path by id. Data scheme example of params:
    ```
      {
          "learning_path": {
              "title": "Learning Path of English",
              "lp_courses_attributes": [
                  {
                      "course_id": 8,
                      "course_number": 1
                  },
                  {
                      "course_id": 10,
                      "course_number": 2
                  },
                  {
                      "course_id": 12,
                      "course_number": 4
                  },
                  {
                      "course_id": 15,
                      "course_number": 3
                  }
              ]
          }
      }
    ```
    * DELETE /api/v1/learning_paths/:id.json # To destroy learning path by id
 
- Talent's endpoints
    * GET /api/v1/talents.json # JSON response with all talents
    * GET /api/v1/talents/:id.json # JSON response with talent by id
    * POST /api/v1/talents.json # To create a new talent. Send in params name and option if it is an author (It will create record with author in Author table). Data scheme example of params:
    ```
      {
          "talent": {
              "name": "Talent One",
              "is_author": "false"
          }
      }
    ```
    * PATCH /api/v1/talents/:id.json # To update talent by id. Data scheme example of params:
    ```
     {
          "talent": {
              "name": "Talent One",
              "is_author": "false"
          }
      }
    ```
    * DELETE /api/v1/talents/:id.json # To destroy talent by id

- study_lp's endpoints (Learning paths that 've been given to talent)
    * GET /api/v1/study_lps.json # JSON response with all study learning paths
    * GET /api/v1/talents/:id/study_lps/:id.json # JSON response with study learning path of talent by id and talent id
    * POST /api/v1/talents/:id/study_lp.json # To create a new study learning path. Send in params talent id and learning path id. Data scheme example of params:
    ```
      {
          "study_lp": {
              "talent_id": 1,
              "learning_path_id": 23
          }
      }
    ```
    > After creation Talent will get its first course from learning path
    * PATCH /api/v1/talents/:id/study_lps/:id.json # To update study learning path by id and talent id. Data scheme example of params:
    ```
      {
          "study_lp": {
              "talent_id": 1,
              "learning_path_id": 50
          }
      }
    ```
    * DELETE /api/v1/talents/:id/study_lps/:id.json # To destroy study learning path by id and talent id

- study_unit's endpoints (Courses of those learning paths that 've been given to talent)
    * GET /api/v1/study_units.json # JSON response with all study units
    * GET /api/v1/talents/:id/study_units/:id.json # JSON response with study unit of talent by id and talent id
    * POST /api/v1/talents/:id/study_units.json # To create a new study unit. Send in params course id and as option is it completed or not. Data scheme example of params:
    ```
      {
          "study_unit": {
              "course_id": 1,
              "is_course_completed": "false"
          }
      }
    ```
    > Course for one Talent must be unique
    * PATCH /api/v1/talents/:id/study_units/:id.json # To update study unit by id. Data scheme example of params:
    ```
      {
          "study_unit": {
              "course_id": 1,
              "is_course_completed": "true"
          }
      }
    ```
   > If send in params  "is_course_completed": "true" Talent will get next course from its learning path according to order (but only if other is completed!) until courses exists
    * DELETE /api/v1/talents/:id/study_units/:id.json # To destroy study unit by id and talent id

# TEST

RSpec only CRUD tests of controllers are implemented and successfully passed. Run in project folder to check:
- rspec spec/requests/api/v1/authors_controller_spec.rb
- rspec spec/requests/api/v1/courses_controller_spec.rb
- rspec spec/requests/api/v1/learning_paths_controller_spec.rb
- rspec spec/requests/api/v1/study_lps_controller_spec.rb
- rspec spec/requests/api/v1/study_units_controller_spec.rb
- rspec spec/requests/api/v1/talents_controller_spec.rb
