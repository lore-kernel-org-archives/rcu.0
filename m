Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA653644BC
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864256; cv=fail; b=Q//gzFgpXhgLMLrGcF/Wh2+aFiCFgBdZ8ealcurvjcvWSP/UkPNSTi2wUi9c71oVDTCu/92PqqvH0reDxJFF2KsralcgIoCWkVq/WSQQTxz6fVAG9v6yDz/lAmHCkwzsjMgeyrnCcJEz8Wg81RqwOlMCEp/N2XsARNCray88+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864256; c=relaxed/simple;
	bh=dL6LSWtfx04K0byse24ufWy+YO38aGQjx/6qUdIm+hs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcKfoAbpBrbtHQ1xBQ8UvMavI7y4JT6Nc7ac2XIIhJuY/gJJ2k3M2w2z+znjm8ADCKE6DwRXUZmKzCeHN1tE8c68n25Eo2JYFTI6ytPWeIRuKIfYqf9LR9FehZYkgGrv4t+9ufDge6PSQP/xFhO5NZH+TAvFQzRKz3/wS0kV3+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yk2Ubrm3; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yk2Ubrm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOo/fIA6UQFEASv9zpkm1H/JKcYCXPkGLN4f0aiyANXmQFrx+DWdgZC990tpOBZHo0xerPZr9vdqySRgdXEsKKLVI6e7wE0iI7KYOGFJN52KEq8cygI3KY53oQtneFLFmZb597det5oM3bF/pYoOtjQoM6KPmP01NG+KQ+L+K+pCiGUfDtjLmi59F+YDC5c9IebybUMznbOmSUozSZXJPqlErVqbxLcIvmEruN6EX3WUiqLwkno2B3LDDrrriT2n1etz3y43gM00Nu0ykTwk0V0INVlX2i3W6i83GzfPtUbif+NbTf8MZHu+Mh4xfXbO0+RCBS2rePQN6s8lGBM8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dn+fVlVrvLN7sGp9lSplijH8PXFegYoXrAlQuhUlok=;
 b=P1jvtuRwLWfXM5lktuHD9iD+X3blkZT9XH922l1xOGU+pu/z4rprwO6+2pJ0M5oIEKYPuH0HaMiEI9oKo56h7rczcvJKw52qjd9a0qCB50uTER37DsQloaH4Yo91I8iBOgFe08ZqE6X+8oX4zBX6wqh1/1TfAFtw3dcBpbHcY/z+X7XCLCoTkpOp9co4uBxeOjMlKPwX/JI1RU6STzuYhxB62GDoTkGyd2ZAKpVPQF0cgYBK94JQZWoO8bGv9hwXp4kT9vBYK/FxqVQ+T3COgI48W875w4S8z2PNbdKaadFinnAQZh7w5iC+sIINvaZIunMth6qlGb9JdASOdLYKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dn+fVlVrvLN7sGp9lSplijH8PXFegYoXrAlQuhUlok=;
 b=Yk2Ubrm3l9wfWuHN6U/cP6kVJLy6IcO1ohNezARs7qfW/+7/PsZwP0KykJ0Gl/5lk489ir1AxNYgy+E+SQy9HUgr2g6o3PCJro2apNBchYRMuiecJcwqs53qroC43ZB1MXtz7biagnfhIJeTYAM63hQ84Y47VOSM842UF/okvX1hqH3zMu0/cy8TYM2io2EYSrJwbyQpEEOqWXvD7t+Dgeg9OuGGJHvu1DDxB0oIk1IkTqgzdFFz6Biskye6gjUKXP9MC+pYy6Adq9gdOHLfrLwS5JBB/Ercgre2vUTaCEXaBIIil1o3UstBQwOkiNc2nCiPkA/c/LHZvk2YB0pZpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 20:04:06 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 20:04:06 +0000
Message-ID: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
Date: Wed, 18 Mar 2026 16:04:05 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
To: paulmck@kernel.org, Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org,
 neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
 rcu@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ad54d7-6d19-47e7-a32f-08de852982b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	on0f+rV/yvnDYD3kOVZtwRjHSrFg71Uj1WWjTa86ifTc+kC0Wqw/cFdeRxqIKOJxPLXOSIx3SpPTjr4SrPQR0mwoIs4wpkAHjOgtKxlBvraJ20SaHQbNXgmGX81CvHFHpgy9ABGRybJ3X3LqDJvpbtDaL8LI3iCZcuolCUDWbFLgDLUKghp8b70p+1eUaYJ7TtOYTJC/qeSLLYoGQzApwELlZ9XGYv24I3LbAWhSBz6tRtYIDxFa88GDVWCEUyOLE+EuVZ3kZ4HFikQ7TNaMQU7FN3IaRrE+iyQ40vkW8XoTZn1KIT8bqaZ/BqA6V27eOGGbwBpMlylSahbnBw0+hbEBcZElV4pePR63+MHLNcDmqFNrNEr11+SkmeWBgQy0YCKqJuYdJcwreEOstEeeH+iEDXae01YfCJX/cQwikHY7VW7dszr3faVusTALyXjulAA5sYoyOdC0yrovAGZ+gmf8XStKIodTvOeqlAN/+BYmH7DtXjA7RQSneJg13yPby5WKxWqc/kEhn6zW4nP8pb157gXIT91WX23T54nLyCJv/PnuGo55+MtY5KlL8tsFC0mARseAR3eNi4PxzOxgxfn6ZchBkJQNmcoLDzge0xxgnWK5HDEsraOOkf8zydH4Fsisp0SJqRS+wjsyKZUUR28FI9URZJ8TYmP65OYgzy0++OeuVIvltDrRVhjTFnixvkfA/d6q1nuJQJ5vzqz4EFZc3/DSG2jZx3L7hGWHdfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm1oVjJncG15SUJGSHdSTFhSWEhnNXloWWQ5TTE2VlljOEEzU1NUc2tqMXdy?=
 =?utf-8?B?dXk5d1dOOVpFTStnVW85YkVYY0VqZm5uUDVmaXVZWXViY3piOENLSzRsRUVW?=
 =?utf-8?B?eXVpYnMrakdRSkpkb0IyRjlNRVAwdVBIL1NTQVhSeWpoaVJaamNWY3BtOWQ0?=
 =?utf-8?B?czcxMUdaUHNTZjBGcjdHNlRtMi9Rbm54RTIxWk43bHY4ckd0MFJGVHp6ZWlS?=
 =?utf-8?B?R3B3Yy9ZVDdMYnl3blJXYW12bXdaUjdaSkpNUlp1TWt5NEhGZncrc2JnTlJ3?=
 =?utf-8?B?UkJkQ3NBNFhmRGtMQ3Y4V3pxNzByaHVvWlpuTDhLSElTY0twV2tHRVQ3Y2tD?=
 =?utf-8?B?M0pKVFU1OGF5QmNkbFRWVEpvcmxqTDVMZ3IxQTJXK0xKU0xYcWtIN0x1UFpx?=
 =?utf-8?B?WVZyVTIvaVRyMmViZ0t4a2ZrMlRHQ09Bd2pqdUZ5RGtRNEFQa3lqNm1qc00v?=
 =?utf-8?B?dW9nTG40d0VHT09UWi9KVVkxQkREcDRJcGozSEtkdloxeXlqSmtzMWRma1JT?=
 =?utf-8?B?ODBISmFzczNyQVo2K0VuTjF5NGZvUi9tcmFBNjJIMUhZSTEwaUNDV3duZG5q?=
 =?utf-8?B?SmRYUUdUdlFRVUZnWHpMcHdNV0M4dVR3T0VkcXlEQnhaVWNKMjVXemJUL3cv?=
 =?utf-8?B?d1FSQWc5UlFySVQ5aksrYXd1VUtUUDhaNmZ5WXhvc0drUUh0dlFZQnpCcjhR?=
 =?utf-8?B?azBsZFBibU5qUy9Dc3dXVVc4c0x2TXRkRkEzK0x3NTlEWjBpNkpZVGY3Mm9B?=
 =?utf-8?B?WXNNM0h4RC9wVExnN3R0aFAwZzVjK3V5M0VaWWp6a0xzTE4wUld1MFcwL3lI?=
 =?utf-8?B?bS9GakhWdktXSTJxWWwrU1ZhZ0FaWTFnU1J4T1ZXYVlnWFF1QzlsZlh1NHhR?=
 =?utf-8?B?cDVDNVlWNzhFMzhYOTZGd3M4VGNCdlZtZUNDYlJuSmRITDlSU0FiOHFYcnl5?=
 =?utf-8?B?Vnd4VHMyVDMwV0JDY0x3OTRqNXJ0cTg3RWNxZnJPdVBTRVVvelRDejVWZFNW?=
 =?utf-8?B?VkFrb3RyTmlOT1BXNHF6TjQzV0FGYVlnYVlpWXNlNkJFY0hoenQyckVDOU5K?=
 =?utf-8?B?Ymd5cWdXM1hWRCtQOERLc05hd29rK0RybmJRdDQ5dGlBMCtmdmFjU3VWSVAr?=
 =?utf-8?B?YzdEd0NTWm5KQWJjSHViRTFRKysxb0gyN0h4dTZvZFVha0xsMXFCbTVtVEN0?=
 =?utf-8?B?ZFhqUjlRWjJCU1JUSHY0TVVvZXdVQUlkMXdPS3d3aDBzR3E2UGtVN1NxcG5J?=
 =?utf-8?B?M2tFS29STWREdzFSaitZRzhsWXdPYXZUd01seXBPOHFRR1lnL3gxdmUxWmgv?=
 =?utf-8?B?L2NueHFlVnVoYm0rTitjQVUyeEtyUk5qaUtsSThyM2VDTzVGdTBJVjFZUkxZ?=
 =?utf-8?B?Q3M5Qk5Fb1JNRzFOYXY3eTRHL2lUNkthZERTTWFwU2VHcG9Zc1ZqSmxuYXBL?=
 =?utf-8?B?QlBHbm03QTNaTnJhcndMeUFpWTlJZ2hJMjNxWjVkRjRabytNdlVwV0ViMFdj?=
 =?utf-8?B?aW5yRVBGdWMrZ3lyTjdBdXAyNUY1dWplMlFmQUExMnlDN2tPQncyanJrdHNC?=
 =?utf-8?B?eEFLVkxha2d5NnRjbVlhMDM0QkRBdEc3SVg3ZUtzZG9ZNmVLVnVWWnh2K09y?=
 =?utf-8?B?eFpEWkRBWlFobmFlNXdrNVl1N3RpRGtvbG9GZThxMmhYMkpSZ3Z0TXI5M0Ez?=
 =?utf-8?B?VHNaVFFQaEQ5MkI2RFQ3NHFoRlQ3d0ExQnpranNqT2hlaUNDNG9RR0pmV1ky?=
 =?utf-8?B?S2l4VXFlbldRNnM5K2dZeGJpYmRXR1h5SThaVENkTXlMVDBjRjEwUGlBSTl3?=
 =?utf-8?B?TVloOTdkaFZTREhEbVNzeUxDT25kWEZ6d1lNR1NvOHVNRytUZzNTUEJXTzJ1?=
 =?utf-8?B?WlI3dTg2c3pHdjFHaDdXTUMwRzdzd1FJMXV0clZRNXpweFNHbnBzQ0M1KzhD?=
 =?utf-8?B?cDRCVHZxRjJLSWZDR1RGeXE4UE5FenV0Q1hlTEZyUzRWWkhHYlhNd3BtVHpI?=
 =?utf-8?B?VzA5WFU1Z1Q4cTlqZk9jOVdqeUphUEI3a2ZUcldYWEhRTUJ5NnVqZ241WFM1?=
 =?utf-8?B?OUR4UXArRCtKTFdRUk1BU3Y2N1J6dXN2THk1RG1nZk5jQ21NU2pCUlhaK2tT?=
 =?utf-8?B?U0Eyc1VEMDlXTVNqK0FkakJHVEFoYmxMSkQ4ZThDT3YzUWJYODJKSnoxenNK?=
 =?utf-8?B?aUg0OUJYUWNQSmdpakpZMHl1SGU1TktJUFcvRjJwZUJFSzhTemE3bDQ0T0JJ?=
 =?utf-8?B?T3NPSFh4RlV5bTRZQ2M4L3RaRTFjb1ViTnVrRWhFZFZ1M1FlVThJak1ORW1N?=
 =?utf-8?B?NFRTSFAwZkZRRjJ3MktHaUNhS1pOMkZML2dTcmdTeFQwTVFkejB5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ad54d7-6d19-47e7-a32f-08de852982b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:04:06.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmQDc6pwRgWyxK9/tHfDjYMIGwgqMg3WcakBSnDBnloWrq5biIaunDU4labm8crMnGJ1RdqOYlEC4Abepogt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

On 3/18/2026 2:42 PM, Paul E. McKenney wrote:
> On Wed, Mar 18, 2026 at 08:51:16AM -0700, Boqun Feng wrote:
>> On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
>> [..]
>>>>>> way that vanilla RCU's call_rcu_core() function takes an early exit if
>>>>>> interrupts are disabled.  Of course, vanilla RCU can rely on things like
>>>>>> the scheduling-clock interrupt to start any needed grace periods [1],
>>>>>> but SRCU will instead need to manually defer this work, perhaps using
>>>>>> workqueues or IRQ work.
>>>>>>
>>>>>> In addition, rcutorture needs to be upgraded to sometimes invoke
>>>>>> ->call() with the scheduler pi lock held, but this change is not fixing
>>>>>> a regression, so could be deferred.  (There is already code in rcutorture
>>>>>> that invokes the readers while holding a scheduler pi lock.)
>>>>>>
>>>>>> Given that RCU for this week through the end of March belongs to you guys,
>>>>>> if one of you can get this done by end of day Thursday, London time,
>>>>>> very good!  Otherwise, I can put something together.
>>>>>>
>>>>>> Please let me know!
>>>>>
>>>>> Given that the current locking does allow it and lockdep should have
>>>>> complained, I am curious if we could rule that out ;)
>>>
>>> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
>>> nesting right. The wakeup problem remains, right?
>>> But looking at the code, there is just srcu_funnel_gp_start(). If its
>>> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
>>> then there will be always a timer and never a direct wake up of the
>>> worker. Wouldn't that work?
>>
>> Late to the party, so just make sure I understand the problem. The
>> problem is the wakeup in call_srcu() when it's called with scheduler
>> lock held, right? If so I think the current code works as what you
>> already explain, we defer the wakeup into a workqueue.
>
> The issue is that call_rcu_tasks() (which is call_srcu() now) is
> also invoked with a scheduler pi/rq lock held, which results in a
> deadlock cycle.  So the srcu_gp_start_if_needed() function's call to
> raw_spin_lock_irqsave_sdp_contention() must be deferred to the workqueue
> handler, not just the wake-up.  And that in turn means that the callback
> point also needs to be passed to this handler.
>
> See this email thread:
>
> https://lore.kernel.org/all/CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com/
>
>> (but Paul, we are not talking about calling call_srcu(), that requires
>> some more work to get it work)
>
> Agreed, splitting srcu_gp_start_if_needed() and using a workqueue if
> interrupts were already disabled on entry.  Otherwise, directly invoking
> the split-out portion of srcu_gp_start_if_needed().
>
> But we might be talking past each other.
>

Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
different issue, from the NMI issue? It is more of an issue of calling
call_srcu  API with scheduler locks held.

Something like below I think:

  CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
  ----------------------------         ------------------------------------
  [1] holds  &rq->__lock
                                        [2]
                                        -> call_srcu
                                        -> srcu_gp_start_if_needed
                                        -> srcu_funnel_gp_start
                                        -> spin_lock_irqsave_ssp_content...
					  -> holds srcu locks

  [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
                                                 -> queue_delayed_work
          -> call_srcu()                         -> __queue_work()
          -> srcu_gp_start_if_needed()           -> wake_up_worker()
          -> srcu_funnel_gp_start()              -> try_to_wake_up()
          -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
          -> WANTS srcu locks

If I understand this, this looks like an issue that can happen independent
of the conversion of the spin locks.

thanks,

-- 
Joel Fernandes
