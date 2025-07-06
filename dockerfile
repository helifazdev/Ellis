# 1. Usar uma imagem base oficial e estável do Python.
# A versão 'slim' é menor que a padrão, ideal para produção.
FROM python:3.10-slim-buster

# 2. Definir variáveis de ambiente recomendadas para Python em contêineres.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 4. Copiar o arquivo de dependências e instalá-las.
# Isso é feito antes de copiar o resto do código para aproveitar o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta que a aplicação vai usar.
EXPOSE 8000

# 7. Comando para rodar a aplicação quando o contêiner iniciar.
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
