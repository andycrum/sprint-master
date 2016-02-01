module SprintMaster
  module JIRA
    # This class represents a single JIRA issue
    class Issue < Liquid::Drop
      attr_reader :key
      attr_reader :summary
      attr_reader :description
      attr_reader :issue_type
      attr_reader :story_points
      attr_reader :epic_name
      attr_reader :project_key

      def initialize(issue_info)
        @key = issue_info['key']
        fields = issue_info['fields']
        populate_properties_from_fields(fields)
      end

      # Determines whether the issue is a bug
      def bug?
        @issue_type.casecmp('bug') == 0
      end

      # Determines whether the issue should be flagged as "important"
      def important?
        !@story_points.nil? && @story_points > 2
      end

      # Determines the issue group that this issue should go into
      # Groups issues by bugfix, epic name, or misc features/improvements
      def determine_issue_group
        # If it's a bug, it should go in the "Bug Fixes" section regardless
        group_title = bug? ? 'Bug Fixes' : @epic_name

        # If it has no epic and isn't a bug, it should go into a generic group
        group_title = 'Misc. Features/Improvements' if group_title == ''
        group_title
      end

      private

      # Sets the properties from a fields array
      def populate_properties_from_fields(fields)
        @summary = fields['summary']
        @description = fields['description']
        @issue_type = fields['issuetype']['name']
        @story_points = fields[Configuration::ISSUES[:story_points_field]]
        @epic_name = fields['epic'] ? fields['epic']['name'] : ''
        @project_key = fields['project']['key']
      end
    end
  end
end
