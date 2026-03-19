Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170823ABBF;
	Thu, 19 Mar 2026 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952026; cv=fail; b=KQ6Ki7h/On46ZqW4EAGtgL6iBOD35n4nPJCJ1jNTvSS0PyR25zIc9qzzrqmF6MLfmislJvQZyw0qAy4PZ853goOqfYqJ0gJcxZxtccl67tv7TbU/oHBq6CslhEChmuuhcMXK/eI+B2NNaW2seUKwRDZjLUFBI4+bVQgmC2yQLIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952026; c=relaxed/simple;
	bh=7Ij9yLwNXfMFafbSbeS1eq9ykd6cZXNcgl9V3oYltvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIPILzei/NyQ69jDM7uAOx0751E8U7E49laWZZmftpEecxfbgTkifxxjAupXxisXI37IrNynORVakREf3N8I9XT/KmnPZ9REp0eJfUg2Ay92UnY3ZA+bTrbmachpdKaXUz/0vAn8jMw19BQi5TtIy438q+ms4ysf4PxZbdJtCvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=joiDrvJx; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="joiDrvJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc41zWJCe83H3+GCgU2O1XsstglmLEXs05vN6Y8SD5ncEisdTrh+qNb+yQU2Av9RKUh45aH6Xap6ptZ9KQ+QB/OIoGKJPu6JZwCn2p5wFqxqo+XN5VQeen4pUy8reacs1VwBDsA3G8icnaJpy2qSv0yZwHUnSG+UX7/lO/GPZGQhdXFo2HsDjgUirW6VI0yotU1r85NAxx2LB+V+ezHjx7d1yw5ubLV8Q2N7jglxnWCGhCnUoef296lR+9/Uv49QEnfKIBKgwnxASC5fMOHsXyd1+yQxlHL1UxaBYrIDCJFuJj5eLMXnQ3stsP2aWhEBNNxhK+KzVDNVx8UZYXnAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqorDPV+exu0NY+T5x60HbwDuitg6EPGE4IELCi0C5Q=;
 b=wsVPLctzE4diQDU8rR36GozTZtUfF2eR5mjdOd1MrqDrOIBHWFRZ8gN8iWM2wyK1FwbWXTCGu9zkKe+IOKAsn4IMJhJId1lErwHkgg2I6j8CMRYEa20Y7gpk1PDAEHOSLhxmtcI3Ua4WuQo+V3OF5mOk9w7eri8Iwzkr7bJ2j7BBAV5iVIxAR0C/VdJHUCbbwNvBBG2TnPB83ABl59uKQNd0UKsgleReBWZBvhR0c+XOrWqKCgEktimUooYKhGCrAKhQzJI+ufWXt4dtZ53GIAbsjxXWMiZddyKtGARm0/dUXJ+SjLFToX10Tr61ClBQDrf2X0t4bW1jE1E2RATVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqorDPV+exu0NY+T5x60HbwDuitg6EPGE4IELCi0C5Q=;
 b=joiDrvJxDTJR8d3rYPZqPDwpi0f1LEFQSkrCnx1b4GfCm2RMT53p9bMGODNC8xyBXbInrRQLRr+sxecx80L0i7o4AfGdRc570FqiGG3DMp3RovMZoK5zhEx3FXto/onYLm9mO2dQyv5fnCjDDONxg5E42zpKCMpKrOQ9JUbiU64+BEmZkZJ/ma5j88beaD3Gvc1TnXpRdH9djvsyaEj8yYmys0Dce4Bxeb34gdzX3zSPvyP6ci1ptEzk07+Pnn5HnkYkIxnIwEbkk7L+jqsQVyc3ciP8L7tzLpwmKSwW5oN9hF9wbJwzoLXBN7zHZk8/LQdCSxcFvOgwnRt7su6Ckg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 20:26:57 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 20:26:57 +0000
Message-ID: <733c185e-9672-4184-ba65-ae5279f5bfd2@nvidia.com>
Date: Thu, 19 Mar 2026 16:26:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
 boqun.feng@gmail.com, rcu@vger.kernel.org,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Andrea Righi <arighi@nvidia.com>
References: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local> <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de> <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de> <abwo0I_mu94t5Ews@tardis.local>
 <20260319170244.jqndSwct@linutronix.de> <abw2ECYirX1tTwV9@tardis.local>
 <c520958e-78e1-41ce-b675-4a560305a206@nvidia.com>
 <abxap0vo0SoP5Jh0@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <abxap0vo0SoP5Jh0@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0671.namprd03.prod.outlook.com
 (2603:10b6:408:10e::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5ecac2-dd36-4c68-deb2-08de85f5ddcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k6FxBu/QoV/Q3Q5An+BG5lCJEjW8ORGFzNP8hBh04KKt+3doqUIl9xLm6N65mCP22bBdIMyfuwNKV4t4HWlXRdbn/KsM4QtC4yusIWtV9crvOSPsvlE820IVcbTFcBd9SNagX/PQK3DpyJ8Rsz1NP4NgfnT2+RNhH03op0/53xJd/aECqdgYqhWLQX+oAJt2+1UQLA7GTbX1G4M05i0toXscWu5QsUI4xPRso4Xv1zGBcI+8+eCnaikcmPRc8ispnH/lclLBNdExVSgzWrR/561ne47UvrhJ+bSXJaCopKlorJ5J75wZgFKizp+3ORf4+1ga7/f1Ti72ciVPLWl3yLlSHw+E5J/2WQGu50wsfgfeP59Cf67wW96V7CgKTXuQKCVhB75ZOkl7SL69FfZjdlyWtyj548lXMIDpMYBUrpMYDD2Q2Bql4dzhmHtsBhob2NOSjDwVbBI/c1gQdm5Um6z2KE4wKB8vMAytz9LScGKBziC+elnIzInbOmnRUnxSBZZt+u531Mj04DPm3PZnpzMU8H3RHcQIK2ue43OJ7F/uhjO0urYhc6+EzHs8/p634jZRFmQX8/hP0kCvsZZT8yVaFjb/nnFrArS72oRpnF+SdAyCwV/fczsnBhuLhIKbNrRsN5HlMLfT/B43ABqe5zI0eLyFu3dNAMCbbqyc82gTqPJSkANQbAse2sTcm1R1bCUTjWzfVEQEZecjtYMF9YgUzpB6iDzXlcXGVi2bCXTh8sKq8us/XMwY/dMpqJxP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkYyS1p4dzJNc1FkUDlWb0lVQTVGNFg5eCtIQ1hMT0w5WHdYVllJOXZqYVNa?=
 =?utf-8?B?MjBMRnkrdmY5bG9vOU9BM1dUb2V6cmgyc2tYaWpWZkRjQ1MrTkV4aTdHWHYv?=
 =?utf-8?B?N2VFYUpMZnllTG44cThWd0crVDM5UlNYNXVETjdhUHMyMFNtTlhqdHVTZjlD?=
 =?utf-8?B?Sm01REg3cFlHV3VHd3plRWNTRFZLb3BOcWJpYUc2VjF5ZTRKbEVhSmJXbmVi?=
 =?utf-8?B?ZjRkeTlNN3dsSFBzdkNWQnpvanVxNHRicko2K1VpUVNmS1hVb0p0eXdneHlw?=
 =?utf-8?B?THFBWk1yUTlDZ2dRRldYa1V6d2FZcEJnSlYxQittZkF0UU9DUm5IRGhCeTU2?=
 =?utf-8?B?bGN4d1RRTUYwNE5POXBvdy8vUEk5eDZlcGw5dDQzMkdLQ1NuNUl1ZzFUaWsr?=
 =?utf-8?B?MjltYStjUmhudExsanRDUmRWdCtCTEpBWkF1NGw1cHdXZXBpRWFvQ1U0Sjd3?=
 =?utf-8?B?YTJmWXJDbmZHb2J5Rk9DYXJqL3BrSm1RRkxrREVURWxQMjNiRzcxUEdwUGFF?=
 =?utf-8?B?OWRwdElhK21aSm81bmRFN2JHcXR4d1dBZFJ6T0wyUHZYMGQyQks3V2FaVWFQ?=
 =?utf-8?B?Yi94OFREcEJDV3NMdEtGb1ZZNGFVVmpaV0FzUjFCSjY1ZUlOZGdHekhBb2wy?=
 =?utf-8?B?RlNqM0hIZVdsYmw2b0FRRUNZMlU2WDByMXptTlI4SkxQZjIzamhudncvUU5W?=
 =?utf-8?B?eFo1eU40c1lDc3pSd25hb2MrTmRpeXNWZGJDRVJNWHZXZ1RzaVFrS1NFQ2Va?=
 =?utf-8?B?eXFoa0czUk9XZE8wT2k5VmpaM0E0ZDkvZnlDQjc2Sy93MW9wcWM3aC82NS9R?=
 =?utf-8?B?SEFoYWh0WHlSZWFaaVBOZ3hYZ21KRTBsMzJKRktnZGc2Y2ZrVzFQcUpTMTFV?=
 =?utf-8?B?K1FUSy9IRFN4SDZXcFNyNE80VnVjUTB2RmFoUjA1MUx6aVhUandaUThWU0kx?=
 =?utf-8?B?MEkxLy84LzdSTU9rQ1FHZW5xcWtKQnpuWWsyRTlXaklmSWtLajFHLzNwZVpI?=
 =?utf-8?B?OS81RENGVmovNXVQMktRRWhSbHVPUXZKM1ZseFlGZDJZb2FubDRXVFAyUmov?=
 =?utf-8?B?YXlyN3dudkhKY0c0NHJTbjkzQ2lWVGhVSnNBSllkWGxKUTB4MkVEakxyQWdl?=
 =?utf-8?B?a0VZSmx1cW1pOEV6OEZWdVZwb0UrQ3Ara3IyNjNCTW5qd0swNjB2TU03Szdj?=
 =?utf-8?B?dGNoRnNMZ2NrNDlZenFtRGp5NTlrcmZ3SGJFWGE4L21qc1FYYmg3MG5qaHpr?=
 =?utf-8?B?S1BneXBSbUJyNU9CYW1aK2hyNUFPTzFhKzE5anRNZ05WOUJUdisxTVBQcERq?=
 =?utf-8?B?UlhsaDZOWmw3cFNwSTUxY3hvQzRaVmExdnVTR2luaGNwMVBCWEc4MVlHaE9M?=
 =?utf-8?B?QWZ0a0RLcGdoMTBpS3hWeFUvaG1MM0gyQmljK2NaSXA1K21nL1BkRUd0Q0du?=
 =?utf-8?B?R3U4QnZGcnkwcGVkZWZNZU5QTDZaOE05RjB2WUhuUTg2SStXeHlUK0Z5VWJP?=
 =?utf-8?B?eU9OZnYzM3dxVWI1eE9IeHVRMHFEL3BUWGREVnNXZDRYMmdLLytkVnd2UWxX?=
 =?utf-8?B?eDRkMit0NmQwanRITFhNQlBETjVHbVU3aXpjTUJHNUN0YU1ERTgyc1R5bDVL?=
 =?utf-8?B?aXZXM2JrL2wvekh3ZFhFdkx4TjJ1YnlEWnRMZWxPbU5kM2dNN1JMODhuYlJ2?=
 =?utf-8?B?eVhGNSt4aVR3Z2JlcCtMdVFYVWlUVm8waTh0ZTZOUFpFVDJlUU53UEdUQVBY?=
 =?utf-8?B?V1BIdnJHallLNVovYW1yZ0ZITm16d3VGcDBJWEc3WUV6NXZpcjVCNFRtNEdP?=
 =?utf-8?B?WEtNMGZiSjRXdVYybVZzMVk1eSsvOUNTckRIMzZ1cmg3cENEbzROUkJONEJM?=
 =?utf-8?B?M1ZDVVdUYmlOOVFZZk5acFFDMFVsdEFGMnZib1ZwRG56cFQ1OVhhaU02UzV4?=
 =?utf-8?B?QzdCRGNVeTBZR0pKcUdGZWhGMGp3M0JxR1MyRlVrUzlpT3NlWVNTSlBNVFlr?=
 =?utf-8?B?MUpTMU42MTR1WWwxelR4RXIzenpCbGRlYW1xM0orUDQrU2Rma1VWUUNicGlu?=
 =?utf-8?B?Q2lZcmhOdlUzWEpCYno5czVPaXg1c0tGYnNsdUdrZEJKZVRJZllzTVcwVDU2?=
 =?utf-8?B?SUxkTFRhV3R1eFFxUmlCNEVOSEppMWVNZzFXaGM5UlUxK2UxMzZoQzZjL3pW?=
 =?utf-8?B?SElEQkNzQVB6Rm1DZkhOK25TSkN1M3pVN0NpRnl4MUlkVW5meHZTVlo2b3Jn?=
 =?utf-8?B?TC9RSmgrVm90Uld2Z3lSMkdKbEJZYzNQZEpYREVGVTN1dU84L1ZlMG5UMGdV?=
 =?utf-8?B?VUlpU1duT3BPckVoMU00OTEwaVk2OVowcFpXWmxGeGxFY1pXZS8wZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5ecac2-dd36-4c68-deb2-08de85f5ddcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:26:56.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8RifPDU76SVPt+S0NTTMDz7xzLOd+FvnkBFHQvNdbgb7xnf95Wi33qKXdGzCjKQj4dQL01CO9vsBgMkWHmRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676



On 3/19/2026 4:20 PM, Boqun Feng wrote:
> On Thu, Mar 19, 2026 at 02:42:56PM -0400, Joel Fernandes wrote:
[...]

>>> naturally happen: if the extra irq_work layer turns out calling issues
>>> to other SRCU users, then we need to fix them as well. Otherwise, there
>>> is no real need to avoid the extra irq_work hop. So I *think* it's OK
>>> ;-)
>>>
>>> Cleaning up all the ad-hoc irq_work usages in BPF is another thing,
>>> which can happen if we learn about all the cases and have a good design.
>>>
>>>> If we could get that irq_work() part only for BPF where it is required
>>>> then it would be already a step forward.
>>>>
>>>
>>> I'm happy to include that (i.e. using Qiang's suggestion) if Joel also
>>> agrees.
>>
>> Sure, I am Ok with sort of short-term fix, but I worry that it still does not
>> the issues due to the tasks-trace conversion. In particular, it doesn't fix the
>> issue Andrea reported AFAICS, because there is a dependency on pool->lock? see:
>> https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
>>
>> That happens precisely because of the queue_delayed_work() happening from the
>> SRCU tasks-trace specific BPF right?
>>
>> This looks something like this, due to combination of SRCU, scheduler and WQ:
>>
>> srcu_usage.lock -> pool->lock -> pi_lock -> rq->__lock
>>        ^                                       |
>>        |                                       |
>>        +----------- DEADLOCK CYCLE ------------+
>>
>>>> Long term it would be nice if we could avoid calling this while locks
>>>> are held. I think call_rcu() can't be used under rq/pi lock, but timers
>>>> should be fine.
>>>>
>>>> Is this rq/pi locking originating from "regular" BPF code or sched_ext?
>>>>
>>>
>>> I think if you have any tracepoint (include traceable functions) under
>>> rq/pi locking, then potentially BPF can call call_srcu() there.
>>
>>>
>>> The root cause of the issues is that BPF is actually like a NMI unless
>>> the code is noinstr (There is a rabit hole about BPF calling
>>> call_srcu() while it's instrumenting call_srcu() itself). And the right
>>> way to solve all the issues is to have a general defer mechanism for
>>> BPF.
>> Will that really solve the above mentioned issue though that Andrea reported?
>>
> 
> It should, since we call irq_work to queue_work instead queue_work
> directly, so we break the srcu_usage.lock -> pool->lock dependency. But
> yes, some tests would be good, the code is at:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ srcu-fix
> 
> related commits are:
> 
> 78dcdc35d85f rcu: Use an intermediate irq_work to start process_srcu()
> 0490fe4b5c39 srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()
> 
> One fixes the raw spinlock vs spinlock issue, the other fixes the
> deadlock.
Ah yes, with the irq_work fix, indeed.

I'll try to queue the irq_work fix for 7.1 and run some tests. Appreciate if
Andrea, Paul and Kumar can also check,

thanks,

--
Joel Fernandes

