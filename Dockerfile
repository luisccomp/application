FROM python:3.11 as build

WORKDIR /usr/application

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1

RUN python -m venv venv

COPY . .

ENV PATH=/usr/application/venv/bin:$PATH

RUN apt update && \
    python -m pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt

FROM python:3.11-alpine

WORKDIR /usr/application

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1
ENV PATH=/usr/application/venv/bin:$PATH
ENV PYTHONPATH=/usr/application:$PYTHONPATH

COPY --from=build /usr/application/venv ./venv
COPY . .

ENTRYPOINT [ "sh", "entrypoint.sh" ]

EXPOSE 8000
