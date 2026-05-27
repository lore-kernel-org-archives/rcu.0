Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013094.outbound.protection.outlook.com [52.103.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84222BEFEF;
	Wed, 27 May 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883662; cv=fail; b=iq0KFwFQL1tucKdkUtj16sbNntHcOsvKjeqsn1wFa1E+iVYgFgXRA0v6XrRjcYdTPf2AGyDLt7LN6oBWJ9S8jhXSUkY6NIupY+ewVtuoA3xiHxm8GW1uDi6UkcSPzLwqpt0JWxMu6Tyl8zzuXugR/9M30IueWykNJRcrouXMDoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883662; c=relaxed/simple;
	bh=P3TTe9AcEsngU1n4R9j8Ib0R6Vi2vvRTVjycZrTuQ0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZZNlKQ8YMU7A+Zp8P6jBrLgRHje6qrSTM4a58f9VWkYrxP4d6os7eJhk1HPF8Mnhjh6OyVa71XTXB00c93Q8E43yoZtnx0/z9eb5fgi6CLKetMg8RJXGLRJ+CsicQztoKC3ZoaC/QZwBdFZm4XE/AVlSmHdtIExvEXpG0aJGo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EYeLuCZb; arc=fail smtp.client-ip=52.103.20.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EYeLuCZb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUsmKUmSg+nQb2FQpo2xdOWhStdtRgKdLERHxnYhmA5cKQ8YdgVzU57foR3B+3xaNy75OXQPsDwE9z+pAqQVdJHE3zVmcunxxhj/sLqXVIxpECssfZrXyMWAokYlGwonZ5Z/nLc4lKYBAQ2sBvNaFtpu/ikFqVq4ZEYDUp6b8kVG/4GHbhVjz1ry4zCHUa+vkWYpx0wJmLs1BdEqMjcN4cSn4uAkOwqwiBuQFNyHMW3ueHeACTB8HH+h69Jyyb+KgbnOsGsodCglCewpIc1lgpSs0a257Hy9IquPWVFHqejUupo6LtzFAC94VNavCsjFe+L9dPaIUwfI5YN4KiMRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O4W8Pysiz5GAUzHYDoasZLoIiifl5MmWLIM3mvz13c=;
 b=x/ahN+3PVNVuEuNvWhaaxBREc7w8Cl20G4YDdzL/KFDmnsKcY+D+KOs6ngL130XqdavtYh4dsLnIS6WADGG0J/8qRyrmL862WheS1eN3RyXsdx2fqpOviWI+ufhesVICXQ59nx1MXaJggdBXeZ1hrso+JrCoYgkrGnpP3mFrOnFgZQn/ebd79AhQvQF6NRsIEFNi285HfccgFZVqYqH6Byxv1TnxmYqNsowG9W2qMmYx+/JSSkBj1QveKuYp3KlAn1GxhixE1Zb5+IbrCAAV/+eQMKOexvXU8Xt8ZU2iOjUMJoX2CY02VR8PUw3b6KG0IjPt4u/xdw0bbvUp7gT19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O4W8Pysiz5GAUzHYDoasZLoIiifl5MmWLIM3mvz13c=;
 b=EYeLuCZbQjBX4P/FR76vPhg1Aq+BX/W3jIhYu4BRgBOo+y4e/dSC72QLHYyUzmq6q5QlRqDls5rsslxsx1xQIy5GB/a5GIakd2vmoKuXbVYEAejBuO918gUXAkyFOHv1+BMUTBfTilQAJdeUh41wfl3V7pxK805wxW/FuOnrh7xj83aLJULIp3mTM0cb3S86aig8HMSEIuh2lfKA6PHSy/y3fXvJ2kfltiddeV9A5kKysYQ+6c5Ppx1Hv/CsAyZHY29qKM0r63D6EvJtVnZ/Oi9yAjdITj4jHLqUhzCM+5qOFhzX05cCJGt6TdTi48SKYwdztLd4hWpz89HD6Hjehw==
Received: from IA1PR14MB5659.namprd14.prod.outlook.com (2603:10b6:208:3a4::16)
 by IA1PR14MB6269.namprd14.prod.outlook.com (2603:10b6:208:42a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:07:38 +0000
Received: from IA1PR14MB5659.namprd14.prod.outlook.com
 ([fe80::63c6:55d3:c704:5510]) by IA1PR14MB5659.namprd14.prod.outlook.com
 ([fe80::63c6:55d3:c704:5510%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 12:07:37 +0000
Message-ID:
 <IA1PR14MB565986AC8E0342070F8CC87797082@IA1PR14MB5659.namprd14.prod.outlook.com>
Date: Wed, 27 May 2026 20:07:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu/nocb: reduce stack usage in nocb_gp_wait()
To: Arnd Bergmann <arnd@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Ingo Molnar <mingo@kernel.org>, Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519190447.1716375-1-arnd@kernel.org>
Content-Language: en-US
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <20260519190447.1716375-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To IA1PR14MB5659.namprd14.prod.outlook.com
 (2603:10b6:208:3a4::16)
X-Microsoft-Original-Message-ID:
 <66268cb3-44fa-4b3a-8c24-a921d40218a5@hotmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR14MB5659:EE_|IA1PR14MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 13214395-7231-4570-a1e9-08debbe88adb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|24021099003|23021999003|15080799012|5072599009|6090799003|52005399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhRUXl6eTlOMkQrT09KMFFZMDhiUExYYm5EbkpsRTMxa1lMckx3VVdtTW52?=
 =?utf-8?B?RUxqcE9HZ2lIZEEyNTlXZHNmMi81WnkwcE9TZHo2ejdReGcxbGRCQ1dNR0xM?=
 =?utf-8?B?SDRlK3hJbXNXM052VWZScTI3Y2VCOUh2bWg0RW1MMmVyUklNbWhnUHc3eHcz?=
 =?utf-8?B?THFpalVIVC9vaWtWMW53TDNTTEVGVlYxeUF1K0gzM2Zid2dKbDBCK0hTRno3?=
 =?utf-8?B?cGR6MW43SFFsMUFkUDY3SG5YV3ZrRHdnMG5WRzA0N0EyOFV3N2RpUFIwdm9t?=
 =?utf-8?B?NVk2TjNha0FNVGZVeE5CWG1CbE50dmxVZ2RTM1lZeUphZ1k1bEdmTlRQSDNr?=
 =?utf-8?B?bTFoZ3ZZNHdRRkFIQk9NaW5uUXJ0WFVKZmY2L3NmZUdpR2VZTWVqdy9iSnl5?=
 =?utf-8?B?ZnVzKzhDc0FYbksyL1RaLzdXNW9vb0NTS0RqYWJPZ2wxbmtMV01wblFFN3Q3?=
 =?utf-8?B?ekYxUXM5dC9tSXBmREE4NDdlMTVUNW9YYU8xaFcrcDdHUDJyYmFrMUJabHdm?=
 =?utf-8?B?TGF5VjVxemMwR1dweS9xcmwzdGp4U0FUYnkwYmtJRWFKbmlJUHBYMDVSMXI5?=
 =?utf-8?B?U2JqYUlLb1M1emM3OURrUHNFUzN3aHE4MmNIdVkwZDBNdHpSSmdhOTlWTlhq?=
 =?utf-8?B?NTZHZVRWajBrVDcvWTV4cVNJSGw3UGJhc29BL1hlK2hTd2RZV09mVExPdFRn?=
 =?utf-8?B?dU5BR0piUDgxcUdGNURlWVc4ZmQ3MTFGUC9HZVVaUU5ZbHAyYlJiWWxuS1Z4?=
 =?utf-8?B?TjJTMXlmeUg5c2NCQjcvaGNiaGZ1MmtubklaR0tJWjNqd053Mmc3YzcvS0hz?=
 =?utf-8?B?V0dNTm4vNTlaUTJjVVlvQWozcTNQWVlwWFVlR1BvY0YzdGZHWkJXWlBXV0FF?=
 =?utf-8?B?L21zTVZURGZNQnlMdzlteTI3cThNdWhqQ1pmdk4zY2lHcXRucUlsdjh4eEsz?=
 =?utf-8?B?Ry9iTy9ERUkwNTlLcVhwZGhmKzFuQ0pveFV6OU9VZG54eE0zMzhleUtkSWs1?=
 =?utf-8?B?SWZSSWdRTDBVZm82QXBydzlaTUFqUWgyKzJab2M3WXU0cEtVTTY3SHVGSlpM?=
 =?utf-8?B?M1V3Yldic21QVGpuS2Y2TWEyWGJPMlNyVlA5cEgzZ2NjaksydjMzQXd0czJJ?=
 =?utf-8?B?cmpnSmZMMGN6NENvakVJZnlSZkROdzNIeTNQdjNxa2ttY1ZFaG9uVS9HVm8r?=
 =?utf-8?B?VWNZWjFUSi9IRmJuT0pNWUJCQ1poNCtDbWd5Mko1M3JQZXBibEFoTmdRY1Bz?=
 =?utf-8?B?bWdzL0ovMmF0SnhrUjZQSWYvR21pVm1TNEZISzJmNkZqZmhrdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHNmT0hYYXZYOS9PMEw1TXZGdnBYNjcyRE9ZN2JLcm5WVVA0L3JNS3ZGV2hv?=
 =?utf-8?B?WWlUYmJjVkcvZ2c3QUhqSFhVaVBOV2NCcU1ackNFQ3ZCWUlhcldpTkREYU16?=
 =?utf-8?B?bkhLbDBGNWYyR1hnVDlxUnJ1a2F0NzZhSHpmMDUyVmVCT2JTcFlpYnlBQ1ZW?=
 =?utf-8?B?cXdBclcyTVNUVUJEWVNRd3JxVVRYMS9ycFlGM0M2aHE3bUxQMmZwZ2dJeWlR?=
 =?utf-8?B?dElUZEhsWG1GbmJkWGJLNDdFa0FnamFhK2tuZ0dRN2hzZTg1cGg0TmU0Vnd0?=
 =?utf-8?B?aGs0VmtITVpNNE9OUVg0TUt4SkZiZFVpU1Z2ZHVlSldoOXpHWXdBQVJFUEp2?=
 =?utf-8?B?ZmhCZ2xqclpzeW5DTTF4ZDRwY0cvMi9nNzAvb2pEcy9DQWlCcnNkOXR2TGhD?=
 =?utf-8?B?dHRLeUIvT3NxWXdBZ0wvbnhLaGhYN1RtZHY4R0FNa2doWFBnY0lsZHh0ZUFG?=
 =?utf-8?B?NTk4MVRtejRyU3FKYzY1VnkxK3FENHh1SDJSY001bTlzU0FQSTc3cTYwRnly?=
 =?utf-8?B?VmFseHVuTFIzbjlYeXI5aTBGRTlPVk41NjJ4NTBreGk5cEt4ekVoM1dFVm10?=
 =?utf-8?B?b25ScVNIaHVBMUE0U0RRRVB1MzFUc2l0OXhhUmsyNmprVWl3Z0lNajZQWDh4?=
 =?utf-8?B?eFllcHdEak1XRFFHRzY3clBFN0lhT1F3T2k4YUlwRXVkcCtqU3FCOURLLzgy?=
 =?utf-8?B?UC9xWENUUnJNOGsyYlhVczRLdWV6RGMzWGFKRWpRQ0l6N2hyYmwyY1pTV2Mv?=
 =?utf-8?B?WkdaTDF5RVlxb0NGTHdsbmtwRVhYK1lUa0lkdHlFbVlSTDhiUTBIVW80ZHdK?=
 =?utf-8?B?ckFCQVBkTW1YL1BOTmR4cVlnbTEyVGpocjg3Z1BWVjdFRGlieFBTZENCTmI2?=
 =?utf-8?B?aVRLVFBYV1R6TGNVNzgxZGI5ck03TU9NMlNiUXBmYlZiVzk0WFpVQTNiK2s2?=
 =?utf-8?B?SlNudFIvVUZadlBvQU1DY2JLZDlyTnZwYUEvd00yQTZnRlloL254WmZ2N0tO?=
 =?utf-8?B?d1hCV1ZmczBtNDA4cUtaOW5GQ2pyd2RTUzhRWkd5TlVIOFZrcGRCM2tpZ0Jw?=
 =?utf-8?B?R25OZFcyZHA0dGt0M2hsK0ZPTGpoNEFiemxaYy9PNHpwU2ZaQm9lQkpqYzNt?=
 =?utf-8?B?VFV1TUNSeC93eTA5TXlXOE9ZcXVacTZQeWs1SXByd2xtVC92R004VnMzU01V?=
 =?utf-8?B?YXlsMDdldjN2cnlhWW1pdjlGTk9DTldXSzFVYS9FK2FEbFEzdmFONHpZcHpC?=
 =?utf-8?B?ZkF2TmY5eWxoKyttY01aRmExMjhyVUNsc2pqTUEwd1JQR3FDMVVRL0F0Nmc3?=
 =?utf-8?B?OU1NaitOWXhtTjdOV0crUm01MjZQcHdsSXh2Rk40Q3ZvOUNWaFFrYkxxOW5M?=
 =?utf-8?B?Zm03Z04yV3dXd3o4K0xNVUY3OTJvOXJ1MldwQXpWSGVDeVBKQURSRUlrZFBk?=
 =?utf-8?B?dmNVUlNNbTZwcm1YVzc2enorNGxabzNqNjRiN0oyTWZJVmRtOGFHakZneU5Y?=
 =?utf-8?B?emgvVzVOc29nNnJnclFMQ0c0T2Z6V0pOWTdxTFlPLzJWWmVLTkliY2xBYWx2?=
 =?utf-8?B?ejdHRENoaTQ1bUgxRE14em9NKzZrbVM0UUozaEN0RlhMVVkwTUx3ejlXV29B?=
 =?utf-8?B?MmI3ajN5b0ErSHkwa0dVang3c01KUFhOYzFoeGhtM1VqeUhycjE0TDkxME1X?=
 =?utf-8?B?a293cGtxZHNVM2k2RE11TnYxbmxYSEdzMzFvYUxwRUVQYnBsZjVZVHNrNEN1?=
 =?utf-8?B?NEJHcVpVY2d1dmRKMURLTUhIbCt6Y2htN0NiaG9FOUlXYTYzdzF0MnBsUFgz?=
 =?utf-8?B?MkFTSUlQQUpmR0V5WnR4RUZzaXI4bjhla08vZUp4aVpneERQeU5ZL3Vtalp6?=
 =?utf-8?Q?Y8cK2fLCBDZX9?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13b70.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13214395-7231-4570-a1e9-08debbe88adb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR14MB5659.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:07:37.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB6269

On 5/20/26 03:01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_UBSAN_ALIGNMENT is enabled, the stack usage of nocb_gp_wait()
> grows above typical warning limits:
>
> In file included from kernel/rcu/tree.c:4930:
> kernel/rcu/tree_nocb.h: In function 'rcu_nocb_gp_kthread':
> kernel/rcu/tree_nocb.h:866:1: error: the frame size of 1968 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
>
> Apparently, the problem is passing rcu_data from a 'void *' pointer,
> which gcc assumes may be misaligned. When the function is not inlined
> into rcu_nocb_gp_kthread(), that is no longer visible to gcc.
>
> Add a 'noinline_for_stack' annotation that leads to skipping a lot of
> the alignment sanitizer checks and keeps the stack usage 60% lower here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1047b30cd46b..373b877cf171 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -655,7 +655,7 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
>   */
> -static void nocb_gp_wait(struct rcu_data *my_rdp)
> +static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
>  	bool bypass = false;
>  	int __maybe_unused cpu = my_rdp->cpu;

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>


-- 
Thanx, Kunwu

