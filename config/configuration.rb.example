# frozen_string_literal: true
module SprintMaster
  # This class holds configuration options for the SprintMaster
  class Configuration
    # The URL of your team's JIRA instance (no trailing slash)
    URL = 'https://<your url>.atlassian.net'.freeze

    # The JIRA Agile board you want to use (when viewing the board
    # on your JIRA instance, look for the `rapidView` parameter)
    BOARD_ID = '<board id>'.freeze

    # A valid username/password for your JIRA instance
    AUTH = {
      username: '<your username>',
      password: '<your password>'
    }.freeze

    # Various config settings for the issues that we want to work with
    ISSUES = {
      # The JQL for stories that count as "completed"
      completed_jql: 'status = Done',

      # The field id for the "story points" field
      # See https://answers.atlassian.com/questions/30940607/story-points-using-jira-agile-rest-api
      story_points_field: '<story points field>',

      # The fields you want for the returned issues (comma-separated)
      fields: 'summary,description,<story points field>,issuetype,epic,project',

      # The maximum number of issues to retrieve at once
      max_results: 200
    }.freeze

    # The filepaths that the script writes to
    OUTPUT_FILES = {
      email: 'output/email.txt',
      csv: 'output/issues.csv'
    }.freeze
  end
end
