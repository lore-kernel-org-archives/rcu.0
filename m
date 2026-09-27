Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020073.outbound.protection.outlook.com [52.101.191.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEE2D3733;
	Sun, 27 Sep 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529347; cv=fail; b=IvjbAsN0riR+ZA5QbcfxJT4aO3dBwNvQJG+NocPBkRVVE4Q94jijRGy+siWIDDSTPvXvfkrB9+MNsyDsqxuD3e8LcNWkVPsR2h5IXzeUs7Qznptz2ZV1i5MWmdVK9BMT/GuHSgV7wFLmfcbriwdu9NeQlGPeFzV6J8Bch+gwTpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529347; c=relaxed/simple;
	bh=s4g2eRyk5WKVs4pQTRJSK3pyMdBGAN3EX9jEXcZiB7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCXcQlml58LxABcKz9UiGkHHTlQRA8L0RfX9bGs56eIFPuNKZLjhXBazuMqaXI7sSzMY12hNd93alwZq3XkKhh5v+cLIETyCClwhN38ZIDRYeozXI1nSbCWyeKVnq9qEBAhdU27WBqXXi7kTugDrW+25OqbC7YKF33Sh0wsdUUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=R4XmqfS+; arc=fail smtp.client-ip=52.101.191.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="R4XmqfS+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQEgbH1Q6pisPzSQnvt1SoCDb4vGudxC6SGVz/nFW5q6PCNtHhXUlUMH88muGlLiQhxb5YAB3xkQaK8XT1Fziav49rZit71So1r8kq8e4GdhpOZQ4nSWJsF6cSVCZLH7wYxTEDLqMYAkMZROwb90s2Ks87nyqeoPLf7Jl1GQzLTdjexeimhT2nf6oC+6hwAS67zSUXQbYKTAFXnzRriRGzVRFmbHo9CqnNpun9GuMHsJw7ms5wYQh8yOfFo/oNW9KlV0JeCut2R8OT7aVL3JndWUQcE1W7RlYpodigfifJ0JoeR5648YU5s+8KUcTYgmZSQzVQHHTrDslmrz80Kh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQCMS9G51pXbwP5DKZRcEjsR/beVeaBWoIjD4yWxd9U=;
 b=Hu7faG0YREm2GBmQUItM3hiHlxb1AizCCgN9ZWmMRWvmAVJEz2jazPfu5Ultj7cA6bkVFXqyJ7jlOEf+/3QRqBelmgKu9mxzub3DGzOY/6MXRlSzPM3T01hnnL5uyzEm1ameG3D2woXC+dXA7/hD9y8MksAK14Kt7vyPyKjFXirG6Cofq0YxA8x0zueegwz8et6y16dM5sT+kmVjiAa5X+pe93YZjnbKRA1uotUwkVVfF7TE0ZI+aA4pcDsCTgA6vKZjT3yEZDFpF8gMH5AL48x7nLjJlHly7nrpQk1WYAvblZp200S8onMPXaK5SZ+J5368ZTGFBJHo29UKrCOIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQCMS9G51pXbwP5DKZRcEjsR/beVeaBWoIjD4yWxd9U=;
 b=R4XmqfS+yCpsqOs/rzddPqkxrWtJRPtfvtqIeYUtXpIufOSN6WEgqJT4gwsVOasYi8+Y4OGzkJ5Jly1kCkwnWAUMFu2ZjdX7Wp+RoZ4fMgCGn0NBuPTUc+4LNsG+O17DWrQ4Vl9rKIv9tKQQ9/O5Cw6njTVY5ueqWw8heR/1xCcfLxhRyx/r4ikGoEg/JaI3yfjkfSx82y1t3sTUq/16nb7otNXAXceNcnGe0xwc2XIoEjy7Uy7c0kwOWzqt/+AQsBTHLNDNbwW/n9SSqmAaHg5sIdCciBxB44tXdGEITfzB2xOl1X3G0RsuikQ/v3zIZ4JAmp3c8M846ZlspMBwow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB8953.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 17:15:40 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 17:15:40 +0000
Message-ID: <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
Date: Sun, 27 Sep 2026 13:15:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <arlHFVT5EzcX4d1-@MacBook-0RXW5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ae8471-96ff-4454-1cb5-08df1cbaf4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|366016|10067099003|3023799007|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8/RaWk5ZOrWSfFVaixJ4wOvFbD29qNK0mAjhUkkaaeZ5blp388RelSB424/mBppwHDEXPHmV05SpwV8VowF+O6IRlLaAuXYY5aILofcHRgNEjVHG9nfO6jiNAmge1fGkjVlwcUzNdeI+q3/ThAjO89+2xHCEKKIi8GpfbIsvTC9MGYk5CGXzLynLuCzeVUqNx24/oUqKMH87GlNflFv85a1y170PI2itZRgAKW9sspySvoK0YAe9jzmhyU+0vFuzGsVe1SMfMnFWZEb2i8oVmgawjDsEq1mkMoyV0ZIZBRAcccbVpEurw0k+qgXLD1WOVdLu7sCQkaw4hmEaT11BU3qwAJQG8/lXkdBQdu4ZdJnhYohLwF1BkrABN76R6qnZOoOE2dNtchXbKpSYdm14vTyNQGT51IChYXXItxR/ASXaQImwUYhDH/tSID7pZKba08H7zd8QfsNiRbR2r7JapmxScMTAecD4OwjDzTLQ0i8/2D8qOcZd7dLFEmT0T7tQKUps52LLnaoSq558feqo9BC0O/Gx0Ia4k/+vl6JXsk3urqWGQdm2dJ3F8ru29eJiqPgBUOKjq6SSIeTVh0l+sHWlA7kWiZ1dE9EJRX31Fz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXk1Vk44bzRaa2JqQ3Q2ZXVuZ2Q4K2Q0UVBMQnJ0NE1rcEIvUCtBeTErQzVi?=
 =?utf-8?B?UXpYbjJUTkhBY3doMzA0YnFEdm5BMkRXTE0wNzNFVXgrbXVRTElXVFhOblNV?=
 =?utf-8?B?cS9Bc0czeEw1emdtcnJhMUZGUXpqMDhzMGZVVUxyTkVtb3VLNnIvWUVyYU9z?=
 =?utf-8?B?Ni9xVDJUQ0h2SjhaQmFVUjlzc1lZc3drdEU3SWs4c2RtWmJwcVc0SzRNVFhZ?=
 =?utf-8?B?bEJ2S2paY1djRkhQZWtOUDhPdmQ5dHp5UTVabG0wOG1OTU1KajZpZDgyVnFm?=
 =?utf-8?B?RnhaWlQvTHl2SXMxc2gwTGlnZG9KSHhtVmcyMXNPVzY0ZU9Kb1ZiaWlTQXpN?=
 =?utf-8?B?RGt0MWhSZTVzR2tMM2NCRWQweWZrNFd2MG9yUFAxTHNxcXg2MHgxZ29tWklW?=
 =?utf-8?B?elJmYUliNmVJN2htZmExU0JvRXdtQkwzVFRCRTFiMnl5Z3h4U2UwQUNNMGNw?=
 =?utf-8?B?V0sybEVCWWIwMlpyTitybXF1NVMwbFlyeldIR1ZhSUp5RjVIa1Y5YmxuWW9C?=
 =?utf-8?B?aWpOU1AzK01VbjNFbzhveWN4WGZYeUhsVjN5WlVNL3EzcUw3ZERUQXZMamxF?=
 =?utf-8?B?U0hEM3owY3ZGRUlNTlNDRXBadUJPb0J3L3VBZTU5bkwxcDhGY1pVRk1yc2VC?=
 =?utf-8?B?MUt5R3huakhpODJlNW9JRlUzVWpVcE1hZE8vTVYzazhLN1RsRzZmS1l4UWpQ?=
 =?utf-8?B?ZEdHc0NOUGRrNU9rd2NuSWNXZERaQmkxKzVVUzMwa3QwOGUvWEJnY3MrK1k1?=
 =?utf-8?B?dWRmNnNOU0pHS3NWUkRJWUg3bnVVLzJKL01JWEdFRlZQQUN0cEVRejRnTnRK?=
 =?utf-8?B?elE1RWswV1RQZXlrdEM2dWdkdGlteXNycEpFWmxEc3V1WXVLdk0vTFd6a3F6?=
 =?utf-8?B?VXFKMko3VXdQb2dBbkRYdTBKTWQ2NjJvSk9NTEpuUENSU0lmeGpPY0dCVXQx?=
 =?utf-8?B?Z0NOeVVXenZvamlTMkRpUkJPMEdLbHExcEV5TmtvMm1WZjkrOEVOZFl6LzFX?=
 =?utf-8?B?RVFHNXBHdUxIeWRQMGRHTnR4ZzFRekp6ckFWMVZRNEpmdlFUczF2eThyd0px?=
 =?utf-8?B?NE4xNlBUWnBheEJPcS93ZlRSYXhleHBLcTBuRndlTE9pbEF4aXpwcG0wRmR5?=
 =?utf-8?B?TUMvNnZYaUZydkxFM3ZyWENjWk1USWlsUXhsZlJlMlZsVW1wdHlmZDdkYjJx?=
 =?utf-8?B?Yi8zK2ZlRi9lN1c2NVN6UktsUWU1Ylhvc2pEcnQ3YS9sbENEMWVHQmlpTmpK?=
 =?utf-8?B?Qjd3cmhSMW92WVh3WGs4aTkwbEJxMFU0TXdXTW03V3VTbDNRQmt6aUdUSmxq?=
 =?utf-8?B?VG5abUVNSlpuTnpSS1pCZWVIS3pmWmo4OEN1Wlp6MFAwL3ZDOEhXUE1XWmxU?=
 =?utf-8?B?azZ2dXFUWkFzOUdRQ2llcU5CRDVKeGh5S0xxblZ6TGwvcjFlcWFwcWFvcHl1?=
 =?utf-8?B?eEFncmlLdk5yUWtURUlMamJpNTZnc3Q2YnUyck1Jb29LTzExQ3BYZ1ptOEk2?=
 =?utf-8?B?c2JRc0ZQWW5qbWFzUW1iS2F3VmE5cXV6S0xsWUVZTStnUHpXVjIxS2NPUitJ?=
 =?utf-8?B?YzNnV1pyQkdsT2x4clRNaDN6M2lvRG16TGFPTjJKYUFMcDhYeUs4Q1lqUTMw?=
 =?utf-8?B?K0Y2VG9QUzN0a2NwSFNLdE91RkdOS3pDdUhrZEZzV3ZjUm55VHB2am5uR2tH?=
 =?utf-8?B?YnVnemtKdUxVT0NzQk1KdkQ4QkVEQ0o3QWVkck0zeUZ4aWlnRm5FZ2NzSVFO?=
 =?utf-8?B?Q1lRM0tNZVFLaUh5aGUreDZDRVcrOHRhOGFiWVhuajNFbzZaaWErdHN5azI1?=
 =?utf-8?B?YnpxRnltOWFYOEczSHFtTzBiTXpaajROYTNiS1JZMWhRUGlyN0U2UEJSa2F1?=
 =?utf-8?B?UHVKZlpWb0gyQmhzQ0NiVkY5TGwrWXIvVmlUaTF2SjBzdWlPbDgyRmNhcTVs?=
 =?utf-8?B?TGV4b2Z2TjZ5WjFrMDlrK0pkSHNENzlack9aa1lEeHNzMUdSRVppdWRXNUZY?=
 =?utf-8?B?ZFg5NjAzZVoyWXk1Ni9XMm9qc1l0b2IrYTJlU2JCUEd4eE9mQTljVkVGL3VP?=
 =?utf-8?B?Tk16Z0xqdEpyRDlobHAzaHhkM2Nhb05WNDFPZDVXdmNzaS95ajlMS1Uzcmg3?=
 =?utf-8?B?em84T0ZjMVNVa20yeGdJdVBsMDFBRXpXVmdyUnp6NmkraGh1QUV0U1M1SExk?=
 =?utf-8?B?Tk8rVVlRZ29UcGdpNHYvRmJxZlh2UFUxZGt1b3Y0bEVOdlVuZkk2dTc1SUFa?=
 =?utf-8?B?TmhUZmIwQVNneUFET05qU3Bsd3ovMXZBTks1b1k4REFjOFpSSnZaQ25NdmVU?=
 =?utf-8?B?QU9WWEhPR0ZmRW8rS3NZTTBqTzN4V1A3eFRUSktvWTZHMFVTK2R4NlNDVGR5?=
 =?utf-8?Q?t4h79n0uU4ws4jZbjVhutjg9o3lxfx7Df2K4R1nqAsrzz?=
X-MS-Exchange-AntiSpam-MessageData-1: JXciSJNs4Tq91ZhG0tuxLMtz3CDU/C1+AgI=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ae8471-96ff-4454-1cb5-08df1cbaf4b2
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 17:15:40.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L15JJt6VIo9CwCDw6w0/YyownxvYquWdJHdsM+QwK4XH8dNoxv8tSBaH+vpu8xMFZ5Rby3wVNwkpugT3hGdjDZh0R92DDKRpaGYUNJwHovw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8953

On 2026-09-27 12:40, Boqun Feng wrote:
> On Sun, Sep 27, 2026 at 11:51:31AM -0400, Mathieu Desnoyers wrote:
>> Introduce a "try acquire" hazard pointer fast path, which performs an
>> early load of the address to store it into the hazard pointer slot, and
>> then re-loads that address after a barrier to check whether it has
>> changed meanwhile.
>>
>> On comparison failure, rather than re-try, guarantee forward progress by
>> falling back to the __hazptr_acquire slow path on failure.
>>
>> The acquire slow path attempts a try-acquire for any available per-CPU
>> slot. If that fails, it chains the backup slot into the overflow list,
>> therefore guaranteeing forward progress for both hazard pointer
>> read-side and synchronize:
>>
>> - Readers set the wildcard, and then proceed to set the more
>>    specific address to replace the wildcard.
>>
>> - One synchronize alternates between two overflow list periods,
>>    scanning each one while readers are added to the other period,
>>    thus preventing a steady flow of readers from preventing
>>    synchronize forward progress.
>>
>> With this change, the scan on per-CPU slots don't need to expect a
>> wildcard anymore, because none can be produced by readers. Wildcards are
>> only expected within overflow lists.
>>
> 
> Ok, I was missing something, but I think it's better to call it out.
> Wildcards can only exist in the overflow lists when the context is not
> preemptible. In other words, there won't be a preempted readers blocking
> the synchronize_hazptr() with a wilcard in the overflow list.

Exactly ! Wildcard slots only exist during the short time-frame of the
preempt-off read-side code region (few instructions). And with this
patch, this does not even happen very often, because the fast path don't
rely on the wildcards.

> 
> So no more design trade-off question from me :)
> 

Are you sure ? Scrolling down....

>> @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>>   	for_each_possible_cpu(cpu) {
>>   		/*
>>   		 * Scan CPU slots.
>> -		 * Forward progress against recurring wildcards is guaranteed
>> -		 * by scanning for one wildcard while new elements use the
>> -		 * other wildcard value (1UL vs 2UL).
>>   		 * Forward progress against recurring single hazard pointer
>>   		 * values is guaranteed by the fact that a hazard pointer
>>   		 * is not reclaimed nor reused until the scan for that hazard
>>   		 * pointer completes, which prevents a steady flow of readers
>>   		 * to acquire that same hazard pointer value.
> 
> (Not a comment to this patch, but I think it's worth bringing up)
> 
> I want to point out this is not true for the lockdep use case, because
> the we need to protect a hash list deletion there, and we use the
> address of the hash bucket there. It's proven fine in practice because
> the readers are rare (we only call the reader is_dynamic_key() in
> register_lock_class(), that is every time you have a new lock class to
> register).
> 
> Maybe what we want to say here is that "if the users guarantee no steady
> flow of the same hazard pointer value, we guarantee forward progress".
> Thoughts?

AFAIU, your approach to protect lockdep linked lists is to use the
address of the hash bucket to protect the traversal. As this address is 
invariant (global array item address), that address should be fine
to fulfill hazptr requirements, but it has downsides: rather than
protecting the specific nodes being retired, the whole hash chain is
protected. This means that, as you point out, many readers retiring
nodes from a given bucket (except the first node) could end up holding a
continuous stream of hazptr for a given hazptr value, preventing
progress of hazptr synchronize.

It's also coarser: per-bucket rather than per-node.

Am I missing something here ?

One honest question: is this pattern something we expect to
see often ? If so, then we may want to introduce a notion of
hazptr protection "period" flip (similar to some RCU implementations),
where we tag the low bit of the slot pointer (0 vs 1), and alternate
between the two periods in synchronize. This would prevent a steady-flow
of same-value readers from preventing synchronize forward progress.

Thoughts ?

Thanks,

Mathieu

> 
> The rest looks good to me.
> 
> Regards,
> Boqun
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
