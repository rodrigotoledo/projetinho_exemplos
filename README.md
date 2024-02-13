# README

## Dependencias

### Imagemagick

```bash
sudo apt-get install libmagickwand-dev
sudo apt-get install libvips
```

### Highcharts

Instalando o pacote de maneira global

```bash
npm install highcharts-export-server -g
```

Para subir o servidor execute de

```bash
highcharts-export-server --enableServer 1
```

É possível passar os argumentos de gráfico inline mas a idéia é passar um arquivo com os dados. Mas inicialmente rode:

```sh
curl -H "Content-Type: application/json" -X POST -d '{"infile":{"title": {"text": "Steep Chart"}, "xAxis": {"categories": ["Jan", "Feb", "Mar"]}, "series": [{"data": [29.9, 71.5, 106.4]}]}}' 127.0.0.1:7801 -o mychart.png
```

### Mailcatcher

Em desenvolvimento os emails são capturados com a gem `mailcatcher` então é necessário instalar FORA DO PROJETO:

```bash
gem install mailcatcher
```

e depois subir com o comando:

```bash
mailcatcher
```
