## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.clc_ip_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/eip) | resource |
| [aws_eip.clc_ip_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/eip) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.natgateway_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.natgateway_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_route_table_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table) | resource |
| [aws_route_table.private_route_table_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private_association_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_association_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_association_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_association_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/subnet) | resource |
| [aws_subnet.private_subnet_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_a](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_c](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/subnet) | resource |
| [aws_vpc.vpc_clc](https://registry.terraform.io/providers/hashicorp/aws/5.45.0/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anywhere_range"></a> [anywhere\_range](#input\_anywhere\_range) | anywhere ips range | `string` | `"0.0.0.0/0"` | no |

## Outputs

No outputs.
