dataSource {
    pooled = true
    //driverClassName = "com.mysql.jdbc.Driver"
    driverClassName = "org.postgresql.Driver"
    username = "root"
    password = "password"
    loggingSql = false
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            //url = "jdbc:mysql://localhost/volunteers"
            url = "jdbc:postgresql://localhost:5433/volunteers"
        }
    }
    test {
        dataSource {
            dbCreate = "create"
            //url = "jdbc:mysql://localhost/volunteerstest"
            url = "jdbc:postgresql://localhost:5433/volunteerstest"
            driverClassName = "org.postgresql.Driver"
            //driverClassName = "com.mysql.jdbc.Driver"
            username = "root"
            password = "password"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql:volunteers"
            url = "jdbc:postgresql://localhost:5433/volunteers"
        }
    }
}