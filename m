Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055407;
	b=Z9Xzc7qE2MgRieVp8ttJnp1uF2H5Z+xf/PMhGS0ShQHWAiiipHf8A8iNSBTsk7YmB6CF
	 YCD0wL0h8LTcmc+Cu0noF5Wq9qmeu4kyQEChieMnyDmM2vE8IugEo3vPUOgMycQGXVrsh
	 QoU7juu25xnolroXl1jOOGtDQmnWNTb4z3wW3aO2ChvZqKGkoiiwlPs9alAnft64QgClq
	 OOiNJqreNxLEOQS1z9rggHXhLdxefisxDBcmYP8NAPqmt8FqFiJCE1FevviiJsAieJjN+
	 sKTdI7s+ndaNhPhLdmK80LiwX7HU3LO0Y+YtwUupu2hc3844CQPEoarxw9cFluLPfwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055407;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PzKLJfPxcryCqswfIvVadN3qP0U13DBScd4mTl8dX3c=;
	b=p+u18w+YQcu//hVd0Z84iDfEAvUt+jCYqIuMX0KGmHbB79mhdO6U4SurYuqaK88Hpole
	 csWHj9Iy4lQnKckgGHSAb0gCIaXKLqn5iMsKbzCj+TO5Q3asURN8Kk2sntE6YZ8XSCDev
	 YWXSq6Tbbf400AtIvoYuBYOzxZEjod6p0lsC9vu7Y5pgOZjSAx1q1arLm5xWGzwVx3AwX
	 oWCGzPSZDoqxuuKR4KfxoaFUUgRe482ttNGa48NkRqEiepIEvaYxnpo+iHNSVIM22iooi
	 ctdMC7cVbyVfhCzEYDjrDPiNcgNoTpLRJXFwnrSccI3h18mORKwRr2C1tv3QH4uDqow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XGn0XJVv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03E606A31B;
	Mon, 26 Oct 2026 22:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D03E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XGn0XJVv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI8FXSK3kakVJ3IeN0JBr0p4W8IHVwKxgRs9nRS6ONcqx77O3Nb1ajThbWM5zJD6dgmvdTPoGnaYmOYu3PhJflMPDIhZQjuYBcQ07x0JWAzvJdbCmgj/kreTvYx6u5OUhi5macppOsYSW+xJRYyY2p6Zk7O/Keo88rCqCdza80Kus+35jtzBk6FAUsglV5wqy/RQ9oz4zC18sB4JzSE4HE22mh0sOeBDQHJlW3vMubtCTpD+uCecxpoiV5mTyiHCFjM/BUx6RWmi50O57BsbKcV9sStaLBh3yMzns8VXc42GoD7vfj6ejqPoX3QRqxuximY4iZF0QdOHaZ8FYZYYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzKLJfPxcryCqswfIvVadN3qP0U13DBScd4mTl8dX3c=;
 b=vm1T/D1duRsaDmIKUVVA2I8s9TbbA+rlbh2JjHphhjsjZm5niQskf834Geg3HwleWKIgDHOD7QfnTATbvu1bC3NyXUBjSK4BCbCRCZmstB3bAuCWc7o2nH4T2c16NJ8UKPFtftLP5Yx6Wq5lzrDcJZWbBZRXl8Oyeu5AqTun9NIH+UPVJb7ladkNCab84sEKp1ooXxsDZeI83Sm8pmWkiq3aI2N4RKbwBQDKbBoZzHaFyvhr9n1r/oWHf8ECjLls2QqK8hGbDB/hsNV+maGJYSOE4fvTnJAB68RqtPGKP9cA0a4cC5XoEsQrCvpyLmrPOHCr2uz2QvWIKWoo0wqHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzKLJfPxcryCqswfIvVadN3qP0U13DBScd4mTl8dX3c=;
 b=XGn0XJVvGWWUQ0gm9AgxSBsyVrf9z0VdTHQPXQ8PBoLQ/WIla/Fn/QEerCnmAJobzOrtAkdxLoa1b8lfjD1m7gvWMJ2WjUIbxrIzu/9jAsG3W5nnut/HmGaPhD+ppGABJQ/XjGJ0MGITShqk80GzGgN0bA+P3ShFW7NHsXY2ySgu9Iu8OiknQuEb6vX4mJ4/wK+MYVw0rFJ0d3Sj3bcxlWMvVoXz0OacdrVNIQhAynMapRUOM+A1p1El5ko2ZxqIhWc5RxYTtGZwHed+hG6oC5GXRShF20B7jBkqT3eahdcn+Lg5r3u1gWS4/09hsE/8WXyJ+RzCPn4Hr9tDOw2cBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:56:43 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:56:43 +0000
Date: Mon, 26 Oct 2026 18:56:41 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, urezki@gmail.com, boqun@kernel.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make tasks-tracing support duplicate call
 testing
Message-ID: <20261026225641.GA487528@joelbox>
References: <20261023094039.29696-1-qiang.zhang@linux.dev>
 <3d92a635-7005-4f46-8cf3-091575ce0567@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d92a635-7005-4f46-8cf3-091575ce0567@paulmck-laptop>
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 94010934-4cb2-46e8-db6d-08df33b46773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|260925021311599003|260925021911599003|260925022911599003|56012099006|4143699003|11063799006|5023799004|261022105027099003|261021121427099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3HfiCTH/+bYGcytpAR9xLBHBl4J8PlE2X/zZ6WFr8orvnBWnIoNgrNvRjDJdTqc8Ay2Aq/GTf3W1YVUpt4xROAP9neQzIsMeWxpLkgWci9A4Q74X+U20m/xXtYlrChX4fm47KPu05nkLhYH6CYP1xNfQJBxlVWGWNhy9hXlrHhU9oYNFvNCwd1QFuN1QuHFIiqV2e3fsxWUwv2QcX5lZcV5BJWSITxuwDfZ4dl9R68bLQsfYDVhZJtrJmdysBIeeHdh5EGotf1atBBZOgG8RRizh7K3pBOtpHm+KGNybRErHXOe6Wl+bg9AV1GpfT5ypUn1MYLez4xWzrN6qkPG3vaOYUZdmT/10rNBszxYl57uDVgf6PsByFEG0BjMsSI7Ew2tGlawEek+XLaeOAcxFK26vp9QaEvY9m3qx5iSI8N7qJ1RoWAXiclwvxfqdKg3dUK8JpA394FNRnFi5gGvE5yj8cwQi7ZRMrPcTdLndJk9iTKrE9BE0zmtuU/WECMAR0siotdAfiP1Ze3Uyi39E7IDIG9aOtHJ4h1PJLknh8CdP3+e2hBksnsGJsS9OuaGxzzW+kJgoU5WT4xrHgKR7xaZ9Nug9z6SKHUYT5dJoCK+96mKcSQU7iUjrqa0FGw/AtJWWI0b3cB+QXNidLkS9iWhD1fNNH2udoHG3LoX/Bfk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(4143699003)(11063799006)(5023799004)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rS6ohg8czfwMyj3F3EO+oC9Oo0lrH0cp3mDRm4wM4y9E9bK2WndKx6MBVda+?=
 =?us-ascii?Q?gseU3Zgj7GXjxys4Wcw4Ub15CRr6A30xTD1iyYGkldy4AGNHAlmi7WKLKhu0?=
 =?us-ascii?Q?XFQ11mnsKfSs5sMoJf2Z7IiQwkwOe9p6RjcBq/mDpmMieVFq9UFiRzbDxKtG?=
 =?us-ascii?Q?YJeH3/41ZIn7IWhZmGBOGzwgfKFvHYF2KrYFARutEfTPeiYRW+xZcTQ4ODL0?=
 =?us-ascii?Q?24qgJgcZTz7yb1rQ+RSSiH8DtIb1e9y4bBmjLx5qZKBKRj9Z42z1xZM1Ci/9?=
 =?us-ascii?Q?xnJ9pPXLgFRQQBwgHyW2ztBrLohcK2wqIZibatBf/J/FHLZ0UlKXOKBa8DuC?=
 =?us-ascii?Q?uiXHDOxJX59SNK+8q5ZrwCcRFPWMkkjoxf8+zCOz2YZ4xfj0kkKapRzITyjl?=
 =?us-ascii?Q?wFHQxtnhl6iQ4OFiWHUAKc4e3uXtYXF86N4XgQ5TqcqlgbJhXPzRb41Gamyg?=
 =?us-ascii?Q?2y72wwmhwlPHiWH9BzDNRkaCyfidrrXRHv2PV7bHY5xka3JbDQEGcDd7POPB?=
 =?us-ascii?Q?apHo/clQtajqCGYWHt0rno30qwnkCnaxEPFUF4IPW22tIkVSWEyy4Nbczxky?=
 =?us-ascii?Q?T3C24TEMKHQ1SBjEYak0Tctfc6PcQpUND2T6Q1vHm3uLo4XEO+kT0iH1YZxJ?=
 =?us-ascii?Q?uQFW5dJRuSBHEmCjpyDBk+CWN/5oJwfhlng/wMM5i3wU9TC5wzY8RTMEp0zT?=
 =?us-ascii?Q?BGI+L7Jejx+KrDSbAzLOBPanAZVrvJy9pNd64XiFx4NWxzSx+qVuB9oFE/fX?=
 =?us-ascii?Q?MEWrpZdo1WgavYRFRZ8gRRlMZOEHR6doQaR7UiRY4A8WyLRV6SdAumKJoixG?=
 =?us-ascii?Q?CcwAyaQflZg2rnu7QFbp4sQVoZZF7qLlARB2UoXAHdn6AS57zYk6vAyYJo3z?=
 =?us-ascii?Q?/3y8QwV/OW+7ECGLKjU3QAe6D1f5S/1Uc/k/peJX31KB6JGrrXl1soAjLzqe?=
 =?us-ascii?Q?oFAQecN9G7Q0Zb8cNwFtBtwauDCBISAOiE7tmW6OCsrOCHKyitRqAHArszE7?=
 =?us-ascii?Q?77hZTm93t4dyzabDQ1JfWsfIqstUVU8xmRS2HxJWfQMYNaTi4tCJ0AosllVZ?=
 =?us-ascii?Q?CN/3S5B6kFoq4K839D8bVgm0g9hUdX4bu0Xb4Gz50TaJGifNPYD7dReUeaJm?=
 =?us-ascii?Q?hGazkmlmKBPRmErwIP8SiU1PExtrpyQ400EHeaIuY1Rrub9tv65d1EYUQku+?=
 =?us-ascii?Q?jIm053UYa0eWWYqE5wZ9DOH0+uqSnvuxWB+jig3DUVM3rP+W8iHyAeo0B2R8?=
 =?us-ascii?Q?Z6FI40pGCwQwm6vPr11o6aCQptPqcsKbAgQmAaIIh7NgKRlc7xhEoIXU2ifP?=
 =?us-ascii?Q?Delo+P9Ye2nf3yvi7+uzg6kU1NLJKIMWVzuWjGxxl5pTgdUdEO11zyJtuCqB?=
 =?us-ascii?Q?SGIkgHUzzBDIlHaTodtFx8ack6RqQB6eMNBPNhw6gk8Qn48g8QxtcrjDd17Y?=
 =?us-ascii?Q?c5Y7PDpT27OnbAF+2fKi2X5q0UWFQlqoA9tzswFl8qW1x2j09nI8D/Nzzni+?=
 =?us-ascii?Q?EIaRyc1UbN2eueoplktqVgR9PmMirSRQA+xaXWzJF/nmmON+/uSeQljqsxe8?=
 =?us-ascii?Q?uxDlQi3M7BpiBLv2Is/mgNj2BtNs4Z/VU85rTEQ6y8LM0qKOlE+wIZ/sLWS4?=
 =?us-ascii?Q?F0EjyGKHvaS5SU3jEkB3iLnL5OlvvYZBvNZdHbOrZxKaTdDJG/VaZ6ZPaivs?=
 =?us-ascii?Q?RaXS7dzPVKhF8v2SuMm2LY8LeZpK90sasGPs+KsdwwMFzEk2FmHs31nQWHv/?=
 =?us-ascii?Q?U8V6xvCM2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94010934-4cb2-46e8-db6d-08df33b46773
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 22:56:43.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHdw/4mg6kmr/ZJB6O/l79czL87ST9O49Rq4+H8b2Y84zqn9lJ3Nw/aaVFXUl8b2Y2ZyS3CyzVr8byIbGGrkNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

On Fri, Oct 23, 2026 at 12:12:41PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 23, 2026 at 05:40:39PM +0800, Zqiang wrote:
> > Currently, Tasks-tracing has been reimplemented by SRCU-fast, it supports
> > the detection of duplicate calls with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
> > This commit therefore set tasks_tracing_ops.debug_objects to 1, enabling
> > rcutorture's duplicate-call test for the tasks-tracing flavor.
> > 
> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Applied for further review and testing, for 7.5.

thanks,

Joel Fernandes

> 
> > ---
> > 
> > Simple output from rcutorture:
> > 
> > [    4.120772][    T1] call_srcu(): Leaked duplicate callback
> > [    4.120776][    T1] WARNING: kernel/rcu/srcutree.c:1516 at __call_srcu+0x463/0x580, CPU#7: swapper/0/1
> > [    4.122665][    T1] Modules linked in:
> > [    4.123026][    T1] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           7.3.0-rc1+ #110 PREEMPT(full)  8fac67ca5e4b530c23977b2e660a83979ea107db
> > [    4.124328][    T1] Tainted: [W]=WARN
> > [    4.124687][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> > [    4.125583][    T1] RIP: 0010:__call_srcu+0x463/0x580
> > [    4.126056][    T1] Code: 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 16 99 9f 03 80 3c 02 00 0f 85 e8 00 00 00 49 c7 46 08 70 cf 4e b4 48 8d 3d ad da d5 06 <67> 48 0f b9 3a eb a6 48 8d 3d af da d5 06 67 48 0f b9 3a eb 98 0f
> > [    4.127823][    T1] RSP: 0000:ffff888100e87a78 EFLAGS: 00010246
> > [    4.128389][    T1] RAX: dffffc0000000000 RBX: 1ffff110201d0f54 RCX: 0000000000000001
> > [    4.129111][    T1] RDX: 1ffff110201d0f8f RSI: ffffffffb8ae6d60 RDI: ffffffffbb255590
> > [    4.129842][    T1] RBP: ffff888100e87b28 R08: ffff888100e87c70 R09: ffffffffb818a820
> > [    4.130572][    T1] R10: fffffbfff76449ac R11: ffffffffbb224d67 R12: 0000000000000001
> > [    4.131296][    T1] R13: 00000000ffffffea R14: ffff888100e87c70 R15: ffffffffba4c4220
> > [    4.132061][    T1] FS:  0000000000000000(0000) GS:ffff888239af2000(0000) knlGS:0000000000000000
> > [    4.132903][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.133536][    T1] CR2: 0000000000000000 CR3: 000000008a8ea000 CR4: 00000000000026f0
> > [    4.134283][    T1] Call Trace:
> > [    4.134607][    T1]  <TASK>
> > [    4.134898][    T1]  ? __pfx_rcu_torture_err_cb+0x10/0x10
> > [    4.135425][    T1]  ? __pfx___call_srcu+0x10/0x10
> > [    4.135870][    T1]  ? __pfx__printk+0x10/0x10
> > [    4.136301][    T1]  call_srcu+0x17/0x20
> > [    4.136685][    T1]  call_rcu_tasks_trace+0x1a/0x20
> > [    4.137143][    T1]  rcu_torture_init+0x3033/0x3800
> > [    4.137617][    T1]  ? __kvm_handle_async_pf+0x21/0xb0
> > [    4.138094][    T1]  ? __pfx_native_sched_clock+0x1/0x10
> > [    4.138608][    T1]  ? __pfx_rcu_torture_init+0x10/0x10
> > [    4.139109][    T1]  ? add_device_randomness+0xcb/0x110
> > [    4.139637][    T1]  ? __this_cpu_preempt_check+0x17/0x20
> > [    4.140160][    T1]  ? lockdep_hardirqs_on+0xde/0x160
> > [    4.140653][    T1]  ? _raw_spin_unlock_irqrestore+0x6e/0x80
> > [    4.141211][    T1]  ? _raw_spin_unlock_irqrestore+0x53/0x80
> > [    4.141772][    T1]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > [    4.142291][    T1]  ? add_device_randomness+0xcb/0x110
> > [    4.142828][    T1]  ? __pfx_add_device_randomness+0x10/0x10
> > [    4.143397][    T1]  ? __pfx_srcu_leak_callback+0x10/0x10
> > [    4.143937][    T1]  ? __pfx_rcu_torture_init+0x10/0x10
> > [    4.144440][    T1]  do_one_initcall+0xd9/0x620
> > [    4.144878][    T1]  ? __pfx_do_one_initcall+0x10/0x10
> > [    4.145390][    T1]  ? __kasan_kmalloc+0x86/0xa0
> > [    4.145963][    T1]  ? __kmalloc_noprof+0x2c9/0x610
> > [    4.146576][    T1]  kernel_init_freeable+0xb00/0x11a0
> > [    4.147214][    T1]  ? __pfx_kernel_init+0x10/0x10
> > [    4.147804][    T1]  kernel_init+0x28/0x170
> > [    4.148308][    T1]  ret_from_fork+0x7be/0xaf0
> > [    4.148880][    T1]  ? __pfx_ret_from_fork+0x10/0x10
> > [    4.149512][    T1]  ? __kasan_check_read+0x15/0x20
> > [    4.150111][    T1]  ? __switch_to+0x1b0/0xeb0
> > [    4.150778][    T1]  ? __switch_to_asm+0x39/0x70
> > [    4.151324][    T1]  ? __pfx_kernel_init+0x10/0x10
> > [    4.151910][    T1]  ret_from_fork_asm+0x1a/0x30
> >  
> >  kernel/rcu/rcutorture.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 1bbf8192786a..c0c8fbdb5508 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1313,6 +1313,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
> >  	.irq_capable	= 1,
> >  	.slow_gps	= 1,
> >  	.nmi_capable	= 1,
> > +	.debug_objects	= 1,
> >  	.name		= "tasks-tracing"
> >  };
> >  
> > -- 
> > 2.17.1
> > 
