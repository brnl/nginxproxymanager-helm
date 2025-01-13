---
# MariaDB Service
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-mariadb
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  selector:
    app: {{ .Release.Name }}-mariadb
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
  type: {{ .Values.mariadb.service.type }}
