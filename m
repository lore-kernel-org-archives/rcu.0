Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020072.outbound.protection.outlook.com [52.101.191.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FC39CCF6;
	Fri, 25 Sep 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365972; cv=fail; b=An1q8mntMEL2fmCeQ3sBmYtiuBSfBcHt2GPKgJ2xhwsOeYhBjrq+6286QHVnWKTjBX8h6afYsPhyrmUfURMxnM+s5hLaHmGobxtEN7pB6Xv+DGmrgwpNF3YiV+pr0YWCL6E5iDsDjM5jb6Gw49NfhtQkaGjFk+dv+4KWYAglGQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365972; c=relaxed/simple;
	bh=+/JRn4fVgoT37j1b4BlMHKR3KBVoqQ3qjWOaXPUY8+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ay+VfgtpFyOjPYBIt01Zu60czO6ly7JUJEyswFfsbHnNbY6XctHSYvzhfVVTzhKgStUjweuXrjYQp3WBSX62yOe+zHQ2Gnc8Klhwpz3CBUo5DBZfgNjDKjNgthTP+IVBmcOmHHc+xYMrT1G9eUn2wLGDtt1fsTPYbH11VQtv440=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dG64psaJ; arc=fail smtp.client-ip=52.101.191.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dG64psaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFQBC2dIfwi5o8+5RLPh6MPQ6GuVWedXWgNBEfQNutPf4Z9RGnVEynQlsWbSYWfDTwK2Yz44GklaS6ypuunwSpKvCpP1w/ws04Kb+rvLeDJ8awm2U9DjEpRzZmyI6PmTjCQiKYr6FG2a0Kpn9olB9/Kv/fu/kz8zzL07Vz/syNt3ZiIblVCLy7NnGL3FGYTWwe5YVgTKR8eEl9V9lPvhL9+Q+gzNCQWPYVbb809xyTYuAJp0TsslAQxrbKjzAItnORaN3kzG3zLS119xYHGXQOR6Tg9V39CwMqaIWygzZz+kcDQnkYehPFuL5YZtwWcVWw9ikRG8RBo7X0scpWF0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn55tYjYon8Wzuo5tAwZpR7qarmGgh+YwLU+M8hXRtU=;
 b=Cr+MKBcYFdqkIe/+hKNomOVy31wqUISs8jV77NlX1ASI0fYJOlTdtbghebkl1gaPdhC9qLK38SM65BDWOSzQtf/CDR6vgrq7Z68TGdULypWm26bdXQY90Sycly09wutxWf4paCtTf8/bv4fW/jm672gs3tTb7NltRrri1AC110vpI5BlTIFYKxWr8sGrYsMfhPqXs+OBlZVmJn98QIvudbleJ6bYh0JXqqx04yXvMNuWcZriLw17dqKwNWE9CSzclzbCZhqR6O8v0ezjcDvruQeJkOg/cQV4tAbwlS0+x44xKtC6rDrwwWUSAcXZ8Xln/Bshn9AB8l9QaWqHISBtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn55tYjYon8Wzuo5tAwZpR7qarmGgh+YwLU+M8hXRtU=;
 b=dG64psaJ0eZjgYDl4loZ5M3syWCUYnTX1dDqwj0gwC+jdBni59WIoYMyRYpG5ExMiYcNyWCePd0GL60Ige7yysIpKNYwoZME0d7//CNVunkgq+BseUrzawI+ZS55AWpVViOSjpHu1MCDgSgjZn0SsVREHAThVXmVEdL3094wT0Ggx4hv/ox0cue/HdL+w4l/cAi2E7in/z60Gjtvr0V8zRoVUTSUHPpZFUzm6EhK2+wd9AFCChYvm2nCKpxD2JF6c+akQdsE9HG6Xt4blZzi2uRzjCZez40RD34k6zDkfc+If/FVuSHKn1bC03mny6jhE5RbVrZsVNnTeG1wvdjm8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB436122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 19:52:47 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 19:52:47 +0000
Message-ID: <0836f8af-30cf-43d6-8e1d-7886a5de9bc9@efficios.com>
Date: Fri, 25 Sep 2026 15:52:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hazptr: Fix two-phase hazptr_synchronize race with detach
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260925194952.4704-1-mathieu.desnoyers@efficios.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260925194952.4704-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB436122:EE_
X-MS-Office365-Filtering-Correlation-Id: e04225f3-ca63-4b94-ad75-08df1b3e928c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6meW0ZJQ60OBpyZzWbEpl5cLtxQj6AeAR7xIOG5xza6Fz5YfaE3hQg7eD8Vzh32wHksOBqhO7z9AuKQUjBapUidEfUScO4Afs+yhhSOMPPkeAcNaQluL29K6l7QWX8AZpQoNo4rqKZQa3LsrNXloXMJThzCL/v/CkW07a60bcfOYyPIl1ioAKQP/nJ2XoB8Aqzc7rKUYYDoxl5q4uOPu03WLlOB82NT5+VaIaI0s6aRuPr5R0mhueMKcrplCg31Js3eukcXwMM6bujrQT6h+RreJUtjRB7faXQWz3IcY3QabOlIU4OqNWPEThqWrIABH5/KP/KP+DW56bJirVIT3dvY4snBZdX10+z2NgV6sqBG5+Vz0Rk62mBwdHtrELANYrms+13e9VZJTUJx138nufY7MCndmeC3LNI4RoI+Nxx4YoOqz7mGgeEIIgT4hspk4eZ8Z2Xr32NVYQAOnPJiGp9wMljPUTOSxa9dwgP7Gvpns39w5QK9mMeT6lANstTyTnjoxddyqSZEd/fHN5whEyoZrP+6b634FJ3JDLhO2GcBr19lRS2S8Cxaq8M2f05btmY2L5NuA14raQRZEuu/CfepZcfhBsou1Pe3Wl4hDdFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NLZXlZcUdmVGEzUnhGWi9JYkdCY3lwc29RZmN5MXFPL2t4TE9uMkZHSUZM?=
 =?utf-8?B?TnQza1JqR3dXRXluUFFUcG0zM1ZWbk9zemhhcUxBZGlaaUJyeFQrRGtBY0pC?=
 =?utf-8?B?S2tPKy96VVptUksyTW55cHJWUXpwNXRWRHFmMjFVaVNNNjJGT3hxdXQ4ZW1m?=
 =?utf-8?B?K3UwOXZDRndRUDlZYUNWV1diM0hmYnhjZnZPbzBNY3dkQWdEQmhEbWg3czRj?=
 =?utf-8?B?N2pPY29MeE95Sjhmc2szZTlZNkRqQSs5dHpPVkE5azI2SU95MzFDaDZTMU5W?=
 =?utf-8?B?SGV0a1U0cmdkSFFXbDdwa1ZTYlM1MXJTaEtPNnJjUlVzeXZiRmNoN21KOGVQ?=
 =?utf-8?B?WGVERGl2QUxqWkZ4WU1rdG9YTEYvYUJ6YUVLYlFMaSsvYkxhNkVFR1ZHREQ1?=
 =?utf-8?B?aFJnTFhwTmtqV3M1RmF1aGdaZVZrQ2pGQlVZaWFCbEdQaHlRanZSeHZuNERj?=
 =?utf-8?B?QW5qT3NNR2RDcm01NDB4WVI5MlRuN0RtT3FkU2c1RkpSN3R3azQrTTZnWmR1?=
 =?utf-8?B?VGFaTHgvU0Z2MUpQQzNyOUs2bTd6Y0h0eUJybTdaQWw1OVJUTGNuelljUjF2?=
 =?utf-8?B?RUVOUUE4aGNXUW5MUE8vc1VZMEJucml4UzYzSkZlemJOYU1YMWI3UHJHVDNB?=
 =?utf-8?B?d2NSVjZKemtQc2F2Zkg3RmNpd1VxQWRHWjNacDJuL3VrY0lsWTJTTmNyOVF0?=
 =?utf-8?B?TmcyOW1GMTN0TmE2TG8yUUZVTkpvVVhYQUszTHpLQmVYVHg3cmlCTVZHLzBT?=
 =?utf-8?B?bmFhcENmNU9PMXhyMVlOaHBRYkNRYkZzNm9OMG1nU2ExcGxhVUkzNC9aUmJN?=
 =?utf-8?B?eUxkaG1hTXpOei9XaWFZQkRUWUdBelN6ZkphSjQxeGNDZzFaRTRnU0JIMG5G?=
 =?utf-8?B?cXNuQ05NZzc5S0VDSXJ1ZEZmcENsQmlQZHNNdm5qSlRwT0ZySURncWppZkx4?=
 =?utf-8?B?VTNKamRyMGFxbDdWZU9ycitPWURWTklsc2o5ODNTTy9lZXpGd1hKUDZCY2Vp?=
 =?utf-8?B?V1JsR1pucW1ibUdOTExSaFVTT2c3QjkveXVXSDJsYi9tWExMTXV3SVNiMGg3?=
 =?utf-8?B?WTUwOHQ3dUMwQitWQldFWVAyOFhkWVFxdExPbTZDYUYrOTBnVU9HWHRaMDdo?=
 =?utf-8?B?aDVTS3FBZFQyRDBsQnVuOHdkYWE0elhHK2tmVWNBV0ZPTEpZZ0tVL2JKa1RO?=
 =?utf-8?B?eHNCdVRmMVVmVWhlNW5wQ2tpMFpoRU1uTld2Wlc4eFlSRmpTWjZKbjQ4OGQ0?=
 =?utf-8?B?MUhBYkJ4L1lmbFpwMkQzREZtMmo1c01PejFGVzYwS21NQ1EvSE5jaDQ0VU56?=
 =?utf-8?B?bjJubEJrbzhDZmtEVVhrRXR5enYzZC8zenlMeWNucGU3cStjVlFkd1A1dXow?=
 =?utf-8?B?YUZiZ3RML21YNnBmRkdUNlR1K01yZ0k3Z3Rqam8rVkdJNWVoUU5rUXlMdk9m?=
 =?utf-8?B?KzNialgwOHovZG5UQm5OQ1RERUhlUEJsakIzQzlWNlc4R2ZCMURndlFVeG4r?=
 =?utf-8?B?TDBrSDNEZ1BWc0x5OC80M0ZVeUNWUEpxUjJyMm9tbXdOeUEyZzVRVlYrTkVm?=
 =?utf-8?B?VmtsS0JmMDljOXdTaXRBYjQrU1o3TFdSNHQyeWs5UDZWenpqczROM2xyUE1K?=
 =?utf-8?B?Rm5Kb3ZVWHk4OXBGVkFuTWJRN2VSeStpWG9nR3RVaEpWZmpWdHFNMGxQb0ZS?=
 =?utf-8?B?dTVycmlNc3FJaEtZaXovbm5oNEdjbDdMRG0rM1RwSFoydi9xUTE5Sk1uZ2pY?=
 =?utf-8?B?aEZWczlOVElVNm1ZNjlwZk4vL2tUREFGNlNXL3cxdzZPYmNnQkFBY1pRMnRn?=
 =?utf-8?B?V2Q3YXpxVG1JQloyOHhXZWN6eEhsbzc0S3BVMThOTFNBbUdLU1M0Z21TdEdz?=
 =?utf-8?B?NUxSR2grR0Q4OSthNkNlMjNKT2xhbWZUckFrOGIwNTUyMGxOL01pZ2Fjb1Fj?=
 =?utf-8?B?NVFncnhLNk8vdHVkK1pyMG9JbkxsWkR3SVRocDF0UlFxbVMvdlhKdUF5bEZt?=
 =?utf-8?B?LzBDanowUVNhZW14RFVQSnVmeDVya01CTU92UFZpV0lPTnNJeFFDYlZZZWJE?=
 =?utf-8?B?bTVFakNQdUp3L2JDV0ptTjlONS9EbjI2cGdKaTdJUWNwZ3cyYUl6K3MxNk01?=
 =?utf-8?B?L2ZSL2laWmc0aDJKa2lBODNmWXZOZjcxSGNidTl3UDNxUVZxMVhUcnJwMDhR?=
 =?utf-8?B?L2UxT2h5WU9lQndrdlZjM2V4WFp1V1REcDBhNmx5YkxPODR4VHRaZHdpL3pi?=
 =?utf-8?B?ZEN4OVl1RGx1NmJRWHpiZjhKTjMvUldPV1JFdnNKanB2emFmazlhU3pzU1lq?=
 =?utf-8?B?NFNiRXlndHdVUnByQnVyNHJKM0tCMjJJdlBrek0rR2I4cXhtaG9GWW55M3RR?=
 =?utf-8?Q?9qQeIeZlCKLwKoN8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04225f3-ca63-4b94-ad75-08df1b3e928c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 19:52:47.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rtf5TKgGxMy/1/ZZl0+2oFLZzQeF1TqrZY97EzhcFI1g3ASkdoSBFxkAHNs0TqauUswdfCTVhYHLEmrDEi+J2vZyMK/ut5yNnBICr6Gkbkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB436122

On 2026-09-25 15:49, Mathieu Desnoyers wrote:
> Boqun Feng pointed out that a detach happening concurrently with
> hazptr_synchronize can miss a slot. Indeed, scanning the per-CPU
> slots needs to be done *before* scanning the overflow lists. Fix the
> implementation accordingly.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Self-NACK. I did not migrate the detach code to move it to the new
hazptr_overflow_list_phase. Sorry about the noise. I'll prepare an
updated version.

Thanks,

Mathieu


> Reported-by: Boqun Feng <boqun@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> ---
>   kernel/hazptr.c | 43 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index d3d1050d92cf..ccc19843edbd 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -24,6 +24,9 @@ static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
>   void *hazptr_wildcard = (void *) 1UL;
>   EXPORT_SYMBOL_GPL(hazptr_wildcard);
>   
> +/* The current overflow list phase. */
> +static unsigned int hazptr_overflow_list_phase;
> +
>   struct hazptr_overflow_list {
>   	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>   	struct hlist_head head;		/* Overflow list head. */
> @@ -53,6 +56,12 @@ void *flip_wildcard(void *wildcard)
>   	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>   }
>   
> +static
> +unsigned int flip_list_phase(unsigned int phase)
> +{
> +	return 1 - phase;
> +}
> +
>   static
>   bool is_wildcard(void *addr)
>   {
> @@ -178,15 +187,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>   }
>   
>   static
> -void hazptr_scan_period(void *addr, void *scan_wildcard)
> +void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>   {
> -	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
>   	int cpu;
>   
>   	/* Scan all CPUs slots. */
>   	for_each_possible_cpu(cpu) {
> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> -
>   		/*
>   		 * Scan CPU slots.
>   		 * Forward progress against recurring wildcards is guaranteed
> @@ -199,6 +205,17 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
>   		 * to acquire that same hazard pointer value.
>   		 */
>   		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +	}
> +}
> +
> +static
> +void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
> +{
> +	int cpu;
> +
> +	/* Scan all CPUs overflow lists. */
> +	for_each_possible_cpu(cpu) {
> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>   
>   		/*
>   		 * Scan backup slots in percpu overflow lists.
> @@ -218,6 +235,7 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
>    */
>   void hazptr_synchronize(void *addr)
>   {
> +	unsigned int scan_list_phase;
>   	void *scan_wildcard;
>   
>   	/*
> @@ -236,10 +254,21 @@ void hazptr_synchronize(void *addr)
>   	smp_mb();
>   
>   	guard(mutex)(&hazptr_wildcard_lock);
> +
> +	/* Scan per-CPU slots. */
>   	scan_wildcard = flip_wildcard(hazptr_wildcard);
> -	hazptr_scan_period(addr, scan_wildcard);
> -	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> -	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> +	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
> +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
> +	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> +
> +	/*
> +	 * Scan overflow lists *after* scanning per-CPU slots. See
> +	 * hazptr_promote_to_backup_slot() for scan ordering requirement.
> +	 */
> +	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
> +	hazptr_scan_overflow_list_period(addr, scan_list_phase);
> +	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);	/* Flip the current list phase. */
> +	hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_phase));
>   }
>   EXPORT_SYMBOL_GPL(hazptr_synchronize);
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
