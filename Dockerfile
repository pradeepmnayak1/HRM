FROM python:3.11.6

RUN python -m venv myenv
RUN . myenv/bin/activate
COPY . /horilla

RUN pip install --upgrade setuptools
RUN pip install -r /horilla/requirements.txt
WORKDIR /horilla
RUN rm -rf ./media

EXPOSE 8000

ENTRYPOINT ["sh", "-c", "python3 manage.py makemigrations && python3 manage.py migrate && gunicorn --bind 0.0.0.0:8000 horilla.wsgi:application"]