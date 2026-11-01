# Karwan-e-Marhaba - My Umrah Journey (Phase 1)

APK banane ka tareeqa (computer par, free):
1. github.com par free account banayein.
2. New repository banayein (naam: karwan-marhaba), phir "uploading an existing file" chunein.
3. Is folder ki SAARI files upload karein (lib folder, pubspec.yaml, .github folder, build-apk.yml).
   Agar .github folder upload na ho: repository mein "Add file > Create new file" par jayein, naam likhein
   `.github/workflows/build-apk.yml` aur build-apk.yml ka matan paste kar dein. Commit karein.
4. Upar "Actions" tab kholein > "Build Android APK" > "Run workflow". Taqreeban 5-8 minute intezar.
5. Complete hone par us run mein neeche "Artifacts" se `karwan-e-marhaba-apk` download karein, zip kholein,
   `app-release.apk` apne phone mein bhej kar install karein ("Install unknown apps" allow karna hoga).

Agar build fail ho to Actions mein red run kholein aur error ka matan mujhe bhej dein.
