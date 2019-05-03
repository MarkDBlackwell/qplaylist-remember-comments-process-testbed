require 'English'

module ::M1
  module M2
    module Methods

        extend self

        def child_status
          $CHILD_STATUS
        end

        def child_status_integer
print "In moduleMethod's child_status_integer\n"
          child_status.exitstatus if child_status
        end

        def command_ran_best
print "In moduleMethod's command_ran_best\n"
#print 'child_status_integer='; pp child_status_integer
          exit_status_okay == child_status_integer
        end

        def command_run(array, is_tentative=false)
          ::Kernel.system(*array)
          message = "#{array} exit status was #{child_status}"
          unless command_ran_well_enough is_tentative
            print "#{message}\n\n"
            trace_write = true
            log_write message, trace_write
          end
          nil
        end

        def directory_etc
          ::File.join project_root, 'etc'
        end

        def directory_volatiles
          ::File.join appdata_subdirectory_own, 'var'
        end

        def project_root
          @project_root_value ||= ::File.realpath '..', dirname_script_this
        end

        private

        def appdata_subdirectory_own
          directory_appdata = ::File.realpath ::ENV['APPDATA']
          ::File.join directory_appdata, '.qplaylist-remember-comments-process'
        end

        def command_ran_well_enough(is_tentative)
          no_emails_sent    = is_tentative && exit_status_no_emails_sent    == child_status_integer
          no_period_matches = is_tentative && exit_status_no_period_matches == child_status_integer
          command_ran_best || no_emails_sent || no_period_matches
        end

        def dirname_script_this
          ::Kernel.__dir__
        end

        def exit_status_okay
          0
        end

        def filename_log
          ::File.join directory_volatiles, 'log.txt'
        end

        def log_write(s, trace_write=false)
          entries_omit_count = 3
          time = log_write_time
          message = "#{time} #{s}\n"
          ::File.open filename_log, 'a' do |f|
            f.print message
            if trace_write
              execution_stack = ::Kernel.caller entries_omit_count
              execution_stack.each{|e| f.print "#{time} #{e}\n"}
            end
          end
          nil
        end

        def log_write_time
## '^a' means upper-case weekday name:
          format = '%Y-%m-%d %^a %H:%M:%S'
          ::Time.now.strftime format
        end
    end
  end
end
