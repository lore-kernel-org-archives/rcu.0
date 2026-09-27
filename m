Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021122.outbound.protection.outlook.com [40.107.192.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420D3FBB4E;
	Sun, 27 Sep 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527516; cv=fail; b=EE8dZsAjVqUANyTat+c1UKl9EBQqG/jiReZVUAvwOoRmnkbyzQWrlVrIx6HIjoYM5lVhhYnFiD8uWxn70AR0h8f53Sy5grxsGy0yJLRHgsAUU2yyvzMfNUEqb87aO3CZ7LqrXUwbsP1uysFhh++TCwbgn+1LMtKTUhop11qmO9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527516; c=relaxed/simple;
	bh=BdCNXAaaBr9q0qCPiYkTohFidTpS4/2x3dlywJ/2TyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gyFRSBoqDbKbzvUr/HhccPnSfCyJBYjgYkwO1Wa3o+HwukUH44s3OCLE9bwNuFHwihtAu96Zmaednmv50ZF13UmAjAlld5mErFj4vH+/wi3spj9+v8zzXSX+MawSGqyq6IVoithqTgJsDb1pSG5dmgMPX8SvijVTun3lJgkjwZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Nrr+Cjp0; arc=fail smtp.client-ip=40.107.192.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Nrr+Cjp0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7AefQYVawbcYSmAZkrixqUtZWUXfUNltnHrBCtxlvdxbFQPMPGE4PwAVOyGphvfxZVKxlaK+6DpzZXjitrsEjMDvMLqSv97lwrgMxqb//xJov4rDE58j/iNA4yUg9iAD7NDCFMcpi0iY/OvJYbhNy2iUsevLME+HjPFs/v5i+8Q5Geu9ZFfVvpW/dG8egkQpRCVhnR9CWcuj5e8iVypLYj8Opqk+8DMBlCEqoCxlwBxxtnWSY5i2qaGAOyIu619ZNQ2fso4iw7oAiBdx5+RertZjWnh14w7cv3d0F+VkM3bhhjRRIyMFiRlyEGtzQFUYTOfdMTK4NYUo+bP39sxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhEkA+Rg/De9I1HcaHHlET7CCFuZXSFuOQiS567u+ck=;
 b=F+IgEiNKILTBtDGAQHI30F+BfDwZBP+bG8XfBpYZ48b+xFv4LY+3O7TUsepkzdipd5GwTfGBMexTTPBA9pvvDIa6JuTDNeV5j9L5munUbBTS5llDll5SVneUroXODbMsYlVf+xlgS0qjDPZmuKb4CdqNgsFhY6f/rxSE5qy1shA7is25ZVgDPpcYkUTPF/VeSpGb8y4nH0wpY+817tQjJ59u/1HuPLUHR/tF5AcnJE5opIixa2UBgeNWpKGwzyyEmNjR8mAHH6gb58Atgw2LwK1Ku1R1cmRac878FLqfu7E3/v1Vqs3+bARVSK390fm7T18hM9on/tBoe0RvSdMdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhEkA+Rg/De9I1HcaHHlET7CCFuZXSFuOQiS567u+ck=;
 b=Nrr+Cjp0FIKpLCc8ZA1MdGrGC9rPzgcYV0G+Q58zYGpg3YccHqvnNdg3BoRnd5ed7YWFyVvdyQwsxSN0DoxZyxp5G6LcbiFU0Ndozog8xDyBBDms+m4J/r89EjqZJu2YQEU1gP9m2cM0XE+CuYbQiaOvv+XOyD7fj5m26QqkYAGwM2Kh5Nf64RSOxdwLzF2ptc452Att8uDnkX/ab0LkZ19a5ZbNFS/DtAouLFywDkbbfWPrxH5VgjDz/HkI7ien42bKkcEdc1/DLTe+gxWaQuAoZbsmKgYievgQIwbX9jzuA4DQRUaVPTSPfs+SbINCjZYwQjnoXTRu7DdJe/fL8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB8858.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:c9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 16:45:11 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 16:45:11 +0000
Message-ID: <5169602d-c0ac-4b5b-841c-7cc4a3c54274@efficios.com>
Date: Sun, 27 Sep 2026 12:45:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
To: Bradley Morgan <brads@mainlining.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <EAE9B584-7CEC-46AA-AC8F-A06F11073763@mainlining.org>
 <89cecc9c-f29b-46d1-804d-c87171a445f0@efficios.com>
 <1357947A-5850-4F73-B22E-2AE8B5CAABE2@mainlining.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <1357947A-5850-4F73-B22E-2AE8B5CAABE2@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: c23e16e5-0804-4cbc-b3e1-08df1cb6b2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|366016|10067099003|5023799004|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	03gjzFTyP8CzMUUnCKCQ8kVCXqgK3dJflONU6l6aSFOU5RibMxAJresyFwRg/vIuJYmqLCGuVfi70VeOApVvnor/iALWcGA886v75WTOG4Yj06aaw40/u0zFNM5Dzrgyuau82a507GP7V4ZUHXLGkDU7Egmte/tWe2LHNb3zYGiNBoMXhF4BfwdhCVj86I0MUe3/WY23SRA7q321reeg0P5/TUrcYO++vTqKSVYWD+iDSEe/0+9yhXbotvV0RXUTVNcExBgFtV1iP0TLryMRvLSwKtnnrNs39UldaHxZKXNjXZEkCQfF9vBkEDvW26kq7k2/4xA1L7/CGLt/gUZficRZ+pq2qskU+7TZEm40Oc6M8Gl2SHOnqEzvi4Qm6b1yG4Lw6AwjWu4JzHk1uXsfQc3QQ3U805pvjDi5Vu6BAOuahQQ71ekjmIFB29tdDyn1wOH0fxkcFpsb3rYJRIEHTuKFTOpPz7wi54jAVukIaq/NaOLL7eW1qDrg/n5EVvKE3s/lGwl5mMiSqA6rEcTGMFrMn3sxXJj4abyRWh+w5kRS3zeH/U0QalvXL5N2oDXCDZbaPWkh9V6xjyNr12Fg1BQUf6/HHrH2QW91vBEQsF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGdvRFdOZzZEWVprOG00VDNGK20vV29wTGVER2pXZjlNcFNzVmJDeDR2bktO?=
 =?utf-8?B?amFtTk1ZaGxQN0dEb2Fwd3NoenZWRHJ2Y0lpcXVnUFlvamltRGJPZkRLZWQz?=
 =?utf-8?B?QklrK2NraGNLd0dJQjh3amxNbGdxZm9NWlVsdVB1ZDFhOWZpbnUvNjlra1FF?=
 =?utf-8?B?WGN0NE5vRld1MTdadFpORDExb0x0S1NSZ1Arb3BNZ2R6QXR3bHM0dmRwb3hl?=
 =?utf-8?B?cnp5LytPY2lVczBraTZhenFXSDAzOEVkUGl3ZXZESWo0SS94OFNUaWlPeWVa?=
 =?utf-8?B?NFc3RFNKRmJoZVdRaTBMUitFclBaaVcrN3RuWFpHRlYxTmRyYWtpSFd0OWtG?=
 =?utf-8?B?eit3T01qQmpoZjRkNzUxQS9Tak8xcmp6Und5Ymhvc0hzUit6WnovL0xsZWdV?=
 =?utf-8?B?OWVLbmkwUjJVZnB3ajI4eDRYZGw2U1Y2SlZiNjZOSVBtcnk5elhHWU1zWXJL?=
 =?utf-8?B?VXhSbC9iQlkwSm9YMC9PRlQ0TTZ1K1BHR1dhUVpzYW1Pb2c0VFh2b1VzSXFI?=
 =?utf-8?B?UlYxb3hja2k4TWR4MmtjZWpQTWR2aERUQW45NGlzWTVBOHNRQTlzdUtzVnIz?=
 =?utf-8?B?LzUyd2hVRWlUamRLLzFqMXQ4UWt4aDczV0U2UmZRSFQ3THEzVmRoUThXNlF3?=
 =?utf-8?B?Ykt6eXJzZ2pNVnNMYlF6NEsxYzhlRHk3S2xtREE1UGpXUzlrQVNuRm1aQnRG?=
 =?utf-8?B?N2FKY3o0cE4xZlliaHlobkZpbksvNUtNd0w5d1IvaGZMUXJkR1k1bWx5NWts?=
 =?utf-8?B?WktDRm5MQk9HaDVOcnFPWUtaM3d2cGRFcHBwemxmYWJsWGdOSHVnNUxuR0E2?=
 =?utf-8?B?bXp2alhQUXNFYkZwNm16eE1zOHljL2RKdTNmWFBRbVZnKzRicWxNQnZFNEpR?=
 =?utf-8?B?a2QxN2YrRjZLN090S09LTnBvek5BTzlZWDBqQ0Y2cXdZbkpPTXBCNHdwWjJH?=
 =?utf-8?B?UmdqRGR5RWdvUUU4V0JydnhwUnF2MGt2R3hWWDRxQ0xtcHBxK01Fc2pSQzJi?=
 =?utf-8?B?bVQ3a3pYcWxOdGZIL1VOc1pxNWJxR1ZOS1V4RThkdVpJVTZaa3J4MENjekRI?=
 =?utf-8?B?cVNabW5oMzU5eGJPSFI4bjhwZFJOV3cvQW0yN3cySi8zdktZQU82U1cxTWo2?=
 =?utf-8?B?SytVNXVua1A5STczZnRXcmdPNjRXTWF2QW1GLytuTUdHUW1LUWtWbWIraUt5?=
 =?utf-8?B?RjFPbncwaE5jOVpja1NRK2VoQWw2ejZXc25DNnZ5cEM0VENOb2Uva1h4VzZz?=
 =?utf-8?B?NHIzU3AxSjdrYjhFOG1lL1RIeFo5RmZDSHZ3cWJydlpkeGVZVEI2V1hBbWxB?=
 =?utf-8?B?UWtKb1UwVDBVZzJmQUdjY3pjY2F5OWVub2M4ZC9jVEl0MW5Gd2NBTFZsK1NS?=
 =?utf-8?B?Z2M5RWdMNURQK2haUXpPb294V3l2bFYrNnVBUmhsTHJNSU1XZUpnNTBtcG5u?=
 =?utf-8?B?YXJOU0hiSE53TG1Od3B5Mml0N1d0Y1NkNkkwWlJQanhYTlEzSUtqb1pFbGVL?=
 =?utf-8?B?M3Z1QTVtcmhjQi90NDFtKzJTaDFmQ1FmRjYreVlGcGdvWmRzd1dUUXViWlpN?=
 =?utf-8?B?YkxQdjcxWUpxL09EdjJIZ1BaRDBraXVlOUJOemNZMTRtM0pVT0dEeUJsWGtN?=
 =?utf-8?B?TmNEeTNPNm9yL3dZQkxmem9FV1Awdk1tQUFScjN5ZzF0UVNwYU51TDl6MXhv?=
 =?utf-8?B?S0VyUlU0T05RaC9WeHZIMk0vUDRHQ3R4d2hDNU9kNGpjdWJEaU9TbGRORitQ?=
 =?utf-8?B?Zkd5TFdsdDB6eTAybFVQcS9UU2l6dHA1aVJwSGIvK3drNTB1RTdWS3BIRlpM?=
 =?utf-8?B?MDIxUEZNaElrRzg3bTJJYmpFZDVySDl3dU9VZkJYdGFPTkdldjY3OFhacG96?=
 =?utf-8?B?VWNDdWxuVjBYTDJOaWhaSnpYaWljNW0raUpyYzdETHhlOGZLWG5HY3A2TzF2?=
 =?utf-8?B?ek5GZmtnanFCeGxjN3ZuYVhHUDZway8rYjJaMkpTSjZ0cjQ3Vi9sd0l6T0VU?=
 =?utf-8?B?WEpJVFczV09VY1FhYTdvUlYxWVNkK2docnlsU0lFOFNQOEM5akNic0J6d0I4?=
 =?utf-8?B?SDJpRitrOWI4bXJmaVZKYmxYWnBJS3pKR2wwKzR3NS93RTRiaVVvY2FqWXZj?=
 =?utf-8?B?SG41TUxEYWMrZEZWTWJWdm5UV3VoMUFJWkhjTVB1UVJENzZqY0ZWbDdUK1Ja?=
 =?utf-8?B?U1lhSzRjUldaOE5IY1dvbERzQUxmWExEcGMxSGdKNGwxUGZkMGZGelBsUGQw?=
 =?utf-8?B?Y2RtRXczZ1lUdldUVzdWd2pscTU2ZGNwTXUwV2ViN2VORUhaM0dSMGJOODNL?=
 =?utf-8?B?ZXFjblBFYTNJRnFJL0RiUVhuZE5BVjhzVk5wa0x3OTFleW9Pd205UU5jN3VR?=
 =?utf-8?Q?pdpplqfdyBJPAM1mQ0OtE5WwA9wtRF9uL576b5egBWYHN?=
X-MS-Exchange-AntiSpam-MessageData-1: 8V6fWQgP3dGn83FoBwA4PmvbBjc457LoZBw=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e16e5-0804-4cbc-b3e1-08df1cb6b2a8
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 16:45:11.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYcAFV7Kzk3hnmKbk/YhMD+RAVNkBVOM2kX4p4WLMrFnlraLzrusQLRXu3B1yaUCypwcdPT+INOGUy0OkbJZ13rlt/iHAx89w1K28FFBBr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8858

On 2026-09-27 12:33, Bradley Morgan wrote:
> On 27 September 2026 17:27:33 BST, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> On 2026-09-27 12:07, Bradley Morgan wrote:
>>> On 27 September 2026 16:51:27 BST, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>> Hi Paul,
>>>>
>>>> This series applies on top of "hazptr: handle NULL address in
>>>> hazptr_detach" you have in your rcu dev tree.
>>>>
>>>> This first patch addresses a race identified by Boqun Feng in the
>>>> two-phase wildcard scheme.
>>>>
>>>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>>>> Those were discussed at length in a prior version of hazard pointer
>>>> patches.
>>>>
>>>> Patch 4 introduces a "try acquire" helper to allow the fast path
>>>> to not rely on wildcards, while keeping the wildcard forward
>>>> progress guarantees in the acquire slow path, used on fast path
>>>> failure.
>>>
>>> Hi, here is a hazptr perf test on powerpc
>>>
>>> REAL kill_fasync(), ns per call, best of 3, 100k calls:
>>> (stock = rwlock walk, conv = hazptr walk, same v3 tree ± the conversion)
>>>
>>>     shape          stock    conv     delta
>>>     1 node,  1 walker     59      59     +0.0%   (singleton: identical)
>>>     16 nodes, 1 walker   539     539     +0.0%   (uncontended: identical)
>>>     16 nodes, 4 walkers  509     134    -73.7%   ← rwlock readers contend
>>>     16 nodes, 8 walkers  313     113    -63.9%   ← same list, 8 cpus
>>>     64 nodes, 1 walker  1979    2039     +3.0%   (pure walk: hazptr tax)
>>>     64 nodes, 4 walkers 1914     509    -73.4%
>>>     64 nodes, 8 walkers 1015     382    -62.4%
>>>
>>> Its SLOWER than rcu, but beats rwlock
>>
>> Two feedback points:
>>
>> 1) The comparison I think Boqun cares mostly about is with expedited
>>    RCU grace periods, this is where we suspect there is a significant
>>    benefit to using hazptr rather than RCU to eliminate those IPIs
>>    on synchronize.
>>
>>    It's good to know that it performs better than rwlock (albeit it's
>>    not surprising).
>>
>> 2) I'm concerned about what looks like a use of hazptr to protect linked
>>    lists elements in your benchmark (did I miss anything ?).
>>
>>    RCU read-side critical sections protect all elements of a linked list
>>    naturally, but hazptr requires more care. See this comment above
>>    hazptr_acquire:
>>
>> * This protection is unconditional, and has limitations similar to
>> * that of unconditional reference-counter acquisition.  In particular,
>> * although holding a hazard pointer prevents a hazard-pointer-protected
>> * object from being freed, it does not prevent that object from being
>> * removed from a linked data structure, and does not prevent other
>> * hazard-pointer-protected objects referenced by this object from being
>> * both removed and freed.  At which point, invoking hazptr_acquire()
>> * on these dangling pointers would be a bug.  On the other hand, use of
>> * hazptr_acquire() is safe for immortal pointers to objects that do not
>> * themselves contain pointers to hazard-pointer-protected objects.
>> * Other (more complex) use cases are also possible.
>>
>> Does the pointer you protect qualify as an "immortal" pointer, or it's
>> a linked list "next" pointer ?
>>
> 
> Hmm. Do you have a idea on what you could metaphorically convert, with a
> core subsystem?
> 
> I'll give anything you want me to do a try
At a high level, I suspect it would be good to start by digging into
users of synchronize_rcu_expedited(), to see if a few of those may be
good candidates.

I would also favor scenarios where RCU (or locking) are used to protect
the existence of an object reachable from a global pointer, and use
hazptr to protect that object. Note that initially this precludes
a hazptr-protected list, because the next pointers would sit in
prior objects which are themselves hazptr-protected, which is not
sufficient to guarantee existence against a hand in hand traversal.

However, if you have a pointer to an object "side-car" structure
(e.g. optional extra metadata), and the object containing the pointer
is guaranteed to exist by another mechanism (e.g. RCU, locking), then
that pointer-to-side-car-object field would be a good candidate for
hazptr (AFAIU).

I'm not saying the linked lists could not be done, but it would require
more care.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
