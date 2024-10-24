# Desafio 01: Criar uma Aplicação Django de Blog

Este projeto é uma aplicação Django que simula um pequeno blog. Siga os passos abaixo para configurar e executar o projeto.

## 1. Instalar o Django

Certifique-se de que você tem o Python e o Django instalados. Caso não tenha, você pode instalar o Django usando pip:

```bash
python3 -m venv env 
source env/bin/activate 
pip install django
```

Se você estiver em um sistema baseado em Debian (como Ubuntu), pode instalar o Django diretamente com:

```bash
sudo apt install python3-django
```

## 2. Criar um Novo Projeto Django

Crie um novo projeto Django chamado `meublog`:

```bash
django-admin startproject meublog
cd meublog
```

## 3. Criar o App `core`

Crie um novo app chamado `core`:

```bash
python manage.py startapp core
```

## 4. Definir os Models

Abra o arquivo `core/models.py` e adicione os seguintes modelos:

```python
from django.db import models

class Tag(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Post(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    tags = models.ManyToManyField(Tag)

    def __str__(self):
        return self.title
```

## 5. Registrar os Models no Admin

Abra o arquivo `core/admin.py` e adicione o seguinte código para registrar os modelos:

```python
from django.contrib import admin
from .models import Post, Tag

admin.site.register(Post)
admin.site.register(Tag)
```

## 6. Configurar o Projeto

Abra `meublog/settings.py` e adicione `core` à lista `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    # ... outras aplicações ...
    'core',
]
```

## 7. Criar as Migrações e Migrar

Execute os seguintes comandos para criar e aplicar as migrações:

```bash
python manage.py makemigrations
python manage.py migrate
```

## 8. Criar uma View e URL para a Página do Blog

Abra `core/views.py` e adicione a seguinte view para listar os posts e tags:

```python
from django.shortcuts import render
from .models import Post, Tag

def blog_list(request):
    posts = Post.objects.all()
    tags = Tag.objects.all()
    return render(request, 'core/blog_list.html', {'posts': posts, 'tags': tags})
```

Crie um arquivo `core/urls.py` e adicione o seguinte código para definir a URL do blog:

```python
from django.urls import path
from .views import blog_list

urlpatterns = [
    path('blog/', blog_list, name='blog_list'),
]
```

Em seguida, inclua o `core.urls` nas URLs do projeto em `meublog/urls.py`:

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('core.urls')),
]
```

## 9. Criar o Template

Crie o diretório `core/templates/core/` e dentro dele, crie o arquivo `blog_list.html` com o seguinte conteúdo:

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        h2 {
            color: #34495e;
            border-bottom: 2px solid #2980b9;
            padding-bottom: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            background: #fff;
            margin: 10px 0;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h3 {
            margin: 0 0 10px 0;
            color: #2980b9;
        }

        p {
            margin: 5px 0;
        }

        small {
            display: block;
            color: #7f8c8d;
        }

        .tags {
            display: inline-block;
            margin-top: 5px;
        }

        .tags li {
            display: inline;
            background: #e74c3c;
            color: white;
            border-radius: 3px;
            padding: 5px 10px;
            margin-right: 5px;
            font-size: 14px;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <h1>Blog</h1>
    <h2>Posts</h2>
    <ul>
        {% for post in posts %}
            <li>
                <h3>{{ post.title }}</h3>
                <p>{{ post.content }}</p>
                <small>{{ post.created_at }}</small>
                <p class="tags">Tags: 
                    {% for tag in post.tags.all %}
                        <span>{{ tag.name }}</span>{% if not forloop.last %}, {% endif %}
                    {% endfor %}
                </p>
            </li>
        {% endfor %}
    </ul>

    <h2>Tags</h2>
    <ul>
        {% for tag in tags %}
            <li>{{ tag.name }}</li>
        {% endfor %}
    </ul>

    <footer>
        <p>&copy; 2024 Meu Blog</p>
    </footer>
</body>
</html>
```

## 10. Comandos para Rodar o Docker

Depois de criar o `Dockerfile` e o `requirements.txt`, você pode construir e executar seu contêiner Docker com os seguintes comandos:

1. **Construir a imagem**:

    ```bash
    docker build -t meu_blog .
    ```

2. **Executar o contêiner**:

    ```bash
    docker run -p 8000:8000 meu_blog
    ```

Agora, você pode acessar seu blog em `http://localhost:8000/blog/`.

## 11. Iniciar o Servidor e Testar

Se você não estiver usando Docker, inicie o servidor de desenvolvimento diretamente:

```bash
python manage.py runserver
```

Acesse `http://127.0.0.1:8000/blog/` para visualizar a lista de posts e tags.

## 12. Publicar em

- [GitHub](https://github.com/daniloopinheiro)
- [Medium](https://medium.com/p/98b8b7d521d5/edit)
