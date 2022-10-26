Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02F0C433FE
	for <rcu@archiver.kernel.org>; Wed, 26 Oct 2022 04:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiJZEg3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Oct 2022 00:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZEg1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Oct 2022 00:36:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B9C74E00
        for <rcu@vger.kernel.org>; Tue, 25 Oct 2022 21:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666758987; x=1698294987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p2pOisbVT0b6Qv7vegacr/f4qN91TE+nNjc02fhdLVU=;
  b=bZ/PKGlnADHcnuJb3VzMHv2qs2pe6EAC1ecioDuCEVS89KBHpDV3hdCt
   fhFcwYr3nRBBA5x0UjyHDywmUZY13A1eXPGJ6OyWqjwZR1xgG2cPfgVsL
   kne/ccJCTBicVM0l+cOWd/jAiKHkaJE24XkIUiV0A8YkeITBzZhPKwc6u
   y45Xh5HMvJkJ5qeJxS9E61CLcdUhVO1oDX4LvTFuJFGz/pRdv2RYmXYzz
   89QC2V4ZUh3AThQ6j6Er6NVwMjjVa2Yv92nrccc/k2n0oUretLgFxQeW+
   35nfnEP57n2JzabeJHQ0pGTHsvRPbZ4pbKGCsoOWK+WGA+Xx2pqcV2Zrw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309547044"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309547044"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 21:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="609819073"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="609819073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2022 21:36:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:36:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 21:36:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 21:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZbgTV9MavoXOuuptWAWVb+PzKC3KzpYRb8WMD/eGhLDQ8wrSsEv0Q/37/XGNPOWRVIc/wq5WFJ1BV8Aw2hcDLwS7GeVTTzPAvfE7nFcrwCfqxgQasxJSe/WZa5Kc5TvA0Eond/IY+Djm/XdAl7eyIFfOUnm+9omE6Z9VEe5i0fdY65Q3qka0EFc9bcrmxFesqHNVVBF39k/pYcHEivnMjQqeG7LdIQCfq/H8yeHqJOKKEFXT2suG1jomCHqSgPaoz6kOVDdCqL1NbqrdpJUMABxB7okZa8mkGR+87Fd0amqxNrsdSyHcOynAmb1LfDAOrJuM1q6KH8JOCuZQ2ga5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UNNijTEsrY3/6iNPE4MRksIILe6cYYKJTxnNIPSk4k=;
 b=QgvZ8o8YNYlF8AW6ekmhb7mQKEqsmGRQ5L8HnUKKC+mk42k6BVRAHXsrCVCl3zvn5F42inea/OT8nfml4WrQtCJx1nRZbwAXPJdTe614Ur2BQW/yhpoEdfhc/Q2rGtdlbzggHlQBKYetuq5rpnLqQLHnNkO+ei0sUS6+pCwxMjrvn05DotP3b9S4LoyTiLiAXidlMtWEaqnjv7+khhxio7jqWy/ZwmhY5g+397zkIcSg3ZMs2J2M2eBGO7M/+fd3OR+tAiyQ57IJqSivZCn4SzVjfplYc2/7y/s+HEObAQOEp/39Vtvxb2bj59uHrzqMLYHL092HRlEL/56XS0+GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 04:36:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 04:36:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
Thread-Topic: [PATCH] srcu: Delegate work to the first online cpu if using
 SRCU_SIZE_SMALL
Thread-Index: AQHY6OspTMvdEnT1Z0Os0kVmIKIlOa4gC04A
Date:   Wed, 26 Oct 2022 04:36:18 +0000
Message-ID: <PH0PR11MB5880F4D3045159634170EFD0DA309@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221026032716.78674-1-kernelfans@gmail.com>
In-Reply-To: <20221026032716.78674-1-kernelfans@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: 2cc3f0a1-b527-41fb-fdf5-08dab70ba043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcHhk8+QRTBqmuFTtJWhhtOfKDwOlqCnp+94fugiIggV/WnLThlW6fYPuE6vEDo5dAG1ESZk9AiZDGjk9c4hFRZxn2hxadZ9CNSjXkfmQlvx4jLypXcTQUtAJOLcaVG2BGHlehZ9x6610qZn2bpSQXT//rd0REmJyIvLqZndBev0JISL7cr3s/ek7ApnMqP9KrymtM5GqWKzOgnZVcNDui2frLSKkHoUaX+UOL/EpCok9H2eqiUSi1yaUBfN69Wgj1yOMlL0UXroUzVhbNa4yyQdyocMgLa10GzaMzYPJ/R3w/qiPsy2p21knq6Rtw+8qpqyWVDpVJmqjVIcr5Cns1YNH453BKzsRn3A4KB0KWmEHhMbFKQHLsJUxKNJJYaygEEsQ07JR/2PN+npSkZuCE8mMyKb2wDeWtkqR4/40p9iCp0RexE5kEF6w1CqsQ/DOUstwXK+BtAJ+38xAX/VfFlZUH33T8cszArQ3jAmUUqOGDTO6lgamL67UadVBwiYPsV1fCAylWix3/uhEIufgAE1ZdWxf9mKUBCA8dtZBoYwQEllEZ69nbQkM3VcfnlWPGy55J7xar52huVI3p7Roh5SzpTk/T6TQMjYVLx6JMqxSnrr8HZOAkSpcX1+DpaXQHP1dawRwX5YO0O2+NwYj/OtTz0dcXgE1BMZxEUKwm+sOzBcqOQtX4FHfFr1t8fyCzWLBcsJKKwPPUqFTV5PR+miqMOBonHuLsKANEW2IeqQ/ahDoF68BQ/FGDi0y27YrdmoEkwGFUp/BA/oIqiaUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(9686003)(6506007)(478600001)(55016003)(7696005)(26005)(71200400001)(2906002)(86362001)(5660300002)(122000001)(33656002)(38100700002)(186003)(83380400001)(38070700005)(316002)(82960400001)(41300700001)(52536014)(110136005)(66476007)(8676002)(4326008)(54906003)(66446008)(64756008)(76116006)(66556008)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vwaODKFknuRTi5JU3dh5GszbRs31B21qRL3iVeIIu7Ex/wxGRNvO2nCjLtq8?=
 =?us-ascii?Q?V1Vh+846EgpqvE+uy3UaUlOh8mmBGiFV4ps1qIkrAtKhi60sHlBFB/nT5+QJ?=
 =?us-ascii?Q?fbtgQ0skGDm3NDvsJskvsHziCE51OxBOtzE9pTCHURAqvBCEj1UpC5r0YcPH?=
 =?us-ascii?Q?VL0jcVoRT8WDRfrVu86Wr4D/1St5Bc0LCIXme6yB4DFvF1Kr4DSUdBhcnjcy?=
 =?us-ascii?Q?RHHLhBoJsf+Ek54JMZIqa6M06MH2wYjWreFwEjUA85dHvmhDku6GDEUPAan0?=
 =?us-ascii?Q?agSnUirqfI4/Tuik95gGnEaRpuV2bfFuPEpjXo/uAHA2fi1VatDoW8qzpRmG?=
 =?us-ascii?Q?iSDZYW3GecEPACOJkAtbR8TX8Hy2ctB4IOOLxLCqSAZjv2APHHPqeIfxjEXB?=
 =?us-ascii?Q?05VHlr76wqRckCdCt8k3AC79qFuQjGTCSvF6sB0Z7CdCCHN5nP68AuQNd3SA?=
 =?us-ascii?Q?TA5geFNtNOBQcp/A2sxlUgFpB9tMvZE/5hc5aKq9+g2NUHKyXPZVwdmVAcqp?=
 =?us-ascii?Q?Hqyf6123ttdRLlGtZOzSwcujcWISys7/+UMk7E7fvSUgEZSpJHPwQXJlabwr?=
 =?us-ascii?Q?8EWlLyRGy+pPEenzykycgJWsrxWCgbkCXoia2diKVJ6Ebpz7DzskdvfYHvum?=
 =?us-ascii?Q?rO/CIGbNHxGrirVa0B8CbKTWEhDYt+f8hIOwAiAsmpXPEbpTjMqyrC+OBYzk?=
 =?us-ascii?Q?PfDAwpdW4bS2d2OR+ld1ov2NSp8+VzhXM7tUvKX+ugB+fW+eIyzvpx17nWXf?=
 =?us-ascii?Q?ptyu/KltkVgbjY+RwKfJzAgQZ16Lt3MUtewP3c55pYigRxu3YMfahwEWVSjh?=
 =?us-ascii?Q?S5MmbTkb1t/S7eMG0R3PS8hQCRVGGaqfBuddpf0M5kyt/XMEubxIgkAsh5jD?=
 =?us-ascii?Q?aphJfe4huL/+LRD6DBeavXUnOSbkbSSNqpd/e2LRiVpBeRRzsu5lh3kwQZqz?=
 =?us-ascii?Q?7GK3jN5CRyDD0nfgxNXqad+LImwsAHTZgGt5TMfwU7BXiOSvbf6OzRfhHf3Z?=
 =?us-ascii?Q?SkGc6OJoRd0hZrp9yicjBzIDCZKb0fUEdhYFB0EEnQi/9KTM7mquw4Yj8NIL?=
 =?us-ascii?Q?5UeSnNy75vsOaL92NOorSqel3nfWU54BSzildO5TOM2hRhQfKVW7UDjgglD1?=
 =?us-ascii?Q?UGtOTrhXbPE0oGd2FeN2dUvq/My1fJpsJ4QMt79Ink2gpR3iB6WUaYhi0/5M?=
 =?us-ascii?Q?xDfHnEHzDxzwNYGGR2EicgOEHf8uXiwFqvlXV6/ME2btFXugeXAKdGuAztXH?=
 =?us-ascii?Q?0HCEF5C76I923U4npJbU+lsfLQ6L3akRAxrOFK/DPOpObz+tFrl9fAdtmm0l?=
 =?us-ascii?Q?qU87jH0lC7VIGLL3FoExqj02PT/A+pbILW2V+XifQFO18cY/xaagylZcYPKo?=
 =?us-ascii?Q?oq0B7vlNjTp9VTKunIs+YifQXLyhelMSdZLdG/PL/7QsChZG8aqttAV2iUb4?=
 =?us-ascii?Q?DAa4knufpPrk9Xxj3aJ/KoB4Ez1pQXWwYFQS0+Lmb7SEqFtyywIO7kPi6GnX?=
 =?us-ascii?Q?Tmtuxfbv/KBZEtHZNPcxyNyR2MzJBBuidW0QjbA/vI1bwd5qLUxxV9BHHpNA?=
 =?us-ascii?Q?TxTAp36g/73wnNNSRir2PuiuwVPleYJEn/7kQYqK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc3f0a1-b527-41fb-fdf5-08dab70ba043
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 04:36:18.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qorQ24cP6S9ChxT6Uk7Ov0V7EHqvwWQlQsSzcDtO+CePfvG26zwhH8JqtUc8DU0QQZRSo4nJFXlsJTcAi6oQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
>commit 994f706872e6 ("srcu: Make Tree SRCU able to operate without
>snp_node array") assumes that cpu 0 is always online, but that is not
>the truth when using maxcpus=3D1 in the command line for the kdump kernel.
>
>On a PowerPC, the following kdump kernel hanging is observed:
>...
>[    1.740036] systemd[1]: Hostname set to <xyz.com>
>[  243.686240] INFO: task systemd:1 blocked for more than 122 seconds.
>[  243.686264]       Not tainted 6.1.0-rc1 #1
>[  243.686272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
>[  243.686281] task:systemd         state:D stack:0     pid:1     ppid:0  =
    flags:0x00042000
>[  243.686296] Call Trace:
>[  243.686301] [c000000016657640] [c000000016657670] 0xc000000016657670 (u=
nreliable)
>[  243.686317] [c000000016657830] [c00000001001dec0] __switch_to+0x130/0x2=
20
>[  243.686333] [c000000016657890] [c000000010f607b8] __schedule+0x1f8/0x58=
0
>[  243.686347] [c000000016657940] [c000000010f60bb4] schedule+0x74/0x140
>[  243.686361] [c0000000166579b0] [c000000010f699b8] schedule_timeout+0x16=
8/0x1c0
>[  243.686374] [c000000016657a80] [c000000010f61de8] __wait_for_common+0x1=
48/0x360
>[  243.686387] [c000000016657b20] [c000000010176bb0] __flush_work.isra.0+0=
x1c0/0x3d0
>[  243.686401] [c000000016657bb0] [c0000000105f2768] fsnotify_wait_marks_d=
estroyed+0x28/0x40
>[  243.686415] [c000000016657bd0] [c0000000105f21b8] fsnotify_destroy_grou=
p+0x68/0x160
>[  243.686428] [c000000016657c40] [c0000000105f6500] inotify_release+0x30/=
0xa0
>[  243.686440] [c000000016657cb0] [c0000000105751a8] __fput+0xc8/0x350
>[  243.686452] [c000000016657d00] [c00000001017d524] task_work_run+0xe4/0x=
170
>[  243.686464] [c000000016657d50] [c000000010020e94] do_notify_resume+0x13=
4/0x140
>[  243.686478] [c000000016657d80] [c00000001002eb18] interrupt_exit_user_p=
repare_main+0x198/0x270
>[  243.686493] [c000000016657de0] [c00000001002ec60] syscall_exit_prepare+=
0x70/0x180
>[  243.686505] [c000000016657e10] [c00000001000bf7c] system_call_vectored_=
common+0xfc/0x280
>[  243.686520] --- interrupt: 3000 at 0x7fffa47d5ba4
>[  243.686528] NIP:  00007fffa47d5ba4 LR: 0000000000000000 CTR: 0000000000=
000000
>[  243.686538] REGS: c000000016657e80 TRAP: 3000   Not tainted  (6.1.0-rc1=
)
>[  243.686548] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42044=
440  XER: 00000000
>[  243.686572] IRQMASK: 0
>[  243.686572] GPR00: 0000000000000006 00007ffffa606710 00007fffa48e7200 0=
000000000000000
>[  243.686572] GPR04: 0000000000000002 000000000000000a 0000000000000000 0=
000000000000001
>[  243.686572] GPR08: 000001000c172dd0 0000000000000000 0000000000000000 0=
000000000000000
>[  243.686572] GPR12: 0000000000000000 00007fffa4ff4bc0 0000000000000000 0=
000000000000000
>[  243.686572] GPR16: 0000000000000000 0000000000000000 0000000000000000 0=
000000000000000
>[  243.686572] GPR20: 0000000132dfdc50 000000000000000e 0000000000189375 0=
000000000000000
>[  243.686572] GPR24: 00007ffffa606ae0 0000000000000005 000001000c185490 0=
00001000c172570
>[  243.686572] GPR28: 000001000c172990 000001000c184850 000001000c172e00 0=
0007fffa4fedd98
>[  243.686683] NIP [00007fffa47d5ba4] 0x7fffa47d5ba4
>[  243.686691] LR [0000000000000000] 0x0
>[  243.686698] --- interrupt: 3000
>[  243.686708] INFO: task kworker/u16:1:24 blocked for more than 122 secon=
ds.
>[  243.686717]       Not tainted 6.1.0-rc1 #1
>[  243.686724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
>[  243.686733] task:kworker/u16:1   state:D stack:0     pid:24    ppid:2  =
    flags:0x00000800
>[  243.686747] Workqueue: events_unbound fsnotify_mark_destroy_workfn
>[  243.686758] Call Trace:
>[  243.686762] [c0000000166736e0] [c00000004fd91000] 0xc00000004fd91000 (u=
nreliable)
>[  243.686775] [c0000000166738d0] [c00000001001dec0] __switch_to+0x130/0x2=
20
>[  243.686788] [c000000016673930] [c000000010f607b8] __schedule+0x1f8/0x58=
0
>[  243.686801] [c0000000166739e0] [c000000010f60bb4] schedule+0x74/0x140
>[  243.686814] [c000000016673a50] [c000000010f699b8] schedule_timeout+0x16=
8/0x1c0
>[  243.686827] [c000000016673b20] [c000000010f61de8] __wait_for_common+0x1=
48/0x360
>[  243.686840] [c000000016673bc0] [c000000010210840] __synchronize_srcu.pa=
rt.0+0xa0/0xe0
>[  243.686855] [c000000016673c30] [c0000000105f2c64] fsnotify_mark_destroy=
_workfn+0xc4/0x1a0
>[  243.686868] [c000000016673ca0] [c000000010174ea8] process_one_work+0x2a=
8/0x570
>[  243.686882] [c000000016673d40] [c000000010175208] worker_thread+0x98/0x=
5e0
>[  243.686895] [c000000016673dc0] [c0000000101828d4] kthread+0x124/0x130
>[  243.686908] [c000000016673e10] [c00000001000cd40] ret_from_kernel_threa=
d+0x5c/0x64
>[  366.566274] INFO: task systemd:1 blocked for more than 245 seconds.
>[  366.566298]       Not tainted 6.1.0-rc1 #1
>[  366.566305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
>[  366.566314] task:systemd         state:D stack:0     pid:1     ppid:0  =
    flags:0x00042000
>[  366.566329] Call Trace:
>...
>
>In that case, note that maxcpus=3D1 instead of nr_cpus=3D1 is used in the
>kernel command line on the PowerPC platform. Consequently, the crash cpu
>is the only onlined cpu in the kdump kernel, but with its logical id not
>necessary 0. While SRCU queues a sdp->work on cpu 0, on which no worker
>thread is created, so sdp->work will be never executed and
>__synchronize_srcu() can not be completed.
>
>Tackle this issue by queueing sdp->work on the first onlined cpu.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>Cc: Josh Triplett <josh@joshtriplett.org>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>To: rcu@vger.kernel.org
>---
> kernel/rcu/srcutree.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 1c304fec89c0..f2df561e0995 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -663,7 +663,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
> 	int state;
>=20
> 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
>-		sdp =3D per_cpu_ptr(ssp->sda, 0);
>+		sdp =3D per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));
> 	else
> 		sdp =3D this_cpu_ptr(ssp->sda);
> 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
>@@ -774,7 +774,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> 	/* Initiate callback invocation as needed. */
> 	ss_state =3D smp_load_acquire(&ssp->srcu_size_state);
> 	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
>-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
>+		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda,
>+					cpumask_first(cpu_online_mask)), cbdelay);
> 	} else {
> 		idx =3D rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> 		srcu_for_each_node_breadth_first(ssp, snp) {
>@@ -1093,7 +1094,7 @@ static unsigned long srcu_gp_start_if_needed(struct =
srcu_struct *ssp,
> 	idx =3D srcu_read_lock(ssp);
> 	ss_state =3D smp_load_acquire(&ssp->srcu_size_state);
> 	if (ss_state < SRCU_SIZE_WAIT_CALL)
>-		sdp =3D per_cpu_ptr(ssp->sda, 0);
>+		sdp =3D per_cpu_ptr(ssp->sda, cpumask_first(cpu_online_mask));

Hi Pingfan

If CPU0 support hotplug.
For example , in this time cpumask_first(cpu_online_mask) return 0

> 	else
> 		sdp =3D raw_cpu_ptr(ssp->sda);
> 	spin_lock_irqsave_sdp_contention(sdp, &flags);
>@@ -1429,7 +1430,8 @@ void srcu_barrier(struct srcu_struct *ssp)
>=20
> 	idx =3D srcu_read_lock(ssp);
> 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
>-		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
>+		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,
>+					cpumask_first(cpu_online_mask)));

Due to CPU hotplug, CPU0 have been offline, assume srcu_size_state is still=
 SRCU_SIZE_WAIT_CALL.
in this time, cpumask_first(cpu_online_mask) not return 0,  this will cause=
 the srcu barrier to return directly.

Thanks
Zqiang


> 	else
> 		for_each_possible_cpu(cpu)
> 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
>--=20
>2.31.1

