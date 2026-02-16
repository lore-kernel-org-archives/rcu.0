Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FE946C;
	Mon, 16 Feb 2026 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277582; cv=fail; b=dXdDL60P2tqpnyVhsEv3pxDEeJwcl6Cgn6TRyzgcQKfRsGJhoIFHcMill9amkGGiMyl444YCTQ3KDhlQLrmab10tGCPhes177vcV8Y1yRfiHTzgVTvmbed2z5+rlSbgJKDXGIvPn7SqlH7cm2HBxsUxQiGTfCIZEEJbaYgIGoC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277582; c=relaxed/simple;
	bh=r8W2132U165a38PQwJ0jnulWJgFLttp9KsPoxoNcn0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LytBxLkY61nnGZ3IsCfMo+TeczSOZ/LYvsyU9u+O3jESd8Cz8RKopojwP0BrIuPOmDHnp/VsG8du1Z7lEDfzcnFaxA4jnLDBYQtyrPGxtbNC/6pkBk2jZ10UUuJbplcyylnu+dpBS39W2HjU9kDrNiVv1fXOczMH/N2cVgcGO1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBhmpDs9; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBhmpDs9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpkyaIms47oOFIFgY6ZaL/HU3lSq+/aA6cmg+uF+ENj/TcOGivYtdOfoSfa5+Vw4jlxLeDBuWqRCUCa0gLa2v4l/Zlz0WJvCIYmlzEGmRZ8ydIY63l+UtqWYUWip0KHSUvm1McucjWUc2gMsjh4PzjL0gQooyvwWHgJIXZYk+86ctDVoo5Hi3WKSBLfCf8io6EE/ADbIH0iHZPhsMCXmc/Kz0CrbjdVkcXjhDjLru70DvhsB4F5IpCULJjsp8BXhtdAPCbPmjlwUNbyD7tlsMc5dltrs8du2TEptHfLZ2gVi+Qhc1FnuWcPrg2kNW6sLh7vwiHLeu/a3FqXn4re7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo0AqryZN/Ia9MoiafNsAuVfzry89HbCyj348aHwNiY=;
 b=ESDJ4J9Ao0a0GLOn3seh+Em61TNqJjI+HbokzPQoymKf89KZf7tg5sQoj2XGtZYT7Lbn47TR5SWTN235fGjHBpFaGxu2inEf+cVNlL5q3BfYogqWe8WrLSicHNKi+vtr5GdwnOte0f36pKyfCnO+KVheDIkfjnl4gLY6cr9yR4pEx/Kg6kKdZpbjj/qVyEiNzmbiVFycehRQqHO07VCbCVTgXaM5OvaP0jiCCBqK2aZ4DtFPGp2p1qsjDlgtQI61T4bi76Ls8Je2yBmo8n9wDUClMTRIuz5EHHqm6lkTyvewLWRSyGfs9bzqE9Hn3TbILClXSwyVtxIKBAsbFolxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo0AqryZN/Ia9MoiafNsAuVfzry89HbCyj348aHwNiY=;
 b=YBhmpDs93xLb/gooC4GsB2hjBGXWqOUhL/z5mtzp3uvsM5YJmhzLFqP0t+VXSlgzHmsqqvjIHcfzVLV6OxzbaDZiyithLF0kt52PypGxfJmrBRJYNg7NyyIrr+PhTiWR++Icdpdby2DPbaa8lfju0Y5AjD9ZPPNZxg88nVtpBnqMJ3uTrPuPLbs0gmkOfFmZmUutP8ey3oj8RupB+L1/+Uu3Ig9VouX+CTk+RJnXWILIXYwvv/uMPIMAsKul+hck+f/3XLwhntm8rwtKbYwL2epODhQw2qvzQRbM7TSkwiTCwHjGtMbyLHF3RQ8uMX31XWVaAcVgolzjR8jrwWTlYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:32:56 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 21:32:55 +0000
Date: Mon, 16 Feb 2026 16:32:54 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH 6/7] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <20260216213254.GA1469635@joelbox2>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-7-harry.yoo@oracle.com>
 <20260216210755.GA1320175@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216210755.GA1320175@joelbox2>
X-ClientProxiedBy: MN2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:d4::32) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6534fd4d-87d4-45c2-f2b2-08de6da2f2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?slXnJB5LoW7i8v0zX3XjWrpbeIgAz/9R7Uss8FMe1LIc5z8qecnJ6o6xBejt?=
 =?us-ascii?Q?QeLMWMT5BbtQflx12fQiypTlJTuimGyKBjJyHvezPfRN1lGS9woN7cCiSKIB?=
 =?us-ascii?Q?3+heenHMvStJRXTw2RKqnwBsodL0/Tx3eX+84OBt0OFyrgInGNEYdLMJ1DD+?=
 =?us-ascii?Q?v1ZnQ1h2LmEBy4iuGtZId6quYinH1juPNJnxyCdqAQnRyDtjO8cWy6dzbWd9?=
 =?us-ascii?Q?Lupe1Mi9EoRMRPieFq3L5Jm/UfEL07RclCQI4BAzmnzx0+4MxsJjbBr6fiMf?=
 =?us-ascii?Q?GKAbdhDebrIt7KFl4gseFKbPI0v94rrKTz0jSmXR5DL/EIDhOR4qqYQC99B1?=
 =?us-ascii?Q?GmO+K6gVe0VJ9oPDU2kitiZ0+mMvPavdLcbSf2E4rgklt9yo8noZJhgoh9rG?=
 =?us-ascii?Q?/oL5IE8IxYAoRq/VXd9sA8CRKBvV0nYlGdMjZv/DEYWXTPfA81ffWq/3CWEp?=
 =?us-ascii?Q?6NmyRB341lKGS56y6VqsEuup7bLJWElpzFI8TGUP+tbGrEAIdVGlOKk6osXq?=
 =?us-ascii?Q?h+tBn0Nt/AOYlXr1gSCrD28J7V/zxKitLjsRVgrwlznuXDZbgH8ktjEpDiUU?=
 =?us-ascii?Q?jDEze++X9ffYHhmecJlQH6TNt+P04zhnZ1qwCGqKLbC9J2Iiu/Sux3lFjYwU?=
 =?us-ascii?Q?4a1bIA6QSyBnnO8+m3ZUB/IcMOGJg8GRoTm63KmH5aNOLuleUU1K5KqOpPt+?=
 =?us-ascii?Q?/H6PxEH0QYNFxD+iYaR68F+Z3+E5ooGELbZplqJFH2jWyIpAyP/878ruQzJJ?=
 =?us-ascii?Q?5h2FQyiaMc89oRYHzhmhNymvKxJWDZ3X+aCIWH77iEtNtmXrr0kkJW3lqezV?=
 =?us-ascii?Q?X9dvOr3Y1XfuMB6tCyzRR+BwQVJuZXyK75GibdToYsGRUaBybRPCiOsnl56l?=
 =?us-ascii?Q?/w6TIY1HQnQWuBKnqbkrhprHL49oYBHqMecQoykTd9kZH8yq0lwKWdjKjsCT?=
 =?us-ascii?Q?4POhTY9qaI/6sV7OehDcYPRwL/FMHzLug9pfpTsU83J1HZrYqiM5oA8i6Ln2?=
 =?us-ascii?Q?Y74+6iIx5G7U94AC9pyavmg6rrwmK05mpvNDdS0dHhBChqWlxDiEV//ueLBM?=
 =?us-ascii?Q?c5pgbxPAvbT1SIQ7zuBp7yEXxkaR7InghSbRVCxofOs0lx+wfFR/NsBo1wBG?=
 =?us-ascii?Q?ZHZhXFQbvS1tbbDd6AZs9JtXYDUZBW7y63HeZatZcLHqhZZi/kkHv5fqk0Fj?=
 =?us-ascii?Q?/olQCZnzNyemzZtR3HL7DcuOuqH0t2c+kTC2N1alHmoHPXjx0NJl5QKQIJdB?=
 =?us-ascii?Q?xYmr9uPQsv3cK44xJF+oL+D5+ggh4V80M+EWXDIo0nND1215+Tm/cP/UmAmx?=
 =?us-ascii?Q?r6sutM7L7auBDZ5Z0OhYI/5m3nrD5ALUaO0ZzfaG60ab3hvVPm3n3/bJhWhU?=
 =?us-ascii?Q?s4bz61twyB3ISxbOT4VDNvr7Qnhp+YmBLrOW+Ku3M5xwYNOcitksCZtDzqu7?=
 =?us-ascii?Q?EUtnxJkYC76eInJuqooMERhXeP79Ah6lQbm/4LNQ5EJHvfFs5OvjKnxibcuY?=
 =?us-ascii?Q?nVbl1SyFS2mp9RiHSNVShEA2qPhYxPxdQ+73+AJsuvYQZ3LP93Y+Qo3F6gpX?=
 =?us-ascii?Q?XvkjNpnrzNnrkh6XGhg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tGGnSUkXjWkJIMWxvG3vQL+u3xAbPO3hO1KcKfO2fcTK3NBgiK1iyjKqjDkQ?=
 =?us-ascii?Q?+VQS9mX65D9/NrJY9dwjyqlvfc/n1eTZQp1idXikNnyt2RgqAxV6DICWrks8?=
 =?us-ascii?Q?AKg3d2yJ7yQ2qiBN2+15Dd22C+JvD72T+BKpCCpmTv2J872ExPze0ZZwrIp4?=
 =?us-ascii?Q?fSbWeNzFggAu/PYhXeEKd4ATN6gdJRpwmjMENI6wpSm2p7TJ12PT1OTap7WX?=
 =?us-ascii?Q?bhOR8Fdfb2a9Lh5m+eQz3XaR/Vq7E/eVLPyCPNU76MumKsA89YLTmV40MeBN?=
 =?us-ascii?Q?ZuCC1vdoK90ivYV8ZbhAfH3fpj+dd8YTPDzwk6Cxo+Xi7zpgYEkQGWwNDd6A?=
 =?us-ascii?Q?CxwaPPfMJaqsnW7f9KVUp3hEHT0LiORSfNk+vs+LhCACrwpYbTffz45b5SzP?=
 =?us-ascii?Q?Lq53dUNGF9kttmIGTw6gKd8qnA3MbkO0j/okSq8/5g4hGo3O66PiZ8h1vISb?=
 =?us-ascii?Q?U7rRuktlgYR9xtJs+FI78KRKgUVN+ukttoYDZ7hmVnLMMDyi1SGlWUS+2oks?=
 =?us-ascii?Q?rKrqIkI3EbgxcS+PqCtjPcN9cOPP2nQdFtEuO1F0/oGOnkovykcMI5t9JWvE?=
 =?us-ascii?Q?VMlcKQjvAYavO4Pyogikc4dbugv/XplyKEWDp/RDsxFyLMIQO/ouxo4/yL81?=
 =?us-ascii?Q?06kAekqwwrAkEFssm3zNmL5AjQ6jGuBdXVH49qLVPJDOFxYFpls5Wt1MV+Yu?=
 =?us-ascii?Q?iGt8OHyi1etkLBVwq67RvwMncbdlCVDycpKO9xvhkluo7yQVsk7pRaAExqrz?=
 =?us-ascii?Q?hh0OQbAtzEr9S+gPwPCk8GhHH6bjXZalpHdVsU1f36EX6DvmYaR+pqajV0uK?=
 =?us-ascii?Q?tjQuhc30BHNwDKVY9T8gI6F7yESAY6qgTrk7/O+0SQY5YsQ7EqTCdMxkeX0x?=
 =?us-ascii?Q?C3iIkoH+UJabjup1nEQY4GYZm++d2nut7uCml+zYJmprp1BreDmGljTBZwqh?=
 =?us-ascii?Q?MkkZtf6MG7ZyF2h/e36nsUYZcT4qPI5jLcd4p44UOqtKk9vAPw+GMBKlsk/O?=
 =?us-ascii?Q?e0MWRWECqy5g8+RH7ePLAwwX9To9+IDSCrHL3pNAV6q950JpbZDb6VHBTgCw?=
 =?us-ascii?Q?5sZZ7+x41FD/FXIe5VH4vgE5nw/CIxhRyFJSNlEXuGSDbp1tpXpMGfE0VhDl?=
 =?us-ascii?Q?PSOzQyCXnrE+UPIA27xmYtx7JvK1XBrlPhRvEC8D3IsBJhhMfcJJXG1zuB1n?=
 =?us-ascii?Q?rAGtjYZCWF6QK8MkRCnhIGWcjJx4Bm6mbdfQhVrVhO+JEZPBiOq+LA4p4dxz?=
 =?us-ascii?Q?GXkNgOFvV1udwL8O8CctbdSgtPzpJfifN2XReBdFT+ieAesMYLz9qYFuQbLR?=
 =?us-ascii?Q?egxYaa/BUhQObNtNowpUG9P2D3gCEyxKsy5imbtBkKtMAJpIrXo4XdCGWupB?=
 =?us-ascii?Q?VgFSMWkwZsNxUQGbH6HhOVbWlsPNG27NDVZzHLCIjYQw0ixgX4dCBkuXrGfU?=
 =?us-ascii?Q?9DpmoQ9nThxINZZoJOp23TYdL4o/fbYTVm3B9kzID0q0joHcynCHAPUW5hTx?=
 =?us-ascii?Q?pJXIrCMwTRdhN1dTHTxk5QWZzY3COnMeUsKoDHp3lvG6D1UkjzByCo7+NXKx?=
 =?us-ascii?Q?VAxfMK565KaBgonT8Vkqoklqlyi4PTlRSTbB358ichikC+YmttYxJVxIX/uQ?=
 =?us-ascii?Q?7hKkSZLVnNldDJHtZn4ixCYFIn6diAiuJH6hfBj6dfQ1MbY1/P3LjIIPcDkw?=
 =?us-ascii?Q?TG5RoCdFF0+xcwcFd3S3okkvlupfqL9m/F4ejLi8gbvU4uP6xsadfgPr27YF?=
 =?us-ascii?Q?8CTPm+S/8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6534fd4d-87d4-45c2-f2b2-08de6da2f2b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:32:55.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpdAmmZB9SFmsEqSUwkJ1z6dVvO+I9GnpHoJJxuU4X2WkLhx2QLrpeksxyFgjpQXWdhb7X8NW09dmPmGOepyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

CC Peter for real this time. ;-)

On Mon, Feb 16, 2026 at 04:07:55PM -0500, Joel Fernandes wrote:
> Hi Harry,
> 
> On Fri, Feb 06, 2026 at 06:34:09PM +0900, Harry Yoo wrote:
> > Currently, kfree_rcu() cannot be called in an NMI context.
> > In such a context, even calling call_rcu() is not legal,
> > forcing users to implement deferred freeing.
> > 
> > Make users' lives easier by introducing kfree_rcu_nolock() variant.
> > Unlike kfree_rcu(), kfree_rcu_nolock() only supports a 2-argument
> > variant, because, in the worst case where memory allocation fails,
> > the caller cannot synchronously wait for the grace period to finish.
> > 
> > Similar to kfree_nolock() implementation, try to acquire kfree_rcu_cpu
> > spinlock, and if that fails, insert the object to per-cpu lockless list
> > and delay freeing using irq_work that calls kvfree_call_rcu() later.
> > In case kmemleak or debugobjects is enabled, always defer freeing as
> > those debug features don't support NMI contexts.
> > 
> > When trylock succeeds, avoid consuming bnode and run_page_cache_worker()
> > altogether. Instead, insert objects into struct kfree_rcu_cpu.head
> > without consuming additional memory.
> > 
> > For now, the sheaves layer is bypassed if spinning is not allowed.
> > 
> > Scheduling delayed monitor work in an NMI context is tricky; use
> > irq_work to schedule, but use lazy irq_work to avoid raising self-IPIs.
> > That means scheduling delayed monitor work can be delayed up to the
> > length of a time slice.
> > 
> > Without CONFIG_KVFREE_RCU_BATCHED, all frees in the !allow_spin case are
> > delayed using irq_work.
> > 
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/rcupdate.h |  23 ++++---
> >  mm/slab_common.c         | 140 +++++++++++++++++++++++++++++++++------
> >  2 files changed, 133 insertions(+), 30 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index db5053a7b0cb..18bb7378b23d 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -1092,8 +1092,9 @@ static inline void rcu_read_unlock_migrate(void)
> >   * The BUILD_BUG_ON check must not involve any function calls, hence the
> >   * checks are done in macros here.
> >   */
> > -#define kfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
> > -#define kvfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf)
> > +#define kfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf, true)
> > +#define kfree_rcu_nolock(ptr, rf) kvfree_rcu_arg_2(ptr, rf, false)
> > +#define kvfree_rcu(ptr, rf) kvfree_rcu_arg_2(ptr, rf, true)
> >  
> >  /**
> >   * kfree_rcu_mightsleep() - kfree an object after a grace period.
> > @@ -1117,35 +1118,35 @@ static inline void rcu_read_unlock_migrate(void)
> >  
> >  
> >  #ifdef CONFIG_KVFREE_RCU_BATCHED
> > -void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr);
> > -#define kvfree_call_rcu(head, ptr) \
> > +void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr, bool allow_spin);
> > +#define kvfree_call_rcu(head, ptr, spin) \
> >  	_Generic((head), \
> >  		struct rcu_head *: kvfree_call_rcu_ptr,		\
> >  		struct rcu_ptr *: kvfree_call_rcu_ptr,		\
> >  		void *: kvfree_call_rcu_ptr			\
> > -	)((struct rcu_ptr *)(head), (ptr))
> > +	)((struct rcu_ptr *)(head), (ptr), spin)
> >  #else
> > -void kvfree_call_rcu_head(struct rcu_head *head, void *ptr);
> > +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr, bool allow_spin);
> >  static_assert(sizeof(struct rcu_head) == sizeof(struct rcu_ptr));
> > -#define kvfree_call_rcu(head, ptr) \
> > +#define kvfree_call_rcu(head, ptr, spin) \
> >  	_Generic((head), \
> >  		struct rcu_head *: kvfree_call_rcu_head,	\
> >  		struct rcu_ptr *: kvfree_call_rcu_head,		\
> >  		void *: kvfree_call_rcu_head			\
> > -	)((struct rcu_head *)(head), (ptr))
> > +	)((struct rcu_head *)(head), (ptr), spin)
> >  #endif
> >  
> >  /*
> >   * The BUILD_BUG_ON() makes sure the rcu_head offset can be handled. See the
> >   * comment of kfree_rcu() for details.
> >   */
> > -#define kvfree_rcu_arg_2(ptr, rf)					\
> > +#define kvfree_rcu_arg_2(ptr, rf, spin)					\
> >  do {									\
> >  	typeof (ptr) ___p = (ptr);					\
> >  									\
> >  	if (___p) {							\
> >  		BUILD_BUG_ON(offsetof(typeof(*(ptr)), rf) >= 4096);	\
> > -		kvfree_call_rcu(&((___p)->rf), (void *) (___p));	\
> > +		kvfree_call_rcu(&((___p)->rf), (void *) (___p), spin);	\
> >  	}								\
> >  } while (0)
> >  
> > @@ -1154,7 +1155,7 @@ do {								\
> >  	typeof(ptr) ___p = (ptr);				\
> >  								\
> >  	if (___p)						\
> > -		kvfree_call_rcu(NULL, (void *) (___p));		\
> > +		kvfree_call_rcu(NULL, (void *) (___p), true);	\
> >  } while (0)
> >  
> >  /*
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index d232b99a4b52..9d7801e5cb73 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1311,6 +1311,12 @@ struct kfree_rcu_cpu_work {
> >   * the interactions with the slab allocators.
> >   */
> >  struct kfree_rcu_cpu {
> > +	// Objects queued on a lockless linked list, not protected by the lock.
> > +	// This allows freeing objects in NMI context, where trylock may fail.
> > +	struct llist_head llist_head;
> > +	struct irq_work irq_work;
> > +	struct irq_work sched_monitor_irq_work;
> 
> It would be great if irq_work_queue() could support a lazy flag, or a new
> irq_work_queue_lazy() which then just skips the irq_work_raise() for the lazy
> case. Then we don't need multiple struct irq_work doing the same thing. +PeterZ
> 
> [...]
> > @@ -1979,9 +2059,15 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
> >  	}
> >  
> >  	kasan_record_aux_stack(ptr);
> > -	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
> > +
> > +	krcp = krc_this_cpu_lock(&flags, allow_spin);
> > +	if (!krcp)
> > +		goto defer_free;
> > +
> > +	success = add_ptr_to_bulk_krc_lock(krcp, &flags, ptr, !head, allow_spin);
> >  	if (!success) {
> > -		run_page_cache_worker(krcp);
> > +		if (allow_spin)
> > +			run_page_cache_worker(krcp);
> >  
> >  		if (head == NULL)
> >  			// Inline if kvfree_rcu(one_arg) call.
> > @@ -2005,8 +2091,12 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
> >  	kmemleak_ignore(ptr);
> >  
> >  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
> > -		__schedule_delayed_monitor_work(krcp);
> > +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING) {
> > +		if (allow_spin)
> > +			__schedule_delayed_monitor_work(krcp);
> > +		else
> > +			irq_work_queue(&krcp->sched_monitor_irq_work);
> 
> Here this irq_work will be queued even if delayed_work_pending? That might be
> additional irq_work overhead (which was not needed) when the delayed monitor
> was already queued?
> 
> If delayed_work_pending() is safe to call from NMI, you could also call
> that to avoid unnecessary irq_work queueing. But do double check if it is.
> 
> Also per [1], I gather allow_spin does not always imply NMI. If that is true,
> is better to call in_nmi() instead of relying on allow_spin?
> 
> [1] https://lore.kernel.org/all/CAADnVQKk_Bgi0bc-td_3pVpHYXR3CpC3R8rg-NHwdLEDiQSeNg@mail.gmail.com/
> 
> Thanks,
> 
> --
> Joel Fernandes
> 
> 
> 
> > +	}
> >  
> >  unlock_return:
> >  	krc_this_cpu_unlock(krcp, flags);
> > @@ -2017,10 +2107,22 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, void *ptr)
> >  	 * CPU can pass the QS state.
> >  	 */
> >  	if (!success) {
> > +		VM_WARN_ON_ONCE(!allow_spin);
> >  		debug_rcu_head_unqueue((struct rcu_head *) ptr);
> >  		synchronize_rcu();
> >  		kvfree(ptr);
> >  	}
> > +	return;
> > +
> > +defer_free:
> > +	VM_WARN_ON_ONCE(allow_spin);
> > +	guard(preempt)();
> > +
> > +	krcp = this_cpu_ptr(&krc);
> > +	if (llist_add((struct llist_node *)head, &krcp->llist_head))
> > +		irq_work_queue(&krcp->irq_work);
> > +	return;
> > +
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu_ptr);
> >  
> > -- 
> > 2.43.0
> > 
