FROM cavenel/tissuumaps:latest

USER root
RUN rm /tissuumaps.cfg
COPY ./tissuumaps.cfg /tissuumaps.cfg
USER $USER

CMD ["gunicorn", "tissuumaps:app"]
