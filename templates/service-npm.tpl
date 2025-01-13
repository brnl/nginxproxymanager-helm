# Nginx Proxy Manager Service
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-npm
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Release.Name }}
spec:
  selector:
    app: {{ .Release.Name }}-npm
  ports:
    - name: plain
      protocol: TCP
      port: {{ .Values.nginx.service.ports.http }}
      targetPort: 80
    - name: secure
      protocol: TCP
      port: {{ .Values.nginx.service.ports.https }}
      targetPort: 443
    - name: webui
      protocol: TCP
      port: {{ .Values.nginx.service.ports.webui }}
      targetPort: 81
  type: {{ .Values.nginx.service.type }}
{{- if .Values.nginx.service.externalIPs }}
  externalIPs:
{{- range .Values.nginx.service.externalIPs }}
    - {{ . }}
{{- end }}
{{- end }}