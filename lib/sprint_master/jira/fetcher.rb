require 'httparty'
require 'json'
require 'pp'
require './config/configuration'
require_relative 'issue'

module SprintMaster
  module JIRA
    # This class fetches information from the JIRA Agile API
    class Fetcher
      # Returns the completed issues in the current active sprint
      def fetch_sprint_issues(sprint_id)
        sprint_id ||= active_sprint_id
        params = issue_parameters
        url = "/rest/agile/1.0/sprint/#{sprint_id}/issue"
        json_issues = call_endpoint(url, params: params)['issues']
        json_issues.map { |i| JIRA::Issue.new(i) }
      end

      private

      # Returns parameters that are used to filter issues
      def issue_parameters
        {
          query: {
            jql: Configuration::ISSUES[:completed_jql],
            fields: Configuration::ISSUES[:fields],
            maxResults: Configuration::ISSUES[:max_results]
          }
        }
      end

      # Calls a JIRA API endpoint
      def call_endpoint(endpoint, params: {})
        params[:basic_auth] = Configuration::AUTH
        response = HTTParty.get("#{Configuration::URL}#{endpoint}", params)
        if response.code != 200
          puts "Error: #{JSON.parse(response.body)['errorMessages'][0]}"
          abort
        end

        JSON.parse(response.body)
      end

      # Returns the id of the current active sprint
      def active_sprint_id
        url = "/rest/agile/1.0/board/#{Configuration::BOARD_ID}/sprint"
        response = call_endpoint(url, params: { query: { state: 'active' } })
        if response['values'].empty?
          raise StandardError, 'No active sprint found'
        end
        response['values'].first['id']
      end
    end
  end
end
