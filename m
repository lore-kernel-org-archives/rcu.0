Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D3C433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 04:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E44261176
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 04:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhEPElN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 00:41:13 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:34785
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhEPElM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 00:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvVCXyJDKzS6gS8kNJXLFaT8g35C+Bh+1cHHB8B2xupZ4quszgfPjGgI0Q7UGTE0mnRA2Y+im/ZgIEaV0+s2xEhOwyMXaVhdjUnRqHCG9AX7ecKW/AmS2kTNbrkQ+ZP6FCz7bzYI4XbMX5gTEIg4KruF/UJGRP0zkv5ja25XX63LFWiAP37vUMllKk6/1r6l0HQFdkx1+XCGKXw9xExZc1yPbiOP0SWARJqUtGfgiF59jzbxSZtwim6kL3in+4O5DxNPQAdx0SCvIb8/MtVeCE+du/Xx9BcT2wzVyG7pKIOgFc1Q69X7c6nrOJ/Q/wfMj4kmuRhLpfzNvA92Z5/W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VXd+SLGJC+IPLckGMlOjyWWyfHVO3s1feQu/6Ep8IA=;
 b=NXnt/VFSqzikZfp3YQ2jcYVx8PtOaSILGasMhI6jxSwk2F8akjkEwnIF/neU2+VANK7Rfsr//EhsMb5DP+TcxHLJfZvYOtHmUhmL8wHosRG8IDpos8ZgFuvnC+W+WM33bQY+1TebTDletL9BHZtvMz+t7qtEp22m+L4NeV//+nyur87+T2fo9Arxroj4Edeso/ar7RliYN6eIY96utmnRb/SWERih9DbGFYVLiUvEnKEwkTn5he002Gxt3VpqHBO8LBpu+Of6YjGJW3obqltKTWIihc4EraN4ZEWNNCpOcvkH5nz8d0UO1xcnBaS8ndNAo1X7XjAroyw+RxPoDMCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VXd+SLGJC+IPLckGMlOjyWWyfHVO3s1feQu/6Ep8IA=;
 b=m9Kq2T7rCrInaLDZGkUYbJenb7oOkFeEzoKO6/TZmSDWBvkUS+qf1/xOjTzeV31O0rLK1AhISEsAOGZsA/wvr9qU9tIVmig8Zo8mA7VCNhoeyBkeWi9j8Ez4tDyYLp1FGfe19w7VVhw+h8HZSH11HskwhMKqQvBqDi0Sjv/Tvr8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sun, 16 May
 2021 04:39:55 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sun, 16 May 2021
 04:39:55 +0000
Subject: Re: [PATCH] rcu: wrong stall log when only one task blocked within
 RCU read-side
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210515164511.3547618-1-yanfei.xu@windriver.com>
 <20210515183609.GA4441@paulmck-ThinkPad-P17-Gen-1>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <b02cbbfe-42e7-92bf-ab3d-88acc41e3337@windriver.com>
Date:   Sun, 16 May 2021 12:39:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210515183609.GA4441@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.2 via Frontend Transport; Sun, 16 May 2021 04:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7c7d55-cb84-480e-12df-08d91824a6d6
X-MS-TrafficTypeDiagnostic: BY5PR11MB3975:
X-Microsoft-Antispam-PRVS: <BY5PR11MB3975885BCAEE0C9546F517F5E42E9@BY5PR11MB3975.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFZFfw3carLc1PC7n5HNaQsXPYddee2mz2gRV/codmwgSIDxpSRm3Itr2foxVciCNQpzx6xDxkPu3ru8CDkRjW+X2rQK4BopFQ04CcKdsz19smlLEyntvQQBexRibpTW4cUfF6d1vlpQbBT64wpmsZU9Ne+97VZIFTBpJUCzQDYaLOiuKBxz5OrZ4Ct48CwXNOd2Ie6dvMSnqoBHSMJEAwhbNS6x2uT5JOn6urrR/l+ARFshMIRtck5SXr6aq95TtWi4tc+THiNoqtpcUp0s7qV1mUgHWHfvBMOPbRccnpaqpvPvByzi23KohQB4NMoI9CHozar7/grpza8oZL8Cot4ChuBsVRLrH8HS6NlJ0gnMvdFqqoNsBgYK05ZaUXU+DYBkpwr9OmTgqxtcpw0BJ3dXB+cpb1jT1n4bg6c/ZZ1Gai0yXiK/z7fGKclztMnTu1kX7OOTcQOYuuernKHUmVK+sONWiTSeEU0SmvAKrFvJ4COZO9h+N+apuyqLDZK4fDUCTfgcIPX1HAB6lAEhqQ+CVijtDiCK8P0PgzVZn6O8W/ZfPyOWKE8TBONKBjBwIEyaTb40f6LDvE6Zf6VxdbNDi7wooOSMkNvebzg3C44XG6oulDsFJ+k0cZ5gLqOL0KgP03HGu1KZvE+mVosts/BniVtA8B5S1LezKMB6i7hG7jV8uZzAu67sVVl5Vcw49ndqOlD5jBXcvexZbNRC6h6wjQ3vfJcQNtj0QZAsDMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(366004)(346002)(376002)(396003)(15650500001)(86362001)(53546011)(38100700002)(52116002)(38350700002)(26005)(83380400001)(6486002)(6666004)(31696002)(6706004)(478600001)(4326008)(2906002)(5660300002)(16526019)(186003)(8936002)(2616005)(956004)(36756003)(6916009)(66946007)(16576012)(316002)(66556008)(66476007)(31686004)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MG4vczdFUWtUZ1F1WHdocUZJWkxpWmg3TGRNTkVmTkxxVjNjSWVBSkEzODJ1?=
 =?utf-8?B?NUYwQytTYWtOWlNnV0MvUzRGMDlZWDdHaDc3d2R2SG5tMnU0RW9XMXR4NVdK?=
 =?utf-8?B?cWZsT2NFbzBPQmd1SUc1RHUwUHZyOWhuSlVaVkphWFU0Ynp4WTBtVWdzUW1a?=
 =?utf-8?B?V044Zjh5cGlaMlI0a2dVZGpkNmVzNnB6QVEyaTJvTnBRSVo4YjFXYmRsWGlS?=
 =?utf-8?B?N1c3NnN5c3p2bVZzb1hPSDR5a1Y4V3ZjYlNwMWJKSEhaa2ViYnF5eWtyQ0Fv?=
 =?utf-8?B?YVBlR1JvYUpoR3hZZE9XNEFOdHpIakpXMTVTa2ZrQlJaOEpwWEMxK3Z1THhM?=
 =?utf-8?B?dUZqVlRnbGpMWURmVnV6SlN6cWZVM2ZYdVZUNlZMYlZiT055RGJlcm9RTjdy?=
 =?utf-8?B?elJuRit4Sms5Y3AvOHA2WlFTTW1CS1lzNFdXdGEzUXdabmkrVFI5ZTd5eXk5?=
 =?utf-8?B?ME8wZzRaZGdQSTdHZ1dLU2x2bmk5SS9RYkh4T2p3VnV2N3RXY25waHYyQVRM?=
 =?utf-8?B?VDJSdk5RRzBEWmdkZE9uTWhyZ0FyRmU1cHFuQ2o2dHJ1MERhUnVZM2ZsbWwy?=
 =?utf-8?B?VU5RbmkraDNvUFRaRHJuY3hiQlNIWisyM2xIQlBnSTFXTjd0WjBVcythTU0v?=
 =?utf-8?B?VzZBaWR0ZDNqeVBNK0M4SXk4ZEpnR2p1dzUzYnpoLytZRFBhQUhZajlFMm1X?=
 =?utf-8?B?YUtoNmdBSVdvSGtyVStvaS9jK3hQYXdWT2trVURtUzdubWdBb3lTNGpxSy93?=
 =?utf-8?B?V3RMZ3lzdDJ5OEFvekF4dnkxYXlJQ2x0S0piOXdhd3duZkFHcHNWRVlWcml0?=
 =?utf-8?B?bTBNWGxTNW0rdk1tY05XZDFGdG9nbDNaMzNzbWRUY1dwd3lVZjd3c3A2anh5?=
 =?utf-8?B?WGN0ejdFeW5Fako1T0NMWTQ3L3NsY094QVFuaFI2c3BZV1hLa0ZpMmVmd1Jr?=
 =?utf-8?B?V0k0bTF4UWh4RktJMVl3ZC9BQS84KzdNTXF4dkt4c1NZY0FKRnA2TS9tV2E3?=
 =?utf-8?B?Tk9YcWhwSXJIRzBvdFhYK1hRRzZ4VnB2Q0lyV0t6NzJwditSVTR5TDJmMVJp?=
 =?utf-8?B?YUFTS3YwSll4ZEkxREtDYmRscWw2cTJlZU9MOUt0VU1MY2FHTzc4RjgyM0gx?=
 =?utf-8?B?NWxyMmZzY2VIdGk3WHFreFlXcjVJTmRGbE43MDF0UEZ6TzljRTVKUTlkVFNB?=
 =?utf-8?B?RlVNUFBFZy9pdXRHYkd4Q2V1bDgrcWVmaWlIaEhmOXBMaEJ5bFVlTEtTa1ha?=
 =?utf-8?B?TWVUNkU2aGFROWFsUEhGb2lxM3hORmcrYmNGOWUwN0R1aE5YT09TNGI0R3NU?=
 =?utf-8?B?VVpUT0xCZllWYmxvdk5paWU4NllPeWs4OVkzM1dMSU1DcDlkc2J4TkVsa1VR?=
 =?utf-8?B?NStIdW1XZlJEWjduYUpadDF2YUhna3ZUNkJURDlpVXNhc2hOaUdsSzZuc1Zu?=
 =?utf-8?B?TGhZbXJoRk94VENYMGpocmxsSDJIT0R1dFdRR2s2N1ZteDhnSitIZE1hVG91?=
 =?utf-8?B?R2c4eUt0L3Y2VmoyYlROOEFIZlgwWmw1OTZudS9yalZMUTl3cUV1OHh0K1Zp?=
 =?utf-8?B?ZVdJQzJrZzJRQWF6cSt6RWF0a2hoRk1XZDJlOFpyQjdyN1I3b1lRL2YvUHF2?=
 =?utf-8?B?QTF1S21sZmFLaW8xZW8rUzNDUmFXUjZGQWxHRHRPc2tQR2c1QnF1VmNIcVlP?=
 =?utf-8?B?RlFnZGwydE44MDJ4TWV4OE5obFVXMSsyUmp1WHd1Nllaajd3YXU3OHAzNkd1?=
 =?utf-8?Q?twNShS3bJv2QZP0zQDEbQ5Lh186oVuhrZtoFPEQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c7d55-cb84-480e-12df-08d91824a6d6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 04:39:54.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYRNQyEFkQgmgByQZ+9B5iLAMZSrOCVid3dz9j1vM19MOXeyZsNmXICMOAl68pxqsY6U/JoMIL7YwHpnIw1Cqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 5/16/21 2:36 AM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Sun, May 16, 2021 at 12:45:11AM +0800, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> The for loop in rcu_print_task_stall() always omits the first blocked
>> task in RCU read-ride critical section. It will cause status of the
>> blocked task can't be printed and lead a wrong ndetected variable.
>> With the above, the wired stall log comes, All QSes seen, but qsmask
>> still is not zero:
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
>>          (detected by 15, t=6504 jiffies, g=164777, q=9011209)
>> rcu: All QSes seen, last rcu_preempt kthread activity 1
>> (4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
>> BUG: sleeping function called from invalid context at
>> include/linux/uaccess.h:156
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name:
>> msgstress04
>> INFO: lockdep is turned off.
>> Preemption disabled at:
>> [<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
>> CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
>> 5.12.2-yoctodev-standard #1
>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>> Call trace:
>>   dump_backtrace+0x0/0x2cc
>>   show_stack+0x24/0x30
>>   dump_stack+0x110/0x188
>>   ___might_sleep+0x214/0x2d0
>>   __might_sleep+0x7c/0xe0
>>
>> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> 
> Apologies for that bug, and thank you for the fix!  Queued for testing
> and review.  I wordsmithed as usual, so could you please check to make
> sure that I did not mess anything up?
> 

Ah, this new commit message is more clear. Thank you!

Regards,
Yanfei

>                                                          Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9855fdb508e2fa136551294861682d83b71daded
> Author: Yanfei Xu <yanfei.xu@windriver.com>
> Date:   Sun May 16 00:45:11 2021 +0800
> 
>      rcu: Fix to include first blocked task in stall warning
> 
>      The for loop in rcu_print_task_stall() always omits ts[0], which points
>      to the first task blocking the stalled grace period.  This in turn fails
>      to count this first task, which means that ndetected will be equal to
>      zero when all CPUs have passed through their quiescent states and only
>      one task is blocking the stalled grace period.  This zero value for
>      ndetected will in turn result in an incorrect "All QSes seen" message:
> 
>      rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>      rcu:    Tasks blocked on level-1 rcu_node (CPUs 12-23):
>              (detected by 15, t=6504 jiffies, g=164777, q=9011209)
>      rcu: All QSes seen, last rcu_preempt kthread activity 1 (4295252379-4295252378), jiffies_till_next_fqs=1, root ->qsmask 0x2
>      BUG: sleeping function called from invalid context at include/linux/uaccess.h:156
>      in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 70613, name: msgstress04
>      INFO: lockdep is turned off.
>      Preemption disabled at:
>      [<ffff8000104031a4>] create_object.isra.0+0x204/0x4b0
>      CPU: 15 PID: 70613 Comm: msgstress04 Kdump: loaded Not tainted
>      5.12.2-yoctodev-standard #1
>      Hardware name: Marvell OcteonTX CN96XX board (DT)
>      Call trace:
>       dump_backtrace+0x0/0x2cc
>       show_stack+0x24/0x30
>       dump_stack+0x110/0x188
>       ___might_sleep+0x214/0x2d0
>       __might_sleep+0x7c/0xe0
> 
>      This commit therefore fixes the loop to include ts[0].
> 
>      Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
>      Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index f4152aa18f48..a10ea1f1f81f 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -280,8 +280,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>                          break;
>          }
>          raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> -       for (i--; i; i--) {
> -               t = ts[i];
> +       while (i) {
> +               t = ts[--i];
>                  if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
>                          pr_cont(" P%d", t->pid);
>                  else
> 
