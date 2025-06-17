{{- if not .Values.mariadb.existingSecret }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-mariadb-secret
  namespace: {{ .Values.namespaceOverride | default .Release.Namespace }}
type: Opaque
stringData:
  mysql-root-password: {{ .Values.mariadb.env.rootPassword | quote }}
  mysql-user: {{ .Values.mariadb.env.user | quote }}
  mysql-user-password: {{ .Values.mariadb.env.password | quote }}
{{- end }}