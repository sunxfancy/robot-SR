// main.cpp
#include <node.h>
#include "pocketsphinx.h"

namespace robot {

using v8::Function;
using v8::FunctionCallbackInfo;
using v8::FunctionTemplate;
using v8::Isolate;
using v8::Local;
using v8::Object;
using v8::String;
using v8::Value;

void MyFunction(const FunctionCallbackInfo<Value>& args) {
    Isolate* isolate = args.GetIsolate();
    args.GetReturnValue().Set(String::NewFromUtf8(isolate, "hello world"));
}

void CreateFunction(const FunctionCallbackInfo<Value>& args) {
    Isolate* isolate = args.GetIsolate();

    ps_decoder_t *ps;
    cmd_ln_t *config;
    FILE *fh;
    char const *hyp, *uttid;
    int16 buf[512];
    int rv;
    int32 score;

    /* Initializing of the configuration */
    config = cmd_ln_init(NULL, ps_args(), TRUE,
        "-samprate", "8000",
        "-jsgf", "test.jsgf",
        NULL);
    ps = ps_init(config);

    /* Open audio file and start feeding it into the decoder */
    fh = fopen("myrecording.wav", "rb");
    rv = ps_start_utt(ps);
    while (!feof(fh)) {
    size_t nsamp;
    nsamp = fread(buf, 2, 512, fh);
    rv = ps_process_raw(ps, buf, nsamp, FALSE, FALSE);
    }
    rv = ps_end_utt(ps);

    /* Get the result and print it */
    hyp = ps_get_hyp(ps, &score);
    if (hyp == NULL) {
        args.GetReturnValue().Set(1);
        return;
    }

    printf("Recognized: %s with prob %d\n", hyp, ps_get_prob(ps));

    /* Free the stuff */
    fclose(fh);
    ps_free(ps);
    
    args.GetReturnValue().Set(0);
}

void Init(Local<Object> exports) {
    NODE_SET_METHOD(exports, "createFunction", CreateFunction);
}

NODE_MODULE(addon, Init)

}  // namespace robot