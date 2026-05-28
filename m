Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB73EBF03;
	Thu, 28 May 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971027; cv=fail; b=NlZMm1uxKkxkXbOhc+JP+bCv6GjNc/9Bbxgl4LZ56HNI0NpTETVeVs5/LQh0CvfQ2EidqKrgIUyBIERNJPCt/4WjomXTPnNGQiXTiuSxohIw+1DL+0PLLfI29e8l8kCjIh5rplAEV2/Oms9XL1ceOn3HX8G/Km9h4fpifbjHdxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971027; c=relaxed/simple;
	bh=q6Bz0RTI4kQ8M4h40jiptxjf5S1FYumc6zUjUh3viZw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WaG6GdBoj0+/JlVHVcZGkYSl3YmQWcB1tVrSYNPTuoQj+3QCqG8bMcXcbjQf6Qu1rAd2bbuyaIKgY+qIRXcZa1We13F1fKHSGttHYkb2wXN8JGsViMQ8aFwK5eMY68IWDdVlWH6AHfDBYTaiaCzm29Y7doOzGkNmqB6IxJVxE70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PWhamu5H; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PWhamu5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4dJo+wlUe5mIE49YG9On4bh+UqhRCSeQ3/pLUuRqCRSnz80XkK6Z+Ln0p96U9r2e9dXAGVDQK3f9BxeOEI63AhTvstwsbA8L+7N9L2W0brkCXjPIvREJKR4lLnzqhc4kErblHRd0e7WOd5QDY8jefv2sHpH0DrHCtSpxIPTwcq6ZbSOlGpZSZrNcGh/d4V4qC4MMZgsgkRHtvp7mHro579AVLid39zpu6VSAvg8GGtuH0rIQoM5mM7cPcBDIBRacBbYNZ2bZDzsX/Pon1/hu0HLJCjbfQDqVpcQkMQ+/v16w/ARNdKMdySsiV/vdMpQFZE97W3snPquO+Y/WgaaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlI5YAfOdkGpBw8WfGnhfrnXMOWn0kYD9BRYpAsRIYg=;
 b=yq1qXNazjE9XPksMygt0h8EmicNg8dVQkI4tuFmvjhOoI9YFZSDhFzJMRCGNiRwsZmOhC7R6qQxfy0PESRykXeNt5+0p9LPlFL2//028V3VO/bIaFoPEC12iZ3HB5+xfQCUplNIMegE8BIVXO8OaAputPUPqX/UrE/CfdRlySqqXK3sltvBx7eaylSwPud+RlndVvzQgfTW3N3FTiDeT+t2XD2NuusIo08N7YrPy6BwVnQxhDz4lrOFmD44nl0aGLYLCbAoqRI32YNPDmSSXQEFKVhqEAwRJ5BHmhiM+7qbOygo3yTEkwZkOoJI7WJeZdlNpBPNaCQIHO/sIN/i6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlI5YAfOdkGpBw8WfGnhfrnXMOWn0kYD9BRYpAsRIYg=;
 b=PWhamu5HlSWU1xOObzWTzwhSbIGwB1eAD6fSUPV9QIb2i3vSELBz0oxzYHPRWOU3b70aDOehMa2X0/p+ienqDqQTPArgZ8ibZPa26abThT24noR2o7f1gEClRwksCq+Vx0spfURB9tsDDUoCNd0gVd8xAogU5VLimoqXeEcPksw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6194.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 12:23:40 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 12:23:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:23:39 +0100
Message-Id: <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <peterz@infradead.org>, <fujita.tomonori@gmail.com>,
 <tamird@kernel.org>, <jiangshanlai@gmail.com>, <paulmck@kernel.org>,
 <josh@joshtriplett.org>, <rostedt@goodmis.org>,
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260528062810.256212-1-work@onurozkan.dev>
 <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
In-Reply-To: <20260528083518.66203-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 56553ad0-b7f4-4c31-2674-08debcb3f340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|22082099003|4143699003|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	YXRGn+4KaFoTtEJClWFtWiEi6mM3NSdT9SJuYIVdfHmc+z/mywc+xqB0jANKQMYLPMud68WJ5MU94r50WQMKt0pce5kozv5KD1M3UwNEPF3JNUS39T2uBEmLD9FG3mubkP+n0/XH3cUWCJvZ70ADysOhX0pbeEbAkxX/fb/Td+mdhhfuWfqYDvqKUCbSCZU6hGlQw0WNDpsnX35/qHjV4pS9Rf69vrjPhfQLvod/RsXCNrq3cOWa2ik1CTuDLO5PPD67i52Q871JJvvEqF/QUhQahmVXFm0gKjyBIpou5RD1VHhfsFWWf1mLi+9Nnj7PSsgLIb65FztbF2zt6rVgymlFRBOjc165AxARY5lOYLVPwXFruzyBtmuG5oEqx5JzsuDmRXXf2LiBuRWNFL41NT9A8Wm560E11L7aSAFK09ASOMl+ZGK4nLgsS9jYpz6qFegrVC8x3mb+goUmrZQgSDblUsQHhTr56vlVgBr2rc2eOB6vpfy905poqG5jWqFCemUN+N4HUFdGw8VUG4px0U4/pvVbqYaD8zaNPUOcJaKqUL5oXH2L6xId9X3G7spiVDWjq1hVoeavFqMxbbyvJf9POfM/ieVB4Di9yHkVX9doPMceRFvwhHot7Qau3+1sTK31p75zjI6mltorVuuCwL20bXCdxSjDsOUj/9I60mh9kjv+7BK57uIhmsY1tY7t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFcvcHNiR1YzN0ZqazcwKzM0VEh1eWJRbWtaejU1U0Z0SEhPaVJtOUltOGts?=
 =?utf-8?B?cW1Wc0pySzRiOGJ0N0ZMVXVncWd4TVhtMTA4Qk5Iam9iMjBSYlBSbFFZb2Zn?=
 =?utf-8?B?OFZQTkhSS1lXR2Nvb1hNenZXb05aYnlPWldRMzlmRUxnWndjbCs2TnBRM0ZD?=
 =?utf-8?B?N1hmMlA0NXQyQ2xXeU1lOUpBVmVXcS8yY0NNNkEweWVWNjBONjB4SmFhVE1q?=
 =?utf-8?B?QVUyZGFSWVBoODBWa05XVzJIY3V0ejYxWWFqQXFvSjJmTDBhUS93aUlUbkhV?=
 =?utf-8?B?b3R2S08ySU5sLy9hZ2hVa0lXSWIrenVCTFk2N3V2aEVHbUthcEtyenhTTGE1?=
 =?utf-8?B?Uk92S1hPR2xPUHNyVUF3Wm9TSk5nZEZYNTNBKzhMOVBKSUVKbkdLcGtxSkxH?=
 =?utf-8?B?MHp3NG9YTTIrcW0zQmJxcmFTQXVkTk9NUkdneU5aRW80U3hqNFU0L0VGK0th?=
 =?utf-8?B?U1dDc3NoQTJuVEJnbWtvNDlUaGhjUTBIWVU1NzBpRVNmQ0IvS1M4Q1EvUTBl?=
 =?utf-8?B?bHFZdnVQMUs4R3BPTU5BNmRVYVVvNVhhVGt4ZzQxTEoyTDFtb3d5djBxSEEx?=
 =?utf-8?B?Vk5uNjVmV29kSWVZaVRMdTQydis2U29MaHNhTFR5L0R5ck1kWU53QWFqMnNO?=
 =?utf-8?B?WHZiUGIxajdQZjhjbCttSHRjdXJFU2gwTElldnE2K3hnQ2l1WFhHSFNkRFlT?=
 =?utf-8?B?d0lUaE1VRlRabDBlYlh0UTA4MU5MMHVycEthODFMdGlVd0V5UUhFQi9sQ1Z3?=
 =?utf-8?B?ZEhxQzNxZTIzVGdhQ1ZBL3p3QXVYWnhXd1ZmQnI4SmVoSEIvV3lrbEwrTzht?=
 =?utf-8?B?aG9Kb2pOS2lNNFc3Nlpud2xydldmeThzN2UxOVJuMCtPbko5UkRvQ1ZvV3NW?=
 =?utf-8?B?ZkNDUVZoRUhGbmN3QzFOaG8xTUJ3YUgyeFZPSUpUeUhFVmREK0FzZVVwUkdE?=
 =?utf-8?B?QXM4bmF1V045TllsRkt2SWdnd3VBUGtHWFBnQXU4QXd1NzFsNFhmM3d6R3Mw?=
 =?utf-8?B?dXVDUFpmVGpVMlNCTk1uR2dxNC9XQzN5Y3EzbllIeUZDOTJHVEdyUmhnSi9v?=
 =?utf-8?B?T0VlSVVmaThBNmNGdlN3RG9ia2ZGajdMR0ZIbzlyQ0ZTR2EzYXAyVDRKMGU4?=
 =?utf-8?B?bGxsdGtJTEZvUUIxcGVWV1Qva1BtYWNxam1MYXMyb0g5dGh3V0hpcU5Ma1Ir?=
 =?utf-8?B?R0ZvMFdYTnB4Z3lGV2Vyd0VmYVNWNVNxaGR4V1prMUp1eWF1N04xTXBRSU41?=
 =?utf-8?B?T2E3MG9PR2lheERLb2lzYWhtRXQ0bHFrUC9GaUl3aWgwS2JFOUw3bWlvMjVp?=
 =?utf-8?B?QWRucXN0YTcxQWMyVTc2WDBLbWZCamxSeThGUFlMR1NSNE5uYUpWQy90SlVu?=
 =?utf-8?B?R0hUcHV4bFJSNFhyMjArOTErMVcvSmkzSmpWcGJNQWtIVHJsZm1sN2ZyZks0?=
 =?utf-8?B?aEdVWEJBUHlWbWJoRWVQMWtpREpKWStnL0M1U1ZrVUt3M0JPUy9MMU9PRWht?=
 =?utf-8?B?Z3pBVEEyMmQvWFFJVDAxM0krVHk0bjZzdk1mLzFNOFpTczNBa09tY2R3ZzZB?=
 =?utf-8?B?TXVQV2lpUDJOWUlMZVZJV0oyelNxY3lyKzFVQlpsRFNmT0N1S09SemNLYjk4?=
 =?utf-8?B?R2xxY0xCd2R1ZFArRVZpa0FMVFI5K1lHQ1R1SUI2UThzUm5zdkpCRW42Tyt3?=
 =?utf-8?B?aEkrS3hzRTFjM3dpaGdlU0tvWEdxV3VxS0drMWVDV1p1YUswZmg4R1BDZWYy?=
 =?utf-8?B?MDVReUhkbHJVS00wd2oyTWxIc21RK2JBcDdDN3M5b3hWd3hkZU5OZWtLdjhO?=
 =?utf-8?B?YWZBYUszUVBFejdEenp5TFFub0JUaWFJSW1ZMXEyNDBnMzVackVhditPQlNU?=
 =?utf-8?B?RXlFNzh3OUhMSlVvdnEwRXBRN1RNcU5EQWdFM3hwb3VRNzVVR1kvNVBsaDVn?=
 =?utf-8?B?VEU3ZEhMRWU2R2E2NElwdUVQY0VaTWNyby9xS056U0lMMHJzQWNNN3JVOElt?=
 =?utf-8?B?c1FpRmdsK1JpUGt2Uk82UlpWM1RZbWRkRGgwR3hBMHNBQjVEWWxRNmpyUklO?=
 =?utf-8?B?dEpkdUloa1A5K0dLMVo2aUhWdkFldW9kZnpXTlFYblY3bTd3V0R1S2NlZURP?=
 =?utf-8?B?b3drTE5zbXBxMDIwTjhLcktRN3cydXZaVStUK0dSYTFiYmhucEJhSU41QUpl?=
 =?utf-8?B?dkF2a05BRHRjOG1FNEZNNE5waXFiQ2lKZmVUYThFN01FMVE4ZmZ6bCsvTVli?=
 =?utf-8?B?aW0wczR6YXNYQXZHLzlBTlBnMG0ySG4wOGJRb2dta0prQ3drNmZ1OVNMeU9V?=
 =?utf-8?Q?GOuJv9WeqSmYQtqo2f?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56553ad0-b7f4-4c31-2674-08debcb3f340
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:23:40.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvODoTeUY9umxXD8FpYdLJ2+kzrLKzc/KLGD2QTVJFLAezXRT6/fUTaFSUNNNTAW1xQApoFmUJepVUw7dSvA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6194

On Thu May 28, 2026 at 9:35 AM BST, Onur =C3=96zkan wrote:
> On Thu, 28 May 2026 11:20:10 +0300
> Onur =C3=96zkan <work@onurozkan.dev> wrote:
>
>> On Thu, 28 May 2026 09:27:35 +0300
>> Onur =C3=96zkan <work@onurozkan.dev> wrote:
>>=20
>> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_stru=
ct.
>> > Provide FFI helpers and a safe wrapper with a guard-based API for read=
-side
>> > critical sections.
>> >=20
>> > Cleanup is handled via `PinnedDrop`, which explicitly drains pending g=
race
>> > periods and callbacks via `synchronize_srcu` and `srcu_barrier` before
>> > executing `cleanup_srcu_struct` to guarantee memory safety e.g. when t=
here
>> > are leaked guards (via `mem::forget($guard)`).
>> >=20
>> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>> > ---
>> >  rust/kernel/sync.rs      |   2 +
>> >  rust/kernel/sync/srcu.rs | 166 ++++++++++++++++++++++++++++++++++++++=
+
>> >  2 files changed, 168 insertions(+)
>> >  create mode 100644 rust/kernel/sync/srcu.rs
>> >=20
>> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
>> > index 993dbf2caa0e..0d6a5f1300c3 100644
>> > --- a/rust/kernel/sync.rs
>> > +++ b/rust/kernel/sync.rs
>> > @@ -21,6 +21,7 @@
>> >  pub mod rcu;
>> >  mod refcount;
>> >  mod set_once;
>> > +pub mod srcu;
>> > =20
>> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
>> >  pub use completion::Completion;
>> > @@ -31,6 +32,7 @@
>> >  pub use locked_by::LockedBy;
>> >  pub use refcount::Refcount;
>> >  pub use set_once::SetOnce;
>> > +pub use srcu::Srcu;
>> > =20
>> >  /// Represents a lockdep class.
>> >  ///
>> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
>> > new file mode 100644
>> > index 000000000000..343f00d070c7
>> > --- /dev/null
>> > +++ b/rust/kernel/sync/srcu.rs
>> > @@ -0,0 +1,166 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +//! Sleepable read-copy update (SRCU) support.
>> > +//!
>> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
>> > +
>> > +use crate::{
>> > +    bindings,
>> > +    error::to_result,
>> > +    prelude::*,
>> > +    sync::LockClassKey,
>> > +    types::{
>> > +        NotThreadSafe,
>> > +        Opaque, //
>> > +    },
>> > +};
>> > +
>> > +use pin_init::pin_data;
>> > +
>> > +/// Creates an [`Srcu`] initialiser with the given name and a newly-c=
reated lock class.
>> > +#[doc(hidden)]
>> > +#[macro_export]
>> > +macro_rules! new_srcu {
>> > +    ($($name:literal)?) =3D> {
>> > +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $c=
rate::static_lock_class!())
>> > +    };
>> > +}
>> > +pub use new_srcu;
>> > +
>> > +/// Sleepable read-copy update primitive.
>> > +///
>> > +/// SRCU readers may sleep while holding the read-side guard.
>> > +///
>> > +/// The destructor waits for active readers and callbacks, so it may =
sleep.
>> > +/// If a read-side guard has been leaked, dropping an [`Srcu`] may ne=
ver return.
>> > +///
>> > +/// # Invariants
>> > +///
>> > +/// This represents a valid `struct srcu_struct` initialized by the C=
 SRCU API
>> > +/// and it remains pinned and valid until the pinned destructor runs.
>> > +#[repr(transparent)]
>> > +#[pin_data(PinnedDrop)]
>> > +pub struct Srcu {
>> > +    #[pin]
>> > +    inner: Opaque<bindings::srcu_struct>,
>> > +}
>> > +
>> > +impl Srcu {
>> > +    /// Creates a new SRCU instance.
>> > +    #[inline]
>> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) =
-> impl PinInit<Self, Error> {
>> > +        try_pin_init!(Self {
>> > +            // INVARIANT: On success, the C initializer creates a val=
id `srcu_struct` and
>> > +            // it remains pinned until `PinnedDrop` runs.
>> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_s=
truct| {
>> > +                // SAFETY: `ptr` points to valid uninitialised memory=
 for a `srcu_struct`.
>> > +                to_result(unsafe {
>> > +                    bindings::init_srcu_struct_with_key(ptr, name.as_=
char_ptr(), key.as_ptr())
>> > +                })
>> > +            }),
>> > +        })
>> > +    }
>> > +
>> > +    /// Enters an SRCU read-side critical section.
>> > +    ///
>> > +    /// Leaking the returned [`Guard`] leaves the SRCU read-side crit=
ical
>> > +    /// section active and makes `drop` sleep forever.
>> > +    #[inline]
>> > +    pub fn read_lock(&self) -> Guard<'_> {
>> > +        // SAFETY: By the type invariants, `self` contains a valid `s=
truct srcu_struct`.
>> > +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get(=
)) };
>> > +
>> > +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for th=
is `Srcu`.
>> > +        Guard {
>> > +            srcu: self,
>> > +            idx,
>> > +            _not_send: NotThreadSafe,
>> > +        }
>> > +    }
>> > +
>> > +    /// Waits until all pre-existing SRCU readers have completed.
>> > +    #[inline]
>> > +    pub fn synchronize(&self) {
>> > +        // SAFETY: By the type invariants, `self` contains a valid `s=
truct srcu_struct`.
>> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
>> > +    }
>> > +
>> > +    /// Waits until all pre-existing SRCU readers have completed, exp=
edited.
>> > +    ///
>> > +    /// This requests a lower-latency grace period than [`Srcu::synch=
ronize`] typically
>> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::sy=
nchronize`] by default
>> > +    /// and use this variant only when reducing reset or teardown lat=
ency is more important
>> > +    /// than the extra cost.
>> > +    #[inline]
>> > +    pub fn synchronize_expedited(&self) {
>> > +        // SAFETY: By the type invariants, `self` contains a valid `s=
truct srcu_struct`.
>> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get(=
)) };
>> > +    }
>> > +}
>> > +
>> > +#[pinned_drop]
>> > +impl PinnedDrop for Srcu {
>> > +    fn drop(self: Pin<&mut Self>) {
>> > +        let ptr =3D self.inner.get();
>> > +
>> > +        // SAFETY: By the type invariants, `self` contains a valid an=
d pinned `struct srcu_struct`
>> > +        // and `srcu_readers_active()` only checks the active reader =
count.
>> > +        if unsafe { bindings::srcu_readers_active(ptr) } {
>> > +            crate::pr_warn!(
>> > +                "Leaked `Guard` detected while dropping SRCU; drop wi=
ll block forever.\n"
>> > +            );

I think this could be a `warn_on` similar to how cleanup_srcu_struct handle=
 the
condition.

>> > +        }
>> > +
>> > +        // `cleanup_srcu_struct()` may return early if readers are st=
ill active. Because `Srcu`
>> > +        // owns the embedded `srcu_struct`, returning from `drop` in =
that state could free memory
>> > +        // that is still referenced by the C side.
>> > +        //
>> > +        // Wait for all readers to complete first. If any `Guard` was=
 leaked, `synchronize_srcu()`
>> > +        // will sleep forever.
>> > +        //
>> > +        // SAFETY: By the type invariants, `self` contains a valid an=
d pinned `struct srcu_struct`.
>> > +        unsafe { bindings::synchronize_srcu(ptr) };
>>=20
>> Sashiko got a good point here which is calling synchronize_srcu() only i=
f there
>> are active readers. That's a nice low-effort improvement we can have in =
the next
>> version.
>>=20
>> Onur
>
> Actually, now I am now thinking about whether we can come up with a bette=
r
> approach when we detect leaked guards. Initially I came up with the
> synchronize_srcu() solution because it would handle leaked guards automat=
ically
> without requiring any additional checks. But now that we can actually det=
ect
> whether guards are leaked the question becomes:
>
> 	"Is there a better option than effectively sleeping forever when leaked
> 	 guards are detected?"
>
> I have no plans for tomorrow other than finalizing this series including =
the
> question above.

The best solution is to proceed cleanups anyway, given Rust rules ensure th=
at
these are actual leaks and not just srcu read-side critical section that fa=
iled
to synchronize with the destruction of SRCU.

This obviously require changes to the SRCU code though.

Best,
Gary

