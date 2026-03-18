Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC52DCBF8
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874381; cv=fail; b=ioN/iOLu4gm2q2oyqyg9l0RJD/HzCqnWCSLJIRdjVykl9IHtBGbUEa1rdkyTnYL9HgW6XZQA/ZUFWqQNxR0F+cyF3qshWyPKhq2PPyiy5o976+DyiLHc6lscSs8zIxPG8H/ZfMKqgQ2Cxw8oyfEaxtw22931PkkMxPE3wDL8Sgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874381; c=relaxed/simple;
	bh=c0OIhaWEjHv+Lad1Xb2Oh7bOu+W+ozMGP5dRySnVA1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kOcQ8t9ih4GUF42NijFFXNdh3ua1VXEbEIlYeDtkT2U5XUDsamjuAjIVGSuLHntWO7ADmahPakqisKHKGy0f6ukYlXPSnrEMCgE1p51UF257iMz6NcIV67VOyr10dRCvKJJ3ZsQpAeEPxCreXeevypPZ1efZoWkgB5OlIhr2WEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhcae167; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhcae167"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S60d6qb0NRKGsJOVeq2fJj1WbOTjZ5rWMbaLTQZcjkDEXtlXDkXhYNDg0k4jpF04OmAp5hkpALJsypGJEWnHw/ty9abBx9epY4rZpG4HebaHyU8RuB2OfhGk2NrHi2bVPBTrpA6JAKbuUbaoyJOa6o6Wh39N1WykMKkt2vOvKdaqYuhF+Zr71/XWnS94uDjVho/63FCubpILgkjG2dEcHk0v7fDEpLl4U0X60KiDjqU6RbDsB6NvP5WJKDH9qbsK/J6jAR+QX0W0r6e1eUy1YT6XmAHKFZHzPC0pdK3N48NcjN25nZI4toVmFgJWHnP7p5XPB7JS8Z/TCpRiqLCNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B06kTzvaai3M35qQf7FrTWAAkr6757B9YGqkGgoLoEY=;
 b=osUZb8vDwrxjyLkfauoqPChY/5hzxIW6vknamHSBx6qeE2TVUUjRO1etK3Q/ZkqtWSTwWOJmpBlTBx58moaX9aAcjhIZsDVe5oB95gY+L13dYt1Sd7xDlEBQFmNPt8gLSo6xbe2Kzi7pPv8rCjXikmXIGXyYfpkShjmcPNkK2un9yPrTGbjeZj+fyJqzPHZpGIMU8OugAop7Po030LiWWRcFecfK2l82oz9fyOjlCh8lsgogulfInQstqTG4Ys0t89d6MLMNvXKtKkjU79y/2Ils/KwoZejY/zbiv6lHWXu8clrliEwRyUPWRXw5g0YjDo+5BI4lUAuqf960XSKC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B06kTzvaai3M35qQf7FrTWAAkr6757B9YGqkGgoLoEY=;
 b=qhcae167vSk0sKAJFINuHJ809BKFGFqdVUWMJY9pt6n4fZpIQbfoMlCDTZ/TDi4C7yNxVzWdewEUMY9CMYbEP0eP0d7TKm1PsMdOY/5ilqLr/7LzRmveaa1xqVdnUJw076z8LznEH6fKnD++d/oOpV+RXJuWLcZVsWZFQLlYiLWBRK9jy8z93azMz59fIO0PBDx7CplWEAGFbWPEKvIG1lgwS1rIDhByCOID7szeffAnas6SwKbPlBnrqYa1l5t+axaBn76D5xyo7am/Cugys5gUvMnCls4RSKMVtusuY2uyL8gTnFTAy4KcPI0cIARD7wlEuPRGDKTiw2dWo0EyYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 22:52:55 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 22:52:55 +0000
Message-ID: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
Date: Wed, 18 Mar 2026 18:52:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: paulmck@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local> <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <absj6rZbyLZY8PPz@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f1a077-4722-46cd-6f96-08de854117ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j+EAUsgFUYTiq1uouK8zgMzfibRifHsF2iE7cSXFQ/Og9il2FIKD7gSZnKxFSBWncEDHzHc5wr1SpFgq/KDDPyixFGIfiusiBnDwxTYjk/4O8EmE3ORmKT9gmWfqHXsryDuq/gJ8eaQCPyipaAXS2OIF5hj53Y1ASgQaO3FCXmXaMkIamZGWBu6/UcqqcICzaMNLnJA/GsZzY5yPWeTb/HDMXpvR30h5o6NuMiTOPqoSh5GOoSjhUHK9UVHGKsN2YojG+kh4sPinymeGYthLvEPj0H1Z3zdDBfCc8AE/+FH2IlyVSF/YGNYv6XROdJGvwq3IUbwYxCf54eK176MUcxdNwM/QI8JH/pA944Kh1R0TqafOGkC/s07rq3Zs1NiAC+H1p8XWBLj7mCtjsZ42NYOVCcBXZQ5KiX8al9J0y4hzLGtN1HQeiyoJyJPR06i39vzxIbEjVVin1KmwrgTI3l3dC7YjLPLVCEy5Hisq8jAPV1oXD3/GlMJPSS4LY2WJOJSbTV+NeNYfOy/ke6Rf70Q3xydXdpH2pCA8s6EYZTHsiP42HkUNI788XqTsW85hqcaGuB/yr5lNd+AacpMJ1Z8lxkQfn91W1++y1BAPZW8j8qq2vGebWoNKOluEztD+7R+3rxUGmguejEtajxmkIyWISIwgR33r/ma+7OOVaQ38pFM6mRKcmssTYySXuELvI2b7Xi2n4GA9QYv9LHSmCWcjzDtktUzpwHj7lVYv/48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENyZXg5anpMcGxFaUNleGppTUhFUkNWZFVXUUZLOGFnTExzbUI4dXU2TjBq?=
 =?utf-8?B?RUJ0WFlGM00rWUJBaDB0WGhsS2k1aVJQa0JueHdTZk9hMHNHWDZiN0czbkRB?=
 =?utf-8?B?Wk5jT3FHWkNTc2oxbFVBRmlJTmlIYWVPRWhiR0RqUldTZSsxTk9PNzdKcWlq?=
 =?utf-8?B?WUpPd3ZLY2xzQ0dldjRJQ29uRVBPSE1jeXRXRGdQbWU3clRVY0FzTktlK0Er?=
 =?utf-8?B?VlNweU1XNm5HTXNTcnkrOFZQUFh4WmxTcXdRcXdyc2cxcW9mdGIrWU5rMVd2?=
 =?utf-8?B?SG1NWFVCeGkraHBXU1kyQ1BaN1pRUTdWQVJwSnVQd2paOFJzTTltUzdtaU00?=
 =?utf-8?B?QnR1eGpUUWJ1ekMwV3p2ZDMzZ2h4Mjc5MmtqMU9zcU5tNjhVQmhCRGdJemNK?=
 =?utf-8?B?aWt2VllTWExxSEcvVnZWaktEZGhqRWNsK2VuVVc3LzJGTFVBQlg4OWVBWkJP?=
 =?utf-8?B?T1BjblV5dGNGVmhLczhpRkFNZGhWMjdvQlRvMjZKdHlPU202QmE1N1FjM2JM?=
 =?utf-8?B?U1k5K1p0ZDluWHJLMHFpS2poTlA0cWs5ak5XNUJNLzRsRmttbHRBMU5sc0NP?=
 =?utf-8?B?YkdHWWc3QnJzL0pEY1pIWVFOa1E3c0NWZVp0b1ltTWI5QkZkODdyb3NhOVpC?=
 =?utf-8?B?VHFkYkM0bkhhMjkrUXlMbG9RRTRqc0twc1VCaFBjMTNYVjFMakFhTEFqNHpH?=
 =?utf-8?B?NFEraWR6K3N0Ylc0SFB5Sis4aGRNUWRRWHNyckViUHVqMm1nZ1V3K1Z6V1Bh?=
 =?utf-8?B?WDR5YlBOYVN3QkN3dHUxR2hUWnVjaXhHV29Ibjc1MEhCUlpGWWVhV2d4aXk1?=
 =?utf-8?B?WnJYV0h5OXZpTVhoczAweklRSTRLUFZJdS8zTWpXWnhPWDlmd1FEcWtLOWZa?=
 =?utf-8?B?N0dKWFBaR0FMTGNaTEtRUDZIWDZiZXZrMEE2Ky9kWS94R014cnVUckJxWjhn?=
 =?utf-8?B?dGFDRHAzd2c0MDh6SnZIMnNrOGZPclk1Snc3YnNUZnJrNmFIZ25KZmZoSXJH?=
 =?utf-8?B?djN2Y3FVell3UTdpVGNxTTBrQXVYbjBKSS9OaFRub015dHJuaWpqNFZWQmVt?=
 =?utf-8?B?ODZtNlVTU3FSU1FOemRlOTRqV1NnU2tzY3NMb3NFV2JwN2I4V2w0cFY5cEhk?=
 =?utf-8?B?QVZZckU4b1ltZ2l3RVRxM2t2ZUNlbW9JTm0yb0xDSzBRNE96NmYweUdoS2Rv?=
 =?utf-8?B?aFFEaVFaVUR1V0tnNEVSdGRhTEhCRlcveUlyZlVuL3VkY0h6dEx1ODdub0RZ?=
 =?utf-8?B?V1FkOTFpNDhxWlo5M0ZmSmlLNnZsNFJuZFlBNWFQWHZFYmhmTFQ1OXRWSUpy?=
 =?utf-8?B?WHFEbk1HSXJzZHBkZE1JenZEYWtNai9HZlRWeng2bStOUGV3b2NTS3B1cmtQ?=
 =?utf-8?B?eHluTmp2UXlIQTRpU1R4eEloNWVxZkxXT1ZpSXJTZExBYmI0UktpS1FOYlM0?=
 =?utf-8?B?aG95dlhyMnRTcEpHV25JczZTQjRkd2p3aGJlUlJzazJnbzVwNEprNXo4bjY4?=
 =?utf-8?B?ZURZUFVnaldFU09ZdGRrS2hyUUdWTkUzeDNYd01LdS9SWmtQM2NUUmlMSEZM?=
 =?utf-8?B?Z0xLWFlkRnBPWmFQL3FtNURmKzdabkpyZUZHUWgyLy8vNGxZZmhmTmgrbTQ5?=
 =?utf-8?B?eW5HMTBLY1J6T3Z2M2lTVHdYREFkV2ZHbU5md1Z6UEJQSHBzSHRCTENhdjZo?=
 =?utf-8?B?WVM5WnZock54L216NkV0M0N1MncrOXUwRUI4bEhDSXMyTVhnWG5INVNUcHg0?=
 =?utf-8?B?QXdPbEE4LzFTbGUzNWIwbmJFMEtDcUhEbGgwa2s3eEMzQmtac3lJamhXZENk?=
 =?utf-8?B?ZStBbXFEVWNCVHN2RmhWc2tGY3dQQStLeXMvTVhrcFQrditYd0FGUk9zT0E1?=
 =?utf-8?B?eno5TlBHSEhhbTNSMVNKUkdwVXdndU5NdDhmYy9taG5YS245L2QzWE0xL3lG?=
 =?utf-8?B?UGtGNDlzWkcvbUdPMUZTQ01MZ2t5T3c0aVY5VFpxTmlMNnlCZ3U0clZrOHpN?=
 =?utf-8?B?NUwvaEFpc1hzdTdYYk44L1FGbWdWK3REOVFWZkpzVmlOazhBSWhNdGxSZlYy?=
 =?utf-8?B?V3M4ZStIRWJEQW1tWnZYbVVPVlFhb1EySTM4YkEwQU1BekxhU3ZIWU04czFI?=
 =?utf-8?B?bG1WZ01iMi8rYTBCTHd1Q2dkejcwKzg4bDBYaksxZU5vcjJwMDlhZEJheHdH?=
 =?utf-8?B?Z21uTjRrTlBDM2ZxSGRDOURTNHM4T0hiUGx5NG5vNlZCRVl1TDdyWmVwcjZY?=
 =?utf-8?B?THZ4THJFK3hDd3g0MTRtQmYwcG1XaVRkM2JyQjJxMDRaUjZFMEhzMDFmdllv?=
 =?utf-8?B?M2o5SUtVcFI0bGdqOGdDMkViTlQxNC93cDBkV1RzSzVuMnhsWlk1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1a077-4722-46cd-6f96-08de854117ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:52:55.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX3GWnQU/ZTWRjdwh3M8PqvDSFDVRarvKhZ+4+eA4Dz1YrM2Wbpdv4pw9haBVxcF3S+fNBiy6osC3+vkzdcmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229



On 3/18/2026 6:15 PM, Boqun Feng wrote:
> On Wed, Mar 18, 2026 at 02:55:48PM -0700, Boqun Feng wrote:
>> On Wed, Mar 18, 2026 at 02:52:48PM -0700, Boqun Feng wrote:
>> [...]
>>>> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
>>>> different issue, from the NMI issue? It is more of an issue of calling
>>>> call_srcu  API with scheduler locks held.
>>>>
>>>> Something like below I think:
>>>>
>>>>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
>>>>   ----------------------------         ------------------------------------
>>>>   [1] holds  &rq->__lock
>>>>                                         [2]
>>>>                                         -> call_srcu
>>>>                                         -> srcu_gp_start_if_needed
>>>>                                         -> srcu_funnel_gp_start
>>>>                                         -> spin_lock_irqsave_ssp_content...
>>>> 					  -> holds srcu locks
>>>>
>>>>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
>>>>                                                  -> queue_delayed_work
>>>>           -> call_srcu()                         -> __queue_work()
>>>>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
>>>>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
>>>>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
>>>>           -> WANTS srcu locks
>>>
>>> I see, we can also have a self deadlock even without CPU B, when CPU A
>>> is going to try_to_wake_up() the a worker on the same CPU.
>>>
>>> An interesting observation is that the deadlock can be avoided in
>>> queue_delayed_work() uses a non-zero delay, that means a timer will be
>>> armed instead of acquiring the rq lock.
>>>
> 
> If my observation is correct, then this can probably fix the deadlock
> issue with runqueue lock (untested though), but it won't work if BPF
> tracepoint can happen with timer base lock held.
> 
> Regards,
> Boqun
> 
> ------>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2328827f8775..a5d67264acb5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1061,6 +1061,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>         struct srcu_node *snp_leaf;
>         unsigned long snp_seq;
>         struct srcu_usage *sup = ssp->srcu_sup;
> +       bool irqs_were_disabled;
> 
>         /* Ensure that snp node tree is fully initialized before traversing it */
>         if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> @@ -1098,6 +1099,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> 
>         /* Top of tree, must ensure the grace period will be started. */
>         raw_spin_lock_irqsave_ssp_contention(ssp, &flags);
> +       irqs_were_disabled = irqs_disabled_flags(flags);
>         if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
>                 /*
>                  * Record need for grace period s.  Pair with load
> @@ -1118,9 +1120,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>                 // it isn't.  And it does not have to be.  After all, it
>                 // can only be executed during early boot when there is only
>                 // the one boot CPU running with interrupts still disabled.
> +               //
> +               // If irq was disabled when call_srcu() is called, then we
> +               // could be in the scheduler path with a runqueue lock held,
> +               // delay the process_srcu() work 1 more jiffies so we don't go
> +               // through the kick_pool() -> wake_up_process() path below, and
> +               // we could avoid deadlock with runqueue lock.
>                 if (likely(srcu_init_done))
>                         queue_delayed_work(rcu_gp_wq, &sup->work,
> -                                          !!srcu_get_delay(ssp));
> +                                          !!srcu_get_delay(ssp) +
> +                                          !!irqs_were_disabled);
Nice, I wonder if it is better to do this in __queue_delayed_work() itself.
Do we have queue_delayed_work() with zero delays that are in irq-disabled
regions, and they depend on that zero-delay for correctness? Even with
delay of 0 though, the work item doesn't execute right away anyway, the
worker thread has to also be scheduler right?

Also if IRQ is disabled, I'd think this is a critical path that is not
wanting to run the work item right-away anyway since workqueue is more a
bottom-half mechanism, than "run this immediately".

IOW, would be good to make the workqueue-layer more resilient to waking up
the scheduler when a delay would have been totally ok. But maybe +Tejun can
yell if that sounds insane.

thanks,

--
Joel Fernandes

