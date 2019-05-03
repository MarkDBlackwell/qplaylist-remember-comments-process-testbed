require_relative 'command_line_test_helper'
require_relative '../../etc/methods'

module ::M1
  module M2
    class MailTest < CommandLineTest

#     include ::M1::M2::TestHelperMethods::InstanceMethods

      def test_kernel_system
#pp [::M1::M2::Methods.instance_methods - ::Object.instance_methods].sort
pp [::M1::M2::Methods.methods - ::Object.methods].sort

#       ::M1::M2.stub :child_status_integer, child_status_integer do
#       ::M1::M2::Methods::ModuleMethods.stub :child_status_integer, child_status_integer do
        ::M1::M2::Methods.stub :child_status_integer, child_status_integer_stub do
          ::Kernel.                                              stub :system,               kernel_system_mock   do
            ::Kernel.load filename
          end
        end
#       end
        kernel_system_mock.verify
      end

      private

      def basename
        'qplaylist-remember-comments-process-mail'
      end

      def child_status_integer_stub
        @child_status_integer_stub_value ||= ::Kernel.lambda do
print "In Test child_status_integer_stub\n"
          0
        end
      end

      def directory_exe
# This code is temporarily here:
        fragment = ::File.join(*%w[ .. .. exe ])
        ::File.realpath fragment, ::Kernel.__dir__
      end

      def filename
        ::File.expand_path basename, directory_exe
      end

      def kernel_system_mock
        @kernel_system_mock_value ||= begin
          return_value = true
          parameter_first = 'C:/Windows/system32/cmd.exe'
          parameters_rest = %w[  /D  /E:off  /Q  /C  mail.bat  ]
          params = [parameter_first, *parameters_rest]
          ::Minitest::Mock.new.expect :call, return_value, params
        end
      end
    end
  end
end
