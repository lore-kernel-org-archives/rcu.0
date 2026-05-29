Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022086.outbound.protection.outlook.com [52.101.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B93D75C2;
	Fri, 29 May 2026 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056982; cv=fail; b=gjjMiAdVH5oOQU5HNpRVLMN5+yyWaOp/cJNSGGfT46vMy9VO1jeJUSjQZyax8CpL6pxOMUwoaUXyDR5JpRbBid2yOB6vLiwKGAdIrcsIMg7Ffks1KQQHZx/lwdW9FqhIRF1nu4vdL9qUgb+HXruufpuuzBGwniDN5saoa7kJQU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056982; c=relaxed/simple;
	bh=ypWs1IDBiWJNO0EZp7r0Qo4BomThC+GqYO3sx074RSc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=iwzZk54my+2UXpV6t0Bqu4mms7V+sHtLe4UjdI7kCFNQo6JHU55vgC5Cp8K3tpt8ybhJnnDUWzcJ0UQt1Nef45Fzlg+WYwIGBiBWk3fnhqNk5OllCC96tCC65mhIxGasdPcs9PRbMKyEhPOkjwE7a6qaAc9BFQh7j+g9AhyAjHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eTHsUnp0; arc=fail smtp.client-ip=52.101.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eTHsUnp0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYTXusc7pI9jvOGY83gpvVv/LMz8eQSSsrz54z5yHb9KdvKFPogt6BSilNfn9Af2SfZXnDV5zPeCOtoZ7Mpw363qhe5OiuluWrUMCjWjgdj4FwJJ6szQAD5zeL77gbQxJ7j5Fd/3JRd1X8UgYYRkqgZeSolUPFS+BEivPBBp1Rke6+qsAUQjjWHw9E9bAGybzwnWjlEZQwNhnSYO/x1dd1r5bKxXX55l9mp0C17ilohCLiD38KnnUv5S9lHdgTzERpXC5wObyQ5u+rUvcI6aT2o4lK9DR6ua+ecboiufmbuBuQASrZpbFtAcbYtUJhYxuLzNSIUlL3OGufEXy4r+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DfqykfSJh0MHalEwSREdCPGvpT9AUzqKVlLtiztfx8=;
 b=O8MtQyjmRlx+mx1fZEEyIMBvT4qLApxcsSVDqvBC9Nwd+MxJa6Qjsy0Yd6DQsOOHeseZQk8A29OI0lrjH71mFVAX+OBdLSMr+zMj1an5qNlw61rTU7++J5jNcjIr/EId9gqrgpMFmHpf+SvyrmBgp5dvQw73KmuO1TSge0KSfjd3IiH3txkvpsbn2hojKmKWxN8zoTMHuVNgwDd59yLJ2LLIFEAv7Edssr9SwwTZCM0ZO0U+5Pymk+k/TxvK0fVh0WqqMF+0s8nur8Pm+EMHoPH/tdXQYuBTarP6dom6MoRs8pw3v8DUE/B5k05+bi9lTxOvQSSUhTy0sPP/AJ7chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DfqykfSJh0MHalEwSREdCPGvpT9AUzqKVlLtiztfx8=;
 b=eTHsUnp02sC2+RLf2NUY+R/TU9JcH/iD6PBkYOmOR3hdg23BjGGpCW42y1GRqwNwnPHScf2hL5wgoSM5SOVaT5qW3fEJeeTOHYv27WdcDj5iIq7TeYOsdbTjhLJ5ypYT9HiDt7Bd5eX2lnSdRYE27/JzEtlz6iV6hMT9GeaBIHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9078.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:497::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 12:16:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 12:16:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:16:17 +0100
Message-Id: <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v8 1/4] rust: helpers: add SRCU helpers
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260529114449.112066-1-work@onurozkan.dev>
 <20260529114449.112066-2-work@onurozkan.dev>
 <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net>
 <20260529120759.145202-1-work@onurozkan.dev>
In-Reply-To: <20260529120759.145202-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcd2944-4594-4747-6a11-08debd7c163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|18002099003|22082099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	P+8jBPz0aAAAPs0Ojd/fUtQsH8qYstYtgOxkngTgwAyH4/X9rB9t1fo1Jvwi6v2iYvbGhSKzqrhDqW8ZaXXd1WjdoTX9v+I/K9e7A1a+Cj3zcf3yNotCaj+2m9hSxwiKcKRFqkiEhEufDIDLtKUV7DuUmlGXt3ojryKXV25mCx7bFS8vy8dT20tDE/P+8ipxU2ImQzQHTkk8BHUmhUKTh+f4Me/5BnR0bPjAXouXYvEPWgQUNGOeYTkadYQUwyYxvUus4D6wFgBvu09ULWXDL8gyx9fC5MFOEC1M3CLI2KG47+j+iVci/P7LMNbGAaSiTya+Xa4FFkuQ44Jf5X2MYIjgKMn6kPUPalMbDpuj9dcHlDy4Y4fJaK3Pms2nE8d9TNic11is8dCeu5pSs36j+xdaDK3FWu9x5rynkpckjNgjTjSj1wrX/rZiyTodXi7NE00QCXYYzP1eTf+05N+6MUWBsWRmqmcwru9Fw0OfVOfDd3dPsU/EqS9CMULBCTT1obMTufPE3ioF86JOwSUNR9ob/0Bl7kJrss8DX/WdAUy584iBDYTIH/1ceFefEl3d/cfIGT8qFmVz8+efsyKsQjxFFSFfY4dCc4t9+6OCNRhvThPaM95Gi5JSW2vKMg1678t1MW0+RDQ8P4F4S1Y1/T8igq/NHuGH4CoZzAxcODIFxNbeX8hAby6mwZy9CUyEtci2jLD2j6NAdalVN20Rdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xTVnowVnIzMWVtUzBqd1BBbWw1TVVPVGI2VGg0MnlyUWtYN1lZQWlENVFt?=
 =?utf-8?B?Y2I4V0FYUWNvRkFOaUE2VlozL2RkSGVOQjhDV3lZV29vbW02ZjBLMThhZi9j?=
 =?utf-8?B?VEtEaGJWQkc0V1VYVTdUcCtJdk5PM09BcjBvQ1RMWlhUYmZnb243dzl6VXcr?=
 =?utf-8?B?SVpSa1BNL21TQ21yTHE4WXVDMktucll3bzVvUVdxOERidnhMeEoxR3d1Lzl6?=
 =?utf-8?B?bVhXOGN4U0pMalFWU0xSQXpyVXFmMnpOODFkR2ZEMENJY1R3cUNWaGtHMlh2?=
 =?utf-8?B?NWtXRUNROG1RTHVDNWM3aTlzYUJGN1RNT1l5UjRFSEhsWW5uWGFaTGQwSlVW?=
 =?utf-8?B?VWlMQ1FYRjJFTVFsVHlmczN2amFpWDdhbzVUZVJMOWJ3eEdIV0I3akhmcnZM?=
 =?utf-8?B?S1hJTW0wOC8xbzRQcDQ0SmVqWVhlalhuVEJVMEI5MVFTWUZVRFBpbzBiNWlX?=
 =?utf-8?B?ZUdITGVkcU5lcGFGZ3Z1TGp6b1krL0RSaStQcFNYdkFaYS9tNGZSSU5uZHNo?=
 =?utf-8?B?bjhZVUEyekh2MndabThTcGQ3N0F3Q2hUSHlMZVRRaytEeVBtZGNsUzh4ZXFR?=
 =?utf-8?B?R0hTcnBIeGJuQytHTzM0azZGZU9aV0hvM2QwSDZ4d3l4QzNmTXppMkRGTlZL?=
 =?utf-8?B?eGE4RVd3M2F1M1B1KzRZeE90STBIQkg1RjBmeXEzUGJwNW9jQjNRZis2OFJy?=
 =?utf-8?B?VkJFV0xGRkpOSEIwbkhMSXQwWUpuTm80S1d5OVFya3d4QUF0dm9VSXlOVFVz?=
 =?utf-8?B?ZmRzbGVqcVo4azVISEU1WEdlZy9vVmpTNUNtTS9CQXRPVHQ4cDJDcWwxS3I3?=
 =?utf-8?B?ejV4V2hIMFJqSVFHNUZxVUp1Q1Jnc3kxTCtORGJkTGVSa29ZVW1UYStRTXJS?=
 =?utf-8?B?c1U3N1hIWHh1NEMxNUoyVStBZzVwSTVqa01NZWl4RlFpTkRFVnFhSm1OdmJa?=
 =?utf-8?B?YnRWbUQyM1RXa0tYZGxnN1dnckZnanpZa2ZqNWRra2lST2VLY3JrWXFIOHhk?=
 =?utf-8?B?UXpjTHhyNldwUTE4bXJBVjAzMXdrYkcwMTdHcCtnd3hDTDhMZ0NNcHBiU3gy?=
 =?utf-8?B?Qnp5ZnNuNEpsUzJjaGRiMHYvMkpWdmhRbk11YjhzTitSb3FWL1pjT2tXWHlr?=
 =?utf-8?B?U3krNE53YktYb0p2WVNjTG93UEF5aWVQbW9GV3MySVQwd2hsTkIrcGVSWXVD?=
 =?utf-8?B?Y0h4VTE2eDkzTG80S3VpdkZYanZxUVZPQ0ZFRmp0bWx6TU8vNHRjRlczT1k0?=
 =?utf-8?B?eVdtWElvNHl6MHBOYUFvMjRXVnJwSGRuTnl5YVNvRzlPSGxWblRqdDAyQlJN?=
 =?utf-8?B?NTJhZ083UUt6L2RsVHkyYlRsQndTY1VtQzQ5d1FlTEZYYytxS1Z3R0ErVXht?=
 =?utf-8?B?T3FJV0FHS3d4am1uVXBjTFRKdlNFSTF4WnZKYUxZbnR6Wnk0aVNidU9UWmhh?=
 =?utf-8?B?WkRYRlhWSEI5RUhqWjhxbWVjYnk4Wm9MZXVFa2lCRG9QdEJDSElObnA0UWp5?=
 =?utf-8?B?THljaHN2bTVvSmdUaFUvdkgwS08rWTZVSnY3V0NFQm0xSHR3Z0N3MkxwNU5v?=
 =?utf-8?B?ZURmandJUnFIeVV2RXk2NnFma09ZM1JPT0szdzRhdENqbXRqT29EU1ZKUDF0?=
 =?utf-8?B?YVp1QmlNeGJ1UDlnOGxkZjBRS09pUXNtTVRyVTZxek0zV0hrbU5OSHFDT1ZO?=
 =?utf-8?B?UEl1UkFrMzJ1cGJZUlVWeFNvakgwdENwU0IvSXJBM0QxOHhlWERXOUNKQWdU?=
 =?utf-8?B?Qm91ays5L1F5OXBKZnNwWENSa0pac0FOMXNGTGhWNmxkZzlUZzAyN3Z6Y1lq?=
 =?utf-8?B?YUhtdEJhNmdqdEk2S3lYZkJoU2U1aTlCeXB4Q1hDa3VOOVFpWnVCdm9ZeklS?=
 =?utf-8?B?Qm1UNWI1d3BndnAzQmZLelpnVHd2VDQ5dHNlT1V4Sys3WjdjbFIxNGFueEZF?=
 =?utf-8?B?Q0laVEJPYUZOakFjTHJ2MVZKNFdhWmo5Sk50d2NWbmNkMm43bU9vbi9wODRt?=
 =?utf-8?B?aVo1U3JYSGtWdzByK2FJTjhoU3UxbnljaC9pcUxad05Db0k5c29xMTNtN2Zs?=
 =?utf-8?B?Z1g3Mk1hVXpibWNNL3RlZGZXWUxZRkhIRXZwWkZXS09nT0RiRjQ4SExVSU5I?=
 =?utf-8?B?eXYweWNURTJTVU5PcVRKMzRKaytUbGdscmV6bUVNS2Zrb2J0TE1VM2FHWk0z?=
 =?utf-8?B?MUJUUGNFNFZaaC9PV3pwUW1Dc05GQ0V4cit0eFZmQVU1Rm1iUU8wNXFPNmpW?=
 =?utf-8?B?UWpRVUs0b1VEVU13MWJKZTR2ZW5NTHAvaFJwNjBPeEhDZktkdmpndEd2VEJn?=
 =?utf-8?B?N2drZEhhSHFnVUE1bFBvTFd0ejdyYlgzM3ViNkZ3enA4V3haUU96UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcd2944-4594-4747-6a11-08debd7c163d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:16:18.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QNSX7KU/rS9o+rOKlBtxRDwfuGgaQUrd0cLHKT0ow5ElsXPIC4llncbSIB8yTIpnHAXRpmQWJW3kNUkH9Xkhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9078

On Fri May 29, 2026 at 1:07 PM BST, Onur =C3=96zkan wrote:
> On Fri, 29 May 2026 12:58:17 +0100
> Gary Guo <gary@garyguo.net> wrote:
>
>> On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:
>> > Add helper wrappers for SRCU functions that are exposed to Rust
>> > through generated bindings.
>> >
>> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>> > ---
>> >  include/linux/srcu.h   |  5 +++++
>> >  rust/helpers/helpers.c |  1 +
>> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
>> >  3 files changed, 36 insertions(+)
>> >  create mode 100644 rust/helpers/srcu.c
>> >
>> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
>> > index 81b1938512d5..790a4ef713c0 100644
>> > --- a/include/linux/srcu.h
>> > +++ b/include/linux/srcu.h
>> > @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_stru=
ct *ssp, const char *name,
>> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>> > =20
>> >  int init_srcu_struct(struct srcu_struct *ssp);
>> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const c=
har *name,
>> > +				     struct lock_class_key *key)
>> > +{
>> > +	return init_srcu_struct(ssp);
>> > +}
>>=20
>>=20
>> This looks like a different strategy than, say, how mutex handles lockde=
p. IMO
>> the way that mutex handles this is more clear.
>
> Initially it was the same strategy, this one was suggested by Paul [1] an=
d it
> didn't sound like a bad idea to me. Also, in previous revisions, Boqun on=
ce
> said:

I'm talking about changing how this is handled in SRCU side, not helper sid=
e.

>
> 	"Having a "#ifdef" in a function body is generally considered as bad cod=
e
> 	(I know we have some of these in rust helpers, but helpers are a bit
> 	special and maybe we should clean them up). So could you move this
> 	function into include/linux/srcutiny.h and include/linux/srcutree.h?"

mutex.h doesn't use ifdef inside function body, it just define two static i=
nline
functions with the same signature in different ifdef branches.

Best,
Gary

>
> So putting them together, I decided to follow Paul's suggestion.
>
> [1]: https://lore.kernel.org/all/05906890-cf06-414c-a625-02f9d7150d57@pau=
lmck-laptop
>
>>=20
>> If we follow the way mutex is handles this, the `init_srcu_struct` would=
 always
>> create lock class key and forward to `__init_srcu_struct`, and
>> `__init_srcu_struct` is an inline function that either calls
>> `init_srcu_struct_lockdep` with all args, or discard name/key and forwar=
d to
>> `init_srcu_struct_mutex`.
>>=20
>> This is beneficial because the usage flows one way. You don't have in on=
e config
>> `init_srcu_struct` call `__init_srcu_struct` and have the opposite in an=
other
>> config, which I think can be quite confusing.
