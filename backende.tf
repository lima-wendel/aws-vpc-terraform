terraform {
    backend "remote" {
        organization = "awstraining"

    workspaces {
        name = "awstraining01"
        }
    }
}