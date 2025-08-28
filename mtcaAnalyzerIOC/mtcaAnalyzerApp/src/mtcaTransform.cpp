#include <algorithm>
#include <vector>

#include <stdio.h>
#include "epicsExport.h"
#include "aSubRecord.h"
#include "registryFunction.h"

#include "lttb.hpp"

static long applyTransform(aSubRecord *prec) {
    double* gain = (double*)prec->a;
    double* offset = (double*)prec->b;
    short* array = (short*)prec->c;
    double* arrayOut = (double*)prec->vala;
    for (int i = 0; i < prec->nec; ++i) {
	arrayOut[i] = gain[0] * array[i] + offset[0];
    }
    prec->neva = prec->nec;
    return 0;
}

static long calculateTimeArray(aSubRecord *prec) {
    long* numSamplesR = (long*)prec->a;
    long* samplingFrequencyR = (long*)prec->b;
    long numSamples = numSamplesR[0];
    long samplingFrequency = samplingFrequencyR[0];
    double* outArray = (double*)prec->vala;

    for (long i = 0; i < numSamples; ++i) {
	outArray[i] = (i / (double)samplingFrequency) * 1000;
    }
    prec->neva = numSamples;
    return 0;
}

struct ExamplePoint {
    double x;
    double y;
};

using PointLttb = LargestTriangleThreeBuckets<ExamplePoint, double, &ExamplePoint::x, &ExamplePoint::y>;

// Minimal LTTB: A = y(double[]), B = out count(long), VALA = x downsampled (double[]), VALB = y downsampled (double[])
static long applyLTTB(aSubRecord *prec) {
    const double* y = static_cast<const double*>(prec->a);
    const long* outCountR = static_cast<const long*>(prec->b);

    const size_t in_size = static_cast<size_t>(prec->nea);
    const size_t out_size = static_cast<size_t>(outCountR[0]);

    std::vector<ExamplePoint> in(in_size);
    for (size_t i = 0; i < in_size; ++i) {
        in[i] = ExamplePoint{ static_cast<double>(i), static_cast<double>(y[i]) };
    }

    std::vector<ExamplePoint> out(out_size);

    PointLttb::Downsample(in.data(), in_size, out.data(), out_size);

    double* xOut = static_cast<double*>(prec->vala);
    double* yOut = static_cast<double*>(prec->valb);
    for (size_t i = 0; i < out_size; ++i) {
        xOut[i] = static_cast<double>(out[i].x);
        yOut[i] = static_cast<double>(out[i].y);
    }
    prec->neva = static_cast<epicsUInt32>(out_size);
    prec->nevb = static_cast<epicsUInt32>(out_size);
    return 0;
}

epicsRegisterFunction(applyTransform);
epicsRegisterFunction(calculateTimeArray);
epicsRegisterFunction(applyLTTB);
