# 1. Creer la base avec les dependances (FastAPI)
FROM python:3.12-slim as builder

# Empêche Python de générer des fichiers .pyc (gain de place)
ENV PYTHONDONTWRITEBYTECODE=1
# Empêche Python de mettre les logs en mémoire tampon (utile pour les logs Docker)
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt 

# 2. Recuperer les dependances et lancer l'initiale
# + Lancer avec script

# Image distroless (pas de shell, pas de gestionnaire de paquets)
FROM python:3.12-slim AS runtime

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

ENV PATH=/usr/local/bin:$PATH

USER nobody

EXPOSE 8000
ENV PYTHONPATH=/usr/local/lib/python3.12/site-packages
CMD ["python", "main.py"]

