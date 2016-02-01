module SprintMaster
  # Writes issues to a CSV
  class CSVWriter
    # Saves the CSV data to a file
    def write(issues)
      CSV.open(Configuration::OUTPUT_FILES[:csv], 'wb') do |csv|
        csv << csv_header
        issues.each do |issue|
          csv << csv_row(issue)
        end
      end
    end

    private

    # Returns the header for the CSV file
    def csv_header
      [
        'project key',
        'key',
        'summary',
        'description',
        'issue type',
        'epic name'
      ]
    end

    # Returns the CSV row for an issue in the CSV file
    def csv_row(issue)
      [
        issue[:project_key],
        issue[:key],
        issue[:summary],
        issue[:description],
        issue[:issue_type],
        issue[:epic_name]
      ]
    end
  end
end
