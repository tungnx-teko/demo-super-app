//
//  FirebaseConstant.swift
//  BLUE
//
//  Created by linhvt on 4/21/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

public enum Firebase {
    
    public enum Key {
        
        enum Database {
            
            enum MainPath {
                static let warehouses               = "sellers_warehouses"
            }
            
            enum Warehouse {
                static let id                       = "id"
                static let name                     = "name"
                static let code                     = "code"
                static let provinces                = "provinces"
                static let storeCodes               = "storeCodes"
            }
            
        }
        
        enum RemoteConfig {
            
            static let terminal                     = "TERMINAL"
            static let channel                      = "CHANNEL"
            static let accountDetail                = "AccountDetail"
            static let appStatus                    = "appStatus"
            static let env                          = "env"
            static let paymentList                  = "paymentList"
            static let themeName                    = "themeName"
            static let isShowApple                  = "isShowApple"
            static let isSupportAppScheme           = "isSupportAppScheme"
            static let appIcon                      = "appIcon"
            static let appID                        = "appID"
            static let appConfigs                   = "AppConfigs"
            static let loginMethods                 = "LoginMethods"
            static let feedbackNumber               = "FeedbackNumber"
            
            
            enum General {
                static let key                      = "key"
                static let enabled                  = "enabled"
                static let editable                 = "editable"
                static let visible                  = "visible"
                static let title                    = "title"

                static let shippingConfig           = "shippingFees"
                static let sellerId                 = "sellerId"
                static let shippingFee              = "shippingFee"
                static let shippingFeeSku           = "shippingFeeSku"
                static let freeShippingMilestone    = "freeShippingMilestone"
                static let shippingItemName         = "shippingItemName"

            }
                        
            enum HomeSetting {
                
                static let isShowBanner             = "isShowBanner"
                static let tokenBannerHome          = "BANNER_HOME_XTOKEN_KEY"
                static let showTab                  = "showTab"

                static let homeSections             = "homeSections"
                static let HomeSections             = "HomeSections"
                static let header                   = "header"
            }
            
            enum AccountDetail {
                static let accountDetailSections    = "AccountDetail"
            }
            
            enum AppConfig {
                static let policy                   = "POLICY"
                static let hotline                  = "HOTLINE"
                
                static let tpayRegistration         = "REGISTER_TPAY"
                static let tpayHotline              = "TPAYHOTLINE"
                static let tpayPolicy               = "T-PAY-POLICY"
                
                static let blueConversionRate       = "BLUE_CONVERSION_RATE"

            }
            
            enum Env {
                // api related
                static let api          = "API_BASE_URL"
                static let search       = "SEARCH_URL"
                static let crm          = "API_CRM_URL"
                static let order        = "API_ORDER_URL"
                static let promotions   = "API_PPM_URL"
                static let catalog      = "API_CATALOG_URL"
                static let iam          = "API_IAM_URL"
                static let payment      = "API_PAYMENT_URL"
                static let address      = "API_ADDRESS_URL"
                static let user         = "API_USER_URL"
                static let image        = "VS_IMAGE_URL"
                static let notification = "API_NOTIFICATION_URL"
                static let pageBuilder  = "API_PAGE_BUILDER_URL"
                static let policy       = "API_VNSHOP_URL"
                static let oAuth        = "API_OAUTH_URL"
                static let identity     = "API_IDENTITY_URL"
                static let loyalty      = "API_LOYALTY_URL"
                static let discovery    = "API_DISCOVERY_URL"
                
                // something's belong appConfigs
                static let clientCode       = "CLIENT_CODE"
                static let oauthClientId    = "OAUTH_CLIENT_ID"
                static let trackerClientId  = "TRACKER_CLIENT_ID"
                static let loyaltyClientId  = "LOYALTY_CLIENT_ID"
                static let gms              = "GMS_API_KEY"
                
                // something's belong paymentConfigs
                static let paymentClientCode        = "PAYMENT_CLIEN_CODE"
                static let paymentTerminalCode      = "PAYMENT_TERMINAL_CODE"
                static let paymentSecretKey         = "API_PAYMENT_SECRET_KEY"
            }
            
        }
        
        
    }
    
}
