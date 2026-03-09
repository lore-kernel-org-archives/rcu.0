Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BACA4E;
	Mon,  9 Mar 2026 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088376; cv=fail; b=ruMzb15ziYiaBzoR+jSN1hTbOPih2FhABPT78yRv7ztwAOwpVGNkj00xYOJOAQ6brL1ToytuG/tSzczW7h3S4iBrqnWm9w5CZ1SAr7ttjR1wkB4eMDHcydHNpgfcMWxxy0xDZwYQn/4G4Gr/VIWcBKtAk0jggGIGGBPHQ4BWVbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088376; c=relaxed/simple;
	bh=FwVM2G+YeylOyRum0xMXTmaNuVj5i+5wrlMKa7aXo+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7GPVJCcU3VsAwzGP+3BaR6fV2fNML+m/U/8+3yqbReuioBmmhiR9N+9w8iMTN1Xn4Yo3/dELWeERKMVx4B9BqEMjeMEoBOGTJO7J86tLraydeXLK5efMaf5BHiTvM1Ky2hNgtXzCDkEP6K7Rw3bSfjBu6lWHTafY1OlOJtUWic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ThY4c46r; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ThY4c46r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biM1BFyCMCZSHmQlAJQddVCpvFUOWnk6Y4DxjLwoYka0os+geBYIX2mtIjuXYJoLWELf1U6v8DfKblrq5MDbFJCiwv/cHlRJrllGRjHDn9SvgS+M9QtIJ3K7Fr5HTHZ6kcFw5lysW/eQUeeHbhdI1kKJ5PM3P9Xo8yEG/r614/gZ/2jKDFF/oY5BsDsJwMkR1ofPPG1rZfugx62V7op7uhiCDq0cNJfE1hCktPXL01Vvgdl9ITL6oOR8m0SorQeOetH1LIWNg7oEtqf3j9wniAgz1qDex3OkLbKKO1X/2XULVrwjaF6ITLdtI9DdzWqYW9PswHPiITHNL+ZHrm96lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ETgeYswaQ1lxpByOENsGMNe+6V1/LBDw71GDD5dlW8=;
 b=ZJO8CwECL421/GMoHPQicdn+KE48+DhO4KeM/yYSJsk+XME34Fp11msi3Ox5iPmJkKt2sxdpSREwYTGWPbYhSjOBgkvophycdCnqR5Ff+qy3wmeAz2debEmF8VBre/COvYdHdOjDHeCNVHQ4TjvkiCSZnv0pFxEfjRqTC/My2fSvB5mBBr0CLQiUEYgXmx123NJKOdjkYYTKhE6bzVZdeO4nEdDX5Vedf7Q4q43+ng0cxxLaoa3X90oAvK9w6AwgJQlN2TaraPutGgcBEcM5L0x3y1/iOJmmZ+5b8kmnmyr6f6LoU4Ip9w1i+qSEdu7vO/feB4erkZuzFgReV4HT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ETgeYswaQ1lxpByOENsGMNe+6V1/LBDw71GDD5dlW8=;
 b=ThY4c46rCkzwtn4vrNL0U5lweYWlx0JNXfxuBB2Joz8wZhhg9lRl5QP/1uRm7K5sZAc8Zs/FcRVrdAB9NF0irSRqJwX2t2NVZqa0ir19Amx7MLXausMzRFA9/6FZWdoUXBqK+hsAMLPznK1trWDL3hv8KkeJw3rBTWVLdcGIg7C3VhZmUuo6olLMqQSex7ViyRVzChoKxQaYjdiMriyP2EXKpNbC7Qe7zH6kv1xpEhJoW2sYbb02n6IXtTMAj4CtoJSqcvVpQIPdhLQCZabIgJpPP0Q9VFuoUPYnG45MnX/NxwEj4P65369w65bAL07JRe2cl5j2mrUkETq/gvoLQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 20:32:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 20:32:49 +0000
Message-ID: <b900330f-0c77-4eb8-bb11-c3083571ae77@nvidia.com>
Date: Mon, 9 Mar 2026 16:32:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E.McKenney" <paulmck@kernel.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Samir M <samir@linux.ibm.com>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com> <aaliA7sc4Nnu_i_C@milan>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aaliA7sc4Nnu_i_C@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: c8545e1f-5448-4788-f158-08de7e1b07a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	04gdDdjeNBNGZ+uEsi2AHMFZsm1/CtyJa3EzM5Ah3bDayYtbxAjA+hNUGHNH6PlrITYf7eK75iGgtacC/UsajVW9nCwk4cnqJwOcumGqXaDx4AC2ROfeNo18DlPdgqweOtmMdZbgHXc5jQACaNUfDTWhOFHZUb1D9CdsuebcSxdwqpjUJlseUVgN21+2hiXLM9tbRwrMeYoGM+5XqoXI0IkKEpVRXEswb2hy/A1v5D7cmS7rNNOj0odn1yF+K+Oo0FXSj8ZWNvBpuA001T3K/Shl87YK/D7SBekpnUvznuKXQpYDtrqH+jxMzOyzM6RJTDRgGHm2MUUzgTY/BTmdxopp9pgkfHiYMxtolYGGKTz76CoKtjGAQLsSv3J6qFQ6OPkR0BX10UhsRuL51k8UwtfOsz7EJOrZaxj86A5d+Qkcq1NFcRM11PWCIdZgy97LoRHZGliW+zUmCzGfgSfpOwoAy8ghFgWEnnL+QNc5uVjRDoWDj2S9/6s018G0Lx8tGX2csSQ41DOUBucshx4PmBuiV6jfo8BdjnfJGYYF0Yc7PEid2X6SS8ZqnyGXdU3LjUIfDk6DP7t0SytLl/3w3FtqH4XKeN97suCiaq+84zAqX8pazs0PYwU82Y5dUiqQ5dnvZODdqxFqG0nrP9Grhm7qapyfAsA0rjmEz24cdg4chJY0I4vLg6D9u9Q6MOMof4yCjXw3L5JZLFpZOoXF+KP9B9NiwjN3M/vVNSKv/Xw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFDcTJCeldJZE5rWnNjUnByTmo2bzZuSXVVQ2c2M28veE5mNHBiYVY1Q25j?=
 =?utf-8?B?VWhoUkVYczVTWUVtU0xSMXdtOW5kQkVNZjZVLytwTEhBZjh5Q3pmejlXU09P?=
 =?utf-8?B?emVYNGlNRnVYUGNCZ3NqcHE2UnZXRy9ZOE83NHFGZjQ5ZDZLbmFKR1d4UGJ4?=
 =?utf-8?B?dk9nS29NbzBFczhFVWN1OUtUeWNSRU5nLzRCZlMwcU0zdFNyYXlOU2prR1Bk?=
 =?utf-8?B?bTZZVWVqTFhOUHdjajljYUhCWlZncnBUMk9OYmVXRGlrSXV2dWtvUHJqZWQz?=
 =?utf-8?B?RWI2V0J4a0dqenRKcWNyQTRRQS9iNDJsQzNGUjd5QURKV2s0Wll2V0lzMStT?=
 =?utf-8?B?TGgxYU50M01wWTNiajZOOW9JSzZYMUh2WXdoOEFBUTdTazV1TFF6ODZVV3pm?=
 =?utf-8?B?d21Xd0IxK2xHWHhJb0YreWsxQmZ4b1ArVWVmQWRzc3FnTkxueDBmRmZpTWhF?=
 =?utf-8?B?MXhEWXk3OHIxZ3ZubTArYlNodzZDNU85cUhuangyKzlLakpnK0trbHM5NkRv?=
 =?utf-8?B?bEdGNUFtU2FrOWJtZVdqTGl3c3FQeWUxbHA0RjVXWUVoV1IrMGJrZkp0QWlk?=
 =?utf-8?B?eDdYREZKL216WDJZaWZOUGk4c1l0b1d4RUVlNitmSjVkWDVZQmpuWTZ3VkdC?=
 =?utf-8?B?dHR5M3lYekRoV01wbWdSMjBqMmVFaGpOTjhxU3A3cHdvL3VXMEFQMlRWSUZB?=
 =?utf-8?B?d0FZZHJPanBnR0h0UXVHMHRab0dZenlmL3JocWtWU1JKM3Bjb0RaRlFSWXQx?=
 =?utf-8?B?L2Z5Q0hQMzJrK3h6THc0L0FIa0Z4RkowSnhsWCswOUFtdFgybVc2SHdYazVh?=
 =?utf-8?B?MFRDOWxtMlQ4QmdQOW53d3VvK0ZxTTRMUElTcEMyODR0QjNoZ3RJdm42d3Jh?=
 =?utf-8?B?cDNpMmJuYzdCZ3R1WnZwNmh5eHN5R200cFdpMTJUbmZpaG9WUGV1SWIvNDcw?=
 =?utf-8?B?WDk0a2pXQzlhMVBCVEs3QVVUazQ1dVV4RjdjN3RGNVZ5QVRkQmJoeStoSVY3?=
 =?utf-8?B?VVNDdDhhb3c0ZnduUUxCdmtqVm5TR2JIdUF5Mi9KWnFZN1dEVmFSL0R1T0RM?=
 =?utf-8?B?SDV0VkFweGh0bktLQjhJRnN2aTZXcXJjNlF4a1N4bDI0aTBzUUlSTmI0T0F4?=
 =?utf-8?B?aVh0dUVzbEJVS1lNVlg2d2o3OGJBYjczSlBDeXplYVNEZnArR0x0MWwvdnNI?=
 =?utf-8?B?ZzRWQjFGaVRGaVA5YTNNZGZOL3B1MTVIL1FtYnFrOG5ZZEFTSHA4Yi95ZURi?=
 =?utf-8?B?Rml1UEc4MW5WYVNYWW90WjdmMVFiVjZwZWVsaEtGK2VaVzFuTXFFeEUwVkJS?=
 =?utf-8?B?NTduRG5NKzE2WmdSalRyWG5LQzdSc2RvcjVISFRpY09BTDZVUHljcHFsQkhw?=
 =?utf-8?B?U1FQS04yZG80ZGlJallRb2RTK3hlR2Y2OHhUZmpnaVdsS1dvMW1Id2hBMy9C?=
 =?utf-8?B?N2R6T1dwRDRhYmY3cy80SkRoQUkxcjBlak9FMmVCUU45L3lpNURCRkp2M3dJ?=
 =?utf-8?B?RmhQVitoSi9nZStMKzZkUmRadDZScEVBZzE5ckFTcDhTUW50M3NJWkV4dC9M?=
 =?utf-8?B?bzliVmN4Wkw0SE16NWYzeFdYSzY0d25QQzZQY3JWMlZSUzlxK0ZiMjQwNmo2?=
 =?utf-8?B?cG5naHl6WU1hRjFnQzVNbFhVaDQvQ0x5UHZjdHY4YjJsUzQ0WGpUR3drQ0J4?=
 =?utf-8?B?b2J2RWFnVXQ0VVEya0g1RU92SzF5TnRQbGFrTUhoUFRqdFBUTFUyMWs0WTlk?=
 =?utf-8?B?S1RQVW9qRDlySStVbWZQMGEvVDVZdUllbytPM3JmSVF0UDlhWkowZHRpZ1pI?=
 =?utf-8?B?VmYzUFFVZjRBOVJtcVN2aUV3UjVzeTdCeHBSWFpIWjBtWUEzYVBaSm5JczBn?=
 =?utf-8?B?bmRmREw2T09jOEZkaStEak16djE3aEV5RUY0L2VtZEt5YnVBcjU3NmFHVnJH?=
 =?utf-8?B?UjRzWVZ0UzBCeTlwb3AzL2Voa2RlWCtOb21TMVZaa3hnMkJ2ZVcraGUxTVpP?=
 =?utf-8?B?VmZ1NzdoTE01djRXWXViOTlOeU1QZ2c2Rk1VSG13dVJJejJhWUlVcFRpWTNU?=
 =?utf-8?B?bUVEbmE0RjNPblF4NlVISDNpV01iQVZqQU5ZTnZwczlSMjA2NVZHRVNjV0VH?=
 =?utf-8?B?LzBManZqYldocko4QVVsYnpLeHdxMlQvNFNKdXhSQ2hrQm9iTSs1cSs2UDdC?=
 =?utf-8?B?NjIyNVgrT3pkdFNUSS81M25Ob3ZVeGNqNDVnQkxDbVRjbi9SL3ZwQkFxbmpD?=
 =?utf-8?B?ZW9WcjVRSjFzRCtsSTdVZEk2eEd3TTg2UEJJcEtuZ3UzVDNMdTcrMjQ1S3RR?=
 =?utf-8?B?cFJ5Mk5zRHprUFl4QmJpYkdiRVc1dEE2R2ExMUppVnZ4Wm1RYUswUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8545e1f-5448-4788-f158-08de7e1b07a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:32:49.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KClf4zSAhqtAajVD5Uap8VtRXXNWSElSwOqHn9kK54wX4rHVtRdM+yd3NWVZjH16teXjujpUtMZQE/FlErKBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240



On 3/5/2026 5:59 AM, Uladzislau Rezki wrote:
> On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
>> On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
>>
>>>  * The latch is cleared only when the pending requests are fully
>>>    drained(nr == 0);
>>
>>> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>>> +{
>>> +	long nr;
>>> +
>>> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
>>> +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
>>> +
>>> +	/* Latch: only when flooded and if unlatched. */
>>> +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
>>> +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
>>> +}
>>
>> I think there is a stuck-latch race here. Once llist_add() places the
>> entry in srs_next, the GP kthread can pick it up and fire
>> rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
>> in-flight completion drains count to zero in that window, the unlatch
>> cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
>> then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
>>
>>   CPU 0 (add_req, count just hit 64)       GP kthread
>>   ----------------------------------       ----------
>>   llist_add()    <-- entry now in srs_next
>>   inc_return()   --> nr = 64
>>   [preempted]
>>                                             rcu_sr_normal_complete() x64:
>>                                               dec_return -> count: 64..1..0
>>                                               count==0:
>>                                               cmpxchg(latched, 1, 0)
>>                                                 --> FAILS (latched still 0)
>>   [resumes]
>>   cmpxchg(latched, 0, 1) --> latched = 1
>>
>>   Final state: count=0, latched=1  -->  STUCK LATCH
>>
>> All subsequent synchronize_rcu() callers see latched==1 and take the
>> fallback path (not counted). With no new SR-normal callers,
>> rcu_sr_normal_complete() is never reached again, so the unlatch
>> cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
>>
>> This requires preemption for a full GP duration between llist_add() and
>> the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
>> systems.
>>
>> The fix: move the cmpxchg *before* llist_add(), so the entry is not
>> visible to the GP kthread until after the latch is already set.
>>
>> That should fix it, thoughts?
>>
> Yes and thank you!
> 
> We can improve it even more by removing atomic_cmpxchg() in
> the rcu_sr_normal_add_req() function, because only one context
> sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:
Sure, though you still need the atomic_long_inc_return.

But yes, the approach looks good. :-) Do you think we can have v3 ready for 7.1?
I would like to shoot for that if possible.

thanks,

--
Joel Fernandes


> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 86dc88a70fd0..72b340940e11 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1640,7 +1640,7 @@ static struct workqueue_struct *sync_wq;
>  
>  /* Number of in-flight synchronize_rcu() calls queued on srs_next. */
>  static atomic_long_t rcu_sr_normal_count;
> -static atomic_t rcu_sr_normal_latched;
> +static int rcu_sr_normal_latched; /* 0/1 */
>  
>  static void rcu_sr_normal_complete(struct llist_node *node)
>  {
> @@ -1662,7 +1662,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  	 * drained and if it has been latched.
>  	 */
>  	if (nr == 0)
> -		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> +		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
>  }
>  
>  static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> @@ -1808,14 +1808,22 @@ static bool rcu_sr_normal_gp_init(void)
>  
>  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>  {
> -	long nr;
> +	/*
> +	 * Increment before publish to avoid a complete
> +	 * vs enqueue race on latch.
> +	 */
> +	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
>  
> -	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> -	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> +	/*
> +	 * Latch on threshold crossing. (nr == RCU_SR_NORMAL_LATCH_THR)
> +	 * can be true only for one context, avoiding contention on the
> +	 * write path.
> +	 */
> +	if (nr == RCU_SR_NORMAL_LATCH_THR)
> +		WRITE_ONCE(rcu_sr_normal_latched, 1);
>  
> -	/* Latch: only when flooded and if unlatched. */
> -	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> -		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> +	/* Publish for the GP kthread/worker. */
> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
>  }
>  
>  /*
> @@ -3302,7 +3310,7 @@ static void synchronize_rcu_normal(void)
>  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>  
>  	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> -			atomic_read(&rcu_sr_normal_latched)) {
> +			READ_ONCE(rcu_sr_normal_latched)) {
>  		wait_rcu_gp(call_rcu_hurry);
>  		goto trace_complete_out;
>  	}
> <snip>
> 
> --
> Uladzislau Rezki

-- 
Joel Fernandes

