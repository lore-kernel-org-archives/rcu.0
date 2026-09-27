Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020138.outbound.protection.outlook.com [52.101.189.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA83290B7;
	Sun, 27 Sep 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530620; cv=fail; b=JrXaCCqe/HIJvVof+hFMeP/j8h4ghjg6pdn7Wi+yM0WcHgEx0huE1wB+mOfR/wtgz8BSqckCqadeBALFm4SSrwVmuOCkkRPr+zp3104TBnxsV+zjTmDQ5q/g1JaJ5I2zHNkDvLXh+bCoYwS8paDeDCutR2mI4WmKRXQMWrDBUfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530620; c=relaxed/simple;
	bh=QQ0MAiu+jgP14JE9mhKf7NDqiOo8ZTpmpsA/1sVe3Jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfciItvFZr8zgzGn140Y6Svww+g87d/hsAOxZKop4Dgf5708LHwGF5iTB3Vapy9Ce8u9rrHavWVW0X1/QaJeV45TEVXY2UhTDhEf+rIS/jMjSLVIShcvPPIMckc4Lh7Wxv6mwBuC7Fk5Bn5hyucPVA2VzUicOwcDuiQ41du/Luk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JSBvfxqY; arc=fail smtp.client-ip=52.101.189.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JSBvfxqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn84pPd4WYizAKXs5saAJAD4wjmuWLT2iVk9ws2squI0Zh//I17vhxq9vADWXQI0AGvqIWcF5smSxIc7F7kDFR/Jqm7xTTqIQTrN3fYJKgW0Pw3Ep81HzbVsMLEZoeYkKk3nDssGk4LnEOb9T6PsfujEUqwaPcG7s214n8ad9ttvz3cKkqxXwZjklYg12HOGbmkJrSO4JoyudFlmsEU5DM3VcOBEWnSiZnb8CLsGiOM20BDPUq/z4D/azrKxH46iXR926VFQXfKX9WLuq9Zu1Kt75PYuIBuf9988QAAZEAAJNUtcaQAVHVRuYyH3LoV9vrJRbGXIZ5HBW9IVAE7qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kedXLENgEvlN/J+9rIEYBIuPQ8Ieu1VnMditzOF5J6o=;
 b=ESnpG/nbuskdHSdPME7hQr+Soid65UqGOouF33I6cY/XdTNoN3euJ7Mup3EJ9U2va0R8tevw+45szLvfq1NQfLCOL/DwBCqR4ZyZHTlkUQyiX1MF4ogGqRrSJ5CKitgci2Lii8rk4XLkyJ6G8kKOR4Yo9pTEQYdkyGQmKAMe2lA5e/GMjjQ/pdAhirs98D+H/v+Pt9NOjr9NDwiEmj0ftyy9oazw58TACPWH1WaDa+BHCD3zutn6IC3PukWn0v5TcCy/pkzPGe7BXlnq7p576NQ0/XvkRk9ehlr31jMGgpxp/MK7uySkI3VLmWFWCv1CzFIbY8gNhmGFi5IUMzvckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kedXLENgEvlN/J+9rIEYBIuPQ8Ieu1VnMditzOF5J6o=;
 b=JSBvfxqYDxA9HtHDyUxuockJLaUvypWxIcGxyaUBklNd3Cx/EmngNmPyXhqKAk7bfNmJUI1NtQ7lCXm0eREVWJRv/JBXXo8/pUuMNInvo5+CYr73JAPREilxRRbawzPei8TqPD8XR7vHK7VVfR+o0VEHHIY2/NtOrkRa/GxdtIlZINz5y8QzS3ciTwR5G++loTbcTxqAjSOyLCkjyXUvvo804Z9PM9ORD/HxVGmvcKjylrE1ZgYHz09TEpR9PPBFZ7XfWQXZF16VUXITgAASiv8E3Fun1+KtP+9okm8qsW3yiUvUz7xYfe9y0Jy49XSF7mTRau+V51nXXrUYSuEzXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PPF7200E28CA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::54a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 17:36:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 17:36:55 +0000
Message-ID: <e26f28e9-e83c-4b39-85f5-928a8097019f@efficios.com>
Date: Sun, 27 Sep 2026 13:36:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev, Lian Wang <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <arlROwtdFs3YyUt_@MacBook-0RXW5>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <arlROwtdFs3YyUt_@MacBook-0RXW5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PPF7200E28CA:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b789eb-6075-4d78-e494-08df1cbdecab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	lxoM4iCjEGkWJ1ntSKlmpgC85BqPCJVyG6uYMG4rXKoseQZ6KtmYF5OzR+hdkRe9Rx5hyEyK71splSa43Dy1VMD8Q13QQYVsa32l6hHHhQPXPCFBhmNChoaVE5eov+2wxbtNtrxqgm2mV/gf6TOt9b4s/prMGkdSjKY7AsXic2nHQinwb/bDAokXqIKtI+8mNlVrpVVa5sgwQYoFK64wKCVlBwEJj96tnJ0fz6WvB7B2oxr+8nUlrmq1b/T8A3TmFuWsPFzA8Bu5xfP46GTgVKViOzbnyhh4Mgfb32xavVY/MhNh4OBZr+RJ6ilfd1XzESVXF1c1VVpe20MezKrd0hxOntlvglStiLhUGrxlc/nd9GmFOzlksUB8EXThgjXY+PWgNBOh8xd5tBn0RGJsbQwED/vtF8s/0I4rbf2dbJwQb7hthGj00J6fvY0PojBfl4FbnXyVvV4cGTEtojDK1uHW0C6yPXwoHh/nrDAuWuMAJy9fMwDSbyA/sNfEipyFtxQU68mHhBLKwcxWrrTJgyWpyAHAa0W64b00dBO8ahyekIrMB5Cv7xrtQPxTHY8d16M8x7IDrIW7OT6eW1Ma1RdEWFEfz/hr/llPatz0/i4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhLNHNUWEQxdUNpTzlmSE9IcW0rd1hQMWFDTkxpZ1d6WHduUXppR1ptSG5Q?=
 =?utf-8?B?Z0pRb0ZiS3lzY2pZQkxPTTArb3Vrd3Vjb3VXSkpNR2xIRFZxSjhYYWdUNGt5?=
 =?utf-8?B?ZjJxOU5zaVZvaStYRU9kU0ZwSzgwV2dOQ3oxR3dqMEJtTWdiWlExUDdBNWw3?=
 =?utf-8?B?S01DV1hGSUViT3g2NkI5b29yRUQwYlZrcUNQSGpjNitSTGt1dUZJVmRGUEZN?=
 =?utf-8?B?K1Y0MnV1QVIzRTV6NVhKcllwd1d3anh0ajBYR1l2d0ZqV0dJTlVtNUdVbWll?=
 =?utf-8?B?OXR6MDYrMTAwdWZZbHFuWXhvYXU0SFZRNDZueWFaREdtZnBEQzRzYW94bC83?=
 =?utf-8?B?L1U1VDJHdWVXTFFLdHFMV1hGQ2JrU09sNm5lRHZMa2llRC9CY2pydzNlbTE1?=
 =?utf-8?B?Y0Q5di91R0RyUUp1REdaTVJzWU1OTFZVNG5LSndDV1pXTE4yUE9ZYk54aDFN?=
 =?utf-8?B?b3REK1ZWUjUrcC9nZXBmcGJhYUQwMm1qcjRPZkdGMnBBYkd2NVFkamVNRW5E?=
 =?utf-8?B?dytCVmM3NTlIblhCdUF2Qkg5eG8ydmlFdnVWOGNZY3ZCcmhtRFRxTEdLRFkx?=
 =?utf-8?B?akFWKytEWnNzVmVDaFFGKzR1ZTFFdCtLK1JCbHlDQk42SVhwRmVtTHNhWmhT?=
 =?utf-8?B?SUcycEVCRDJ4dEJudXdUbDRTSjFHNlk4dTg5SXNoREV6SDFBUjM4eE1QUmhQ?=
 =?utf-8?B?amtPSjRGR1F5ekRLSWIzRHM2ai9KRGN6VVVZVitzcXpqNUw4dWZoTmZXOS9I?=
 =?utf-8?B?MnJ1cHg3cDI1WldibjlPSTVpRlJ0bHQ5YnpnTi9adFNaNmNvdExyRXRHcFVu?=
 =?utf-8?B?MTk3OGdJMW16QjFRVktNM3hpNFZabHVnaSs4N2NFVjFqanY5ZmlqV0YrTlNq?=
 =?utf-8?B?aGFqSW9wWXpKSEs3MWU4MTczdGpYRHh1Z0lnckk0bkR4TUJMdXR1MEZablht?=
 =?utf-8?B?TjdBNER1OXgyRnJGMFJRSUFzeVc2OEVBd3pmVFdHa1hnbDVPaDJoUC9rV0pi?=
 =?utf-8?B?dHpaR3pqd0VORU8yZzRKM0x1VlEwMnBqeTZsWVNtWDBuaVFoQkNxOUJjWU11?=
 =?utf-8?B?NTJEeUQ2VUV6ZE1CVXViVFZvY1FqcDhJeWVIUVFhSGpqTEVxTi9hTG9XWi9t?=
 =?utf-8?B?UGtaU1BQWDdUK29IQXJCbVd6OFFjUHVIVnNNZTljV3I0NjlyYWRtVEU1OG9h?=
 =?utf-8?B?SlkrRTZqTnFaZmR2VFplNDdnbGtsL1dZYTJhOEFwbng3K3lrZUs0RnBrZGp6?=
 =?utf-8?B?c2tkMURyU0NwMVQ2cHBJdFRXZXIzQllNbksvZHZnSVBnKzQ4RjhTL0NNclBa?=
 =?utf-8?B?VlRYTk1NekxiNTc1OHVFdXBCQmgwRmlGODlLU1cydHN5VkdrUCtVY0lqWkZJ?=
 =?utf-8?B?Wkx0SlhlNXh3TVlGeUswLzVVYkhQb25nS0ErRTRkV2llcFVxd3AyWlZyK2Vv?=
 =?utf-8?B?Y3dLZG43SDJMQzNZL0RUOFI3Y2ZaaDBJMnVoeXZjcVp3WFhQUHBlV2JSNnJ2?=
 =?utf-8?B?RCsxdnQwd1ZZZU1qelBJNjl4Ukx1Zlk3ek1pZG5qMGcyZU13SXNJUnpZOHBY?=
 =?utf-8?B?ZHEvdTVOWDZGYU0yempXaUV3WFFVaDdtUTJHbFJVRmJSTlQyRjEzaGxhMW5Z?=
 =?utf-8?B?YTc1MTk4Q21OT0c4MElRZWsyVU9Td1Q4TXpUeDZQUXJrNm1zaTNKeHEwQVJp?=
 =?utf-8?B?cEl5SDdkeGNCQis4ZW9STUxyVWYzZ1RIK01hU2FOd3Q0cHZINGxPRkcxMWNt?=
 =?utf-8?B?Zk91bUs2SFJxQVo0aDdFNHF6N3N6MjN1THJ0eWRvM0ZKZUNleGhqWUdqRTNn?=
 =?utf-8?B?TWIxVmduMUhDN1BNQXNiMzh4ZEdUd0VmVHdiUG5YL0VnT3B4WFA3MkZ1bXZY?=
 =?utf-8?B?aXRIc29PRllNbnRJRzFRejhvSnRqdEN2V0ttbks0QnROTWNZL1RRVjJaZkYv?=
 =?utf-8?B?bU9MdWtDczN4LzU1cG9lYVpBVHR2TmFVbldXWG9HZzEvam1NeCttZ1pQekZu?=
 =?utf-8?B?NTdDK2lRajBRQmg4QXVDZGZPS09Bdzc4RktCeTdSL0RZZmxZVjVBcm5GQks5?=
 =?utf-8?B?WW1jR1Q4emNQOGxOYmtKdGd6WE1kT1RuMzN5WlFtcmFaRlorL2dDZUVwQmg3?=
 =?utf-8?B?YUxJSFErV3UweUNyMG9yTUpLZGNCMGlMY25OREdEWkJOOTNOOWpNZHJlS3dE?=
 =?utf-8?B?aDFSazhYZzNzTExIbE50SWlLUjhkNE1iNU95OCtMZldLVm9OV0NXSFRud2RM?=
 =?utf-8?B?cFg5SnlzUkx2b1gzYnp1ODJjbkM1eTRaVFVveXlGNzdwR3Mvai9GaUl4MzdZ?=
 =?utf-8?B?cW1UK1FoY0h6MXUvVGxUZ3VRTE1xNmJycTVDeTJwUHF2VFVVNVQ3L2NzMWh3?=
 =?utf-8?Q?sm8MBN8jSeB637lDoDt6Zjz8b1Nr7eVrk32RahqEvfMCj?=
X-MS-Exchange-AntiSpam-MessageData-1: Jdrb4oOxuoyshX80gF6OYEcBKyT7HVT4BCs=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b789eb-6075-4d78-e494-08df1cbdecab
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 17:36:55.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyhwZmg0Gntd5L+QadBPGpKufkK/x8Fdr3Y3/zUKtdxoiAu2wOubeMx4eDEBzfxYhFEJCHGLxNy7Q0CspBnHHavtuOoyWfpSYGFsWA5wMqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF7200E28CA

On 2026-09-27 13:24, Boqun Feng wrote:
> On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
> [...]
>>>> @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>>>>    	for_each_possible_cpu(cpu) {
>>>>    		/*
>>>>    		 * Scan CPU slots.
>>>> -		 * Forward progress against recurring wildcards is guaranteed
>>>> -		 * by scanning for one wildcard while new elements use the
>>>> -		 * other wildcard value (1UL vs 2UL).
>>>>    		 * Forward progress against recurring single hazard pointer
>>>>    		 * values is guaranteed by the fact that a hazard pointer
>>>>    		 * is not reclaimed nor reused until the scan for that hazard
>>>>    		 * pointer completes, which prevents a steady flow of readers
>>>>    		 * to acquire that same hazard pointer value.
>>>
>>> (Not a comment to this patch, but I think it's worth bringing up)
>>>
>>> I want to point out this is not true for the lockdep use case, because
>>> the we need to protect a hash list deletion there, and we use the
>>> address of the hash bucket there. It's proven fine in practice because
>>> the readers are rare (we only call the reader is_dynamic_key() in
>>> register_lock_class(), that is every time you have a new lock class to
>>> register).
>>>
>>> Maybe what we want to say here is that "if the users guarantee no steady
>>> flow of the same hazard pointer value, we guarantee forward progress".
>>> Thoughts?
>>
>> AFAIU, your approach to protect lockdep linked lists is to use the
>> address of the hash bucket to protect the traversal. As this address is
>> invariant (global array item address), that address should be fine
>> to fulfill hazptr requirements, but it has downsides: rather than
>> protecting the specific nodes being retired, the whole hash chain is
>> protected. This means that, as you point out, many readers retiring
>> nodes from a given bucket (except the first node) could end up holding a
>> continuous stream of hazptr for a given hazptr value, preventing
>> progress of hazptr synchronize.
>>
>> It's also coarser: per-bucket rather than per-node.
>>
>> Am I missing something here ?
>>
> 
> No, you got it right, but as I said, we can use it in lockdep since the
> readers are relatively rare, so not an issue here.
> 
>> One honest question: is this pattern something we expect to
>> see often ? If so, then we may want to introduce a notion of
> 
> I honestly don't know. But in my opinion, we'd better focus on finding
> more typical usage of hazptr (i.e. protecting actual object). So ...
> 
>> hazptr protection "period" flip (similar to some RCU implementations),
>> where we tag the low bit of the slot pointer (0 vs 1), and alternate
>> between the two periods in synchronize. This would prevent a steady-flow
>> of same-value readers from preventing synchronize forward progress.
>>
>> Thoughts ?
>>
> 
> ... I will say let's add it only if we have more users of this pattern.
> 

I am concerned about this because many uses of RCU in the Linux
kernel protects linked list traversals. Turning a RCU-protected list
traversal into a hazptr protected traversal is not as simple as
acquiring each hazptr hand in hand.

Your own use-case for lockdep is indeed a linked list traversal,
and you need to use a work-around: protect the address of the
hash bucket head.

I'm just wondering if this work-around will end up being the
"blessed" way for protecting linked list traversals with hazptr,
or whether we should consider alternatives ?

This ties into finding additional usage for hazptr, because linked
lists are so prevalent in the kernel.

Thanks,

Mathieu

> Regards,
> Boqun
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> The rest looks good to me.
>>>
>>> Regards,
>>> Boqun
>>>
>>
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
