/***************************************************************************************************
 SR-5986.c
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Workaround for [SR-5986](https://bugs.swift.org/browse/SR-5986)

#include "SR-5986.h"

void * objc_retainAutoreleasedReturnValue(void *object) {
  // I don't know whether this way is correct or not. It's just a workaround.
  if (object) { swift_retain(object); }
  return object;
}

