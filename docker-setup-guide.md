# Database Docker Setup Guide

## Quick Start

### Using Docker Compose (Recommended)

1. **Start the MySQL database:**
   ```bash
   docker-compose up -d
   ```

2. **Verify the container is running:**
   ```bash
   docker-compose ps
   ```

3. **Check database initialization logs:**
   ```bash
   docker-compose logs mysql
   ```

4. **Stop the database:**
   ```bash
   docker-compose down
   ```

5. **Stop and remove volumes (clean reset):**
   ```bash
   docker-compose down -v
   ```

---

## Configuration Details

### Database Credentials
- **Root Password:** `root123`
- **Database Name:** `order_service_db`
- **Username:** `order_user`
- **Password:** `order_password123`
- **Port:** `3306` (mapped to host)

### Connection String for Spring Boot
Update your `application.properties` file:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/order_service_db
spring.datasource.username=order_user
spring.datasource.password=order_password123
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
```

---

## Manual Docker Commands (Alternative)

If you prefer to use Docker directly instead of docker-compose:

### Build the image:
```bash
docker build -f Dockerfile.db -t order-service-db:latest .
```

### Run the container:
```bash
docker run -d \
  --name order-service-db \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=order_service_db \
  -e MYSQL_USER=order_user \
  -e MYSQL_PASSWORD=order_password123 \
  -v mysql_data:/var/lib/mysql \
  order-service-db:latest
```

### Connect to the database:
```bash
docker exec -it order-service-db mysql -u order_user -p order_service_db
```

---

## Useful Docker Commands

### View container logs:
```bash
docker-compose logs -f mysql
```

### Access MySQL CLI:
```bash
docker-compose exec mysql mysql -u order_user -p order_service_db
```

### List all containers:
```bash
docker ps -a
```

### Remove the container and volume:
```bash
docker-compose down -v
```

---

## Troubleshooting

### Port 3306 already in use:
Change the exposed port in `docker-compose.yml`:
```yaml
ports:
  - "3307:3306"  # Use 3307 on host, update connection string accordingly
```

### Container won't start:
```bash
docker-compose logs mysql
```

### Reset database (start fresh):
```bash
docker-compose down -v
docker-compose up -d
```

### Verify schema initialization:
```bash
docker-compose exec mysql mysql -u root -p root123 -e "SHOW TABLES IN order_service_db;"
```

---

## Development Workflow

1. **Start database for development:**
   ```bash
   docker-compose up -d
   ```

2. **Run Spring Boot application:**
   ```bash
   mvn spring-boot:run
   ```

3. **When done, stop the database:**
   ```bash
   docker-compose down
   ```

---

## Production Considerations

For production deployments:
- Change default passwords in `docker-compose.yml`
- Use environment variables for sensitive credentials
- Add backup volume configurations
- Consider using managed database services (AWS RDS, Azure Database, etc.)
- Enable authentication and SSL/TLS
- Implement proper networking and security groups
