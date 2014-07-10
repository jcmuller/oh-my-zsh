# (c) 2014 opyright Juan C. Muller
#
# This code is released under the MIT public license
#
# This is accurate as of tddium 1.18.5
#
# Commands:
#    account                             # View account information
#    account:add [ROLE] [EMAIL]          # Authorize and invite a user to use your organization
#    account:remove [EMAIL]              # Remove a user from an organization
#    activate                            # Activate an account (deprecated)
#    config                              # Display config variables. The scope argument can be either 'suite', 'o...
#    config:add                          # Set KEY=VALUE at SCOPE. The scope argument can be either 'suite', 'org...
#    config:remove                       # Remove config variable NAME from SCOPE.
#    describe                            # Describe the state of a session, if it is provided; otherwise, the lat...
#    find_failing files+ failing_file    # Find out which file causes pollution / makes the failing file fail
#    github:migrate_hooks                # Authorize and switch the repo to use the tddium webhook with the prope...
#    help                                # Describe available commands or one specific command
#    heroku                              # Connect Heroku account with Tddium (deprecated)
#    keys                                # List SSH keys authorized for Tddium
#    keys:add                            # Authorize an existing keypair for Tddium
#    keys:gen                            # Generate and authorize a keypair for Tddium
#    keys:remove                         # Remove a key that was authorized for Tddium
#    login                               # Log in using your email address or token from dashboard
#    logout                              # Log out of tddium
#    password                            # Change password
#    rerun SESSION                       # Rerun failing tests from a session
#    run                                 # Run the test suite, or tests that match PATTERN
#    status                              # Display information about this suite, and any open dev sessions
#    stop                                # Stop session by id
#    suite                               # Register the current repo/branch, view/edit CI repos & deploy keys
#    version                             # Print the tddium gem version
#    web                                 # Open build report in web browser
#
# Options
#    [--host=HOST]                  # Tddium app server hostname
#                                   # Default: api.tddium.com
#    [--port=N]                     # Tddium app server port
#    [--proto=PROTO]                # API Protocol
#                                   # Default: https
#    [--insecure], [--no-insecure]  # Don't verify Tddium app SSL server certificate

_tddium_command_list() {
  local -a list
  list=( \
    --host= \
    --port= \
    --proto= \
    --insecure \
    --no-secure \
    account \
    activate \
    config \
    describe \
    find_failing \
    github \
    help \
    heroku \
    keys \
    login \
    logout \
    password \
    rerun \
    run \
    status \
    stop \
    suite \
    version \
    web \
  )
  echo $list
}

_tddium() {
  compadd $(_tddium_command_list)
}

compdef _tddium tddium
