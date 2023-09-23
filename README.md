# HistoryMe

Get the list of sources from settings.json and store them in an array SOURCES[]
For each PATH in SOURCES[]
    Get all the file path present in PATH and store them in SOURCE_FILES[]
Get the destination folder from settings.json and store it into SETTINGS_DESTINATION
Create the array DESTINATIONS[]="SETTINGS_DESTINATION\current","SETTINGS_DESTINATION\1","SETTINGS_DESTINATION\2","SETTINGS_DESTINATION\3","SETTINGS_DESTINATION\4"
For each DESTINATION in DESTINATIONS[]
    If folder DESTINATION does not exist in local computer:
        Create it.
    Else:
        If DESTINATION = SETTINGS_DESTINATION\current
            Create an array CURRENT_FILES[] with all the files paths present in DESTINATION
            Create an array named EXISTING_FILES[] with all the files in CURRENT_FILES[] and SOURCE_FILES[]
            Create an array TO_BE_DELETED_FILES[] with all the files in CURRENT_FILES[] and not in SOURCE_FILES[]
            For each FILE in TO_BE_DELETED_FILES[]
                If FILE exist in DESTINATION\4:
                    Delete FILE from DESTINATION\4
                If FILE exist in DESTINATION\3:
                    Delete FILE from DESTINATION\3
                If FILE exist in DESTINATION\2:
                    Delete FILE from DESTINATION\2
                If FILE exist in DESTINATION\1:
                    Delete FILE from DESTINATION\1
                Delete FILE from DESTINATION\current
            Update EXISTING_FILES[] with all the files paths present in DESTINATION
6 - For each FILE in SOURCE_FILES[]
    1 - If FILE does not exist in EXISTING_FILES[]
        Add FILE to MISSING_FILES[]

# At this point I have:
#   SOURCE_FILES[] Containing all the files path in all the Paths descrived in Settings.Json
#   EXISTING_FILES[] That are all the files existing in SETTINGS_DESTINATION\current and in SOURCE_FILES[]
#   MISSING_FILES[] that are all the files not existing in SOURCE_FILES[]

7 - If EXISTING_FILES[] has some item:
    1 - For each FILE in EXISTING_FILES[]:
        1 - If FILE exits in SETTINGS_DESTINATION\4:
                1 - Delete it from SETTINGS_DESTINATION\4
                2 - Move it from SETTINGS_DESTINATION\3 to SETTINGS_DESTINATION\4
                3 - Move it from SETTINGS_DESTINATION\2 to SETTINGS_DESTINATION\3
                4 - Move it from SETTINGS_DESTINATION\1 to SETTINGS_DESTINATION\2
                5 - Move it from SETTINGS_DESTINATION\current to SETTINGS_DESTINATION\1
            Else:
                1 - If FILE exits in SETTINGS_DESTINATION\3:
                        2 - Move it from SETTINGS_DESTINATION\3 to SETTINGS_DESTINATION\4
                        3 - Move it from SETTINGS_DESTINATION\2 to SETTINGS_DESTINATION\3
                        4 - Move it from SETTINGS_DESTINATION\1 to SETTINGS_DESTINATION\2
                        5 - Move it from SETTINGS_DESTINATION\current to SETTINGS_DESTINATION\1
                    Else
                        1 - If FILE exits in SETTINGS_DESTINATION\3:
                                2 - Move it from SETTINGS_DESTINATION\3 to SETTINGS_DESTINATION\4
                                3 - Move it from SETTINGS_DESTINATION\2 to SETTINGS_DESTINATION\3
                                4 - Move it from SETTINGS_DESTINATION\1 to SETTINGS_DESTINATION\2
                                5 - Move it from SETTINGS_DESTINATION\current to SETTINGS_DESTINATION\1
                            Else

8 - If MISSING[] has some item, copy it to DESTINATION\current
9 - If EXISTING[] has some item:
  1 - For each FILE in EXISTING[]:
    1 - If ITEM is not equal as corresponding DESTINATION\current item then
      1 - If ITEM exits in DESTINATION\4 then
        1 - Delete it from DESTINATION\4
        2 - Move it from DESTINATION\3 to DESTINATION\4
        3 - Move it from DESTINATION\2 to DESTINATION\3
        4 - Move it from DESTINATION\1 to DESTINATION\2
        5 - Move it from DESTINATION\current to DESTINATION\1