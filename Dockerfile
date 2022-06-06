FROM python:3.9-alpine3.13
LABEL maintainer="juniormach96"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Create a virtual environment
# install the packages inside it
# remove the requirements.txt file
# add user to not run the container with root user
# user must not have home dir to keep container lightweight
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# update path variable to run the commands from virtual environment
ENV PATH="/py/bin:$PATH"

USER django-user