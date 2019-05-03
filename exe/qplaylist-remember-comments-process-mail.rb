require_relative '../etc/methods'

module ::M1
  module M2
    extend Methods

# Don't greet.

# TODO: Consider doing 'bundle install'.

# Navigate to run Windows batch file:
    ::Dir.chdir directory_etc

# Windows Command Line Interpreter:
    com_spec = ::File.realpath ENV['ComSpec']

# Command Line Interpreter options:
#   /D     - Disable execution of AutoRun commands
#   /E:off - Disable command extensions
#   /Q     - Turns echo off
#   /C     - Carries out the command specified by string and then terminates (must be last)
    options = %w[/D /E:off /Q /C]

    filename_mail = 'mail.bat'

# Run Windows batch file:
    command_run [com_spec] + options + [filename_mail]
  end
end
