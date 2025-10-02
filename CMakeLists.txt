cmake_minimum_required(VERSION 3.22)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(1VST VERSION 0.0.1)

add_subdirectory(juce)
add_subdirectory(dringbuf)

juce_add_plugin(1vst
    # VERSION ...
    # ICON_BIG ...
    # ICON_SMALL ...
    # COMPANY_NAME ...
    # IS_SYNTH TRUE/FALSE
    # NEEDS_MIDI_INPUT TRUE/FALSE
    # NEEDS_MIDI_OUTPUT TRUE/FALSE
    # IS_MIDI_EFFECT TRUE/FALSE
    # EDITOR_WANTS_KEYBOARD_FOCUS TRUE/FALSE
    # COPY_PLUGIN_AFTER_BUILD TRUE/FALSE
    PLUGIN_MANUFACTURER_CODE Dkr6
    PLUGIN_CODE VST1

    FORMATS AU VST3 Standalone
    PRODUCT_NAME "1VST")

# juce_generate_juce_header(AudioPluginExample)

target_sources(1vst
    PRIVATE
        src/PluginEditor.cc
        src/PluginProcessor.cc)

target_compile_definitions(1vst
    PUBLIC
        # JUCE_WEB_BROWSER and JUCE_USE_CURL would be on by default, but you might not need them.
        JUCE_WEB_BROWSER=0  # If you remove this, add `NEEDS_WEB_BROWSER TRUE` to the `juce_add_plugin` call
        JUCE_USE_CURL=0     # If you remove this, add `NEEDS_CURL TRUE` to the `juce_add_plugin` call
        JUCE_VST3_CAN_REPLACE_VST2=0)

# juce_add_binary_data(AudioPluginData SOURCES ...)

# `target_link_libraries` links libraries and JUCE modules to other libraries or executables. Here,
# we're linking our executable target to the `juce::juce_audio_utils` module. Inter-module
# dependencies are resolved automatically, so `juce_core`, `juce_events` and so on will also be
# linked automatically. If we'd generated a binary data target above, we would need to link to it
# here too. This is a standard CMake command.

target_link_libraries(1vst
    PRIVATE
        # AudioPluginData           # If we'd created a binary data target, we'd link to it here
        juce::juce_audio_utils
    PUBLIC
        dringbuf
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags)
