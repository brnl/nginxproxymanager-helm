# PersistentVolumeClaim for Let's Encrypt
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-letsencrypt
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  accessModes:
    - {{ .Values.letsencryptPVC.accessMode }}
  storageClassName: {{ .Values.letsencryptPVC.storageClassName | default "default" }}
  resources:
    requests:
      storage: {{ .Values.letsencryptPVC.storage }}
