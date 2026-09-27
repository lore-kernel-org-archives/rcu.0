Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022136.outbound.protection.outlook.com [40.107.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816293B14D7;
	Sun, 27 Sep 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526457; cv=fail; b=GZQK8QB+FzO2OSVbx+FEK9v3cn/6cgL7rmxDuaiD5DFf1RxnrDCtXVnTNjnEE5CtkZootHSS5v47KR3TEeGY/HQFg/4tfsngUVhkwR2sWDTtF4gVw6fPd76X9vvVWR+btcMkRJOpf144jmBI+ux5M5TqH0/2jvL7HzBumD8aPh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526457; c=relaxed/simple;
	bh=t+gZikHr2b0SxqzODkvKo7Y+Nq4r9fQrSC1YBqG54Co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XW+X7rTeU8AyMobZ2Gzfb8aBSn7sbgo1gFcmuivTzj/lRSfsn89fvsN4OVD4fjZPtID88fAm7M3vbazSVq3KL7t6J539006mKQjMSvtOOlc45XvF/3UBfWQnOsKkndITQlkamg3Poyvsp04idRlKtoj3FiI92hp0P6Oh2cvis9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Ujy2hzT/; arc=fail smtp.client-ip=40.107.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ujy2hzT/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z45DKTmaqBTBWQgvtPkf+oapqepaD1SCVCs2aAU0N3Viw9O4f9flo48De8eKLF61bHF2BJuEEy24eZf/7hjURXpB2GSpMrr60FNyINFuBRwczEXY1JrjMP3b8Aqw3O0dqO4MVEBGWOigCsQKfrnUky8J/qXZm8CQKPrDbXdXe4zBIoS4dVMZcgl+Mexoj9E4TSxmekAuOqAdGJ4Vlc4dNq+9O10YdXAlkLEeZ2yt1by3ROt3uUBLTQsjIO0KGTYxCkDJ+1z3k3mKu8Lnnb8qXySiFloQH3NA+YQMF4r6IOMKaEiCl9vw+IlEVUQ6vWPz6cRjSyEWL9ybRDVV8RsFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqzsQInpLMhntYHHHKaQRpo4qYC4juUjQzUjTKvJrMc=;
 b=ju0x7NYae5CImXP061ytz03lyyUaJGew4vi/yB/ECkZZSFMI78KHUbTwjLO1snEe2njykH2kboPxRV6CNDlu0q6w2bUxfyklk9V4dQHfeTZxY0p/y3dKWsw5o1ILHOpwDw+uGUY/j0xpWHXA38rj9KFy7Vebx5JVslkFmOJehMamza0ueQpQtObKGGJ+I44V35Kutncwqn5HJCrS0sYuswNO30+LBb8eF1vWxBnd8c/Ram0gq2VLKfLFE6cAvYLMXUjOnSWk7RQnr5IG0swcbN5eM3QVMna+teB72+OSiZmHo7SMmFfxuicF08WW8M1lCMYvQdaItZz6DHAN1BQ30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqzsQInpLMhntYHHHKaQRpo4qYC4juUjQzUjTKvJrMc=;
 b=Ujy2hzT/JPaFV+3bbHFS9SBTwKkWFwLcwjy3JWTlH5WbtAnnRNCnrWz5cQE6DopHzu/M9WmDN2nUASnqbKFkf+D4n0q/APuU4AUP8CujJwc23Z2HWsJVqimlREW2nC6VZoY85csapX5dkUlZW+JIWdi88lsLo6HThMIArHuTEyS6Q2XS68u7rAaMKqJxqqcdIgfquHX7XlmTVCYkBWlmJyUgWBrN3beJwmJVmSgIAlpwWOAQe8hlD4vAz8d+h4g9GQO2se12j6L4lrJuze8Y+zbucNdfbY0X/sXdu+Uu0kN107ln+ZffCeGb7SA79DCVZO8cYnCxPWc7fFOIdWY2wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB11570.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:153::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 16:27:34 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 16:27:33 +0000
Message-ID: <89cecc9c-f29b-46d1-804d-c87171a445f0@efficios.com>
Date: Sun, 27 Sep 2026 12:27:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
To: Bradley Morgan <brads@mainlining.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <EAE9B584-7CEC-46AA-AC8F-A06F11073763@mainlining.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <EAE9B584-7CEC-46AA-AC8F-A06F11073763@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::22) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB11570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be9ba50-d286-4072-5cc5-08df1cb43c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MiZTWmNIKR1KfLE2xNQOzLmee9hy2lSBbu/v8OiWLlm1BWdoBthKPDst/PYcSmVgW30EGksPA8WDeZJ+AglKsweuTbtQfGiveDqlJREyixmjlUdy4+Z7nDjdZdrvzttUZbMw6gsciKjGZ8C7R251lk/I0TFpHPIIGwP70R2NFSkU9oZixLGU55f/1CzwZf2aSlJrTsb62jCLKpVBlypivMG0/pLMrOJxZZgmU3dKUY4lPvsJVH5uIDIyVyyJsAb7pkprA6TURuslhhP72G139nu7QGVqhTFQtvwsu6gW9ZRf61Fch9LIoN1wGDGUh2hmHofW/fi6TSGb46v8PBDaut7WLaRGneJSPUcQ/2uKHdz4SgnwodzJ8GspoyCOHkszvMX40p3aiwEfvqfmrpeh72u0thhj5vOtrnOS980u2hAJlRrgl04Ty2UpVjloKW/EjDjp9j2s7eYbrCG+7sq5OoIwBY3yt7+JxBMwE6B9/3eaS0yUawFIjUOYxwxm77m4w2EGZ3MYQW/x4+49nDyxk0J+aREQWUf3ZqQn0JJ+zHKjhCRRf6wbVZgzKHTDT9t187v4FTFCTvScVP7+IX7hlZCo7QDUmAYh2KT+dCWWaCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdOVEV0NGRPOHNYTFhSZGt2dEpSM3lmOFhzQ1Z5akVPWkFRYXlMUFRhUzhD?=
 =?utf-8?B?c3JKVEd1akFKendTQnlnbkhuWlNOYXdJbGFrdnE0VzNhckFucWlzQmp5dnM5?=
 =?utf-8?B?OTI2OEZHb3FKSGVRV1Z0T2wvelFzMDBTeTlqZ25hWHFkdCtPZWJjY0hvWDM3?=
 =?utf-8?B?a05LTGwrMk1QZnR2U21qZlBnZDBNTVBETU5zc1liQlR0YVl5MnJzRm5uWVZq?=
 =?utf-8?B?amJKNW90c0RzYThzelExeCs3MTBtcmc3U1RUMFBNSE5oOHQxbWJHaFFodFRk?=
 =?utf-8?B?WFFVa0xNL2ZaZ2xJTGhIbXMrU1I5SkxObGVWbUdld0duUVIvWUU1bjZTYkhL?=
 =?utf-8?B?ck1pMFlkb1NPM3hZT2thUXRJbGlCbHVhM0ltZGlDMkF0bEFzUlRwS0NxdzAw?=
 =?utf-8?B?d2NzTmkvWGxGK0YrMkIwcjZ5WTYyS1N1YkE2cnpBT3hJNkU0aVArRnBKekNw?=
 =?utf-8?B?UGJaZG93bU5mRGdJc0lFcnczZk1obDFaKzY5QVZPbGJZdUs0a1VyaUNZK0tJ?=
 =?utf-8?B?NnRObDZwdzJMYWN4MWtwbngvb2RCSHhPR2lpVUJyTk90TnN1SE9sTGgzNEFG?=
 =?utf-8?B?R1NJYThFRlYzMGVNV2FBM05iaXJmVFhUSkRINHZocEVMVGpENkx5Y3FSRnE5?=
 =?utf-8?B?ajE4Q3h3SUREL1hpbFhxUWJ2eFFWbTZNSzZnb0hCdWJPdGt6QXo2SDhKU1Nr?=
 =?utf-8?B?WS94bHJLaytVYXZ4aDlRY0VpQWNQajNCZG5QYkwwbUoyZTVuMWhHZEVyYm9a?=
 =?utf-8?B?RCs3Zm52aHJDSC9zVGhyZlQycEliNElwaDBpbkRSSDNGMFVVYmdyM1JSK1ZE?=
 =?utf-8?B?M29udHFVRStabVVOVmZXZFN5emdaYy81bEphWXVub2VpUXRJcWFGSi9rb3JR?=
 =?utf-8?B?dVh1UHZDOFpMWnlvZGNGcE5yREltYW43TlNWR1N6RkkxdC9aRWxpUXdxVDlq?=
 =?utf-8?B?bU9WQThqRXd0L3dGZlROZ0NaTGJZck93ZmVtQy93K0puU3lOMUxsYWVEWTZ0?=
 =?utf-8?B?SlJPNDR4Y1RBNU5DRFluRWdtZVUwZnJobFZKRkJWcU9Nc2FuVjdmMThmUkZB?=
 =?utf-8?B?cHpDM2NrZHdKUVN5VHphK1MzV1dMUlhOejRDSktLN0hrYlYvUkk3NE9IWmZ6?=
 =?utf-8?B?UDF6ZU9Idk1VTk9nN2RML0JiSkdyMXd5dHJZWWluTm9HMFZnU2l4b3g2K1lk?=
 =?utf-8?B?c0NpbkdPVWhnMW4wQ2pVUVFKNlpsREpUNTRTOG0wQ3Fxb0RMajdNSER1VENH?=
 =?utf-8?B?UXdkbGNCQ0Z3Q3R3VlNlOVp5dmp6YmJwMG9WNTJadUh4cXZRZjVSRE5aU2RS?=
 =?utf-8?B?Lzk1bXpJQzcwdWhpUk1pYTFhbVdKV0ZERDFZcDRGdGVVeDA0NElIa0Q4QU93?=
 =?utf-8?B?RWtNaWtyODh6U1duYmlzc3FCU2N0Ty9HVzNBaVZsdFR0dGN4M0Y4U2VlQXBl?=
 =?utf-8?B?VHd3dmNEcE1URGVqRDZYMTdKQTNNcjhnQzB2disrOWNjakpDQ0M1NXRmYk43?=
 =?utf-8?B?RGNITXVTN25CT1VPaDdYaXZ1V0dVdURKd2R3STZrMXo0eEVUVjdLZmdJLzNU?=
 =?utf-8?B?MU9PM3dpWitIUmQwcjdsekRPS2d2VkN0MHFrUUhCRXZIRXYvbzE2VWllclRV?=
 =?utf-8?B?RU1wdHp6NzJISHJmZEY2MWRmQzQybkNETmdIQ2N1T25UdVc4UUN4elpOZ05u?=
 =?utf-8?B?WGJLeWhnbnh0Wks0MVRRM1ZqajNyZGhjK0N3eXNzSk84RlJld2Q1ZkQrN2F1?=
 =?utf-8?B?eGNuTHZaVzFTRW1DYXYyTHRkd2ZCczhhV2RRVGpTN3lhNkNrcHZnSEdibzRl?=
 =?utf-8?B?aG0rbDdWWGFieGN0YjVuRDYxZXAwc1dQbjFqbVMySGVOdHRhYVBCQ3ZBUHRs?=
 =?utf-8?B?TTBxSUxpUHdUVmhEcVlLN254Rkg5eERHZDczRk9KSXhvbmtNYWNXS3pnQU5E?=
 =?utf-8?B?elQ0L2NScE5nbm5XOFB3NURCdnJrQjRVNHp0LzJEeU5nbkY3M2dJRkFkU1Ex?=
 =?utf-8?B?WnBZZU9lak1WS0NIM0M5YjFQT1kzSDJFOE0zeVhaMmNQdTh3T1BkMm4wZjUv?=
 =?utf-8?B?bU1WK2t4NnExcSswTlhTUFN1Skx3aks1Z2dXRVRlS0liOHQ1YnZuTk5BQ1ha?=
 =?utf-8?B?UHp5bllHSXdlcEZDLzlLQ3pGcHRZQUs0RmhpSy85bEc4THl6djlQb1JYcS9E?=
 =?utf-8?B?MEdmdmMzRFNlRjhpZXlKTDlxNUl1L0YvUHhhOWxKejhjOFpXVCtUR0N3ZElW?=
 =?utf-8?B?T1A2WndEZXBWMThtSXhxUyt2dkJOYmhkOXJrQVplYTdJUzhIS3IxZnRBSGZs?=
 =?utf-8?B?Q3JmZHBZZWVJT29JUENvN3p5MlNWOHR5aG1QY25MRWozK1NOU2p6ODlRT3dk?=
 =?utf-8?Q?3Cr6LNULza+DiN537zBAa/+73xU/CoHiVZ67amWEwIT/E?=
X-MS-Exchange-AntiSpam-MessageData-1: f4+IV4KS//QicqqgkI99ykaO3t+l2gXyJxE=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be9ba50-d286-4072-5cc5-08df1cb43c21
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 16:27:33.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHA8iooM0XMZkCFB0jDs6XshOj0wMimLJmx0G9CgyQw47UYnMlnWaFqnxBhcY/XnJXU2nZkvHrfYaTW45ZxnPCRtlQ2RudrzwRPSENQUIEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11570

On 2026-09-27 12:07, Bradley Morgan wrote:
> On 27 September 2026 16:51:27 BST, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Hi Paul,
>>
>> This series applies on top of "hazptr: handle NULL address in
>> hazptr_detach" you have in your rcu dev tree.
>>
>> This first patch addresses a race identified by Boqun Feng in the
>> two-phase wildcard scheme.
>>
>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>> Those were discussed at length in a prior version of hazard pointer
>> patches.
>>
>> Patch 4 introduces a "try acquire" helper to allow the fast path
>> to not rely on wildcards, while keeping the wildcard forward
>> progress guarantees in the acquire slow path, used on fast path
>> failure.
> 
> Hi, here is a hazptr perf test on powerpc
> 
> REAL kill_fasync(), ns per call, best of 3, 100k calls:
> (stock = rwlock walk, conv = hazptr walk, same v3 tree ± the conversion)
> 
>    shape          stock    conv     delta
>    1 node,  1 walker     59      59     +0.0%   (singleton: identical)
>    16 nodes, 1 walker   539     539     +0.0%   (uncontended: identical)
>    16 nodes, 4 walkers  509     134    -73.7%   ← rwlock readers contend
>    16 nodes, 8 walkers  313     113    -63.9%   ← same list, 8 cpus
>    64 nodes, 1 walker  1979    2039     +3.0%   (pure walk: hazptr tax)
>    64 nodes, 4 walkers 1914     509    -73.4%
>    64 nodes, 8 walkers 1015     382    -62.4%
> 
> Its SLOWER than rcu, but beats rwlock

Two feedback points:

1) The comparison I think Boqun cares mostly about is with expedited
    RCU grace periods, this is where we suspect there is a significant
    benefit to using hazptr rather than RCU to eliminate those IPIs
    on synchronize.

    It's good to know that it performs better than rwlock (albeit it's
    not surprising).

2) I'm concerned about what looks like a use of hazptr to protect linked
    lists elements in your benchmark (did I miss anything ?).

    RCU read-side critical sections protect all elements of a linked list
    naturally, but hazptr requires more care. See this comment above
    hazptr_acquire:

  * This protection is unconditional, and has limitations similar to
  * that of unconditional reference-counter acquisition.  In particular,
  * although holding a hazard pointer prevents a hazard-pointer-protected
  * object from being freed, it does not prevent that object from being
  * removed from a linked data structure, and does not prevent other
  * hazard-pointer-protected objects referenced by this object from being
  * both removed and freed.  At which point, invoking hazptr_acquire()
  * on these dangling pointers would be a bug.  On the other hand, use of
  * hazptr_acquire() is safe for immortal pointers to objects that do not
  * themselves contain pointers to hazard-pointer-protected objects.
  * Other (more complex) use cases are also possible.

Does the pointer you protect qualify as an "immortal" pointer, or it's
a linked list "next" pointer ?

Thanks,

Mathieu

> 
> SIGIO delivery, plain mode, 8 ptys 1 listener each (identical harness):
> 
>    BASELINE (rwlock)     472/s
>    CONVERTED v4 (hazptr) 452/s   ← singleton fast path: gap 12% → 4%
> 
> With a few changes, it was 12% slower than rcu before.
> 
> Do you want those changes?
> 
> My idea is, we find something that would put use to hazptr, here is what I
> tried
> 
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index c158f082f1da..bb04076ff6d9 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -17,6 +17,7 @@
>   #include <linux/slab.h>
>   #include <linux/module.h>
>   #include <linux/pipe_fs_i.h>
> +#include <linux/hazptr.h>
>   #include <linux/security.h>
>   #include <linux/ptrace.h>
>   #include <linux/signal.h>
> @@ -1009,15 +1010,20 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
>   		if (fa->fa_file != filp)
>   			continue;
>   
> -		write_lock_irq(&fa->fa_lock);
> +		/*
> +		 * Make the file invisible to the walk before unlinking,
> +		 * then wait for any in-flight send_sigio() to be done with
> +		 * the node before freeing it.  The walk holds a hazard
> +		 * pointer to this node, so it cannot already be freed.
> +		 */
>   		fa->fa_file = NULL;
> -		write_unlock_irq(&fa->fa_lock);
> -
>   		*fp = fa->fa_next;
> -		kfree_rcu(fa, fa_rcu);
> +		spin_unlock(&fasync_lock);
> +		spin_unlock(&filp->f_lock);
> +		hazptr_synchronize(fa);
> +		fasync_free(fa);
>   		filp->f_flags &= ~FASYNC;
> -		result = 1;
> -		break;
> +		return 1;
>   	}
>   	spin_unlock(&fasync_lock);
>   	spin_unlock(&filp->f_lock);
> @@ -1056,13 +1062,10 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
>   		if (fa->fa_file != filp)
>   			continue;
>   
> -		write_lock_irq(&fa->fa_lock);
> -		fa->fa_fd = fd;
> -		write_unlock_irq(&fa->fa_lock);
> +		WRITE_ONCE(fa->fa_fd, fd);
>   		goto out;
>   	}
>   
> -	rwlock_init(&new->fa_lock);
>   	new->magic = FASYNC_MAGIC;
>   	new->fa_file = filp;
>   	new->fa_fd = fd;
> @@ -1121,44 +1124,51 @@ EXPORT_SYMBOL(fasync_helper);
>   /*
>    * rcu_read_lock() is held
>    */
> -static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
> +void kill_fasync(struct fasync_struct **fp, int sig, int band)
>   {
> +	struct hazptr_ctx cur, nxt;
> +	struct fasync_struct *fa;
> +
> +	/* First a quick test without locking: usually
> +	 * the list is empty.
> +	 */
> +	fa = READ_ONCE(*fp);
> +	if (!fa)
> +		return;
> +
> +	/*
> +	 * Hand-over-hand with two ping-ponged contexts: the next node
> +	 * must be acquired before the current one is released, but a
> +	 * hazptr_ctx may only front one live slot at a time.
> +	 */
> +	cur = (struct hazptr_ctx){ };
> +	nxt = (struct hazptr_ctx){ };
> +	fa = hazptr_acquire(&cur, (void * const *)fp);
>   	while (fa) {
> -		struct fown_struct *fown;
> -		unsigned long flags;
> +		struct fasync_struct *next;
>   
>   		if (fa->magic != FASYNC_MAGIC) {
>   			printk(KERN_ERR "kill_fasync: bad magic number in "
>   			       "fasync_struct!\n");
> -			return;
> +			break;
>   		}
> -		read_lock_irqsave(&fa->fa_lock, flags);
> +
>   		if (fa->fa_file) {
> -			fown = file_f_owner(fa->fa_file);
> -			if (!fown)
> -				goto next;
> -			/* Don't send SIGURG to processes which have not set a
> -			   queued signum: SIGURG has its own default signalling
> -			   mechanism. */
> -			if (!(sig == SIGURG && fown->signum == 0))
> +			struct fown_struct *fown = file_f_owner(fa->fa_file);
> +
> +			if (fown &&
> +			    /* Don't send SIGURG to processes which have not set a
> +			       queued signum: SIGURG has its own default signalling
> +			       mechanism. */
> +			    !(sig == SIGURG && fown->signum == 0))
>   				send_sigio(fown, fa->fa_fd, band);
>   		}
> -next:
> -		read_unlock_irqrestore(&fa->fa_lock, flags);
> -		fa = rcu_dereference(fa->fa_next);
> -	}
> -}
> -
> -void kill_fasync(struct fasync_struct **fp, int sig, int band)
> -{
> -	/* First a quick test without locking: usually
> -	 * the list is empty.
> -	 */
> -	if (*fp) {
> -		rcu_read_lock();
> -		kill_fasync_rcu(rcu_dereference(*fp), sig, band);
> -		rcu_read_unlock();
> +		next = hazptr_acquire(&nxt, (void * const *)&fa->fa_next);
> +		hazptr_release(&cur, fa);
> +		swap(cur, nxt);
> +		fa = next;
>   	}
> +	hazptr_release(&cur, fa);
>   }
>   EXPORT_SYMBOL(kill_fasync);
>   
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f9d1e05e8ae6..852f1b8c00af 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1365,7 +1365,6 @@ static inline struct dentry *file_dentry(const struct file *file)
>   }
>   
>   struct fasync_struct {
> -	rwlock_t		fa_lock;
>   	int			magic;
>   	int			fa_fd;
>   	struct fasync_struct	*fa_next; /* singly linked list */
> 
> 
> Anything I did wrong? No?
> 
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> Mathieu Desnoyers (4):
>>   hazptr: Fix two-phase hazptr_synchronize race with detach
>>   compiler.h: Introduce ptr_eq() to preserve address dependency
>>   Documentation: RCU: Refer to ptr_eq()
>>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Cc: Bradley Morgan <brads@mainlining.org>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: <rcu@vger.kernel.org>
>> Cc: <lkmm@lists.linux.dev>
>>
>> Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>> include/linux/compiler.h              |  63 ++++++++++++
>> include/linux/hazptr.h                |  47 +++++----
>> kernel/hazptr.c                       | 135 +++++++++++++++-----------
>> 4 files changed, 203 insertions(+), 80 deletions(-)
>>
>>
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
