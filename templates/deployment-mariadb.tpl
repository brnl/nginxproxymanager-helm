# MariaDB Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-mariadb
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  replicas: {{ .Values.mariadb.replicas }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-mariadb
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-mariadb
    spec:
      containers:
      - name: mariadb
        image: {{ .Values.mariadb.image.repository }}:{{ .Values.mariadb.image.tag }}
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: {{ .Values.mariadb.env.rootPassword }}
        - name: MYSQL_DATABASE
          value: {{ .Values.mariadb.env.database }}
        - name: MYSQL_USER
          value: {{ .Values.mariadb.env.user }}
        - name: MYSQL_PASSWORD
          value: {{ .Values.mariadb.env.password }}
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: {{ .Release.Name }}-mariadb-data
