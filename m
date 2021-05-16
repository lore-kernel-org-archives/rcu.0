Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697AC433ED
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7E6108D
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 12:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhEPMes (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 08:34:48 -0400
Received: from mail-mw2nam08on2079.outbound.protection.outlook.com ([40.107.101.79]:31964
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232844AbhEPMes (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 08:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH8OLUF8yf5bYj3e/gcz2UJUn9em9pTPYav7vS2BQM/QWbaj+n1w0rW8YF4K4Yx2lhmCY16AORaQ3uO6vGZ5A5d10aldHt1j8zfpNee0bW2lZ5R1LXBk5Tqk1dqJslIUvn4iYxFFrKoqMuV3a+DaRjzjzCJDarf02cYYSH7q45sDvOB7gq1/ylBB5Q4L0ZqmZv/AxsD4avmntTcaRumS3LxWMQ+BSXmrrudx9K84cNOPK8GzHzYttscFSK1l95+ZzLYUg6XQrd5B7hywg/Iwemwnh9XvxAi1alFPZmAcUWvozbsZ8LBofP9D6O70F0eY1vqJKV8xfp7S/05MLgkpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYcKVhrXocyjb9P9mzqcCi7SXysWqss3lAmWnqyHMik=;
 b=odcClPWmG1eozV2/Vk1zE5b9ZZHTmDf+2C81LGzFMubmL3Ywz7/xGDMC+HbAdc4R8FjkNCg9yALQOhiwdLMyynRVkuH+Zcr3WOagrDSZxtaiZBT2X3gIZVA07qFXOIiGOdXFuqFIoA/sRlxZreUgY2cYeQFxNshFddXREjRV+zM9Tv8A9RVup9CTd9qFHVrNNIjS5Kn90/hf7e5a1obvFFWSuBwD5bqAUXG5hY+QLXI2gwB5CS09qJbD1iZ5UknyWo6OTxfrIu45pjLqai9Q8XrDyoAINUkWbyK9tvNbUNfsnr3Ke9GwaYJCA/HxRL0O2/7A3UFhgKSdOqHCa+Rqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYcKVhrXocyjb9P9mzqcCi7SXysWqss3lAmWnqyHMik=;
 b=QXtnvroXwXA8OGb5d1gaQx5GxcLqi4ivZ15JjQyCJWbxSRUD1hDyPTznUzfCB0ZqfVlSA0T4iSNjj2HvM+iwDNCD+qZQs3aFp5Nd3tfKxOLKqptLRVOmb9Zk7aG3ZNIqeNXtbOrcIPg3seLaz5skVqUq+akzLnv2S+5VyPb9HjE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sun, 16 May
 2021 12:33:31 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.029; Sun, 16 May 2021
 12:33:31 +0000
Subject: Re: [PATCH v2] rcu: fix a deadlock caused by not release
 rcu_node->lock
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210516095010.3657134-1-yanfei.xu@windriver.com>
Message-ID: <f0fdd57e-50ba-21c1-a1d8-18cf38d0ac2f@windriver.com>
Date:   Sun, 16 May 2021 20:33:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210516095010.3657134-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Sun, 16 May 2021 12:33:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14fdcde0-5fb0-4d29-90a2-08d91866d05b
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5184:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5184DD5BE3E5004831B98E5DE42E9@SJ0PR11MB5184.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mE+RSysrrQjl1fG/wF0DgY9Edg9uuFOfp1i6tiHpxS9JJLnCyMg7QTeNbuIWEUhNpiNGgTMMMq6KIL1oqkCq/GKBWbgMRMfabqUuXL7yOS6yecWHzDhO9YfmR2e6BA6KhlWKkznuaUgQJm4lKUAsxNMh4M/uYasHYgRdkP5F4YzpqESZdefV9NIiKW1yz/3HtrjnIC4Z5/hMh7fdnpikIVFoIEKWZAeNOJz8GtFwu/TOPZvaAl4PSVTRjhAivjGsY1D4z0EzsBqOXltZRvVvkLwlvg38qqAY2JugdGbn8HgijHlsFmr9IhNuOXtn5rT2PbG99T0CL3oXCJYyluyP8sCpMTN6kxoVM5oSGk0sHeXBMA8Jfc18mcJnDvKK3pJ65n274iJ4YIROZfF1dTNWDIi+ZtKMFc/kumltQOLJpUVgJNdenXZeLvpSslTk7qaZbP6bWjE+2S1EOIPgAEC7GxVDJInZfSsiQJWOCEx/7H8Tqhfr+vNclfQzLvLewwEyhE9EPlwU1yiOLP5R3VPk3c1QnUieMMBVjrPAEwrL9XYOvf3GWiNlHQJGL7RYOjv5ApAp1Cm6+0cOHR3IRlVSKrd2M8WJMu8YT0O3vGZG6laWD7J6P14ayXrcoResTn7n/FRHTV7aSbhiCJrAh5Bgv9/Jk2J4FHlN93SDDeD/7iuWlngyPHM3P9AygbbieNurSDcsrP6GAgE54JB32i1Vm9su5VD1eIMZWTMOG8c/8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39830400003)(316002)(45080400002)(16576012)(956004)(2616005)(16526019)(186003)(6666004)(4326008)(52116002)(66946007)(86362001)(6486002)(26005)(38350700002)(38100700002)(31686004)(66476007)(2906002)(31696002)(8936002)(83380400001)(478600001)(5660300002)(53546011)(6706004)(36756003)(66556008)(8676002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjhqRkxEeVNSNTJ5WmVtOEpobmFWZnpycENVbkhLRHJVVTQ5UmJ1dWhJQnNJ?=
 =?utf-8?B?NmpOR3FJQzJPQnlhVmNuRUQ1UHNFWkErYWhvTlhLNzg1aWxRazdDVndENmhw?=
 =?utf-8?B?anVvWHhrcnRxTjg1WjNMY3pqbDBoaWZJYWFtMW5GekxKTE4xa3U2SHM2emxi?=
 =?utf-8?B?S05IRExqMFNETzh1OXBSZ2FBZDgzQUpiVlptVnBtZTFSdUl3alNHRUhHSlI5?=
 =?utf-8?B?aW51SnBIY05BYzlOOFFHclRLb2NIb09CWDVBU1pJMk9xY0lUcnFEZTd4elNW?=
 =?utf-8?B?VzJrdmtyUXlBOWJhSlNhQVhDak0xdStCSXFWSDhzQVg5TE9heUFTWGRISmt4?=
 =?utf-8?B?SndsaVBxWUc3Z2pDaS9DQjh2dGRwVjBOemdOTHQ1MTkrdEorbU1pR25VOUQx?=
 =?utf-8?B?WkNEa1UzOVplQnMwSFRzcnhKNkoreG04UkpqQ1lLQzJXdmdZdDYvS0grVk9R?=
 =?utf-8?B?VFNLT1lpNEhjcHBleEoxR1ZxNTNsSWx3MS9ERkJ6ZGkwaWkwQzZaZDBhVWsr?=
 =?utf-8?B?SWNwVU1qSy9kdlBFa3k0NHA1OExhQUhiMk1GN3JtTUs2UVQzWGZqaERKT1Vh?=
 =?utf-8?B?eFlLdmgxZ0d4Tkw3dnFZVjgxMjF4dE1jUWV0K0c3cGF5ZmFsUlNzbDRSUEZw?=
 =?utf-8?B?d0hyQlZodEhQQ3c4RzU4WWxaZkNHYXN0U21HbzFMK0k4clpuaEhSOEw2LzRs?=
 =?utf-8?B?OFBFWGRPSC9pZmRJQmRZcnRhajJrbFhRaklxdUdnbG5lczRhSnQxSm9FVnpr?=
 =?utf-8?B?K0pjaFhwdHNmNldFUDB4dDl1SURmaStPSlg3RnVmMGpFc1UvTjVGaDhWaEQr?=
 =?utf-8?B?azdWOE43MnNOWUZQYWZ1bzVXS0RtZVZMZFluUnFEOHFZNzFJNkltQTQrbE9E?=
 =?utf-8?B?eGRGQUhUbnRhb0JwazdFcERsVklMUWo3R3ViRWhMUGw3UHJYem93K0x6Qit1?=
 =?utf-8?B?SGxLM21zdGJHbDBBUHRoMWVCT05SUVByVnpYbE1YbnZ5ZUhSZ2s2REU2S3VY?=
 =?utf-8?B?MFR2cFZZQ2J4aWRJejY5c0RKb1krWEdUeGtLTXBUKy9Lb3ZNMTFtWnVTVXd3?=
 =?utf-8?B?Z0p5NUFiV2dXL0ZmMXJRKzI5MDJ3ZmVuN1RhMlBtV09CS1VzZ0d1YlY5NnFB?=
 =?utf-8?B?ZStha0d4N0kzSS85MDBGWUE2bGdraWl0WitlVlVCRjMxUW1IcTZ3ZWNMRkpD?=
 =?utf-8?B?S0N4ZUN5TzhKWnJYMHFBWUhQUXNkSlBPU3czMFB2VFlLSFh4WGZVL3Ivdmh2?=
 =?utf-8?B?WFFkV005SE5ROU5PdGx5NEkrT01nMzc2a2hSanl3YU4rekllU2FLTVZCNS9M?=
 =?utf-8?B?L2xEbWUzMkxESUtMMWNvSnI5anpuV3JuVzNsbGduczJySStVODBDUktNOTB6?=
 =?utf-8?B?RHYzamtmMTlZMUhRTjdJQm9pZisxdmluYllseC9nM2x3dUZrV2kvczdtNVZk?=
 =?utf-8?B?N1dIM1FVcElaU0tZcElzcExHekJKZ0JlTU9LcDdVc2hGRk1oaEJLU2U5cWRv?=
 =?utf-8?B?bVlKdlFFNmZsNzFhc0lDbzhEVC9STmhySHIzczl0WXAvME5jR0VIUjIvdHpQ?=
 =?utf-8?B?bnA4V2E5SkF6STVWR3NPTmhlOExnVEJidHh5bE9WZytPQnd5aXVUT1kvRCti?=
 =?utf-8?B?N3pwOElGd1F6eEZjZlJmc2NaN1FhNjg5LzBLbkp0UHlvSmw2QVZqY2Nvby93?=
 =?utf-8?B?T1JvYUlJYXROYWRQaS8yZUpTWno1N1YzdU1UdVg0eFlUU1lzajZ6Z3N1VzJJ?=
 =?utf-8?Q?qBdaga4OCq9yOXQP+zHDzRTWRfkzf8Q8PEvZoeu?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fdcde0-5fb0-4d29-90a2-08d91866d05b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 12:33:31.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dLAJ7GoNhUhHYcq3fgnFsY2VicIwOj0jFLbXrf3O9NjuqovwuYMafcGHLdYkW4Z16G0qVCV0pcDB2ZBTTc0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

Should I merge this patch and the before one into one? If need please 
tell me and I will do it. :)
In addition, before these two patch the bug will lead a phenomenon which 
is "BUG: scheduling while atomic:". Because the preempt_count is 
disabled in tick irq  while missing release the rcu_node->lock.

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-11):
         (detected by 3, t=6504 jiffies, g=34033, q=10745911)
rcu: All QSes seen, last rcu_preempt kthread activity 28 
(4295088530-4295088502), jiffies_till_next_fqs=1, root ->qsmask 0x1
BUG: scheduling while atomic: msgstress04/90186/0x00000002
INFO: lockdep is turned off.
Modules linked in: sch_fq_codel
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffff80001004d57c>] 
copy_process+0x678/0x2790
softirqs last  enabled at (0): [<ffff80001004d57c>] 
copy_process+0x678/0x2790
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<ffff800010402744>] find_and_remove_object+0x34/0xd0
CPU: 3 PID: 90186 Comm: msgstress04 Kdump: loaded Not tainted 
5.12.2-yoctodev-standard #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
Call trace:
  dump_backtrace+0x0/0x2cc
  show_stack+0x24/0x30
  dump_stack+0x110/0x188
  __schedule_bug+0x100/0x114
  __schedule+0xe5c/0xfd4
  schedule+0x70/0x16c
  do_notify_resume+0xe4/0x19d0
  work_pending+0xc/0x2a8


Regards,
Yanfei

On 5/16/21 5:50 PM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
> don't contain tasks which blocking the GP. However this rcu_node->lock
> will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
> non-zero. As a result the cpu will hung by this deadlock.
> 
> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
> v1->v2:
>      1.change the lock function to unlock function.
>      2.add fixes tag.
> 
>   kernel/rcu/tree_stall.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b72311d24a9f..b09a7140ef77 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>   	struct task_struct *ts[8];
>   
>   	lockdep_assert_irqs_disabled();
> -	if (!rcu_preempt_blocked_readers_cgp(rnp))
> +	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   		return 0;
> +	}
>   	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
>   	       rnp->level, rnp->grplo, rnp->grphi);
>   	t = list_entry(rnp->gp_tasks->prev,
> 
