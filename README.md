# SprintMaster
SprintMaster is a simple script that gives you information about your sprints. I wrote it to make writing sprint review emails easier.

## Getting Started
To use SprintMaster, you'll need an instance of JIRA running on Atlassian Cloud. You'll only really get value out of this if you're using JIRA Agile's sprint feature.

### Steps
1. Clone this repository
2. Edit `config/configuration.rb.example`, add your own values, and remove the `.example` file extension
3. Run `bin/sprint_master`

## Running
To run Sprintmaster, run `bin/sprint_master`. By default, it will run for the first currently active sprint that it finds (you can run it for a specific sprint by using the `-s` parameter, described below).

### Output
SprintMaster will output the plaintext information to whatever is specified in `OUTPUT_FILES[:email]` in your `configuration.rb` file, and a CSV of the sprint issues to whatever is specified in `OUTPUT_FILES[:csv]`. To aid in debugging, it also prints out the plaintext information generated when you run the script.

### Options
Parameter | Description
------------ | -------------
`-s/--sprint <sprint id>` | Run for a specific sprint

## Contributing
Feel free to open issues or pull requests for any errors you run into or features you think should exist.

## License
Distributed under [The MIT License](https://github.com/andycrum/sprint-master/blob/master/LICENSE.md)