Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1994C433ED
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854C8601FE
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhDORBx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:01:53 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:42817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233343AbhDORBv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:01:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiOvPzb02PAhhLCAhpAohu506wQC90uBknXqHHCmee9YxSl1brjIM/YFdsprkfk8qZy+cuQPkcSvixIa1r8wp0S3uEFuxOLmdre1aBZBgDO0dimNY6TDnHvC0s91Fi4Qb7CnMko7WLt55vsfPMtmmWoleXlRO2pQPNjOcZmOej+J1Zit2DbJy+qdnAq8XRl/SvicIuOQZhl3VCY0IXeBG8rgwITTVRynu8WMWsmwRfG3l4mIP43/tqYaPsuMP/OnduNXZynolZgSWtD6E2VGyA+6kVXf6j9b+SYWef9ZcFRihTd7QplSMP9sS/rqPP3Mr+Nu2nCb36vssdfPJitEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC2spq0YF9mYc0gNlUTA0VxqLh7e/3RIPV4qM6zB04Q=;
 b=dWPBcWHBQbxw1zFO4wDWdxzzy1m6pOufqA3unvg2WsTRk5aa15BAAbPlde7ExWwAQ3458mLYGV0f1ug6OCwC/Ea34uHrLuBIGJVJFTIbmw9Pqeioy8MB435RfuzbwYhRaLjV+8ynMYoy4PmCp0OUcDfmay5NQ5l7mEVB/7k/YU9f0lD+MhuHedIij7yT0+le9Q9ZI1ZoI30d5/UHQ1KWvWrz+RwiG/zeRg9yZ3IdIpgabf813rkAruld2UBHndJ878hRCsx0v1B1RGZ/CB3FrrOyOzZjVKRuFVdvvaQdvqKXVhAFJdT/cz4pRfyfPqWJX4eHEoNYKdu17iwrA9Tfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC2spq0YF9mYc0gNlUTA0VxqLh7e/3RIPV4qM6zB04Q=;
 b=pU2nYPMtzeUkx0Eh17NuxBf5ACn7r8prEoUdwXWHlq+TAmzM3pTIauyVKxBVPs9lqGUW2cmpMGf42mt1fj8nrv6sJwbSkYUZMBVfrJubPKpfnDWlZygPXvgqojbsmazCT/SWziORdBM+oym4Xy15pFG3vzixEZOsk5zuldKZSwQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3669.namprd11.prod.outlook.com (2603:10b6:a03:f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 17:01:25 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 17:01:25 +0000
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption code
 path
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
 <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
 <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
Message-ID: <aa5ea94b-fe0e-bc0e-5a8c-627a206e3efc@windriver.com>
Date:   Fri, 16 Apr 2021 01:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <adae433f-f886-32e7-2ebd-192a624d7586@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0086.apcprd04.prod.outlook.com (2603:1096:202:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 17:01:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa36e92e-cad9-45b7-bfc0-08d900301a2c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3669:
X-Microsoft-Antispam-PRVS: <BYAPR11MB36699E8919925B1A495C789BE44D9@BYAPR11MB3669.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sgwha3yLvXzKfPZtOYc26mAfOD1CwxCh86IN7g2I2Rw5zQtLkagyOmOhRnb0VXA+PcGIm3D3AUYdZ1oLznb9hIH4KXTuHmdFK8nlsixj6nyWZIUY19RljjUQI9B2STIgDNlHvQhfjwpNV3Ka2nNfl3Mo0n9fh9XRC6+MfT/zibRyZWcTORKSgDAD+zt0HB2JU8HLa9wB4XYkdloEIow6GGlt2YLFZStIKVXEFwaOHN2JF1e/PkuWCPR/y/QdHnWXoJmEcpib7E0UynvecTo2/8VWG1c/JRH8kISWPXybpTbUTYLnC2/yKMYYc4oIJFXpgHqRUGIaVQq73xiZD/KhEWN7eG0SzW8A7lMsCV2cRLIAtM3C0qIZF/Xbq6guBxLdvdr611k6VmAfaugzxBvZy689z3a6sN3dyduB4WLWnREmig0I+D20q/02nuB5YVy0IxOcoHGaz4U9IW1g1B4W5thwDxRSqNwcOXGTYY+itjVjjJTZDX3ZeFnV4crks9U0l3G14RINpJA+a5T5QE5zAtC9XpNWEZE3jwkVeTOiXSHVyBeVG5eUKTaqbarWsmaWRTv9+GDIt999KkbzydbKz9Jp1ynOT5mET7GDDfwoC09VThN3o9ZMRzniK52adG7KJaQJnmIRLKkLKmr5lIJrqgxr42DzrfykRbLrQXphH0MSdxMck/5iawUQA8YDPnNTKp52C0ZD1UQxwLfA5hTBUcMbMKV2fvFytj2GQWbgzVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39850400004)(38100700002)(38350700002)(6916009)(16526019)(86362001)(478600001)(186003)(26005)(6666004)(31696002)(6706004)(83380400001)(8676002)(66556008)(5660300002)(8936002)(2906002)(52116002)(4326008)(31686004)(956004)(66476007)(2616005)(53546011)(36756003)(6486002)(16576012)(66946007)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFVrWjBURDYzRnJiV0p3Y21lVDRqSlJPNU5nRDR5aGYyR3ZrK0padlpKK0c5?=
 =?utf-8?B?M0wwVzVMY3VDb1g3SjhQalRyWnVQRThQNGlPQjdDcUxVNGQ2Rjk0cEFqWGVl?=
 =?utf-8?B?OVoyWDVxUjN6K21lRzA1UlFRZ2ZMMUp4a292R2lxOXhPSFVkMHd4a0hrYjZ6?=
 =?utf-8?B?OUJ0eHE3emNpZGZhYWRjenNYVDFWKzN4cjdVWHlET2hWcHk0aUl0bVBoNE5o?=
 =?utf-8?B?Z3pMUm02QXRLM01sTUpVMUp3aEQ4UytXM1JHY0hHSEszeUVqUUtGNGhHVlEx?=
 =?utf-8?B?Y2dvS1R2OUp2S2p5cDNkNEtHZk1YMEF0OG94TGRUT0NjNTkxWE9OVUp2U3VZ?=
 =?utf-8?B?azJsaDhvL3ErOWxuSG4zRGprVlB1RnN0eHo1UGp4NE9pT1JQdW1LWnVHRXlR?=
 =?utf-8?B?NmpCRlVPUWNDbmFweXVCQVlmMUVtZGZDclpicEdVMmV4RGtySUR4bmF3ZkJq?=
 =?utf-8?B?UXFSaytjS3hJd2IvdzlKZ2NQdXR0VDhKRVNRUWJCOHMzR2wvbU5RZVFZMytK?=
 =?utf-8?B?NWtqZUJBdVdtY05CbDZWUzZVNHRuU3JKQ2dmcWdXMzBNanBPODZNVGF3OUpE?=
 =?utf-8?B?QUVPK1RjR3lFblZEQ3VTNm1qSXFpRGlXeFpzTEhJVFB6ZHhFNWNGbXNVNUZ4?=
 =?utf-8?B?N1QzUXVIeW9BbjVSUlJndUlYZmxDeEFMWmVRMFhlTkhWU0FEZ0RXN3d0aXdV?=
 =?utf-8?B?YXJJNkUvc2puY0Q2UkpFRXdVczYwOExuN0FFc3FTRFNJMmNhUTljL1Z4QU1V?=
 =?utf-8?B?UFFqOVFVdlJKZEhTSmFLdU5aOXRYY0VNaWlUVW1rd012RGh3UEpWaGJ5N2VQ?=
 =?utf-8?B?TXN6aks3ZEhiUFN6L2pUSnZ0OXU5YkROTTF3eDgwQWV4dGFWNzVNYzhwTTlx?=
 =?utf-8?B?VzRuYUk3aHMzbHMwME1kTzF6QXp4RXRFNENPVkZ2U2hudmRuejh5L2ExczRM?=
 =?utf-8?B?a2hZK2pyYnQ4ZjNLU0xNY1ZCTEs4a1BUbG8rUmJuUmdJTjFpYWJUbzE3VmNZ?=
 =?utf-8?B?eGFzem8wZ1JibkpWa1NYZFlqOGwrQTByMWZ0MGx4TzF1K2xwSUVtSVgxT3ll?=
 =?utf-8?B?d1pQbUY2SWhpU2k4YU1BWFRLZG5YeFVFWFJheVo1Rmd0M2hXS0VSM2tmSXRm?=
 =?utf-8?B?MWFmQndkUVV6bVdhYkloODJwQmpGU1FBZ0Q2QjFDN1JQc21oQ1NSSnNEbEdG?=
 =?utf-8?B?WXE1bkJraEwzVlk1NDVWbHFabmlzZVZXNXNBZVJrQzM1NU5UdlJ5bEdyRVdJ?=
 =?utf-8?B?a2VPaFd3SjI3Vm9IbHdZTmFvcm9WWVZkVXVXdVBldGIweVhVcHUvUWgrTUg4?=
 =?utf-8?B?NWtHTE9qbU9scnRTdTExTm5ubkFXREF3M2tUSXpyOUcvbjZNVVdYc2NGMnFj?=
 =?utf-8?B?czBNTlFNOE5hTmVPUFpNQ0Ewc2lOTm9GN20wOEtMTVlGcG9YVmQ3K1hKQ1di?=
 =?utf-8?B?djdOVm9lendKdE0vOGdhV2hSMFZsdlhTM3hrK3FJWU9JSmRUUmdXemE5U3U3?=
 =?utf-8?B?aWQwRFBZYWNET3puZzhTTUhDK0RxdmwrUDhORzlDUG9SN3RZaEdPZm5WSC8z?=
 =?utf-8?B?MUR6SzFvSWlURG0wZDIzTkg1YUVzNWFMbGYrYStYMDdISlQxNlI3SExyRGQ0?=
 =?utf-8?B?RS9XSi9qWkZmVE9YcEZIdWxTL0x1ei9HUWJJa04yL2JsWkJZNDVpb3kwelhO?=
 =?utf-8?B?Q2Q0K1dHWmRDRERLL014TGlscFFrWUczK0JTVXpEU2ptak9qU0JTclFsczBB?=
 =?utf-8?Q?ysYjwkJNfuJ3SUCvEorh+eTIAUaXHuJQyMNdieF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa36e92e-cad9-45b7-bfc0-08d900301a2c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 17:01:25.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FelBqKLJSFBVJru5MWaIOnHuH4l2X5oMl2dplBlOzppHgYrlAFSaEuXCnFfpp1V3XqqQp5IcNz6jZf6d3RiUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3669
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 4/16/21 12:18 AM, Xu, Yanfei wrote:
> 
> 
> On 4/15/21 11:43 PM, Paul E. McKenney wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
>>> Hi experts,
>>>
>>> I am learning rcu mechanism and its codes. When looking at the
>>> rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
>>> operation in non-preemption code path. And it has been a long time. I 
>>> can't
>>> understand why we need it? Is there some thing I missed? If not, can we
>>> remove the unnecessary operation like blow?
>>
>> Good point, you are right that preemption is disabled anyway in that 
>> block
>> of code.  However, preempt_disable() and preempt_enable() also prevent 
>> the
>> compiler from moving that READ_ONCE() around.  So my question to you is
>> whether it is safe to remove those statements entirely or whether they
>> should instead be replaced by barrier() or similar.
> 
> Thanks for your reply! :)
> 
> Yes, preempt_disable() and preempt_enable() defined in !preemption are 
> barrier(). barrier can prevent from reordering that READ_ONCE(), but 
> base on my current understanding, volatile in READ_ONCE can also tell 
> the compiler not to reorder it. So, I think it's safe?
> 
> Best regards,
> Yanfei

Hi Paul,
I objdump the function rcu_blocking_is_gp():

after dropping the barrier():
ffffffff81107c50 <rcu_blocking_is_gp>:
ffffffff81107c50:       e8 7b 2a f5 ff          callq  ffffffff8105a6d0 
<__fentry__>
ffffffff81107c55:       8b 05 41 fe 7c 01       mov 
0x17cfe41(%rip),%eax        # ffffffff828d7a9c <rcu_state+0x221c>
ffffffff81107c5b:       55                      push   %rbp
ffffffff81107c5c:       48 89 e5                mov    %rsp,%rbp
ffffffff81107c5f:       5d                      pop    %rbp
ffffffff81107c60:       83 f8 01                cmp    $0x1,%eax
ffffffff81107c63:       0f 9e c0                setle  %al
ffffffff81107c66:       0f b6 c0                movzbl %al,%eax
ffffffff81107c69:       c3                      retq
ffffffff81107c6a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

the original codes:
ffffffff81107ba0 <rcu_blocking_is_gp>:
ffffffff81107ba0:       e8 2b 2b f5 ff          callq  ffffffff8105a6d0 
<__fentry__>
ffffffff81107ba5:       55                      push   %rbp
ffffffff81107ba6:       48 89 e5                mov    %rsp,%rbp
ffffffff81107ba9:       8b 05 ed fe 7c 01       mov 
0x17cfeed(%rip),%eax        # ffffffff828d7a9c <rcu_state+0x221c>
ffffffff81107baf:       83 f8 01                cmp    $0x1,%eax
ffffffff81107bb2:       5d                      pop    %rbp
ffffffff81107bb3:       0f 9e c0                setle  %al
ffffffff81107bb6:       0f b6 c0                movzbl %al,%eax
ffffffff81107bb9:       c3                      retq
ffffffff81107bba:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

umm... It did been reordered by compiler after dropping the barrier(), 
however, I think the result will not be effected. Right?

Best regards,
Yanfei

> 
>>
>>                                                          Thanx, Paul
>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index da6f5213fb74..c6d95a00715e 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
>>>          if (IS_ENABLED(CONFIG_PREEMPTION))
>>>                  return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>>>          might_sleep();  /* Check for RCU read-side critical section. */
>>> -       preempt_disable();
>>>          /*
>>>           * If the rcu_state.n_online_cpus counter is equal to one,
>>>           * there is only one CPU, and that CPU sees all prior accesses
>>> @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
>>>           * Those memory barriers are provided by CPU-hotplug code.
>>>           */
>>>          ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
>>> -       preempt_enable();
>>>          return ret;
>>>   }
>>>
>>>
>>>
>>> Best regards,
>>> Yanfei
