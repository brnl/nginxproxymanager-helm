# PersistentVolumeClaim for Let's Encrypt
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-letsencrypt
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  accessModes:
    - {{ .Values.letsencryptPVC.accessMode }}
  resources:
    requests:
      storage: {{ .Values.letsencryptPVC.storage }}
