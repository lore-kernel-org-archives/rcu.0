Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C002BC76195
	for <rcu@archiver.kernel.org>; Wed, 22 Mar 2023 07:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCVHSD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVHSB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Mar 2023 03:18:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1E36EA3
        for <rcu@vger.kernel.org>; Wed, 22 Mar 2023 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679469480; x=1711005480;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zRFSnDgd+9yT/Fk2Kq0Aba2wllPxGkILf+miTG44mNA=;
  b=OP9MLPLVWhdv/hGLtVkhDu7jgQ888pi+i7qua7W5AEdHT5nWw1uqv7Mx
   yDw9m+e0bW3EpKtLh3DRxOCmM7z6j/FzhgJvnJ5ojaT0/e4TiwKXGdcqS
   C+8pW4zaWGDz7be8NevnaNZebF30DRRbHp5HLwuAAd2elGwOKgqyKlfqA
   KhO0WB2s7cAnx+7KnHSu2wfuNtynEIIgzvSXlsQwXcxf+cLfMD+AhTtUb
   eHFMyRyhqInSQYIMdV4kKn9kBDe+f5344+pVACAJzDmGY5wXUV45VPn4m
   nIsVpZZbtc5vW6mqIer+VrfSkzB/TmX/5geXSD/AlqHixsRWx4pf9q1/H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327523876"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="327523876"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 00:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="1011251634"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="1011251634"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2023 00:17:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 00:17:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 00:17:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 00:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDUvD2Q9O0WjgNop3+R2jMeOVed+MAO6E3NW3wWEqDpT1dZSg71m/JlJjtKvjjuO3L8NXXleoObxt+HbSp0CoHfO/59n7s6HnJKvW4y3Lst2rjmN77/16MzhN5kMhKABAy8rcNGxN6/aOdDBQlbR+QTNuYAjHfMy5T2nAoRff0Cd1o8OzDm7XcD1pvpkWu2Dl2cmpLThErVnCCZwd3M+SeAgB94+Z8a1Q2AB+MEVT6YXeGJ4vmKT7dbxUxgK9Bn/qs1h5T4iLgAjgfVLbJ57np4echnUnOHjgV+cOuvBLA85GJ78HZkYCtXE7Jp4iWdRAGUf4e0m/GaEv/aPtqAf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcOuTlk8xMyvZs5UWGfWauh1zAYAykG3dhLLwO4EPgs=;
 b=lW0/+K7V6+XQYkdgYpcW9iYFH1rG83tlWIEdtcNrmAtutNl5BwBxn8q2ZoN2OG1sKV12WXwAgO3C+9uoIR83NnapHibDbuKHBbgwH68v0iINpMQq4ZwbOfvRFU9qNQB2+c74Iwe5Ds7h83/0U9i29ZqdNzjfD6An1we1QRiwSO4CbvpTp8ZGsLWlIXhBQd+5Mo8ob2HdIxVgpaJ2uDwI6/9l72kmPgH/XRETyZj00cVXOff+fs9NvwGsz0EmL9WZnAiBbGoWZQ7pTRn0IFDJXbWLYLkBeQ/UpGWeagbNCxy7tDxC2ZFbNie5yF0mhInftMPReFeGCnxxTVFjS2iz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 07:17:54 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 07:17:54 +0000
Date:   Wed, 22 Mar 2023 15:19:15 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Jens Axboe <axboe@fb.com>, <boqun.feng@gmail.com>,
        <quic_neeraju@quicinc.com>, <paulmck@kernel.org>,
        <heng.su@intel.com>, <lkp@intel.com>, <peterz@infradead.org>,
        <rcu@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup
 BUG in v6.3-rc2 kernel
Message-ID: <ZBqr82GsXXoofwhZ@xpf.sh.intel.com>
References: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
 <ZBR0qFQYoq4+2sXC@lothringen>
 <ZBUisfcPvXzqrSQh@xpf.sh.intel.com>
 <ZBiOdCtHy1I2irFT@lothringen>
 <ZBlGS9SlKzQkbbSF@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBlGS9SlKzQkbbSF@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: a5657d3b-a3cc-4dc6-15e8-08db2aa58dc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VE3J/Y+zD8d4Vpdbfaq9UcygIQIhd7430q/cFo86OUCFFmfPK2HWVabAOU5APSUa6ae2ZDUGsIQZhoM6nl1gVb1vM9gF+HWpuMzu2Uz/X/7iX47yWAwRgyYgOv3QKigI1w/37VKuYuUWxP5l9OKEpWeNrSFywwtaMMQW7XQHzrW5Gy+Wkc6nq+TNqYrEBvS9Y33dc082fxGWdYTECJyPrFv8s9KWQqNCvy/8i655dQ6aPowTmyzU5+YwMUHrj1PftuV+rCQ3KfFjIJg0ubeF7qYZ9xOEPvL2PBvkZKyrio3/Bt5GBDBfxcnSQugMaVtd36WP5bKBdlFnHtI2XLHAd1T+L81DCDsGXGavjw3GYC0gPdHiyqsYkWFjBs/FqlJO7NfiJvM/YPCJvN9tH/knVScDPNSv1UFghNXWqiIdCeFCCNm0rePX/cZsv09+vvz7g7+5xFQRRckzKOQ18FsgESbY8xnGEnXHYeodh72exseTOCMJ94qtAyQZWui8NQwuHYOXGtYO9W+gKjalD5i/qEv9uSVudkQErTDOMHNjuxZxv4TPBmXhHtxCi/4HOo4v+QJ3enFLattyyqpbwedhnlguoRCpqqpsNDO+vOCJaPbWLvb/okNhKHeChjZ0PzMgtufpYUby69JtrsRqJSL29A/I6E71vwo3wtyR8SeC0tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(53546011)(6506007)(6512007)(6666004)(186003)(26005)(6486002)(8676002)(316002)(966005)(478600001)(83380400001)(4326008)(66476007)(6916009)(66946007)(66556008)(44832011)(41300700001)(8936002)(82960400001)(2906002)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nlq2VnYC7B943srz9stJBLg2dolo5uWv1qPh2lc4pIBsvSg/NnfyHaamfHzD?=
 =?us-ascii?Q?QXAzyphMZZwcGUER7UeNcARtK5nQ4fQy8zRVNzqIPDzA+hmY8ZmEwMoaJm7e?=
 =?us-ascii?Q?8ngq4d3JfXjIuJ7z0AGhgqT4/qfqEI2+scL0L7+4QTWRNkTHCdhMjf07wDOH?=
 =?us-ascii?Q?JLtqhYpbZwD8Zv/yP1UfambE+4j00qB9pZI9kaiB6k0ur9FNXfcRnFe87Osd?=
 =?us-ascii?Q?OfTCwcomd2vfn+OQlsuFqnOPP4NowbxCmag5wvQqcNzOQ+268hIIY1EKtkvr?=
 =?us-ascii?Q?Zgx8Qmk/Q2NqXOyFUgZf9O25DvzwFnOG9lhAB5J5aFvEp1N9qJdWMrUC3qXr?=
 =?us-ascii?Q?nO/hqHzB1M76zUjqpK1ye+tPrXJBUyhl3n5m6e9d5uLB7A2MEygvcYY77aaQ?=
 =?us-ascii?Q?P7budFbllF1CN/p8g0WRb92aYGT9mL/lnCss98lOEBxEzfWnARgryes0a1zg?=
 =?us-ascii?Q?fgjE9V3kcwk6RfGBQMhrpb0FtPkie2CJ4iQoifA2hjt3w4fNUj1XU0cvN+Ba?=
 =?us-ascii?Q?FlvBUoxUlbCQ6MlnHea5Qmu+hnxk+kQAGu5LBZpnmttG0VSPbJ/KJqsz9zkk?=
 =?us-ascii?Q?LQj0Mf4nMNbrqsHxIgbqbFmWOSKiLLHn6E6AXL3KlsulSjV8Eldp/ll2RBZW?=
 =?us-ascii?Q?oJMP5XawyVdXYjh91tZPtq59whsILAInBPD036JtqKJVmqRddTKj+BEvC+gr?=
 =?us-ascii?Q?cNcQfpiTmEkC1ObJMUt/lelnzFNYKodffJOnuRDrvYJyE47DFtpRnwufEhBg?=
 =?us-ascii?Q?pIcf9hDTEOlEtU/jZpqS0fACij7qbKsi8mixU1eAEJYjq6i0EqRY6dvL7Pz3?=
 =?us-ascii?Q?R6lrStocL+kv/gQxuWDykdQ/WEkZfczbFHvQk0SC3nxC7PDr6Tmd9ZoF0ZSx?=
 =?us-ascii?Q?TiHRw61kxnoaaT5Sf5Dl1IzmoVVg+j/QUkhRBPIE7L+5WZwENcEmBNs3KG6I?=
 =?us-ascii?Q?yFpXo3yCkAJ7gKhuz8klV1ipMMIJOEI/o3X8BhQX5dS8xfxjAiQH4qHfPikS?=
 =?us-ascii?Q?ppxg9LOThOdj6/BlSg02a38tJqsjYHHx2kt/m4zIvYlGQpGoMk2dlqkDHIWV?=
 =?us-ascii?Q?+fa1YN+foJMbdnkjbNA+7KgxtL0mLYOTi+sypQtZ9RUN4T36KOhVJ/O3NPtg?=
 =?us-ascii?Q?WyLJJmGw0UITEUgRPsgBZgdqT6amoUIOFmA9HdrM447w7oGHR1/AkTVB64Z6?=
 =?us-ascii?Q?ufJ8O8srIfWromhp8A1++j/auxj8Hz5WQkRcfmmDoTELHJun4TwjOzfaS+zf?=
 =?us-ascii?Q?VPWHPZePdn3FFcZI1vh+yAC3FsNTuly0U0oi/4k9WgtPakNeSqWDufqZhyME?=
 =?us-ascii?Q?/MvtT9E2Yos7ik5y3+4V9oKQHNJ9aoaOFUQh6Qs/0wQv0k1gmF4byYUVWEbq?=
 =?us-ascii?Q?rdYiP1btFO2wrvdWlaom6sULkOYIArx5kjTXVdwd5MN2hfW3xFhPf9/nqVK0?=
 =?us-ascii?Q?b9h9yzECnJPd1s0LXOVJFibYXpViYEwESbnh6s58OX9knOhQmM1vCp3C9bT6?=
 =?us-ascii?Q?ARuvNyI84W5UY2VxwuBqPWebKcK0u3Ngon0kFIvLU3fsmJ4w+SOfXb1dsEvK?=
 =?us-ascii?Q?wAFEVG4H2TnF8c0Jgr96gcegomoIL4fqo+7ZpBBk/EKtQI1he3+WysdIVijk?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5657d3b-a3cc-4dc6-15e8-08db2aa58dc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 07:17:54.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82o8Sbvar5HF4NfCHcztHtYswa6JdUJCP2Aqe2UoilIv+FmR82f3c+iTaj683lyniw7nOgXjPl3Mu4nPUpOfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks Darrick J. Wong's suggestion in another report:
https://lore.kernel.org/linux-xfs/ZBgCH%2F8EguhJkwPI@xpf.sh.intel.com/T/#m68662b542a0c2c1c9e4146705cde8db3fd0a8d4c

More analysis info will be added in issue report next time.

Newly added the repro.report from syzkaller: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/repro.report
And newly added syzkaller report0, repro.stats and vm machineInfo0 info
into https://github.com/xupengfe/syzkaller_logs/tree/main/230316_062127_sys_perf_event_open

Thanks!

On 2023-03-21 at 13:53:15 +0800, Pengfei Xu wrote:
> Hi Frederic Weisbecker,
> 
> On 2023-03-20 at 17:48:52 +0100, Frederic Weisbecker wrote:
> > On Sat, Mar 18, 2023 at 10:32:17AM +0800, Pengfei Xu wrote:
> > > Hi Frederic Weisbecker,
> > > 
> > > On 2023-03-17 at 15:09:44 +0100, Frederic Weisbecker wrote:
> > > > On Fri, Mar 17, 2023 at 03:48:33PM +0800, Pengfei Xu wrote:
> > > > > Hi Frederic Weisbecker and kernel experts,
> > > > > 
> > > > > Platform: x86 platforms
> > > > > There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.
> > > > 
> > > > I can reproduce with you tests which is based on v6.2-rc5. However when
> > > > I forward port your .config to a v6.3-rc2, the issue doesn't trigger anymore.
> > > > 
> > > > Did you manage to reproduce on v6.3-rc2? And if so do you still have the related
> > > > .config ?
> > > > 
> > >   Ah, I fogot to say: kconfig_origin will be changed after "make olddefconfig",
> > >   there were many items changed in .config after "make olddefconfig" in v6.3-rc2.
> > > 
> > >  I used below way to make the .config.
> > >  1. Copy the kconfig origin to .config: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_origin
> > >  2. Fogort that the bisect script will change .config: CONFIG_LOCALVERSION="-kvm"  ->  CONFIG_LOCALVERSION="-eeac8ede1755", seems to have little effect.
> > >  3. make olddefconfig  // Then .config will be changed in v6.3-rc2 kernel code.
> > >     Put .config after make olddefconfig in link:
> > >     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_v6.3-rc2_after_make_olddefconfig
> > >  4. make -jx bzImage   //x should equal or less than cpu num your pc has
> > > 
> > >     Put v6.3-rc2 bzImage in link:
> > >     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/bzImage_eeac8ede17557680855031c6f305ece2378af326
> > > 
> > > And it could be reproduced after maunally test in 150s.
> > > v6.3-rc2 reproduced dmesg:
> > > https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/v6.3-rc2_perf_related_problem_dmesg.log
> > > 
> > > And it could be reproduced on our ADL-N client x86 PC in guest.
> > 
> > Thanks!
> > 
> > Now it triggers but I get something a bit different:
> > 
> > [  299.258474] INFO: task kworker/u4:1:30 blocked for more than 147 seconds.
> > [  299.259223]       Not tainted 6.3.0-rc2-kvm-dirty #1
> > [  299.259657] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  299.260529] task:kworker/u4:1    state:D stack:0     pid:30    ppid:2      flags:0x00004000
> > [  299.261484] Workqueue: events_unbound io_ring_exit_work
> > [  299.262163] Call Trace:
> > [  299.262514]  <TASK>
> > [  299.262826]  __schedule+0x414/0xcb0
> > [  299.263303]  ? wait_for_completion+0x77/0x170
> > [  299.263753]  schedule+0x63/0xd0
> > [  299.264120]  schedule_timeout+0x2fe/0x530
> > [  299.264635]  ? __this_cpu_preempt_check+0x1c/0x30
> > [  299.265169]  ? _raw_spin_unlock_irq+0x27/0x60
> > [  299.265621]  ? lockdep_hardirqs_on+0x88/0x120
> > [  299.266054]  ? wait_for_completion+0x77/0x170
> > [  299.266686]  wait_for_completion+0x9e/0x170
> > [  299.267198]  io_ring_exit_work+0x2b0/0x810
> > [  299.267669]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> > [  299.268176]  process_one_work+0x34e/0x810
> > [  299.268620]  ? __pfx_io_ring_exit_work+0x10/0x10
> > [  299.269061]  ? process_one_work+0x34e/0x810
> > [  299.269561]  worker_thread+0x4e/0x530
> > [  299.270052]  ? __pfx_worker_thread+0x10/0x10
> > [  299.270635]  kthread+0x128/0x160
> > [  299.270962]  ? __pfx_kthread+0x10/0x10
> > [  299.271405]  ret_from_fork+0x2c/0x50
> > [  299.271850]  </TASK>
> 
> Thanks for your info!
> Seems this issue could get different behavior on different platforms.
> 
> And you behavior seems like the other problem like below link:
> https://lore.kernel.org/lkml/5ff2b3c0-eb96-c423-dcee-1bdf6604e9df@kernel.dk/
> 
> I found this issue could be reproduced on our ADL-N and RPL-S client platforms.
> And the related commit is just suspected commit, maybe it's not the root cause
> of the issue.
> And I hope above info is helpful.
> 
> Thanks!
> BR.
