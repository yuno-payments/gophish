#!/bin/bash

echo "Update & Upgrade | Install Golang & GoPhish..."
sudo apt update & sudo upgrade -y
sudo apt install golang-go -y
sudo apt install unzip -y

# Install GoPhish
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
sudo mkdir /opt/gophish
sudo unzip gophish-v0.12.1-linux-64bit.zip -d /opt/gophish

sudo mkdir /opt/gophish/static/endpoint

echo "Create Custom Landing Page..."
sudo touch /opt/gophish/static/endpoint/custom_file.html
sudo bash -c 'cat <<EOF > /opt/gophish/static/endpoint/custom_file.html
<html>

<head></head>

<body>
    <p><img alt="" height="318"
            src="https://cloud.phishinsight.trendmicro.com/content/lps/assets/user/39f45d95-5eb2-4b8d-9aa2-620bc07a57f4/7f842e3e-974d-4e8f-8ba7-de43fe7defdf.png"
            style="display: block; margin-left: auto; margin-right: auto;" title="linkedin_cover__1_.png"
            width="1272" /></p>
    <p style="text-align: center;"><span
            style="background-color: #ffffff; color: #000000; font-size: 20pt; font-family: arial, helvetica, sans-serif;"><strong>Caiste
                en Phishing!</strong></span></p>
    <p><span style="font-family: arial, helvetica, sans-serif;">En Yuno nos importa la seguridad de nuestros accesos,
            por lo que generamos esta campaña para concientizar sobre los ataques de Phishing. En los proximos dias vas
            a estar recibiendo un correo para que realices una capacitacion obligatoria sobre Phishing y asi puedas
            estar preparado por si llega a aparecer una caso de Phishing real.</span></p>
    <p><span style="font-family: arial, helvetica, sans-serif;"><strong>Esto fue un simulacro</strong>, por lo que las
            credenciales que ingresaste no fueron almacenadas en ningun lugar, ni hubo ningun cambio en tus credenciales
            productivas. </span></p>
    <p><span style="font-family: arial, helvetica, sans-serif;">Te pedimos que no le comentes a tus compañeros sobre
            este simulacro para que nuestras metricas sean lo mas acertadas posibles.</span></p>
    <p></p>
    <p><span style="font-family: arial, helvetica, sans-serif;">Con cariño, el team de Secops </span><span
            style="background-color: #ffffff; color: #000000; font-size: 20pt; font-family: arial, helvetica, sans-serif;"><strong>💜🔐</strong></span>
    </p>
</body>

</html>
EOF'

echo "Change Config Files..."
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /opt/gophish/config.json
sudo sed -i 's/false/true/g' /opt/gophish/config.json
sudo sed -i 's/80/443/g' /opt/gophish/config.json
sudo sed -i 's/true/false/g' /opt/gophish/config.json
sudo sed -i 's|"contact_address":.*,|"contact_address": "fernando.fabbiano@y.uno",|; s|"filename":.*,|"filename": "app.log",|; s|"level":.*|"level": "info"|' /opt/gophish/config.json

echo "Execute GoPhish..."
cd /opt/gophish
sudo chmod +x gophish
sudo ./gophish
