set(FREERTOS_SRCS                       ""
                                        )
file(GLOB_RECURSE FREERTOS1             "../lib_rtos_support/src/*.c")
file(GLOB_RECURSE FREERTOS2             "../lib_trycatch/src/*.c")
file(GLOB_RECURSE FREERTOS4             "../lib_trycatch/src/*.S")
file(GLOB_RECURSE FREERTOS5             "../../../Source/portable/MemMang/*.c")
file(GLOB_RECURSE FREERTOS6             "../../Common/Minimal/*.c")
file(GLOB         FREERTOS7             "../../../Source/*.c")
file(GLOB_RECURSE FREERTOS8             "../../../Source/portable/XCC/XCOREAI/*.c")
file(GLOB_RECURSE FREERTOS9             "../../../Source/portable/XCC/XCOREAI/*.xc")
file(GLOB_RECURSE FREERTOS10             "../../../Source/portable/XCC/XCOREAI/*.S")
list(APPEND FREERTOS_SRCS ${FREERTOS1} ${FREERTOS2} ${FREERTOS3} ${FREERTOS4} ${FREERTOS5} 
                          ${FREERTOS6} ${FREERTOS7} ${FREERTOS8} ${FREERTOS9} ${FREERTOS10} )

set(FREERTOS_INCLUDES_ALL               ../lib_rtos_support/api
                                        ../../../Source/include
                                        ../lib_xassert/api
                                        ../lib_trycatch/api
                                        ../lib_trycatch/src
                                        ../../../Source/portable/XCC/XCOREAI
                                        ../lib_rtos_support/src
                                        ../../../Demo/Common/include
                                        src/regtest
                                        )

set(EXCLUDE_FILES       ../../../Source/portable/MemMang/heap_1.c                         
                        ../../../Source/portable/MemMang/heap_2.c
                        ../../../Source/portable/MemMang/heap_3.c
                        ../../../Source/portable/MemMang/heap_5.c
                        ../../Common/Minimal/comtest.c           
                        ../../Common/Minimal/comtest_strings.c   
                        ../../Common/Minimal/crflash.c           
                        ../../Common/Minimal/crhook.c            
                        ../../Common/Minimal/flash.c             
                        ../../Common/Minimal/flash_timer.c       
                        ../../Common/Minimal/MessageBufferAMP.c  
                        ../../Common/Minimal/sp_flop.c           
                        ../../Common/Minimal/StaticAllocation.c
                        )

#Remove EXCLUDE FILES from list
FOREACH(SRC ${FREERTOS_SRCS})
    FOREACH(EXCLUDE ${EXCLUDE_FILES})
        IF(SRC MATCHES "${EXCLUDE}$")
            message(STATUS "Removing: ${SRC}")
            list(REMOVE_ITEM FREERTOS_SRCS ${SRC})
        ENDIF()
    ENDFOREACH(EXCLUDE ${EXCLUDE_FILES})
ENDFOREACH(SRC ${FREERTOS_SRCS})


message(STATUS ${FREERTOS_SRCS})
message(STATUS ${FREERTOS_INCLUDES_ALL})