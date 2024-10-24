# Use uma imagem base que tenha Python
FROM python:3.12-slim

# Defina o diretório de trabalho
WORKDIR /app

# Copie o requirements.txt para o contêiner
COPY requirements.txt ./

# Instale as dependências do projeto
RUN pip install --no-cache-dir django pillow psycopg2-binary kombu asgiref sqlparse python-decouple -r requirements.txt

# Copie o restante do código do seu projeto
COPY . .

# Comando padrão
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
