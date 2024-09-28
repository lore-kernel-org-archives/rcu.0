Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2139.outbound.protection.outlook.com [40.107.121.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2F16BE2A;
	Sat, 28 Sep 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727565877; cv=fail; b=LTgXKg0BJmN340kBm7W8Jr7CEZHo41bjbt+ZC/3CJmtvGQyKU2W6e6i5e5H7wT6neFvkaHMan8o+sIox3a2TLWMukczShKYBEfEc4SY9xz5dp0EfMkZKb93VVX4k6jqk+jDcx1AtykGATneNCpmbLr62/iTqlbfloTxQ8Qmufks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727565877; c=relaxed/simple;
	bh=UxrvY8W/p6JhFIs9EpJ3BIolaL2vASHYN5y1/kCFoc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1UqUllO9P6VgXAlV/QsLT+zplFGQwlvyvbVGV7sbsYzrRm4HcmgvU9qCDGRDZ+wKMBCLenIr7DHZFmzAGQaNhqwioyhGt8xKTTXPTKAT1mjCITPC0tTrFuIpBku7IUBj3tVEwNwuHcAOBDgz0uBvaDxnzBSHetnI5/LRxdD8io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=POI9yUIF; arc=fail smtp.client-ip=40.107.121.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="POI9yUIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApdvhahusSPMMYzG8Ax7T3Ox+1r7tcqDeejw1BePVvzI2Afy8luRZRd+ICvEh0wmBc3jpal+jPZfS0tSR8yfjKaQI7cmZMfERhOK5VpstAKXnLiy9U2jDFwOcgEBep5Ylxo6lgOBjXe3MiJAUbkic65oiv9EDKNewJ/2+RVZl/wZV4SmKYuX4V704v0YyhZkMxkdwwZGldVvFw/vJUOVF8CPom/7keAsEWCX3GEpDC+Y60HKrVmIYTuujO+Pd9VZzfJjc7KPgF/O4vIjjEwaG98frnzmL0j+fVzUjuIJ6FjIyS4GdydGcjOAFxbhILBQgLBB3nYbhdF//YLMX7/IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUuzGJLesdiBPn9foSicXb4wYFYAaUPt9G1ltiaOUGs=;
 b=s6adtUR87W/8vkEyQJx0MS23DHP5Fi+qe9m+j2utamCfc1nC4JvTBuUv93cz2LSGvK/QW6M7eL18ajrHH2qfS1vERtiAgy4Yi7GPzBGgxvLG/HIwsXusoIuWNzL/0nkMt2va8KJ4/rvqP2dyem7E2AjqMFbFsU3CBuiUTnu0mdCwZ2nE6vGx1euzrBjk0P8i9X97RHLoYQbINYNrHjR/0ekf7J8VmlX/Qwb+mqALhIpWOR7e3K/EofCbBUlgw6w24Ma/1UTYCVM/iLUXd147BBpg0JmxK9UqY1BRhbhYf7kEaePPHPLBxQpaG4yFBlCkvtRTKJNEgWSgRsPQz0h09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUuzGJLesdiBPn9foSicXb4wYFYAaUPt9G1ltiaOUGs=;
 b=POI9yUIFOXQEyy4AgcPQ0KxnEWLFmN3UyluvwiM6tX+3DHmQnn2ZyVw5FuKfobJfhKBCgf0eG8c4AgewmrXM9Sq+bDpAQsT122iXo1k/hXX1ybT0Grj2xgLOFqSeJgulA7cmgREMZrcV6S8j7Zvwzglhx1xYEaa/Gsk4BmKdzo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 23:24:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 23:24:31 +0000
Date: Sun, 29 Sep 2024 00:24:28 +0100
From: Gary Guo <gary@garyguo.net>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
 <boqun.feng@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, John Stultz
 <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic
 Weisbecker <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil
 Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik
 <mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
 github@npopov.com, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <20240929002428.38f37f54.gary@garyguo.net>
In-Reply-To: <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
	<20240928135128.991110-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f998eb-757a-40a2-1c64-08dce014b48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0w1HdP2WHdhh0UBiks6ZgODRE11drrOvDDpnAyW+YAlf/2kwnb3CCM5RixFU?=
 =?us-ascii?Q?U3xx4WDAeN2qnHCNpPZ/6OK1QntJAZRUVlEzXXK6f/qm6LwOHnFcofw3iFG8?=
 =?us-ascii?Q?JAzSHt4vw4dA1gFjhCBufMszcA7qHQ3vAUYkzO4N329/amSkeJUwTWYpc9dZ?=
 =?us-ascii?Q?M06QAwoYY8jS8hQ3CSkyixoi7C0hODW0OSWA9Skc0JGGC9PXteqZzWXyHB/T?=
 =?us-ascii?Q?9ZAQVC1CINbjtjpZ4Wd+bPDjfhT33X6M8KFeryl33ZIuSqnVFvkRXCXBgWMK?=
 =?us-ascii?Q?f/OWLZqVlwYabjyAGv4sp9bkAGuoL5t4Y7ZLZvq7fcSqzM28vjsAvbZBS2PF?=
 =?us-ascii?Q?uiRLrvqTnMiiewGYfMZonWSwcWGBLRF5ZNfC+pLWoYVrsg8Hj/5hCTsfFItH?=
 =?us-ascii?Q?Vk2nqcav81st8etMBe0s1I3WNSd3rBSjiegOq49RxH6LdY54DM2UQii3FQdy?=
 =?us-ascii?Q?/dn2ermsf5haGFV2ohmm+9YAezfAbYJ8Xvx4VWBeh1EcWVeGfBQmuMQHACnE?=
 =?us-ascii?Q?UQ2XFJ3F3LvpGtcZ4eUYmPfsb+yYEwu66brI1vI55LXagZ6my7AkiT7AFmbF?=
 =?us-ascii?Q?NW/EJtoUK8LfGT0nh+ikPU08mo5dWk6HzW5u4xROQ0pLBMo43iHARHyrhCHp?=
 =?us-ascii?Q?z79dkS2iWLpPVAPlxMPzoC8XuHkLXdLWCyQlvE1PG5kfDbCb4ZuQwyrTNM6C?=
 =?us-ascii?Q?Ke0oqv/9eUyGxqdzb/UkjtpTUSrjQeTBewyPdL9/0eaeKqkASbjCt99mdxZd?=
 =?us-ascii?Q?pM13So0B7BuhSUrAceyltElJOPwWl45MSyC3cVw/bIj7t8FhBbyk8imRvqUZ?=
 =?us-ascii?Q?bNoF8O40RZWxMx2JKqcLam+FBZJTE75Mh4apF2GKO6norITLmFmRb5vXDIJG?=
 =?us-ascii?Q?zOJp/Soa+4e+s9XvZ4/D2Se/O+QyD/s3Ehax4I2T3+oUqdZ/qMSJXC/lDAQM?=
 =?us-ascii?Q?/zmG41ZCqEVQ6MN5e+bETFDvyYI2heQogKcdIyEIZb8ISX3sPa3ZHGXykN5H?=
 =?us-ascii?Q?XhGxdCm/E6rsyIgdwoYKdA3WSg6o5zaQhRAlRVFfqnX3Mnys3s+UvlVRqiQ2?=
 =?us-ascii?Q?sIIGYv7CJD5+KwCJ+Q2gdY7yiNA8Nvk+dsu+H63MGaDsN+cBH7yC4/C87yiV?=
 =?us-ascii?Q?PoOa5uTnrG5/8Bx2MYoRrAm2MAc4ALHMVG/ghQx+ZDHkoiiu7K+hWHSLV5Pk?=
 =?us-ascii?Q?xHAkCmk/yHrXOvhPu+EOALru4hOVbsKF8N01wW2UCymo3hHYFnleQiSVm+8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wk925sfDUQm+7z/TfGCLxfH7+qwTeGNsyQ1CcDpPTwejd9LzZp0Ks9VZ1qX9?=
 =?us-ascii?Q?fTmCP72kVNOCwpw2nkVIZUYxhgXWnF91B7Km9MhqP1kA69aMTgyXl8V+s1mO?=
 =?us-ascii?Q?PM3N9wkOtzABI0qfwd3sfChSv2LznuOa47F0KqX10xL8jQbxFh/G/3LgAN0x?=
 =?us-ascii?Q?LctWpZq9GzR0KNnpeqX5hmLvzMgdkiNt20p36NgchHjBaS9Ic1v6T9jqOXvn?=
 =?us-ascii?Q?KxKNvZOCkebdiUzNwVmntvOQsDDLfdiDUW1C8VfIK/E2814kMno12o/TTfQC?=
 =?us-ascii?Q?rlWePUtdXAbDPa4/9LMxfwTUYqejYiBTOPxGo9OaHOk2ZYNzHmKpbF2IDk0v?=
 =?us-ascii?Q?CidABz5KHDb16TBWUem9mPfa9AEY0WsEX42Bz4XhWn2OjzmYKnf7mK8Y7Se3?=
 =?us-ascii?Q?G4td/COI4x3zRpL4kmTmgG/v95Yh/KSduhIU30H4n2PYE3rLfbiYytpyp0Is?=
 =?us-ascii?Q?sMHoz8DbrQ2+nOK3bzctjmuLqr3+Qih089JD8z5Yh+ICv01YHLwqmbsnYVDD?=
 =?us-ascii?Q?vrvlYlaZs/3P6KehZkv1R4jHSyLnvxdi/g7vx6/K20RNPckis6rOQ0PXpJ9E?=
 =?us-ascii?Q?DL7u1JwG+hwj9/iUi9byuBe6+IbKtrOJq6l/VDU1BB10mx2RSVE2/atSZYsk?=
 =?us-ascii?Q?KowGwmlD4FL30Me3gdKrOWvNHCLd6Ffv7vXYpm27u6MpN54rMC/bKNHp4Xif?=
 =?us-ascii?Q?zTpk2BzvVXxCs0rLdjSp9cCleFml8NrFlnr7mPCPjhVsvagx0MYVQWo8q337?=
 =?us-ascii?Q?Tg7tTmc9zSDSwjPBkPgP7Ix3wo0CHziDn/l/Z8c/UqEhKunQlC6F1BDA9XUb?=
 =?us-ascii?Q?TbpXuJBjDBnqQi4ZAlNvndUvLFBp2pymO45zdF2J19XrwCdB6WoEUS+xpB0+?=
 =?us-ascii?Q?T2fuoxdxvmt71/31vR8I31uILyxxZFc1bo5s0Wrjiw3iToRS9trIU3NFiCpq?=
 =?us-ascii?Q?KAwL2PRFE9IAmUYytQYcJT0As19URkXD7ka2Mrn0/8ZZ5rDk1f70+cx8vcsj?=
 =?us-ascii?Q?rZIkW/YnNa4WKbI7WBAUIvVcdvPvNtrzpkhH+yQNotjd2jQYeSa8cr2hOksx?=
 =?us-ascii?Q?/2srG0otN/JkPZLdShe+5+S3tpS8xpc2abkrbT+6dEDoHL6U2ujBpMik891s?=
 =?us-ascii?Q?IGnt1We4WInEBvL7Jg/O72cLq7rySeJbI7W2+gca8jIg2hPJLSJunNKkOMW5?=
 =?us-ascii?Q?6th+uOr6HAkMXanw5opffToDZTtT6v7zWp/4MCNLVXNWHmiZJ2yLJuNYSaX+?=
 =?us-ascii?Q?UaBojnmGLZ5Cx1IevOqK0vULsTqbcxC/Xf5qVlp1LjtcS/f4ifPTMkHhi+FA?=
 =?us-ascii?Q?3PTfKcD/N8SX2jqGaSwJhOQGEKOmfLIGwSMh2h+GvK6m1j15qmzIXk8aOS7K?=
 =?us-ascii?Q?H3r+n2rKrRvvfqvU8Gt1GwUoiaN2g04iWSaYGOnk3FMO20ilslBjjRrU2egv?=
 =?us-ascii?Q?nWQFUz6Oxdi3Xdl6+u3GK/DdBq9TVdxlRXZZJD3xZJxXDEaj7cmQFtx4etLQ?=
 =?us-ascii?Q?TgHaRZ0qvIB76H6bmEmneroVUYgZGh0mfZmKRFwy0qrc1+cRwKrwALECVaN3?=
 =?us-ascii?Q?+CveW+3A6CKvG6qD8Q51qZHW7XkzY9fQChc8hsrfJuJEMLb6C0SHDOPaB/k1?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f998eb-757a-40a2-1c64-08dce014b48e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 23:24:31.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVhERhbxAcyCuSXu+gskZgrlkQfFbAPe+817L18ATV6TAE9mPYYOs/lJCzfLNmqAOOycn19e1Vm9qDL+9DsxXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6419

Cc: Nikita Popov <github@npopov.com>
Cc: llvm@lists.linux.dev

On Sat, 28 Sep 2024 09:51:27 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Compiler CSE and SSA GVN optimizations can cause the address dependency
> of addresses returned by rcu_dereference to be lost when comparing those
> pointers with either constants or previously loaded pointers.
> 
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().
> 
> This is needed to prevent the compiler CSE and SSA GVN optimizations
> from replacing the registers holding @a or @b based on their
> equality, which does not preserve address dependencies and allows the
> following misordering speculations:
> 
> - If @b is a constant, the compiler can issue the loads which depend
>   on @a before loading @a.
> - If @b is a register populated by a prior load, weakly-ordered
>   CPUs can speculate loads which depend on @a before loading @a.
> 
> The same logic applies with @a and @b swapped.
> 
> The compiler barrier() is ineffective at fixing this issue.
> It does not prevent the compiler CSE from losing the address dependency:
> 
> int fct_2_volatile_barriers(void)
> {
>     int *a, *b;
> 
>     do {
>         a = READ_ONCE(p);
>         asm volatile ("" : : : "memory");
>         b = READ_ONCE(p);
>     } while (a != b);
>     asm volatile ("" : : : "memory");  <----- barrier()
>     return *b;
> }
> 
> With gcc 14.2 (arm64):
> 
> fct_2_volatile_barriers:
>         adrp    x0, .LANCHOR0
>         add     x0, x0, :lo12:.LANCHOR0
> .L2:
>         ldr     x1, [x0]    <------ x1 populated by first load.
>         ldr     x2, [x0]
>         cmp     x1, x2
>         bne     .L2
>         ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
>         ret
> 
> On weakly-ordered architectures, this lets CPU speculation use the
> result from the first load to speculate "ldr w0, [x1]" before
> "ldr x2, [x0]".
> Based on the RCU documentation, the control dependency does not prevent
> the CPU from speculating loads.

I recall seeing Nikita Popov (nikic) doing work related to this to LLVM
so it respects pointer provenances much better and doesn't randomly
replace pointers with others if they compare equal. So I tried to
reproduce this example on clang, which seems to generate the correct
code, loading from *b instead of *a.

The generated code with "ptr_eq" however produces one extra move
instruction which is not necessary.

I digged into the LLVM source code to see if this behaviour is that we
can rely on, and found that the GVN in use is very careful with
replacing pointers [1].

Essentially:
* null can be replaced
* constant addresses can be replaced <-- bad for this use case
* pointers originate from the same value (getUnderlyingObject).

So it appears to me that if we can ensure that neither a or b come
from a constant address then the OPTIMIZER_HIDE_VAR might be
unnecessary for clang? This should be testable with __builtin_constant_p.

Not necessary worth additional complexity handling clang specially, but
I think this is GCC/clang difference is worth pointing out.

I cc'ed nikic and clang-built-linux mailing list, please correct me if
I'm wrong.

[1]: https://github.com/llvm/llvm-project/blob/6558e5615ae9e6af6168b0a363808854fd66663f/llvm/lib/Analysis/Loads.cpp#L777-L788

Best,
Gary

> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 2df665fa2964..f26705c267e8 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -186,6 +186,68 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	__asm__ ("" : "=r" (var) : "0" (var))
>  #endif
>  
> +/*
> + * Compare two addresses while preserving the address dependencies for
> + * later use of the address. It should be used when comparing an address
> + * returned by rcu_dereference().
> + *
> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
> + * from replacing the registers holding @a or @b based on their
> + * equality, which does not preserve address dependencies and allows the
> + * following misordering speculations:
> + *
> + * - If @b is a constant, the compiler can issue the loads which depend
> + *   on @a before loading @a.
> + * - If @b is a register populated by a prior load, weakly-ordered
> + *   CPUs can speculate loads which depend on @a before loading @a.
> + *
> + * The same logic applies with @a and @b swapped.
> + *
> + * Return value: true if pointers are equal, false otherwise.
> + *
> + * The compiler barrier() is ineffective at fixing this issue. It does
> + * not prevent the compiler CSE from losing the address dependency:
> + *
> + * int fct_2_volatile_barriers(void)
> + * {
> + *     int *a, *b;
> + *
> + *     do {
> + *         a = READ_ONCE(p);
> + *         asm volatile ("" : : : "memory");
> + *         b = READ_ONCE(p);
> + *     } while (a != b);
> + *     asm volatile ("" : : : "memory");  <-- barrier()
> + *     return *b;
> + * }
> + *
> + * With gcc 14.2 (arm64):
> + *
> + * fct_2_volatile_barriers:
> + *         adrp    x0, .LANCHOR0
> + *         add     x0, x0, :lo12:.LANCHOR0
> + * .L2:
> + *         ldr     x1, [x0]  <-- x1 populated by first load.
> + *         ldr     x2, [x0]
> + *         cmp     x1, x2
> + *         bne     .L2
> + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
> + *         ret
> + *

> + * On weakly-ordered architectures, this lets CPU speculation use the
> + * result from the first load to speculate "ldr w0, [x1]" before
> + * "ldr x2, [x0]".
> + * Based on the RCU documentation, the control dependency does not
> + * prevent the CPU from speculating loads.
> + */
> +static __always_inline
> +int ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +	OPTIMIZER_HIDE_VAR(a);
> +	OPTIMIZER_HIDE_VAR(b);
> +	return a == b;
> +}
> +
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  /**

