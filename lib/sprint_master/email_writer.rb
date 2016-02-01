require 'liquid'

module SprintMaster
  # Writes an email
  class EmailWriter
    def initialize
      @email_template = email_template
    end

    # Renders the email template with the given data
    def write(email_data)
      email_text = @email_template.render(email_data)
      save_email(email_text)
      email_text
    end

    private

    # Returns the email template (a string)
    def email_template
      template = File.read('./lib/sprint_master/email_template.liquid')
      Liquid::Template.parse(template)
    end

    # Saves the email text to a file
    def save_email(email_text)
      File.write(Configuration::OUTPUT_FILES[:email], email_text)
    end
  end
end
