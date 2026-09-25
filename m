Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020122.outbound.protection.outlook.com [52.101.189.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6473BE623;
	Fri, 25 Sep 2026 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363987; cv=fail; b=SYJggZeFE4cWz3iLXUmNab0dE/ihIJwmnJitSJXmtfwlvvn2mY+TJIa3OE1I8Rl6S/hpruzzWU+LL0uAQFhgfXHbl4k7fUZ5HDr79USoRvcn6LATWh5vaMEgJ+lzEXqCFnw37UFclLB3gPi1iIPMrJA266YTkmhWDbwdh85j8R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363987; c=relaxed/simple;
	bh=Ai4Bf5alugn0EjYb42VceTVEW8jEfpG7mT9ykkGZcmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ygkt25ERnH+/ju8yI0kJG/4pS/So+vUBfz8wo+YqevrYXFKnGkHXm8CeoQHkyOfAzQeL47SQovKjHrIChsNC7Db58VbPFk+E7y95OMCodXRIXqzJV4zZJy9CjfS5SbCZDqLJjz3v5aiWBWQcjEsPoDPzQx+rxOTqahfB/suG5hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Qk8wmzV+; arc=fail smtp.client-ip=52.101.189.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Qk8wmzV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyRIXFJx/deXsNBH0Lm39lGo/ULJTD7FUA9dptmxA8dksd89mBZINe8TguMNdoOIPgtPQ1ecLpVf8G0Ry7prxCX+PI7XouJtRwiuhDy8rwJJXyjkW6RRjl4Nriyb7HlekvnHlMaE5yq/wan+qb4ELoh61DsaHjEgm3M0EZZr1I5HP4P5KMDDdQLAeZiU177R4MwPgug9ShgmtNoB/PJpPPzwMvrYIXazTLNt3z/yhoZ3y8eVzqc/iTasNxqVhmqh+JTcjFK9p+P7k3L0clOgy72Yh/5TSHgIsD+zPObeTCZ15wJkD8P2h/+kfsJKd7gBTCEkFJ72ZXfGrYVIqeqE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAXtzg/7gFCvt0NfWsl35avysRxZ5+njdscHxC2mx7c=;
 b=iEGqY6K8aKBLZ3+8A8L4GXRmlKiCKrYKywYCAjw8O48j3AbzLSkUz6uISyFkOfDHw29f4KTTaSKF+a883nSYnxQ7EZh88WDbRIJZL/Syha+b6ch50G+nNLb9PNBaE5hxF8Yq5tCLg/Jdw/9qvyUHRmGpBqTsUIPTT274fHsCbJb+QyQr7mjisLcFtfekS+9VOuYHQRn8LqZiw6Qk7Vq/lZ1+BIcb1BfssjHPCHOyqCEEoe8bOYgPBaeISZPWUoZNThnCgzdi44niR1lePJ986gJisUOvrB88vRQCduVeD3PklX1IoyA0h2K3fhAkIiaQHiySjCuNaCX/yoPottTTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAXtzg/7gFCvt0NfWsl35avysRxZ5+njdscHxC2mx7c=;
 b=Qk8wmzV+E+PKLNF2Oj4mqKcaDWhXQK2SzqVFRyeAc+pTk6xjK5LR/TUiWrPg53tAzZYHI4gEo1a7+B+05FDDD0VdRJ9kZF+NkSSaU5PxEkWyNf0AHQGX46sfXfPbKW8Jfnm3F3Iu7Qdhy4f7RbP+drkftVnBomiYl7ply+DiQPidNucXwjQPjSKwMW35xjKEEpP/zKnp/zNEq0cwDJ7L1p5uGybf3g73ZZ6yEpmfVyTPZUlV2A7u+8DnyucDCOTYNXomNV8v4gvoh/mzltwdKTh5L1TCgRvsnBaUSzVtNu1eTR5764EvX/GUSCVpECcL9ZsfXP0MSi6GxB9zcYt1sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9692.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 19:19:41 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 19:19:41 +0000
Message-ID: <4da27ea8-6f1a-40a6-9be1-8bbd474d8367@efficios.com>
Date: Fri, 25 Sep 2026 15:19:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
To: Gary Guo <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, Boqun Feng <boqun@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
 Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>, Bradley Morgan <brads@mainlining.org>,
 Bradley Morgan <include@grrlz.net>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
 <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
 <DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0494.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db4d07d-8dc8-432e-086f-08df1b39f337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V0l1HbNSdmhoTmrq69ysebB2ZmSMnT4kwNY7xF6q8JQzMoV3NSFuhPUwx6+FgffqgrawIC1iy6w+iWOfjJtvTHrF/YRFZLE9vW6wqIl8oUrPZdFTWPAj2P3SY91K7/lsesRxbqJ5EMItTje3tebnSD4jWOhsARcErr9ZmXiGigU2isYtLV76RnJzIUyGWm1z9CWYgCA4MnngD0sKtj9lRXLfigRmaZ2+XmpKsVjmQGQp1iL7IUvfmpmb78ZkmjfRclSukn/vMc5erK7pg/kMX9fng/GN8KK1yCSD/oFdY2jF/exbBKHNfgBlex183RKhIpz7PWCtWM6vxANKvROVzBMxGOjWWcjlXCGuzf6f086UMVbXQT/JatvqmOomthhUdpIU8m4f2KSjB83nCu5rk6mHI40ceoPX8fiW5l5ju3SH1/HSn2RzLOuUsYl5JjLiFiLxdBQNbt1W4BgX3StNjaogAWBRyUBwV/vbC4qXRfdmpmlQSX8U2fX2vc5Gr/HiiFGYleLuzj3OLJ9EM/smvErzIlcn/3420Vfd7Ss89GM/yrXDJMIM1ul4kcUGGM221NOyQAjr/W5Kqee2O7+iYvQHgZ4ZEpqzD8C6VVc0sRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RCeFpFNUZtRVN2ZlpZNm1JL256UnFSV2JZS0d4M2MwS0pLNGxhU1lubUVm?=
 =?utf-8?B?OVhkMGtENjlETU1aRDdqSTlyT21OQml0eExXb2RiQVhUejVCT0lmTUtMMWU1?=
 =?utf-8?B?MGxXOGN0OTByTHlvUmVBSDBSMDBlWmM1czRWdWJIZkhQZDZwYUpPNE5QVEUz?=
 =?utf-8?B?T3RJZ3pwUTRaNlhaVVdHM1BVVzhES0tqcmEvaHFESlVMcjd2bE1JMEd3dVRt?=
 =?utf-8?B?eWlybzFFTnJzaVVuQTdKRDNBZVJWLzFOWjlzZ3BHVFJkVHZZcitHR0dUY0Fn?=
 =?utf-8?B?czFpcTJLaDJPbllZUk5vUFdVY2ZCUW41UURLWDcrWWRCRlh4WVQ3MVdNL2ZP?=
 =?utf-8?B?VytIdmhUcGhGZ3QvQVVhcDRILzViN3lFMHNCN1d2M3pMTGk0cDYzTWtpL1pl?=
 =?utf-8?B?OW1UbEl0cUpmbTgvZDN2Q015WXltNm9aSjY3SmVxdExhbGlzcnBQYTUzeHp0?=
 =?utf-8?B?d01XUWhTdFVUTHJRd0NOcVJ2Zk1CUUFZQnNyazdTT1NNL2N2U3lnMlVFRDJG?=
 =?utf-8?B?SjdKV3duTnYxTVY5YlhnSDJPZlJMazdNTnppdlp3dzgzSzAyVlNFSlhZMzlR?=
 =?utf-8?B?dFZHb3BMWWt3SFFXM2ZnV1lOdVlQUGFDRXN1dnVneUc5dkhXOXZvQ0NkVTR5?=
 =?utf-8?B?TlFldmhhT3MxU1ZXeFdkR3hYRkY5OW0yaCtMbU1Nc1ZiM05iY2ZuSjVpQ2p6?=
 =?utf-8?B?bnRVRTg0SHM3RW4xcXB1cjZ0RU5oUkpYOGFXN3Zkdm1pNDNTdC9KQXpBTHJo?=
 =?utf-8?B?WVpjcWhoam1hMCs5djR0NllyV2VTMHNpenNBTXZZTExEbkhsdkp4OWJOQWtH?=
 =?utf-8?B?ODYwZU04Y3J1cy9sSVZrWWkwTXRkTkQxNHZMQlNHL2d1Skw4cHpvSkNadm1l?=
 =?utf-8?B?Qk1pYjFpWncwSkRzSjMyUUV1eE5vYllTK1I5ak5raFAvUG5VU1ZPMGFyYzdP?=
 =?utf-8?B?a1RKSmpNSUpUd0NMRDM2QWg2NWNvNzhlbVdvME02UEtVQU81UGREcFFvR21F?=
 =?utf-8?B?WDZhMURoa3lQU0RESGN3b2dKUHdEekZHREVxNEhCV3I4dHFaVDhmTTFEc29h?=
 =?utf-8?B?WFZkb2kwaXJITGZPeU1qRENJKytoYnhEcWNTb3VQaGdINDZpTHZIS1JTT3Rm?=
 =?utf-8?B?ZUxFaG1ENnQ5Vk5lVS9pa0piWlkwR1Q3cUV2ZWhIQ3BkSExCNVBleGRJc2pi?=
 =?utf-8?B?cXoySk1FemN1RXBCNkt0eHN6R0NGWklmSk93WEx0Qkx0ZGVGcGd3eFJxNytE?=
 =?utf-8?B?dW1BRCtkbkFYbmp6YUdYVWltL3NJU05WNkZtQ0svVVYzWThJRUYrK0w2QzM5?=
 =?utf-8?B?OWJEUUFOUnhPWGpPUzJnSFdVSUtuQXltTVhrNzAwMW14NUFYTkRYb3BJcXZp?=
 =?utf-8?B?cFhkSGdaNDhabWgwOFY2UDlXdU1aMTMwaXRucTdxdy9aUGRFWWtaMDB4QlB3?=
 =?utf-8?B?OU9SK0VMUElhUEtxeUlmbzROQ1NTTjltZUk5dzRadzJPL3RkaFdkdEdvNTFn?=
 =?utf-8?B?a0Z4V3EyM09yUHh5TU9TSUpDV1g2dUpsLzZOMHd2SzZHTktuaDlBL2RjYVJH?=
 =?utf-8?B?akkxb00wejlNdVZWUmdGeHlxcFJaaHVaazlBb1htSUpoVWxBaWpuVFg1VGlY?=
 =?utf-8?B?Tm1FWVdYU1Qrbm9PTG00Nzk2eFA3Zkxva0VRRmh6NDQxUGQ0cWZkK25qd2dl?=
 =?utf-8?B?NFVCOFZZZHY5QWJjQjg0R2ZYakQxYld5TkQ4eEtFN0NvV1E3NEVlYmwvK1hX?=
 =?utf-8?B?Ylg2NHhmQTgrV0Z4N0FFWk5QdDBnQXVsMXRCZEFydk1BbUNRdk9vQ0RQbUoy?=
 =?utf-8?B?Zmd6MHVVRE5HcHM0bUEyenVvLzR4MmpuejlwOEIwRDV2OWQxdVh4Nm1sL1E2?=
 =?utf-8?B?NDJnUjU5YkFIaElOSHJleXh2Q1dtd1REcC9jcVhqNlZFN0F2cWd0dHhLL2NF?=
 =?utf-8?B?M2p2RG8zekkvK2tmSVNoNkZEMDNBeWpBcHNjMHo2OTA4dFJBVFdSZ0xTMkor?=
 =?utf-8?B?Qlp4WVRqbk12K2U0M2VCZFd6eGkyUXQyazV3K1pEQkRLR21sam1XVjhaSjg2?=
 =?utf-8?B?cEg5R3E1WW5lNlNsRFI1b2FvdE9aT2VlUTRIKzg3VUxDUlBvUVQvdkgyTzky?=
 =?utf-8?B?RGNoS1N5NkxMZkZmKzQ3YjZnRmRFRmNMVzZVOXMzenpia1g5RTZ0Skx5WmxY?=
 =?utf-8?B?c0gxZWhSMHlHMjFtTXdQdmJQdTRlSzh5WldqaGlJbzV0RWZMeHYxbDA4Y0or?=
 =?utf-8?B?SGMvU1Z1MmJ1RGZYVmo3dnF4QnVHb0o5SitIQU44eWd5TXBoYms2U2ZPTEVi?=
 =?utf-8?B?S3NLZmR1b1lpT1NOY2hyenZ0bWVHWWlud3huUGtuYk9DWmhITFpZSEFWZUJq?=
 =?utf-8?Q?oXrOsT0RGlLL9WYg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db4d07d-8dc8-432e-086f-08df1b39f337
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 19:19:41.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iflh0kRyL2vC/cKaxlKMLKhP5SHgWa2iLuMKamXtZh/EcXE8jbCGaYAzjSMTnJWTsI2zd5vLmMxU4tWzx4F5bezv/nvn4PbNzrmHEGFd+/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9692

On 2026-09-20 11:57, Gary Guo wrote:
> On Sun Sep 20, 2026 at 4:44 PM BST, Mathieu Desnoyers wrote:
>> On 2026-09-20 10:46, Gary Guo wrote:
>>> On Sat Sep 19, 2026 at 1:00 AM BST, Paul E. McKenney wrote:
>>>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>
>>>> Implement a two-phase wildcard scan to guarantee forward progress of
>>>> synchronize_hazptr() even if there is a steady stream of ill-timed
>>>> readers which populate wildcards into per-CPU slots.
>>>
>>> Hmm, I am not sure that I understand the problem here. The per-CPU slot is
>>> scanned only once per CPU, and patch 1 already introduces flipping of the
>>> overflow list. What prevents the forward progress?
>>
>> A steady stream of readers acquiring and releasing various hazard
>> pointers happening concurrently with the percpu slots checks, being
>> unlucky enough that each of the slot is constantly in a "wildcard"
>> state, thus preventing forward progress of the synchronize, just with
>> a steady stream of individually time-bound readers.
> 
> Oh, so the issue is that we cannot progress over a single slot, because with
> ill-timing a new iteration of the inner loop of "smp_cond_load_acquire" could
> see a new reader while waiting for the slot to be released?

Correct.

> 
> So, in essence, the flipping is used to prevent ABA problem on percpu slots?

Yes, specifically an ABA which could theoretically prevent forward
progress of synchronize given a steady flow of hazptr acquire/release.

> 
>>
>>>
>>> I think having a shared global read by all CPUs sounds really undesirable,
>>> especially that it gets flipped for each hazptr_synchronize -- this means that
>>> in the pathological case where there are a steady stream of hazptr_synchronize
>>> calls, each fast-path hazptr_acquire will have a cache miss reading
>>> hazptr_wildcard.
>>
>> There is a straightforward optimization we can do if this happen to
>> cause performance issues: only do the flip when the synchronize
>> encounters a wildcard retry delay beyond a specified threshold.
>> So we ensure synchronize observe the absence of both wildcard
>> values in each cpu slots, and only flip the current wildcard on retry
>> delay.
> 
> Another option would be avoid using WILDCARD if possible. IIRC the wildcard is
> used to ensure forward progress on the reader side, so it avoids the possibility
> of READ_ONCE(*addr_p) changing before and after protecting.

Using the wildcard has a few benefits:

1) Prevents this retry loop on the read-side.

2) Prevents comparison of a loaded pointer value against a re-load of
    that value, which causes issues with compiler optimizations (I did a
    ptr_eq() patch in a prior version of the hazard pointer patches to
    handle this).

It does have a downside though: given a very long preemption by a host
VM, the guest VM could technically keep a wildcard present for a long
time in a per-cpu slot, which would prevent hazptr synchronize from
progressing for a long time in the guest VM kernel.

> 
> One option would be to first use the typical hazard pointer impl that read the
> pointer twice, and when that fails, use the wildcard protection. This would mean
> that in the common case where the hazptr_acquire does not race with a pointer
> update, the WILDCARD protection is not used at all.

So your idea is to use the hazptr load+reload approach (with ptr_eq()
check preventing the compiler from removing the dependency on the
second load), but rather than retry, fallback to the two-phases
wildcard. This way, we get the best of both worlds: guaranteed
progress for the read-side (with the wildcard fallback), and typically
we are immune to long-host-VM preemption delays, because the
wildcard fallback would almost never fire.

I like it. What do you guys think ?

Thanks,

Mathieu

> 
> Best,
> Gary
> 
>>
>> This would prevent the common "frequent" synchronize case you
>> mention from causing cache misses on the read-side.
>>
>> But I preferred to keep it simple and wait until we hit this
>> level of synchronize call throughput until adding that extra
>> complexity.
>>
>> Thanks,
>>
>> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
