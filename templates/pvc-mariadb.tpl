# PersistentVolumeClaim for MariaDB data
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-mariadb-data
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  accessModes:
    - {{ .Values.mariadbPVC.accessMode }}
  storageClassName: {{ .Values.mariadbPVC.storageClassName | default "default" }}
  resources:
    requests:
      storage: {{ .Values.mariadbPVC.storage }}
