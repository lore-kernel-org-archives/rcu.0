Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022103.outbound.protection.outlook.com [40.107.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39B371041
	for <rcu@vger.kernel.org>; Sat, 28 Mar 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774740247; cv=fail; b=nVJsVBH4SGTlRWyiK86E0xFFEsxIaoJlPzLi2SIezcH7VGQtGjR8H27lDBPR0xMqmadL2rWdk7r01oairwYlNszMc1LE11Wm06Alkm9n2qKODoROqzzTG39O+DtWx235rcyaPod1v1vuXta25W2ciH6DspPYZisqsqRWbJhScLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774740247; c=relaxed/simple;
	bh=6Yt6TW8BWpBO9QQIbeTouQl60vRjO+g6JVbWX+g7NoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hq20jRTKtxDq4OjGHhsPQ/jSw9ESyN95hNiwqfJRNds1XfM8pPCMzooixHxZPimxr0DD3NHYjlqFomj2GiO/52A+eQSdJYVi+xBdj55JKOr+Lj1d/YfTh/cib2cIgRcB80BZ4qPIM4pYHOQyOMvuKoUpUjw59XmvQxZo0QoeDUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XVdIotXC; arc=fail smtp.client-ip=40.107.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XVdIotXC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9zACx7kGODHAgstgTWGuNLfbU32e4G2gLNcLP/y4FRHKYmXA932RZONumuIR5xrkzxY82UhD2je3tqXsDkCmWiJlw3UVkeKL8r5aW/O1LLASYEaozp4e0V671hSyRAOnrX+JTDXjdGa6U7xi9GLE44ceW/U3bKMcE4EFrJAMvqX14T7Q9RvYaH+gc3Rp/TLlX1PZqYfZn1BFxj7ndXo6UdxDWYYALctPSZMo78P0VpYx1b3cBZiqUHuPv3NKWJTmBOJebZdre3ML395P6qytVPDEr06EWM4trNpTIQxVTBwxi+/L53VKc5sI+ECVXK2Nrjz5LLJc1DMOghvX/cZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjBGdVxFu7agS5xF0BlV6gFfOKkEPQ9kf4U8saj/UZk=;
 b=vN1TI/KajR8rHKYMa6SiPPZmD2zhT9mL3BE0vaEZMeRqjoGNe17t2gNYK15LTwxenQ63sUyKpkakKlibE5tnqyfxgOlGbhjk6npfkpPuF4eub5k97G5LkKzNkXzSYE/pBqBpyMhDKZjFndwhoE0B/uZ86j8lDQzxze2kCqFVrm6J9tfxF/5XnnMYSITQhtvW1ChCIB43zFk0Qp6EdtqFnyoH7bLlZC9QMGyAfn/WlktEfmvH8UGJ1yenB/a/1+j6QIJCZ0/A/lZErCiMBx1gzXacpkspW7NaSF8MeKatyOzM9l3ZOI9fOc5bdM/0ihX4QiBA0twxmMEIpkWpUR2Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjBGdVxFu7agS5xF0BlV6gFfOKkEPQ9kf4U8saj/UZk=;
 b=XVdIotXC1dxOknTdR0cSWKrh4By5pfrdstIULxK85UG3jojlhewyLm0UVbSi9Y7PXiecsX/dtsKYyRn1fEuBvjUzVW+NPJMEL8GPwVatKHvvrrLEyXL3WOqzXAeGlSeL5kap1/zxC1/LPZxaZuD0MHIzGfHD33nsx8GfIt712jCPeaIHQqu082+wftBdBMbiYk9bNZvQNio2KWhYkoUyL5/WJm81R5bBL+LUumrVyMXDx2SWsuZL454d2o91SckHZ8tgmu1NXAS7SGKyvW2JmRn5J1hnXVTUDRIwxLaogo/1P3P7cLSqos+sknQmLjqzTNnu2TTGpcPyxF8a4p14Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8737.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Sat, 28 Mar
 2026 23:24:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9745.025; Sat, 28 Mar 2026
 23:24:01 +0000
Message-ID: <729a4527-5f11-4ef1-b8bc-06e87a6caaae@efficios.com>
Date: Sat, 28 Mar 2026 19:23:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Semantics for hazptr_acquire()?
To: paulmck@kernel.org, Boqun Feng <boqun@kernel.org>
Cc: rcu@vger.kernel.org
References: <0787677c-809e-47f7-b8a9-75f65f3b0a33@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <0787677c-809e-47f7-b8a9-75f65f3b0a33@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3074bd2d-efdc-4ec3-38d9-08de8d211801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WlNLnoGajc7xa12QnXBef9W1wNSGqSLLnB3oonaKMBot+HrhdvcdSyoDqZWWaKDdeY8QE0lj+j23JUByWPymTqts2ABoteaxN0SgXVzMS+F2zAiR3gQs7/1QpbpDoCRYNRNJoQXqTqog8SIzwIDc11YZunrTLHvP4DHKuloLUMEA27jVjUg8gfo1qXXMpCYWz/7sLqnqIr2BQJ6LEk/NrAXvfiQNMh/Ttm43/3sqcpmMnwnnBcBQdRCMI+VTjBCjKni8Uso548fTrRE7hbHTTQyfrA4eLdAcvWSaFq/Odr1F53X2HL7Acr3ObQ0w8vLgWb1YrEjrY/xkew6HLzMrUin8fmPSLcen0Amzvul/zPQkt2N5eefq1zFeX+9r2sn70893Jt0kv3YqGdTxxxoOgu7/5M6pwYxLkWEn/ZJoHwwipO5JqpsNcDSNyE72yYm4EmDzmdxpcUCk2bqMcudGE22pY+aHuxP8zIQhKGFKahpldU6JExVTq+T/o4pygvNZ9niwYKSqBaeGbU6etMaR9MM7ImfRfQHrBKpXIHwBgSL18BQ/ArJhu408B2qMUT33LYBw2SkrT+BX3y6iLAy2YUczvnXqeB7VnpCBjNIsww302enwRCbD102OnBIRoF6psl0p/k9/z/WlBIw+TIh8gxYm6uoMV6XeBq6n2GN1JAwSn2WHMWPhwFgiAuAnuysk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHI4SFZmSG11MXNWcGsyV2FTZU1VV1dLTXJIc2M3VXhPZXFLckhsNitiK0RP?=
 =?utf-8?B?em1uUzRRNW5jeWY4dWdLTGkzeThEK0hLK0h3MDR2V2w5d1k2RVRsUnBTZlFu?=
 =?utf-8?B?dlArSkJnZ3BQYWIvRy9VRkdTMHNNY3gwaEsxQ0pkb1FzN1FiaVRMWU55OGxZ?=
 =?utf-8?B?bG5CT1Y3amZGQ1hsVzRxTXJPTnlnN2Q1eUJUeDZiUlN5UUs0NFhwQWpNeUtZ?=
 =?utf-8?B?Tzl1L3dRY2pLblNHcWpPL2lUNkxORkJDMDhkTWpUenQ0OWdoZC9yMnR0TCtt?=
 =?utf-8?B?RkdSVjlhcU9DL01RaVNRYW5ZQzVFd0g1bVE5elRXM0IyRjhnT3liL3Rtam92?=
 =?utf-8?B?UWJpRjA1c3BCc1dGUlZ1SjR2NjFhWE5mVTZ1M1dmTVd5WnRKWnpZbUY0QUtu?=
 =?utf-8?B?R1AvNUtzenE0YzVFSkNySG1md0lMSkV6M3VaSTRTOU9wNGdMeFRoY3RkTmlP?=
 =?utf-8?B?cWUyTHFHeGNUWlN4UDFyRFBvSmovR3RFVCtLQ0FicFFKb0sxb3NrVmFKZm1L?=
 =?utf-8?B?VjFvaTdUejhlaXkybUIrVkdOU0Z6Uk9IR1ZFQ3RSYjlhTGlqTXZlT2dVRith?=
 =?utf-8?B?VzIwaTZWTmxmdHhpZFE2ZUtxb3FvNE5KVlM0eFdjMlBCMnUxbFBaSy8wdzho?=
 =?utf-8?B?VjJRUitzaURzS1EwT0g2YWxWT3hyVFp4eTRZN2lyVklxN21FZkZvTFcvYWNZ?=
 =?utf-8?B?bUlmQ21VaE9RL29EWXlOZXBnbDBEcTVWNGpPVHpCMDNPV1grNldNV1pCMktI?=
 =?utf-8?B?WndMOEFiWmhHdFllRmlrOUoyd085MDM2L0tNeFRnd0E3TDE4TXl6MGtnUWpj?=
 =?utf-8?B?d3BVQ1JzWXMrWXkrMERQRW9tTGdjbE9OMkE0bmZ1aUwxeHBGZCtoZXZUVzZH?=
 =?utf-8?B?Z1NkZ25pSU9YaFZndCtEbkNGYkR4Z3h6SDFSeHpLNzBhT29weWJQcWV3Z0VG?=
 =?utf-8?B?endJblowK1k2WGhzMm8zYVMxQk03UExvNExqdVdwV3k3M2FZanhRRGNQYU16?=
 =?utf-8?B?Q0g2SThVTzNWZTJjMmp6NloyRUdoV090K0lmRzBCWCtBdjVic2VrczdqWnN0?=
 =?utf-8?B?bWZZTTBJWEhac1Z0Z2wzcFNGT2RMNzlKRDZwK29aVVdRVXprTy94OWV5dmc0?=
 =?utf-8?B?ZXFuUHNNWUovdGxPYlc3R21kY2kwRU9EN2JsUmxEdHhOdlRCenhYbEM5c2dT?=
 =?utf-8?B?eUg0OE5RbnJXNzU5dzB2bVkvdllzY2VrQ0hFQUNXbUJFSWNoTVhsdEdtLzlP?=
 =?utf-8?B?TWRReW9yMjR3Z2xWR1V1WHg4RmRBR2dKUDBOMWpjQ010SkpqUmZBSzlma1Jz?=
 =?utf-8?B?S0RNUGg0QWtoc2tHbDk2SW9BajZHdCtRMXZ4a2x4NWtYVzF6bXc4UUFlcUpM?=
 =?utf-8?B?dzlBZ0EwcnRhUlBqY3ZOSHBHQktaak5QNWRtL01EZHYydXJYd2dCUnU0YTZu?=
 =?utf-8?B?WnB1YzlDcHdFenZvQ3JhZm1RS29ZWHB5VUx0L2lSYWVDUFBrTk0yY0k0aXVE?=
 =?utf-8?B?VFRCaXpaVDFFTmUyUFFBWnN4Q0dITXpyY3JpOTErVzV2Z0hUNkJVMTJjRzVo?=
 =?utf-8?B?aHh2QVBDT2lpY0s5YVhkT1cyZjA2M2tMUUV4WkxnWFlqTkVlSTBHNDluT0FM?=
 =?utf-8?B?NlNyYytFYVBWaDhSeHhTbGRkL0J6ZW1GV3FVZStoclhoRyt6Zk9HMEcxNitP?=
 =?utf-8?B?RzZWWC9YbFp6MjcvNCtlSWl1MkVRKzV6ajBydmZkeFZ0eVpUYmhCWk91RjNo?=
 =?utf-8?B?aTc5RThmNVFTa0JackhIV0xGUGM2SVowRjBXWk9sc2cwMmczS2RXb0E1RVRV?=
 =?utf-8?B?a3RTUk9odTN2NDd6MXNyaFQ4MGlaRXlqcWRBNjk3ZWRFNFBHWlIvRXcrVTNW?=
 =?utf-8?B?YXRCTUU5U2RhTXZ6WWZxOGV1MTdmT0tHUkhMV2d0MW0xd09oOGI1STRiTFdi?=
 =?utf-8?B?ZWFmY2FYaCsyZEp2dnFTWXFtTStJUEd4NU5rNVV0Nzh5STlpMzhRVk9Mbzlp?=
 =?utf-8?B?Y3hCNFlmSmM1bWNDUDU5d25zVjVEUkcxY3dETFREdVVtdkhaYlVXSFdoM3Q4?=
 =?utf-8?B?RlFub25PcEdHWG5TOUZGL0k2YWVqL2pySlVKa25lWG8ycUI3NDhEeWZXNXI0?=
 =?utf-8?B?d2FMRkx5dCszZU1FQi9UTjV2eXhSWFd0L25HUHRteE8zK1hqcnh3aFRuaEM4?=
 =?utf-8?B?emJFNzBqQ1dhaExNTUhYd0FXUnJGMkFqVlArOUdSMEs2MDEwT2NXUTNlUWxZ?=
 =?utf-8?B?TklWTFJERmZzdEVHSWZuVXlDVlN1Z1VsTm9pVk9aTW5uTzJXTFBMa2NML09r?=
 =?utf-8?B?ZGFVYTBLbjZQdDJqQ1R4TnFBNW9OZjB4amNFZkJhTUdnR2pFMG54ZjBXL1VP?=
 =?utf-8?Q?jiF3O1Qxdu4BAZ8s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3074bd2d-efdc-4ec3-38d9-08de8d211801
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 23:24:01.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WbwtKKtnYogNnzP4xRcH5300OfGtmikpWZIYfoaDq+t5AfCELS3X0dUtNQXZyDzPg861tXQ/EH3/KXapXVsXA4YF/G8hYvWzNcB165jMbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8737

On 2026-03-28 18:37, Paul E. McKenney wrote:
> Hello!

Hi Paul!

Just to confirm: we're discussing my hazard pointer implementation
at https://lore.kernel.org/lkml/20260223204418.1429025-1-mathieu.desnoyers@efficios.com/ right ?

> 
> I have been (perhaps redundantly) putting together a torture-test module
> for hazard pointers, and need confirmation of the usage rules.  Here
> are my current guesses:
> 
> o	A given hazptr_ctx structure that is passed to hazptr_acquire()
> 	cannot be passed to another hazptr_acquire() until after it is
> 	passed to the matching hazptr_release().

Correct.

> 
> o	A thread that has done hazptr_acquire() can be preempted and can
> 	be migrated to some other CPU before it does its hazptr_release().

Yes.

> 
> o	Except that a given CPU can have at most four outstanding calls
> 	to hazptr_acquire() that have not yet found matching calls to
> 	hazptr_release().

No, it can have more outstanding acquire than that.

The fast path does:

+	if (unlikely(slot->addr))
+		return __hazptr_acquire(ctx, addr_p);

going to the slow path.

The slow path does:

+	/*
+	 * If all the per-CPU slots are already in use, fallback
+	 * to the backup slot.
+	 */
+	if (unlikely(!slot))
+		slot = hazptr_chain_backup_slot(ctx);

which takes care of chaining a backup slot in that scenario.

So the unlikely case where a CPU has more than 4 nested
hazptr_acquire, it will begin to allocate hazard pointer
context slots into the per-cpu overflow list.

So the intent here is to get good performance for the common
case (nesting <= 4) without introducing any nesting limitation
for the uncommon case.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
