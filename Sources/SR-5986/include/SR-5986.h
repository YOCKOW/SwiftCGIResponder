/***************************************************************************************************
 SR-5986.h
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Workaround for [SR-5986](https://bugs.swift.org/browse/SR-5986)

void swift_retain(void *object); // Implemented in swift runtime.
void * objc_retainAutoreleasedReturnValue(void *object); // Implemented in "SR-5986.c"

