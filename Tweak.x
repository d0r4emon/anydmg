#import <version.h>
#import <substrate.h>

#ifdef DEBUG
	#define LOG(LogContents, ...) NSLog((@"anydmg: %s:%d " LogContents), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
	#define LOG(...)
#endif

//
//copy from "AppSync Unified", thx :)
//
#define DECL_FUNC(name, ret, ...) \
	static ret (*original_ ## name)(__VA_ARGS__); \
	ret custom_ ## name(__VA_ARGS__)
#define HOOK_FUNC(name, image) do { \
	void *_ ## name = MSFindSymbol(image, "_" #name); \
	if (_ ## name == NULL) { \
		LOG(@"Failed to load symbol: " #name "."); \
		return; \
	} \
	MSHookFunction(_ ## name, (void *) custom_ ## name, (void **) &original_ ## name); \
} while(0)
#define LOAD_IMAGE(image, path) do { \
	image = MSGetImageByName(path); \
	if (image == NULL) { \
		LOG(@"Failed to load image: " #image "."); \
		return; \
	} \
} while (0)

//
//Imports from /System/Library/Frameworks/Security.framework/Security
//SecKeyRef key
//
DECL_FUNC(SecKeyRawVerify, OSStatus, SecKeyRef key, SecPadding padding, const uint8_t *signedData, size_t signedDataLen, const uint8_t *sig, size_t sigLen) {

	//original_SecKeyRawVerify(key, padding, signedData, signedDataLen, sig, sigLen);
	LOG(@"checking dmg signature, processed!");
	return 0;
}

%ctor {
	@autoreleasepool {
		MSImageRef image;

		LOG(@"Loading and injecting into Security.dylib");
		LOAD_IMAGE(image, "/System/Library/Frameworks/Security.framework/Security");

		LOG(@"Hooking SecKeyRawVerify");
		HOOK_FUNC(SecKeyRawVerify, image);
	}
}

