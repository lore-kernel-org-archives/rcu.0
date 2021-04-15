Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DEC43462
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A709B61131
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhDOPFk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:05:40 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:52625
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234638AbhDOPEh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 11:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIu0HEKXrckRjar46Sx5dd7LpaklfKiHAVb3TavqhUrQF/EaSDeiWs2MppzvfpITXMtJ1BTxUsts1KYtSQtsxpjE4sn4jQdHRdffav1B/j08OtoldmN1ftjVzyDiFqQhPbrN5FqxyDWRwaBhKtSnHUjRdPa1NZoTz1llmJPKlOmwuiQV5sshI97N45zj9DjmrCZhBaG5+pE/nmfswXmPNAcWHDsAbFUUb4CTZcIeBCiPU7G97n+/bgoNKRki529NxO41CkEINyTNXgJnfbu9+utKzx83KYhqmmXFe5GDtQN0Pj0YOwjicrLiloA13w0LfXSh7GamxPlU1uXsr73BJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnruNx+bRqjz5vSKyTyZASmKmVflkk2FEjx1Iqhwmqg=;
 b=X+2Y80esXdJwkLhbfVxbybhvMflNsx8xg7HiJm6XkQY/DHXr4GT61OS9xx4tQ627MqOXqFUw5QAMxVCTRr7+7uJcEaf2WJHwrcuEek6pIovpxr+xkJ7zjOuMTihLLV3EcnbamFbnSr9Lpk/zpjLsTiBSFcDXcP989clVwOHzS5z22Nhqx3sRzpA3I49PNVS0rDomWXc2XVPkhOwGvrRcbwopzB4bYkllkjZOPlEW40mn3f2jwB4eeknIhtHMZbxIjSEFsFIDiH+Vsm0vzTzmHKHbtI2Utu6h9dpZ7tqOwOXIgtmex6oqZfoXEX5vN3SMvcyOL6ufvdnK1T9+uHNUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnruNx+bRqjz5vSKyTyZASmKmVflkk2FEjx1Iqhwmqg=;
 b=e2WXTfellpG4BHnh/w70UDMCzJZ/WuPX7Gg+oi2yn91gWwg4OTWtZkzXFrkoFlgCFvDh8WV5NoF5gVyy8YKLulgpCtvlFMvjm+tiptxxiBCk98Q11mKkYb8sk8QjnE1IQ1hZ4VT9Ympss/f7h+0lzggRrf/sFttmcypvOn/uWX8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2597.namprd11.prod.outlook.com (2603:10b6:a02:c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 15 Apr
 2021 15:04:13 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 15:04:13 +0000
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: [Qestion] Is preempt_disable/enable needed in non-preemption code
 path
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
Date:   Thu, 15 Apr 2021 23:04:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Thu, 15 Apr 2021 15:04:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb53d31-598f-4e90-4cae-08d9001fbab1
X-MS-TrafficTypeDiagnostic: BYAPR11MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2597FCF477CBC60390296BB0E44D9@BYAPR11MB2597.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksuwXmNhjEEgh6SqqltQv1jo92ZOE+GJ7vwj9l+ysfxyRqRC9/qLlSb1Sc4KCG+o4XmFRbak7MTGaHxeAmV5ErmpgcpAKiXtoCKKk9zjQSGkDdbKhwvSWAnqxQyWmrumdz128qcbiTz0Uqq7nr5NRGdEfPsEduYzrThG0YxT2qkyT/6xnSE8s5PiGyetw7lmHW0Rt3U8tbcM80/esYshhVLPY5RHuiLq4Ug4sqBqHiGN3bpaJ5PBLeA283Vbhqvj7Bu75oUBKJK8ymjrAS0R81HnK4BNwqz1XhAi59PFZJwz5QTC3HktwUZw05MTcA+fdtB6ZYdSEgCZ5oqb+r0opqDiLqdejvUHufekXfPkaQ6G7Rd8zQVgWbVVJMa2OomW6tZ7KnXKTKgzHJgqtoLy7v5S0TFzkoveOPRp8IclpSoAt6bKMFzV9VfnKkoqjzihCQo5VnoVF1KbMTiC2UOQE2ovbsRjrzigiLLl7HBLfGcRDlzwI+P+ds6PU64RBZ+odQ4ZthLnQVFynp7GDMtbWw2kDmH+tEDFuN8q586HD7pdRsbMEsCxRu3llOQ+HhnIMLaR5RzKaxsf4hvCYOHHhhuLphOVEmkKKh6f7JrzoyuikF5v+BGCNIP8DY8CBJRGJtSP0gEgb7vpFBc9DghJW2mDIMyWr9yJv10omUf/i5kE2J8E2RDgXhady10i7icuyDCCRhrFr4H9M5GClSX5b+uAffFJIEo8tz6ejfFcZeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(66556008)(66476007)(16526019)(5660300002)(66946007)(2616005)(6706004)(83380400001)(956004)(4326008)(38100700002)(6666004)(86362001)(36756003)(16576012)(6486002)(2906002)(31686004)(26005)(8676002)(6916009)(38350700002)(31696002)(8936002)(186003)(316002)(52116002)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1lYT2lMaWdYZjhqenBjK25TQ0xBN0EraFFOMFlMTjBRdFNaWXBuOEk1VW4y?=
 =?utf-8?B?U2ROc3Z3S2VUWkd0RTFxczAwYXZpc3FWMEJhWVcwL0NSb095ZjNLSG5ZTEx5?=
 =?utf-8?B?N0lDUUwxT0grYjliNVEzM1JSNTdsM2FOb1RwKzIralRYMDZuREZubXlPUFFS?=
 =?utf-8?B?U3RRYmFpN1lwdWp0WkdRMGxKVFpCd2k4RG9LOVlnRS8ranpUOFRYaldFeVlX?=
 =?utf-8?B?NWIybmpYeG1zUDhxTWhIL29JWU16VSs3Q2ovdjV3eWkrS1l6bzJGRUUxWUEv?=
 =?utf-8?B?ZGd6VERmUTJxelVTM1IvSWRtY1BCMWRKclQ2WmVTMW9tckE1akc0ZDlmelNz?=
 =?utf-8?B?QnRsbzZUZUg4RXRlRnl0SnNXd3dUSWtQTitUMytUUjhtV3dRckFnTVl2bGVP?=
 =?utf-8?B?bHZPa2lHYWxQMWZOcUN5UjJDS2NSblV2OXpET2RwZ0xzVFF0MnV5dCt2QnNq?=
 =?utf-8?B?aWsvdm5IZE5OWHV5VXppNGxxMmFEVW9pYk13VjdiWGppaXlidk13enJ4bllH?=
 =?utf-8?B?Ky9QdnhBaDZMV1dTU3ordmNxeWp4TlkxKy9QTmw5MWt5RnVuRGxaMFZoOVhu?=
 =?utf-8?B?cGRtc01IcFZhbXdqeHA3c1dCcTBvcldYbWRsYnRaa1ZHN21jWmJuZ2p4Y3I4?=
 =?utf-8?B?NjZ4ZVkzSmREdENPQ2pKQjRIQUw3bmx0L21MUklQTDFaZW1nYVBSei9ZZjND?=
 =?utf-8?B?S3BUVy83aXF0b3NaNHJBZnl1UE9kSEJ6WGd0b2FJR0NZOG1CdUhrTXdJMU54?=
 =?utf-8?B?d2tYWXE2QmFjeHNFWUlGb1lJb1NWWXJJSGZVcmdtMGhOZ0l2bG1ZM3RnbzlM?=
 =?utf-8?B?czZBa1M5UHpXVnFKK1phYml0bWVEa2JsVngwcFB4UklCOW9XcU5vUXd1SmZH?=
 =?utf-8?B?UEFqN0xTeVliUHZoRDl0UDd3bXNlMXFDSUF1R1JpM0hOc3F5OGliTmpNbDRw?=
 =?utf-8?B?bTFmb24wUUN1Z1AwdVpVcXJvU0RmVmpmZVJabHJpV1psT0lRUXlUZ0lnMXRK?=
 =?utf-8?B?dDFrWm5ua1RqM2ZYd2FpQjFUTm16ZVIyTW45RlVNRzRpQTRRU1loRm9naVJa?=
 =?utf-8?B?eFJ1bmFsUkthODdmb1hIR2YxYkgrVHdPRi8zWkFDUkgwbktZdFU1R3pMVW8r?=
 =?utf-8?B?WmoxY29CMDY0RklDazZHd1g5aHFKSndtZmhZeUdKUFp1QlBscWlmKzlRUWZU?=
 =?utf-8?B?c3NmSHI0eWVDTllwbHJXcElwY01zV2RTeDIvbHZIUkdkellMT3RycXlLcE4v?=
 =?utf-8?B?dExhVWdCSHk2dGI2VytDS2o0OVpIODVuVXUzaTUzdWtFcEl6UXltYVZ6djg2?=
 =?utf-8?B?N1NPY2dvZFRqb3RxRm1TdzMyYm9hZkZHcllZTDVCV1Nwd0xuNlVrcXpEREtM?=
 =?utf-8?B?a2pMMWgxMTBUalVXVm51Yi9QL0tTQUYxeVoxc2tSRUZSTERQZkltQmw4Ykty?=
 =?utf-8?B?UTdZM1Rtbk1lQlpQdk9nZ3RzRDhTb2RzQVlrZG5TNkY3cnR2c2QvQ3JSaHFC?=
 =?utf-8?B?VDFkYkt5TVBnUVAwbkJGblF0d0d2c1hCYmQrWVBhdXlwNWhobzNINnhnZHlj?=
 =?utf-8?B?OW5nNkRyTUhid1Bub0thSUt3NXZxQXB1RmxYUk9peGhtSDVseWs4WDdQYllN?=
 =?utf-8?B?a2lCM2Q2WUFGVXprUW1OdUhUZlFXMFY3ZFJsU2xWMFlJMUlveXBVOTlJOFYy?=
 =?utf-8?B?QVlzeXYxbUlKVGRaVXFEZE9aTHk5WC85dGxGaTh3RnNDclNPRzBYZTdqRXdX?=
 =?utf-8?Q?Ug4dlhtfbIRLviS/wX6/W+sCimjhjHmQ/8Hv9wj?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb53d31-598f-4e90-4cae-08d9001fbab1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 15:04:12.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6FQ3X+XIfiNVx7V5YWrs+pU3SgDeJDehrYgXcfy+cSs4b6gRkr7EQdbC0wKxz//ZgtX0e24rjzK6jxVRjE/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2597
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi experts,

I am learning rcu mechanism and its codes. When looking at the 
rcu_blocking_is_gp(), I found there is a pair preemption disable/enable 
operation in non-preemption code path. And it has been a long time. I 
can't understand why we need it? Is there some thing I missed? If not, 
can we remove the unnecessary operation like blow?


diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f5213fb74..c6d95a00715e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
         if (IS_ENABLED(CONFIG_PREEMPTION))
                 return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
         might_sleep();  /* Check for RCU read-side critical section. */
-       preempt_disable();
         /*
          * If the rcu_state.n_online_cpus counter is equal to one,
          * there is only one CPU, and that CPU sees all prior accesses
@@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
          * Those memory barriers are provided by CPU-hotplug code.
          */
         ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
-       preempt_enable();
         return ret;
  }



Best regards,
Yanfei
