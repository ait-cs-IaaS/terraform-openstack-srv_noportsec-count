output "instances" {
    value = [ 
        for server in module.server:
        server
    ]
}