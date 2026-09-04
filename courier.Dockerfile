FROM dgshanee/courier

COPY service.yaml .

ENTRYPOINT ["courier", "run", "service.yaml"]
