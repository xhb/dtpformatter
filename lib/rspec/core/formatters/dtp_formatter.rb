require 'time'

class RSpec::Core::Formatters::Dtpformatter < RSpec::Core::Formatters::BaseFormatter

  def report(key, value)
    if output == STDOUT
      output << "usercase: #{key}......time: #{value}\n"
    else
      output << "usercase: #{key}......time: #{value}\n"
      
      dtp_path = ENV["DTPDIR"].split(";")[0]

      report_exe = "#{dtp_path}\\bin\\report.exe"

      flag = FileTest::exist?(report_exe)
      if flag == true
        system("#{report_exe} --perf --table db_case_run --key \"#{key}\" --value \'#{value}\';")
      else
        output << "can't find report.exe to record performence result\n" 
      end
    end
  end

  def start example_count
    @start = Time.now
    super
  end

  def dump_summary duration, example_count, failure_count, pending_count
    super
    output << "------Summary------"
    output << "Tests: #{example_count}...Failures: #{failure_count}...Total_time:#{'%.6f' % duration}...Timestamp: #{@start.iso8601}\n"
    output << "------Details-------"
    examples.each do |example|
      output << "------------------"
      send :"dump_summary_example_#{example.execution_result[:status]}", example
    end
  end

  def dump_summary_example_passed example
    report(example.full_description, '%.6f' % example.execution_result[:run_time])
  end

  def dump_summary_example_pending example
    report(example.full_description, "0")
  end

  def dump_summary_example_failed example
    exception = example.execution_result[:exception]
    backtrace = format_backtrace exception.backtrace, example
    report(example.full_description, "-1")
    output << "exception:\n\t#{exception.message}\nbacktrace:\n\t#{backtrace.join("\n")}\n\n"
  end

  def example_classname example
    example.file_path.sub(%r{\.[^/]*\Z}, "").gsub("/", ".").gsub(%r{\A\.+|\.+\Z}, "")
  end
end
