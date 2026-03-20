Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E0344D81;
	Fri, 20 Mar 2026 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040551; cv=fail; b=btLt2Jsp0Efbdfhjwf8AmdCsVU65qsoPFCH74lpjFYAVZ+YjQuILqo9y18pU9/MSWqF5a50AFi+x37GaxFXirGq2honnvCOcKKJ1xwH2jFOgfijLfctP6kwGpRuEWkXC5+SP4rQPvPW5QuoruOo6hKC1qtnCl+Z2p3WyYcjrb08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040551; c=relaxed/simple;
	bh=aO1SzSHYiGCVrnWSr9mtTIKUPsm7qYFEv/HCPgrAXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QajhKrzNT/uhI8y6uFHNdJqo9ne2vU4BhVmsp2rf+WuMYjvAOAwH2OKA7o77q063kS3Fl0Io/Zpfhbj8X/FZpli7soprOEXt73CmnkZ5POOCy86fygDv7SsYsdYNn34F6X4FEH8IIhBi3DGa33QfyFQ+hp6qG2RzJJcKBo/a+uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2zLn+dB; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2zLn+dB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG0q5OM+/J1xeGJ8L2pgK38z3hmeo9BeeqzlY7fjb6FQO2hDnrTWzBDf1/hRC/EHP3xG1YuL3eN6TtS97Nx5Y/CRprLUlNrPaHGE/Jdj5VhQ9kFGiRNZj20zJGIA3G1b8Xv2yZoXDj1pIPduoxBimioXg2mUDJD6sM8ud92wOTqvTiNQWqpyoVDNKPnLznhBLhw55rb+EXkVm0iD0R5fMCtoD2+woFVYaYWHxho3vo/G2WbPPs208viki/yy08FNcFpDNWQyWPTLpTwa3nhFE+LJz3lCXX8cTVw/lww+5e/PE6WWybRVMZia0D+zBUKH3pMjZei43YDzNoVDbWM3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGOPqGP7ZKmo/gTC5C0lrPxjhF0rVZHWhZ7kb5hTvEA=;
 b=H0jFzVVxuRtnqzpWssXihX94+w3VO+8WaRGDS8Q2npXi26IR9bzaH8wmA6KVkiRiu0U0b+X2zbRQGDaEHJ80CZX8R1hhXgTMi03QhRpHRzXZVUuuKh8CoKOUvmcu8L3DQbZ57wNsA9t6C1IJgTrL3ZqpnLpsfDOyVynuLGZ9lM26hzYEEG8mlrv0Bz47DryY+C4zD/ByffzM3c7VA0Q50rxCrk907MklFGzmUyazITT/I6wjeGHcH5fOhs1wkv5B81T9GzkoB23cXUrqSGBSkC8zypxajAm901V96OIQJZkSy/0PI7z+zvcdyA9ddTcr4TPUU8aWcKlB7JTtdPtGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGOPqGP7ZKmo/gTC5C0lrPxjhF0rVZHWhZ7kb5hTvEA=;
 b=h2zLn+dBsvdQuxe2McgEo8/R3QY6nO5ax92VYsQ6yEVxn3rXqmLE6xnbw6N4D4KFERDWG+vudgeI+x7o0HPyNLH/6lxP7aUlN3+yJ1RR0R7j5gkdD2DWdR1I6uktJwfPGGHrXjZcoiW6iCJZ/FbdTW1fkEQvHNeFg5b0ASwTeSFPc4wfK52KNYKLqx7nfN3IR1BE2oQ1qenKAYL48Ctk6Ah/3eJ+CIEo8xkYMjm3WG72JidUXUbFdfwWdkpuFdi+HZQGT6/cS6rjsVDvJXmWz5rTgmvtH+qp/H534+9ZLqrY2irjemaXF5nCAq/YeW2SMWJ2jB2cMMOIqnznmsz9Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 21:02:21 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 21:02:20 +0000
Date: Fri, 20 Mar 2026 22:02:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <ab211KSqJI9gzTUd@gpd4>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <ab2yd35rm6OgZUmb@gpd4>
 <ab2z6XRzTajNADK2@tardis.local>
 <ab21dx-Z1zE-TI4s@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab21dx-Z1zE-TI4s@gpd4>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: b855b888-bab1-42b9-e15f-08de86c3f9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v5KK992Hyvj7MDveOndZPci0ExUioHZ5ZpQ4vr37UgmlG86fbOQykl8ZhdniI/14Gr4hzTAOt9xBi9SMhtjyh3KQ/Bfr5yiNcUnyaTy32QWpqzUqhszAGEz3l5ydBNkEcZjdAplUVm9LboXFPr9jpyIahAZYx5d3J4nCrd+o7P2l8hzF8wA7x38H9w3iKtuz60q2umyGpE39pYZUKZw8sfOY0RychGVqVX6QsmhUxg/yag6J/NopgCkbkdwDlUQZd/c/BYEQVCKJcA19Z4KspZPWdm5vUKegxv23TqYa0VSuGhOie+dbmsK3S2h0unAHRkJFtFYIk3BrhgWrcHg4rDkZ9Ri4/77sFj9XNW0Zlale7WSl/RNvN3aGVakh3exImq7pECobTmEL+B+dQscSh+F69/fAKk8ymmP2j37yLGN18ZLnxp0rLz8jzG/QNXBCma1QfR/QfYIMmzuUwdRWgMxvbNJBfp5MDwdNcFt7ngQm05/umuDTJILizQo0gDt9dcUAnLyY4WNpJEx8//j+TSVfNqy1NevUZ6G33uIdOyix7VzM/PaMudXR2kbf2/bPxIvdc692Qq8tBbiT75e3RXYq/xY+5itMny98Pb43VxA/CDi9XmsCRnbKUJXQDaaHfVRM56XTxGUSj3jq1gu5XgxDztgN6kbVVaRv9AZ+DNTHp2UF3A+ZFhk9QZhg3fJD/gzNrxzNbN+HnG3BOV2Dz1IIS0cZisBsNv/7hDluomoRPpjtLW5B1huIx0RkAFgX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m1gE4Dcfe+kclpDK7FqMgeLBoJ3doUFUJnt9+igZj2CEMalDTzlqvvQTVMxM?=
 =?us-ascii?Q?SLsxFIxlIAzwMPeoFm705kPN94S4P7/NXBsFPLYcoPQ6mhgqUmDVzhaCIeEr?=
 =?us-ascii?Q?Qt/fkaPIsw82VuznGu1zcTI8A6a8a8dDxGU/sXPmeAh9HmDyA1gGuRZPdjuD?=
 =?us-ascii?Q?eosKgpCbCIthG7hEWDUXeGbG7aIUfhOU4NOkczKzoqQCGKfbB1/h14Tb1rOM?=
 =?us-ascii?Q?9GPSaYwVTVvgN2dWVOTAhoeKoq5hD3H6J2DPWEWhv6bd34Ny9KRmDKfH70Ou?=
 =?us-ascii?Q?LX7tzHvyEzlmdL6qDTDNdPH62cRQfoOQHDHNNhtMeMf8lLWp6zQEWDh6u3bx?=
 =?us-ascii?Q?NxUN3v4Nq2Qj6MLOpWav9lSGQ6MSW9a+KjQwZ7HfTbs0SSdC64ob8nPKWUxu?=
 =?us-ascii?Q?/NAJpvNL9SE/guPi7pGOktx6ix9YaKmwXchYxsFng1U/irQt11cSyv1fRp+f?=
 =?us-ascii?Q?hQKqbg+gTC3wfro015/J4S1G6tPyHiOKh1PRmm8ilaiq0aR4iVGOIEXomQEa?=
 =?us-ascii?Q?sBPiID4/uaeq/Uykbzc5ZFb7xZYPOtBQ5tnKsZ+L3Y+3TsI/Ox5siImpdWqB?=
 =?us-ascii?Q?GlLT+jqm1HOAS3ncHtfLRXEF9J4to0nLEiu5XUYbmiZukYZmpzWjB6BAHpA5?=
 =?us-ascii?Q?lAcp3QJCM25qgkisOl4+q2M02fuZoAFGcWPRpNjKTSWVlXUBqtUvnmdl3bmq?=
 =?us-ascii?Q?1rgioD5uPlwxtiWwI4izWrhkGDnbE2mnJ92s4PTR1HQE3ud0v+bGfFMF2WSw?=
 =?us-ascii?Q?7Jqn61Jv4sn3qE1q7T2uO0eIsDKaWdGgJtK5NX6Bxz71efjGBTYbEXmgwBP2?=
 =?us-ascii?Q?JhrOH5HlLnLNflQomz9M8aPS3xXxGs2tQYFgSnrXrQS7X57M9/qBxDAdxts/?=
 =?us-ascii?Q?DWV4zOoDHr45frvYdu3sWwLYvJlV+HxTKYnpKNY/OKHNBfPtZ+qWBlnhXgpq?=
 =?us-ascii?Q?05x+fjDZ8W9mcdjmg6GLvrLpJr6rV3/HwIQr7mOFovca49LmmG95InHAhs+5?=
 =?us-ascii?Q?WKXIL9zklrGgG+kIka/o3MtIyiTk8naSFcX7DmMjcBSdLp7eFZ6LsUDvjGNO?=
 =?us-ascii?Q?CME8zAJS4gD37z+vqb2M26PdYYUr2Lsx3QRdy3bTMSoCfdn5Gw0p6wfxzWEb?=
 =?us-ascii?Q?BLkcy3pSL3JjnCGXg41s9ojZLBs1hlbPaSs8ayw+xfdPmt/QR/MI/4mjXigK?=
 =?us-ascii?Q?g0Xo+Jc7TqL1NFBzHrN6LGddv1Cm+mRpkDTk6FD9uufB+9NSNWztL/wie0UF?=
 =?us-ascii?Q?cp3LXN3CcRf2NeviJKaSW94LZ5iW6M1zuZjU0FAxyIOyEUO88X3uLp2z2Gbi?=
 =?us-ascii?Q?AGRIHJOG9xUYCCxGz4h2Mqe3Ew1Ouxzy6zCl7JyToy19rIYq6+vjsotOGuf3?=
 =?us-ascii?Q?z2e/4OhDW9Rolyosf5DsrvBOLqgZQxPAzarYDAN64vt3C3vD12UVuvPdlFyZ?=
 =?us-ascii?Q?Eyz2O4fboWBrm6eoT8SWO938HSbx4r7TXOsJZQHxLHgMAkgeEh1ogXVD/0cy?=
 =?us-ascii?Q?kBtxf5xIGOLJDS1KVvo8t2KKPbgdnKJ17UlfAbld1Xn02JI96V8ey/u/aJhp?=
 =?us-ascii?Q?ADXfBQV+k8rxj3LROfpaShPPJ+7SM3g6PPjwPHf0GYg2gzMz1hr7uoxSd2Z5?=
 =?us-ascii?Q?Rn3EnGVmErhjeElodavtxN7C3rvKyd4cNG//W7h7bwiLix4IC7Ms5kvZOSUf?=
 =?us-ascii?Q?9Hmh9T0MSs08s+MuHmFY45P0LezsOhsiYWwM62C9tjBIxuwWeZI23etspd5B?=
 =?us-ascii?Q?JaUIDugZbg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b855b888-bab1-42b9-e15f-08de86c3f9be
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:02:20.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESAYS6VnsKWpKFz9VCWVN928fPdS7DxJzY6VDZiSepYSqeV7wSLKCXpPsKYG+3lVlxkC/RNgVuxncRXp+3zBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Fri, Mar 20, 2026 at 10:00:47PM +0100, Andrea Righi wrote:
> On Fri, Mar 20, 2026 at 01:54:01PM -0700, Boqun Feng wrote:
> > On Fri, Mar 20, 2026 at 09:47:51PM +0100, Andrea Righi wrote:
> > > Hi Boqun,
> > > 
> > > On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> > > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > > happen basically everywhere (including where a scheduler lock is held),
> > > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > > the work to start process_srcu().
> > > > 
> > > > [boqun: Apply Joel's feedback]
> > > > 
> > > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > > ---
> > > > @Zqiang, I put your name as Suggested-by because you proposed the same
> > > > idea, let me know if you rather not have it.
> > > > 
> > > > @Joel, I did two updates (including your test feedback, other one is
> > > > call irq_work_sync() when we clean the srcu_struct), please give it a
> > > > try.
> > > 
> > > I'm getting this at boot with this patch applied (testing directly from
> > > Joel's branch rcu/dev):
> > > 
> > > [    0.639477] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> > 
> > My bad, this is missing:
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 73aef361a524..e08aaacad695 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1993,13 +1993,14 @@ static void srcu_irq_work(struct irq_work *work)
> >         struct srcu_struct *ssp;
> >         struct srcu_usage *sup;
> >         unsigned long delay;
> > +       unsigned long flags;
> > 
> >         sup = container_of(work, struct srcu_usage, irq_work);
> >         ssp = sup->srcu_ssp;
> > 
> > -       raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> > +       raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
> >         delay = srcu_get_delay(ssp);
> > -       raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> > +       raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
> > 
> >         queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> >  }
> 
> Ah yes, much better with this one. :) And I confirm that it fixes the
> initial locking issue that I reported.

Forgot to add my:

Tested-by: Andrea Righi <arighi@nvidia.com>

-Andrea
