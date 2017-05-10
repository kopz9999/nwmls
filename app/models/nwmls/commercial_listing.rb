class Nwmls::CommercialListing < Nwmls::Listing

  RAW_ATTRIBUTE_NAMES = %w(
    LN
    PTYP
    LAG
    ST
    LP
    LPH
    SP
    OLP
    HSN
    DRP
    STR
    SSUF
    DRS
    UNT
    CIT
    STA
    ZIP
    PL4
    ASF
    LSF
    UD
    AR
    DSRNUM
    LDR
    LD
    CLO
    YBT
    LO
    TAX
    MAP
    GRDX
    GRDY
    SAG
    SO
    NIA
    MR
    LONG
    LAT
    PDR
    CLA
    SHOADR
    DD
    AVDT
    INDT
    COU
    CDOM
    CTDT
    DOM
    SCA
    SCO
    VIRT
    SD
    SDT
    FIN
    MAPBOOK
    DSR
    HSNA
    COLO
    PIC
    AMP
    AVP
    BDC
    BLK
    BON
    CAP
    CHT
    CSP
    DLT
    ELEX
    ENV
    EXA
    EXP
    F17
    FAC
    GAI
    GRM
    GSI
    HET
    HOD
    INS
    LSZ
    LT
    NNN
    NOI
    OSF
    OTX
    PAD
    PKC
    PKU
    POC
    PTO
    SIZ
    SML
    STF
    STY
    SWC
    TAV
    TEX
    TRI
    TSF
    TX
    TXY
    VAC
    VAI
    VAL
    WAC
    WSF
    WSG
    YVA
    ZJD
    CFE
    ENS
    EXT
    FLS
    FND
    GZC
    HTC
    LDG
    LTV
    POS
    RF
    SWR
    TRM
    WAS
    TN1
    SF1
    RN1
    LX1
    NN1
    US1
    TN2
    SF2
    RN2
    LX2
    NN2
    US2
    TN3
    SF3
    RN3
    LX3
    NN3
    US3
    TN4
    SF4
    RN4
    LX4
    NN4
    US4
    TN5
    SF5
    RN5
    LX5
    NN5
    US5
    TN6
    SF6
    RN6
    LX6
    NN6
    US6
    PARQ
    BREO
    AllowAVM
    ProhibitBLOG
    ConstructionMethods
    EPSEnergy
    HERSIndex
    LEEDRating
    NWESHRating
    ROFR
    Auction
    LSZS
    EffectiveYearBuilt
    EffectiveYearBuiltSource
    OFF
    OFFRD
    SaleType
  )

  acts_as_nwmls_listing :property_type => 'COMI', :attribute_mappings => RAW_ATTRIBUTE_NAMES

end
