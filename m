Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F1EC6FD1D
	for <rcu@archiver.kernel.org>; Sat, 18 Mar 2023 02:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCRCbT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Mar 2023 22:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCRCbS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Mar 2023 22:31:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771EA3BC61
        for <rcu@vger.kernel.org>; Fri, 17 Mar 2023 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679106676; x=1710642676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k93yKOBBpL9zyvt5HzPPvEPBaGHj9NzK8lQt9VHFsJI=;
  b=VxRtSrNzNRBaXEk651u1LTCR/EJ+sy1DnxBtt68p9r5gSyWUFgXesHqI
   g2BA0E0ozFLTOraqZAq2iMrhL+zv4BlNUhi91Oz4PdIHX5ntUiytawYLG
   Qld1jeGW4eCZgPr9iT7xQv/rw3TbxOmSuHsY88zlqIxG549joO0CxJ8EY
   LCsOzQO3bNmkSlLhVWzktRZMbxnLSkf2O3WTys0LhkTy/AP+yn0LU38eH
   xmojRuf+qse7PA1ml7wz4vvfS3rEhujy0TZ+Bd2EoNdbZCUyQP0mfH6as
   lc3rbcIrESZYDRsUC611TWo01eewDGawMw9xl/KuloP2YP8DkisXXlUXF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="338419968"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="338419968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 19:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744761416"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="744761416"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2023 19:31:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 19:31:15 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 19:31:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 19:31:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 19:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9d8oBtrGF1s69bLXsmb2QgBEsyUn1yihyEmxUhb7Onc7GfmKY1P2pAshhs66+CanQKWt2wMrbV+/PFVFisaDZswDos16sP8nRPXnVTx86zpHyYBe0+8Y25EDCP2uQ0vEMtITGSwbWl7fbpDCZZ0Q91hp6Bt+TSWxGh9/Xchfu46ZKaa2rgOVkUA6sbYZMBK+072GiNjdEfPNJFyRT+9c/cdHJ4jOAIQwSRwlpcQt34klVSkXBd3eNYFp7BPvjnGhAGdcF2534nKLKTNekhjsWnGK7pG2iXbIwbO8sOsqowssaCGjCqndYBn5SftOXYqAK2NebQU1e3cKiPlncUJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnJJRhtaoKddKBjrFJuBxoWYIAovy0M1RrlgED6Etyo=;
 b=jRTsqtLL7cvwuxb6bk9pGeYel2HRA4PQ5sT1lfvxHKmh4Wsax37wGYNfT6VILhNz+YSC/7KdCLhjkOVFwrPg0jNOtxusQcWUe6m8XFHYXQ32hJhQvfeKzGX2549XDkg6r5aE4HvDahgSOurLGasXDtMNiTiFSv6/kYmDFkrDymoAWlvheBhJe7t80wtFYB/H+ywTdJSKDOciUMl7RXgd12xVyIQ9Z4HJ+NWBFMNap7UyLYXGUdy5NlHQ0glfgFp1wGod7jA0W2ufLkIS9AuvPqfV30r3QWKx8UcD91HZPH/n9UZG638afyRNfDyZ8cHpU+/oU4Nfrc1Ziqv5HPGSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB6834.namprd11.prod.outlook.com (2603:10b6:510:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Sat, 18 Mar
 2023 02:31:05 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 02:31:05 +0000
Date:   Sat, 18 Mar 2023 10:32:17 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <boqun.feng@gmail.com>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>, <lkp@intel.com>,
        <peterz@infradead.org>, <rcu@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup
 BUG in v6.3-rc2 kernel
Message-ID: <ZBUisfcPvXzqrSQh@xpf.sh.intel.com>
References: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
 <ZBR0qFQYoq4+2sXC@lothringen>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBR0qFQYoq4+2sXC@lothringen>
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a19bf0-3a70-4050-da70-08db2758d2af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYlhojULfRIxv5HBTdmaGxX9qNqesV+lVW5SDk4izwGEHxaC8osxRtNcF15aXU34IvT8Q0A2GO2Oht00CScvdp4rG979O+yQpGsK0/MSWno6elGPiYij3KY4ajwMb7gxrVrYrmEJNQ0xCiOsBwBRG+tZe2s4QDr2qj1D28JKBJZ85Cq2JbeM04hXZ2G3oOyg2ys39r40dHdt9JyR8ZArbDPrDAK044xfTDncfEVMuSDpGNdpYTZrGtDP6lIrgcdlY1TUYcoukJ5vpy1Dm/Vmqt3vz5l8J+zpwzhM9LDMVDEatElaTdH6LfjySxZBSYonivNSleUi0vlFD1ekImujc7mJ/aYJ69T5LHFbIUZ997Goo0dyEz9SSup+0bVy3ln4xx9s4Vzx/KHJY0tjTywSIouK+mnDaP3rQ4Px0C+uhiwgmeoTy/MUOcaFvz5iB1HQFoH8SFAuJgRH7bJanZs4Tqd1c6vaABouiiLI+5+cSDH2JsqnhLIzz7/pP/qDy8H8u8+i0bWGI2u4T1vPW2F52s5Lq6PuHJKBWD4b/3WJqjz+p16cqWmMaRBpVqltXhdXGzbXzxAeptySk9QJ8A/yOQUi+ZPgd5g9nGsou+mzULoM61i4duX3ka8cjwY2CX2nfa0pgkzoXDFP/zZmGZqtTPpVI2uZezvU4fBTdjuCprY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(66946007)(66476007)(2906002)(5660300002)(41300700001)(44832011)(8936002)(38100700002)(86362001)(82960400001)(966005)(8676002)(6486002)(478600001)(6916009)(6666004)(26005)(66556008)(316002)(4326008)(186003)(83380400001)(53546011)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCEFZACI38HJBEwKkEzdhtkOOjx+RWx1egf/qSElKlOQAnDgpavfqvXAikud?=
 =?us-ascii?Q?SxwSCdFQHp6z3WVxLYHizyPFpaYPKeodLIuoURTAy3DhM5fF+PJDfaxyq0/g?=
 =?us-ascii?Q?bNfgR5eNAzabsYMGSipAzbRTLIW2WRpBi3H4NSggehhGBxiZ1m0hIFVPmoI2?=
 =?us-ascii?Q?ycjk7F3sE3RXi52ncHyTpLHREkOLpNfuGkopQvgiP8UJeVaMvj/IDdQNRbvR?=
 =?us-ascii?Q?+jGfkDGmG/Ibc217N77VD9VTQssck6Q4yojj+a3uOB9TNvgcCgu6AFkzen+C?=
 =?us-ascii?Q?sUwxLsRv8dENMhfNYtT1JqdAuB7B/7yu2oikWAqPHJ1KrZLwTg/0iMRTYt36?=
 =?us-ascii?Q?tnL1o3EdPHEerXc+UNOYdvyJWxfma43ulitQZ9g1AmhUeoPQoqmcoHjSueCP?=
 =?us-ascii?Q?6vJfresCmGusH06n0X1pg2mtTBwIXZCCtlM4Ps7KeVBlPGHwsTpi0MVWh+tn?=
 =?us-ascii?Q?+ISi9VpoWFV/KRkQaGYK6pZmMkTyLsbp/I9Tx57ipcGA/Rtg7+AtVmx4ap1j?=
 =?us-ascii?Q?Tyg/NnZV/ZQ+i3xMbZiZzjuSejNGeCIUn6GRb1wCr93IYiSLZyqnd+4z2KJf?=
 =?us-ascii?Q?TO5PO9RBW3J+aNURTq7I+tXOXPPu6qkD5PWdgHl/9JcpYpxCH3snn4LMtixK?=
 =?us-ascii?Q?mr3qW3E+1KsqUwpKsprzBf4yjkZS/cgG4A5jSYmRslU3kdgvlFbaMWBK8aO4?=
 =?us-ascii?Q?MfExMcEgVcKTtMBXV8RVzqIWV/9Z2uUhe6kg/4heqTpUgUne6bAqrA4Xua/z?=
 =?us-ascii?Q?DsMjpYQ9yRClsKDeXg6VRGE6hLbaEKVqau7c44yDrvOclVu6GZUsPjInBa2K?=
 =?us-ascii?Q?CpYpHwFcq5DNfiygq+ySYPXhm4wz7mFVW5OuLs+1HJV1n5hHWyDHzMfOo+kl?=
 =?us-ascii?Q?etdjDAq2nJMB5V9DE9fjQ4vo2RXB6tUusCoiXYFhG9bLhdgbf9ixjd6j2kOa?=
 =?us-ascii?Q?mDE9zlUEvp4pmfskedVchFj1F7KYb1vEXrVZ7NYQk8ZK7Pc+ho074hHQZiHf?=
 =?us-ascii?Q?RsQjj4qZ23s5RLxrHfUrRVm3yfWf/2cc+hJPNBe5F94DsDk3a6X0f1pSC4c2?=
 =?us-ascii?Q?l3vKPX5nIrYRG1JIp15OlaNfivqduCBnWQx4TC6ABN33jwZICbk5MHpwb+Xa?=
 =?us-ascii?Q?pYt6w28fZUVaoPP1Yf7Qjcf2N8deI5O5ixHdtKrKcOVd2RCqst3xsJfK70nb?=
 =?us-ascii?Q?gaCr1y/7BTJu+YizUlAqa6HvRnQtQXaYD8y7P1HPIk67RODTC0yZ+r56EN+7?=
 =?us-ascii?Q?PnZbcp4+fzF+1alwV5XkIFjE5FT17yPP7VonmEhPS4u4eKraZG0OZhMiRp9L?=
 =?us-ascii?Q?lZQZ4tIE7ZyUL3iJ76wipx1nRJhNRqSZCGiH8fqgJqn4qclbvsz1ursFL6+h?=
 =?us-ascii?Q?mAxMxpd3pja6/FBGUo16DlGB+MRu0qWCwdUbMJUAbEmAPuHkTVumA4q/E1LP?=
 =?us-ascii?Q?MBgIhpL/Xkf582Dp4q8GINiLYd9kcGzD6Nw8Ad3EFJjDLBP1QmNMGzahaHsb?=
 =?us-ascii?Q?FK4ddPM16X5vf+9HDsE5PoR9fIrLVRw9dZUfRVD9xhdo91a2N06Y8StDqwXS?=
 =?us-ascii?Q?PN6fneOtsrBqIZoEbf9vj5VU07YXv5QGmEao2I6WullJFbLcfgL/WTmb5iPq?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a19bf0-3a70-4050-da70-08db2758d2af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 02:31:05.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCcCQbAabqAmve2PPaLZxskjPfhdzvNJUhRSO+v0fOmjoHtDJ3FvQhCASqMYUiXlhETo73PR6279i7xqnESJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6834
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic Weisbecker,

On 2023-03-17 at 15:09:44 +0100, Frederic Weisbecker wrote:
> On Fri, Mar 17, 2023 at 03:48:33PM +0800, Pengfei Xu wrote:
> > Hi Frederic Weisbecker and kernel experts,
> > 
> > Platform: x86 platforms
> > There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.
> 
> I can reproduce with you tests which is based on v6.2-rc5. However when
> I forward port your .config to a v6.3-rc2, the issue doesn't trigger anymore.
> 
> Did you manage to reproduce on v6.3-rc2? And if so do you still have the related
> .config ?
> 
  Ah, I fogot to say: kconfig_origin will be changed after "make olddefconfig",
  there were many items changed in .config after "make olddefconfig" in v6.3-rc2.

 I used below way to make the .config.
 1. Copy the kconfig origin to .config: https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_origin
 2. Fogort that the bisect script will change .config: CONFIG_LOCALVERSION="-kvm"  ->  CONFIG_LOCALVERSION="-eeac8ede1755", seems to have little effect.
 3. make olddefconfig  // Then .config will be changed in v6.3-rc2 kernel code.
    Put .config after make olddefconfig in link:
    https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/kconfig_v6.3-rc2_after_make_olddefconfig
 4. make -jx bzImage   //x should equal or less than cpu num your pc has

    Put v6.3-rc2 bzImage in link:
    https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/bzImage_eeac8ede17557680855031c6f305ece2378af326

And it could be reproduced after maunally test in 150s.
v6.3-rc2 reproduced dmesg:
https://github.com/xupengfe/syzkaller_logs/blob/main/230316_062127_sys_perf_event_open/v6.3-rc2_perf_related_problem_dmesg.log

And it could be reproduced on our ADL-N client x86 PC in guest.

Thanks!
BR.
-Pengfei

> Thanks.
