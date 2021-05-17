Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85BC433ED
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 01:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BF461042
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 01:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhEQB46 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 21:56:58 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:30241
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229736AbhEQB45 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 21:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn4Lq9I0UrdTyXcfAFAXVLiTP8uJwAyFZyeLj62DW8MCNrIAf+IwNuPNh/7Pnp/dtHuLb+an4NL1hktbGcqfgTovIFtgOZaM61Pe+jCFxbzoEAx3+XNjokA1coA4lGblwOT18p/9B774fVVnParFdHbIthugVHlCMU26t9VJZ5XXAx1LRQyGei7uZ1+GKYvHG0tQLnMgLbK28g8TYG6PvbeirsKm3l0WBFLtweKG7W6cyn8TYqepaAOZQ2dKQQc+FtSnTw5V0W5TgzgLmHLARoT2GI+jVsRMHK3vAtYFxAWWbPpDaAjp3IfT0VWQP8KnTur4gA7A5wASSLO32hD/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvJbYWZMPSZ1ad3P3lA/IxDhNdB0+Usg4F6QrlayghI=;
 b=mso0QTTLEZo24g74gITIvXFnjYlYFLM+72VvR55g+Kr5oxZ5zuRnQ/MOCmBgLESJPV6iLga/mtL6Z6CUi0ZIdS7HxcHHpy2dRfZkgApJwVpH+NrGQpuBev8CwxcptXGahkui8cbAzDoq0wEA04DpxiW9Q32+0RM18E1qFInTBTerpNlqX/YvgvmTFbWZ2N7q+SdVLuGTDC+ehN4FFFSUzmWjBrIbUPLyordYqvXr6tf+A150m1vK4raZ9lwLsVr+lueX+oLLyxKeDAQlHMIx6dijwikW8JdfgIMZ5JRHgaRrLtGjaH6fjD4JjGlLQ06u0scT39BLW2pzbUXtcL0VRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvJbYWZMPSZ1ad3P3lA/IxDhNdB0+Usg4F6QrlayghI=;
 b=gRFv8s2jtj8uS7Be0+UjlSxXzggFPlpCwQc4N48sH53P7OSRFxmq8s+8++WwroygY66TrWTFWoYzCZSlAxgDmIFE0Nfq2bvnj+kqk2ye4+sLlaOW7HwBEMCTEOGjnW9yLRf0jnh6WtSOLXRlTd2ndWWxaDedUVdd4ia+9bbpMoU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4370.namprd11.prod.outlook.com (2603:10b6:a03:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 01:55:38 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 01:55:38 +0000
Subject: Re: [PATCH v2] rcu: fix a deadlock caused by not release
 rcu_node->lock
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210516095010.3657134-1-yanfei.xu@windriver.com>
 <20210516225853.GD4441@paulmck-ThinkPad-P17-Gen-1>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <72a3b3f4-1b74-6c03-9d04-ac4bb721a55a@windriver.com>
Date:   Mon, 17 May 2021 09:55:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210516225853.GD4441@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Mon, 17 May 2021 01:55:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d30fc47-2936-4ce6-1ff3-08d918d6de13
X-MS-TrafficTypeDiagnostic: BY5PR11MB4370:
X-Microsoft-Antispam-PRVS: <BY5PR11MB43701C57538EE2C583D0172CE42D9@BY5PR11MB4370.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWcurwT8gRawIIU1aMtJweexHcKrTPDvOpWdeLtA3bU9qcN1NmCxgLgskX6ISf/s0zbVoIuiVbVPdT3KUV01b5bXviiQ7fkZKTmtfBoFKSwvxJlEtLkh62ZHY+T/p9ihk0CvAB0wdbt0qbLalRfv023tENkhib35fEJ4INuc3YtqjnhRChZN7T7r/fRz9zwZMvIZw7OH8PY/p67xBok5y/HvgsyHRENSa/YiVGgGE7FYIHPdudlDP7GGQjtVfhBicS08pSRQqm7xu3ZNAyonMQ9FGYJ1zKpK5l93pDD8Jkfi3l0mWmQ5kycOVCL4mYmOmymrHjjdGQjgWEhrf3HAO58V4nau//APyLEiLd4j8ipjvqPUs4x72IZhxhkAArgTWOIqSGdLJs2Gwae4bdU/I9fBNnBR8dHgTZJ8+ZEH5r75augFyVs8cEMi9bH2DZOILn9FttC4uaMnMoEafEOOciF0S/OR/S0GJdrLFN2PSXxzqFds3QffJ4XKVR566ZzRa+PvvzH8CgasPuuRmIyh0JN8vFf+IJgmgSEI9LvTKo1YQ3I8Nrt8F3MT7qAbD6VWneO4Z7srXmZaQYCbfSAjl93pCUS/IH4Wgl+4kaRG2liuLU4j0YyJdaYfVdgkKgwMYQrUjqau6LPLJenHOMK5wpLCsRR3EeoZArB5F7LB9qYL0TvkTH51XR+QG/Vr1dvgxi0r4ueKMmzprZ0mhelZdVpjojNs86NaI7h0Z261Mzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(346002)(366004)(136003)(4326008)(31696002)(53546011)(6666004)(86362001)(2906002)(956004)(2616005)(66476007)(6916009)(66946007)(478600001)(31686004)(5660300002)(8676002)(66556008)(8936002)(6706004)(26005)(316002)(36756003)(186003)(16526019)(6486002)(38100700002)(38350700002)(52116002)(83380400001)(16576012)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zzk0bkF2cEJacDYzMTNyWEdWLzB5L0xkVlJpdUpEV2RXTmFOYjA0aVIyVUtO?=
 =?utf-8?B?QzlGRVJJS2xySmwxb2ZPbWR2T3lycEt6L2wzNll4eHJVVWJKMHBIMC9sRmN5?=
 =?utf-8?B?Z1BIQXVacFhXNENROGE3SmRENE9FSXhrbXBLVFlvVXJmbWY1L3E3NGJRMGV3?=
 =?utf-8?B?YWxqWkxXRSt0VUNuc3lBSkREZGNPQlRsbGZ4dXJ1TithaFZXaUxPYkdEUFRZ?=
 =?utf-8?B?NE5ub3IxOUFDOU5CbFA1LzdabmJQQ01HVUkzYjE5WWpUTmk2N1FMdWdsY1Fn?=
 =?utf-8?B?VXV3YVlycVNNL2dOdVN0RXFnSlo1eFpTNjR3djJuekZIRmZtZDVqTFpYYjFm?=
 =?utf-8?B?dVpWZ1d1VGUyV3ZseTUwK21MS3JOMjhpUVBzRURXQjBoY1FQbXFQV0QyYzRV?=
 =?utf-8?B?TzZWNUEwNExKR1htd0JWQ2E0WC9tWFBKRnVTSXpLWTZIa2RaOFRGSzB0NzRp?=
 =?utf-8?B?NHlabEMrdFZyUDlYV1NOb2p1ckZQOWl6YUNPemw2bDJRUXBEQWNyMmFzWldx?=
 =?utf-8?B?WHphakJGWWVhamU4RHZES040S0tBZ0FYMXZRaGw4Znp0MUJxN2NmREtFeGlM?=
 =?utf-8?B?ZVFoZHR2RmVDZ0ZiU1FIVDVzdy9RYmN4eGNkUk9lYUtCWi9aT1VVeS82SUc1?=
 =?utf-8?B?RkxiOHBRK0dGaE1NZ1NtWU9hZjM0U0dvd1ViTnNFdmNzOS82VzJtZXRsVzFF?=
 =?utf-8?B?TUVBMEIxWWxud0F1bnZvakFoSit6WUdGRElrbW1mYXdJclFZWWcwWlg0TTBZ?=
 =?utf-8?B?WERIdzhXaGdtM3ZqekpCVzJmd0hRcFRKREcwWWVzYlJtNitWb1Uzc3p3M3Qz?=
 =?utf-8?B?YVRscWNuT2xYM0hCdFBzdDZuK3BJOWFhK1lWT0VGdXZua3F6ZlNrU3FOeDFi?=
 =?utf-8?B?czhsTFJKZjdnMUIzV1hDemNHVGJYUXhkaXU1N1BhcVFPVS9tcE5LNjhWc3d0?=
 =?utf-8?B?VGsyRFJSU0huZzBTazNlcHNvdnBQWU1nbDk5cmRMRzhjN0cxWjlyYWltbUM3?=
 =?utf-8?B?MjM1SFFNaDQ5Rjd1QWpGclBMbEJpOHRYVVh4Z0YwanV6NTRlcDYybCtXeHNX?=
 =?utf-8?B?NW5hZC9FUE8vRFVkSWh1Q29VSFFEbXZ0UThucHdSaVk3c2FsbXdkM2xsNXQw?=
 =?utf-8?B?cENabzlDd1RubTNsbVFQNk5VZ3FGSEhaMXJ4RFdDZ2h3QlZJRmpPZHozSjZY?=
 =?utf-8?B?VDdKczhHZDI4WDRNeFBQc0lpai9KOUR6dEZkREYzOHppekN3UGpaVnkzVlk5?=
 =?utf-8?B?MGFnVWw3RU9TYkFySnd6SWNIdmw5VmhienNUQUo5TDI3OG1kMlptWnkrZGhK?=
 =?utf-8?B?T3hKaW9XZENsUEY5Q1VRekNheXZFdmlTRCs2cjZ2VUE2RDFveERoMjV5Z2Ur?=
 =?utf-8?B?N0JCQSsvd1dJZjV6Wk9jZ3dUM2xIdW1qam1pNEprYzlxSE5WaGJLamE5eEls?=
 =?utf-8?B?blRvQ1NRTDhPU0xlcko4Q0hueXhIYnd2Q0FkSlI5VFplbzU2RmJTdkp6T2xW?=
 =?utf-8?B?RGlraVkzeEUySmxDYnRKKy8yUjhHQ2hmeUwyZ216bDgxZHdrbExZUmdqRnBl?=
 =?utf-8?B?WVpmS2ZzMmoxNTR2OWRKUEpXTkFxMFc4aGc2c3A0RlJUK1VsT0tzYndXeDFZ?=
 =?utf-8?B?ZmhYVm5ua1ZzcndPYlVMTkRvT0FYdUcwQUppS0lERno3OFkxZVh4NjRSN3Jl?=
 =?utf-8?B?a3dlZFluelZrZTdoTUZsUW1nazdESml0dlpRckR2OHNicmtFcnVmcU0vV2lY?=
 =?utf-8?Q?GcN2f33Cx79PpjqiFLPX6LQrau4AHdM0TEEflyT?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d30fc47-2936-4ce6-1ff3-08d918d6de13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 01:55:38.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gic0JjxVSo8dLEW5ETYZWdaAdllIXvVhEulyL/Kgg/k3X6C8zjx41thXyB9KFP5VZ2ULrweUQdcDlWmAL8yAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4370
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 5/17/21 6:58 AM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Sun, May 16, 2021 at 05:50:10PM +0800, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> rcu_node->lock isn't released in rcu_print_task_stall() if the rcu_node
>> don't contain tasks which blocking the GP. However this rcu_node->lock
>> will be used again in rcu_dump_cpu_stacks() soon while the ndetected is
>> non-zero. As a result the cpu will hung by this deadlock.
>>
>> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> 
> Also a good catch, thank you!  Queued for further review and testing,
> wordsmithed as shown below.  The rcutorture scripts have been known to
> work on ARM in the past, and might still do so.  (I test on x86.)
> 
> As always, please check to make sure that I didn't mess something up.
> 

Looks good to me, Thanks!

Regards,
Yanfei

>                                                          Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit e0a9b77f245ae4fe1537120fd5319bf9e091618e
> Author: Yanfei Xu <yanfei.xu@windriver.com>
> Date:   Sun May 16 17:50:10 2021 +0800
> 
>      rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock
> 
>      If rcu_print_task_stall() is invoked on an rcu_node structure that does
>      not contain any tasks blocking the current grace period, it takes an
>      early exit that fails to release that rcu_node structure's lock.  This
>      results in a self-deadlock, which is detected by lockdep.
> 
>      To reproduce this bug:
> 
>      tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> 
>      This will also result in other complaints, including RCU's scheduler
>      hook complaining about blocking rather than preemption and an rcutorture
>      writer stall.
> 
>      Only a partial RCU CPU stall warning message will be printed because of
>      the self-deadlock.
> 
>      This commit therefore releases the lock on the rcu_print_task_stall()
>      function's early exit path.
> 
>      Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
>      Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index a10ea1f1f81f..d574e3bbd929 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>          struct task_struct *ts[8];
> 
>          lockdep_assert_irqs_disabled();
> -       if (!rcu_preempt_blocked_readers_cgp(rnp))
> +       if (!rcu_preempt_blocked_readers_cgp(rnp)) {
> +               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>                  return 0;
> +       }
>          pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
>                 rnp->level, rnp->grplo, rnp->grphi);
>          t = list_entry(rnp->gp_tasks->prev,
> 
