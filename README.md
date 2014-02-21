# Ninety-Nine Cats

This is a practice Rails app for [App Academy](http://appacademy.io).

It features cat adding and editing, as well
as an eclectic feature of requesting to rent cats,
all with a little Bootstrap 3 sprinkled on top for flavor.

**Other Features**:

- Hand-rolled authentication via user and session models.
    + Uses BCrypt for password hashing.
    + Stores authentication token in cookie.
    + See:
        * `app/models/user.rb`
        * `app/models/session.rb`
        * `app/controllers/sessions_controller.rb`
        * `app/controllers/concerns/authentication.rb`
- User authorization checks:
    + You can only edit your own cat and only you can approve requests for your cat.
    + Enforced via controller `before_action` methods
    + See:
        * `app/controllers/cats_controller.rb`
        * `app/controllers/cat_rental_requests_controller.rb`
        * `app/controllers/concerns/authorization.rb`
