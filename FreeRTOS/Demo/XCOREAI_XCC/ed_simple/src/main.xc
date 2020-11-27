// Copyright (c) 2020, XMOS Ltd, All rights reserved

#include <platform.h>
#include "rtos_printf.h"
#include "testing_main.h"

extern "C" {
int freertos(int tile);
void bare_metal_task(chanend c_vfe);
void vfe(chanend c_vfe);
}



int main(void)
{

	par {
		on tile[1]:
		{
            chan c_vfe;
			par {
                vfe(c_vfe);
				bare_metal_task(c_vfe);
				freertos(1);
			}
		}
	}
	return 0;
}
