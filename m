Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1947C433ED
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 10:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABEF6115B
	for <rcu@archiver.kernel.org>; Fri, 16 Apr 2021 10:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhDPKvq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:51:46 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:9825
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235315AbhDPKvo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Apr 2021 06:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHsjx2/ItIiVMhRW9S5Th4/J8KDxF0G7Y+G070AL4afOzIUcCUVTlIAo9Ov+P2Uc/DMrwcL8rRSYk8OqoDqQTmHgS6bozpmzHjRrhV34Py21cava/W+qLYpndBC7w3y9UECTVz07NROMD6h97+CoAoHAVGZbyr2dFdb2OMIV2QUvdvnFo17EJYz/XZt8fKOBEnmthUVv5+ESyr17dsBCYY6D8tGXKqF9PmAK9Zjm6925R5mxGXsK5x3cUbX7iwAA42v+GXO1FlIQ+7jsy+Tl143P2ZTe9FkPm6VkUw0T4xdvol2lb0Rx7JnHn8wsxPVm2hebMKZn/R2J8dAAOJbsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scjB371DXveruiuR9xnWEKOWhnSuH+iroPGSLuKXUoo=;
 b=Rmu7TZITvX7Cza6aIolzuiVuQwvdmEqnvYxoDyLFunHrHtzb99y/wrSilnR3SP8vOuJIlntdveTJWPa1WM9g1YCSPEGAwta7pSKgfh4iKJpTNDybRn/l7Ta3oMQWqSkm6C8zEtcAMSuENHx+qOZXT1LKUNX4eVIHdk5nkrDLlab6pGpOqBJf08T9yREEz5Zl1OicR8SZKXDkh6vzS/a9cEZjhlPNNruppP3rFmF8heTButM2dRdpSpBEuoIAq7xeA+doswelstnJDKZmQU8Dxiiq5HzwSW+E4gsHzd+PiIWiuhvPNnJ2SnqI8SM8MoPQipNcN0ZeeHkGOIvNq+t3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scjB371DXveruiuR9xnWEKOWhnSuH+iroPGSLuKXUoo=;
 b=V/EZnj9ltELsGo++5TRYjmitM8avD3nAO+MTZeCSoN5MoRPk4XCr7EfYJvm+AxtXfbI+lA7sPSZmiPisQMHspyiil1MsvCsprvupOfSSiDAAXMFkEPGBIfIWxvceARzCBNJxrGeqepy1kGTA7yDYqtfvTpmQWEJc+79eY2besRI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 10:51:18 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 10:51:17 +0000
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption code
 path
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
 <20210415170748.GA4212@paulmck-ThinkPad-P17-Gen-1>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <3ef49985-68c9-277d-648c-53447ff602f4@windriver.com>
Date:   Fri, 16 Apr 2021 18:51:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210415170748.GA4212@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR01CA0072.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 10:51:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f83c5a-ea13-4c13-be38-08d900c5900e
X-MS-TrafficTypeDiagnostic: BYAPR11MB3448:
X-Microsoft-Antispam-PRVS: <BYAPR11MB344846D351F7C75EC09E63E3E44C9@BYAPR11MB3448.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vougl+US2kgnDQRqfpvBJqEl0S93XlIjXhLImwVCqAZsJooy0y+T+naGgYP8tOLKGh6VLPeww0AwrOlWmU5i7tfX2HjcntUf0LAi8nL6s8da6u9wVRjE1kzwDXcXl+aPmyPV3arWDUtZJaWR5WNGSfGjto0xUSmAl4JDdMP99FyU27L4zesqTzETTssW5EQzwFmKNMborfTIWid7beCKl92G8W2106Je8mydG6su/LFC2cwdu78JiEaCCHQI7epqNUhRy6RRzb4ARZ1uPj49CdKGv8DGbNaOwHNxjz7zorUEWySl25AqHy3MiH2yNyygGTmjV2Y/8pZaRuD9QS0BjjmcXRkacl4C7gVF1/3Wz8Yb3HpE5mCGnnTMJCRg4GYh4D85BR+WqBNr4kfZlEGw24D6A9cdZLF1JslT2fnGyTayuKsQoSqAS19PPZTaGTPKsrHNhhABEJ8Q+GO3yb+7suo1n7iH33J+uoo7WTOhKbAV8QjgyF3LgzuJ2IFqhjG+FuxVV5iOtJx3lXNCnhhAL+620nRpmWZ9ZPnSNBZPMx4m1WnjWnBrMvbzSwlo3Dv+Ks03Fnl8HIjZgTCGByRuEHRP/6UkxOwERjvhFlj1oVu7gJqjPLOEA0fRbXuxoXlHbyFkJ/GV1tvXL4wq2XE2+hAx/PVmwmssDh94nAk4BJhd/Ie7ZwBumR5V/W1NQcUloydTawGvd3hla4NbLCBbsZ4HxMhvOHD7cG6v7vJjD4O7Coo8B2QfffxcwirSmfpYqAo1PnOlqRAR+5EyUtXBZN7Hyaq2S7Pz4Ul+U8bLg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(6486002)(8676002)(26005)(38350700002)(6666004)(6916009)(66946007)(31686004)(86362001)(83380400001)(38100700002)(5660300002)(186003)(966005)(4326008)(6706004)(8936002)(956004)(316002)(66476007)(66556008)(31696002)(16526019)(53546011)(52116002)(16576012)(36756003)(2906002)(478600001)(2616005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnZnNndybmlDdHU1bVkzUVdrVUwzL1VEU2lROHV5Y01mZjI2bjA1azdRVW9s?=
 =?utf-8?B?S1grQ1pPcU5XOG9oN2NSSlo2TlBhdkFFQlpXUVc1MGQrTVFWNEZ2cS9vdkZw?=
 =?utf-8?B?bHpPc1BmMWsxYVN0MjJROFpTaUluNG5UVGZ1RmQ1clFaZmc5UGlwRkx1Rm9z?=
 =?utf-8?B?OGI1UXVjUDRyMHBkOGs3OG1ES2g3MVJWN0FiaEVZRnhYaFpxdTlZOXMvVFl6?=
 =?utf-8?B?Z2JZaWZNOUQ0eXpCWHR3dll5ZUZBWkdUU3hXcGhsN0NZWDJpS2JzcDU3eXdh?=
 =?utf-8?B?QjF4eG41SHhaS3lrTTdyWXBqbkQ5a2xsS0s4U1Eyb3prdEY3OHFMbHpsNEVS?=
 =?utf-8?B?SlUyS0hCQUdqc2xpaGcvY3Z3WGxneUVDTXZTSnZLaHlPMVlkMUdmeEdqUzFP?=
 =?utf-8?B?UFMvRTM3SndLemdTVU1VY1J6dW10aGhpbFN6NUxXUEVyUFVhczBhTERwVlpF?=
 =?utf-8?B?VlpWMGcrOEo5cnZldml1a3NYQ1V0bTh4V3ZoQmRCdTY4c2swbG42b0xQNmtG?=
 =?utf-8?B?YURzMkFIMWJ5MzI2aEp3bE9WUDVTU2RVTEVvaC9Id2M1QmdpbDZzU0t3LytR?=
 =?utf-8?B?UlhzRGpaTTNKQ2FrQU1uaDJndUkvRTc5UU9zczJ3a3RIZUlUZVFGRkJneWpl?=
 =?utf-8?B?RFdzR1hEcDFhcUIvYm5hRERoMldoMDlsVGx6c2wvYVpuYWZycFd2UFBhYnZ3?=
 =?utf-8?B?Njg0V0wwZjUvNjNpYk45RVRYQzdvSk1FTWpNZy9yUGxhMytXOW1RVFJLdFVP?=
 =?utf-8?B?b1pmckFoNmk3ZGNNV05pWnR4c3I1YmVkUWVKL1BCWFFQNXJIZloxK01BMllv?=
 =?utf-8?B?Um1SOWcvVkgzQjFkMHBCWndLOWlnVkREUnVZWCtDMzQvcTBHY3oyZnpQL1Iv?=
 =?utf-8?B?YUFFMUVMMkY5RG5zVzE5SWRlVGtVSEhoME9FWExaNThJNlgvUU5PcFVnOXhh?=
 =?utf-8?B?OHNpdWo4RXQ0YkdKWU1adDFmT2JEWitIb2VEbFNyYXViSk5pWmJPZWNGcHg5?=
 =?utf-8?B?WjQ1RWpCeWY3MXFTdlFxS0JDYzlmSFZUTUNlWjl6Mm0yTHIrSmUyVXhLNGU5?=
 =?utf-8?B?WStRU3F3YmhSQTVkRGVXZWR5dS80aUhyK04xbkExTGhYU3E5VVhJMjN6Ky9i?=
 =?utf-8?B?YjZwVzU0VDRqamp4WG9uTDBIVFZmNk1wNjJ0RjBndURKekFGZmpHQzE4NXdV?=
 =?utf-8?B?NFZUUG1kVjZNWWhFRkdHaXdNNU11SUd4WWhVYis0RGs0TUZBdG9qdTBkUHI2?=
 =?utf-8?B?YU51Y0VPNlVPbEp0UitodEV2bmJNaTk5MXJ3MnhsWE5wRDl5UVBRUmxiTVFv?=
 =?utf-8?B?TzJyWVY2QnBrS3EyTmRKaVhUSnphSnVQNGpvQ21kMkJiVHhpSUlqY1oyL3lY?=
 =?utf-8?B?NVdpZUthR2xMc0JKZlBJbUt4K29KZzdmK3ZqSlhPYmEyeGlXVHEramgvWFU0?=
 =?utf-8?B?NmZtOEVpVjc3MDQxV1Vnc204bDYvVXpsUkZIN2IzYU0wV2dyT1ovajB2OTVn?=
 =?utf-8?B?eFNEL0duQ2l1cUp3U1JPT2dIVXBtU29yRjdsSGZQODF4bFdENjAxMmkrZlpL?=
 =?utf-8?B?cHBUdFVZRlY2aFRSOVNiTzluLzFRQ0VPNkZmaTlaK1hQTDdzMmxiMjRVN2Ur?=
 =?utf-8?B?WklNMnhTNkxoRmUrWTk4TG5GQy9HWk5KTkZxeW5tdm0xUzY0NC8rV0RKSHlP?=
 =?utf-8?B?MER2cnIrb3Y5NGN5QlJ3VkFEUDZYbWRkcDZMeUprSVdkSVBtWldKV2tsRnYw?=
 =?utf-8?Q?+2o7SnCoORTKyqFJrIedeZFjw+EwID8xqmayA0i?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f83c5a-ea13-4c13-be38-08d900c5900e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 10:51:17.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzhSzi26dtGuSjwOdK1oklWYw3tf0Yxppmw77KaAlL8kMCsbvZoX0nICER04wZ3IbQpOBsLyLMcHp03+BZhB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3448
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 4/16/21 1:07 AM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Apr 16, 2021 at 12:18:42AM +0800, Xu, Yanfei wrote:
>>
>>
>> On 4/15/21 11:43 PM, Paul E. McKenney wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
>>>> Hi experts,
>>>>
>>>> I am learning rcu mechanism and its codes. When looking at the
>>>> rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
>>>> operation in non-preemption code path. And it has been a long time. I can't
>>>> understand why we need it? Is there some thing I missed? If not, can we
>>>> remove the unnecessary operation like blow?
>>>
>>> Good point, you are right that preemption is disabled anyway in that block
>>> of code.  However, preempt_disable() and preempt_enable() also prevent the
>>> compiler from moving that READ_ONCE() around.  So my question to you is
>>> whether it is safe to remove those statements entirely or whether they
>>> should instead be replaced by barrier() or similar.
>>
>> Thanks for your reply! :)
>>
>> Yes, preempt_disable() and preempt_enable() defined in !preemption are
>> barrier(). barrier can prevent from reordering that READ_ONCE(), but base on
>> my current understanding, volatile in READ_ONCE can also tell the compiler
>> not to reorder it. So, I think it's safe?
> 
> Maybe.
> 
> Please keep in mind that although the compiler is prohibited from
> reordering volatile accesses with each other, there is nothing stopping
> it from reordering volatile accesses with non-volatile accesses.

Thanks for your patient explanation!

I am trying to absorb what you said. Blow are my understanding:
1. "the compiler is prohibited from reordering volatile accesses with 
each other" means these situations:
int a;
foo()
{
     for(;;)
         READ_ONCE(a);
}

or

int a,b;
foo()
{
     int c,d;
     c = READ_ONCE(a);
     d = READ_ONCE(b);
}

2. "volatile accesses with non-volatile accesses" means d=b may happen 
before c=READ_ONCE(a) :
int a;
foo()
{
     int b = 2
     int c,d;
     c = READ_ONCE(a);
     d = b;
}
if we want to keep the ordering of volatile access "c=READ_ONCE(a)" and 
non-volatile access "d=b", we should use stronger barrier like barrier().

Hope I didn't misunderstand.

Back to rcu_blocking_is_gp(), I find this link today 
https://www.spinics.net/lists/rcu/msg03985.html
With the content in this link, I still haven't got the meaning of these 
two barrier(). I think I should learn knowledge about cpu-hotplug and 
things which talked in the link first to make sure if I am missing 
something, and then consult you. :)

Best regards,
Yanfei

> 
>                                                          Thanx, Paul
> 
>> Best regards,
>> Yanfei
>>
>>>
>>>                                                           Thanx, Paul
>>>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index da6f5213fb74..c6d95a00715e 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
>>>>           if (IS_ENABLED(CONFIG_PREEMPTION))
>>>>                   return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>>>>           might_sleep();  /* Check for RCU read-side critical section. */
>>>> -       preempt_disable();
>>>>           /*
>>>>            * If the rcu_state.n_online_cpus counter is equal to one,
>>>>            * there is only one CPU, and that CPU sees all prior accesses
>>>> @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
>>>>            * Those memory barriers are provided by CPU-hotplug code.
>>>>            */
>>>>           ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
>>>> -       preempt_enable();
>>>>           return ret;
>>>>    }
>>>>
>>>>
>>>>
>>>> Best regards,
>>>> Yanfei
