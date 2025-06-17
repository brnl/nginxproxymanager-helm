# Nginx Proxy Manager Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-npm
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  replicas: {{ .Values.nginx.replicas }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-npm
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-npm
    spec:
      containers:
      - name: nginx-proxy-manager
        image: {{ .Values.nginx.image.repository }}:{{ .Values.nginx.image.tag }}
        ports:
        - containerPort: 80
        - containerPort: 81
        - containerPort: 443
        env:
        - name: DB_MYSQL_HOST
          value: {{ .Values.mariadb.service.name }}
        - name: DB_MYSQL_PORT
          value: "3306"
        - name: DB_MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: {{ default (printf "%s-mariadb-secret" .Release.Name) .Values.mariadb.existingSecret }}
              key: mysql-user
        - name: DB_MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: {{ default (printf "%s-mariadb-secret" .Release.Name) .Values.mariadb.existingSecret }}
              key: mysql-user-password
        - name: DB_MYSQL_NAME
          value: {{ .Values.mariadb.env.database }}
        volumeMounts:
        - name: data
          mountPath: /data
        - name: letsencrypt
          mountPath: /etc/letsencrypt
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: {{ .Release.Name }}-npm-data
      - name: letsencrypt
        persistentVolumeClaim:
          claimName: {{ .Release.Name }}-letsencrypt
