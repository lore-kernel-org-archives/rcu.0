Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020093.outbound.protection.outlook.com [52.101.191.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA758B6DF;
	Tue,  8 Sep 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886439; cv=fail; b=p0cyPPLVOR64039pHZbFKdJLQg8ar6fwxN7HqFTI8JsPPGW150daLCdenT1+MCtBSI1xnm+JmJTO7FwZ4TLBbtynksVBZQmsQrEYes+1kL77+KlceCb0HL4VAnxDkWA5gUI7d/VJIxgSq0m+D25/Y7A429P5NsBZSIW50frCMew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886439; c=relaxed/simple;
	bh=7StJuF46lBdS5IeMqAd85sdAZcmrGhR+ytaLfiTJtgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atkZv/YUzFW1rlHCnKu4XmfaF35cFdj99hjFl7JMoEXrTJ2BD9N3PUCMb6BhbQhFp70e5o8qj8QerHUPuhfPIlq1/H/vIO3tPBeKSaKUb+nG0C655JZolALOJnbumamLqXJoSNi0UU+3l/ozkJSPPFFKDPO3qjvwVf2c1/pFYVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UmAuO7ow; arc=fail smtp.client-ip=52.101.191.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UmAuO7ow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGNvX8zV8WiukAFfIXMCOZy3kp6wxicmxXwrpaCN8E3V+ndZ2JohvrL86YwNPj2Hku06xLA2LRhK5I70tHdkYNsOYWVA2YpMl11PPKLSQEsiNzSeYxy1KL+g+6T8sVG7Pt4OZV64PQpH1e/0kR6GEMoA/PKSR/fz6wCWkOYf5fPB2oSLOvufq1ZNrfza1lIxb8t43rm4q73E0Kj85o0mV3N6RpSAeghigG8U72XmKmWyW/fBu5yr7ARCzbBDjzsEYlD/Ofpx3TPsKBbnkk9UltD+tPA0hMMQCE2DSFavmi2j4D2Ertr7WbvnEVAegMY+UDhg7xzqL3PmNQ6bL0uPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgWzNZJGqin1hqqhdeIzrCCTSxFytrqmm7Z59z0OSVQ=;
 b=VApN0oBkauRhYyTm1KEK4IPF6hIsBaNgfgA1KXGhsOyQn/TLQ3HBZQzEjFafd8VbM19PB/a3aB+NBc3ALFA4btlCgJU4MyB3ugw+i1/Z8L7NeeqEfJoRLD91i20Fk8hM7f/8Wz6NKjzJyV6M0tG4UQHhf2nxG+1FCoA8UGIdNV6nbhl82CYeffJ94TsCxrDIvCSkTMfp2dDH6xSqX4PhVAIQfe3vNfhhMb7bBeQdY2NKlP+JKxQlZOGWRBwLTDb9fcou24NQdd+zuwC7s9I3MF7tgo2U0yxQ3rhuqubg1Tl3JhkTk2vbL4DLiIyjJTEUt0fWAC7GvQuMFVP6/cq1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWzNZJGqin1hqqhdeIzrCCTSxFytrqmm7Z59z0OSVQ=;
 b=UmAuO7owtOCJ6vHm6srJqsxtt9X+amfQ4jwZ6UJDCQgBYw77s66o19rBU6+pmbCfIFUwvD9+WInvj6/bs4aPMgFN/RB4vnd8v5Q1woi3mnN6U6yxmhjmZTgaX2GnYiVgJII8REvQ263x//8g9Svs9Y3KYmz7rRYHUc3yHDm9it0SfgR+apJsf4iaw0YiuOGzpxTNLsxAq5/3OLOyT5ei3ueBBkc8tdmXT91+surAMgiKl9pitMfaDBAKRo0SzG4aIjWK4EfbeGXdzfDabDX47NCOdGJOd2O7VufAWVE3kyO6GiivEBlTmgcebFYyVj0G/g1oE+E39Yf768JPbkOVQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB073704.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:d5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 16:53:54 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 16:53:53 +0000
Message-ID: <21b63f08-e79b-4eb9-9922-77a61d5ffa7c@efficios.com>
Date: Tue, 8 Sep 2026 12:53:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
To: paulmck@kernel.org
Cc: Bradley Morgan <brads@mainlining.org>, linux-kernel@vger.kernel.org,
 kernel test robot <yi1.lai@intel.com>, Boqun Feng <boqun@kernel.org>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
 <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
 <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
 <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::35) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB073704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3177f524-68c8-4b75-9183-08df0dc9c40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VcRlpUgeWzvhJXvgwCfvZ9xkHl2pVVadBCMOYqzCaeQ/pyrkWBsn9R+/Z6WdOAAwdAwTmIiDhlTnz7TS3nubMAA1ZDvFGoU6VTSBTX8cn2ahX5zdVD3m5G/OLu2MLXXv3KtAzpF8fgAR2UZmLVJtEivJlVpmi+QtG08BJjG2aP/8zw4W7odv+FP6AZnH5oUbzlCNGde55SoEUWKDK1/ib6ICcyOv4aRvnXcDz/SxJLptXaacz4BYXYw2wCEyznXD0qQzZbozivVyVVysSrY2yVMDRFGW/68QipNZwys0Vy4EXzeJiXYDJuhj6fiLpJpmCaNBW6EJ4Dhw850uUS/mFukMtRxkMM4YnoP5BZen1JcexBtoeUbL6vlz76Z/A6yRU/+h9kRIz6nsDU3CPzYrz9l5r/P42guzvjQgvHgGvTxC8GexXj6tUpCDQsSVoCR7cY0SIxIcvukYUqyHPCkH/BLznSuV5a5BYyumhPqllbCApgvu+eChRGWsYIYbfQ8YX/BpWTwf71fc29uuL8quRWV43NIB3NwfG3WkoXXrQKGTAHOyf0qOrPUEW556N9Ki2hKO/f8k0vLHR/5fb0LogSVTZCHNXQPUOhnrK93lDR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blllenRCcXkxVWIyd3VKaXJXNG5PZHc3amtHSFdya3MxZzMxd1lRT05INEdt?=
 =?utf-8?B?VEc5cHk4SzR0TnZkMnAvdktneHd6T0U0SjVNSzV4aGZNNjFKaXlBUkJlQ0RO?=
 =?utf-8?B?V3dzdk9XZmhScGJDWmxTUjFWMjNsWlpPY3dWTUpPRmN6eDdjelRwdDQvK0sx?=
 =?utf-8?B?eGc1M3EvNkdxdlVqNnViYTQ0bkErR21jYWZIZ2Q0R2dVNWc5R3ZDbEpQUXov?=
 =?utf-8?B?ek05OWs1ZWtwNWcxeks4Z0lrN0ZGQ2tZYXdkMWUrTzJFZEhqTHVRYVU5elJn?=
 =?utf-8?B?SnRqdUdOQ3BzcGRSM1BXeVVrWU9Yakhza3REM0ZiOEN0Z3ZEdmpvTGhsTGhE?=
 =?utf-8?B?eWZaT1c3enN2STErazBaVEtZRFQ3cU5DbkZ5RnFta2k3Zi9ZRks2SU9kSWpU?=
 =?utf-8?B?OE5lM2F0bXI5K2tPVGhRaEpXV2dqOGdIZklCSmNpMmI3aVRZT1MwRlhoUEFl?=
 =?utf-8?B?dkRONVV2WlFGcEVKSVhybWdLLzMzM3E0MEsxYmJYMVdFdTZad3VGeGtiZVNQ?=
 =?utf-8?B?M1l6cTlXWlFNRzBvRkQ0bFdyYjJza1dxYi9HNURnaVpDN1E3VXVrTy9GVXQ1?=
 =?utf-8?B?dDhvZW5vZDh5SDQrbmRsSzM2SS9oRS9TbVVORUw5aTdkV1l1ZG5rQnhMcXE4?=
 =?utf-8?B?MXlKMEVmeERmWUZzekJJS0VvcU5aKzNHV0d1MHUydm9LNlBqVU1pWWxRRHQw?=
 =?utf-8?B?TXJpRGhOcDliTFVVd2xuSUQxVFdUbEYzK0o2M3dZUkZSVG1ad0hubmt0Y2Iz?=
 =?utf-8?B?alpPMFBOc1Y4SVFPeHlnZmdSWk5iNlBXWUlCZElQbEQxUzk1R3YrWVNWcktS?=
 =?utf-8?B?dEdDN1pXK1RnbTdWd2QxVGpyODIvRUJTY2tKVGV4TVZHamk2RVpkM1lJVEt2?=
 =?utf-8?B?TjIzbHIvUHNhZDFQeFlRNDZNeVJKUkNHdHBUcWtvME4vMXJ0T21LeGNMVXJG?=
 =?utf-8?B?MDU3NG9SZW1VZ1M2SllwSzVuRnJWSUFZcm1sM1Jhb3czUDc5eEptMCt2Q0lr?=
 =?utf-8?B?UTg0UUREVUV6TGJENFQveGlUdGtVUGxEQW0rdGhEQUtiUG8wWEV0M1VSWmF4?=
 =?utf-8?B?YWdFb1FZRkVocHNEelpiQ2FUeVhpNFkxQi9uaHU1cUFzRzY5QXZxVHI2eUEx?=
 =?utf-8?B?czBSZVBKK2pDU2JvMVplMFdkTUtZdEo4VUdtRTFmejdsdFhiVmhETGp6d29r?=
 =?utf-8?B?cFJuM3RFWXJ5T3RaQ2t1WUxyTzJNeTlXMExtNk1XZ2UrQW5MRUtrbU1SU1ln?=
 =?utf-8?B?K3E3OVNIQU9FNHJIYURCY3BPT2J5ditQTmJNaC9OM0hTRDdPQklmQ0VwdFc5?=
 =?utf-8?B?cE04eXFTbW1zeHJtdll3T3UyM1Rabk1PcGFNSDMrNXd0Wjh6bUFHV1JzV1lB?=
 =?utf-8?B?VUNDZEswSXh2M0t5dU9TUGRSL01FVEI2cjdUcUJYemd3L1ZBVkJGN1RkTEVO?=
 =?utf-8?B?L1hzODFZZFJqTS85RFpSaTIvUm9Ba1NoMzRwYk1YZzMzbmtFeXF2NFZicEx1?=
 =?utf-8?B?a0ZuNEZ1bmduNnZqVVVjeGxHL2ZyYlh3ZFRqMmFEa0lST05DcGxRMHUvK0cv?=
 =?utf-8?B?L1FOUE1VamoyeTh0V095WHM3d1ZJSllGaXZ0c01iTU9QcHVzOGJkNlhqV1hN?=
 =?utf-8?B?eEhTMzJ3Z09Oc3dkSUpoa3JvTFV0WkRUSXovMGY4bmdnL1lpdTFZQzkxSVE4?=
 =?utf-8?B?SytjMnVpeFdUdWZtVVRHN3QxaURjUUkvTlZXeWwrZ29lRVN6bXJlR2p3UDF2?=
 =?utf-8?B?eEpOOVNIZWFSUnh4MXJxR2xpTlUrREhKZ0Z0T0Y4a2Q5bW5ObzN6bVF3R3Vu?=
 =?utf-8?B?cm5jRCtiVDZHTXFLQURRajRYaFNGcXRZSEM4REU3b255bndRYzBqTWMrN1Zs?=
 =?utf-8?B?a09yZzlRZlV0V0dYcjR6eldhUU1ZVHlaeHZHVmlkQk5veTExUDU0U0Z3a2Jl?=
 =?utf-8?B?dUkyck5hZnlTeXZZc3N5VnVhWW94OE44eDJucXU5Lzl2Qys0YXpWcit6YktT?=
 =?utf-8?B?SEs0WS9CUnpxaXVDT2FYS0NVa2tNTk14amRaNm1NSElQb2c2YVM0Ui9pR3ho?=
 =?utf-8?B?c2lxdU0rZ2JRWTZDSzJoMFllVkhHNzR5NVNnaUNYMld4dm1LL1R3SGNuUXk1?=
 =?utf-8?B?ai9Mb1JJVFBiNTlKSENuZGx1d0U1LzNHNnlDdmV6dXVpK0VCSWJ0VU5ia2xS?=
 =?utf-8?B?YWt1eHRIdGZMOFhsRkNtM1R6QUQzY1FNT2hDU3hCajMwdHZWSy9FT3MxNzdW?=
 =?utf-8?B?cHk1c09wWVRzZlVxQXdVRFZ5SW5ubkgrYjVGaGdwT2hqN014NkZHZlp5cklx?=
 =?utf-8?B?ZUFLVFA4ODh5U0MwaXBFZHd0ck1aT25sYlhRamI0a3hZQnJ3TWlPWDVFRExr?=
 =?utf-8?Q?zINvcu53nT5aWl+E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3177f524-68c8-4b75-9183-08df0dc9c40e
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:53:53.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baGwvqF9k09AVTrjZG6mxhUZgGRMFOp+ujHbjOK6jVfO5SBWcJW9BfWo96WWldHT3pjF0iOZAwy3b9a7/N24WMKSBExk2gXySjUA5lvIkps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB073704

On 2026-09-08 12:22, Paul E. McKenney wrote:
> On Tue, Sep 08, 2026 at 11:29:31AM -0400, Mathieu Desnoyers wrote:
>> On 2026-09-08 11:24, Bradley Morgan wrote:
>>> On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>> When hazptr_acquire loads a NULL pointer, it sets:
>>>>
>>>> - slot_item->slot.addr = NULL,
>>>> - slot_item->ctx.ctx = ctx
>>>> - ctx->slot = slot
>>>>
>>>> And it returns NULL.
>>>>
>>>> Then hazptr_detach is called on this ctx, it will act on the ctx as if
>>>> needed to be promoted to backup slot, even though it has a NULL addr.
>>>>
>>>> Looking at what hazptr_note_context_switch() does before promoting
>>>> to backup slot, it checks for a NULL slot->addr, which is exactly
>>>> what is missing from hazptr_detach.
>>>>
>>>> With this in place there would be no need to explicitly check the
>>>> hazptr_acquire() return value before calling hazptr_detach().
>>>>
>>>> hazptr_release() has a early return check for NULL addr as well, so it
>>>> makes sense that detach does an early return (no-op) similarly.
>>>>
>>>
>>> You shall kill me for this!!
>>>
>>> Could you perhaps do a splat in ze commit description pls?
>>
>> The splat is available at the "Closes" URL below. I'm not sure whether
>> we should duplicate this verbose information ?
>>
>> Paul ?
> 
> I am fine either way, as long as the information is reasonably easily
> accessible.  Which is the case either way.  ;-)

Then I favor a concise commit message, leaving the splat details to the
"Closes" link. Feel free to pick up this patch for testing.

Thank you!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
