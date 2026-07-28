# Red Hat UBI Python image — OpenShift-ready (non-root, random UID compatible)
FROM registry.access.redhat.com/ubi9/python-39:1-1780505855

# Become root only for installing dependencies into the image layers
USER 0

WORKDIR /opt/app-root/src

COPY --chown=1001:0 requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=1001:0 app.py .

# OpenShift runs containers with an arbitrary non-root UID in this group
USER 1001

EXPOSE 8080

CMD ["python", "app.py"]
