Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F612BFC60;
	Fri, 26 Jun 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434705; cv=fail; b=eHnBUt9GOfNZGpqJDLeSJFfh/Rnq0v8cWXzL0sXTZeWB9s4TGg3NZOX3qM05ybDoner2R8BDbLAN7MKpky1GptweDnJl7Et82BG3FvJzMIUnGSXczx6xaQAk9PUpdzV3+R8XMKFMeVVgyoLni8wdhkYzLxdmHRoDkaVFbnOWQVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434705; c=relaxed/simple;
	bh=9vkLTCBJkWXuE1fz3X2VNQzDATPk4cUM1HFL1qeOGUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTo/qUcDetxpwmIhRwj9bcMytYFS5jchCn3IjUEBtrs0FQY95IwTYlpb6zf+hSjbkKtr8BNhL/MsUOolvOiOAoqdRId7sKcKc9LJX023Ew9mz20E5L/uZ6DBJrbqKRQVtsM85RzNwbvToCpo6Dl346uftpvz84Ove6bLNGcvUEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiZBpSLZ; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiZBpSLZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7/cQcMZGBhiBY2+5r5YQ3KwgflvVG/JVKZZkhVs3bLUTo+2Qxb+BJd8Z/Lhw/wqtgMsXpUB6q4lBta5Por+tgXfnZStHdxBj4JoiXxrjr//8YtVZI0mTvJZPTE3g8IuNGdkr6ibDbOArKrPs1jM9iscosw1ahSr+tTrWR5GgWSiwZks7UPVI1DzudLbR9goJEaJOkjlY7EFZ3ai7tYRYHQxhw4l2p1Z5lPKqyzITcqqNVhA26+2vV+SB0YDzhVQ8Q0eHh4GyeBR7EsN38N6GpuOLeDYUZc0PaXmmYEZIcFjadaH4403kFyaKCU0ekcQ7ENn3TSE1cWM7Xo6EV4HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2TLjHQpFu67cY0Com/0B/U1I6tj2tOSSoVjUjZgKrc=;
 b=ieuJyIAm5TtBCLLZ/AfdAcAlLgDviT6KpoENEITUpaEjwGSpBFZVjIpHZqS5dkjwhn7RGoAjUmzUxbz6+vdiYUZryxalGM6zwCqDgYxvLkbqcerGo8oktpzEExnCQm6GdD95nD2MPxRn7nzbZb+E8PGE3UcDnDKxtQWyNp743T8h5X2aqjk1TL37irufpAZ6MoQuds6ZpkzI3pgYYlN/I4qtMWHPryhavwfj4ESECRHajTeeN1wEUg+gJThgNie7uwHBUaI56PrFFxiFK5+fO8DKSe3ulATsNR0bY9brB7BBqe43ls3F/5pgsBErS2z2iNPPR5NVbTUNXdSpJUdMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2TLjHQpFu67cY0Com/0B/U1I6tj2tOSSoVjUjZgKrc=;
 b=CiZBpSLZdREFRzCLKr1o/ESBCw0/QfQvs39DZHWaONab5GpkjtcZgIh62LlVo1zQNJQ+jWiYCxn8Wclr6O4yKBp4DauGwBoHMn9k0pdUej9FjZOS86bGqe40mjJFOCvqxB98yGYb8wOvtUg1G44K2PvDzw6AZQBs4Od77TW7wWikl6R8mRGBbwNFctYgBHc/7nHVCg/m4S4GywX2mRB84m/rWJNnAoonLOLsnIacxuHZbZ8vYryD71JYxDehSnS09FNUKpJmwYgZW5DQOyWPtVvCP2i3eS/aHOkHNrkwy+Q91LjhsvYb/Z+b+IOAetWOcMv5/lKDhysiD0av167EkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.13; Fri, 26 Jun 2026 00:44:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 00:44:59 +0000
Message-ID: <c3636f33-bcdd-4883-9b24-5f9ff1ff1778@nvidia.com>
Date: Thu, 25 Jun 2026 20:44:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] rcu: fix stuck defer_qs_pending state and add
 rescue timer
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260626004301.1632168-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: edb8c922-3582-4619-49c5-08ded31c2680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FvU2TphEZuADTRUA41eA4IEHZhXm2M3USrjT7DU+wLWJ8kqVNC3PyKHgk4Zn9//eizzV5koVNid/gX3Jm6ajEU+I7Z5K+lzWKn/UH5+zpDCWttiD53XdBJp1O8J3NFsRyhyq2p/wiN6h/NTWQXHaZmlBLZx4fYzbwXV0ontXM3B/w1W/QxJoD8rNFHwiVMvZDPQ+ztH0JxmhsHGymVm4FTxsutgfsJA7+lVMVvlmnPtv34JBHCU2yg3SS/AJGgqoM5jUVXB0K3qzL2XIenyE5lfi9ULGyFXSzk4mBjjaFLIATr0bVO8IBHXkHNsav+QwRqkyj+n9HUz2bRUmZB+31YhDuhogL/Ucir15HGpRIMMPJdEpEM4Lxv/9JS2ApRbWY233fr+JsqtGC3qAkCnxRCgxr1217U2MboLK0+xAOlNZCZ2lKLCWNxc0JGvJkdgerInu4Zf78X9IW6OBDUg9ZeENNWW79jP7FlpJ7stao5WnSzP3/hSNmugaWy8SqMzzeYcghq7D2sv4CBMMAJ4+VjpkBtQnFH4aeOrBDWbir65LVHx1PIhSNG4xS8E+cqf2L6ECMDTCV1jtgcB3mvrvFJbUSBJzXJx5J8RKXiBkKb2kmjMKIYkzV7zpciZd6nXJyFOPIMZu4g9/6hAp4HPVOP1WKz4HIiBTQZCOlbSM10E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azB5d1UxMTZSUFFJYkYzQktzQ3RTMmp3Ulh0N2Ryc3dXZlpIK09YYUlUV2lh?=
 =?utf-8?B?Qm9yN2tzTXhjZzBaZU5mK3FOcFU1KzVYc3JGeSthakg0UnArdWNHWFdBNDdj?=
 =?utf-8?B?OERiYmFIcGlhZW1QSXhHN2k0TmNFeUNPS3VQWnJLb0lpTmM2UWFIM0dqYjMz?=
 =?utf-8?B?RXRKa3VoRjdUbXRESGMvbXFUOXd3RWFwbzYwV0VWN3VXM2RwWEJiWmpMNEF4?=
 =?utf-8?B?RDNNMy9WcW1zVFZUTDk3UzEzYm1lc3JJUUxIdk5zOHBYRW9GTVp6SW42dmsy?=
 =?utf-8?B?c0V1TVNJVU5VRjIzbHNYWGNBbnJOVkVyYWpWWDhHYkJUVzdURlhtTWFETG5J?=
 =?utf-8?B?S0ZpakE2R0laZUZyOXYvbVRiN0dTZlRRajUwR2ZmSjNvMVNIdCtuQXBYMDBu?=
 =?utf-8?B?WHVYTmg5dlhUaUtMOHdLczE5dnZ0azByRjBncGtsNVBpa0tXbFFuc1gvaS9x?=
 =?utf-8?B?ald0cXhSRS81MlQzSnlxQU9Oc2tjTHMxdTlXZEhQZHlMT0NHVW9mdDFYUUVK?=
 =?utf-8?B?ckVPMXhZdGhCNlRYc29TL2tpK29hY2JHdW1EZkFneWFzVHZjMS9TRGxXeHEx?=
 =?utf-8?B?UUs1RmFNdlczbis4b2VoMDU2Z1VmMnhRY2ZjNXkwaHlnVDVxc3p6d0sySTgw?=
 =?utf-8?B?dmdYY2UxeXZNcit1bUJadGFjNllONEtpeUVuWHRadVI3K25JZ3QrZVJNT2o4?=
 =?utf-8?B?WDZ5NDJIM3JtZzI3RmpHSzJyVVFQVHhTV2ZJWVdoYlV0YzJzTm1pUFhQdUtU?=
 =?utf-8?B?d1BNck45YzFUcTFPRGRDVFBlMnpCUlcrY3RYYSs4dTMwOTZ6NEd4aW12aTJV?=
 =?utf-8?B?b3hLMlR6KzltV3dYS1gwNjZtTHdlSmg4cUJxSENSb2gzU0JVYS81MGM1NVpB?=
 =?utf-8?B?akZIR0ZwZ0drRTJqbEtIaVl6cTk0UlVQcXZWVGJJbFNNODJYNlZ2RkRQVklS?=
 =?utf-8?B?UEhGbVRjTkRtcEFHTGF4UXZaQnVXYW9obGV0bm1ZeFplM3Vxb2VrdndOSmhn?=
 =?utf-8?B?VU1sakhMbVMxQkVjVUNxQXk3VW5DU3YzV245Q2s4cjUxalJQTUpDcWtBWUN2?=
 =?utf-8?B?TU16TzRKNmJTQ0o5b0VpM3hDSlJsTEFDY3VIYlI0WGdlOWZIVW9YV2ZtVHdW?=
 =?utf-8?B?dFlxTm5TaXEvR3hkVlJDVnZVaEl0S1daVjI1YnpMMldVemcwTURHWjA3eGVB?=
 =?utf-8?B?NlZJSjhLcWVvRlRLUW1pRUNDSmx4eTQ1OWhuV0FhZ2dic1RTSjZLUDl1SW5j?=
 =?utf-8?B?YVp0a3haVlI0TjV4UzBLcThwaHVOOXl2Q0hCSU05NUJMZ0UwaW4zZFpSVVlB?=
 =?utf-8?B?QjFLTzNUdzRWOUZ5T1VKSVhHaWFPS1ZML3RCc3JsdXk1Yk1NVERhM1VmWG4v?=
 =?utf-8?B?c1phaWRETWpML24xSVhhYUZ4UUc4RXh5VDBmTHNuVHhBeG92cUNOTVJmaXBq?=
 =?utf-8?B?QVMzd0dKd2p0dHFyVnl2K0hZOXlRN2c5bnA0UnUzZE55K0FyT2lqbWtDM0hl?=
 =?utf-8?B?ejBGR3pnelBlM0k5enhMTE93Zmh2dDNnZ2lKWVVzZmhUV29xVnZRQ2N0SlJt?=
 =?utf-8?B?ZTR3SEpIQVhuUE5VdW5vcXkvV1BWemlCV296MXZPanp0aEZWRFpkeWg2dFF4?=
 =?utf-8?B?dHJRcklObkZqdFVKcC9PVUNmblZNS0NKMHlDdzVSUE5Ya2E5T3pmSXlPaHRB?=
 =?utf-8?B?eVlyUTlOTTk3aHZlaFZ5ODUwVFBoY1RKZWVGNmNlVDZkM0VESVVzbUU3V3Jq?=
 =?utf-8?B?aXNZOXpRWXl5OFpjdXplQU1JdGx0MGNVcXpkYWdITk5BQnd0UllXYVJ5Z1ZB?=
 =?utf-8?B?WCtmRi9Ec01yRWdhTVJudGszRTEyUk1XZFUzS0xtRkVzdE1RcEN1eDhRQ0V2?=
 =?utf-8?B?NUdKdm02TXhMWTRPM0lack5qbXVkbHNyTGc3QnlvZEQ3TUg0Y2p6Q2xNVEh1?=
 =?utf-8?B?U3h2aTN5MVlDZEpkbWFnVWtWMFFsNFp0R1Rsd3VQblovUzBpUU5JUG5HbDAy?=
 =?utf-8?B?MlkwZWxLeTJqd0hFdU5pRTB0UUZwK2dLZ2lOSFNpYTZhd3pVRW8yQnptV05o?=
 =?utf-8?B?QTB3NGdHOXIxK21Scnk3YjA3WlZUVEF6dVU5VFFXam1OanVOckhiRURwOGY3?=
 =?utf-8?B?b3RmOHpQYis0VDNiTWVjbXAxUVc0VWplNjhWemNJRVhnM2RieGRwZmpQVGZ1?=
 =?utf-8?B?cm5ZMmtsUS9LeHZKY2F0ZGc4VWFpc1I3OWdxYzFPUVdoOHh0R245Wm5jb25M?=
 =?utf-8?B?ZWY3eEdRNTNhbVhnUXV0b25HSDBTR3hOY21LNUxzRGhoNG5XSk45b2RuN2VW?=
 =?utf-8?B?dXRhYmxGUHoxV0ZMeGdxWlpVU3Q3SkF2T3d4MXJKcll2WlVyTEQ5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb8c922-3582-4619-49c5-08ded31c2680
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 00:44:59.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML9n+jbBdhjFjLLDMIBnSgRPFdYCiHFSVQWCM6NtL0adv44EgXZdfOxuM5FdwF+vT7u2PneVkOV79DKWlGjrRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207



On 6/25/2026 8:42 PM, Joel Fernandes wrote:
> This series fixes a bug where rdp->defer_qs_pending can remain stuck in
> PENDING when a preempted reader's quiescent state is reported up-tree via
> a path other than the deferred-QS irq-work handler (FQS scan, hotplug
> transition, expedited GP IPI, context switch). Once stuck, the pending
> gate in rcu_read_unlock_special() silently suppresses all future arming
> attempts on that CPU. The series adds PENDING -> IDLE transitions at the
> missing sites (patches 1-7), including the case where the deferred-QS
> irq-work handler may run between segments of a compound section (per Paul
> McKenney's counter-example) and the softirq deferred-QS arming path.
> 
> Patch 8 adds a per-CPU rescue hrtimer that bounds the worst-case
> deferred-QS reporting latency: when the irq-work handler lands in a clean
> (non-reader, non-compound) context it reports the quiescent state directly
> via the new rcu_preempt_deferred_qs_try_report() helper, and the rescue timer
> reuses the same helper so that, under preempt=none, the QS report is quick
> without depending on the scheduler.  The rescue timer is cancelled from the
> normal deferred-QS report path so it does not fire once the quiescent state
> has already been reported.
> 
> This version is rebased on top of Paul's latest rcu/dev branch. The
> rcutorture reader-end deboost test patches that were folded into v3 are now
> in rcu/dev and have been dropped here. The git tree below additionally
> carries two debug-only commits on top of the series ([TEST COMMIT], not for
> merge): a detector that WARNs if defer_qs_pending is stuck at GP cleanup,
> and an rcutorture tweak that gives the async deboost mechanisms up to 500us
> before warning. Applied alone on unmodified mainline, the detector reliably
> fires within 5 minutes under TREE03 rcutorture; with the full fix applied I
> could not reproduce the issue.
> 
> The git tree with all patches can be found at:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-dqs-stuck-v4-20260625)

Just fyi, the 2 "[TEST COMMIT]" patches not for merge are in the above tag. I
missed including it in the LKML posting, but they are not for merge anyway.

