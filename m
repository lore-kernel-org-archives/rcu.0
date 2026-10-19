Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA872222C5;
	Mon, 19 Oct 2026 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792371364; cv=fail; b=i6liaxQmZLm4XphecJ9CBD24pZu6ad+ihLkSXPzco2Nr+4JUWREaJZJYsZLY7cHfR2tlk1a4AJu3wpEJdSEt+EeDFzv6I9SnLgHJKp6UIvhf+UwVJFSmTXEd084ibGg6iQzaqqiyRocv1e7PcbP2/9ZuNnX0i9ROldbKqjbQd2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792371364; c=relaxed/simple;
	bh=DB6EMuLkQzs2gue5smo/4F61rlwCUuqnn7dWZFETV/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hS5twdevgjfknB4XFNxgLiTstouuHTlALT1r41QZ1wrOKROt2BFdcDAmo3S+ZcC+YM02C3Yihh9IQ0WyVq5y+NqYDydI5HAMYY8PFMPZ1n093yuSFfDuKaCiP2vxxvOOSkccKkEIRGSI/1/28xdDS78rDDRr2xl1ZaxqdQqlqfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sq7ac2g0; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sq7ac2g0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFBBpUbW/QAfZiRIIzjKgtvZxQZwGF91P8UrS+ys07rYOqD2/lV5xA9QVbhAaFzoXXI6Syw0MOCrRwh+zIqBTdAlPhgBDFqF8yVYe5gLaBQok9jOv+Wr/8p1mJ5uh1lsKM9QTG1qWHkYApIIOwLQaXMd3UCKtG1r7K5ujU4QXV1KomDMg3fKn8nFCIvbn4M9FYTCULt0WEfnjtaazmSJUvrEj+n5VR/rNGvbYdQe3wuhqGPMHHRJ6P3sHGJhjRrf+ZbVmfVArYtZC+HMiqoFmeliSlmJZPc1tRnz2J4X1lGOFPgIe92eKBl+dwJlA+NA15kz0Lj8mcime+vWUn1zcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JN29/8W184kNr4KvRKBzWrvz2BmcU+nRqjH3PnmTgo=;
 b=jjemIYDxCzdxF+CQRg4TlQGXziTs+jETlU7CF4k9Vw0D5YogRNWc39rPA+NJ1FM7YgTgOmrqlNnUS8R8tVDF6Zedz5M4iUBgpBruWA7Yvz14de2p9zbTQVa2zURBaSM27uy/1/DWlu70ap0KZ3cH7Nnvq4//EK2toXtmbWRrO7c0u1AQdUWaX3AelziDYCwwfTT4rBHLz+yb/4pofYu3gZ+UAeEjaKfpZ///pYUSNRV08ULJYzd4eltTwTcs70HDUq4zbXr5KuSHzZ37pvsMMkCpm/b6IryLE2wP7reD2+gGvOQxw8zsyC4J5I9MrG93zWNVVQvMejPvxY2hyTuzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JN29/8W184kNr4KvRKBzWrvz2BmcU+nRqjH3PnmTgo=;
 b=sq7ac2g0s47whwsXl4mU0/sLZ9PLtjMQk8qKKRIWIDr6mMOzzD56LFmwIdR0kVAENJLA1vm62aK9eIB/BEnZRooTR0aaCPesenphCYGc3eVB89Vm1bW4jVutmzeLSXD6lamDjTUquMT/wbN2Jf8SYTQXbs3gJtLmR8HWaRDGpCMAw4LhRBsx8DHIe3MeXo9ufkC0fsT7ku4qZRBmMOvD0+buFVdZLa0lxb2HUvAf14z5yJlln1L49hfRLtkDtdwY+if2ENCPjYkqafN11mUxTfnP+eCxDo3wqDTaZv7Qfz4Z9hkYypYHo3lAknevtNlEwclSbmWS6cHT6vCN5Y7ZtA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 00:55:59 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 00:55:59 +0000
Date: Sun, 18 Oct 2026 20:55:56 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
Message-ID: <20261019005556.GA997610@joelbox>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MN0P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::32) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3e223-12c5-439d-c7f3-08df2d7bbd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|261009223027099003|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ONJMgax/HeDd2TXqebR6TDOMm+o2LNGXz8+M7USM12z/4JMTqq+1ZGQOovA/+xVKIJa8xbWAsdg3cyh/HqpmFDLfBIkrEetTCcO3Z4oG4L4Uzq6mbpteEWYXV7rghOcQvRBTHdOxztaqgwyfG2SXiTC2IpxknrZF8w0QrEXR1DvOjAUO5vs8SV1RbgyaTtsqvb77nGsF31Gd7xyLGFEeoCrGurWR8vHOZT36S37J4OZ+nw9hVmwoSBz89aHpazdnI7pI5+TRrO5BlNmQXPMmxYHJHbw+7yf+lUeKSCdTWxBxH0UPhoQyKFGkJ0ZBatctDrRUV89mY7LuQGUtuJwDaSeNprZtDWKhv0KFDlmhduOkXfN/aDlD8CQzK123s5aBtI5Ja2X5aioYjZZuRv1DM9PcUjxfEVELBOLOBubVT3tLiipClISCnS6E5KfoZbtJfThw/aFqpSXPf2qCh8EWBw6XueKT/0K4mEoQDsf2aMXTkR5X4AJgkAV9xqIqlsHZV3sttRPYfQKDaz+M3LM1FXqRY/SH/6XfJm8pq+xbXPM/Er6TOQxTpNZhp0kkRSItk5p2hlQ//pEHpNvgVUjU6X3KELQyAqzttPVnTgKCh90iUtz72w0NN96HmtBuoKLSiiA/ezRK0A4oXhWl0EO7CUTxMjDYzFXzafQCxitrLF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Ho0/u/g/WNtN1kM80YgjWUrEDDSjj7ubgOFaqv4CypJBMJDSHQHBELmnTmJ?=
 =?us-ascii?Q?zIL1B47XmMdAX0Ccplmy0357LJI4RPPq3E4MwXJzSAzdO/swKj1zKGwJ8vCl?=
 =?us-ascii?Q?zzd2e1N+6BX+4FkzyivOy5OyAZvDVzJ4FrXr32+sq3trS09YTFmnNT5w2RFT?=
 =?us-ascii?Q?KqXOrZrHvV4MrXrJMZ9SOk7cpij5jpWt5G/uZgb8I0xSKWS9+qHZ8Qsx49Yu?=
 =?us-ascii?Q?AYPF7orkhvtBKneMhHIK4/VSlg4D30lAHqH48OvN2wFiOjE9U1IMggttCicO?=
 =?us-ascii?Q?c+9UUONlFZqQmtmlCEXWy4esN/RpNiZq6AMX8PgLXHeyR4YqFZ2FBk44uP8z?=
 =?us-ascii?Q?42Nz5GdPjUVgtwEInID2F5T5/QElXmW3w569cVyAXQiiFnX0Ps3PjtAontQ4?=
 =?us-ascii?Q?n8z5eJiULFPnrG+bMUmxHqv39B+DzmKEOnXi8LsUEo+hFPFAePKImwZnnMCN?=
 =?us-ascii?Q?BJRKwAK/46TE7HRtfNAOnSXMlTwFDnW5x4AsJErceXPgaO+pYrOSvEI60vzP?=
 =?us-ascii?Q?UddhppKagHH2N/uZerT5KMLP9DfFmssccoVgkKJMm2h3Y/MxRkinr+tc+aa+?=
 =?us-ascii?Q?eE6qMj9YRx82I7miRfsBWWCDOM5t1jw3wPHLRbXVm/caEWUEeLd1E5Lpkyfu?=
 =?us-ascii?Q?++FEfHlW9/CKFECcQjbXhLW2/hDDDEHYWBCNUXlOBDy4yPuoy1Ov0CePP/bY?=
 =?us-ascii?Q?oaNUOX3yK4elgD54ZMXlfo293KTMsbSc2JL1op5vsYmNPyoz80pvx9h/p7yZ?=
 =?us-ascii?Q?M3msYWYaORutoRi1niw4MdQKrxX7cY3Xs/BQkD5td/f8NpkxFkkSQ8/AYjGf?=
 =?us-ascii?Q?31sIMKetS/Hle9LPmKBCyXcQtDkUJn26UUA/MnoAYNYYyp0pik+NZs+VaaZE?=
 =?us-ascii?Q?kNalhoN8389Y7XJuEFc/px3CW4QiSHUEsVHHwCfU+SX9BvI6YvAQpUSGjNe0?=
 =?us-ascii?Q?2u7XE23+Ljzn0LgtOuYA6d/J3ZvBTq4pLoqMOhiMeV99sqHFi8SsDL5i25CD?=
 =?us-ascii?Q?CmIv6FXCk44lKlLvF8Ig+bxMV22RbF6FDJLd8qadXW47Q4cMtWbeBEhDveaL?=
 =?us-ascii?Q?emVeDkMy4yeTeEF1wN7WG7iii1UI+1NNPlUi0jEQdM/LliZEdkqMh/ttnrGk?=
 =?us-ascii?Q?3rOKWic+KyGKY2kdEZ/GyXwfpGTPDJ4znjpWcuXpN1t7OA6VFFRciNsy1nf3?=
 =?us-ascii?Q?CHSB9JaWXw0GAoYwquLcsbkdBQdQHy7dCTooTaxe4dHl+ciXW2LeEa0UaSaY?=
 =?us-ascii?Q?U04d601Le6aCiKkpztOewEeo+VisJzW+Xt90xVk6qkF6sZBsbPSQIiNO+xz7?=
 =?us-ascii?Q?DQyEqUi0RPam5FeekqXokDKg87WOv9/EKA7xPtgsQKuC29CnRxUfjfnskzgm?=
 =?us-ascii?Q?IJMun9Eug4AmX7AUTgzcgP+PRdJBvBUdHmJOMJPhHB8slMvwG9ug2brYu684?=
 =?us-ascii?Q?WOrX677xo5q19F90TGSu5VDiGuzkq8K9Fx//lh3mCBcjBYoMUdLePohnI6B/?=
 =?us-ascii?Q?Hrd2JgCQDeommI8RCewu75EgRFaQA7sqXT4WU9/vydmK5yfCdlQggaKZYM5C?=
 =?us-ascii?Q?PLiDGvD0nMBd/cIUZuWEWfn+sgwS4IWm/TN3nHtrGkLeiTy9M7shM8lgAhHL?=
 =?us-ascii?Q?w/Thue4ngj8zaUeYAoxkZxdWAsS0Tr235Ye+AvumJpf9OgmRHeYgxc6bKrtc?=
 =?us-ascii?Q?Imf9Xp61CVCp5hp/ObXK8A/uahM1vI5qZnjP3x7Da7W+0WvDwcd1f9mLqxD0?=
 =?us-ascii?Q?+CQmmcBODA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3e223-12c5-439d-c7f3-08df2d7bbd54
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 00:55:59.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAxd1ksq5zKOqzO4gvYVIvMqgL8GAnXVRH3ZUy9JJMrxMmfAgBuVefA26qkTFLcnLSlAYQiN1fPQpEIY7gmmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

On Fri, Oct 16, 2026 at 09:33:07AM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Earlier this year, I came up with a neat trick which reduces the mental
> challenge of adapting data structures to RCU.  It turns out that it also
> widens the applicability of RCU to additional classes of data
> structures.
> 
> This is done by a low-overhead abstraction which I'm naming
> "RCU Pseudo-Transactions" [1, 2]. I name this "pseudo" because unlike
> classic transactions, the writers exclude each other, readers get no
> snapshot, and there is no abort.

Cool idea! Instead of tagging the pointer, perhaps alternatively the proxy
object can be allocated in specific dedicated parts of kernel address space?
Might be slower to test against though. But perhaps will make it usable by any
users who use lower bits for other purposes.

Btw, Pseudo-Transactions sounds long and weird, maybe "RCU proxy"? :-)

thanks,

Joel Fernandes


> 
> How it works:
> 
> - Reader (rcu_txn_dereference()):
>   - Load (rcu_dereference()) pointer from slot.
>   - Fast path (no proxy installed): unlikely low-bit tag test and
>     conditional branch (not taken).
>   - Slow path (proxy installed): low-bit tag test, taken branch,
>     the proxy points at the slot's record, select old or new via the
>     group selector word (0/1) (load-acquire).  Still wait-free.
>   - Pointer constraint: Slots must hold pointers which are at least
>     2-byte aligned when using the low bit as tag and must not use
>     the low bit for anything else. NULL is handled as a plain value.
> 
> - Updater (caller provides mutual exclusion):
>   - Allocate a transaction descriptor (gfp flags provided by the caller).
>   - Append records to the descriptor.  (each slot appears at most once
>     per transaction)
>   - Commit (works in atomic context):
>     - Install proxy pointers into each slot. (store-release)
>     - Commit (flip group selector from 0 to 1). (store-release)
>     - Settle (each slot loses the proxy, gets the new pointer value).
>       (store-release)
>   - kfree_rcu the transaction descriptor.
> 
> Here are the key highlights:
> 
> - It enables atomic publication of multiple pointers observed by
>   concurrent RCU readers. It removes the tricky "but what if a
>   reader observes this intermediate state" conundrum typically present
>   when porting a data structure to RCU.  A reader that loads one slot
>   before the commit and another after it sees old then new values,
>   never the reverse along a chain of dependent loads (or with an acquire
>   between them).
> 
> - It allows composing data structures: a node can be published
>   atomically into many data structures (e.g. hash bucket list and
>   LRU list).
> 
> - It removes ordering requirements on multiple object publication
>   with respect to RCU traversal order.
> 
> - Can be used as a building block for fine-grained data structure
>   locking (see the second example in this series).
> 
> - It enables RCU traversals of cyclic graphs with arbitrary traversal
>   order.
> 
> - It allows replacing sequence locks and reader-writer locks in many
>   use-cases, providing read-side wait-free progress guarantees, in
>   scenarios where readers need a coherent walk rather than a snapshot of
>   several fields.
> 
> - It removes the need to copy data structure nodes for updates:
>   multiple pointer (and data field) updates can be performed
>   in-place on memory that cannot be reallocated.
> 
> I have presented it at LPC [1] and uploaded an article [2] detailing
> the idea as a defensive publication.  There are no patent claims on this
> work.
> 
> In this RFC, I'm presenting a port of rcu_txn to the Linux kernel,
> along with a list and hlist API built on top of it. You will also
> find composed hash bucket list and LRU list examples near the end
> of the series. I've implemented one example with a single mutex, and the
> other using RCU for neighborhood lookup and fine-grained per-node
> locking.
> 
> I considered various alternatives such as Paul McKenney's "existence
> guarantees" work (2015), seqlock, rwlocks, RLU, MV-RLU, and k-CAS (all
> discussed in the paper), but RCU pseudo-transactions performed better
> than the alternatives in my benchmarks due to smaller cache footprint
> and fewer read-side fast path instructions.  I have applied this to a
> partial port of the dentry cache to userspace; compared to a straight
> userspace port of the current kernel scheme, the rcu_txn variant shows
> up to 6.75x speedup for reverse walk under concurrent renames, and up to
> 21.56x speedup on writer throughput when scaling to 8 writers with 184
> concurrent readers under a leaf name exchange workload (see LPC slides).
> 
> About the development process of this feature: I have used an LLM coding
> assistant (Claude) throughout the development of this feature. The novel
> ideas are my own, and I have carefully followed its progress, guided it
> towards acceptable solutions when it was hitting walls, and reviewed the
> resulting code.
> 
> Origin story: I came up with this idea while working on a userspace RCU
> trie data structure which I named Fractal Trie (still in development),
> and I needed to be able to atomically publish parent/child pointer
> updates on nodes which were controlled by the application (therefore not
> mine to reallocate).
> 
> The series is based on v7.3-rc7.
> 
> - Patch 1: rcu_txn core API.
> - Patch 2: KUnit tests for the core API.
> - Patch 3: Bloom filter so appending a record to a large transaction
>            does not require an O(n) scan for an existing record for that
>            slot (O(n^2) overall).
> - Patch 4: rcu_txn_adopt, debug config option for internal consistency
>            checks.
> - Patches 5-6: composable singly and doubly linked lists on top of rcu_txn.
> - Patch 7: documentation.
> - Patch 8: litmus tests.
> - Patch 9: list writer stress test.
> - Patch 10: test of commit in atomic context.
> - Patches 11-12: usage example for composed data structures: a cache
>                  whose nodes are present in both a bucket hlist and an
>                  LRU list, one variant with a single mutex, the other
>                  with RCU neighborhood lookup and per-node locking.
> 
> There are a few areas where I suspect this abstraction could help in the
> Linux kernel, namely the VFS layer and mm_struct VMA tree / per-VMA
> locking.  I'm interested to hear whether this is useful in other
> subsystems.
> 
> I'd specifically like feedback on:
> 
> - Where this should live (kernel/rcu/, lib/?),
> 
> - Naming and API shape (descriptor + records),
> 
> - Whether the Bloom filter threshold should be a config knob,
> 
> - Subsystems where this could apply.
> 
> Enjoy!
> 
> Mathieu
> 
> References:
> [1] "RCU Pseudo-Transactions: Bridging the gap between RCU and STM",
>     Mathieu Desnoyers,
>     Linux Plumbers Conference 2026 Refereed Track, October 2026.
>     https://lpc.events/event/20/contributions/2348/
> 
> [2] "RCU Pseudo-Transactions and the Single-Writer Flip-Latch:
>     Atomic Multi-Slot Publication for Read-Copy-Update Data Structures",
>     Mathieu Desnoyers, October 2026.
>     https://www.efficios.com/pub/rcu-txn/mathieu-desnoyers-rcu-pseudo-transactions.pdf
> 
> Mathieu Desnoyers (12):
>   rcu_txn: Add single-writer RCU pseudo-transactions
>   rcu_txn: Add KUnit tests
>   rcu_txn: Skip the record lookup with a Bloom filter
>   rcu_txn: Add CONFIG_DEBUG_RCU_TXN
>   rcu_txn: Add an hlist edited through transactions
>   rcu_txn: Add a doubly-linked list coherent in both directions
>   Documentation/RCU: Describe RCU pseudo-transactions
>   Documentation/litmus-tests: Add RCU pseudo-transaction tests
>   rcu_txn: Test a list writer against concurrent readers
>   rcu_txn: Test a commit from atomic context
>   samples: Add a cache on RCU pseudo-transactions under one mutex
>   samples: Add a cache on RCU pseudo-transactions with a lock per node
> 
>  Documentation/RCU/index.rst                   |    1 +
>  Documentation/RCU/rcu_txn.rst                 |  255 ++
>  Documentation/litmus-tests/README             |   37 +
>  .../rcu/RCU-txn+install+once-install.litmus   |   55 +
>  .../litmus-tests/rcu/RCU-txn+install.litmus   |   66 +
>  .../RCU-txn+list+step-back+once-flip.litmus   |   78 +
>  .../RCU-txn+list+step-back+once-settle.litmus |   78 +
>  .../rcu/RCU-txn+list+step-back.litmus         |   85 +
>  ...-txn+monotonic+acquire+once-resolve.litmus |   79 +
>  .../rcu/RCU-txn+monotonic+acquire.litmus      |   81 +
>  .../RCU-txn+monotonic+dep+once-flip.litmus    |   77 +
>  .../RCU-txn+monotonic+dep+once-settle.litmus  |   77 +
>  .../rcu/RCU-txn+monotonic+dep.litmus          |   83 +
>  .../rcu/RCU-txn+monotonic+unordered.litmus    |   84 +
>  .../rcu/RCU-txn+publish+once-install.litmus   |   60 +
>  .../rcu/RCU-txn+publish+once-settle.litmus    |   60 +
>  .../litmus-tests/rcu/RCU-txn+publish.litmus   |   71 +
>  .../rcu/RCU-txn+remove+nolock.litmus          |   64 +
>  .../rcu/RCU-txn+remove+nosync.litmus          |   64 +
>  .../rcu/RCU-txn+remove+once-install.litmus    |   65 +
>  .../litmus-tests/rcu/RCU-txn+remove.litmus    |   72 +
>  .../rcu/RCU-txn+sync+free+nolock.litmus       |   55 +
>  .../rcu/RCU-txn+sync+free+nosync.litmus       |   55 +
>  .../litmus-tests/rcu/RCU-txn+sync+free.litmus |   60 +
>  MAINTAINERS                                   |   11 +
>  include/linux/rcu_txn.h                       | 1036 ++++++++
>  include/linux/rcu_txn_bloom.h                 |  110 +
>  include/linux/rcu_txn_hlist.h                 |  486 ++++
>  include/linux/rcu_txn_list.h                  |  544 +++++
>  kernel/rcu/Kconfig.debug                      |   16 +
>  lib/Kconfig                                   |    3 +
>  lib/Kconfig.debug                             |   13 +
>  lib/Makefile                                  |    2 +
>  lib/rcu_txn.c                                 |  142 ++
>  lib/rcu_txn_internal.h                        |  129 +
>  lib/tests/Makefile                            |    1 +
>  lib/tests/rcu_txn_kunit.c                     | 2150 +++++++++++++++++
>  samples/Kconfig                               |   13 +
>  samples/Makefile                              |    1 +
>  samples/rcu_txn/Makefile                      |    2 +
>  samples/rcu_txn/rcu_txn_cache_mutex.c         |  354 +++
>  samples/rcu_txn/rcu_txn_cache_node_lock.c     |  713 ++++++
>  42 files changed, 7488 insertions(+)
>  create mode 100644 Documentation/RCU/rcu_txn.rst
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+install+once-install.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+install.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-flip.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back+once-settle.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+list+step-back.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire+once-resolve.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+acquire.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-flip.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep+once-settle.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+dep.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+monotonic+unordered.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish+once-install.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish+once-settle.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+publish.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+nolock.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+nosync.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove+once-install.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+remove.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free+nolock.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free+nosync.litmus
>  create mode 100644 Documentation/litmus-tests/rcu/RCU-txn+sync+free.litmus
>  create mode 100644 include/linux/rcu_txn.h
>  create mode 100644 include/linux/rcu_txn_bloom.h
>  create mode 100644 include/linux/rcu_txn_hlist.h
>  create mode 100644 include/linux/rcu_txn_list.h
>  create mode 100644 lib/rcu_txn.c
>  create mode 100644 lib/rcu_txn_internal.h
>  create mode 100644 lib/tests/rcu_txn_kunit.c
>  create mode 100644 samples/rcu_txn/Makefile
>  create mode 100644 samples/rcu_txn/rcu_txn_cache_mutex.c
>  create mode 100644 samples/rcu_txn/rcu_txn_cache_node_lock.c
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> -- 
> 2.47.3
> 
