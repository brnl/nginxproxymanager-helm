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
  {{- if .Values.nginxPVC.storageClassName }}
  storageClassName: {{ .Values.nginxPVC.storageClassName }}
  {{- end }}
  resources:
    requests:
      storage: {{ .Values.nginxPVC.storage }}
