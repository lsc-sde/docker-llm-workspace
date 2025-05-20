# PostgreSQL Startup
echo "Starting PostgreSQL..."
service postgresql start

# Create DB user and database if not already existing
su - postgres -c "psql -tc \"SELECT 1 FROM pg_roles WHERE rolname = 'jovyan'\" | grep -q 1 || psql -c \"CREATE USER jovyan WITH PASSWORD 'password';\""
su - postgres -c "psql -lqt | cut -d \| -f 1 | grep -qw jovyan || createdb jovyan -O jovyan"