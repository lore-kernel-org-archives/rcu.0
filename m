Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C43C6FD1D
	for <rcu@archiver.kernel.org>; Tue, 21 Mar 2023 05:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCUFv5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Mar 2023 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUFv4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Mar 2023 01:51:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36822DE1
        for <rcu@vger.kernel.org>; Mon, 20 Mar 2023 22:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377915; x=1710913915;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7ykItpQOgNwVuzKwB4YHnj6rYiVBObe9iioDKAnW8Bs=;
  b=TGEGWnDWtCYxo2m+g405oUFAl6oyZFiWoSZq/MFWDlbPK1SzZeQaOByC
   vDO5bZjbBdhlkNjX6ZdIIQZMsV3fADzHLpjEf+Ct5BE4DSwtqi3CBB+DS
   QgqE/56xVJHxK6imglu27elti36h/XCLwSvI1YCTtUr1ZgI2C35Asw7ah
   at1FXz30kH/kP1awMmixYDqxVE+31/ldsA5foRxjfEMS7xchDsbQc3JdE
   4ZLfRHO7QK09GWCgVc4oyDn4SJp/r6c+RL31AwVRktwn+V/KKRivFSi2O
   Ni8YisKnTonlQEuhS9oJRkRRv7upOUN2MwM5oZ6XwfJE30n4Shd7o49sL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403727654"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="403727654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711666940"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="711666940"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2023 22:51:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 22:51:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 22:51:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 22:51:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 22:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOHqIHhaTS50EZ4lPYv3dvGnS+EvuGGIz7e2zTquBSMbZ4kR7mjDB6Bbgwx9UlerCG4XwGsPy8CIRw5cEJv8WZvEhX/NSRvPPTn2JUHakVA9p1KV4hlYoT3xzgg9hjxVW5BwwG56A9l68y3vlSH3lvi5u/UKlt2BGSHLX3im7WSIim1Hhq4pUhK/hPKZh7OdJ4qQLNVlczjEjN+a1YI5JmvwhX0xKIwaKondmaf0jl3f/3Z/txjPoVn30kp5N6w4JSi17LbiAbd/pNYSFf8pgtn6gK5Sfgy2ABR8I2E7L9Kv+W0+qqz3c50+dNTjr7TrX9IRMPA8OppZkZoNia1Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VKKOK3/V2+2hBlVZw06ddZtQ20VSy68qj0ZjopXvP8=;
 b=K2hE5VshJY2NlPczqUaX5OPvYE0XzePKt8Ya4ERPGBUDIi7PgVVlRxT2NERRBh4HXmnAGMQO3ZYSozgIfY0TkN8rS5urSZfJX7sqabhgaMYNRaguMBeKSRWejyXsl3yqTsMAvtGpUt/arrSSKxsJg8aOrMQxLX/wWfeqz6NpiTl55yme67/3ArZ4UGiIQncEh7WolEOq9TFvx0CkkMmzVL7TlS2gEAVzqamaxJZf2919L08MLkYRPRi/b5iZY99FRMPhyTfwFFdpglYfcNy6hW25JXNb7ZU6hGtZ+UoPkkZzNspfAzZhgcoKUJwBxyrZ1klVR8kEAWOAi2aBo+SxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:51:48 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:51:48 +0000
Date:   Tue, 21 Mar 2023 13:53:15 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Jens Axboe <axboe@fb.com>, <boqun.feng@gmail.com>,
        <quic_neeraju@quicinc.com>, <paulmck@kernel.org>,
        <heng.su@intel.com>, <lkp@intel.com>, <peterz@infradead.org>,
        <rcu@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup
 BUG in v6.3-rc2 kernel
Message-ID: <ZBlGS9SlKzQkbbSF@xpf.sh.intel.com>
References: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
 <ZBR0qFQYoq4+2sXC@lothringen>
 <ZBUisfcPvXzqrSQh@xpf.sh.intel.com>
 <ZBiOdCtHy1I2irFT@lothringen>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBiOdCtHy1I2irFT@lothringen>
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA0PR11MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e47a25a-deba-4683-cf41-08db29d05c12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26m8DGWNNykNJsUJRQd9Qbw7cpxo9F1XHmnAyeCBbFv1bVany9deKvClYFUZiYib+uBRfdQdyIRpoCL/ZUGdk6yAYVVQoskKcD8aYw69KJN6T2wLsTs8h9bMtalo20S4U22U9CeSBo7Wvh4igzOe4k3cjiTuGt4tShtgAllBxsFDGpqtkkIpGWOwMfywFbuPctW6Skz/HuvuBfaWmvwrpOgisl5oZV2JwxzWI+7+54Q4hjSP8lgbBiB4xM4wzQtw+WGor9A6VtVUtenIbNVo+uBvEC2c5kG45KSXTfIEJIUSL5S91NRd5eRhFGqGhRUDgD0kuwg1ZYdWB23BTUasYhEUvodtXyyisxvSkq7qwR66wgRKqqA6a5hcdIFJU1NBb8k4AfeTOD8YINrkYpWfxM0V4rYk3jsTxvQjeVfqTIuaA98jbVqlPWO4KG5BedKrktLLvV+55u91L8KkeN55/Xu6H8UL/6s6u4GLrfyHoQcsBXqJovF02Ax5jPgxPobuRXoETsFz/5dxICD7QWWdQ1QCpOKPoxdajDOFGPUEGNN5TX3AGKHgh54U5TvUy2gEABuyT4ZUDkMZUQ+Djyl2mLkzdHEvP0sC3IlA/la+oi8G9sp8nfnKHg9T6Q6H8KJqtXL378tTjGcQ2reMwcidtmI0aycEMkXw1GpS6eGeoME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(2906002)(82960400001)(83380400001)(86362001)(186003)(6666004)(8936002)(5660300002)(38100700002)(41300700001)(26005)(6506007)(53546011)(6512007)(316002)(478600001)(966005)(44832011)(4326008)(6916009)(8676002)(66556008)(6486002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2MutLdlD1Mej0C68dfAtApnMANcHzlhZbjJte9yMEV8LixW6bnUoRlMWox9?=
 =?us-ascii?Q?MDBLXxM3fBEOnXhsolX4cQaaq8BAPl+4IUaKpF6gD53oxUzKXu9JFReq+pWa?=
 =?us-ascii?Q?2Vofobej32qWhBdQ7z/L7GVbkyTKslf+/kLUIIoEECoTsYtUJXMNVvRIIkpC?=
 =?us-ascii?Q?3HbVlo3jiYXhkeLdaGXUF6/hNET/Rxon0+J7Fngyxpl0VqwU6CDVJb9MtF2f?=
 =?us-ascii?Q?5TPLRwxzPY4NxWXZhmyLnHHGlQL3WQoyJ7OotnE38jlGBLofOSB0yreikfvi?=
 =?us-ascii?Q?5EVn3KQaSKNHCSHacNEy+WFroGmXm7dkCldT5x//CJFRwlAeY8Jd00ezUJQh?=
 =?us-ascii?Q?ljdSoebRkVRu4je5o0cXMXC/D7vscsEWPV9uc12+lvYQLu00NNxZE7dmP/u+?=
 =?us-ascii?Q?jLH6Mqmp78aXftQ3vXpSb3uc8BwTTFGbprnOrhZESYHSOVa44Iha8s7VOaZ6?=
 =?us-ascii?Q?WJM7W/LYOF1KmpLJ6I60XaDz6Cr6ZR6c9KqhLlSTeNm6a2ONxJz8vdlKbArM?=
 =?us-ascii?Q?DANa412vKxg3BkLejTzqbrm9ro1nYwbWAr6qcF5TWxJ/Al3Og6GEKDuh+jbF?=
 =?us-ascii?Q?6byHb4SJqyoe8kPHOT/lwQXga4N5YGFHFmVBxQamlbTP768Ry01n5/Nb5DeO?=
 =?us-ascii?Q?1ENE79nYw8jb99ib4NF/TOqHCDu7mTWN5gtsuEcpYAGxalUTq7fI0JfLQkSF?=
 =?us-ascii?Q?XeStH0DLS9SXZqgLhXAi1B9hY5ww+Nh8zva8XPDOfmx/dQ0JTdRqBsQCny0Y?=
 =?us-ascii?Q?PzxisDN6AfOxlO5E2MjAhcpoJsR+8CIx9FqQo9phIqKynU+YdMQKWt5K/viQ?=
 =?us-ascii?Q?umFz/kGVfNMC1pJo12knK13yXzQRrvdaF26X1Z8+szrz0eZwrWE7cQODU8Zo?=
 =?us-ascii?Q?jMCf77QwRWvMF3O/kiKVWKdwNTKIuQGscaQAqzthRmYbY6pgd85Pcz7uwDzq?=
 =?us-ascii?Q?/KPIorUjCIHRJdeLq+7DwlzxjfRwP8rHxDmKScQXGkntLySclFdBAIyzqSrq?=
 =?us-ascii?Q?zcWghKCD7zIWzyIMdYjmT6gQgwocbt5fjhtmMDg3Bha4HnAd4pthed6Je7JT?=
 =?us-ascii?Q?wmOtznY9Dgl/RZ4bkQSgf031qlnGrUwjlSyfPk2CUyrC/i0ctSIbW/6KmMQq?=
 =?us-ascii?Q?5XUSYxp8bkiF7+y+J5QBYIREQecoRFOZEz9OxGfrARl43Bez9AR6hF993R6b?=
 =?us-ascii?Q?wu9ig8cVq6sl9Suad7X/SlFgAB53AOoMWxEuuiIkBINv6lZtGTQQSwbR5bEl?=
 =?us-ascii?Q?c7Cvea/tJHoRtJjUw+qPQN6qMzdiOI8iJNy4AX5HJOtTb61XW8xNXluAvEEg?=
 =?us-ascii?Q?A5lEUv0zc1iNXW/+07mDF03C/JHCm0kaEbIRFUklQ4SS6WvYRDsJmC0sZ+9J?=
 =?us-ascii?Q?NS+zpnvEFjj9a/YFizD4xt6hTNezxcJmeLBT/Rg4Na8Pn8yFxHu+vO6TuFOx?=
 =?us-ascii?Q?IIElTGG1UwfjX5Z1FxvhMuucd0herLIeq94F3VJE6Sx5gZD0XTheBnRezw0p?=
 =?us-ascii?Q?KKY4MIKr1L4NvmQW0GgmXuHUr3yGWDtnryNVUKPhUb7MAOUuBb0echCnOM+f?=
 =?us-ascii?Q?OGkVpptPe6AtQyezLCEsz1s1iRW+2VsvmOVH9KBmYe7TzdtDk1k+yqG09hQH?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e47a25a-deba-4683-cf41-08db29d05c12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:51:47.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K4i7w9Aub32kysg1v002PbrqpkXuhIrs7hTeLnhaGEMCUi8SsOzoAFyoTlLWBVHt4i77MSLEgxuXxIMR5a9YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic Weisbecker,

On 2023-03-20 at 17:48:52 +0100, Frederic Weisbecker wrote:
> On Sat, Mar 18, 2023 at 10:32:17AM +0800, Pengfei Xu wrote:
> > Hi Frederic Weisbecker,
> > 
> > On 2023-03-17 at 15:09:44 +0100, Frederic Weisbecker wrote:
> > > On Fri, Mar 17, 2023 at 03:48:33PM +0800, Pengfei Xu wrote:
> > > > Hi Frederic Weisbecker and kernel experts,
> > > > 
> > > > Platform: x86 platforms
> > > > There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.
> > > 
> > > I can reproduce with you tests which is based on v6.2-rc5. However when
> > > I forward port your .config to a v6.3-rc2, the issue doesn't trigger anymore.
> > > 
> > > Did you manage to reproduce on v6.3-rc2? And if so do you still have the related
> > > .config ?
> > > 
> >   Ah, I fogot to say: kconfig_origin will be changed after "make olddefconfig",
> >   there were many items changed in .config after "make olddefconfig" in v6.3-rc2.
> > 
> >  I used below way to make the .config.
> >  1. Copy the kconfig origin to .config: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_origin
> >  2. Fogort that the bisect script will change .config: CONFIG_LOCALVERSION="-kvm"  ->  CONFIG_LOCALVERSION="-eeac8ede1755", seems to have little effect.
> >  3. make olddefconfig  // Then .config will be changed in v6.3-rc2 kernel code.
> >     Put .config after make olddefconfig in link:
> >     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_v6.3-rc2_after_make_olddefconfig
> >  4. make -jx bzImage   //x should equal or less than cpu num your pc has
> > 
> >     Put v6.3-rc2 bzImage in link:
> >     https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/bzImage_eeac8ede17557680855031c6f305ece2378af326
> > 
> > And it could be reproduced after maunally test in 150s.
> > v6.3-rc2 reproduced dmesg:
> > https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/v6.3-rc2_perf_related_problem_dmesg.log
> > 
> > And it could be reproduced on our ADL-N client x86 PC in guest.
> 
> Thanks!
> 
> Now it triggers but I get something a bit different:
> 
> [  299.258474] INFO: task kworker/u4:1:30 blocked for more than 147 seconds.
> [  299.259223]       Not tainted 6.3.0-rc2-kvm-dirty #1
> [  299.259657] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  299.260529] task:kworker/u4:1    state:D stack:0     pid:30    ppid:2      flags:0x00004000
> [  299.261484] Workqueue: events_unbound io_ring_exit_work
> [  299.262163] Call Trace:
> [  299.262514]  <TASK>
> [  299.262826]  __schedule+0x414/0xcb0
> [  299.263303]  ? wait_for_completion+0x77/0x170
> [  299.263753]  schedule+0x63/0xd0
> [  299.264120]  schedule_timeout+0x2fe/0x530
> [  299.264635]  ? __this_cpu_preempt_check+0x1c/0x30
> [  299.265169]  ? _raw_spin_unlock_irq+0x27/0x60
> [  299.265621]  ? lockdep_hardirqs_on+0x88/0x120
> [  299.266054]  ? wait_for_completion+0x77/0x170
> [  299.266686]  wait_for_completion+0x9e/0x170
> [  299.267198]  io_ring_exit_work+0x2b0/0x810
> [  299.267669]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  299.268176]  process_one_work+0x34e/0x810
> [  299.268620]  ? __pfx_io_ring_exit_work+0x10/0x10
> [  299.269061]  ? process_one_work+0x34e/0x810
> [  299.269561]  worker_thread+0x4e/0x530
> [  299.270052]  ? __pfx_worker_thread+0x10/0x10
> [  299.270635]  kthread+0x128/0x160
> [  299.270962]  ? __pfx_kthread+0x10/0x10
> [  299.271405]  ret_from_fork+0x2c/0x50
> [  299.271850]  </TASK>

Thanks for your info!
Seems this issue could get different behavior on different platforms.

And you behavior seems like the other problem like below link:
https://lore.kernel.org/lkml/5ff2b3c0-eb96-c423-dcee-1bdf6604e9df@kernel.dk/

I found this issue could be reproduced on our ADL-N and RPL-S client platforms.
And the related commit is just suspected commit, maybe it's not the root cause
of the issue.
And I hope above info is helpful.

Thanks!
BR.
