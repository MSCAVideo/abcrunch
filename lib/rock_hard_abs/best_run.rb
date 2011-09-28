module RockHardAbs
  class BestRun
    def self.of_avg_response_time(num_runs, ab_options)
      RockHardAbs::Logger.log :task, "Best of #{num_runs} runs at concurrency: #{ab_options[:concurrency]} and num_requests: #{ab_options[:num_requests]}"
      RockHardAbs::Logger.log :info, "for #{ab_options[:url]}"
      RockHardAbs::Logger.log :info, "Collecting average response times for each run:"

      min_response_time = 999999
      min_response_result = nil
      num_runs.times do
        abr = RockHardAbs::AbRunner.ab(ab_options)
        RockHardAbs::Logger.log :info, "#{abr.avg_response_time} ... ", {:inline => true}
        #STDOUT.flush
        if abr.avg_response_time < min_response_time
          min_response_time = abr.avg_response_time
          min_response_result = abr
        end
      end
      RockHardAbs::Logger.log :success, "Best response time was #{min_response_time}, with:"
      min_response_result.log
      min_response_result
    end
  end
end