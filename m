Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FD2EA481;
	Fri, 20 Mar 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040453; cv=fail; b=rZTMpJYwfT9KtumnR63Zzmk7ZbBvTfReuXNouM+Bl4TAIVid4OSHWlIrVmoW4j/x7emPvB0AJ2nAdf4Ct6yEfDaafT2HGYQPYgH+oHQ/DI0pvWzuYiAae48yZkPya5RIp1rLWYN2PeZAVf57VWJFravIPI5+STOovcuHMHi6JEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040453; c=relaxed/simple;
	bh=XcIrbcBqJaJW/JJfrxscvtVeYolTWysHQf/Noovoj54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKv8HfEqLKswqh2UVzyElyU8/TV++RHTBUab4SAH+PSf/5mB5XbxO82QqEhS5LeKeA3DARQj6vQ0UVqAganjMW/5+wcIkvQZtRpWaM4VmR9bCNNyVDKwwBZXlGzy3vgqRLUAjNP3poTf5YvQXruznHYuHtqgoeHA9USdvSBSBjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBXIjNsz; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBXIjNsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTSsoGJ3arjRJp3iKTqK62PSLxrP1xNBY/wGZ4At5oamvPMx9e8sWth3HEH43l3gQdjkb94l4EgxYt72K6k0e0w2e5WOmfIBE07mn1N2yW4G52YtLjf+nf3QQ05aeOblkttqP76sOKo254j1w3uhmQFtLEISUa+F7u8Zo+5hgVX415IgB1F6wi8WxclHkUVLVzOU1Ec8cLOdTzZ8jBD0rs7yAMq20io4vZ/9HNZJI86/mIcddyzXUop1h9qX7gHjRWZWq5yAPY/g5WxlluPNs6LdBWAiUvjW6RaF5XriKvZksRMRVPTOGmmZ/GPNisqqXHv3p5VdA/irGJ6RTyMTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/4bEjDxkqm6nmFCNFUSAd2zVi2GvL384OZ+TCT3UZM=;
 b=yCnNRP8ckJPfgF8I3luYXJWyUdb1pd35ypqaiOsw50diydSQFBiU3N1xd7xDYP+CwSKzXYHoMRCKsgZcp3jW5wm+UYZ+GE6fzq3DZLOPlyxaF27q7rMzudbo44MSj+5W968eRJVpiqedoaXSUr2ozqyosRRjvVW8YA3GNpWOvxX6Y3/Ag38+2R6P9Jjhs8RrWkM/XOyZ+/Wi6iao9eiRBDnIJAcCIJLXpvCAo7wCRMEAPQjEvZfRFAWLCmTT6azYpkJtUGgyuD0XljyedYvt6V+QBFSjkP8pI31Kre/qy6ghCfhoqtz37XfAl579BruGg9F/9kcqh3RQtu+AluXAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/4bEjDxkqm6nmFCNFUSAd2zVi2GvL384OZ+TCT3UZM=;
 b=SBXIjNszacOg5YqlB9HkF8sooDT/OuDKp5TYq2/YHWYZFrMI946BLa9O3RRLCymd4BKXjHTMjhZSrcUl4MXGYCMgsB25q9Oe4Md8Tux7/aGNjY+ZvWS+j3QSVrgUBADMGPuNf7ShoUudTaVf8zauClgjbpaJljaw4QXZRgdQOrO0l8/6ClvN8Y54QFKO0E8TeTfgKfqJxr/82YYZYJWq3SlpTp8i2hycPpf+NNb7IJyWYa2mNvpk7MBZeGi5125Y+Y4hyHn871zerHVXalREbiqeNo5jgz0Y6fgx2QdXdsBgILa2o9XfD7eDiB5hERtqOwoSiuvClb/82Bv4BzdQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 21:00:46 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 21:00:46 +0000
Date: Fri, 20 Mar 2026 22:00:39 +0100
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
Message-ID: <ab21dx-Z1zE-TI4s@gpd4>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <ab2yd35rm6OgZUmb@gpd4>
 <ab2z6XRzTajNADK2@tardis.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2z6XRzTajNADK2@tardis.local>
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: fe51ed94-bcf5-44e2-29ae-08de86c3c207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IL7MHloBImbWnBEXy0WVzlNnRjyP/RB9hxuqOyXX7ufHLiR2lemTHYyQYAfCnKzuS6p3U3KWNbgKMmjm90M7o1q60gYjaunowndTfaCsVKI39meZ/cBPbBL6fEhM2kon+/1Ene7cNINWERjncTzTL92l6H8UocgxS+h/VsCjArWpM2TqwYUzYxSKj+QCQIlx3k43UD4T8wRzaQFUNOaKbaUecXwJwAQBYnVI4xwBf75WGuYgTSzg7g9Hl2bKjtpH+FpA9csaOv1FqqKa1OY/xuSmndK0aD1N6KlDMwr/iXFJAPB01odX480zk7S/u9wesjEb57VSoZfYCVZB65FbWvIJRjqNCE3xPvmCeHI8ZFQWrAH5ipk71EI1GOV2z7KsLIxYXUFPTlMPgnOoo48txXUDFcmUlxnVbZjeXe1+S67azgfJ3sCBQE9Vc2eo2hmuuRs+pJDWGcD8GzgLDmwM/DOJ7V/u4QWW0UWo6qxbI4AqUIdR/Yic9mJSgd/UUBXomoxAw1aNa0YlnmTPV7e23qCRKUhvaExs7FOlk528Z6pCNbO/Det3BWsMrgUUiccV7C3I1W6oJ0tNATRK1hXrYWpS60piKF7tLair1wDOjuYfltgVMCwE4A6grh4tykTAYCdXHDrSg806XMmD9yVHcJkWkmqZOhfql3bV6zEjDcSaA/r0GH7QLMXcaC9w8AWijVjUY7VaDQa+TWM5Q/YGL4sBHSq7ivg6IlFDP2PgucsctRzQYSpMCXKgEWz0OmF7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEEaV/4fFwAu0si55g2uHWIqJxIB3Wfycj2AhhI4Egb1qT/7MyQH3ebGctRP?=
 =?us-ascii?Q?gNyEzNc04xgPhAuQgm5w1/P3jhzMSe/lnDh7P6ELXUeRDB07V+u4ajYq4EvQ?=
 =?us-ascii?Q?w+hxNdxlOAMDi6+4szdhEPTpGdJqre1nptp7GK4qP6H8l1oS0XIBmPojeeRX?=
 =?us-ascii?Q?8B1VZ7QlN3FJIWxsfMOa5AU6goZTVnAdzz9OoR/qrfZGNQYI0LbAlWHgXdAc?=
 =?us-ascii?Q?EN+BgRaAePjsQl43cA9YbWRlxJxUer7yrmPgh1JsigsfHCpn3OtEEB90B1g+?=
 =?us-ascii?Q?xm+6e42Hy2gVbVBYt2f5FPRrta6cbAI8Owm9iB9L+8WUDOX2/7LFSN6QezY9?=
 =?us-ascii?Q?4817NtLIYuIAjsWteepRQai6ZwKnj4IzT61fKjUDNOHfvfSMfHTKD8wAVrvG?=
 =?us-ascii?Q?sDIGo1KgHjsTitM5FC4Zx6tPSRVMSRkZIIB/CXYBCguIT8vwb0dnP3tjx1FR?=
 =?us-ascii?Q?d3sZl/9QFELgqPnN2/tYAdYJVLYXt8r6O9kujM9piQDLr+MckfYcUc8qXMYZ?=
 =?us-ascii?Q?+k/XjbxNT1ZWuA0mT3LBqSTvVsMNRcHA0rXsiZbYR1xmKlRiVuJTteA0eqwq?=
 =?us-ascii?Q?sfuTIJ0tqu+SDleRXPD0jmER8ThywZVzi0WO4dMW/9OLO0+AAqKwSEMSEUNE?=
 =?us-ascii?Q?4nl50NSekI1PztClUNEFpNDtkr5aURoo9VQucu/oPD3utS8evtja5BgBY1Ai?=
 =?us-ascii?Q?qRIfrLqNQ2Er0hkjtOm+1seJ7qBC2tBgVzU7CXLUnPuo6P9bbexaTIy2X58M?=
 =?us-ascii?Q?db8psA9bT/KOzMw/D8OFq7T3g5mHxSp9rPG+tS1EOynpcuPrWckc7OU+hp3Q?=
 =?us-ascii?Q?7fbLmjzoDEeDLuECRqJos7WR52Wm9gsxC6MXDsh6gL3PB7/wZVY+UvTFvXk4?=
 =?us-ascii?Q?dYKcIBvaUxz+Jrr3t7ZU+ZFYVb2g/1F9gl4/JxApoF5h926RSu+1wN8vEQ7g?=
 =?us-ascii?Q?KKZC+YLUPYarUwsSVeJzul1fA4AnZ4GbeMTAO5ysO8fVqg3ByVCw/E6CCAx7?=
 =?us-ascii?Q?cpS275lDSj5P/enxkrz/m8A5y3tKucueNm2C68281Jp09uBVZgVJouugQ9NC?=
 =?us-ascii?Q?2ratMXu3uQMBozF5EMh0K19Lc6PzatG0mVG9dPwO5tPMs000LM3eQVGglLdI?=
 =?us-ascii?Q?b9M1x1iPH6HExlwQfRRsWFoA9l/WO5IT+m8ykjdpiaXg48wdPUtLmwS/p9aG?=
 =?us-ascii?Q?DSmUamjgnsWvkpc2gHzx/n+YiygA8MpeKisWpYoNwS1HPG9VIUOg9qNMj0FG?=
 =?us-ascii?Q?q83+9ijCflXVKv/LcSf7R8Rc2c88tnGao4E/sgoANQLuNZWwyLdnbWDGynzM?=
 =?us-ascii?Q?TlKk6Mjf4YLgchyNgzNZSCXUPe33IU9r1A5JwKGHex2raNZJZoopL+pBTsHl?=
 =?us-ascii?Q?NliOq3BSdKOwrTEsNBOhJ6z/8E3f7ckQeqgOl8444hO+ODIF93Rx1yhAvUEO?=
 =?us-ascii?Q?YbM04ZhWHkvyVa/l2poa0juyMq691YOUDZKKaSlTuUzdinY/7Hxtas1fM5qM?=
 =?us-ascii?Q?xIteCg/DAtvdFhWBR1ThEL3+XW4DwUpJEi3PRikTOvap+r22+PAFkw9ESAXc?=
 =?us-ascii?Q?IqouzhTYIHwkbv1aQqQm5pRM4yn/fNMSPePwMfnB0FTAg1xvVroTtPkus24u?=
 =?us-ascii?Q?WZjHJN1C0Yf7dccdIkn2QKXyiH2ho/dK3QFTDQnMDPcPsa6SOhH3RzyjFfSX?=
 =?us-ascii?Q?GqoryL1X2SMVBRslDvkXhwoOI62MQVWYq8nznS+/6/MdkBoTFS989fQCX124?=
 =?us-ascii?Q?fH4bFg5OWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe51ed94-bcf5-44e2-29ae-08de86c3c207
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:00:46.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EULUX/gvTcPoOmo1r0cM3yDWuBJq8VjrYFESeB8Tc8Ckg3uZ1bjP1qiqm3jdc10o1SBxqQUTjMdj9hclBFbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

On Fri, Mar 20, 2026 at 01:54:01PM -0700, Boqun Feng wrote:
> On Fri, Mar 20, 2026 at 09:47:51PM +0100, Andrea Righi wrote:
> > Hi Boqun,
> > 
> > On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > happen basically everywhere (including where a scheduler lock is held),
> > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > the work to start process_srcu().
> > > 
> > > [boqun: Apply Joel's feedback]
> > > 
> > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > ---
> > > @Zqiang, I put your name as Suggested-by because you proposed the same
> > > idea, let me know if you rather not have it.
> > > 
> > > @Joel, I did two updates (including your test feedback, other one is
> > > call irq_work_sync() when we clean the srcu_struct), please give it a
> > > try.
> > 
> > I'm getting this at boot with this patch applied (testing directly from
> > Joel's branch rcu/dev):
> > 
> > [    0.639477] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> 
> My bad, this is missing:
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 73aef361a524..e08aaacad695 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1993,13 +1993,14 @@ static void srcu_irq_work(struct irq_work *work)
>         struct srcu_struct *ssp;
>         struct srcu_usage *sup;
>         unsigned long delay;
> +       unsigned long flags;
> 
>         sup = container_of(work, struct srcu_usage, irq_work);
>         ssp = sup->srcu_ssp;
> 
> -       raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> +       raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
>         delay = srcu_get_delay(ssp);
> -       raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> +       raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
> 
>         queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
>  }

Ah yes, much better with this one. :) And I confirm that it fixes the
initial locking issue that I reported.

Thanks!
-Andrea
