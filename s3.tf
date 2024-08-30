# AWS S3 Private
resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucket-infra1-private-v2"


  tags = {
    Name = "MyBucket"
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}


# S3 Bucket Policy
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:*"  # Or more restrictive actions as needed
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
        Principal = {
          AWS = "arn:aws:iam::381491955630:role/PublicEC2Role"
        }
      }
    ]
  })
}
