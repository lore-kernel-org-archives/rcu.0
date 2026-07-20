Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD4382F27;
	Mon, 20 Jul 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581614; cv=fail; b=jG+ekJoUIkCGrqpuvF3n0ywxTIn7SyK5F9Vqo8nSiyIZVzvZCeXFTa1l6g1sBpIW6p0yofHJX1hkF+zPTuqXH7oR5sjk1e7ti05MsQf84fdNXvuH7Er9hysY00tecg9ChWpkFgB4DMVnsfjnSdcfjXccle+llZJpubg4fWaSGu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581614; c=relaxed/simple;
	bh=OA9Iq1QdaVUD0XrxE38aI2jdT3C0jpSuD89nOb5eJMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxcdIhZlOrkFnYx70uDoSHDIvd5Lu5Sjq7ifTtbqmG7VnAHv2M76ufyd5EvDsUSq1uvSp3NLz0D3EVWcjYXO78jNd316P1dfqG/tvxeriW2OpSDyPL5qdM2m+W3FAncj3VO7TMKbhr/nGTZTog2ud6wxJydPOiGSH7UJ5y5dgA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fW94ZdyT; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fW94ZdyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by7CIF1fnZzTiXdL6XtJ6xxOZI7bZKb9Bb36H5hQmdrZrBcwYSlbHFrgiLxAYzkHLgGlk8VHcJOBJFXsmgYnR/0nCu7MJFbxWcqCK58w4R17ApBltelTZ2wSbOYYcuUdZA7Zpyni7eC4qdsv1lzjieZ5iPIzmrALBOXnur9g/BuB4NpRrmRy5ISqhHd+xh0er61C4RLoWm1p3V3AILNuGrrVKD7I64TQshUDE7ZMZ+VAqbEiHIbDSHu+uAUq+7xK/o7ym00rwPwZSLclO0FYhBoLw7mEbM2MPFOedGOpGpeXz2uBXPs19LoFa3vL8lV4AYjrNXGhjrDmlT7lfmUcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAwvtAUKqaocZaljglQ1HcPn3tq4toD3RHW1Ae0Q2cU=;
 b=AGocDyIxw/10jQQu75aGBgicZMZWgdaW28xf0J1oAim42O4rPorHS4xlOEf3BtD8Y/FId3TkDK+sCq1j5TEOs/n6SmRCm5S71oO/dnvwnGHTE8a/jS2mtDpIn9HRK+cBKzPCTrsRoXe4PukWhk0vlwdUYgW2wRm6vrXAbilK6JGQhxZlsM9IVKlq4vsk/6eClegXJNKAN0ezsQqd7AuWbtphQ40v6akuTKtgnu09tTfjb6bFmlrfp2tH7rjOY6C/BGOstCZQZFxx3euW24CM8qL9kb1Q6U1/pZMBGEwDiahQOzAIZ/lGyMybmY78xzwoxbTL66RAdLoUnkzjsv5Ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAwvtAUKqaocZaljglQ1HcPn3tq4toD3RHW1Ae0Q2cU=;
 b=fW94ZdyTwlnAxIAyh+yc/Y8DOsdcpLr7Q8xkfHvGgQhMmPIrTb6gQziEt3X9Fu0EwLXjNqJi8GRRr6vYRDN96zik4kPDftF70r2y9OYCOCbUc9YA4Z1JyjbF2BTMb85SOE9gQDvRalxyhXNpn5QaOi2rCoVdyuMMsw7Cb0cheuKg+MvPEfldiPNqeDHFpVvDpCvgNDNtQQNa5KsVPXfR1vlXyPz3hq6bpXuYyQRd0mumDThSP1qEfsjVpyUSDTBVuTl+/8/dxA+clNEGUr4FjFPvxD5jCT2U1NVFDOCavHbBd0KwZi1TrI+UqU/ZEJ2XnDhygaw2jh/700YZ0oarPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 21:06:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 21:06:50 +0000
Message-ID: <2fac3418-909c-4e26-a519-f269ede20006@nvidia.com>
Date: Mon, 20 Jul 2026 17:06:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] rcu: drop redundant defer_qs_pending clear in
 irqrestore handler
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-5-joelagnelf@nvidia.com>
 <434ccb30-64e9-47a4-bb08-621632eddadf@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <434ccb30-64e9-47a4-bb08-621632eddadf@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dbc855-378e-4388-b1d7-08dee6a2d139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	g/wIjKtb/7zaqAGmeCgH/eDea8sLNYy2JDYJhwrjPqPmtEXijwTGRR6mQRAsE0G1beixf5GYGQLe9RHBNocz/RHvtkd6YbNOzYP+myKSmjVSxYOrRJyNtbqPw1MdtrTsO3Mr9PdQ5d9f1dxzVjqpiCA8c4CD6aVPHguBuJoCkETDAPOovcqGI5Elum7E6S64vQx9TqaN1uMT2Q7HvPdn4uM3FSPeLX9WN5agnUfrGH8bPkFfUrQUM7akIfQ6F4wp23IQVXs63QoeFKbmEaK4bGYnbSQ1YDTHnqT+iS85CVer8m7vmqE8hqRUUHLj/gWkfGloO5xxKo+ivRCHIYAa/Ki8W5u+T63xbVYaDem3UoKNoDAL5I2Yff9kAoCPfSUH2zdYL+8owMXGXlGJl8aK+i/Y0qfce/NZD+K94LWhjvD1Qx0kMGBxwxDEYK9uqcCfjWlNp1q8YCLNhGJusPdoeNxhhragnWtsCznIO66TM67J45mBRsw+2N6J2Xr8o8qkwuIIT05WHvewIKyjjshikYWNpLhjLcX7cY65QG8HVXr1ddf4flYv4x+FqQQlQeuHyfXOwZf1Z5Rayai1xgRk2DUphtdkmssnSoy4KJIlxi3AaWrcLROP7mo6Z7kI4zCgrMmmUXhp2VCgGnqP2YN+X6MvG1TEKueRbATRkt3jz0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzgzcU05QWJEMDdoelovSE9oYTlhbXNlalNmbWxLVnhWMVBHMzdHN0FwYm9C?=
 =?utf-8?B?TjJ2ZjA5NnlkTEp3SUprV29UMVJ6VXI1Z0tlTmRYUEh0cW9wUzRCMS8wSjF6?=
 =?utf-8?B?ZysrUUtyTVc2S2hjYXA3aEFtMWZIS05GOTBkbG9ZWSt3ZkNvNSt6ZkdOaVdV?=
 =?utf-8?B?bGhTWGtoKzdsY0JKRSszS3BDbGxsaFlZTkR1VHR4bXF0dHkxd0RucFFkcGFO?=
 =?utf-8?B?TXY3MXhFd3ljY3o5Y1VXdnZzZEVpL1FaYzdxekhYQkpWWkpDZmlCU1hkWkd1?=
 =?utf-8?B?WWRwanZZaWdsdVhhWm9jaGhGMVl4RnRWWUs1Vmg5U2s1dVQxUERsUHZzbzll?=
 =?utf-8?B?aVIvTHBDcUpIVTdGMG9xdnh4TG5WNmNnSEJlbDRYMzI0dm5tRGovVlJhd0Zy?=
 =?utf-8?B?NVJxcHppNno4SnVpRWh0VmEweXhQdm1Lc1dvSGJ4VUR1TkhyN3NaQ2poUlBY?=
 =?utf-8?B?QmNmWlV1aDFET2VMWEdjS01YMmJlaDBnUjFrSkxIcjhrd05lWGpJTjV1UUFj?=
 =?utf-8?B?WFRjaCtoZkZ2SkVoQXBtN1BDMlBMNTV6NkxETmFGOG1McW1hY3hLallISmZo?=
 =?utf-8?B?Um5vWlBIMlc4VDJjdVo1bDg2VmxmemdMOWJBYVNQcnp1UlZIYXZXOVdjMWxr?=
 =?utf-8?B?MHU4UkdwOWtLcGx2Kzg2TzJsZVphdk45SEo2QkFJRG9hekRObWlRcVVDempp?=
 =?utf-8?B?QXMzc1JaU2Z4WURwaWxKTGFUcnl0bGRIbmZrYUdIRWUzRXNxRVd2dEFHNldt?=
 =?utf-8?B?TXBJQVArUDNBNmJlZ0pZQVJsSysxemZJM245QTQ1dGxvWndqVHpVVFRhUG42?=
 =?utf-8?B?bksxaHYwVHp6czZqS2tJbStPbGZkWlBoYmtvQ0ZYR2tjcXU1MHJka1pHV3RD?=
 =?utf-8?B?cnc4alJyQkdOQ0RPdy9xKzJpei9oU1JwQUEzSkNabzF4VEtRWnhjNy94b2R6?=
 =?utf-8?B?WlUyMjF1bjBKbmFFZXVscWhSQXFjRUtNNmc5ZXFsRnlXbkJlOCs1K2ZLQUhK?=
 =?utf-8?B?eFdPRUtjOG5XTk1VUzl6T1ZPM0tuVVcyVEc2bnM3ZEIxV1ZRazFUSXo1azQw?=
 =?utf-8?B?NkZBVUQwRk9GUTJIRVBYcHJuMWhjSG5JeHpxaDBKMERyc0o1dkl4NWlUanJW?=
 =?utf-8?B?MkROTEhKQjYwb0lBWHZWbThTNEFYdDNYTlhoY003UFVqRVZxYkNGVTVDWnlM?=
 =?utf-8?B?K0RlMXZQNDdNK0dCZXZ1VnF5RkQvRS8reHFKZjMvcWx5NkI5bEZXczl1c1FI?=
 =?utf-8?B?WVZRdjNja0hPeGNhNHhLTEVlMzBYNm0wVWg3cXkwR1hWMXhMWlM1ckVVUFFW?=
 =?utf-8?B?bnFPOEV2MzgxazJPUXQ5cHFsTzFVWlJpWmF1V2tqNEllY2FKUGpUNDM5b2JM?=
 =?utf-8?B?S1NxdTFVNVF5Y0YwUHhNaG5lVWZDT1BTeHd4eHpya09oSk5mNXZucmtCODZT?=
 =?utf-8?B?elI1Qm1JQTFmeGdSUmRMN1d3ZnhLSjZPTDRXOVJWNzVhVjI2NFVqZGNIaUl5?=
 =?utf-8?B?cmU0RGpsZFd3YlpCMTZkUGE0OExxbExGeTFXZHIwb1NsMnptQXpwREZpd01p?=
 =?utf-8?B?YnpPV0VwUkx6dGZJcHUrUGxIUjNlV3Z3WXJMemN5YkhuclIzaFYwUVpCSFBx?=
 =?utf-8?B?MTcreFk0NThveGl5ZTluSmErUEVDRlRFVU9MRWhPcDhDMFY3dkZDQUxibDZ2?=
 =?utf-8?B?TW9JdmFnM3lQRlJlNU5NVTUvQ1V5RlhyWTUwT0RwYVdTTm1IMWpLMS95NVkv?=
 =?utf-8?B?YmZGejdnNzZCd21RRHJQNUh0bGxYbEhYMFlpcDU0ajZVRUxzSWFsNTZWc2U1?=
 =?utf-8?B?cjlRTnRhZ3VDd2RzRG5EWXFYbzRUellaL2Jxd1lzN2ZYTE5pazd3Q1BHQW9N?=
 =?utf-8?B?U3ZSb0FyV3ZhekR5T2FXaTVWYkxOS3hQSHFRS05nRE1UODFmWTAxYzVxclFV?=
 =?utf-8?B?YWdMK1MzL1lQbjc1WGNyVlk5QTRnaFdXNzJGRVdUZVZheTBRNWErM1FxaVAv?=
 =?utf-8?B?bE5nVzQ2RmNZZldaNG9vVXlkNWVaWXNkdDRyYVdUNzU4N1BJaFpwczhDRFFO?=
 =?utf-8?B?VU1BbHF3YTdMZUNoNUdxM29oN0xwQW12ZnFBbkZSaWJvSkZpSW9POWNpc3Iz?=
 =?utf-8?B?RHk0V05oamZGRUZ3QlU1QVk2SFQ2bFRhQU1leHdsRXlYN0VSRWhROXRWb2pG?=
 =?utf-8?B?NFVFSlQ3aTFSMWl1QzVSdUoxcVlDUGp6OEl2K1BxRFp0ZzkrN241ejkwUHdT?=
 =?utf-8?B?T1Y5bUM0a2JobDEzNWc3emRTQVZKWHpKcjJVUVREUzdxTWh4bkMvVnN6Qjlp?=
 =?utf-8?B?R2F4aVhjU3Q5eDlibHl4RnRZODhITHYxTzdkTjFYQ2E0ejFkOXYyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dbc855-378e-4388-b1d7-08dee6a2d139
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 21:06:50.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuioZW66O1vcL+SNJo1VsFXD55B6vIab+WX8Mgmb7Zfj1L5ZnwfSljl91A79DQJfGlUwAeXw+DZ1MzfxOF1G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674



On 7/15/2026 4:58 PM, Paul E. McKenney wrote:
> On Thu, Jun 25, 2026 at 08:42:57PM -0400, Joel Fernandes wrote:
>> With __note_gp_changes() now clearing defer_qs_pending at every
>> per-CPU GP advance, the per-irqrestore clear is redundant.  Remove it.
> 
> Wait...
> 
> Given your patch 2/8 of this series, isn't __note_gp_changes() now
> clearing ->defer_qs_pending on any new-to-this-CPU grace period start
> or end?  If that was a new-to-this-CPU grace period start, is that really
> a one-to-once correspondence to the need for a quiescent state?

The asymmetry my series relies on is: clearing this flag is always
correctness-safe — a clear can only permit an extra arming attempt (softirq
raise and irq_work); only a missed clear is dangerous, because a stale
PENDING suppresses all arming, which is precisely the bug. So the flag
doesn't need one-to-one correspondence with QS needs. It's a re-arm
throttle whose only correctness requirements are: (a) cleared rarely enough
to keep the recursion bound (once per boundary notice preserves it — the
deadloops needed unbounded requeue), and (b) cleared often enough to bound
stuck-time (the CPU noticing the GP is the natural point, so a stale flag
survives at most one noticed GP). Right now it is stuck forever when I run
TREE03.

Put another way, you are right that it is not a one-to-one correspondence,
but merely that the CPU noticing the start/end of a GP is the starting
point for when we'd need to pay attention to ->defer_qs_pending, so we have
to clear it first (in __note_gp_changes()).

We can keep __note_gp_changes as a single point of clearing (except some
special cases) as this series does, which also makes it more robust IMO.
Previously, we've had issues where we forget to clear the
->defer_qs_pending flag.

Did I miss something?

Thanks.


> 
> 							Thanx, Paul
> 
>> Effect: PENDING now stays set from arming until the next per-CPU GP
>> advance, future arming attempts on the same CPU within the same GP are
>> gated by the rcu_read_unlock_special().
>>
>> This serves both as an optimization (should not need new irq_work again
>> this GP - for the compounded section case, we detect and clear it there),
>> and reduces risks of recursion due to clearing too aggressively.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 7768a40677a4..c37d8cfeb714 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -581,8 +581,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>  	union rcu_special special;
>>  
>>  	rdp = this_cpu_ptr(&rcu_data);
>> -	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
>> -		rcu_defer_qs_clear(rdp);
>>  
>>  	/*
>>  	 * If RCU core is waiting for this CPU to exit its critical section,
>> -- 
>> 2.34.1
>>

