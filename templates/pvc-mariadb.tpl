# PersistentVolumeClaim for MariaDB data
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-mariadb-data
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  accessModes:
    - {{ .Values.mariadbPVC.accessMode }}
  resources:
    requests:
      storage: {{ .Values.mariadbPVC.storage }}
