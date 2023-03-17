Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5073EC7618A
	for <rcu@archiver.kernel.org>; Fri, 17 Mar 2023 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCQHri (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Mar 2023 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQHrh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Mar 2023 03:47:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B7C0805
        for <rcu@vger.kernel.org>; Fri, 17 Mar 2023 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679039255; x=1710575255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AXD3TxYBQ2hq3oTGBciUuG1kC5JvgrJ8n7//AtsV2xA=;
  b=Ol2O93xG1lYJ8ro8sXu9fGfTXo8cGtQjjSdZcdI2w8lmtzRPqs1MB8fi
   YXX8VNL9wE2Y7/juEBM6Pig9GBkkRAgOENnPPD92J+a9IUv0jctgfAT4M
   +xTSbA3rVSN4d+8jbnAxdJywmKiDttaup6pPFpHxkfxKi8idb8XFFD8vi
   Ohg1iCFEssEnUzayUmW2RE8JRf3jy0paHIR/CE968RUZIAoBsiGI6Iznw
   RfFhWIJlDoTidM3WQIHxHcExHjI//Q/NejkE7l0WCDZaAqWb3MZO4470R
   RP3ckF/9coE+SZg5uXzlFTGrt8ra/PDD+gPizJgmiTwVZMAH2N+JS+ht1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339744401"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339744401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 00:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="673471170"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="673471170"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 00:47:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 00:47:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 00:47:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 00:47:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 00:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZTZvdSxTh4j8QytfMKipMinglrkfseJYtO+veJOeromwtdPCoLhRjibHLy53f8YyEK9PwCzlCjChW3KccOA/AJpvpLz7eRrPvCwTz5WJaZ50030VvVvNVB0cjpF+R8Lf+en2zSS0Blsa1ObI01ePXw0a1tk5WTbHLQraUmcq9yr/f+Gmke4KjZ43Oi8KAbZsVXIwHgxsi1J7di7rqlVX+DBhXuup4YT+s6WynPwBc/GCgdslXbM10ZJMv9uPiUoSqpAy8PbLoFKyEqWuRz8G/6s1XmJId58ObWvKgR5xMB7FA0TyhGVe/h9vvMdILoYsaCCHHWmhPug0O0arnB3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ7/CupS/WP09sE6roNtl/O4xfGJyKHZu9rEfm6nBrI=;
 b=e3gVMF4l+UzjHJSIT7IthQQPzWL9uTuVQ96yVu8aAEepMdHlFaqqeV0hPv2PnlPiaBCABAKOjCNa7MKML6omtr9ZCI1KL/GCPWjJN8eSm/SfbO8vwKWp++Ue+1JKsfI0bXBTlHFRmVc3FcMuwqwrr6nbXO8B8GyT3xWwOEKYXiX2I+YgJAphxWcZry8iMpKZu3t/Ho4uX9vyGGWNFdkj1KSY7YJsl2+stlZjK7S41Y1b5S89YQ/clGzPReYa06zGxToXzmiJO5Aq2Gy2NHy6jvYZ4bh1x+M7TURQj0isaLw7sqKtwFxA9hGui4DiqQ5m9bifYcmjWQ2/NsfvmSX3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 07:47:12 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::1d7e:20c1:f7b6:dcaa]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::1d7e:20c1:f7b6:dcaa%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 07:47:12 +0000
Date:   Fri, 17 Mar 2023 15:48:33 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <frederic@kernel.org>
CC:     <boqun.feng@gmail.com>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>, <lkp@intel.com>,
        <peterz@infradead.org>, <rcu@vger.kernel.org>
Subject: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup BUG
 in v6.3-rc2 kernel
Message-ID: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|PH7PR11MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: efd0297a-b797-412d-c6cf-08db26bbd174
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Lr1di3UoA62Se+7goSVPi2TTknaCpF06bSoY5BS8yFt2caIb9ZQ3WNL78ZXmw14OV5E8OD15lwoZUMfAGmJPeJpgcxKO/GRYQDPVfjpuc9GcfCiDQzkIgF5m4xVBU62JYqqDd4akfBym2JV2liidroF9lC3mZW1WMmAUJP1ckzlwpZHvRshFSe08GLMEVKKUY2e43HUVkQHNneHsJV9gMGkj7nuOTDos2eDnlAxUuEFWd7hwiiyCOpmhFH+FlqTt5oqDFlsqzXrNhCBNrgjbZW5itncs/Q9uhFch2f7CZTJDkL7E8lppfHrR16biwbCzJAd6k7qiyjyu7X35dBAJSXSgLgYYduwima4Jo0Gqcm58btypOZIUbJSeyBcToFb6fnErEMhNJI+fYxefhrAVX+HQklh7FEYmpfci+VaJjWtgSF+dA1T/1w5N2RnM7Y067ksxHbfdScWOGqNuwAzwsF8Enk8Nq8JdRPSVtLmJTfYuzl5a45DayYqiIiUbrAt6aWq/4/9AXK4zcPizEZaub9+FDZ9pGesavVRB5ZxsJbSxAL+VoOAKjLa/z5V5uhrzVKpnYWc4VIgbDegV0oQNKAL0AxDmHfldjLZEc5XEssZcEB0VGzcGInIrEhY2vI17BEUuGD16V15xQCAijYlPwNZL0faB37OFbaSsFFIKAtiAi3FlWMB+JRbg/1EQM8mr+YX1hiFiQJgJ0fOki8FkENPctmlSi70wb4tJly4wtNFTBuFx6nTFobp+trMz/we
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(45080400002)(6666004)(186003)(83380400001)(478600001)(6486002)(66556008)(66946007)(66476007)(316002)(8676002)(6512007)(966005)(26005)(6506007)(4326008)(6916009)(41300700001)(30864003)(8936002)(44832011)(5660300002)(38100700002)(82960400001)(2906002)(86362001)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zUVJ6vFyf1rNHAey11g1dVzquXZBR6kUiR+R5t2FXORBIcxLJeDSrarLVisM?=
 =?us-ascii?Q?VTO8mVDv5ybxzOjL51/0Qd1xV3MLgcEIntUjzNQSANVoWmgWclZEYUNSk1H/?=
 =?us-ascii?Q?v/zo32p0xTab1Y8ArGhL86zO9UPxjuCDfbNxizfuwKx8kjdqfso1BvJRkbX7?=
 =?us-ascii?Q?DOqmj7fINXD/3kRmVrKxV+K/CbPYJid/CqfhpVBpx/0N/bOavNdCPboO/0lC?=
 =?us-ascii?Q?O6kQMP44fHqJ20y7iYojxaJwnrwo+ZgTl9CHhixhNtC6rcMUZyWG+I3mr+rz?=
 =?us-ascii?Q?EYQlEdw+6Jpzq1Rlh1stn8sZc0jC3/CcA5L9M4LSFvsjVjfxGAKCRvR4iCGM?=
 =?us-ascii?Q?ACTk6odVWGH4GzjMbSCeb1oboXzRbOOGa+7BkBaKL+rB5mIWaTruE2NGI9Ld?=
 =?us-ascii?Q?vnRwpnN/mykvKyCL+YTZ6hSS04wwzGaum6dQz1dVW3UAyn6QTmIuFXqCl4Rx?=
 =?us-ascii?Q?ugZRHdYDi7vjubvk31pQcFVBDNvBs0hvSHtBRPk/j8P7ZFYOLX+aIntsKcBy?=
 =?us-ascii?Q?uz3Zr7JSdtGjQQTZqLBPUNKgM+vwh5ZR9GMJc4i8ji88A27h+fXTNotvdrCM?=
 =?us-ascii?Q?YJVAyOnq8ByxmcRGZUsIIztcWPmBTSJ1glDO4OZ0T9EbCz3nIA+Rsq6zj8Jp?=
 =?us-ascii?Q?To5OlOU1TUngxV9IWMDbMfOQmT5ADU0I/iCgPvvjKidmvYi/n7lhAfM1jp3p?=
 =?us-ascii?Q?dW5XajpJtDqlU7Vu9v9bEcXLq6wUmKdpWuOQSlZBGlcgUV6oUDPvao4q7bpq?=
 =?us-ascii?Q?vkBsn1LoeVQrnehoyXq1YOyCg/BWO47HJHZGmo2OI5YFLCC7BF0T7wkh+VfP?=
 =?us-ascii?Q?lSFjNhJsNfMo6fl3EIfMDmzuLq41aelyRdTZi/fxSl1Z+yQf8UhK+ejePQzY?=
 =?us-ascii?Q?q145eqhHEG9eSN/3V+G/4RwbpprEB1HXNOvG8Th8qFD5g683uq44oiIg8DlN?=
 =?us-ascii?Q?ATKhLoSEQajDUsSH1bL96lKGmCcE5fvVh6HquZ+ryqfQTV5wvSBEjyv2vtUi?=
 =?us-ascii?Q?jwNMHTW5pe3Xh8sM/nMiwwRlsi+OPZtePQMN9Q7o4z9QpEVohcx5R64gaJOC?=
 =?us-ascii?Q?XYUfEHqYPgLn6aE5uZDrMT635Xfao++rTHBszwiFZk9wVN6UqqZubnpPLjmg?=
 =?us-ascii?Q?DGuz8pftf6dNhxevtgI0sAggvoSvHJCahj0NNIhLjASH0hKMwKS+7ez9HYjD?=
 =?us-ascii?Q?50ZnxNO3MZpXfMW1/wA+IJk3r0SCtM1FL2S+eP4TXgjZkOJNjFknXo6evkkp?=
 =?us-ascii?Q?eycAWA0WwV0LSpEhQVLezI9g+vZvNhSBKkng0LQljyxe97ZDOHnDXxXeqqsG?=
 =?us-ascii?Q?JHCqsl4pQtPxIIa9iNICGSpJT6rXXOuDSMoLUEheu0OfBXFJQVu+182poIw0?=
 =?us-ascii?Q?PFrlPOmM1kAhdX33PqwVlGcVM0dA5SGY/FzhZ6igHGd/aJlS/3z3WLIAwiAN?=
 =?us-ascii?Q?Bh1diVX2IskqNmmNre17RWCH8nB+AvHree5iJFjbtMo/muxVvzU/7SQ8qfsj?=
 =?us-ascii?Q?MB0XvZkjlM02qUOexPpToIdH837l73v+nnRv0YGFWZx8btLSrTG+beQ2olCw?=
 =?us-ascii?Q?wuUoQNGb8ohKljAKroyv69AMxfYbVk/5qFttbQbVOU+0KWvsrYa2Hu5VOFyA?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efd0297a-b797-412d-c6cf-08db26bbd174
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 07:47:11.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8zTTQbufuK82p25a8ITj+7VJSNg95+gsI1DPJe1/QEYq1kQSyB9aE6ZftD8vuzNDNBN8KfhqL1+IjzFf0a83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic Weisbecker and kernel experts,

Platform: x86 platforms
There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.

I saw previous fixed patch has been merged into v6.3-rc2 kernel:
"
commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0
rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()
"

I'm not sure if there are other new issues, the bisect bad commit is:
"
c597bfddc9e9e8a63817252b67c3ca0e544ace26
sched: Provide Kconfig support for default dynamic preempt mode
"
It's just suspected commit, because reverted the above commit on top of
v6.3-rc2 and made kernel failed, could not double confirm for this issue.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230316_062127_sys_perf_event_open
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_origin
v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/bisect_info.log
"
[   24.580606] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
[   64.563136] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:511]
[   64.568596] Modules linked in:
[   64.570087] irq event stamp: 640964
[   64.571259] hardirqs last  enabled at (640963): [<ffffffff8107509c>] __text_poke+0x2ec/0x4e0
[   64.573204] hardirqs last disabled at (640964): [<ffffffff82fff863>] sysvec_apic_timer_interrupt+0x13/0xe0
[   64.575281] softirqs last  enabled at (495656): [<ffffffff83024a4c>] __do_softirq+0x31c/0x49c
[   64.577257] softirqs last disabled at (495631): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
[   64.579275] CPU: 0 PID: 511 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
[   64.581032] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   64.583432] RIP: 0010:__text_poke+0x2f2/0x4e0
[   64.584873] Code: 06 00 20 00 00 e8 0e f0 07 00 48 81 7d b8 60 49 07 81 0f 84 79 01 00 00 48 83 7d 98 00 74 0b e8 24 f3 2c 00 fb 0f 1f 44 00 00 <48> 8b 7d c8 e8 85 dc fa 01 4c 89 f8 48 8b 4d d0 65 48 33 0c 25 28
[   64.588300] RSP: 0018:ffffc90000f4fa20 EFLAGS: 00000206
[   64.590112] RAX: 000000000009c7c3 RBX: 0000000000000000 RCX: 0000000000000006
[   64.591863] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[   64.593599] RBP: ffffc90000f4fa90 R08: 0000000000000001 R09: 0000000000000001
[   64.595348] R10: ffffc90000f4f790 R11: 0000000000000001 R12: ffff88800fe29980
[   64.597090] R13: 0000000000000001 R14: 0000000000000da9 R15: ffffffff82263da5
[   64.598831] FS:  00007f7680806740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   64.600704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.602240] CR2: 00007fff176ab6a8 CR3: 000000000e6d2004 CR4: 0000000000770ef0
[   64.604018] PKRU: 55555554
[   64.605106] Call Trace:
[   64.606177]  <TASK>
[   64.607930]  ? __pfx_text_poke_memcpy+0x10/0x10
[   64.609796]  ? drm_buddy_fini+0x5/0xe0
[   64.611842]  text_poke+0x3a/0x60
[   64.613674]  text_poke_bp_batch+0x172/0x310
[   64.615776]  ? drm_atomic_helper_page_flip_target+0x4/0x170
[   64.618053]  text_poke_queue+0x93/0xb0
[   64.620108]  ftrace_replace_code+0x12a/0x1b0
[   64.622526]  ftrace_modify_all_code+0x1b9/0x2a0
[   64.624733]  arch_ftrace_update_code+0xd/0x20
[   64.626307]  ftrace_startup_enable+0x67/0xa0
[   64.628155]  ftrace_startup+0x124/0x200
[   64.630197]  register_ftrace_function_nolock+0x43/0x90
[   64.632164]  register_ftrace_function+0x1eb/0x280
[   64.634074]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   64.636519]  perf_ftrace_event_register+0xcd/0xf0
[   64.638494]  perf_trace_event_init+0x98/0x4b0
[   64.640836]  perf_trace_init+0xde/0x170
[   64.642951]  perf_tp_event_init+0x60/0xa0
[   64.644800]  perf_try_init_event+0x88/0x280
[   64.647230]  perf_event_alloc+0xe25/0x1c00
[   64.649236]  ? perf_event_alloc+0x5/0x1c00
[   64.652094]  __do_sys_perf_event_open+0x3b6/0x1910
[   64.658662]  __x64_sys_perf_event_open+0x2f/0x40
[   64.660485]  do_syscall_64+0x3b/0x90
[   64.662126]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   64.663729] RIP: 0033:0x7f768092b59d
[   64.665179] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   64.668694] RSP: 002b:00007fff176ab6a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   64.670924] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f768092b59d
[   64.672718] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200000c0
[   64.674495] RBP: 00007fff176ab6c0 R08: 0000000000000000 R09: 00007fff176ab6c0
[   64.676284] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401180
[   64.678081] R13: 00007fff176ab7e0 R14: 0000000000000000 R15: 0000000000000000
[   64.682881]  </TASK>
[   64.683972] Kernel panic - not syncing: softlockup: hung tasks
[   64.685592] CPU: 0 PID: 511 Comm: repro Tainted: G             L     6.3.0-rc2-eeac8ede1755+ #1
[   64.687621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   64.690078] Call Trace:
[   64.691204]  <IRQ>
[   64.692393]  dump_stack_lvl+0xa9/0x110
[   64.694342]  dump_stack+0x19/0x20
[   64.695802]  panic+0x4fd/0x520
[   64.698074]  ? watchdog_timer_fn+0x31e/0x390
[   64.700692]  watchdog_timer_fn+0x337/0x390
[   64.702824]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   64.704467]  __hrtimer_run_queues+0x2ed/0x820
[   64.707965]  hrtimer_interrupt+0x134/0x2d0
[   64.711106]  __sysvec_apic_timer_interrupt+0x9c/0x290
[   64.713132]  sysvec_apic_timer_interrupt+0xab/0xe0
[   64.714798]  </IRQ>
[   64.715851]  <TASK>
[   64.717322]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   64.718915] RIP: 0010:__text_poke+0x2f2/0x4e0
[   64.720373] Code: 06 00 20 00 00 e8 0e f0 07 00 48 81 7d b8 60 49 07 81 0f 84 79 01 00 00 48 83 7d 98 00 74 0b e8 24 f3 2c 00 fb 0f 1f 44 00 00 <48> 8b 7d c8 e8 85 dc fa 01 4c 89 f8 48 8b 4d d0 65 48 33 0c 25 28
[   64.723885] RSP: 0018:ffffc90000f4fa20 EFLAGS: 00000206
[   64.725754] RAX: 000000000009c7c3 RBX: 0000000000000000 RCX: 0000000000000006
[   64.727543] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[   64.729319] RBP: ffffc90000f4fa90 R08: 0000000000000001 R09: 0000000000000001
[   64.731110] R10: ffffc90000f4f790 R11: 0000000000000001 R12: ffff88800fe29980
[   64.732904] R13: 0000000000000001 R14: 0000000000000da9 R15: ffffffff82263da5
[   64.734725]  ? drm_buddy_fini+0x5/0xe0
[   64.739558]  ? __pfx_text_poke_memcpy+0x10/0x10
[   64.741484]  ? drm_buddy_fini+0x5/0xe0
[   64.743608]  text_poke+0x3a/0x60
[   64.745483]  text_poke_bp_batch+0x172/0x310
[   64.747621]  ? drm_atomic_helper_page_flip_target+0x4/0x170
[   64.749968]  text_poke_queue+0x93/0xb0
[   64.752071]  ftrace_replace_code+0x12a/0x1b0
[   64.754525]  ftrace_modify_all_code+0x1b9/0x2a0
[   64.756744]  arch_ftrace_update_code+0xd/0x20
[   64.758365]  ftrace_startup_enable+0x67/0xa0
[   64.760256]  ftrace_startup+0x124/0x200
[   64.762346]  register_ftrace_function_nolock+0x43/0x90
[   64.764363]  register_ftrace_function+0x1eb/0x280
[   64.766305]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   64.768721]  perf_ftrace_event_register+0xcd/0xf0
[   64.770672]  perf_trace_event_init+0x98/0x4b0
[   64.773005]  perf_trace_init+0xde/0x170
[   64.775114]  perf_tp_event_init+0x60/0xa0
[   64.776955]  perf_try_init_event+0x88/0x280
[   64.779378]  perf_event_alloc+0xe25/0x1c00
[   64.781369]  ? perf_event_alloc+0x5/0x1c00
[   64.784210]  __do_sys_perf_event_open+0x3b6/0x1910
[   64.790759]  __x64_sys_perf_event_open+0x2f/0x40
[   64.792600]  do_syscall_64+0x3b/0x90
[   64.794222]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   64.795798] RIP: 0033:0x7f768092b59d
[   64.797243] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   64.800765] RSP: 002b:00007fff176ab6a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   64.803000] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f768092b59d
[   64.804790] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200000c0
[   64.806585] RBP: 00007fff176ab6c0 R08: 0000000000000000 R09: 00007fff176ab6c0
[   64.808394] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401180
[   64.810181] R13: 00007fff176ab7e0 R14: 0000000000000000 R15: 0000000000000000
[   64.815000]  </TASK>
[   64.816463] Kernel Offset: disabled
[   64.818327] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
"
It could be reproduced in 1800s.

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
