Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968042FE582;
	Mon, 23 Mar 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298257; cv=fail; b=WzBTOKCis95jQ0pwAnCB965BJAAZl7cDbZPBum+f49gq0GipBX0Uj7GkVEw9VMDnu4hFo6hYCCzRSUtFVuI/VGUrmsQelpVDYO+LoGH4S+eKSdOqEmLQn6nYOL1R7FJ7ldAbzKwmYdgOGkyGflO32NO8zETe2yvXBgPsVmK9k4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298257; c=relaxed/simple;
	bh=IhYsZ0Rol1GJPQaJmdLFfX8WvDgvmIVZyn1yalYyFJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJYq2OYqBwCK/DqWAhv2soIvN3zg8yutBsCfdu2d13G5yoCBtgMNtxbTO6vR2EChlSiatiXlzwRwc1P6+/yUB5e+QsGPc31eh8lWXL8dY9tKZ1UzG6ER0QduK+H9vM81IBmuHHDnMeKzTfLyYaMiFSZWM/NDL31V/6evR/DE5hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/RaUzDW; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/RaUzDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kybdohM5Q8q0SHYP+HOYY/Pk1RrjRWuUiyfhdoi98zRyxhu3JJMwEC6njK6tXWBmlR2efm7p8XRiOFHaHE39VCghPybcq2CgPwgcN4lkFPbS/+dSyCrB6RFAuvFIzwOx0XnbBARvaOR/xKBd9n7zvBlxnIgu9lRtcW166C+6Ua2TyDGsMjyGe3CATwNekxU3JfPouXxkDrvq8WF72cz1SJUO57gFHUqY056Msl1/CquENkQ6Zl1hOse2mVHhUUP5QRHWma8YoaPt941BnKQoW5yGlhruL8heDuTimfu55jr3cuf7Huw86UxuoEVZJ+ARffoPc6GxXFdH2sg2mJsrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UrMDiChlBkoSTSnazMsEzNnl6hACvaLH5E+GSjF6Gc=;
 b=J0lQr9wNACAOgRPVAU5nAccLQPFsG+yAIfLRU5iNMKvu9FvROis/eZUtpuHgRACE1tbctJ/cKtFRK1yds4puPDSIlIxzsGQEPjU7KUOKkKQhYfx31yt6eqsME8jOurC5N1HQKFkhA9dEPALz8Z5JOpqeDGXiO6fsTG9pYg/1RG//rbTjUoFnpm+PHUMW2RAxO6LzTxLoQAePqMuDlZ18l8oXZmpw+2fdI/ugg0iu35pMJ0pzRhhjyBVU3Ju5qrfKpteqcqVYhWYU/+ja8TlROOqgpfhSlSp8ipriyEN7vewQjoRI9a4fyTUgrKsTVWhn69gkldUyR5yMx+GiXsYZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UrMDiChlBkoSTSnazMsEzNnl6hACvaLH5E+GSjF6Gc=;
 b=Q/RaUzDWFQkD8C04CTNWgPOg+0g2mGfWvUaOfCf6+hTezfejOU/Z1CN3ldL7hS7nf42/G6y+aJboPEynfnBaRLs2PbBn5TPDSso0k0HKzDgSN+chisjyuqTjljSIoHtAU9ZenwvXrt0oWfKO2yLVTfgBdgiDu1DjW7m5MM+nBXL+8ZiJwXXcARezR8BerlOjGu1cwROz/WM6nBrfRgL1+zng7+RqtUgN94J9nNNrUUpPXNI0MIob+cK4fMvy2/aZIfv9lQZ5rrUM4LfcFTWRhfpEOw2ZKb0HOj9ZMlVGytHLeWkwb4ojoJvBdxSsYnRs9A/gCBMnuQ9aaPsWu8V3Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 20:37:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 20:37:25 +0000
Message-ID: <6b3d151f-3d21-4382-9ab8-386bfc9d47fb@nvidia.com>
Date: Mon, 23 Mar 2026 16:37:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rcu-tasks: Avoid using mod_timer() in
 call_rcu_tasks_generic()
To: Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Song Liu <song@kernel.org>,
 stable@kernel.org
References: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <20260321170321.32257-1-boqun@kernel.org> <acFZem9MNHRXin2h@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <acFZem9MNHRXin2h@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: face7d29-7c2c-4a46-2194-08de891bfe2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	08k5W6/PckwJkP+clCkIRE9lmbnlVtnuDZcyxdc0AKfkbOaKfBXejmWwGHR1CQK73VknrqCrTIBedJPKwQmdQUyP8mpcSlRHTqdj10pqgNVPk+/mLHPGPZWt4cpUx14KJ+gmTT4X2wXBcDGteO0qfFE4l0M7r0Gw+GuYs1Zh9EAVwsv5fqG7IZvLU4/52rXBMGfr1JzGYzlxEU8HIQqY834qmkh8lhemcFgN9XIAB+ewuI1dKF+WCd2OZPRijytohpPkUu8Ydj6OTs5Z5pXZ4ybdPgL52CDk/d6gNly0jQq/gGTHbH/L/mG0+BXGFbF8iS2cQYt0ZkzERA/dZSGkm546X2Zl0ISilZECPQzuzY929Tm5SwYSB5q8HZs17KByZxybkDI5WXjN4BBuNpWRFzCrlRwdYpZKMZ3M560lXQLdeuj6liRqMTk2ss1OGfWrlLoFxsZ+kEMmu0sy/o57K58CEQipiL7zO/QiwZRKY2zeiEdXXYLLDGiNXNW7ryfGI117fgko8xF7ppzi5ZC06DGk3u4Dj+JYNUljJQMdS86RQNSHBrslaWE6dF3giMZyDOdBK7kGnQvEt4IWtV6yHwGHkA2Jqki6sSE4I3c7JvoBH/I9y41qsw//uXyzvjhUQCG7pB174Z0Fo3s3Xaw4JimjUKJrFc0o2iGVwdI/cFL33NjYLz1vammzcASplP4XDJtIU+ZYjNyF+EybohC81ZfxFY9h3ajqSwBSt33CSLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmdUalpJR3diUVUyNjNGQ1pMWHJ2d2JrV2ZrRXJDSDBFUWFDd0lLOHFpT3lG?=
 =?utf-8?B?T2NmSUFrK2xQWlhOTml6cFMyL09vT2w3Mk5veXQxaE5aN1lNOXJaOEd1Z21U?=
 =?utf-8?B?Qk9uNlZFd0tmTVZXeEtLbld2aWhYdTdhdXhuTUpoV2lPY1I2cmhzMTVPR3Ri?=
 =?utf-8?B?cW9EcFZLanNRRzYxVElZVmpyOGlnU2JnU24zWXI0SkJaOHJWbVRybytYR3Rx?=
 =?utf-8?B?MmxCYkQ3L1VaRWIyanpSM0VpSGtLVDFoenB1ai9wSERWRXJmci90NGhYSTkx?=
 =?utf-8?B?WU1lL2JIelR5SEZCcVRkd3RrSnNkeEUvV2p3WlJwRFhNNjd2dDJSNVc4VUI3?=
 =?utf-8?B?eDhDQXVmOFpTbWlBVVRwdXpOY1NNMXp3MnR0bmJZN0RLd05UZzE2d0FoMGxO?=
 =?utf-8?B?dSsxdUFwT2EzdmpuQzhCTlhsSGJiRk9Lc3ZJY1R5aXA2emRML3Z1cFF5eWZx?=
 =?utf-8?B?VHdGbkRXdWJsQkNlSFIraVNoeE85MUtPODRuUVFUVUZ2RFFmY09DTHV2ZXJh?=
 =?utf-8?B?MEFTT2FGSDBEK1JkSHRkVzNsR0dsOWUwSFByTnJWaU5RbU1BbDhIdHp3Wity?=
 =?utf-8?B?dC8xTnlCaUo0WU5uaWYvdVJhMkhTZTlGbDMxMnAxN1RobFJQaU1iUDdrVUE2?=
 =?utf-8?B?UHJQRlYzR0FBUmlneHdybG5Ra2c5anpIS01iUFhrQUR4Y2FNQXpBSVdzMlZV?=
 =?utf-8?B?TUQrTTFBanhnQW52bEl5ZGsrZ0JNMXNuT2h0dHNYWVY1bkRTOTMxZlJaZDM1?=
 =?utf-8?B?THlMNUxHL2ZKcHlXaWtNT0RrTkdpaVZrSHVWYkRESCsvY3oyR0NNNG5ZSnZG?=
 =?utf-8?B?ZTh3UEFpRzVZWHFqSlBBZnV4RUtkbUlnZmhWSmZaZk1DZmJhSGhxZDlWZy9L?=
 =?utf-8?B?Nnp2ZUdNb1NJWnEzVTVMVWZER1JpaG84bWdkSTBRQ0JjUDU3dURyWllVamtj?=
 =?utf-8?B?aDJPZkFQcDZqblJBWVl2TFFKNHlObWw2RmY5c1NyNytSSHNOSjQxQjRiWFJH?=
 =?utf-8?B?N0gvQ2tUbVAzMmZPaXNNanVxckRYN2NSSEVHT25xM3N4UlZxbTNUa0VKWmxD?=
 =?utf-8?B?dVJuK0VUUU40c1VkejVYMWFPczJZSHRMUTJHYXlveTNkOWdPdTZjbVFzNnRm?=
 =?utf-8?B?Z1I5ZDNlVFlWOVlTc0pRbGtYQTR3MEhGcGJDVFZBVm5wYjI3eHRsdFJPRk43?=
 =?utf-8?B?bXVrYjNZNWxhVG9IOEVpRUJLRDZsek5hSjd1YzF3Z21EL1dwQmg1Tllxc3Rq?=
 =?utf-8?B?YUVuelY1d2F5WTAvY1ZhbmVZdTdWRmR5cWZBdVF3Z1VrQU5Zb1UraFdQSzA0?=
 =?utf-8?B?eGdwbG4vemtpZjhHdFpNbUVVZ3h2Y0dDeU91V1J2TDhLeHN1dWxxRVVYRjI0?=
 =?utf-8?B?TUI4dmFJSmQxUGE4Nit4NlNvNnBaTHU5MHhwT0dBbUpiSXp0ZXJkbmxvVEpI?=
 =?utf-8?B?L1NwZ1dWV1IyK0FMZkRFaEc3OVE4WHEvVzRtRVBXSk5yRFN6VGpTckNBN0RX?=
 =?utf-8?B?SVZvNTF4RGtpM0tnQ2s3R3oxampwamdnQ3dJc00xSVZCSnN2UUpORG5od2VE?=
 =?utf-8?B?TTEvOGdKSm9UMStNR0ZvWGFRUGVuMXVQajlYSjVmWFY3Tmk3WXpXaGs0OTk1?=
 =?utf-8?B?akVoRXUzUjFzTFd3KzE0aFZkdGlIRnF1WWZVVlpaV3UrNnMyRHQvT29pVjlO?=
 =?utf-8?B?SDM4RUFpR21YdWNQdnBESDBPRmdacFJ3aDFtdVhGRzZWdVF2Tm1SMUR5N25k?=
 =?utf-8?B?T1BFVVh5VkhkMkM5KzkrdWdka2Q0a1ArQStpRnByY2pEc2QxME92UW9yUWh0?=
 =?utf-8?B?T0M5U2ZWekpJTXpqMmNrMWVXVnprUGZGZHFZdjgxdUVRdmM2cFBnT3RZUTB1?=
 =?utf-8?B?RUZSWDBjZzd0dUtJTlBlZjAvdnJDeUlPZmlDWm4zd2h2K2E1WVYzbkRRSU9n?=
 =?utf-8?B?NHZZM1RPM0FFOGF6OUt2ZXd0Y2FQODVPVUN2YzZpeVd2YU1CQTFZQUNnQlNI?=
 =?utf-8?B?NkswaDZmd3NkcjJRdnFBd1lvS1lremc3QjZYaENKb3V5dVpsbTZSUndQRlh5?=
 =?utf-8?B?SE55THIxanpuamdleVc4SEMxNmowNHNJTXExSE51dFlUejBhckhLRzVMbEVw?=
 =?utf-8?B?LzYzS04zczR4Ti85OVJVUURBRG9odUt3WW5OeGFPUmRFZ0dFZjFMWENFR25R?=
 =?utf-8?B?dm9wMFBqTHgxZlNKUzlMdXZVTlhuN1FpVWJjTzF3dlI3YWxmVjFvOGlyUWlY?=
 =?utf-8?B?d2ExWmcwaE9jU3ZTaTZIV2ZZOWllNUVOeHpNVVQxVjFmbml0bGdwNFg3a2g0?=
 =?utf-8?B?ZkxKWmhFWUhkZWZ4TjhIN0IwR3Y0T2VzTEJoVzNhb2hkemJDWThvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: face7d29-7c2c-4a46-2194-08de891bfe2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:37:25.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCpxDHXjsvluIf5zcyrG8e/7r/1p7xCOJh2N57KQaUtO+KgnbFWhlpPh4DwUqPtrbM6I95FvdquoyP8OaBVCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011



On 3/23/2026 11:17 AM, Boqun Feng wrote:
> On Sat, Mar 21, 2026 at 10:03:21AM -0700, Boqun Feng wrote:
>> The following deadlock is possible:
>>
>> __mod_timer()
>>   lock_timer_base()
>>     raw_spin_lock_irqsave(&base->lock)   <- base->lock ACQUIRED
>>   trace_timer_start()                    <- tp_btf/timer_start fires here
>>     [probe_timer_start BPF program]
>>       bpf_task_storage_delete()
>>         bpf_selem_unlink(selem, false)   <- reuse_now=false
>>           bpf_selem_free(false)
>>             call_rcu_tasks_trace()
>>               call_rcu_tasks_generic()
>>                 raw_spin_trylock(rtpcp)  <- succeeds (different lock)
>>                 mod_timer(lazy_timer)    <- lazy_timer is on this CPU's base
>>                   lock_timer_base()
>>                     raw_spin_lock_irqsave(&base->lock) <- SAME LOCK -> DEADLOCK
>>
>> because BPF can instrument a place while the timer base lock is held.
>> Fix it by using an intermediate irq_work.
>>
>> Further, because a "timer base->lock" to a "rtpcp lock" lock dependency
>> can be establish in this way, we cannot mod_timer() with a rtpcp lock
>> held. Fix that as well.
>>
>> Fixes: d119357d0743 ("rcu-tasks: Treat only synchronous grace periods urgently")
>> Cc: stable@kernel.org
>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>> ---
>> This is a follow-up of [1], and yes we can trigger a whole system
>> deadlock freeze easily with (even non-recursively) tracing the
>> timer_start tracepoint. I have a reproduce at:
>>
>> 	https://github.com/fbq/rcu_tasks_deadlock
>>
>> Be very careful, since it'll freeze your system when run it.
>>
>> I've tested it on 6.17 and 6.19 and can confirm the deadlock could be
>> triggered. So this is an old bug if it's a bug.
>>
>> It's up to BPF whether this is a bug or not, because it has existed for
>> a while and nobody seems to get hurt(?).
>>
> 
> Ping BPF ;-) I know this was sent in a Saturday and only 2 days have
> passed, but we are at the decision point about how hard/urgent we should
> fix these "BPF deadlocks": As this patch shows, the deadlocks existed
> before v7.0 (i.e. before SRCU switches). And yes, ideally we should fix
> all of them, but given we are close to v7.0 release, I would like to
> focus the new issue that SRCU introduces, because that one would likely
> affect SCHED_EXT. Thoughts?

Yeah I think this deadlock is "lower priority" in the sense, I believe it
existed even before 7.0. But the new SRCU ones are related to 7.0 where the RCU
tasks trace implementation was switched to SRCU. So in that sense, yes I think
the SRCU fix has to go in for 7.0 itself ideally, with the potential timer fix
above moved to a later time.

I wonder also, could we (programmatically as a startup self-test) add a BPF
tracepoint program to every trace point possible and see what blows up? I am
pretty sure there are dragons in there too other than timers and workqueues.
That would also make for a nice-selftest, where a test BPF program is hooked to
all tracepoints and then busy-loop somework load is run. I'd brace for some
fireworks but..;-)

Btw, I am testing the v2 of the irq_work srcu fix, so far so good. :-)

thanks,

--
Joel Fernandes







> 
> Regards,
> Boqun
> 
>> [1]: https://lore.kernel.org/rcu/2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop/
>>
>>  kernel/rcu/tasks.h | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 2b55e6acf3c1..d9d5b7d5944e 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -46,6 +46,7 @@ struct rcu_tasks_percpu {
>>  	unsigned int urgent_gp;
>>  	struct work_struct rtp_work;
>>  	struct irq_work rtp_irq_work;
>> +	struct irq_work timer_irq_work;
>>  	struct rcu_head barrier_q_head;
>>  	struct list_head rtp_blkd_tasks;
>>  	struct list_head rtp_exit_list;
>> @@ -134,6 +135,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
>>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
>>  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
>>  	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
>> +	.timer_irq_work = IRQ_WORK_INIT(call_rcu_tasks_mod_timer_lazy),			\
>>  };											\
>>  static struct rcu_tasks rt_name =							\
>>  {											\
>> @@ -321,11 +323,19 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
>>  		if (!rtpcp->urgent_gp)
>>  			rtpcp->urgent_gp = 1;
>>  		needwake = true;
>> -		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>> +		/*
>> +		 * We cannot mod_timer() here because "timer base lock ->
>> +		 * rcu_node lock" lock dependencies can be establish by having
>> +		 * a BPF instrument at timer_start(), and that means deadlock
>> +		 * if we mod_timer() here. So delay the mod_timer() when we are
>> +		 * out of the lock critical section.
>> +		 */
>>  	}
>>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>> -	if (needwake)
>> +	if (needwake) {
>> +		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>>  		rcuwait_wake_up(&rtp->cbs_wait);
>> +	}
>>  }
>>  
>>  // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
>> @@ -338,6 +348,16 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>>  	rcuwait_wake_up(&rtp->cbs_wait);
>>  }
>>  
>> +static void call_rcu_tasks_mod_timer_lazy(struct irq_work *iwp)
>> +{
>> +	struct rcu_tasks *rtp;
>> +	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, timer_irq_work);
>> +	rtp = rtpcp->rtpp;
>> +
>> +	if (!timer_pending(&rtpcp->lazy_timer))
>> +		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>> +}
>> +
>>  // Enqueue a callback for the specified flavor of Tasks RCU.
>>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>>  				   struct rcu_tasks *rtp)
>> @@ -377,7 +397,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>>  		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
>>  	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
>>  		if (rtp->lazy_jiffies)
>> -			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>> +			irq_work_queue(&rtpcp->timer_irq_work);
>>  		else
>>  			needwake = rcu_segcblist_empty(&rtpcp->cblist);
>>  	}
>> -- 
>> 2.50.1 (Apple Git-155)
>>

-- 
Joel Fernandes

