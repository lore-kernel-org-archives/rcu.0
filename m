Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81413382383;
	Tue, 21 Jul 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653123; cv=fail; b=CyzKxo7h4GeQCcGZLK3lGfKEGza6m+cocR1cCVNg8hDFRIo9bMpXsLgT2PamlZEHEMceFb24wqg+VCjziHxmCCjLb40JuEgzpWtsbVwm7LcRkoSeqiOWl/G11YHqidkCvhwDI5QUgYA5DXGl9nf/u2usOdzcKDZ4OILWJvtSYyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653123; c=relaxed/simple;
	bh=zIqexSuKB6A31OI3h7oAPc/MamGAmwqkLl9NaeyntXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s17fK8Ouxo2v1Rat9UQ+QtnKD4udT3rPpoF+eI4owwqZXj6mgzdbKo5Ayvn3Giei7dGMiv8e3ouhFp5MBzzbwOra8FHHbFpNnXMp8h/hLx156wBfdxOAnPqjTigyNlfY5eBTxxFn+lswwS66nVVgFUagTxWHenKNKi9eEQz104M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mn6N+9M7; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mn6N+9M7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1EhVwFpEz2l44HHS2zfo/EXBTEXon1NYZxj3uF9ndpYC2ti48zOgvG9OYSyyMK2OIwNSPKV9gHIADVmzpOSa6/OYxz99grdngONDk4G514JfrjjOvsxgURzE6x+ef4K0g6OvJ5jTBlKfTutVNif1GNVL1agJOKpXlWzHzMdRL6IuVcDQATFbvq3NvprAEAqXgGLwe1Ld+//lX9+pX9M9w2X/iOk/O4v539nEGY9spDbbkXpbVNbhbodfb7Du9aFtZUvh6V9/IMoldtAT4lYEixUEGMbKF1LIg6LDsxNJXCMrYlSN8BkVzg8Ih8d03abrw0PR7aUEndZWDXkl32ypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW4MOoSmHkjx/yz+9uwUXknHP7D6ANBh0Czxuw72lnU=;
 b=Isr95juzxXkl/RyPcZ97/qyKn+itTEoNA98DrMgSRPCAa8ce7wahF8TLRlhZHwBc1pihPDTf3yZgvFTgEDV6ZVLVjzjHngXenC8cM5YKgVWSIYJpsjzhw6P98/bkZERgbDUIDAxu3AcK9rygRVFX+QbkcP05mYa5NXBV6ZU4PaSH01QFRbKeS0HDcV9N383yDXWBr/Tl5jUWvfog5knmYh08X6vo2suMv4nPktaclnXreHbpfKUE55cHr5452wvFRw+Y+N7cekX19QMIcfpijrAIOIBz3CdLzbeJ4KBtTXL7S+ukFwGpAkTpDTBNEq3N8oJXQs0bAzbGJ8C8MiVV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW4MOoSmHkjx/yz+9uwUXknHP7D6ANBh0Czxuw72lnU=;
 b=mn6N+9M7lE3K+7uD9IhkncihUuhTxjzfuIFKqi+i8brqiLZ23svyr3OB+eGOgVTNe0ui1u/P3TaM9cBCtWL4U9LiuaB98Mb2QjfK/x/CIs8qD2UuZ96CTRSIEEk95ZWAPMHLk85hEO2SgfyxrbXKZ8I3TLoi8wlkUhaSts94feM6QDTtZJjassweii6LpL4xNFrqFjOzmb3EAnEdthQVxcof8yHi38NF4c4iOEXPpbgIoZPy/jwDnyRFjpNdBC88/G2uwLA1jb6Oc3H9xee+ZdFLpRUpF5EcBVqZ8yh/SwfbUOCemSnuh1dmgbf4o19Ad8vBBRHpXZNrksMQoqeDpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:58:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:58:38 +0000
Message-ID: <9b08731e-827a-49d2-8f4e-b5cd6ad83913@nvidia.com>
Date: Tue, 21 Jul 2026 12:58:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] rcu: clear defer_qs_pending in deferred-QS bail
 when nesting > 0
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-8-joelagnelf@nvidia.com>
 <977751ab-b5e8-423e-84b9-8a51c0f2401b@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <977751ab-b5e8-423e-84b9-8a51c0f2401b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8654a0a7-ddf4-4b78-763e-08dee7494f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xr9uylb8yTmGbBMSpKXXidWH0Nd33NuMjSrtH5DeKNa6KfnJ141IeARvkl/XVupn3hAFwov7iNRnmJsChzBXzE+FnkfAdLJvLZoO39dwQn1iU7LN7MFroCbEWauQ/yf+FctJDLoArAQ45piIpJdOQaQgm0r/63Le3uOgariMUvdWJOrMRXGvGQTJ8PFQs2DefyH/qgTt1Kk7I1WCl4vNB09eWbEDziODZzuUZGh1cUDKoMQ+sj4rkq4Csl5O3t+1L5AKowC4RJ+EdU+ISLFtZwD29BrFqzF8xPAEb5sRXHHQCRBq6pMdSirvD0UBdw1yGvC69CgInqqwpCUURrt7WKrZuGJHWcpvTZkqFkQXfaFzTSzhZ37UuSN4w9NjdlOapG/B9lHGX/6gKQOePW+CVf3uP78dC512wOF06q6R4dXtN0Y37HI13cFsiymjjR836+/XAdMC8eW7Voy38xWvbVcqrurCcqskWH5XfHNLMThxcp+gijutwbVfj+BEGITKzIYrQ6LW8qy0k1W4kMtzYQUaD2H8Cnz6nw5JdXcp33fSG+t8egtniYPQ1GldKPQETBnT8471GZ1BAUblLXj6aK59bcObfs4eh2k3n8V04QVW4J1M6uBMXQOlAxXP5fxZ8whvlOi/MpCedqoP98bvUx8vU03W8gWesvE6zlxIYes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDNqdDhLY3RTSjg2b1krRzdDQmJmT0RWNGtEUU9TVlJLNHJFZGVqMmZua0Jy?=
 =?utf-8?B?U1lXVWFYUldwWWR2d1QwZXFod0k0dmhCRlJmM1dJUUNWZnU3MXBaVy9EWE0x?=
 =?utf-8?B?OGVJY1JoR21kdEtnSXF4ekNCUVQ4L3F0T1A4SXc3bjZkNzdHMFJ0OXdnODlm?=
 =?utf-8?B?a1J5elQ5c3NPQktaeVMyM3VFbkxNbSs1aXpDREhVWWhnbkJ6b2xWVXE1eFk2?=
 =?utf-8?B?cytDTklZcjVSMUhaakRmbzh2TXJpTDMzZ0p6TlpKL25hajZYVlRQakQzckJl?=
 =?utf-8?B?TGwxc3o2TDJHZW5uU2hxWHhKRGZZUFBEL3YrdDFGZEdxR25FTGZnbkRWSFIr?=
 =?utf-8?B?RzF5QkZXUTNYYzdtRFNKNnBhYXJTeHZqa0VUUkk3emZTM2FGK2h2UVptaXpB?=
 =?utf-8?B?ZmZPRGtPUmI1YVRWbW9hQ0JzU25TcGpEbTNpZ2w5Vzk0cEVLSGRMMVRUTEFZ?=
 =?utf-8?B?bmtCWkE3cEsyVUowWDk4dEVIK2tuU2dVVFBqSHhKSTlXZXR3QkdVVzlTakZ5?=
 =?utf-8?B?Yk9zL1R3VGhpb0NHR0V4RVVQRDNLNVBDM3pYUzR0M3g3U3hWUm5zT3llZ01G?=
 =?utf-8?B?cEhWTWxjZEIwNlN1aDYwbXc5a05LUkRQRk5GVnZyMUpvMEVyMXA2UWxpMGhl?=
 =?utf-8?B?RjRvZHBKOUtyYjRZNVZtcHRjNVMzeE9XUUhuZWg3U2d6N3drTEI4UVZSaFFv?=
 =?utf-8?B?QU5DL2E2UHp2WVJvem9WUUduTG9sT0VDaGdWTUoxRUhzNzBzdklPYXFPQ3Vu?=
 =?utf-8?B?S0ZzQ0FKa1BIOTBuaGk3T0dTRDRrRzBNYlZ5OW1zSkN6eWlwQU5RdE03ZnRy?=
 =?utf-8?B?cmNIUHMrdFREdVZpaGlHRncxdGdEQUQvVkc1a2JMb0tHelhYM0FsV1ZBM0lZ?=
 =?utf-8?B?MDVHclhwaVY0VXZDYkg2VFNHMGZ5QnM4K1h5NkRFMlU4MTRybXRNRmZ2UGVU?=
 =?utf-8?B?M09BZUw0Y3dQR2FhbnoxMnBSZ0VWakhvMjFvMWRaeTJFUGZyckxaUUQzUGts?=
 =?utf-8?B?YmN5K2VQM3lNZWZaMThHbjdidU4yWDEvSVpVRDFjYkhKSHozVzRrV3NrNldN?=
 =?utf-8?B?bExQdkp4TFFhRzJlNytxWE1TWnE1Sm1DemtLTkhJZ2xUbkdDa2JXQnVxeFVr?=
 =?utf-8?B?MUViRVZlRDBiSnV0RC84QnFkV0dBbHlOOW5VZ203Y05yeEN2Zm0vaENYZS9r?=
 =?utf-8?B?UzRsRnY2dllQZ0NBTkg2WjR3L0lkZDFaOUlPVnNRSVBxNkZpSlpXd3NESC9S?=
 =?utf-8?B?YjRnOFlKMmdQTDlqOEh5N3RGVG5DY3lqQWJNTm5jcHJjSFQvUkF4eU9TL0xm?=
 =?utf-8?B?a3loQ3pHRUhxdWxPN3c1Q0hOdGcxSGZRUW9uUDM3Skk3cDRxdVJtODRtWnpk?=
 =?utf-8?B?dHpBYVVTclA1UTZpZzA1UzZsaExhK1czRjU2OW5JRkJiMlFVenVGYUU5N2dj?=
 =?utf-8?B?Y2syUFU1UDE3N1FOMlBPZnFqN3NZNXQrL1c2NXlpNVM0Znd1Tk5zYnl5Y29Y?=
 =?utf-8?B?OXRBTHg5a0xjcFYzR2owOGhVSEJuN0lKTm51SmRUaVA3d2JTb3pLcW9HOFl5?=
 =?utf-8?B?Qkd2TFRRVldUVzlhazkrN0NvU2IrWHVtUXYwZThYaUk0STVHcnREZXAyeXZk?=
 =?utf-8?B?bU5rL2UvS2JiTytMbEh3T3YwT3M3My9UZWxST252UCtvaDRHT2h6RUZGbUox?=
 =?utf-8?B?NkNXZkVoUFloWWpaMWdsayttVEJqOS9RakZTZkdFbktLSStuS2FqYU9nVHY0?=
 =?utf-8?B?a2NaT2QvRTFseVcrUkNsYTE1RlJUT0VQWS9aeUpMZmFpWE1tWlpISnAwZDY4?=
 =?utf-8?B?R1lGTWxyMTVObXZMOEMzRHZLWFJZbmFSTUxUMFNaVDU5akxiVEpIVU50UE81?=
 =?utf-8?B?blczYmprbURERWNOa0xtUTNVYUNnWGpuZjcwelZKU0dGcFVBMU04d1ZSZytF?=
 =?utf-8?B?N0dFRDdyMGZoMWtYYmlDeTVtNUF4WGNhaFk4cElDZS9jejZpbDhDb1o2K1Rx?=
 =?utf-8?B?aHNaYlBQSElxUEpEb0xtT0pPQWxyczltVDZsUzUzNDdzVU5MVVppb0U4R29D?=
 =?utf-8?B?T0dYamppL3k3b0VCTUFmTUpzaXVMd0twc3VGZlNlVDBHbWVzSm52c1ViVVlY?=
 =?utf-8?B?ZTNjazU5TTk5MytLZWcvZHNud1gzdnk1aHRHUHh6ckp2UnM3N254K2hYT3VY?=
 =?utf-8?B?Mk95NVZNQ3BPS1pTTEk2czFrTWlNbjdMVVFqTmVLYVcyYmhaUTV2b3dYL2dX?=
 =?utf-8?B?eE1EUXFkb3pjSmRtMEdMcUtBUGpGUm9CUW9rTE16ZW1WSjVvdi9aZ1lhVWtq?=
 =?utf-8?B?WEJmQytCVWNFUjVkSDEwaytjcncxeU12ZnI2d0hveE9SaHB4a21Odz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8654a0a7-ddf4-4b78-763e-08dee7494f16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:58:38.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWFl15Jm4Mbl5tGMWwnXNBpUfNpOj09rfXBzPVFg3DPQbkF5TXK9SiBg6fQZwN8gC4BDtxi8BTMnC+gTJotqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271



On 7/15/2026 5:30 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:43:00PM -0400, Joel Fernandes wrote:
>> Paul McKenney noted that a softirq (or irq_work) handler arming for a
>> deferred QS can fire and find rcu_preempt_depth() > 0 -- the task is
>> still inside its outer reader, so rcu_preempt_need_deferred_qs() bails
>> without reporting the QS.  At that point the queued mechanism has been
>> consumed but ->defer_qs_pending stays in DEFER_QS_PENDING.
>>
>> In the meantime, the only remaining path back to a quiescent state on
>> this CPU may be a local_irq_disable()/_enable() pair that does not
>> call preempt_check_resched() (it is just `sti`/`cli`).  patch 6's
>> unconditional set_need_resched_current() makes need_resched true, but
>> without an irq_work being raised the next outer rcu_read_unlock_special()
>> hits the P-gate at the arming code:
>>
>>     if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
>>         rdp->defer_qs_pending = DEFER_QS_PENDING;
>>         irq_work_queue_on(...);                 // <-- skipped
>>     }
>>
>> so no irq_work is queued for the hardirq-exit preempt_schedule_irq()
>> path either.  The deferred QS now waits until the next timer tick (or
>> similar preempt-safe boundary), needlessly extending expedited grace
>> period latency.
>>
>> Clear ->defer_qs_pending in the bail-out path of rcu_preempt_deferred_qs()
>> when rcu_preempt_depth() > 0.  The recursion guard semantics introduced
>> by commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ
>> work").
>>
>> The clear is also safe against fresh recursion at this exact program
>> point: rcu_preempt_depth() > 0 guarantees we are still inside an outer
>> reader, so any inner rcu_read_unlock() from tracing infrastructure
>> brings nesting back to outer (>0), never to 0.  The slow path of
>> rcu_read_unlock_special() is structurally unreachable under that
>> condition, so no recursive raise_softirq_irqoff()/irq_work_queue_on()
>> can be triggered by the clear. Essentially, the mechanism will work to
>> prevent the following recursion which Xiongfeng had previously reported:
>>
>> irq_exit() -> __irq_exit_rcu()
>>   -> tick_irq_exit() -> tick_nohz_irq_exit() -> tick_nohz_stop_sched_tick()
>>     -> trace_tick_stop()                    // BPF prog hooked here
>>       -> rcu_read_unlock_special()
>>         -> irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu)   // self-IPI re-enters irq_exit
>>
>> Reported-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> I am a bit concerned about this one.  We are clearing ->defer_qs_pending,
> but there might still be something that will attempt to complete the
> deferred quiescent state.
> 
> I am nevertheless tentatively pulling it in for further review and
> testing.

Right, I believe that is expected and safe. Something else may well still
attempt to complete the deferred QS after this clear, but I checked
every path and there is a check in rcu_preempt_deferred_qs_irqrestore()
which returns early when special.s is clear and no exp QS is owed, and the
irq_work handler / rcu_core paths check rcu_preempt_need_deferred_qs()
first as well. Whichever gets there first does the work; the rest would be no-op.

Also the flag functions like a throttle, but not clearing it at the right times
can also avoid doing real work. So we ought to clear it.

thanks,
--
Joel Fernandes

> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree_plugin.h | 28 +++++++++++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index f58ae29acdef..6f5d31e3f1a3 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -692,9 +692,35 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>>  notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>>  {
>>  	unsigned long flags;
>> +	struct rcu_data *rdp;
>>  
>> -	if (!rcu_preempt_need_deferred_qs(t))
>> +	if (!rcu_preempt_need_deferred_qs(t)) {
>> +		/*
>> +		 * If we got here from a softirq/irq_work that fired while
>> +		 * rcu_preempt_depth() > 0, the deferred-QS mechanism has been
>> +		 * consumed without doing any work: rcu_preempt_need_deferred_qs()
>> +		 * just returned false because the task is still in a reader, so
>> +		 * the actual QS report has to wait for the next
>> +		 * rcu_read_unlock().
>> +		 *
>> +		 * Clear ->defer_qs_pending here so the next outer
>> +		 * rcu_read_unlock_special() can re-arm a fresh mechanism (in
>> +		 * particular the irq_work path, which the local_irq_enable()
>> +		 * recovery boundary cannot itself reschedule from).
>> +		 *
>> +		 * Recursion safety: rcu_preempt_depth() > 0 means we are inside
>> +		 * an outer reader, so any inner rcu_read_unlock() reached via
>> +		 * tracing (bpf programs attached to trace points) brings
>> +		 * nesting to outer (> 0), never to 0, so no recursive
>> +		 * raise_softirq_irqoff()/irq_work_queue_on() can be triggered
>> +		 * by this clear.
>> +		 */
>> +		if (rcu_preempt_depth() > 0) {
>> +			rdp = this_cpu_ptr(&rcu_data);
>> +			rcu_defer_qs_clear(rdp);
>> +		}
>>  		return;
>> +	}
>>  	local_irq_save(flags);
>>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>>  }
>> -- 
>> 2.34.1
>>

-- 
Joel Fernandes

