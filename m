Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC061C433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 16:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B288F6115B
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhDOQTQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 12:19:16 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:16161
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231549AbhDOQTP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 12:19:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBoRASkio/+lDrRsotbYnCwGYDJCG/ePkBQfNWo72yvgf61YXrpJZYldsTTcTPu4fqUdLQrRbVa04L55x0Rngd55+qtQLLRnALc6r85ibxx55tMb8uTAQ4EJVnb9uLU304qo9qy01juzq7mCAZaeI3VEiLgTWgrFvJM1HNK5rsPywP5scxyYUhFgE6XJ5odkZq3Try/dOL28kcYDnFwDdrmpbBgr70gHj926OF7DHcJlu5iG1YeNdoLGvtIrc/peXmOZF1M443WDY36yuMq288axY6cTqquCEXRphJajrDFrgRmg3jHdoyPhto4XaxaNno2LaG+B/iWiHr/y9lCudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWeVETb23Kblil1tXfHt8jEVHaNK6r8bCwLgFstzlBc=;
 b=Z2MbeSsZbUGu8wnDxlLpzeb91cDfqGwnD68+1YWDDkG0HwO1AbeRnayGlFdaI2MK1oUwDkg6gytx1hWfT/gKKFbG0Uv7HybGo7IW73m7ln1L7ovoZUZhOUrdL1QyxovESsqEAOKtx2HYN0WNnEWAnUmlFxm9HzU9t9M/eyxmaOJpD3mivXkbbNUYPC7fr0ZOpKMLZDs1Z0ZqS2Fs9SL803IH3rgMuIAnvaWQHBi/AMfuXeQV7ait7XjAbQ1wLcCG9k6mSfHkuv6KbgYengSKcxq97vieNiSCqYneAM9s9LWuVKT3LZfXoNf/ZjaE1N8PoIhrRr7E1EzATUkfBlgxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWeVETb23Kblil1tXfHt8jEVHaNK6r8bCwLgFstzlBc=;
 b=D4lisu+As5iA/v0uq/E6ZfI0vsE3nrNJFwXv+P+YGeYISDXEsJrFLVrWmv4d0uTwvXqyKS153Drsm/A5Epcnb9VGK8cXmmY6PzURh1QH44ZhJjV2cb/4OTV3Na9E+JydIfDhakwrM7fFKZ97ymJO+SE8m62CyI0PBQ+5eiLxCCo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 16:18:51 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 16:18:50 +0000
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption code
 path
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
Date:   Fri, 16 Apr 2021 00:18:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0032.apcprd03.prod.outlook.com
 (2603:1096:203:c9::19) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR03CA0032.apcprd03.prod.outlook.com (2603:1096:203:c9::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Thu, 15 Apr 2021 16:18:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ed2f843-e5c5-46ea-dab2-08d9002a2795
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4816:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4816C594223D83138F48DEAFE44D9@SJ0PR11MB4816.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEN40W6jvDRWE5pbStjTTffpEVZqO3xo7LPG6lXMeZ+VFM93DOtNzcbJ9W7Um2g8UwelcsTyGmmiDxhzf3DId4HP7t/PI0O2WAvmL12yOXhaya8llOCx3l1mSHJ87uBEi8h/Gko2xpvB3B1UfwN7uLlfs3R31qdY9RmRpVJ9BZl+lFDS4KqP+7x3ToO+7TP6ohrOvld4x4tNhr3eXtdPQj0qCqRgF6VE88mRs5mEvh0qpHy8bh6mbu2eDu2ngVF61vht7MWoqSYWMLDkwrDM5If9XcG1CX2RhtecjlXX10E5x+dw8b2KnKd3SyDPpIonvl2qIqQF02D4VwbUTHPB1BSZGXCYTA+wmleqZ+NDbpJn6qNUxAMMk7M4knHuCNSqKi8GN2bRAd18G9ZqCPdfZmjxx8stkYqYlEYlq14Dza9acB9XdjSYswddn7Khs1iyATFRYxtvSa9MQpmRFAPeNJ9Utt5Gwd3nHn4SivXK3ZxmO3loQLtXyiCZjt5gLRaRxdQBLagV7PbLtkPp4NVhIHwgUG0Dguqh+ZoLMRYBulAV/yTBqCJSX2z3liSB+kHlpcgcW5Zneg1oaDmeV+7gFMNDmVa7SGQqZ+MTayI4civtwRUdKB9rMuGT8HoGexZy7QOMZLqzywoXWe+LzHzc2WxvpCy8E3PUhHr4CtwBTJ/VotMcAlX2rJ/pSD2I9mT9GX4iOLVTdHr6vnjhFPi9Gq/cP+MQ8b/UjDUOc6YAYZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39850400004)(136003)(66476007)(86362001)(26005)(956004)(66946007)(6916009)(478600001)(83380400001)(2616005)(31696002)(186003)(36756003)(16576012)(53546011)(38100700002)(8936002)(31686004)(38350700002)(5660300002)(66556008)(2906002)(6666004)(6486002)(52116002)(316002)(6706004)(8676002)(4326008)(16526019)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlp6Y3lTdWpKTWVKZVowa3RUU0x4TmZaQitpMUhMV1VFL1hWUjBPSWdZQyt5?=
 =?utf-8?B?eVZCY21zZ3V3ZlBrYVNhcmRCUGpxMnFjdGI5VUVHakZDZVJWME0zeURhMkw4?=
 =?utf-8?B?NjB1Z1EzV0V1cktIR2dlQjlNY3NiYUJ5azUrWDJiVHNVaXJJYWpZeFErcFAx?=
 =?utf-8?B?TDM5RFBDay9ybzc1alVhZ0pVeCs1MGVjUVpUT0ZtS013eGZvcm1ZcDdjUmNo?=
 =?utf-8?B?YndFalU5Y1N4dW1weHVwN0VONGlIT3RJNzIxZzMya3ZoL1lRRDkrRlJrVzNB?=
 =?utf-8?B?aSsvZTlQNmQvY2JkanNUUFBjQm9YakdGMmJ1SzFVR3lpa3NRM1VTTTZjbHRm?=
 =?utf-8?B?S2xCQkJjVXdzUjE4Yy9od1Y2M3ZEVmgxbHBYZ0JnNGNrRGRZdzRUSEZrUHlq?=
 =?utf-8?B?KzY0Vmd2N0xUYjJSUXFSWnZBamx2VlhTblZxZ2xuKzlsdDJMcDYwYzZBamtm?=
 =?utf-8?B?K2xJMFZpT3cyeVJRQ0hyNzY3eE45MUkxWmN3WGF4aDdhYVorVnB3UzF4N1hO?=
 =?utf-8?B?YUFWRWZleWNRMFBod2xOTWdRbVJZazUrZitQVGFabkdUN0xXbmEzUFNRenFC?=
 =?utf-8?B?NmRFbUlSMUNiZlFCdE4wRDJ3SlNLTzZhUmo2KzJKUkZIT0haNVZHOUlkY2Nt?=
 =?utf-8?B?OTZGSnFabkFLdWlmaWpzQ0VCZEFxdGNKVUY3UEsrM3JIWGhZMTlXMmYvaFpp?=
 =?utf-8?B?c1NLQlFWUUFCQmp2V3pkUTBUOWRLT3VYQ2txLys1WlVQSWwvend4MlNTNDZn?=
 =?utf-8?B?NFlOOTIwUHdrOUltaVhzc0xJczYwRHRpT0pKdHBQMk9EaXRYbzVMb2FLM3I5?=
 =?utf-8?B?QXB0UmR0QXhkZVd6THNyalVWL2pBejFoNWtjejcvdnlxVkJScHlXbXdhdFFj?=
 =?utf-8?B?ZXNCTHh3cUZYczYwMCtUempnYmVnajdWa0lPaFhuZlFGNmRKWFFpaFRLZ3RE?=
 =?utf-8?B?ZFBCM3UvNENzQk9hR2w2TGlYb0dlTTRVd3c3RVpHN1ZkNlJOU3lwc211dmd5?=
 =?utf-8?B?V2VaVkZ4R2dybVNmUXFrN28weEE5UHJpbk5wUkY4YVVieDF4dkRKSjVkTGda?=
 =?utf-8?B?cXUzNUxwMFF1eUNQcUJ4ZGpzRDlVNlFsNFRkV0lxcTl0N1VNQ0ZXcXplU0lJ?=
 =?utf-8?B?Vi9ZUjl2bXZ1dUFGaUVyaDhWcklHenFxeHd3YWZYZDhXeUw4RWdjYUQvQzl4?=
 =?utf-8?B?QWZIWXBGem85cEN0RU1QZTU1ckRLSXAzZis4RktMT0cvQWtESm5KUVhmOXFm?=
 =?utf-8?B?NXNWQTJZS2o2QXgzbjNYMERqNFVzSHpQeUdmeFQ5RXlGL1ZoSEltVEx2TVk2?=
 =?utf-8?B?NXVkcHFSUEk2WVNQZWlET1R2NnlZTDE1a1RKczBaWUNwSXZwT0NPS1ZvYUs0?=
 =?utf-8?B?N09iMjc3US9hYXZ3WXJXbDBDeDIzcHNOZ3J4aDhWNktGVkxWU0YwZjU5Y2ht?=
 =?utf-8?B?eW9NSmlMbnQyZHJiVk9qc0JGNVY3bnBzSnlKeC9GSklrZ1hpRFptc2lhYkJs?=
 =?utf-8?B?YVRLcDRhVVdQQVBJSTVHZnQ0U2lUL0twUllXYTQ4S2w2UmlCdUxyMXNFajhG?=
 =?utf-8?B?S2ZTTmpWSjF6WFFRQTlHSXNZcWJDeDF6RHpRanBqWXFDWkNOeDdETFRwSERC?=
 =?utf-8?B?QjRTbDRWd1BnRlI5aTJoa2VtVjNWYkdaaEpBLy9VdVVoQXlrZWFtUzdXT3NB?=
 =?utf-8?B?dmRsTmpwVEdvTUdHYXM2elJYaHZpbjU4M08xdVQrZnM5ZklVMWk4bWNOOXJU?=
 =?utf-8?Q?CQpPjuL+vKMRochkGnEkKxuo7PsU+i8Tyw/YAn/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed2f843-e5c5-46ea-dab2-08d9002a2795
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 16:18:50.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEVc99MXmTXdwmFvl6n4wUlkH5PekXDfmVKolUCn359JuFrqFzJ5BNTYtrbp8PobfhXJovn18Or7Xjuy9dXgIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 4/15/21 11:43 PM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
>> Hi experts,
>>
>> I am learning rcu mechanism and its codes. When looking at the
>> rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
>> operation in non-preemption code path. And it has been a long time. I can't
>> understand why we need it? Is there some thing I missed? If not, can we
>> remove the unnecessary operation like blow?
> 
> Good point, you are right that preemption is disabled anyway in that block
> of code.  However, preempt_disable() and preempt_enable() also prevent the
> compiler from moving that READ_ONCE() around.  So my question to you is
> whether it is safe to remove those statements entirely or whether they
> should instead be replaced by barrier() or similar.

Thanks for your reply! :)

Yes, preempt_disable() and preempt_enable() defined in !preemption are 
barrier(). barrier can prevent from reordering that READ_ONCE(), but 
base on my current understanding, volatile in READ_ONCE can also tell 
the compiler not to reorder it. So, I think it's safe?

Best regards,
Yanfei

> 
>                                                          Thanx, Paul
> 
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index da6f5213fb74..c6d95a00715e 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
>>          if (IS_ENABLED(CONFIG_PREEMPTION))
>>                  return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>>          might_sleep();  /* Check for RCU read-side critical section. */
>> -       preempt_disable();
>>          /*
>>           * If the rcu_state.n_online_cpus counter is equal to one,
>>           * there is only one CPU, and that CPU sees all prior accesses
>> @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
>>           * Those memory barriers are provided by CPU-hotplug code.
>>           */
>>          ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
>> -       preempt_enable();
>>          return ret;
>>   }
>>
>>
>>
>> Best regards,
>> Yanfei
