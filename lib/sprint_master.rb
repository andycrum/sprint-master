require './lib/sprint_master/csv_writer'
require './lib/sprint_master/email_writer'
require './lib/sprint_master/jira/fetcher'

# The SprintMaster masters sprints
module SprintMaster
  class << self
    def run(options)
      # Get issues for the sprint
      fetcher = SprintMaster::JIRA::Fetcher.new
      issues = fetcher.fetch_sprint_issues(options[:sprint_id])

      # Write issues to CSV
      SprintMaster::CSVWriter.new.write(issues)

      # Write issues to email template
      issue_groups = generate_issue_groups(issues)
      puts SprintMaster::EmailWriter.new.write('issue_groups' => issue_groups)

      echo_success_message
    end

    private

    # Generates groups of issues
    def generate_issue_groups(issues)
      issue_groups = { 'Bug Fixes' => [] }
      issues.each do |i|
        group_title = i.determine_issue_group

        issue_groups[group_title] = [] if issue_groups[group_title].nil?
        issue_groups[group_title] << i
      end
      issue_groups
    end

    # Writes a success message
    def echo_success_message
      puts "-----------------------\n"
      puts "Saved CSV output in #{Configuration::OUTPUT_FILES[:csv]}\n"
      puts "Saved plaintext output in #{Configuration::OUTPUT_FILES[:email]}\n"
      puts "-----------------------\n"
    end
  end
end
