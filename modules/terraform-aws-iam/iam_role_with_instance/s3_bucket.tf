resource "aws_s3_bucket" "iam_demo_bucket_name" {
  bucket = "vannaboth-demo-bucket-1234567890"

  tags = {
    Name        = "My bucket"
    Environment = "Demo"
  }
}

resource "aws_s3_bucket_ownership_controls" "iam_demo_bucket_ownership" {
  bucket = aws_s3_bucket.iam_demo_bucket_name.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "iam_demo_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.iam_demo_bucket_ownership]
  
  bucket = aws_s3_bucket.iam_demo_bucket_name.id
  acl    = "private"
}
