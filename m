Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA54C433ED
	for <rcu@archiver.kernel.org>; Mon, 19 Apr 2021 04:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C48461078
	for <rcu@archiver.kernel.org>; Mon, 19 Apr 2021 04:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhDSE7j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Apr 2021 00:59:39 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:32262
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229980AbhDSE7i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Apr 2021 00:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jadg48ybTkItxBsaWp8zW5mMmzhD8EvP4F9btbKZprWa7Z2Y8JK7P2CeWAUtgt6Os5duS6Nh3gpJG6yOBRtdjdWTeASpwf4bakvKXppWpWOWe6tRHgJVRmqwiMslPVu7QlwN881zpP1CAWSt3WeyDVVAiH0dBlU7FARdNruxJTuD7vHIHIIjOIX1uz0jY0HvzvpledJ31UZ62E2BlYImF2zLl+4vtp5feIDFngisuAFxenOf4+DGhrPZQ7zgsKAs3i6PrFloYXj45hAhMe2m0x/ZNeY2CquZi3oF/eArSNMJywLXXs29p7p+Pm/nkQRURBdYIlNFEE3abDKqWzxlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUf6r/x/HFx+A30PlLOJ1FnAtgvUW3i3C5bjtYMxCwk=;
 b=M0cuu3NS0kIuLD9PqAnJ6hUJD921Q8yjNGkaUtI20wBQL/UNh/tjTlCc5hOzDod2k44fIdgFlDLCAN8JSPAAwNV0Bi6wKV0dDyK2siekWuEGdzaPuyfQFWmZJrOsvQ7iM2YHhtOKnOvNlkYEa9p3HpPgys/6ABAfaEQSeGvHd60UFnUfTs5u+KiNy0sfiHvK64/P9cAOfkamPtzvm8fkIIIjj9sk53n1/UNglnk5jJRTCrjn6G996IauYJQGM0nEC4PiEDZ+i/n9uC51xemQGNOABPFJi1gfwXq1LaFnR0RgKJX2ghguc9D4ec3QRG0Y37dkJuZ0zeRS28qC1trDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUf6r/x/HFx+A30PlLOJ1FnAtgvUW3i3C5bjtYMxCwk=;
 b=JqXZaGg5LSGQDFWrKr+dAQdJ9QS8V00GuWe9qFuDOx+VW4lCWrNauFbijDKGwC4kXZSUlsnO+K/YnKx3uC/EcgSmkL3g5V2j4u1pbpWyOcZihzxelqZnsaMNYfvh92ao4UKp/5E18/+BAd+JH4+ktde9h07jWocwcRjjIwXDjo0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 04:59:07 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 04:59:07 +0000
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption code
 path
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
 <20210415170748.GA4212@paulmck-ThinkPad-P17-Gen-1>
 <3ef49985-68c9-277d-648c-53447ff602f4@windriver.com>
 <20210416172629.GH4212@paulmck-ThinkPad-P17-Gen-1>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <b5c91db4-c1b6-3849-d5a9-89ca07d2d020@windriver.com>
Date:   Mon, 19 Apr 2021 12:58:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210416172629.GH4212@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5 via Frontend Transport; Mon, 19 Apr 2021 04:59:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f716c6c-e203-4e59-33b0-08d902efdc93
X-MS-TrafficTypeDiagnostic: BYAPR11MB3254:
X-Microsoft-Antispam-PRVS: <BYAPR11MB32548BBC5DD3AC8065560A2BE4499@BYAPR11MB3254.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPkNFsL6ymFsE4XWq7Q5agkI/vObyKBsroDOGoS42HOEA9sPF14tIoKRFF23FH3fKdtkOG9aqIJ2BA0EgOkJuu7EMlKOIPAB310kuO0pA8L9jL9hwNCbs+cLDtaK5827/xfHDcrMfpXxsztkuvHaAh6+Z0QsZHf9aka3KR0vwAROw8v9HMhRcO5GxlWVe2O3Pp6twgHgmvLKxu1rDfadGacFgVggPFSouapy6bcn7jlrEGOSEOIYN8MshEuyPuZ9ADiJxuA9ukBvL1WYqsSbKX49SanY68/O5iJ5Mwzr9qXMtQEKZIhjOnDdHSlxQifInk/POLAU+5JXYc8pXzROq+3wtu8SBYVciul5IqLICFFYmHzmYwPCwFmF9uvNAY55Pw/xmQMqzndF0/wqeE/lW+u/d5IYj4FJMQuA6jynaU5WWzkyPUEbf4x2wGyEHI0ZwCd/4NcVe2r6FCyxd6JJDaYLTwYulkmoRBRVCGvkA6Ikv8gqwmY+/Nyij9v2Rm4zQZIAyz5QPtAIHlDZ4o1jgvJfcwSXeFCUpVMiVBxrheW4bM01lBbps/zrfZ12PBB10bgubZppmkyl9E+LpqVt3EGQMhctf2zB18+kq3Ajd3u5sSMg2VVwVzWh+h4JCJ9l8bO2tx4bZEXXdFlMHy3h7rTouPflqYVxZIBQo/RJzpvHARKNPg6fIFHnXPh+rWcHxcD9QSBqhWejeTnO39FNjbA9H4Ijvp6vpyptn3QzinJfk0xnAyNSit8zT7Xuctpkn712mUY4u8U4L1TRs03HjrwHe5Bnx2NuHhIEAL7oSnB1nx5s0AcJjuTKjhMQpfqb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39840400004)(396003)(8936002)(6916009)(83380400001)(6706004)(52116002)(53546011)(66556008)(8676002)(956004)(66476007)(38350700002)(38100700002)(6486002)(2616005)(2906002)(16526019)(66946007)(6666004)(26005)(186003)(86362001)(31686004)(4326008)(478600001)(966005)(36756003)(5660300002)(316002)(31696002)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2VnQ0o4eWlzNnhLY21aVTZ0bWVralAvdUp6OUlSWFVGQzRqM0ZJR0p6a1F1?=
 =?utf-8?B?R2FmS1ZMSnpmMEJvOHQrL1ZwVUFGaS9JUGgweHdpcklJNDZoZFhQS2pXU05i?=
 =?utf-8?B?dnV0TVhDMjVYMGVlS3dMbmJvVWRxTS9Bajl5OG1GdW40alBjaDNWaHhWY1o5?=
 =?utf-8?B?NElnQWs3OHRoUU1JYWtNZWRHZHg3cllMaUU2SjJZcnd2OGc0YkJCTmdhMVlk?=
 =?utf-8?B?WTE2dHJ2eW95c01QSjNCcmljWWQrTHcwRkZPVFZ2aUVCOTFwaENobVpCZ001?=
 =?utf-8?B?SjBkcmFURTdBa3l1S3d1ZFk3UHcvZzFEbFdIZ2Y3SHp0eVRNOFFVVGJwRFRC?=
 =?utf-8?B?Vy95THVVMmpsdlRXdWFvWVBOL1RFOEl5K1ZzNCtQbEd1TzZmRlZIVlRWTGQ1?=
 =?utf-8?B?cnM0cGlVSmFVRkp0NlFiZXVUNHpXbnpmQmVhTU9KQW5RNEo5cHNPcjVuWHNN?=
 =?utf-8?B?MWd4V09HUmJ6NzZzMXZNKzV1OHdMU21QSUZOd1ppamdhNnZ4bjJBME15QzNx?=
 =?utf-8?B?eDgvaWY4RjBIeUZCMGhDWVM4MDFUL3dPYnhwcjFrVG1TRlZPd2FjcFFUYW12?=
 =?utf-8?B?RXkvV1BTLzAvTGNWdktoTFZxWEdjM3diQjJsV01URXZTMUZwNHZCNCtQYzVo?=
 =?utf-8?B?TzNySzNTMUppa282MnZqZXFsQy9XS1hhVjJHMWdlKy92MTFrUml4VEh2S1d4?=
 =?utf-8?B?WjNyM0pGM1kwZC92ZnhTVkRXcVd1UVJlaFJRdllnaGVURFQvaEpUSS9sbHpX?=
 =?utf-8?B?elBrQ3I5K1pXU0lTRFcvc2hyd0d5Nko4WTRnUzBxTEovZ1g0ZG5XbURwd09E?=
 =?utf-8?B?VkdXZDRwYXNuUThpYStHcXhyQjc1d2lwVmtFOHNRR0V6L2o2MEcxenhXVzVp?=
 =?utf-8?B?d2lqVTRuVGpRTjBqTUNDZk9Ga2MrTUNGb2VGTzZteGVvMFdJZnF4eHExb29y?=
 =?utf-8?B?VTVxSVRKUzdvbGdqNVVORUdMYWRoaTkyMHNkREl2RjNtRXR6VTlkSTE2R2cw?=
 =?utf-8?B?WHRJWFZQQng5RURTbEUzNE9qYUZyYitIRHU2NTVpZXpRalY5S3pKUWtLNndB?=
 =?utf-8?B?Z1YxZ2VmVFdOeWZPTEQwSUNBRDU4SkV0NHdTYjA3dWVTTnlRc0U2UklUZUtu?=
 =?utf-8?B?djE1ZFZzTDI3VGFpWjNLRjFTaTFmbnNPcHBld1p3RFJRV3k5MUhDWHp3OUdD?=
 =?utf-8?B?T2lLZVVleXJ4VDNvdzhteUgyRUl2S3ppMDV4TGRrZlphMWZaVjVJQkN6anRs?=
 =?utf-8?B?eUVOaWlVU3dPbDVLYWc0WFZRelRaYmEvOVAzNEhnSWR4N0xEQmd3Rmp4eVZZ?=
 =?utf-8?B?dmRISkVDNUFBdXZlVVBtdWR2Mzg0OUJ2c21pTFAzYU1icW1zQkpLUmorZ291?=
 =?utf-8?B?VjJ4bTI4WEs3dlkzSzJQL1dlaGhwUEFiaTdRdS9hQ24wVzJIWmtwOFM3NzlQ?=
 =?utf-8?B?SGtIYXZJdzlpOXIrMzhmUXhrL2FsSUlrdWlVRDFYUFQwY1hoVnZLdWRnKytY?=
 =?utf-8?B?Ni9GbWVrK3pUMUJBU2xCVlo3VldkaFhBaTRIaXF5Nm1WZjlTdERaSFZVbURE?=
 =?utf-8?B?MU51bmJjTXc4aDNmZ2MrTWxtUy9JM0RQTzBDZTE0d1BsaGhFUHkxR2phTU12?=
 =?utf-8?B?YmN0Nk53cnBBdk9NbENPOW5Ycklmd09qUEM1N21BdStiM3czN2NybGkwRmJ6?=
 =?utf-8?B?WjNpelBxVFExNjlROGdOV09hL1dQVDRNa0JaZHB0ejFldUtOTi9UVjNxWlEy?=
 =?utf-8?Q?BXWW0/WrOflnAIX0pTGHNoe3UPW8Vc8arUt+aHQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f716c6c-e203-4e59-33b0-08d902efdc93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 04:59:07.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR8wvasFnssHJAOMRDlPectyhWEMAqrU7Eu2/sJpp3DfUdE/4ExL4gosrAHG3sbBJ2Jcm0pjdA5WwgYE65q0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3254
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 4/17/21 1:26 AM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Apr 16, 2021 at 06:51:10PM +0800, Xu, Yanfei wrote:
>>
>>
>> On 4/16/21 1:07 AM, Paul E. McKenney wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On Fri, Apr 16, 2021 at 12:18:42AM +0800, Xu, Yanfei wrote:
>>>>
>>>>
>>>> On 4/15/21 11:43 PM, Paul E. McKenney wrote:
>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>>
>>>>> On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
>>>>>> Hi experts,
>>>>>>
>>>>>> I am learning rcu mechanism and its codes. When looking at the
>>>>>> rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
>>>>>> operation in non-preemption code path. And it has been a long time. I can't
>>>>>> understand why we need it? Is there some thing I missed? If not, can we
>>>>>> remove the unnecessary operation like blow?
>>>>>
>>>>> Good point, you are right that preemption is disabled anyway in that block
>>>>> of code.  However, preempt_disable() and preempt_enable() also prevent the
>>>>> compiler from moving that READ_ONCE() around.  So my question to you is
>>>>> whether it is safe to remove those statements entirely or whether they
>>>>> should instead be replaced by barrier() or similar.
>>>>
>>>> Thanks for your reply! :)
>>>>
>>>> Yes, preempt_disable() and preempt_enable() defined in !preemption are
>>>> barrier(). barrier can prevent from reordering that READ_ONCE(), but base on
>>>> my current understanding, volatile in READ_ONCE can also tell the compiler
>>>> not to reorder it. So, I think it's safe?
>>>
>>> Maybe.
>>>
>>> Please keep in mind that although the compiler is prohibited from
>>> reordering volatile accesses with each other, there is nothing stopping
>>> it from reordering volatile accesses with non-volatile accesses.
>>
>> Thanks for your patient explanation!
>>
>> I am trying to absorb what you said. Blow are my understanding:
>> 1. "the compiler is prohibited from reordering volatile accesses with each
>> other" means these situations:
>> int a;
>> foo()
>> {
>>      for(;;)
>>          READ_ONCE(a);
>> }
>>
>> or
>>
>> int a,b;
>> foo()
>> {
>>      int c,d;
>>      c = READ_ONCE(a);
>>      d = READ_ONCE(b);
>> }
> 
> Yes, in both cases the load instructions emitted for the READ_ONCE()
> macros must be emitted in order.  The underlying hardware is free
> to reorder.

Got it.
> 
>> 2. "volatile accesses with non-volatile accesses" means d=b may happen
>> before c=READ_ONCE(a) :
>> int a;
>> foo()
>> {
>>      int b = 2
>>      int c,d;
>>      c = READ_ONCE(a);
>>      d = b;
>> }
>> if we want to keep the ordering of volatile access "c=READ_ONCE(a)" and
>> non-volatile access "d=b", we should use stronger barrier like barrier().
> 
> Or an additional READ_ONCE() for b or a WRITE_ONCE() for d.  But again,
> this would constrain only the compiler, not the hardware.
> 
> But this wouldn't matter in most cases, because both b and d are local
> variables whose addresses were never taken.  So someone would need to
> be using something crazy to poke into others' stacks for this to matter.

Agree.
> 
>> Hope I didn't misunderstand.
> 
> It looks like you have most of it.
> 
>> Back to rcu_blocking_is_gp(), I find this link today
>> https://www.spinics.net/lists/rcu/msg03985.html
>> With the content in this link, I still haven't got the meaning of these two
>> barrier(). I think I should learn knowledge about cpu-hotplug and things
>> which talked in the link first to make sure if I am missing something, and
>> then consult you. :)
> 
> That sounds like a very good approach!
> 
> Keep in mind that I am worried not just about the current state of
> the code and compilers, but also their possible future states.

I see.

Thanks again.

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
>>>> Best regards,
>>>> Yanfei
>>>>
>>>>>
>>>>>                                                            Thanx, Paul
>>>>>
>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>> index da6f5213fb74..c6d95a00715e 100644
>>>>>> --- a/kernel/rcu/tree.c
>>>>>> +++ b/kernel/rcu/tree.c
>>>>>> @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
>>>>>>            if (IS_ENABLED(CONFIG_PREEMPTION))
>>>>>>                    return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>>>>>>            might_sleep();  /* Check for RCU read-side critical section. */
>>>>>> -       preempt_disable();
>>>>>>            /*
>>>>>>             * If the rcu_state.n_online_cpus counter is equal to one,
>>>>>>             * there is only one CPU, and that CPU sees all prior accesses
>>>>>> @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
>>>>>>             * Those memory barriers are provided by CPU-hotplug code.
>>>>>>             */
>>>>>>            ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
>>>>>> -       preempt_enable();
>>>>>>            return ret;
>>>>>>     }
>>>>>>
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Yanfei
