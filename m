Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012A5478D;
	Mon, 28 Sep 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595160; cv=fail; b=A98lzCIjj8O0GyxZuZl/P7N3MoVyqrATwN5KJ1HU0UMJb6aevrI8sgs8tl3Sa5yxlFiUbYlEO3sKWypzp819uWrMSAV7Lf98BfptTZluGGZFSzpszPx7J2LK41gKhP8DVjRqzEHcMKUD29upzFEEYbwriJyMp10IsVFToQHOE2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595160; c=relaxed/simple;
	bh=YKbe3/FjUZ1y1t2ShOdO1NVLNtvZVCJqw4Dr5mxTNpw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mIT3Oi6mSbc5C7UFacodil0aOZYgUtJsmKVtxm/GaQ3d/YozWhu3w5vFeXP1AE0uLt5iCXBfVxOWR5IDfjWx6xXY7jSGPVnSs0rkxHBc3rolHVoJikacKtAlAIwBbyEqXSFeHtRhd57zCZdnOgqnb8V6vFDgaUe5xD7ZvDF3x+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=n1ApBpML; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="n1ApBpML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydt+Dw4bapRTi0MbXhCL+3L3sGwIMZNrEnirMxRMP0syrCVrx1t7me7GtT3hzGtdnFLTIph3d0l/97XD1mciOjQVxdj6p3bIt/cRJ8MnY+A8eSuHMzfQffo/DbIMZuXPZkS6IpdGbPSZpvXeHZkUnR4hhn+EUXuw+bFOw8kooIUI47PjelryQJZ92VJr7OWWIlegaIO07BnPzITa9VOLdmBDUzXRtMerPPEjkMbaZlqAwreoZp+M+2KUQMhxNzk1PM5pAW+cNOU9Rn1boH0IHKu/kZxuvhwh+2oiL7pRBmIPGoWxTRmE4qKB1HAFsEgWyVXKdl9/Qvv/EHIT2+wsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCOk7edYiUCQKkQZIKKKS4phfW8KTHCY65JJqO/uJ6E=;
 b=yMofH2VGna9LkzoHjf90fMB4foMd1ekmrXeSYmI5rA3sFvcf/0eAx0LM6D7NTFt8meoTZncIZ/sBI63XJzgsKHY83MS+bU8/eQ7R8OIaVLVUmNkr3asciMYmz834j8u/5xMO0MpzR15OH/7wmUerpkUXzGxqZL77QrtH0ZpshsLW1rP0wv2ZW62TYAWaZw7ffigSWxs0/588oXdxIAYNYAhIu8/L054iND+pc76QArDFiduY6PmLXlpTv92KrOk2H3VB7ZIMS+nYq+8WJ9TZY7KxzddfyCbkklpr58qpktP6ZrL3Re+G3ZsNkUxDtYOWjQvz4D8QyGsixrcEatcWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCOk7edYiUCQKkQZIKKKS4phfW8KTHCY65JJqO/uJ6E=;
 b=n1ApBpML17c57rAsb1N5Vk9pBmP6AQ4AR2+P5AQUU045/EYy3B4+E58X4NSjmBFWH7wX/CcKEfa/pdoP+RcUHaILK9K0EWPrs75Lmb9TYk4nrz9wYll8UcSk2PmdE7AL0ueUzgA4Nr0sPyqQkiDr+lAqH73ALFrKvcqcR0hbrCM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9039.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 11:32:35 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:32:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:32:34 +0100
Message-Id: <DLQX09XGAHDL.1LSFQH13SU7XR@garyguo.net>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Paul E .
 McKenney" <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>, "Bradley
 Morgan" <brads@mainlining.org>, <rcu@vger.kernel.org>,
 <lkmm@lists.linux.dev>
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
From: "Gary Guo" <gary@garyguo.net>
To: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net> <arovltfvFzv2FFjO@MacBook-0RXW5>
In-Reply-To: <arovltfvFzv2FFjO@MacBook-0RXW5>
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: b2877581-cd85-453c-eb2c-08df1d54311b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|376014|1800799024|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7fBJoAlvMtCZd2QAtyfGhcFOazkeuR9QDBSyElKq3jrYW8RO/0dlt8xi/iUmW/Tn2zrKii+ZP137XsPcybB5b+vwGpmK4IzkpXzCO4Z4yKAAoeS4zPZN6vUYjwlSHXEpGg2zJfeQuLEE2R5RAATBZuNLvd1I4Y6F92j248UyNyfA/vSWy6OY22shKgmqK+l1ft1oXzqrLv3s3b/aLnVTrZEvFzWI5XjqOF/P8y7hiT/H+DV0FGm+uMbuZ9ZXp6Cn7mKWy/MXzE194oQ6Z5pu0aBUT/h1MOC3rIsTzUkJQjX8vc3bks7E7P8x2VzQ87FfV7ObWkfZaAdFSGFJwqk7ftf8v/p7nw1rq1ZK7DZ3sZekPCcc+hTc865QY90T4mEJg2WMiEWqfMBKyviBjOTJC4cR+gmKMZyalQmNkbZWsizbTQMEs0B+Q/Kao4bFRWem8t29YH3tkcyNV+RGhyKHtGlGsccqmE+0//7pbRhrBnk5D5WjjynOrmXP4XhXQX/8EguNKyfylwJui0NMoGw4prs3OiPXE1goiCTQS9Ovcim68MKeAHcLK8Jb2BHB4Rr8hY1/YM99Bgb4a7z3GrMk8Ig7Zc6y8lAz8HF8GyQfKoc2a4EauO+YLYUX0x8lI1+p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHQxcGgvV0lvcmxDWHYwNXVHUTRsVnZyVkVHcWtybTVvUTJIOTFDck51YlNZ?=
 =?utf-8?B?eElTem1jMlNOR0xvT211WHNqWVJPaExJTEQ3VWpDTzY3bTVFNExCdWgyL2hG?=
 =?utf-8?B?THRpeDgyM0YwRnYvQVFvUmNvQjlZODQyMytxKzRtOHRMbnUvbkkrdGQ5SW9B?=
 =?utf-8?B?ZE52WGpLdUxCOVdXNjRmTFJwQnBpdjJGdWZTNkErMWFNVFFLeWNZQWttR0t3?=
 =?utf-8?B?ZUdnMnZQdW43aTBjTS9nMk1jR2ZaQ0wxRmlBNDNEem84ZjMxaGpQaXVoYXVQ?=
 =?utf-8?B?OE4zMkVlWFNFOVljR0R6a2w4bGxsV0lxTHdId1ZZZzM0Vmcrd0JLU3UySlZM?=
 =?utf-8?B?anRXb20yY0JaT0xQY2xIL3RCRzZraVRTY3F6TklJaDM2eVVqWm1GK1VjTitR?=
 =?utf-8?B?cXN6a011L2N3dUNxdWpNMVhwQnVRUFNPNXM2dUxybTdXQUd3NTY1bFNyMWtD?=
 =?utf-8?B?ajVrcXdVNC9lYUVFS2JtaGNKT2JmL29aSHl6ekVCczFIV0E2eTlSTjV4WEVn?=
 =?utf-8?B?Y1drUk5NSUh5QWFhTTZFR2cvVEw1WGlDQi9MQVlpVUpDRDZ3eHBmTSthSVJR?=
 =?utf-8?B?YXlLZjRaNHZGMDdTeVB0cEllNFpraU5rdU5iQnN2YTd1OEFUak5wOS85MlVM?=
 =?utf-8?B?Yzk4K0VlTU9kYit6V0lrTmpSOEZvbnp0VVVQRFJTL0tYemxQMk03VkhVeWkw?=
 =?utf-8?B?Y1Q4a3ZwVDhxN3p3VHZhVmY5QTNSdlE4YVlDbmN4ZFJudVZLWW9IdDNXV1pF?=
 =?utf-8?B?Sms3WUFtbGxTNDIzR25LK09DYlkvVFk2RlVRNEdBd1dGVjBweFZkMUc1d1ZF?=
 =?utf-8?B?WkJiZU52dm0zQzQwaURIbitkYzM2c0ZMTWFGMHlxdHp5L2pBQU9FQTFUTmR3?=
 =?utf-8?B?cnNpS2dDY01oQ0hxYklPTFlYMTBXNFkrKzByN1Y1cVM3VldiUWVwUVp1MkFX?=
 =?utf-8?B?amsyM0lzQ0ZzUVR6Vkc3eXVxcUtwdlZRaGFKM0pYdWkzRFZ3NjNzUGhLL0Qz?=
 =?utf-8?B?NU5hNkpWQlU0TXFlaU44WW9HNG0xRnRrbXczRzJjWm5EVkkyYWI4TDJOT1d1?=
 =?utf-8?B?VFd1R05kVEE5ZUh2UlE4QnpxWDFkei91Yzd0aHh6anZyQzJvemJhdzRSQmUy?=
 =?utf-8?B?YlQxaWlTME4wd3JoUDU3c2NqQTFSMXBIOVVRWmgyMTlpK2FHeTlnd1NodmRU?=
 =?utf-8?B?WXhwbGNGbVhIREVVdWE1TWxEZEFtbEFyaUV2N0xUcFlGNTcvZ0J6cm9hMXpa?=
 =?utf-8?B?aVp1K2pQdnNzMGhWQTRYOVJXTFBTTEhWMWRMclgzV3AwdGFuczkvTU5NU2ZR?=
 =?utf-8?B?c2FyYTU2a0xIRjA0cGh0T3ZUMlp6Y1RiNENQUzBidlBTcUt2bTJ2UkJjK2dS?=
 =?utf-8?B?U0d2eXJQSmhmaXc1UUlrd3FKYmljakVxUTdUY3lWL1lMMGVTU2VVZHlKZ0RZ?=
 =?utf-8?B?M0JkQWZmYlJwNXV3R1pqZDV3bjhCY0dLRmpKKys0Z3V6dFRZb1ovN0RYSXNt?=
 =?utf-8?B?cyt1cHZMSmxhQ2ErRU9FSktzTmx3WGpXTG1CYW0vb2xrWmRkNTNSRk0ydXBi?=
 =?utf-8?B?RTVoeitHMHVuakllNXc0Rm14T1V6aTc4cDkrNG5TNFJsQVdVUitnYlNIWTh3?=
 =?utf-8?B?WEIvR3BGU2xsRU9zdy80ZmJKYm9NZ0d4bFU2QTVKSjFTVlpwdng2Wml2aUoy?=
 =?utf-8?B?RGVSbUZzdFhjSno3K3QxaUJqSy9pMTdSc3FxNHExQmFGdU9iZGc3TDJQN0JY?=
 =?utf-8?B?aTdqSXpJUE9WR1pSamNPaS9wV3NrS3U3Qm9MbEx2c3FnWnVhQlVFemt3K2hS?=
 =?utf-8?B?QmFJa0FnMUFPZVo2N0NKOXlRODBiV3QrWElHc1dyTkhHbWhJVkVvNndUWHFm?=
 =?utf-8?B?WUhodzBCY3lMMXREQVVrT244VmVCN1ZGVVFsalBxWTBqaW1ua0laTlZ5Tnh4?=
 =?utf-8?B?LzFTNW5HalpFb3JNeGNxVmgyUTkwbUJISE84QkNoM1F3RVFsa2VaVzlLY25x?=
 =?utf-8?B?YlJoS3ZyNTJrZGVzblB2aTBzNzkyMmpGbGZkVllSV3hDb0RMSS9rS0h2N2tR?=
 =?utf-8?B?ZEFCRDYzKysyY0FrV1ZSaVFzUlVjbmF5djgyS3NiQmdpWngrcFBiOFdUSTJR?=
 =?utf-8?B?Z1F6YUpIdXZiVGprVmU2bWRnb1JVUlIvbFdhVnBBN3g3aWJtZWFya1dTSk9K?=
 =?utf-8?B?bkFOK1V1ajUvQWxsRm4rcHBmNUY1citNRTAvU1ZWbTJZWkh2M1BTeUhuSzZp?=
 =?utf-8?B?VlM5dkN6Y0dtR25ZUld1bGdQYkpQZlF0UEFIR2ZhWWRnV2dTQXZQaXQ2aWdZ?=
 =?utf-8?B?Sm5TMHFLTHFRTSt1OFZmdHhFNjd0WjA5TTR6YzRJVTJFYVhFYkZZdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b2877581-cd85-453c-eb2c-08df1d54311b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:32:34.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y87bgUFxaES0QIdwPVf4vPoCNCSecr/k9bCgbsWY2L/wgwtpG2ucJez0x3w8rEmY6hPkUqkeIjKUWD3D0A7Xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9039

On Mon Sep 28, 2026 at 10:12 AM BST, Boqun Feng wrote:
> On Sun, Sep 27, 2026 at 11:39:00PM +0100, Gary Guo wrote:
>> On Sun Sep 27, 2026 at 6:15 PM BST, Mathieu Desnoyers wrote:
>> > On 2026-09-27 12:40, Boqun Feng wrote:
>> >
>> >> I want to point out this is not true for the lockdep use case, becaus=
e
>> >> the we need to protect a hash list deletion there, and we use the
>> >> address of the hash bucket there. It's proven fine in practice becaus=
e
>> >> the readers are rare (we only call the reader is_dynamic_key() in
>> >> register_lock_class(), that is every time you have a new lock class t=
o
>> >> register).
>> >>=20
>> >> Maybe what we want to say here is that "if the users guarantee no ste=
ady
>> >> flow of the same hazard pointer value, we guarantee forward progress"=
.
>> >> Thoughts?
>> >
>> > AFAIU, your approach to protect lockdep linked lists is to use the
>> > address of the hash bucket to protect the traversal. As this address i=
s=20
>> > invariant (global array item address), that address should be fine
>> > to fulfill hazptr requirements, but it has downsides: rather than
>> > protecting the specific nodes being retired, the whole hash chain is
>> > protected. This means that, as you point out, many readers retiring
>> > nodes from a given bucket (except the first node) could end up holding=
 a
>> > continuous stream of hazptr for a given hazptr value, preventing
>> > progress of hazptr synchronize.
>> >
>> > It's also coarser: per-bucket rather than per-node.
>> >
>> > Am I missing something here ?
>> >
>> > One honest question: is this pattern something we expect to
>> > see often ? If so, then we may want to introduce a notion of
>> > hazptr protection "period" flip (similar to some RCU implementations),
>> > where we tag the low bit of the slot pointer (0 vs 1), and alternate
>> > between the two periods in synchronize. This would prevent a steady-fl=
ow
>> > of same-value readers from preventing synchronize forward progress.
>>=20
>> Slightly off topic, but I have a use-case in mind (in case you're not al=
ready
>> aware) where the address is fixed like the lockdep class, but it does no=
t suffer
>> the forward progress guarantee.
>>=20
>> I have been wanting to use hazptr for revocable for quite a while (I thi=
nk I
>> chatted with Boqun about this last LPC). For the revocable use case, the
>> protected pointer is fixed, however there is an additional boolean flag =
to
>> determine if the resource been revoked or not.
>>=20
>> Something like this:
>>=20
>>     void *revocable_try_access(struct revocable *rev) {
>>         struct hazptr_ctx ctx =3D {};
>>         if (READ_ONCE(rev->revoked))
>>             return NULL;
>>         // note the & cancels out with the * in acquire, so the address =
is fixed.
>>         hazptr_acquire(&ctx, &rev);
>>         if (READ_ONCE(rev->revoked))
>>             return NULL;
>>         return rev->res;
>>     }
>>=20
>>     void revocable_revoke(struct revocable *rev) {
>>         WRITE_ONCE(rev->revoked, true);
>>         hazptr_synchronize(&rev);
>>     }
>>=20
>> So while the address is fixed, we have a different field to do the unpub=
lishing
>> part.
>>=20
>> For some context, the current Rust revocable implementation uses RCU, bu=
t this
>> is limiting the case where it can be used. The current C revocable serie=
s in
>> https://lore.kernel.org/all/20260912123529.7951-1-tzungbi@kernel.org/ us=
es SRCU.
>>=20
>> I think this use case is a good one for hazptr, in fact, I have encourag=
ed Alvin
>> Sun to try it out and you can see an implementation (Rust) in here:
>> https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-6-074b=
add18716@linux.dev/
>> Although, over the course of the year, we have been reducing the amount =
of
>> revocable usage and shifting to represent things with lifetime..
>>=20
>
> Paul asked me for the Rust usage a few days ago, and since we moved to
> a lifetime based approach [1], which is better IMO, I don't think
> switching to hazptr will should observable difference here, especially
> for a real workload improvement. It's still worth trying to see how
> hazptr in Rust would work for this, but it's less a sufficient condition
> to merge hazptr from my understanding. Of course I could be wrong.
>
> [1]: https://lore.kernel.org/rust-for-linux/20260517000149.3226762-1-dakr=
@kernel.org/

What we get rid of is to use `Revocable` (or `DevRes`) to protect resources
where we _know_ that the resource is alive (for example, in device private =
data,
because it's teared down by driver-core on unbind).

However, there are cases where we can still have the `Revocable` pattern, f=
or
example when a class device is exposed to userspace and the bus device is
unbinding. This is a pretty recurring pattern too, and cannot be handled vi=
a
lifetime alone. This is what motivates the C revocable series.

Best,
Gary
