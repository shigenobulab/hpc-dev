# EC2

## Spot instance

### Tips: get spot placement score

(example)

```
aws ec2 get-spot-placement-scores  --region ap-northeast-1 \
  --region-names ap-northeast-1 us-east-1 \
  --single-availability-zone  \
  --no-cli-pager \
  --target-capacity 1 \
  --instance-types m6id.32xlarge^C
```

References

* https://awscli.amazonaws.com/v2/documentation/api/2.4.18/reference/ec2/get-spot-placement-scores.html -- CLI command reference
* https://aws.amazon.com/blogs/compute/identifying-optimal-locations-for-flexible-workloads-with-spot-placement-score/ -- AWS official blog
