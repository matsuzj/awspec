module Awspec
  module Helper
    module Type
      TYPES = %w(
        base ec2 rds rds_db_parameter_group security_group
        vpc s3_bucket route53_hosted_zone autoscaling_group subnet
        route_table ebs elb lambda iam_user iam_group iam_role
        iam_policy elasticache elasticache_cache_parameter_group
        cloudwatch_alarm ses_identity network_acl directconnect_virtual_interface
        nat_gateway
      )

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          name = args.first
          eval "Awspec::Type::#{type.camelize}.new(name)"
        end
      end

      # deprecated resource type
      def auto_scaling_group(name)
        puts ''
        puts Color.on_red(Color.white('!!! `auto_scaling_group` type is deprecated. use `autoscaling_group` !!!'))
        Awspec::Type::AutoscalingGroup.new(name)
      end

      def s3(name)
        puts ''
        puts Color.on_red(Color.white('!!! `s3` type is deprecated. use `s3_bucket` !!!'))
        Awspec::Type::S3Bucket.new(name)
      end
    end
  end
end
