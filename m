Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412986;
	b=0joNsYLh5qHUl5y4DBPVxq879A7qx5ey1lxnEiJhxq4WNgk1vNzgJT1MZySbbHEWdAXs
	 TG+H7zMgb+4cfcoXV8DyWz/EiYSkQyNJIIm59+QeFWp0T0YPRvwCIiJ88SucWKlOweDhb
	 AC4WW/3ZIk/kx1ed0BA+0jA3Hip6pYmkJG2y94tdSmLP+Y4NSXhwTlek/20H1Mek7OTSO
	 Vn+OaGERVPCADKLhhc3UP2/uFHBGwvi4q0zNSCtU0HJZs7L+sIpyIlAKgCgjGEhgJUrtB
	 7pYmOTYvCjPbw+KIsOobRlQ2vszkGHeWS1rVKaGCb/BGPDIBpSFFLtbPGXZ4qSw40LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412986;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+RtG4uStW5bYFZiSIFBD6woS2FFtGOizshnKMZU8ZB4=;
	b=OTotBHec/THPs0I+51dQEY8TjpzmCh6b7eofSU1DHbl1Ogt2kmbBGxmcMvsQ3CbX8Qct
	 3IUneqkGYS/mjhCHXl74hc1EVKc9v0QN/O7LszkMmdYBaclpizHWjdUhCscBybDTd5wL9
	 Qtv+PnAw9+N7CHK2/OjK4+gu9yKsu9UxMIYSwVWrga4lRbEdR+D6yyDdykOug7yDregB7
	 ZCo6DOvvvQYEU2lIIAeeBa2de8dsbKe9SDWT94jtBxR7jak51cVPU4TqjU+dJsoLIiiZ8
	 Eag94zn94WkDFPDnO5iWsAfNeQmI3JVwtJv4YWyvkYJQwOlr4J6WB2TWig9ZfcV7xSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OIfpw8Ry;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.32
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502F606A32E;
	Wed, 11 Nov 2026 16:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A502F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OIfpw8Ry
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDlPoIAaj9uM3oJWHs8KGWEGAoOZstg2dfarOSJLyX7PXMtOk3cgWBPlPEGU/fn8AR9ji4N51lCVxZTgpJ4DJiE1sYHsSW6DI4+sEGHjbxSi0cKOkZ4VJNTMozX2nEWlMIW4/uEveYLZZVXTe/9nUYsx9ksIZTKAF4fRMqo7F8w+3O6MoIByO5IJKAsnccxL0dZfMZ6UOO16XHGZCFwntV7iuvQ5d/O8ie/sTXBfWbLEEMmh9DG8sFlrSJJvumgvehWHjI+vMyb5e3NC4OqhzBGyusMh3BX2Lj6DpB+Ez/Ex9TaKJbHjMp2bchKuxIMX7MK3yaRFLpJrD8UqfoP9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RtG4uStW5bYFZiSIFBD6woS2FFtGOizshnKMZU8ZB4=;
 b=BaSmGUfMFpOW5OpVpAmGhQ3HPGG6bPh1jMIEYWAmiTzKeF/o0EiLtBNfv4b4h8q20YXywngTuA5sn5LSwyVs4UWmQQtbxDXZotgVnMWXxBWjGpzZKtTAe3wPymZSEb/5BtEaQzMxiohIXU2wU29l7H2kaGwSyc7iSlQ76AaXFNHtLhWFex0N2Fp09S4Gbm6Ce4DFT+Vxwga8/JG6sPqU7oEzBsX/4boTRRXXXpcHosJauPso6XC1ZWAzoHouGCBWoJbh1ZEi1zXpp2aspR3zzOYZFhog88an19vRh/UMdBbvR1MtwbiAPHDcpLPc6bb0aQ36vU0kCC3ZiLbOFToYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RtG4uStW5bYFZiSIFBD6woS2FFtGOizshnKMZU8ZB4=;
 b=OIfpw8Ry+DPDX1HeLsUSqwx3+7Ze16apSyOhQoGfV5cvR83a2hUY996Svno8EzsapIChb4yX02Rh8Q9fQn+NMRXc4QgXTt1LZ1qMEMtRbZ0evFWLFKk3NjLB4KPomIR8a5Fn78gJgqVaoXAjxQJe7cNIx+ZpgiR737BfvYuCeKa9Knibskx/Tpt25SkBnH15cI82hF6iIHR7HceWci023Gil1EHr0BKCbBrK3YjvQo08lsMw1urhOW/QqAJsy2k9j9NGkzUB8yrg1xbzs9o58hbO4qja03qOpxMY+/zTB+jV0+ThXa6UDa+2S16+wRcGj2gCP2hL6x+r0JBCh7WStg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 16:03:01 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:03:01 +0000
Date: Wed, 11 Nov 2026 11:02:59 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, urezki@gmail.com, boqun@kernel.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Update recent RCU/SRCU API additions to
 whatisRCU.rst
Message-ID: <20261111160259.GA2180138@joelbox>
References: <20261019122209.15604-1-qiang.zhang@linux.dev>
 <20261019122209.15604-2-qiang.zhang@linux.dev>
 <25bb1aa8-7563-4fca-a17b-5a7d168b5c23@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25bb1aa8-7563-4fca-a17b-5a7d168b5c23@paulmck-laptop>
X-ClientProxiedBy: CH0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:610:b3::20) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc323a8-2e44-404e-de07-08df400d4327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|10067099003|4143699003|261009223027099003|11063799006|56012099006|261021135927099003|261102123227099003|261028144727099003|261026121527099003|261022113327099003|261021121427099003|261021130227099003|261022115727099003|261009221227099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info:
	FnlJwu+lBIaRO2dIUdzHdGEUUXvOfF3udBw4bpJOh4zpNy/ej7xRs79R7BKGoy6U7iVraHyYV8Sx5Yalr0R5BLyIAbWfmhSK4R+6y/j+kGiplDp64a64PHHKuEDfWWZZPyGTPEMCnYssAAKmcaAIxJk/TzW9jwmMlID5mVLGeXr0T0hcXOlARGBU1R0JcGpIlsaoYP+wPTqlwgS2KNNH2LLkRH/jP/q8RqeM0ilCfh631OoxbTLFVT5edG4kMX0dxu254H696/xaaNEhf/eg4691FItx1mEQKVVbpgDgERcLGnqEEiqDazWAJCBdcDXrNkSNXPIhsUvSFYR66YqhpYDUfgaKKs/S5jJQkdxor2ubbe4tLjLXwc+9kF3r0eA9X1JWyTvBAt5MbvMwtxfjMLDtZBtrPZEFCX5dJSIAK7SgzcYJI1ZDH0nA5Cyim2W6Qjk1D9+lEpD/SLJzhzBKh0yBCIOLaBaLpC6+FZNqSOH8hqTzXWtu5JH4xxXNbwVOPSIrZXmccm5ntt3qmzp68WFEAYX0ZISAorwzgWlFbNI3Ocy429S8oi/OIrNneFENssDNyBnh7sIjyyko1PPaQIK14++ZzibQsSECB57clMZKSSEkdUV+5PfHeBNQny7KXQAA7u67g7T6N6UPhiA9v3Z5BooByNKhGR7gjLfnNAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(261028144727099003)(261026121527099003)(261022113327099003)(261021121427099003)(261021130227099003)(261022115727099003)(261009221227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026130827099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TRZ2m255hCSdPvrzJIM277VM1DO5gBGiCNjAp13Y1gEVtZ+IoXSyK+cpTHra?=
 =?us-ascii?Q?3ZewVkolkmDXNScF7+WNn94kmCLu7vdMAKXX5qyCYpubZwk4DOU9OLaWWMT7?=
 =?us-ascii?Q?5EpnF2P541rY7Ec0c/r+lB0mCcl3D7vIpMmed2OftQaWLA9QECoMw4oDG0vq?=
 =?us-ascii?Q?Xia0VfdQtl0yz2Jhf3WfC7NSXZ5jLzdAjl0dAUXPVXu36Z/8/RpgIktS9k/F?=
 =?us-ascii?Q?xP/aMI8jGghAdKgWm/ppEf/wtQDR3m+q96EW1ZEDqh8Y6Q8R/EXn7qJppyz0?=
 =?us-ascii?Q?FkXVvY8eQ5hEv0HrXqo7nSYj/aKA17k8kH5iPwN7rySIlJSXY8Nu4lzL/Ggk?=
 =?us-ascii?Q?ZqMAohR7dRDwIH5FE/MlT3mXbt8Q/hvmUiYMEBjn83dUx7wF0OdYBprnyUOr?=
 =?us-ascii?Q?c3C1J8AqAS8ZCNDbZSVIFeQ9KVTSBw5ySVIPR6GcZKFG5+uZLBBS+cJGDjjX?=
 =?us-ascii?Q?t3gqpRaSOUhFAja/E0kzAHckaB/j7N4kWIAaqA1DJPSdas9gPFO/8ZtCGmxK?=
 =?us-ascii?Q?4eT4F3oaMGwXL2uui2TLJMtcgXjHC1cV84TVRrjzHRFcWjwwWo2gCIqM9p+N?=
 =?us-ascii?Q?IYo5HcLLp42vYEZs2mni83HBTX4ANqZcBJPqNAVh11IgFGCkwkAgY81wdXmt?=
 =?us-ascii?Q?VG+m+UBMf7RiFfxld+f73LN7nvNndh2tjT1zeHVJbVZFt1MUtlwyNr25AcOt?=
 =?us-ascii?Q?M3JXBjuTR01RVxsWnd+y/GzHSX8A1pxzHtEcY4MsFJ/nG7B7SEXccoQ0Oxhw?=
 =?us-ascii?Q?IoleHczg0UyaZ3ue9qcK0EeDaBLlrTpNy0f9ZxDsKxVp+9C4Ta6nnWPFo/oW?=
 =?us-ascii?Q?Il/eaaO7tX2lgL8/VasccQoQ5ot/kF1ZkXomD8oYko7euWjSX6ITlM/XP2iy?=
 =?us-ascii?Q?RT858queFg0e/PGv8wDjqin03y7oIoQHtXtcrxvQX7KzUs+4IFBwEbtqjQti?=
 =?us-ascii?Q?o2toe0zVRNX/tuKPL/FbdqoDrgmBDgPLoGeaIr6d+BO6mUUhX8F/oe5Gqkhq?=
 =?us-ascii?Q?WL7Siri8mtPWO09xNdRBAALrypuLxBNzI1kMFkElyeuRMZnttZmbVjwZVTRB?=
 =?us-ascii?Q?twZ19Wpc9IWQNH8UTA3ytu31jNra+mTMKwfG+mH9vIHfvXcyyfHFYUwiALAm?=
 =?us-ascii?Q?rkUo7OVYs7SiTrG1uFxHCXfHtPRGZz17SSClSrSYBdsmIK1PxzjGKlJWvIz3?=
 =?us-ascii?Q?TBP9oMLG2b19euPdPc5r57TZuprr8ICcFHdXq+p1zisELIiQkslUZgSXh40q?=
 =?us-ascii?Q?i1ivJ0vmxDJ5gWaju01r29IEjKlAd/nKOSlGkfMg0OXTHns0BgnIxyU3r2t0?=
 =?us-ascii?Q?Lh+4xrQ8Lft0JxmMzT/vzhQvCV/GhSpWV/OdU/HoDovnsm60B1yiAJ+dn4j/?=
 =?us-ascii?Q?0BahT+3XfU1XRZ4LBsj3VTujkAXffqC8KZca2D+f/rlQx1exxu0GRVV+zNKj?=
 =?us-ascii?Q?7qIyO5CIXl1UvlmZ+a+iTgeUUfQfm9IUWLLxv9lbeKqZvpXhj29vjRuKg7KL?=
 =?us-ascii?Q?PWFzJTxh6zZ03TjF5GwVNA+bL/7Pf6S/4cInGIjY5v2EdLJFn3IKOT0AniKZ?=
 =?us-ascii?Q?M0A97etr+qSloXFh8bjd236STFVTQLc5j9roTmJclnCsNMGXcwSYLOBXFlRE?=
 =?us-ascii?Q?CS6egwJzihFYFRpB/45qDcDLHlc8Nwo6KCClAYR8hoZGGfpslDlnpw9BSgXX?=
 =?us-ascii?Q?1BzvXQ6ypqUWTz8kjQovbzEa+vLV8MI58bX5qtNSmyjX6dNLzaUTq9AuVEIm?=
 =?us-ascii?Q?Xmav3hMSQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc323a8-2e44-404e-de07-08df400d4327
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:03:01.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5eq0Joc8TcOb0akJRDeX+RM7A6COl/4ozZhNbzdQnt7HnSHxXhBEnkC2HvkkBazSkMB9ue/Q7+s++nNrNDbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On Mon, Oct 19, 2026 at 09:44:40AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 19, 2026 at 08:22:09PM +0800, Zqiang wrote:
> > The following commit introduces some new RCU/SRCU APIs:
> > 
> > Commit 'd3f52f53a562 ("srcu: Create an SRCU-fast-updown API")'
> > Commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> > Commit 'cacadb630375 ("srcu: Add guards for notrace variants of SRCU-fast readers")'
> > Commit 'fa8a2d55139f ("srcu: Add lock guard for srcu_fast_updown flavor")'
> > Commit '954c0d741299 ("srcu: Add guards for SRCU-fast readers")'
> > 
> > This commit therefore update thems and some missing RCU related APIs
> > to whatisRCU.rst.
> > 
> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> Thank you, for both patches:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Applied with Paul's tag for v7.5.

thanks,

Joel Fernandes

> 
> > ---
> >  Documentation/RCU/whatisRCU.rst | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index e6767baff2d3..fe9dc3948690 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -1084,8 +1084,9 @@ RCU::
> >  	rcu_dereference			call_rcu
> >  	rcu_dereference_check		call_rcu_hurry
> >  	rcu_dereference_protected	kfree_rcu
> > -	rcu_read_lock_held		kvfree_rcu
> > -	rcu_read_lock_any_held		kfree_rcu_mightsleep
> > +	rcu_dereference_all		kvfree_rcu
> > +	rcu_read_lock_held		kfree_rcu_mightsleep
> > +	rcu_read_lock_any_held		kvfree_rcu_mightsleep
> >  	rcu_pointer_handoff		cond_synchronize_rcu
> >  	unrcu_pointer			cond_synchronize_rcu_full
> >  					cond_synchronize_rcu_expedited
> > @@ -1209,13 +1210,23 @@ SRCU::
> >  	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
> >  	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
> >  	srcu_read_lock_notrace		poll_state_synchronize_srcu
> > -	srcu_read_unlock_notrace
> > +	srcu_read_unlock_notrace	synchronize_srcu_atomic
> >  	srcu_down_read
> >  	srcu_up_read
> >  	srcu_down_read_fast
> >  	srcu_up_read_fast
> > +	srcu_read_lock_fast_updown
> > +	srcu_read_unlock_fast_updown
> > +	srcu_read_lock_atomic
> > +	srcu_read_unlock_atomic
> >  	guard(srcu)()
> > +	guard(srcu_fast)()
> > +	guard(srcu_fast_notrace)()
> > +	guard(srcu_fast_updown)()
> >  	scoped_guard(srcu)
> > +	scoped_guard(srcu_fast)
> > +	scoped_guard(srcu_fast_notrace)
> > +	scoped_guard(srcu_fast_updown)
> >  	srcu_read_lock_held
> >  	srcu_dereference
> >  	srcu_dereference_check
> > @@ -1229,9 +1240,16 @@ SRCU: Initialization/cleanup/ordering::
> >  	DEFINE_STATIC_SRCU
> >  	DEFINE_SRCU_FAST        // for srcu_read_lock_fast() and friends
> >  	DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
> > +	DEFINE_SRCU_FAST_UPDOWN		// for srcu_read_lock_fast_updown() and friends
> > +	DEFINE_STATIC_SRCU_FAST_UPDOWN	// for srcu_read_lock_fast_updown() and friends
> > +	DEFINE_SRCU_ATOMIC		// for srcu_read_lock_atomic() and friends
> > +	DEFINE_STATIC_SRCU_ATOMIC	// for srcu_read_lock_atomic() and friends
> >  	init_srcu_struct
> >  	init_srcu_struct_fast
> > +	init_srcu_struct_fast_updown
> > +	init_srcu_struct_atomic
> >  	cleanup_srcu_struct
> > +	smp_mb__after_srcu_read_lock
> >  	smp_mb__after_srcu_read_unlock
> >  
> >  All: lockdep-checked RCU utility APIs::
> > -- 
> > 2.17.1
> > 
