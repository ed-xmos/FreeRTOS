// Copyright (c) 2020, XMOS Ltd, All rights reserved

#include <platform.h>
#include "rtos_printf.h"
#include "testing_main.h"

extern "C" {
int my_main( int tile, chanend xTile3Chan );
void rtos_irq(int core_id, int source_id);
void bare_metal_task(chanend c_vfe);
}



int main(void)
{

	par {
		on tile[0]:
		{
            chan c_vfe;
			par {
				bare_metal_task(c_vfe);
				my_main( 0, c_vfe);
			}
		}
	}
	return 0;
}
