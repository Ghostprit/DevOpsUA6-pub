FROM python:3.14-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

FROM python:3.14-slim AS final
WORKDIR /app
COPY --from=build /app /app
EXPOSE 5000
CMD ["python", "app.py"]