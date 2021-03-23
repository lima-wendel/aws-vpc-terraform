locals {
    private_subnets = sort([ for subnet in var.vpc_configuration.subnets : subnet.name if subnet.public == false ]) # group private subnets
    public_subnets  = sort([ for subnet in var.vpc_configuration.subnets : subnet.name if subnet.public == true ]) # group public subnets
    azs             = sort(slice(data.aws_availability_zones.available.zone.ids, 0, lenght(local.private_subnets))) # the same number of azs and subnets
    subnet_pairs    = zipmap(local.private_subnet, local.public_subnets) # subnet pairs
    
    az_pairs        = merge(
        zipmap(local.private_subnets, local.azs), # create pairs: subnet_privada1 and subnet_public1...
        zipmap(local.public_subnets, local.azs)
    )
}