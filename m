Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022078.outbound.protection.outlook.com [52.101.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDA322A2E;
	Wed,  5 Aug 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954213; cv=fail; b=qGDWoRo6Ql9VdZN5cjF47IkS4xKjjC/kV8cSxt4yqKqoBjotytXmLKF6gjjkWoI2ANat1oYoO3A8gUG3Xtu4OWU7jixVN1wv+nNFDnRXyYkbAObFigs/bEyrQmNk4fOukifQ5jQyd0Tab2x8iBeArBdzFdF/GtJGI+cw7KAwhFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954213; c=relaxed/simple;
	bh=UA/2VW0y0fAO4tgevF7w2H5xtMFl1zLCwJfzU3ddIeM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=rFCNzNMnZjnrBTNqj4Yc5pqtPL4hmBxYM2Ix+Ngj6PdABIcm7dN3nblnymgORVGK3b8JQ9AKmt3GMw3iCxOx53wmMlEz7FKKB3FfulwOWDJ70TN1LDKo9gX6bkWfZhlxjLrvBsXzC6MvsEtcKZnGY+YzXOYGULl896yK/9MLt/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zFi/mz+Q; arc=fail smtp.client-ip=52.101.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zFi/mz+Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHAeJyhflLcOXNnDDGxPYC5/EX83y0Og1rk0b9SfnIGU1tsKdsvkXZqmpErZClphMSBIPN9Rz/gZ5GZAhuSY8fRJNDde0alVgTRMOfMWft7V5p5ekn6QImSKR2XZby8n0tN1yEV1TclWd88njsmHbjGfkkbH0FXhjqXj35iHmPmB1w5xhU+abDkvj5X/rbmAvHgutTDAM632GxZJyCVDf141wBZe5SLrB2iYwavT8BFiCUiVU5BvOKfJNxE3qeHu66zvgtNI6J9YdaRYGD06bwjbtfJO8CL46Isblu7Cj4AklSqSGm7UjjZLmJgJYNJoCpb+JGNUlSQoYMGhr9FnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFpcatNQVqoR2ms9kLaS9qWyNaIgSnczUBr4mZyyYOA=;
 b=BLCKAAI6GMNyDO537EcHvPtVMJ3BQ3LyG9N6B4Ljyv41EZ9BXXMA2JnXK/sxj6RYfMHYhaNnu25MUhdsYNgX793tr28xfxtPjpZV0SlsG3yDczv9Fw/Z7sEDYiREO9XhGSokMJ4Yl6UWfWLWMGTullhIBEFLjB0wZFIIfEp/ChtgNcS4jVWJTqiblUtA3bX5pyYPkoJ2KL94hHH7cvyxj9M5RnWOUVZY5XUnSQLKuOHZV0FU/a5/0x6CoxZnkA/1hdc6sp2du9BQ57yf9j8VblmsV8k2+sVQzrdQMj1tVbF7QgMoLqKOAwA7nIEKLUlX0cFHWWJiED1biUyg8xau7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFpcatNQVqoR2ms9kLaS9qWyNaIgSnczUBr4mZyyYOA=;
 b=zFi/mz+Ql0zlRf1ZviGptHE31VPG49DQ0e02BtSQKg825UoQou/03+Wh/OaFB7BtSZshEeXqpv5y0bRTVkzWpkR9baPq3BlNIE+IlOqs739OPnEIBo3GZnbImIKxwrmg0GKYWkTeBeoUhUUbsKbP2DXfJk7weqdS0U7t2bdcaB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b3::9)
 by LO7P265MB7924.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:410::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 18:23:27 +0000
Received: from LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM
 ([fe80::5d79:38cf:117d:48ee]) by LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM
 ([fe80::5d79:38cf:117d:48ee%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 18:23:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 19:23:26 +0100
Message-Id: <DKH7XFS38HQR.3HCZEFK98I605@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Lyude Paul" <lyude@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Burak Emir" <bqe@google.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Mirko Adzic" <adzicmirko97@gmail.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Daniel del Castillo"
 <delcastillodelarosadaniel@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v9 2/5] rust: types: implement ForeignOwnable for
 ARef<T>
X-Mailer: aerc 0.21.0
References: <20260805145949.938505-2-phasta@kernel.org>
 <20260805145949.938505-4-phasta@kernel.org>
In-Reply-To: <20260805145949.938505-4-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b3::9)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO9P265MB8547:EE_|LO7P265MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cc73cd-862c-4300-74d8-08def31ea4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|921020|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ksdYum5CUoXqb4R8JkDtMZ0he++pQffqjklGlNMbjw/kdKIhjyFhNuKUzkRWYq5ynf9R777pmnJANTULr2ICPcVecH0MhoYbaqH0eTT4ZbeqJXcuAY6dQbTn5lofkufT5/U9uVmOncikxAz0gdSaim/21S7a9MjXFuuXTQ3T36pgpZhi9TCFwR9RTcvZyl2U8b3pcCZnN5M1WML2sK82AicsvC7fL9wgQhTD++5wvj5IIziCTuldzH6/SDt1NwegpiBAWT5LyY15/K4gCJSCTPI1L59uLB+IPw9Z8KEpbmznmBVtrY6p/Uzm+IFoHBv3p4LPT2bqXDNokgDdYsMX/rvi+YL4OCoROswXd/uvQUtLfdTDvQQvlxf46hf/Vw4+WQ12nL8hq1p2kiU6n3kyvquocJvZaPM1bKXnyRLIqqvcj0aAtleFgrvJzk9NKE0JH9F7OAC1J3P44ilDSaVzI7fFjSs+M/V6zG8zxTz4MSlChL+gwSUTRyKuVdip6t3+CBSUR+VrUWShYRJw+Dp+HHp9CfgH7qm6AYeYYgzQT9XOGNS+GI8NDnEEuvt2T7SHjxMNZeTKgYEX5wdomSEegqY0VD0kX+iljtg3JgGwsBr8FC9hu0L41gvELBhDVgFTY5Vn86TY26rM+u0NP5ZhHGx34ctV4tYqSy3C7XfpODKJtNvZvoJM3DgYdGjKsJ4WrVph8JoJEAZNnNVu6Cbk5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWtnYWxROU5WZFpSczhHaTJTZVlPVjZycGJwQ21LM1BaSk5qSXpSMzREZFpG?=
 =?utf-8?B?ajFvUUdVb01SV1pEVmg4a1RnY0lDb2JXTHFlNkQ2OHdPVmFDa1Y4VWxZOU00?=
 =?utf-8?B?UVo4VWxqL3B3T1ZnM2x5NC9PMlNNSlZLVjN0M3dybzE3SDA4UTRYZy9CaHhB?=
 =?utf-8?B?SUR5dTNic3RQd1pMWUpXbzVKZHhtNWt6eWFlUHFXb2lEenBXMngrUm5mYlFV?=
 =?utf-8?B?VGgyYnJTemtBNTR5NGQyaHZ3c1NkZWNKdXowV0tDbm1HemM5Zk5Wd1VMS0tw?=
 =?utf-8?B?Nzcwck92Ni9CMUlSVGlzVktjNzFxUGxudDZqNWhhdlFvbm9NdWpTeU8yYkZx?=
 =?utf-8?B?dmhmUFBSdkoybklnczZrQ29pS24rWSt6V1ArNk5rYmlLblV2dVhGL3IyTFVk?=
 =?utf-8?B?c2NYOC8xUVJ6alc2VTZIUU9WT2k1Q054NnhvV1h5R25KY1QzYU5PRmlCdkQ4?=
 =?utf-8?B?WXRQTTJSOEtOeVQ1ZGt5NGxNV1U5azg4QVZOTGNvckRTUzh4ZHRVNm5EUEpF?=
 =?utf-8?B?b2xaNEFJc0FFTVNUSHI3ckVOOVZ5TVhLTFhCbU41VDhad1ZPMlBRUFNtVVgx?=
 =?utf-8?B?WUdxemw4RTRITEUwd2gwdzIvSDJyYkhlWmphMEt3UG9QRjA3UHZxamtzSDkr?=
 =?utf-8?B?a0NhUlMvYjdGODlNb2xyOGtwYm45MG1wWVVBTUhLTDZIcXRraUR4RHdUZE1v?=
 =?utf-8?B?MXhWVEFSOGxvenBPYTRpSWFZWlQrSjlOSCtJS3ZWRU1aK3J5ODRiSy9ZcUU3?=
 =?utf-8?B?RUhINjQzOEVSTGtvUnAwVjV6WEJLT1dQUGlqa2JMMUl3bVQ0U1U0UWZQcFJD?=
 =?utf-8?B?c1R5ZnppZzh3YXNRMnhlM1JIK0E2SlJLbW5PYXZoc3lVQ2F4NXF2ZVV1aXVa?=
 =?utf-8?B?MjFPd3JnMXpBbGw5MEQwaFdzVEV2blJtM01aTGhxWlVJdDJCSlJFbjUxVG03?=
 =?utf-8?B?SGlPc3g5MmVvUUpVSVBvazlBQUFuNFd2VW5Gb0dvSXM0b0pjTGc0eCtGdTFN?=
 =?utf-8?B?RGRwWWQzc2FJZ0g2L2loRDdQQzJrYWRpaXpEL1MvU0xvcjZPYlJNWVJ3YXMv?=
 =?utf-8?B?blZrNVBibUlSRTJFQ1duNUt2ekFOeS9nWG1EcExUU05OanQ1a2YxckNyZHFL?=
 =?utf-8?B?SEh5Z1FoWURMNWErWkwwZTFTcEd2Q0VmaTNwSStNMGpoTnUvSlNTUXBtNlpX?=
 =?utf-8?B?V1ZUKytnMGdvRHFKNEhrd3FEYnV1NUlTZXdUZS8xNEVQUTc5U1pMSmpGdndJ?=
 =?utf-8?B?d0pJTHJwMEp5cmlCUzl5TitGaTd0S0RaTnVISW1JSjJXbWJpcEFxaXI2N0Nt?=
 =?utf-8?B?cHo2dzlubDU5WUQ4OXJPWFAvM2ozamVSV0ZqU0s1am5RM0NJdXdHc3p4WGdR?=
 =?utf-8?B?RVlKUjh3K0REa0tmb2JsazNEd2VQRzkzWDl1S25PcXE2VDREVWNuaVRXclpU?=
 =?utf-8?B?czlSWXVmb2pGZ3N3WE11ajdOVVJPNXcycSs2d3Z4R0JTTUdMTFNKend2Y0k2?=
 =?utf-8?B?T1A1YXpyR3BybHhuK0V6R3lZZkZpQXd3cVlFMVF0OSttcXQzOEN5Nmx2c0hF?=
 =?utf-8?B?emQ4cVhOSUQ0Vi9GUks5UzBFVkMzK0o0OGxKMWpFbjYvTHdnc0NiVlFZN0hF?=
 =?utf-8?B?ZFRYWU5wdHM0WC91cEk4RXdBcWhrZUNtMHhsaDhHMm91ekJwSm9FNHU2ZFZV?=
 =?utf-8?B?YkZDYzRaKzBXUUJKbGVJdGRVWG10dVBQNFBUMldLRkgxbytPVlhiTkEvS2Fw?=
 =?utf-8?B?SThFdkR2K2YzYy9MYlBLU0dpcjdML2NwV1I4c09aSUZCNmZNcmZmV05XSGdU?=
 =?utf-8?B?MGdySnk5Nkc0NzVGblZuMHVoQWxEMnN3WHoyR1FITERndDVIY1M5ZWFwVFgy?=
 =?utf-8?B?T3gvNXk2b0tVNnI2RWlJcVdMa29KQVB5U3Q4d2JTM1VUWUFDSm9vSEp4TTAy?=
 =?utf-8?B?NnQvMkI4V2RYMVY4VTVqejd0dVNXa2x6RERZOW4vRHpPaTlLU25BQ2RHRFdx?=
 =?utf-8?B?d2RxNnBJVE93VHNmOW5OcW8rYjVhbFlOOSt3ZzRxQWRxL3lmRkdpTUN0TVM2?=
 =?utf-8?B?N1pDVElKVWRKaVZaZUhxZk1zRVBWU3Z0ejl6TTVYK1lTaGN2OEl2ek1uczM0?=
 =?utf-8?B?WUJ5Rm56d2dGV3ZGYWxhV01PWjRBTjFMUU4yaktodTliTEpLMmJOMndBUzEr?=
 =?utf-8?B?ZGp6eXF6YzN4U0ovT1ExZzFJQVlzTm1XazVTSHZNUWtaVklSM0U2d1QrZmZE?=
 =?utf-8?B?WnRrSlJrVjJKM3IvNjBtTThKQUN1MzV4bWkwRkFRYnNtZVptN3haTXYzUDkv?=
 =?utf-8?B?Tkwzd0FNcU5aNkg5bDNnSGxkeHJQb0Mrd0dxekZBU0cwRkxlNkE4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cc73cd-862c-4300-74d8-08def31ea4ac
X-MS-Exchange-CrossTenant-AuthSource: LO9P265MB8547.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:23:27.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTcn1gVXZoQvUza3Qpf/adjIO2PP4DZckeVSDr7CXdno3hP8aWz4JD/R2kyLHiCWDn9QzsozSX43jHuCNi2LxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7924

On Wed Aug 5, 2026 at 3:59 PM BST, Philipp Stanner wrote:
> From: Danilo Krummrich <dakr@kernel.org>
>
> Implement ForeignOwnable for ARef<T>, making it possible for C code to
> own an ARef<T>.
>
> Since ARef represents shared ownership, BorrowedMut is &T rather than
> &mut T, matching the semantics of the underlying reference-counted type.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/sync/aref.rs | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index b721b2e00b98..540766613659 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -24,6 +24,11 @@
>      ptr::NonNull, //
>  };
> =20
> +use crate::{
> +    prelude::*,
> +    types::ForeignOwnable, //
> +};
> +
>  /// Types that are _always_ reference counted.
>  ///
>  /// It allows such types to define their own custom ref increment and de=
crement functions.
> @@ -188,6 +193,41 @@ fn eq(&self, other: &ARef<U>) -> bool {
>  }
>  impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
> =20
> +// SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so i=
t's non-null. The
> +// `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's=
 aligned to `T`.
> +unsafe impl<T: AlwaysRefCounted + 'static> ForeignOwnable for ARef<T> {

This doesn't need to be static, if you can add `where Self: 'a` on `Borrowe=
d`
and `BorrowedMut` instead.

Best,
Gary

> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *mut c_void {
> +        ARef::into_raw(self).as_ptr().cast()
> +    }
> +
> +    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        let ptr =3D unsafe { NonNull::new_unchecked(ptr.cast()) };
> +
> +        // SAFETY: `ptr` came from `into_foreign`, which consumed an `AR=
ef` without decrementing
> +        // the refcount, so we can transfer the ownership to the new `AR=
ef`.
> +        unsafe { ARef::from_raw(ptr) }
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that th=
e object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
> +        // SAFETY: The safety requirements for `borrow_mut` are a supers=
et of the safety
> +        // requirements for `borrow`.
> +        unsafe { <Self as ForeignOwnable>::borrow(ptr) }
> +    }
> +}
> +
>  impl<T, U> PartialEq<&'_ U> for ARef<T>
>  where
>      T: AlwaysRefCounted + PartialEq<U>,


