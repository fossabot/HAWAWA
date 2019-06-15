# imgui
# Git repository : "https://github.com/ocornut/imgui
# Drop-Down library

message(STATUS "Clone 'imgui' from [https://github.com/ocornut/imgui.git]")

FetchContent_Populate(imgui
    QUIET
    GIT_REPOSITORY "https://github.com/ocornut/imgui.git"
    GIT_TAG "4158cba1ffd338c46d52164c2be0762031e66f53"
)

message(STATUS "Clone 'imgui' Done")

FetchContent_GetProperties(imgui)
if(NOT imgui_POPULATED)
    if(EXISTS "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui")
        file(REMOVE "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui")
    endif()

    file(GLOB NB_FETCH_CONTENT_HEADERS "${imgui_SOURCE_DIR}/*.h")
    file(GLOB NB_FETCH_CONTENT_SOURCES "${imgui_SOURCE_DIR}/*.cpp")
    file(COPY ${NB_FETCH_CONTENT_HEADERS} ${NB_FETCH_CONTENT_SOURCES} DESTINATION "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui")
endif()

# Get list of public and private sources of imgui
# publics[out]      List of imgui public source
# private[out]      List og imgui private source
function(NB_FUNC_EXTERNAL_MODULE_PUBLIC_PRIVATE_IMGUI publics privates)
    file(GLOB NB_EXTERNAL_MODULE_PUBLICS 
        "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui/imgui.h"
        "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui/imgui_internal.h"
    )

    file(GLOB NB_EXTERNAL_MODULE_PRIVATES
        "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui/*.h"
        "${CMAKE_SOURCE_DIR}/${NB_MODULE_EXTERNAL_DIR}/imgui/*.cpp"
    )
    
    list(REMOVE_ITEM NB_EXTERNAL_MODULE_PRIVATES ${NB_EXTERNAL_MODULE_PUBLICS})

    set(${publics} ${NB_EXTERNAL_MODULE_PUBLICS} PARENT_SCOPE)
    set(${privates} ${NB_EXTERNAL_MODULE_PRIVATES} PARENT_SCOPE)
endfunction()
