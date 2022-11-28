Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0F7C43217
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiK1OsA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiK1Orw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 09:47:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F55282
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669646871; x=1701182871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bFszrHZhrgzQary29uNyJxkDJnTGAfAOpd0NeCwSHGA=;
  b=nctmQ9ngJvr/vSpAAmNSyiBag2x7SAorCI2bCGDJQqqQkVjGNNZDYA1C
   b63VYufGaZ86Riz9DRkxwmz06Eyz1JVPTibXUlsCPppg3+1hWArW66s6Y
   PJnSFU9YRZ1le7RWwM4nwsFd2+b4r3U5UWF7Ci7qAUvjk7hCmZGSlzA5C
   kTmfX1buMjAyhttBOQwoufaipjuWi6Hw5GaBtQZBhjbmisun61tQ+AasZ
   aC1gG/RLNgot3+/xvLwDPk0IYFysGXF9r1xquy2GHdo96k3v4yRv3UIfO
   NGgwc3pgjD15k1UnKiOsiycPQ8AUKFVlZAZJ1TcetbqAZwQm3pBS4AwX2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341763013"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="341763013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:47:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676067029"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="676067029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2022 06:47:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 06:47:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 06:47:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 06:47:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 06:47:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9if+DZz76bz2NaCCHJMv6yhiPWiG9ga+GYSa0Z5wVOO0MuZNsT8c1OfRpvRD/g6T8E32yDeYWZS4Ng052g5zBuQl0SlKBgYS6wvixg2eVF8Ar1yNOVYersuePbHFqu2MoZmo1aWKcrQF9A8xqr/2DGZrzw11VnJ+DEQoLTAHKs7L2cPSrcY101042mTgKObhQgx/V+gnq2/Sa2pObKkhITqJcTiDGVZcUF2YElr8UCz9w5DKAxnn9eibufFEc/eebPRJlxKBexGx4obAEnBrJtWAMqfQPP2zui8K8W5qgCDDOYNIe2MENBRfmIvvNTyUb8RnGZLxNNk1YF034f9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swKOMV0YTJIIzGYLWy7gsHtm3d2ie4k9q6bG8X8Gxu4=;
 b=knPazPAJ5+XZddjWOsEeS471Cpj/AXrNhv/fH7jLU43Zyzbt+Pdb8t+9+EbLU9ZhQnul0mHruKWOb0Z10eZNnn8anlBcaXYHCUCz7WApHnMlF8SsbTUCmwUXF9KhPwJtI+YoGwOEMumbe28VmgO2R0Z9UXcY7gYVNTpOb+ILECGrQCWwZ+fGFE5RsgmQ5wO28bMUR622ETYRiEZb6kr5fTHtjymNW19mxuGddO7JFEGQrAworOJQarhV/nGOTEIrXfyoEB69CjygzvmWyYdCZxqpaq/YqZcmcOwwfNtC2US8oZYEuWbaSAmSMtBZLPJc4nAjLqkZDhaXO4B54QBJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:47:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 14:47:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Thread-Topic: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Thread-Index: AQHZAwNxpZWoZYYOPkq0Qajw7AIDeq5UCziQgABcSoCAAACuUA==
Date:   Mon, 28 Nov 2022 14:47:46 +0000
Message-ID: <PH0PR11MB58803CCA382FC4A50E53CBDBDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-3-kernelfans@gmail.com>
 <PH0PR11MB5880585607E73B0228D77946DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y4THX7G73KbIFi5z@piliu.users.ipa.redhat.com>
In-Reply-To: <Y4THX7G73KbIFi5z@piliu.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6436:EE_
x-ms-office365-filtering-correlation-id: 52041415-dd29-41d6-c1e9-08dad14f83cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yj4wmc4w8Q6NccMt403XS+JWPi9biU2ScEMhaIaPE6LqUdg/q/9sz0xiV9HJ2rta/LZLFr54snp4WI8BO7DDRFZT5tI50WHwaL3/0BY7Lz3ThaYjFEOtAoQJ+TtJjBgcP0QuQU8vBAyU7HNZnOEtNIFoOCaV7v8KwpEEobXo3CnI1boYdMa33N3P+gkQBbQq1YaUTt7B9FgkVifpCTmiEPAfSA7fK6OFASKCpWPDh+rGk6jKBXZCT2RyVSHDByvH2GH8QV9oLi42mM85DqQ47ukRD30l0jEtFvmHVfhh3FZSBLSYnDfiX8i5FgMf5xsGQk6GwovKXOojEF3g0XjSj0wB8Nct3Z8WwJm4v6Jp1BijWQQJcDtQ6Y7DIr/XaU4vzEgtT85DjaQJsE9ILDB2NvEsdgu9LFWdtJNhcxV1xgG7vuO9yWY8nZ9Zc7TqbDqwCWSRgXVeAHZSK78Xhh4JUHSDDxkcUmAhji4PAzMAyyZ8CQvsvLM0luqrbEwNy+YiBgt2sIUWMrGHvG2rwimGIBdO6EowhbgMa/qnICn9lcORIxzvydd8eYGTTefl3pi74lBIQWvSWP8Z0CtKGHJqtsEMNl553HeAF2XE/0dbGFw9LGCYxo/aVbCDLQMz6qBlbBlFJ2T1Gfcb40oZEhxwCxWiwRRvVTybs4iKjMo7c+5Ku35Gwvov+GGtEVDXDjLqH0h+eYW/hKKK3ZzclOPV8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(38070700005)(5660300002)(122000001)(71200400001)(38100700002)(82960400001)(6916009)(76116006)(9686003)(26005)(33656002)(55016003)(316002)(186003)(54906003)(52536014)(8936002)(64756008)(8676002)(4326008)(66446008)(86362001)(66476007)(66556008)(66946007)(7696005)(6506007)(41300700001)(478600001)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AiWGEX5VuZgkwyDWaYVCXFC98KBWaUnh1VBxxZZ4rmAumQ/qIHTsMtmfsF6I?=
 =?us-ascii?Q?W/PF/XNLMB95N/aITIQ3hFaEKLPUfcYuDLfIn6ypCEJPl2CipZYxsg0k3Yaj?=
 =?us-ascii?Q?+cOxeBtS26fYrhJVL7spXmaGXPFdEQocXekMlTxP1Tw9sMlA+p2hoVDfuf/W?=
 =?us-ascii?Q?AKhNwSOmHrhV1g2qjaqNWRluVLNcPwbunLwq9Hxnh98oecJh3TOLyI+OvU4v?=
 =?us-ascii?Q?fiGMWa4lJM+lJtW1iIohZzva6UKkeYALVJ4VjKYoURGHQOpPZtHlJrodq8ip?=
 =?us-ascii?Q?sFdR4rE3JXwF9TTMp6wCtO2gU4VOPuGUAJF85mp+e5F107mH0bWBs2ZA2qSf?=
 =?us-ascii?Q?qiW3XtN+Jyu0qC1oYyKATM7Mt3c+rJVZ459hUiZH5NdPoS1XSaDXUa3l8CLP?=
 =?us-ascii?Q?I23r4e5bXrmF5XOiayp2jIlWtVz1tCp99eI35hOBznGqJL02Sv8FMXpF/5ND?=
 =?us-ascii?Q?TpUfuZ2Ym0FPPCQGKAT/mvGx9hPWltsztN8dY/3j8f5pOdF/NEuW9Uo2TFlE?=
 =?us-ascii?Q?QEA2Qw76GEjW408aNHxqwKgNfeUB/B1bVWXqvbfnZhfTYS3k1rYlmauy+Ybc?=
 =?us-ascii?Q?c2oV1y4DHPJgxAGIozZPpV6VqkLH+IIUBngp4RDGizIJwGnpgrT9IxDKShvT?=
 =?us-ascii?Q?xeTdv79+eSB1ZyO2sH1SyB2agkJhQCFc5+bhc22NIUVhdauXizJ64ElFepQA?=
 =?us-ascii?Q?fqjdWCiUyeoErKBWCvsGcEXfAy5+zzrvyLwQSpUMsc8w885JrP5cRKCh+ocw?=
 =?us-ascii?Q?nDSmlFUe344EAyUnCek7xVQQtoUoSBoO5ZKzbi0Z84KWOmL0db2weRsz1i9o?=
 =?us-ascii?Q?DRmm2zKl7KXZKaB8Vcv0aVtknqNVELZfopg38o75MX08glcXtxzZ+Y67iVBe?=
 =?us-ascii?Q?Egl54H6EUrIs+ce5wiWGtyqi5O+1V1Udl3T7EBjhJ6jzif000FR10B9Bf1/W?=
 =?us-ascii?Q?d5Uo8wUv1OFZNL2/YbduzVAKxJ/b1tlQnEDBgh9M35tevgzRwHxZECxOQhCx?=
 =?us-ascii?Q?ICSfLMs++Zj15PfS5tbuIH3Neg41NSTMURR+mHXxaBhf7RMgtOxbR5IO+cKl?=
 =?us-ascii?Q?nZYvH9LNPk69Kes92JViyFYeUbd0MHshutujnxVa1BM3IcXNUKYUIAnz1aZc?=
 =?us-ascii?Q?0W4FPm7SYA514mBwskvk1WPYF7/aylIvq/9AzuLFFXdzhSPnj8khlSoCYW8r?=
 =?us-ascii?Q?H/7BI4CxvKNMLtF686lPtxG39G3/YsPcZPnbevClVBih9jbblgRMQRSWuyZ2?=
 =?us-ascii?Q?DBR1FwFzY/G1BnuEggfm/4fTH8b/WvkLc8+ejjtqYZzAtLF5bMEnFOwQeDNx?=
 =?us-ascii?Q?ocDbysSBRZ5QmTP7lsKqtdxvE+prFe92bKWm53FAqwGuA7629zPFsufU4aAF?=
 =?us-ascii?Q?FH9jgip5Og3GjvfK5Qb2TXFk4Yov3IAMltgi8YIokf01SBezgyhiG5h/cw1b?=
 =?us-ascii?Q?3z8osNet3ZnVMShWS2Q/lyCqzDUfL6YFqn+0+7rIMZw0kD+/L4tgnLPJijXz?=
 =?us-ascii?Q?fWbq69d+/o1rdGdCSiIRihnUIs5TuH5TxLtmESDWbOgD/2BmE9OClXr6k1ou?=
 =?us-ascii?Q?UhAt6SavkWZzVe5XXxR70e8t57DCpnnIM3uy6dJb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52041415-dd29-41d6-c1e9-08dad14f83cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 14:47:46.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyvESzNoflteeHy6GL1USG1/jbiznRlyePGh989o7tBPk/CezvSoUcZtkGkusX/SkErhr5Xz8WgxRGMWtIpSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 09:20:18AM +0000, Zhang, Qiang1 wrote:
> >Subject: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
> >
> >At present, the code chunk "Transition to big if needed" is out of the
> >lock srcu_cb_mutex, which allows the following scene:
> >
> >    srcu_gp_end() on cpu1                srcu_gp_end() on cpu2
> >
> >    init_srcu_struct_nodes()
> >    ^^  scheduled out in the middle
> >                                         init_srcu_struct_nodes()
> >                                         ^^ overwrite the context set up=
 by cpu1
>=20
> Hi Pingfan
>=20
> This scenario shouldn't happen.
> The srcu_gp_end() is invoked only in process_srcu() workfn.
> for the same ssp->work, workqueue can guaranteed that the=20
> process_srcu() workfn is executed serially. (view __queue_work () details=
)
>=20

>
>How about this:
>
>In process_one_work()
>
>  set_work_pool_and_clear_pending(work, pool->id);
>                                               -----> another ssp->work
>					       can be queued, which can raise the
>					       scenario mentioned above
>					      =20
>  worker->current_func(work);
>


Hi Pingfan

The following two code snippets ensure that this scenario  does not happen

__queue_work():=20

last_pool =3D get_work_pool(work);
        if (last_pool && last_pool !=3D pwq->pool) {
                struct worker *worker;

                raw_spin_lock(&last_pool->lock);

                worker =3D find_worker_executing_work(last_pool, work);

                if (worker && worker->current_pwq->wq =3D=3D wq) {
                        pwq =3D worker->current_pwq;

and=20
process_one_work():

collision =3D find_worker_executing_work(pool, work);
        if (unlikely(collision)) {
                move_linked_works(work, &collision->scheduled, NULL);
                return;
        }

Thanks
Zqiang

>
>Thanks,
>
	Pingfan
>=20
> Thanks
> Zqiang
>=20
>=20
> >
> >Squashing out the race window by putting the code chunk under the
> >protection of srcu_cb_mutex.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >Cc: Frederic Weisbecker <frederic@kernel.org>
> >Cc: Josh Triplett <josh@joshtriplett.org>
> >Cc: Steven Rostedt <rostedt@goodmis.org>
> >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> >To: rcu@vger.kernel.org
> >---
> > kernel/rcu/srcutree.c | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> >
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index fe0759d89c2d..281cd69fe804 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -811,6 +811,13 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > 			spin_unlock_irqrestore_rcu_node(sdp, flags);
> > 		}
> >=20
> >+	/* Transition to big if needed. */
> >+	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
> >+		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> >+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >+		else
> >+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> >+	}
> > 	/* Callback initiation done, allow grace periods after next. */
> > 	mutex_unlock(&ssp->srcu_cb_mutex);
> >=20
> >@@ -826,13 +833,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > 		spin_unlock_irq_rcu_node(ssp);
> > 	}
> >=20
> >-	/* Transition to big if needed. */
> >-	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
> >-		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> >-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >-		else
> >-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> >-	}
> > }
> >=20
> > /*
> >--=20
> >2.31.1
> >
