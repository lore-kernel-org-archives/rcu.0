Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE826277818;
	Fri, 26 Jun 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485777; cv=fail; b=SppoFMDr0Z2dAcFWQCRfuBod17uaj1WotqOXGF/+mYkRIUief6EYiy7+P8kzVH5mO/njPv7Tr0p+BK3b7PNf3HXVTLqdKlSRffO60mTtWMvK5t2bwqI9Jmvq8Hkyrcguh1iGt/Te2kJwcbiWHcEFqZmEDVjoAjpM3uVJ+lHArig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485777; c=relaxed/simple;
	bh=CUlX4wBGu3LF8UZqP75RXIe0Abiiih/4OrFF1qhAQRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKXx/Foyv9KYVsX7t9AnbHY9Md/M1GF8lNyEp1wBuSwueEg5A2/oryA44w9jLw8hfD2HTsAJDj/sF5ySUkMZ8fdJWmtNaOVKUBxAibSIk0OJykP0r+nPeJf1L8+yT0XxnXGB5FqnA87LM8C0tjKALi+L8Jz493waGzMRrMesfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OecgUX05; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OecgUX05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWIEeoLpjmZwnHe4jN9cU3UvqBrYBQcQzvb/CbdFQr0vQGOdfy4c7Di8QnVYQdj0cZ7ODlH+txkiWrpO3o6eaZbHjBuWn1qWTDR9OpGD4Bc/xyT4h7jH6l+eVoNkP4h++jKZxhBo6nMHyu1jSAZdSnjI9IfWVOy4I83FPYNKwipb5LC6KrGiB7ba7J5sdcdbu8aAMoPpM6ZS0k1ss0NHR0v/9GrD7pS1IlWdpYFfqMhpLynzES20cGIZttxts9on1uVtsLtSmHDIHcZ79oHRFV7g4h18BeYtryjd3MSB8F67NuOyQgoUn5fUi/wWTp0IrsPSQpaef1rO7SH2wwELqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlmMs3m0DWSHmWUA+E2qmqtOr1vAPfJUL4zXUbuLY2Q=;
 b=IbhDdaLZzKUkr+zndGWD+t4bG9H7Wpc6EUMeWVF5v8OyLIcofl/cux+Nf55Sfe7bknHX67UVbhBj+cVVYjy/pI0q5tv7v64+kNjL/KkN7i5zuTkcUMW/IplXUU/zWHvOIfy16g2Cgpy6EIxXhzV2gelIJHhCIjz08BpKgOH7Gz3mTGrcsicPpo6XM+oQyp+WGld5hPFeaEwVTomELDpsqyTgwRfwm9aD/PipCXyVO1ngcGnXgNwcKeT+ZkviuMIibL/jCf8EAKw/DlGQKhMrs5WcUjwcEs70+OJvyHPgm8xUvrspgn9BgnxcOAr7fiodyK1oHs8bHbDJzvsZLGqBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlmMs3m0DWSHmWUA+E2qmqtOr1vAPfJUL4zXUbuLY2Q=;
 b=OecgUX05fHlE+I25XtkNIpgO4N+eUqR9c/YJ9TDm2gaZk0zAJagKRnDhOfYVOD6hMeOS+vPMWipC+FhKAiHKullctFyoXJVELia+8OayPC+hcRWDXkx7N6E5Ns6oig+UuK7+GCni5ZmEYVFL6kZoWIvVU1E5Z3xOu4Kgsj6psV2ixrtGR3PZ8y+RiNr7hi4k/qPCWkRhUh5oNHgeOeKMBzpy6CFsztAAjbARDrPiP6BGElVluFPLUGXgW+bASDLV73Lp66wjU1et1s6NgPH4md62ZSrsPpHvmCYhKO4MM5Uhn6cyrkfLS7yZV1LJpdtIUHYHY1WnJwCpAbKeXkFIeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Fri, 26 Jun 2026 14:56:10 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:56:10 +0000
Message-ID: <c2a42624-2ac2-4f70-8882-a63ac5bd01e1@nvidia.com>
Date: Fri, 26 Jun 2026 10:56:08 -0400
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
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 29270998-91f2-4906-3d7c-08ded3930f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dzdJQvHOaHc+i7D0OqmjRXgFLYmHYX4lCyKoaYdlG5+ZTUU6g6+fOUzS75pCtrEYjqtR4SFlt3Tzg9Rb0N7dj/cR/JdQDACtdoD8ItArKUg4/xyA5n1CKrM9+GWncJG0LLyvwgCdm3URWNAJHhnyMA0TxzXs/OTed3+S8c5lCeqhyQg9yRo3U97mS32RWXpJH4SOj7fAPpVWsHOeKRxhN5eWKGxbSXqPHNMX101Z0vgWKSzcdCpVeEVdRnLPoP64bfIbjpnneQ3FtSJMM3tCgA/ec4UwdgTm4XBXDveGyzpMbQ5NX3bF4caX4pFdsj8w7Fv06ydqYgjJktX+xERGkHnKsVKvQzZQfFJbrgofPMZRglk5VLYnuT1ApvVTiPcgV4gGa71exvry2dYs8cFhpe8IDw7Z2S65P5tIgeUmlWf7/3dKcA0EzpJRLjtCNwcIFk3XSWe7M4VQ5OjhPYBrwbnnI4RmBosyqDS+NxWy/vQneQ0Y/+SBVHcP8rESjLe3Pahhrxqd7Gf/rPSXn4cahfqxMGVEv8R9EU37y/qkjU14pcb8fEZSZ7G7UAewjfrxzshZoinshOe3+I9gJd5r47cYdIoBOmS0Z+g0w1orvmQmvavArhM4An7bv4i/FG00FwBTi6HNr915erpwOWXlEPUk9+X6qzAQt9DMszZhJeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUpMRExTRzhuZ1VPTnRpZzd2OFIwUUZNK0tLWXlsRERhN2dDK1BWSkgvbU9z?=
 =?utf-8?B?TE81MXpvd3oyZVVLYmppOVl3cWhsWUEzV3RjdGI5czQzSTVmOWNtVGJwa1FM?=
 =?utf-8?B?TFJMbDFmS2RDVTJnQ1lpM0Y1UTFDTlJ6UjJobkdIZWhPYVByQmVIWVdIelFM?=
 =?utf-8?B?NDgvSXk2WXpyelJOaGZEVXlpQzBKbmllSjZ1NzBoVHZFTGxNWHp1dzhLM2JX?=
 =?utf-8?B?UTdYNXJ0ejlCUllPUU9FUlN3N1ZkM3U2MnZxejM3dlZjMUovS05WaC9wc1Jv?=
 =?utf-8?B?bzYxOWthV2M1dVpkUGlRZDBaRWFjNnRSdlg1ZWR5ekFOQ29tTVRtRkZFc0NI?=
 =?utf-8?B?YlAvNmVlY2IzeFRxNlZDRVJldDFVd1E5KzFWMU5kekpUWTA2K0ZncWdoc280?=
 =?utf-8?B?TENoYXlWOVlXS0thSzZlMzd0UGt6MFNuSnErU3lwcjFLL2JYTE5LYjJMcjRk?=
 =?utf-8?B?WEdPUzBsMDZXYVdrK0ZNN2U5V3FhTFZ2UzVlcVNVVzQyVGtxczJTZXVnNjZT?=
 =?utf-8?B?bmVpNGdQZ0VtOGxOamJoZ1lqUmZtTWZJY3p0c3JkTWJaaGxldFRzQkVVLy9Z?=
 =?utf-8?B?dDlISkxVU2ZGbldCZ3hlTGYxMGhhRkZ3MG84UzlJWkQ0NURTZXBzdWwzdDh6?=
 =?utf-8?B?WEs2Mk15aHpsOUFjL1JZalZ6WnVTYkRxZHg2VjB5cXFHNEpTRWIvenRGazNx?=
 =?utf-8?B?TlAwS1FoYW5UQjFOYTlVNkorN0NtWTAvUlNidVpBSUlnUnBsWUJkQUgvRkJR?=
 =?utf-8?B?TEJ0S0RZaG1vbGF5RHJOUDVqNCtQa0UvYTJLNVRQWC9RUHNTcEdaS3ZTRVhz?=
 =?utf-8?B?LzFpblVJSEVBSVdodVJySXUyYmNibUc5Qitmd3dPQXhoTkdQTi9GUC9LL3dp?=
 =?utf-8?B?N2dlT1hqbThWWTFiMHA0KzFTRzZzZUVZMFFOam1CVWVlankxZ0MvTHVuTHhn?=
 =?utf-8?B?eUJGOENOdHpMcEVDUVVDYWVBL0RRNDhDTzFFc2I0SEg3WU8vQWx0VEVSR2lR?=
 =?utf-8?B?V3FZQ3dYR0ZDenB3NWFHR3l3YlJXa21QMTlZMjVid3o3YmpXOUdhOCtOUCty?=
 =?utf-8?B?UWhhS2ZRZldTOGlPdmE3SXFBU2R4dGVQUTdRRzhaM3M3aGJuVnJvU2k0RVFD?=
 =?utf-8?B?WFQrUjdzSHRWdVJyU0IxUWRGVUVJS1dxYlNvc0tWNFJ2bnJ0NUF4bnVzcVVw?=
 =?utf-8?B?TWN1WEJnOEl2aTZST0VQN3pjeEVEY3RSSys1SS9acmFNckZSdkpZc0tZcVJO?=
 =?utf-8?B?a2tRT0cxVlRPcWpZMjFXcGZzSDQwNWNYa1krYzZmeUc3M3FONm56bEM2cHZF?=
 =?utf-8?B?VmIxa2lrOWJzcjRMMEJsYWhFU2FlQitwRzlkSHlURU42ZVhva0tySFZ4SmI5?=
 =?utf-8?B?TnNGNkpFcStjbDJranRoL2l4QmRKVTM4ZDl5Vzd4YjRaVk5SUEVGTG9IbGR2?=
 =?utf-8?B?SDhLaWtKUlM1NWF1dlJCaXpvTHNSQzlWcGhWVTdqY2grYUJ5RUZ0OXVOSERP?=
 =?utf-8?B?dy9FUHZUNjB4aXlMMWUwc1hZci9xMHcwY2xMZWFhSUY5SFNNbTJlN3VFMEZh?=
 =?utf-8?B?ZWRqVFJiVTMyS3Y0eXhiSlo1V2ZxelhLbU1pNTFJNWVqWXYwRjZXWnJDOWEx?=
 =?utf-8?B?QVJYck1jQnp1VVBGQjJmT25icGU1MXlIK1VIbnl4Qjh3MWhDU0puYmhmMHlQ?=
 =?utf-8?B?VUsyeXJNbjg1cHJiNDNoWmNkclVjd1A1RVJpRlY0bGx3YkJhWCtKZUIxbzVO?=
 =?utf-8?B?K1RzWFVxaUFnaTlHZS9kdTZjL3JTTDdUeDZyK0NiU3BvYzBJLzY0Q2RTcHFQ?=
 =?utf-8?B?SkFvdTFSdjVSK3BqNUhTYmZueXhST0l0VERGd0FvaHVDRVh3QnZFSjlQQmZp?=
 =?utf-8?B?VmQyYkdMUXR3cEZXR1VQRDZJSDJXbzc5a2JnZVdPVnc2SzA0dTlQVkswWVJH?=
 =?utf-8?B?bW8rVmhKbkZQRW53UVROdm5SYklSUlZuUWU0V2JIajdaZU5MMnV6VDVSd2hi?=
 =?utf-8?B?RHBqTllMYjAyQ2tFQ00vS3R0a3FLZVBNMHMyckQ4aTJQMlpwZW0yZktxVnl2?=
 =?utf-8?B?VWRUZFl6VFlNTlJEaG9sdUt5VHE5WWcwOXZZV2pPNnVobEl5Q3QrV0YwUFJO?=
 =?utf-8?B?cFpidWNtSjZ6MjJVTFZQTHZjWUxwb212a1hadkhKVjIrc1V5ZDJIbjk2dzdw?=
 =?utf-8?B?NFpaa1E0UE10NWgwWk42aW55d0lYQ3hyRkR4MGI3MXB5eDhaVlJ0dEVoQ21E?=
 =?utf-8?B?dnRqWjI1K0FxTzVoVEpFVUlHcElKaCs2RXlhWEhzS2VUOG9KSWJtZkhYV0t3?=
 =?utf-8?B?dUc5ejkvNytiS0JUNUxtSE56eUp2NFRjcTQrcFgyMks1SG5vMmdEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29270998-91f2-4906-3d7c-08ded3930f4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:56:10.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGb+Pv3wNPNrCFmbl1HCQkW5VYl3H2mXnt7lW99LZco4gQQGkuFL9y0X7jMaLXgpmHq3aT0rKQFvocvZJcNPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656



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

Additional overnight testing with the patch series passes. Perhaps ready
for some linux -next testing? Or do you want to test on your end as well first?

thanks,
Joel Fernandes

