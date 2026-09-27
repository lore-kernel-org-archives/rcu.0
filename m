Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020114.outbound.protection.outlook.com [52.101.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8C4052C6;
	Sun, 27 Sep 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526042; cv=fail; b=M75c7JsXMpBJetu6KQzPFVJ5nLBAKUSn3fNaDYv2ShKEzIAyxIQZdJ0Dw3cSKugGFRG8CjhT3GT+EsMn6RBWJRuiHow644HoYdbznf+v19t0YqdDvcUqCAT5Gbjec0h176/zAE5tE4uWWWZumIkVDk9vEeXrYEYeUwAufb3ScUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526042; c=relaxed/simple;
	bh=KQps2Lu3sty8H+6NTtb+mCGy6Mq1YOwQwrQdXT3TLLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S/QmBAgwKT8YyMUPLLyO6zQ/oXk5TOM9x73ZiTwg1q6klyZGMvZI6Zob6JvUJnQfcQKQZ+l4cmqPeLHy8tljWwLEB6sju7f1b5Bmp1YDtuBlU0FHLDABbVfLJ/8zDfW1Wkg5d5EWwZpFezFonaFgD9TMjaGBW3Dx21cSQxfVvbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RIx4rRD4; arc=fail smtp.client-ip=52.101.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RIx4rRD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTRY03np1Txmp4LgzZ2XelSUpFKJiHZWCo9gLyka4Gq3b5jD25KlKjNCzMXefMx6gbU/u+YZELhdHEtDzetTtFqt5wUGSCmUZyiuL7/Gh/FgRJtmrJOvYa92fpVvhzNZpurfx3fb55Re/0iCcIHkz8zsXhHS67PbpAB20xLDc/7sVAmx1zdVwvY1s9KlbIQHoEu7D2QDF4X5Ry6/86LsdRRnaWf8/YSNzyGc63UvPX5XeMQeHUMX0Rm1bo6uWgD3YOlPAwZNKZSu4XwACsZ9TErA95LRGIQJh2Vx5jHeFEI/Sw4AdoA8As/eBwg8KawqgukDvA+MlIWqz+wvmfYXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZe5UMQ5htajpjX4ZjYR7sOExPEN36jERT7c6J72A8M=;
 b=SHrZD5FyGwwqYQCBuRNdyjtCSDEwAxcY7hZbkia6613Sqb2iRKAM36KVZpk9XgFBeYFImFjZfmGbKUhp/yjPJVAm2UeIs0krCg3euoQv5NfsIjuJtN7t/IoHKeJV5KVZExWx76nO2s5gdA6USNeVroKgazygM26/iG/F3Sm5kFdjKxkUWZOXHO6tt7IrvLFT+Ni3af4cYixPKhiGMDrAe5ZXtSLkJnUCeoKs1mfXClwKcZq/KQHb+Dj59LSqm8c2nztJhtnZrn5LK4eVB0s6rrvDIJf0zo/yiDof+mRId9xpWLuLSzoxdNYgaUgEIpc7dQWeI1w0YKu+qAx3IKXUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZe5UMQ5htajpjX4ZjYR7sOExPEN36jERT7c6J72A8M=;
 b=RIx4rRD4/WFeBU8e7SABy9WLyOuyx/7D7yiRzgegpdVOlKvmCLU2pTTLwlPOYAjD6QoJXt6ipMw0byjVswumeQ/Jw/gO5Jfi2DaelTwd2BSpefFp6JWSCJ+rF4HWkKMuobULD1maLuiWotCDDwxHHfgbASyewSOA5bHH82PnRUhPTQyqEJ6EtkAqhRnPBO956q9AdyIVVQIHyAzPh4hzERSd1w1bGZq9Kuk458Gy7w2s8uvhI72p8Alo9B4NNKTUHE/JxBJp6JvmWruGWhO8bo3kybBIW9Aj8LRaqP7ktbXcEbuCH4h+wpVG2n4jh6TrkRJXWb2rrmMky0N3+CjcZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB11570.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:153::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 16:20:37 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 16:20:36 +0000
Message-ID: <c60567de-6583-47d3-a540-a7622855ccf0@efficios.com>
Date: Sun, 27 Sep 2026 12:20:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
To: Boqun Feng <boqun@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
 rcu@vger.kernel.org, lkmm@lists.linux.dev, Lian Wang <lianux.mm@gmail.com>,
 Kunwu Chan <kunwu.chan@gmail.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <arlBDX_907OBM5WY@MacBook-0RXW5>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <arlBDX_907OBM5WY@MacBook-0RXW5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::9) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB11570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eacfd69-3ac4-423b-1534-08df1cb3438b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|56012099006|10067099003|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WKxdD+3YJP439XQkAZsIHSaAgluV0FTsHP0QlWoSrCMgxl36gUzdKPW0WMnUUhYwDDfK/Kx/zdXPesCZz/l8GA3ZPbhgRa7spTnODnEq5Ttloy7EtU8xyxGF72tOXGfJ1C2t3DoGxqfSu3gNAHOGIOCfBLOk9UlRUg3AQ29d5N+pICMffkVuLtn3UKxipUa4QwzMmGv85P7NXY6JxlXDDxb9o2qU89ks5muhw8ANUUSilJa0Ugp35KXBUGiXIqeFwLjUc/WjmUBN4Yk/ebljgk4NC7BBRj4isinFACRAoLweHOLfCWBqGe5UPBGXIQoMyL4LQ851Bq/DISkhQDZXYjbvug5PL0Im8Sv32eN5QNDC0Nbr2i6aFnvXY04ioZo2TJAcRJ4jFvVjScOfuCgiM/y/bScAEmIaXItgirfGmJex9Ed7tJW3cYu49vUbgEyJXvxYynokTjSQAfp616MxXV8T8gb2zom+vIGITH482z3hn0Kz0SNmFyaDVruAT8QpjyI+YKRSsbztCF8MWBTogMKjCkleS903H89o0jMPSp9LxYwvAQdma7acI3515teVaDXoKLkyqQnNc/8GRh/GloPxIZTFb9xwGFozFOHd5Z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(56012099006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjQ2S2Q2bmxGVFVDa1FZUUV0dzdsMFZxc3grQ2ZzMkx6U20rNFJPQ3h2WFVj?=
 =?utf-8?B?R0VDSnB3L1I2QTc2MFhLejkvTEZ0c0ZpMkhnc0JscTFIVUtYZy9ZQXZGTGF0?=
 =?utf-8?B?UityZldQWVJxbVhsTEtjN3UzRThBOVhORFpsR25zMTBueE9Hc1REdnRHMHlr?=
 =?utf-8?B?WTQ5aE0wNldueDd6ZHptaTkrUUlDLzE5T3FObmdsWWpxT0IrcEw1UFpzc1l6?=
 =?utf-8?B?K0FjaCtOU250aWM0MU5nMmlvRS9KbnVCcUo4amlMNUVOLzlmeW5PcU91YVVa?=
 =?utf-8?B?L05yakdacDBGNEVVUzNWMUNpb09PWHl1SGVCNDdTWUt2V3lDVEJOR3dGbXhs?=
 =?utf-8?B?UXdVL1hLWXU2d1h4aVIzUUNBMUpML1FsSmdIcHRwTTY1aUZzRElKOExsY2F6?=
 =?utf-8?B?MjM3UTNTZTBGTWxUcldsTXBXY09jL3NWMGJ4Q1RTdUJyaHJVZzhnVnhsRWpy?=
 =?utf-8?B?a1ZjWlgxNGhnVTczL3FIbXNZdVNYYklCekRhWkorMTZZNE5sWTQrTDUrZGhn?=
 =?utf-8?B?T3FxL1RKazkyenVYRmRqVm5OdmoyK1loYU1PZExtNnAxOVlTSW56UHFnSllE?=
 =?utf-8?B?V3NQMXE1Mjl5bnMzQU1ldk1LUGljTXdRbDNINXNuVDB4RWMvMEdPNmZoM1FO?=
 =?utf-8?B?QzBUa1Y5OGM1M1gyVXB6R0tSYTRkV2JWR0JITnpiM1FtWDlFMEVXdXpPT2lU?=
 =?utf-8?B?UGExdU43TnFQcW1QUWd4aGplbFhyOEJyQm1ldkcrQkVmbWNvSWdaVUp1M2dS?=
 =?utf-8?B?N2tYQWtJNi9wVU5OZUtheXZyMXAzUWRzRytLWGZlMVJyTVJJaTlxM2ZRVXlm?=
 =?utf-8?B?MXMvVWhqRzRVRStqNW01bm1VWjJDNEc0UlBHTXRTczNGS3FIbWRJeUpnZmZi?=
 =?utf-8?B?amQ2Q0M3M0Y4MVpUTjdud3dFWE91eW9UYXRNS1U1bXRPOTRYTVZUM3ZxQnc2?=
 =?utf-8?B?OUY4RnpVRUpWRjV5c29jQjZSN0RFeVViQy9MbnRJZUhKc3NWYU5PaGZZUHVZ?=
 =?utf-8?B?VUdVOXFRbkd5SURVZFRWbWt0a1NMS2RacFh4cWhWZ1lnQzdoS05yRHpxMzUw?=
 =?utf-8?B?OENpN2VNN0ZCb2V2NENLSk1tUC94Ymt1cnd2ZjA1bXJRdVRuUHV6ZU9QUXAw?=
 =?utf-8?B?VmFVTjJmajVxLzBCOEd6OXkreW1XMTB2am92QVhLQ1VsRDJDOHFoT2JKRllS?=
 =?utf-8?B?UkdzV3BDUFVFR2VhWnBldE0vSzc4M3htZ29UVzR5czhLcDNXN1gxY3A3c1dW?=
 =?utf-8?B?dFhmaTMxMEJSTDNiQkh0TlgreHlQcDNJblhOeGh2NllabFlUT2s5QTdyZk5h?=
 =?utf-8?B?UWN5Q1NsM2d1SURVMVpUTnFtdFpqTFp5b1lCRW1JTFI5c3crV1dna05MeUZy?=
 =?utf-8?B?QTNtT1ZxamhBMTgyUExBN2RCKzRLbVRTTGw4MVAreXlOZ21lU09nTHB2WUxl?=
 =?utf-8?B?ZXZZLzYvR21nTG5yaFZ0OFR2ZmFzVXhrMVB1QWYzMjk3U2NQSzZMUk8yS1RO?=
 =?utf-8?B?OGRLelllY0lpMk5JWWd6Q1ZqTjJXazdVRGFKcE4xbEhVN2xIb2FXaGNLYTdY?=
 =?utf-8?B?cC9OQ2xmNEcvRHoxdDdXblpvWW1lVnlIYXlaNU1wR0o2Z0hyTGpibUx1bmlt?=
 =?utf-8?B?VE9jVkJQRjMrRXlVdGFEU200Rm4rZ2JBcncvOUljbzY2VmlqbDBKMm1IeGVJ?=
 =?utf-8?B?SW8xZzBsTER0dkNqSE9VMHZud1k2aEZjWHprb21mNnZOZnBmbjR6QzR4Sjhn?=
 =?utf-8?B?Mng2OWhFejVNK25tbUV6OHVGTFIyTkRiWk1VdFF5YVJrRERIWC81VDBRaXl0?=
 =?utf-8?B?TVFZdVNyaEF1dGdMbXc3MDZqWmZZRmRzc0pMZUhka29GS0M0Wkp6eXVpOXJs?=
 =?utf-8?B?WWJ3U1hWUXJzc3R6KzhqTmtiZ2MzSGRJc0E0TDFyOS8wVHZnM2dQcUM3ZFQ2?=
 =?utf-8?B?K0pDSng2cW92Nkc4VzJ6SEZIQVQzOXdlZjR3bHlvcDY5ZnlkcWF3K2NHNk5L?=
 =?utf-8?B?YXZtczA1RHA0ZlRTeFdTVlhGZEQwOEt5TDFybjBEOEdFZ2hXYmNDMU5WRWRo?=
 =?utf-8?B?dFFiNmE5M2NYVFl4UnRtQWdnaUllbjdET2RhYWNaa1F2M0VLQ3djYzBYamg0?=
 =?utf-8?B?U3NzRld4SEJGK1FlTlRKL0k0RlVjK3Y3eWdQSDJySjZKcWdkUjdDTDVzSUV1?=
 =?utf-8?B?dXRZNld0RE5zUGkwdXRUMWlkb1c5UkRRaEpZbEVWVy8zZnNFRW0zenJGeXVk?=
 =?utf-8?B?K0FPM3dPM0ZYdXRKbzFteHhYNUJNTURvM0o0dmFObFNVZDBnRk9vTytPaEZT?=
 =?utf-8?B?WjRzL0hCdTJhMWFtcUNxQzY2WHc2WkFVRnF4dit0eXdjZnZvcUZYMFo3R2Rv?=
 =?utf-8?Q?/2SGlr1PuRTW8VqvSbWwd96AKvv9fQYyf+gYEKjBbWz3R?=
X-MS-Exchange-AntiSpam-MessageData-1: FJ+Ty5yXe1W0PEaAvnOBSDIwBemZNyoHm9A=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eacfd69-3ac4-423b-1534-08df1cb3438b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 16:20:36.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8tUkJfDtFXZklBz/74KD0VPYW6PEa7hxbAEdLq+aLWnq2KFPFbFpVIUJPwMbZuQEZXrV0Md7LlxTQMIKGjHjcuTIysHyH9ZII2xckdOT9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11570

On 2026-09-27 12:15, Boqun Feng wrote:
> On Sun, Sep 27, 2026 at 11:51:27AM -0400, Mathieu Desnoyers wrote:
>> Hi Paul,
>>
>> This series applies on top of "hazptr: handle NULL address in
>> hazptr_detach" you have in your rcu dev tree.
>>
>> This first patch addresses a race identified by Boqun Feng in the
>> two-phase wildcard scheme.
>>
> 
> Thank you! That looks good from a quick look. I will give a deep look
> later on (I was traveling).
> 
> For the following versions/patches, could you also Cc Kuwu Chan and
> Liang Wang (Cced) ? They are helping on the scan thread and lockdep
> integration, so it'll be good to keep them in the loop. Thank you!

Noted, I've added them to my patch commit messages, so they should
be there for the next round.

> 
>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>> Those were discussed at length in a prior version of hazard pointer
>> patches.
>>
>> Patch 4 introduces a "try acquire" helper to allow the fast path
>> to not rely on wildcards, while keeping the wildcard forward
>> progress guarantees in the acquire slow path, used on fast path
>> failure.
>>
> 
> Nice! I want to point out that later on if the reader can handle the
> race with the updater (i.e. the readers don't need the progress
> guarantees from hazptr, then we can expose a hazptr_try_acquire() for
> exactly that). Although I do have some design trade-off questions for
> patch 4.

Sure, if you have a use-case in mind I'm interested to hear about it!

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>> Thanks,
>>
>> Mathieu
>>
>> Mathieu Desnoyers (4):
>>    hazptr: Fix two-phase hazptr_synchronize race with detach
>>    compiler.h: Introduce ptr_eq() to preserve address dependency
>>    Documentation: RCU: Refer to ptr_eq()
>>    hazptr: Introduce "try acquire" fast path, fallback to overflow list
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Cc: Bradley Morgan <brads@mainlining.org>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: <rcu@vger.kernel.org>
>> Cc: <lkmm@lists.linux.dev>
>>
>>   Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>>   include/linux/compiler.h              |  63 ++++++++++++
>>   include/linux/hazptr.h                |  47 +++++----
>>   kernel/hazptr.c                       | 135 +++++++++++++++-----------
>>   4 files changed, 203 insertions(+), 80 deletions(-)
>>
>> -- 
>> 2.43.0
>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
