# ------------------------------------------
# ECR 
# -----------------------------------------
resource "aws_ecr_repository" "main" {
  name                 = "${var.project_name}-${var.env}-${var.repository_type}-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = true  # これがないと削除されない
  tags = merge(
    {
      Name = "${var.project_name}-${var.env}-${var.repository_type}-repo"
    },
    var.tags
  )
}