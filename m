Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF42E6CA6;
	Fri, 20 Mar 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039696; cv=fail; b=cokA3dz65fPjAoMOjNQE1O16lUuxuQqGUfR+jvIKlm0NI57QGuufXPBMAWd+CQ0mMi93qD6SlcghbHi5HByLOSdosSJHxrdFRASLlqN1lcMyMOV5GquyP+DUg9RTyGxlNaN4UwPvfHYe2fBxxWS5vBgMUm0c0EUs2h8GvU7uMrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039696; c=relaxed/simple;
	bh=geNMvx2iKC6mP+LfcqcpTZMfhMKCRRncMrd0YFSBMJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lakiRBqRFJsvGW6nVvCwqn7qcACCsJfmK4diSGVWi3dxi7W3Ps+2M9qtPHX4l8JkixE/HIlydLZWi1KKOStAk/cOJmfjk7DCxJMwx/q9QLcjMNhn+2R4223imJvV17LujynA0ZhgKMM29CoVqU7CGP3PiUyeNtxmqTSBiF/qLjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjAt8Wsw; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjAt8Wsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM4KcZ63hBXlWAJoft7JMyJMTSdlpuR6yiJxwHZ0iQcsNce2R5ypxrMPH++b3WmEt/uxbptxzRW+28may02ravq1h7FzrqvMgsZikpbZTbbyUELMnl5gpw666C4B66chOvr9uipzAlsoPhbtdUTPxtKOeuDSfRMTKdbsekPhXmCe+O6MnjakkLKn6VsuXIy1wg4gc4UGUV4DZ2bE8JVRRxWG8D7guGsceePvoGl3hmUfWDnZuYJh+kOrU08b6Cmtdi5wB5G1IYX5gXeNVf+bl2ElfYT1Oik97FOStRD9CEtxUWPXi0k7bio1alUt/u7u4A98U8iq5XhH2NJRNJB+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRLEKJ4j9632H4N72/EGx71dCaBXJZRRGuOFsvh5ny4=;
 b=BJHsVWQ206zsH8wjF6R7MIyCMYKY48neGiPWKiO3zvxYIkuYXk8hCfpZTG9PUOAD0edACVPQKmlnQ+eXjbSrs3akvz73IjCu6kXxvaO+qy0x150/op4DvT6yBoiWsom0v1a0PtZ3RevNOW1ZSyvPgkM9FpaLgYEYeSerVDbs/1neiHu41oFIAxOhp4eknVdJvxr3D/foUqrrPFVTNyeMEIYy3uY5M+/e5//jdDq3JEuAF1+dEJhR/YTfFWwRY/aKxKLO3BihxdhanTJ3Mwx6Bc3mol55+J559Mx6P4hVU9xJevgwvinvdIOnD0/os4IVprl62VD+x2kXqdINq8MzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRLEKJ4j9632H4N72/EGx71dCaBXJZRRGuOFsvh5ny4=;
 b=mjAt8Wsw0IR++gkuIp6+h/kCTloxK4RByJjMjJ7BwGJRExI97KNoWOLR1NHfStOHggmXNxIowJ6wdcshR+k5hFSBuj++Bmuuhwxl28VkvuV/H16ups2pEyKynY5J8mRbM4Poj5sE0h61v8Q6ZMrtL7eHmlIQc1WqAt25S0br1oNWlq8FSawQkc1f5xU9JTlc/BlyDGGd45S7u52c+/sR5f/xrgu445A3Joh53fmp1BOzWx9PlqKP2IzjXXGYx6RzmR7bDRlSZHUlztFR8gfwuR90f331IeSSSYrWf0EhxW8ro51gb8w6kP71wlhU3pjz3dsZP5dF1OwtY2g3K47I1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:48:07 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 20:48:05 +0000
Date: Fri, 20 Mar 2026 21:47:51 +0100
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
Message-ID: <ab2yd35rm6OgZUmb@gpd4>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320181400.15909-1-boqun@kernel.org>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: eeebd459-c293-4036-1978-08de86c1fc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B2v+Xt2N5ZYrzLcI7QDp2AoRZxGfho51bHiH492hM96Zcl+0PYUVcarus3ewsWrftcQHvMfJhA22LZ/8mi5hWjB68e7/exkHObU6sdHhLI3mzqQ2RS5rEwJIJrbmDBpIP9Lrvinlw6+ewoiFUlh6UHO13D72E2Q2D+kxvAsvM4TARnWDO+NeAbIoh6MBtrxEXBYq6DvruIMKjOXgvmq772LP/e/2ykLMsE+4Yud+MlfRIG4bzb3WsQxBU6o6K13nXUhMBdeLq5EN6ymERGNpSNz/rhr8dzQxOHgYq1Ul39Dy3ZX8SQ/RqUd+MwVxd/0iSwo6p8HyAEXIx9EacAnkQvabeMFocNxMH8XlGmBlXk9VYL76Nhl2ugFsQNhvY2PPKANyipsJ4edu8nrRrpWhtWvK5p13+5OWNHFHrcAQhxIOLfOMaJ+wDfxXuwEjTvI2/r1Cfr+YEyscaUZGqVc0U1W35mde4GQ4q9OrEJBSPYeQWwfRLqI9z9XVP/17ILX5JDUlUwF47zuPtp2GdukbE3UydtHqzb2JoEec5gtdwKOTfMi3hgyRBYbRiE7bqRxoUuomQcXSwQ2h2/TujmEixFyERL1195e5XK6/I/foZwloCVPoBk8+pgSxOxqD9lO4D03f6IlqP0hvQ52TR8wTyX27XZ6ekq803f08wcsinAuIjiB/wQAChBaA77+au5ce9XtlWTEGm9oewQNEr0S1/Pok/19zy5kpif7K85Lo+JZYet0Et2O78PBihUr7gYw2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POnq6F7O+OcxxDAoe6pilXK6OWm18GpwVj1qthnDlVIC54pl82azEV70wtS5?=
 =?us-ascii?Q?fSav+qniUDeopjYv6pkmU3jWnLUPQK8rzlGge0i0EPQLfJmusURrz7N/Mavr?=
 =?us-ascii?Q?yVPGzNe/Y87F2j0Q1zDc67zuCQNq4NV7MBRWnzfy6dw9GYjNalLRdeuUiRws?=
 =?us-ascii?Q?Odw1nuMYLfLS2OxH8Rc4IUfYw6jsaCFLPbTrtz3Wf8qm3XwXfobP79v717Ny?=
 =?us-ascii?Q?H9AOKebmGaBrBHC+iO0/kwNH/KvypSmQ2NQ1roJvibYvhKVsIw9xrrWtGe03?=
 =?us-ascii?Q?gKf3WJefV6mzELhGMejxt5AEjjvqbODowXb1pgX0IBOhmd5s7sxWDKJbMFUS?=
 =?us-ascii?Q?nvguwN1BV2Qi+afKdVlANbjHcVtcBah9hDALQEwvR/ARGTeAQ93eF5P4vEkU?=
 =?us-ascii?Q?Osth1/fab65sRHD2UN+IEnRyeAwDk/enkMLoQItHQh9auBIHF3K/rWykprsz?=
 =?us-ascii?Q?KkMYih+pTeZX46fqrUvPseEHWIkZFcbqS4LZFAtjx6xsKfUhZASaYa5lTPXf?=
 =?us-ascii?Q?wiTwuHHP6c1QBUYY9a21DveFPA6ioNJj/i2qdYECS/iWZlDnS1fzDXRLfg3O?=
 =?us-ascii?Q?l1tMtXpM+s/sCee8tiaWH68W5EVMTlgOh4QK65Qso796Se4g9HQiMAZVrxdS?=
 =?us-ascii?Q?6pTkokPCIFwHdM7ESoCoBLfLm2994biXutxUC8/nYgbK51RrjrCIFbGyzg+d?=
 =?us-ascii?Q?5AdKelYhIdjGT1XebBKWJHFeQj7gHLzrocxIuujmO+HPTO1xUxxKJUhfNDCu?=
 =?us-ascii?Q?ypdJ0I0iidz3cHCEIECIm/kKogjNveR2QFd7E9dJDOw3mADmuqJNznJSPHs/?=
 =?us-ascii?Q?Pt231ie72fnKwkidwYqwRUCBOOGCdBDIfajYjdA8xQk3yDIsBGMQ2/bbpTJL?=
 =?us-ascii?Q?ZZqz0jW1cZn5hEKoMbdfXy3L2O1hsr74wj0dt/SfPLDkx2qQe2Rqgq36PRvs?=
 =?us-ascii?Q?SQE+665wRL2lRGT0yU+2HPHFftrwYwhnrB/vpRJXJzPkUKggG42zzviPaXVd?=
 =?us-ascii?Q?XonHd3XB96UC/bbZQFH7oXj+J1fYen3c46AeuS/0WZbJBn2735T4fI69MgYb?=
 =?us-ascii?Q?e04uHyNJ2fijOYiriiSPyLI5jB2RRYlKZ5c5pl1sXkU7yAVFsT66ULUZckD8?=
 =?us-ascii?Q?9+fUqynsiA6OYBHLUaq7ATm+oI1Lay/FrSG5U1rZwb0lrErhc+pgybFfyymk?=
 =?us-ascii?Q?FlAEx6ETFOVV0Ub+A2vAgcmir5nqMZ7rvlWpuJ5JsEHKJ+zPJNwFbhUW6Z7Y?=
 =?us-ascii?Q?2igWOJ+Q63lg0LqTnVNuFTOcJiuAMePqF38dFC8+hFetInFzSkVJpe93Ljri?=
 =?us-ascii?Q?CbLBBbLmoRtpqw1pTK97W0aSzn3pKt4dZYAnqElbQeLk83deDiaVQ/A5s/fL?=
 =?us-ascii?Q?WUXzI7/Mzw9yRGaaxOR3d1ICFz9ffC76DvS6lprzFr569Q5pegRnmONRawx2?=
 =?us-ascii?Q?hIipBhnfV4eLTz0bfda9yg6yo3tFyvF1MltQiVY5W+uQ5jFymyrsaq6MoUs6?=
 =?us-ascii?Q?x/DhmjXDk+40QwKCD3sDw5xK6rGopa9Cb4Td+zgvHno/Tn8Ea6rbIwkMUC5K?=
 =?us-ascii?Q?MjXuEjwQpJl+UrnYrsWYhoMljuspKf2uptgcxZ6S9ghfu8pE3I16Tfax6xZV?=
 =?us-ascii?Q?FrpkEtyaSgkvjUlyg+EyNEFYsYfsIhZEkj/Y6sih+d/kCRQyciHG25bKeZZS?=
 =?us-ascii?Q?6NzQ8XWbIUI7duUyomiUQdRsdaPl/PAjE/FHOIqjK8ChWP/jNN8ATW3mB8Hr?=
 =?us-ascii?Q?oIlcu9YVOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeebd459-c293-4036-1978-08de86c1fc76
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:48:05.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Tt4ovNsFN8PmnDdqYmK+2eFbuiK4KsD9vdKqbChDHdUF+6FzuCvo7ZvmNdfJNsRoh/qduRz+LMMyX7e4nxQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

Hi Boqun,

On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
> 
> [boqun: Apply Joel's feedback]
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
> @Zqiang, I put your name as Suggested-by because you proposed the same
> idea, let me know if you rather not have it.
> 
> @Joel, I did two updates (including your test feedback, other one is
> call irq_work_sync() when we clean the srcu_struct), please give it a
> try.

I'm getting this at boot with this patch applied (testing directly from
Joel's branch rcu/dev):

[    0.639477] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
[    0.639479] WARNING: kernel/locking/lockdep.c:4404 at lockdep_hardirqs_on_prepare+0x15e/0x1a0, CPU#0: swapper/0/1
[    0.639507] Modules linked in:
[    0.639507] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc3-virtme #5 PREEMPT(full)
[    0.639507] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    0.639507] RIP: 0010:lockdep_hardirqs_on_prepare+0x165/0x1a0
[    0.639507] Code: cc 90 e8 0e b1 4e 00 85 c0 74 0a 8b 35 54 08 43 02 85 f6 74 31 90 5b c3 cc cc cc cc 48 8d 3d d2 3c 44 02 48 c7 c6 b9 58 c5 b2 <67> 48 0f b9 3a eb ac 48 8d 3d cd 3c 44 02 48 c7 c6 37 55 c5 b2 67
[    0.639507] RSP: 0018:ffffd26700003f58 EFLAGS: 00010046
[    0.639507] RAX: 0000000000000001 RBX: ffffffffb35719f8 RCX: 0000000000000001
[    0.639507] RDX: 0000000000000000 RSI: ffffffffb2c558b9 RDI: ffffffffb36bf810
[    0.639507] RBP: ffffffffb35718e0 R08: 0000000000000001 R09: 0000000000000000
[    0.639507] R10: 0000000000000001 R11: 000000007cb360a8 R12: 0000000000000000
[    0.639507] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.639507] FS:  0000000000000000(0000) GS:ffff8a7e076f6000(0000) knlGS:0000000000000000
[    0.639507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.639507] CR2: ffff8a7dbffff000 CR3: 0000000023452000 CR4: 0000000000750ef0
[    0.639507] PKRU: 55555554
[    0.639507] Call Trace:
[    0.639507]  <IRQ>
[    0.639507]  trace_hardirqs_on+0x18/0x100
[    0.639507]  _raw_spin_unlock_irq+0x28/0x50
[    0.639507]  srcu_irq_work+0x63/0x90
[    0.639507]  irq_work_single+0x69/0x90
[    0.639507]  irq_work_run_list+0x26/0x40
[    0.639507]  irq_work_run+0x18/0x30
[    0.639507]  __sysvec_irq_work+0x35/0x1b0
[    0.639507]  ? irq_exit_rcu+0xe/0x20
[    0.639507]  sysvec_irq_work+0x6e/0x80
[    0.639507]  </IRQ>
[    0.639507]  <TASK>
[    0.639507]  asm_sysvec_irq_work+0x1a/0x20
[    0.639507] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x70
[    0.639507] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 b1 3d 26 ff 48 89 df e8 d9 a1 26 ff f7 c5 00 02 00 00 75 17 9c 58 f6 c4 02 75 2b <65> ff 0d 33 62 f0 01 74 16 5b 5d c3 cc cc cc cc e8 f5 83 35 ff 9c
[    0.639507] RSP: 0018:ffffd26700013d48 EFLAGS: 00000246
[    0.639507] RAX: 0000000000000092 RBX: ffffffffb35719f8 RCX: ffffffffb2017e0b
[    0.639507] RDX: ffff8a7d80338000 RSI: 0000000000000000 RDI: ffffffffb2017e0b
[    0.639507] RBP: 0000000000000282 R08: 0000000000000000 R09: 0000000000000001
[    0.639507] R10: 0000000000000001 R11: 000000007cb360a8 R12: ffff8a7dbb628a40
[    0.639507] R13: 0000000000000000 R14: ffffffffb3571940 R15: 0000000000000001
[    0.639507]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
[    0.639507]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
[    0.639507]  srcu_gp_start_if_needed+0x37a/0x520
[    0.639507]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
[    0.639507]  __synchronize_srcu+0xf6/0x1b0
[    0.639507]  ? __pfx_wakeme_after_rcu+0x10/0x10
[    0.639507]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
[    0.639507]  rcu_init_tasks_generic+0xfe/0x120
[    0.639507]  do_one_initcall+0x6f/0x300
[    0.639507]  kernel_init_freeable+0x24b/0x2b0
[    0.639507]  ? __pfx_kernel_init+0x10/0x10
[    0.639507]  kernel_init+0x1a/0x130
[    0.639507]  ret_from_fork+0x2bd/0x370
[    0.639507]  ? __pfx_kernel_init+0x10/0x10
[    0.639507]  ret_from_fork_asm+0x1a/0x30
[    0.639507]  </TASK>
[    0.639507] irq event stamp: 6418
[    0.639507] hardirqs last  enabled at (6417): [<ffffffffb2017e0b>] _raw_spin_unlock_irqrestore+0x4b/0x70
[    0.639507] hardirqs last disabled at (6418): [<ffffffffb20013fe>] sysvec_irq_work+0xe/0x80
[    0.639507] softirqs last  enabled at (6406): [<ffffffffb11ce7b6>] __irq_exit_rcu+0x96/0xc0
[    0.639507] softirqs last disabled at (6401): [<ffffffffb11ce7b6>] __irq_exit_rcu+0x96/0xc0
[    0.639507] ---[ end trace 0000000000000000 ]---

Thanks,
-Andrea
