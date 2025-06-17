# PersistentVolumeClaim for Nginx Proxy Manager data
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-npm-data
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  accessModes:
    - {{ .Values.nginxPVC.accessMode }}
  storageClassName: {{ .Values.nginxPVC.storageClassName | default "default" }}
  resources:
    requests:
      storage: {{ .Values.nginxPVC.storage }}
