Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E32C3260
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865518; cv=fail; b=cBMNgzE8tIpjW0R4cx+OjsnVYWegPFwCV2ltEXbvrvltW6lURNg0ny6ZDHA3aBJFcpOBoGHDTqQfrQmfcLy1KjC32I1Kvh5QpXnY/2lmIKYHHsZ0Gk9y3/ixDVMYjaOrT3v+6cIZBzwT0BYNQQ54pQqS8sks43Iw5fOZMj20xx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865518; c=relaxed/simple;
	bh=z49euEojeFyM9dKGoh8Y2Vec937vy+sAUEWXYdJKnzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YQmz3nNx/lyoAue8lsKNHAWF7FJZEsFDMJ3nqcBih3s7OdWGcvyc3N/+2f17gDpBu9+ehYZSNGvhx4a/FEhiAAkRxa2GAIoF0vRvEbATBQCr/K+eHEBtDtXrKzq0c61QJmHaZr+1cSfLwKk6uaps1SPIzOr7386TJJ/CrNzVVJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbMn2QG4; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbMn2QG4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyHoz5TzRjvmmIyijDc798GNEydXgZV+cFBKiuBciBgyp7qbcZTCVfShGshzqXVg31x8yzhpyUOEmN21f9FzfLYsXP6YQIptDsj+gTeuO8mw008NqkY5QrFwWta0SxsIZ9wNGiqUeKhcUikST6ISbE/owK51jIszCpGN5BWrtwYGD7gQNxOstc+qq0zgKhQwF6ZkL0x670Dci/jYx7mzK0Jc9eqarI8rbxo5CRsB8Mov4gLuGv3SX/cyVShvQSqubDljakbQOiUYvSD5JH90X3ZVmFWqp3gsI+YxC1p/S/dJfV0L578psCkwyfe+bZdfKAQxRQI7r8mOqU99zJM2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzs+hJEr89QpGcvrcWgBrvhodGjVuh2g6x70A3yCk1c=;
 b=uEg8o6htGagIe4A3TYZp9lcSvijmm4/AGtjNWeBr9y4Xf/45x8ShGBDw8/Yo1kvgot86SgAO9s07NeqlkV9gkkPK6Vqs+dQJCUrdANLLOrQtPLom1gCyGFhSsOJDNnip/i6UPdlY3z5MzXEIRvVSlRyUuzyCe8L/SgBCEfOCoyCpOEXc+Mg2jlZJ+VHWvR4SqFT/7GQMkTM0mp2Fq3WxpBbVekxoAgO+hh+73LFeKqr0yv6xa5kpDOerC6+JK6vOQ89r9aHh72aU/GWNgs4/ayvIrwlHOiaAa4XgsWLMHlFilq0pasl/KVM2X88v1yjQCJf7L3LYYU+HvwxHp0CcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzs+hJEr89QpGcvrcWgBrvhodGjVuh2g6x70A3yCk1c=;
 b=GbMn2QG4SienDj9JsJsmNhphwiM8h85FOOna1sdNMtGEX/wmwWfoAUZSSEjLg+XtPPdTZirYe3N+LcLS8O68i3Vq2tAxqA8CKM3oY1pEz6Amqcb7O9au3KvrHweHj1uLgM44++RnX7ZkDmRJSgIZeHBi4rj9RG6p3O+Tk8hRb9sbX1A6LfANZJcVhOhuqyYyWGRnvXgd83Nqh6UpNnGGtzGIsIu8pIhdLIV5plM5Srm1zqyjtQ+MSvFdi8AMuV6ASRMWi0kZrU5MXVw22qx5mgoWAgMnK+vH+edLRhoEvgD06++Oj5MybBBAH0SsuokfiS6oO2LjjNroRvXNcCyocg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 20:25:12 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 20:25:12 +0000
Message-ID: <7bbc5c57-2a69-43c8-bdc7-806b05c1a60e@nvidia.com>
Date: Wed, 18 Mar 2026 16:25:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: paulmck@kernel.org, Boqun Feng <boqun@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <CAP01T77waxWVZ7Ftscn9PZtUb=MaPZYtYJz36Xhs+2fe3pqP9w@mail.gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <CAP01T77waxWVZ7Ftscn9PZtUb=MaPZYtYJz36Xhs+2fe3pqP9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0093.namprd22.prod.outlook.com
 (2603:10b6:930:65::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: b536ff43-5e06-4a9b-8646-08de852c750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gtpJNpnXtyPS3lKpAkU1q2ccSPQ/p0HPseGhVozlqTpKNlm/bfvp+CyAMu9xP7kZWOVg6rll148raMROD6gflvOd6ksE12V5SlVikLAT+DkODFafnDKyZ6suMYqWPZcHyC9gWleySVbO3G2/xGy1FSikwhCJYPE0NXx1oIPI9418+YLDoUr0fHZmWLP2S359DLobtUtFndsUwvLQisw3hR2epFlB2Z9+2wYO7DhRk/qLPt5S19wUvBtliAX4FeyjJROh6Gf+t6cgm3o+KdYLfzQNu6ADSYJ6Z3hY+1XVWldQBwU0QZMWvrzJ5PMzyYzGyZeRBdfG6olhdBSoEOHw/gT0tXd+3CipTwJSi49pb0Hjg9kFXgtnuMV7F43zvZ8+FrHsFICEH0N3LHIoGg6MPSVURyeedAhX3pzgYlZO6F3sOu+oPZESfwX/UdnvK2CTTLtaLLmR6ObZqt1SuuaVH2jZ8tuUEgjk4+eGrqly/XO1dztzlgKElkxWSGr3zpfM0Z5QAw+OddrFUT3/mnW0lwdpo5QWtmYTH6pSFPnfIxc//NkGwfGgJAtnIiXo8r4yLKe3HPIFYx/PWrd5WLkJ1T/MXFNSHdztBaNjUX5Tjv30IYTlpOiBZcpo8BDMWDllD74ktM7pR27A5NtUTfTvOC8JGH9xuw0yWCnonTS142J8rycHUxkSmx5vTi1YwDzN6xH3YaAvh+TiT2wjg7Rj800juZF0A+hqGe8IcPp/yhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2lnZVNzMmNJZGt3eEtRaFdHYSs3bDRocmt6SitPcGpRcm1DM1E1MWYyMWJS?=
 =?utf-8?B?VVp5WFJ4dmYrbmtQQ29xZk5NbEowMytORldhQjJweTlJTkVERzNteUVLQkVu?=
 =?utf-8?B?TUhMeG9PenhpZ0w2eTBGNms0bDIxRzEzZnhlVkdlTmNUVngzT211VDZvOFUw?=
 =?utf-8?B?TFpRL2lOYUVETnBmMUUrQ2VDY2tPSk9paEN3dEdGaGtzeVNQZmE2eCtYKy96?=
 =?utf-8?B?VjVDZnUrZnhXdlp0NVVNMlk2em5PaUtOS0oyUnZJN3huR1FuMFZQaGhuOHFk?=
 =?utf-8?B?UDhzNzY4a3NlN1U1eUNpOEZmM3RlVW5IOTF0ckJZTzVhaFVwMnlsQkM0Vm1D?=
 =?utf-8?B?MGdyNjhyMzBtcEovZDhPV2ZpZDhtYi9Eci9aVlhNUUZwamRFNTA5MDd3ZWlP?=
 =?utf-8?B?S3BEVzl5T2JteU4zZ3JHS0d5MGtUc0xZakNDMjRSS2xaa2FyS1g3VmNLQTY3?=
 =?utf-8?B?eTVaYzFjYmVxWnJuTTQxb1JmRmgwajFDRDhpSEgzOW1iaXV5Y1Nod0pLSkxy?=
 =?utf-8?B?NUZhR21xK1hhTnVFcndkS0FvNCsrUEh6U2kzNEJkL05hM2xZRkdtL2ZyTW4x?=
 =?utf-8?B?MHFpQzYzRldTZ2lZV0xxY2FNT3dzaWNmRk8xaVdBbzBvWTFOZzJzQzQzaklW?=
 =?utf-8?B?VGtWYWdKWDFmbDZFZmozaTVNSjJ1QnhuRWUwa0dRNjZva3NDZmsvaU1qYWMx?=
 =?utf-8?B?RkhXN2JDdi8wY2VLbWsyTVB5cWxDRTZxQkZFZFBpMm45UkZJclVWSDBKS0dC?=
 =?utf-8?B?T2VId3VTQXp2b2VoVjgvdW1tejVYbzl3RCtLcVRpdDA0ODR0YVhzZGtPL2VT?=
 =?utf-8?B?M3lVSk1zTElnd2FqRmlOWlBtUXJGRElyemVXaFZTY3BNV2praENRQUh2bERR?=
 =?utf-8?B?QlB3S09wQmY4SnM4QnFOMlZHN3dIc2lUeG9aM1R6WmVIUVB1TEVORm9TWjM0?=
 =?utf-8?B?cWR6TDdqaHpoK0h4SWZhbm40cjlUaTJpMUp0TXVNRHBaeFBOMERGU0E1UUpL?=
 =?utf-8?B?Nm9qMkpJSldrc2ZSWHQvMjg4RENXUUNVVWhMSUt4S1FWY0Q5aVZwY3Y1M1A0?=
 =?utf-8?B?VFVFVVI3aEUxLzNFTHZnNkpEU3VSSmY4d2M1OFNMTVNVQy9Sbzc3N2x6TUll?=
 =?utf-8?B?clVYbmtJVWVXU1FHWWp1ZHpZK3pubjMwV0RqL3pwcXRXNzNTcDJpbzRoS2c4?=
 =?utf-8?B?NU44YUY3RThJK0dtR25aRzVodmR2V3laV09lSWpyK3Y0T2p3WnRSQWFyZm96?=
 =?utf-8?B?eXUzeHYxOHEwQW5WUyt0ekZWWFpsaGs5akRkRWJjTGxkQ09pd1AzT1hrK3Qx?=
 =?utf-8?B?QWNMcEk0MkF3YXE4MTZyRG8xTzZBUTlvNndRYndXVE5QMzd4ZEtqZDZNRGVo?=
 =?utf-8?B?WmJhdy9KSXRFL09hbTAwTkt4b0U1eld4SVFSOHdQNzNCa1FqUCtadFlHMXJR?=
 =?utf-8?B?bjZUaFRJK3BFWFplem1GSDd6Tm5aU3hsVjZtV0NzbXpyVXpNMWVaaXR1ZWRw?=
 =?utf-8?B?RStXRVpWbFcxclJlcmVESVIyRy9MQ08zK0FjSWdrdUNoR3BpYzNCTmYza0J1?=
 =?utf-8?B?TTN5L3BaWnhZYURvOXYrNVZIcCtjcUJUbkdIeW9JUnlsRnVZQ2M0V1FHNVhV?=
 =?utf-8?B?YmtNTXN6dTlPelVkaGgzVEt6V3R3WWxlREU1aStnUlRhbkFYbXlKYjZobjF5?=
 =?utf-8?B?b0JGOS9XSS84dVB5R2N4NnZKZzRDM3g3OUdTa1VaVDljdnc5WWlIQXBPVDUr?=
 =?utf-8?B?c0dOSGZuUGpnWFprOVdtN3pRTHhSaTBOamFFT1Q0dEtlT054dzFabUJnL0JP?=
 =?utf-8?B?c0pzTElyS1c3cmpnSmQvdFlTeHMvT2xzTXhWRGhqQ1JCa1hsQ0ZiTVdmVTU4?=
 =?utf-8?B?N25KTmpKYzQ2S2M1b1lwRXl5M01LK0FoVkdLQThtSW9HblNQWW1vVWU0UnJQ?=
 =?utf-8?B?czUxcDFmd3RYN2l3V0ppdlkwakgzV0pkeTNUb1gwVEYyNzR2YitORkRhLy9C?=
 =?utf-8?B?RzFWQWZ5NGRzUndIMTJmK2YrYi90bDhYaTlsY3ppa0dhUGRKcmdQWlgvSkRF?=
 =?utf-8?B?QjhSbndNMXltZ0kyMjB0VkFRZzR1aFBWbVlkclcrOER0TkFiV1pxZTdYSCtk?=
 =?utf-8?B?NlozQ2ZMMWpXZmZTQmtHL3MvR1d6U2ZOZlVlM0VINDBuSzhBODVLaDB0U1da?=
 =?utf-8?B?UHNIRjJkV1h6QnlDL0NHOWU4QVU0V3NXWFMxWGJUbTF1K3BZcXY1TXI4Z2g5?=
 =?utf-8?B?Yi9aUnVEdUY4amhaQTRZQTRyOVQrVC9iMHVSV2g3RElsYjQxRlhxT2NtdlFU?=
 =?utf-8?B?N0g0NGQ1eHFMUjBnSmJHRVNjU3h2amw4Qk5oTjZybnh6WlRXWjlIZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b536ff43-5e06-4a9b-8646-08de852c750d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:25:12.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkOpzHuXUQpgEPqcwu9JmevAdSrweD8EREytFFNflDJ43H1/dwB9b9yZXhVnY1U4YSgV+btRLwyAeV/wxADyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880



On 3/18/2026 4:11 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 18 Mar 2026 at 21:04, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>>
>> On 3/18/2026 2:42 PM, Paul E. McKenney wrote:
>>> On Wed, Mar 18, 2026 at 08:51:16AM -0700, Boqun Feng wrote:
>>>> On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
>>>> [..]
>>>>>>>> way that vanilla RCU's call_rcu_core() function takes an early exit if
>>>>>>>> interrupts are disabled.  Of course, vanilla RCU can rely on things like
>>>>>>>> the scheduling-clock interrupt to start any needed grace periods [1],
>>>>>>>> but SRCU will instead need to manually defer this work, perhaps using
>>>>>>>> workqueues or IRQ work.
>>>>>>>>
>>>>>>>> In addition, rcutorture needs to be upgraded to sometimes invoke
>>>>>>>> ->call() with the scheduler pi lock held, but this change is not fixing
>>>>>>>> a regression, so could be deferred.  (There is already code in rcutorture
>>>>>>>> that invokes the readers while holding a scheduler pi lock.)
>>>>>>>>
>>>>>>>> Given that RCU for this week through the end of March belongs to you guys,
>>>>>>>> if one of you can get this done by end of day Thursday, London time,
>>>>>>>> very good!  Otherwise, I can put something together.
>>>>>>>>
>>>>>>>> Please let me know!
>>>>>>>
>>>>>>> Given that the current locking does allow it and lockdep should have
>>>>>>> complained, I am curious if we could rule that out ;)
>>>>>
>>>>> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
>>>>> nesting right. The wakeup problem remains, right?
>>>>> But looking at the code, there is just srcu_funnel_gp_start(). If its
>>>>> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
>>>>> then there will be always a timer and never a direct wake up of the
>>>>> worker. Wouldn't that work?
>>>>
>>>> Late to the party, so just make sure I understand the problem. The
>>>> problem is the wakeup in call_srcu() when it's called with scheduler
>>>> lock held, right? If so I think the current code works as what you
>>>> already explain, we defer the wakeup into a workqueue.
>>>
>>> The issue is that call_rcu_tasks() (which is call_srcu() now) is
>>> also invoked with a scheduler pi/rq lock held, which results in a
>>> deadlock cycle.  So the srcu_gp_start_if_needed() function's call to
>>> raw_spin_lock_irqsave_sdp_contention() must be deferred to the workqueue
>>> handler, not just the wake-up.  And that in turn means that the callback
>>> point also needs to be passed to this handler.
>>>
>>> See this email thread:
>>>
>>> https://lore.kernel.org/all/CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com/
>>>
>>>> (but Paul, we are not talking about calling call_srcu(), that requires
>>>> some more work to get it work)
>>>
>>> Agreed, splitting srcu_gp_start_if_needed() and using a workqueue if
>>> interrupts were already disabled on entry.  Otherwise, directly invoking
>>> the split-out portion of srcu_gp_start_if_needed().
>>>
>>> But we might be talking past each other.
>>>
>>
>> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
>> different issue, from the NMI issue? It is more of an issue of calling
>> call_srcu  API with scheduler locks held.
>>
>> Something like below I think:
>>
>>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
>>   ----------------------------         ------------------------------------
>>   [1] holds  &rq->__lock
>>                                         [2]
>>                                         -> call_srcu
>>                                         -> srcu_gp_start_if_needed
>>                                         -> srcu_funnel_gp_start
>>                                         -> spin_lock_irqsave_ssp_content...
>>                                           -> holds srcu locks
>>
>>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
>>                                                  -> queue_delayed_work
>>           -> call_srcu()                         -> __queue_work()
>>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
>>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
>>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
>>           -> WANTS srcu locks
>>
>> If I understand this, this looks like an issue that can happen independent
>> of the conversion of the spin locks.
>>
> 
> Yes, this is a separate issue, we should make the conversion to raw
> spin locks anyway, but lockdep found this once we applied that fix
> from Paul.
> In sched-ext, we can end up calling call_srcu() while rq->lock is
> held, e.g. from exit_task() -> some bpf map that deletes an element ->
> call_srcu().
> There are other callbacks of course where it can be held, and other
> programs that can run tracing the kernel while it is held.
> 
Thanks. I guess I am also wondering, why didn't lockdep find it without the
conversion to raw spin locks though? An ABBA deadlock should have been
detected either way. Is there some difference in lockdep's ability to find
deadlocks depending on whether a spinlock is raw?

Anyway, I am applying the raw lock conversion fix and running some more tests.

thanks,

--
Joel Fernandes

