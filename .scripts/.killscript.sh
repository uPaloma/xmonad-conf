#!/bin/bash

pidof $1 | xargs kill -9
