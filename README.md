This directory contains files for creating a Docker image that runs TissUUmaps without read-only settings. It is based on https://github.com/TissUUmaps/TissUUmaps/tree/master/container (618b97caf0767bae5b2fc8580c9a29e203607fd8) but with a modified `tissuumaps.cfg`.

## Step 1: Build Docker image (only necessary if you have changed `Dockerfile` or `tissuumaps.cfg`)

```
docker build --platform=linux/amd64 -t jenfransson/tissuumaps .
docker push jenfransson/tissuumaps
```

## Step 2: Create apptainer images

In order to run on Bianca ThinLinc, the image must be converted to an apptainer image, and a firefox apptainer is necessay for WebGL 2.0 support. On linux system:

```
apptainer pull tissuumaps.sif docker://jenfransson/tissuumaps
apptainer pull firefox.sif docker://jlesage/firefox
```

## Step 3: Transfer .sif-files to Bianca

## Step 4: Run TissUUmaps on Bianca

On Bianca, run from a directory containing a sub-directory `shared` (the files in the `shared` directory are those that can be loaded in TissUUmaps):

```

apptainer exec --mount type=bind,source=.,dst=/mnt/data /path/to/containers/tissuumaps.sif gunicorn tissuumaps:app --bind=<projectname>-<nodename>:56733:80 &
apptainer exec /path/to/containers/firefox.sif firefox --bind=(projectname)-(nodename):5800

```

If Firefox doesn't open automatically, open a native browser and navigate to http://<projectname>-<nodename>:5800
In Firefox, navigate to http://<projectname>-<nodename>:56733


