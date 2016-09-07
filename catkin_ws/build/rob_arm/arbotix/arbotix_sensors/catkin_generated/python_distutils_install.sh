#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/dilucia/catkin_ws/src/rob_arm/arbotix/arbotix_sensors"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/dilucia/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/dilucia/catkin_ws/install/lib/python2.7/dist-packages:/home/dilucia/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/dilucia/catkin_ws/build" \
    "/usr/bin/python" \
    "/home/dilucia/catkin_ws/src/rob_arm/arbotix/arbotix_sensors/setup.py" \
    build --build-base "/home/dilucia/catkin_ws/build/rob_arm/arbotix/arbotix_sensors" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/dilucia/catkin_ws/install" --install-scripts="/home/dilucia/catkin_ws/install/bin"
