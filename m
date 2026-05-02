Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021111.outbound.protection.outlook.com [52.101.100.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072929BDB4;
	Sat,  2 May 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777744562; cv=fail; b=WSF5QG7H6UfeSfxnTIFo23kZN+Y9JAmBYJH0umftrQcqf8ZYQnwpg/GH3KPOvOUfr8pnYqde2weFtcZKtb4DHZhh/BEVYNUphCfcpnS62GUhinjX5vo1VZquPxP+5wDpAVikS/vkbtzUm0dpMfTTgTW8dfEidinBqRgbIUnh/Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777744562; c=relaxed/simple;
	bh=SC0bDiKioZYQLZrf/5XEXeHsMp9Ncq3mTUFJwwUtHeU=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=UrKEcjZPMm8Zyw2MB1qYgYDKEStYXxRhZuNF3KUaw0Vllt7/gGbEqn2tgQ/FbPPWmpKQay8joK6wFaj8nzkOXSzyG5B0lKEDYVMopKDtCIXLeIxwfwmcdgB+g34JCJuAr/nmS+TwxRN2qNlWfAnR7B3Awpo5XfmPH8SE7hAMXaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NgT7Ttmd; arc=fail smtp.client-ip=52.101.100.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NgT7Ttmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5s4mC+T7qGcs90BDMlVx8e26nCFo/iwy1J9OCR5nWXr3deWyx9HSn4dFfQZuj5SzRmTYasu6RniY+SbwN5RhTvTZAoADnz5pDz2GtlbPu0m511XZWM+YmNxJ8Yu1uMUwSXiy2oaxtHnr469PMxc/vgIIQiPMwQB/p+tkDKG3xTR8Wn2uKTrRIt+dHKWu5PmyyzFhdqQ+cKFZFOHJn9eCAXkxrT72upZQmZErc2aRKipCuUeAopzvQ1o9OMFM9XbRf9R2W9Is+o0S64cUPv14tPr4JoQkCTAkgC4OQ1ZqKYOKzfWoWAaEagoUEWSS6czOKD/jd8Fh563j17qeyvb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6DVH0A3WoZ8WH4YNILANogct+IZifBYE0fkbic/Lfs=;
 b=LlXIhrwBl4tvJyheUVMyRW+82WGJtUf9AV0ZzywC1gO4WKHFJSaudkyIv3Fbj4Bf7m8f2p7NXPP4uW8F1NPP7CN4mNISi/OT5RLz4zQFkxmI9rRhBvF+0c//MudDTKXM/NpoJVW75V3bbkTy5PxBvs32fwjnvRRIIp8dPNAYauX1YivFtubFq8ck8H4MaW+o3VnV3N57jnkCtCIdMovDP2YLP1mPca5Am2/LDS7UcyfiplLJ+bZuGgDmSMQIYnu8vKMePB1UAPKVrW74LLQ9UWGz6sqvPgxq6GDKZxVlFwb6gsg6eF64ZjWJG++hz6uYq+XUDO+TROWcGJr1P8kRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6DVH0A3WoZ8WH4YNILANogct+IZifBYE0fkbic/Lfs=;
 b=NgT7TtmdnU798i1HYibTBU0F9oCJujBVLmm+W9nq7CY8t97T4OvwrOrzQdOVL65NVuVTlWEwTYZM+aoWISB+0kw4X7jnUGIHvjOppwryA42ezU69WNZiM/ioz6z9HlOVEKue8i94taWBHWYpMXnzuKtw2ZocqrHstFIjiroaV4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2400.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.24; Sat, 2 May
 2026 17:55:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 17:55:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 May 2026 18:55:56 +0100
Message-Id: <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 2/3] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260502162833.34334-1-work@onurozkan.dev>
 <20260502162833.34334-3-work@onurozkan.dev>
In-Reply-To: <20260502162833.34334-3-work@onurozkan.dev>
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2400:EE_
X-MS-Office365-Filtering-Correlation-Id: 87919f8c-d94b-4023-ad6f-08dea874102d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vS+Wl628m123V07ezsyaku6f141eex1nqU+4Ua9rjE3u/JDy7mQVoKhDW/LUbb/L1HLo6KfjtOmo1mC7NhRzGZ6laB4qmRFzbgzoPW5U/VRrgW+yosCpNwRXUi+oImCIXR/FQo2Pt7L48Y3lrXFIFXI17muXEoUG1IY90cUy7I4fSo4wLV08qonLYmHf26RJXpDOwnzzVMU/j1zdVyft/s5ooMPzrHvUTZnWI4pTLUyT1PGQIEQMrCzJ3+tH7BG4/Y0798Lm4ZmBiuZY+7XuC0gEJpb+aorsaMoBOmaf0xs8SmEPRJh7revJwUZSuSHAebFtyNKsc7qnBqr0K4E3v7nRIBGurkF9PlP/Vjpn7/Pi8UvhKjMWrv+d+yRTq3QiOxXL9gup/rZtTssQCw2XWmlaRw0wvSGQpxrBA89mgKsKRg8UIrEELIc31l4cWVdWEeH8I8gamrn2Sz5jrfSu1syT0vcR9fXyBFCK8HBQ/bEHRtNWG8Vt1VnEPNKv94zMtst/wvf/YZeNSwZUFUNiYoR3otpNvm3oHPfTURK+fYrtTk8sqMgj6gt86FBpiqL3m5wbu3VGHUG6XocTFjIDhBJlJkILS4EIQWyBlJuBzqgnYIipgeYrAzo+0nLAqU5ym5+5RcN3/sAF/xk6avWsoJKPBGsFT6IXFxUFF2QdgT7af81E/1XD5hrHkY6s3bla
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0E2UDlDcXdHL1lyOEoxZmgvd3hKREhnbFd1ODlIZlZrUHc5eG8rMWlHNmZj?=
 =?utf-8?B?Y01RczBrQ3VJV1RLWFJUZmtrOGd2dU1EV001TUkvN0JQT1A0anMrcVJwSWxy?=
 =?utf-8?B?a2E5emw3aTBkeTZBSDNBSTNoS09lRnAvQitreEtwbU9XdEc1R2dvS0I1cERw?=
 =?utf-8?B?ajlxSVcxWUpER0RIbEQvbFU2VjMxYzFuSlNtMFhBK0xsVmNsa1ArNXlBVkV4?=
 =?utf-8?B?elY0WVVKNHFvUHp0R3FmYllZY2FxTnFRK2szcDZUR3F2dkdlbWRPRFlyZCtS?=
 =?utf-8?B?UEhBR1lVRituNTZDUkFaOTZlNFJXendRRlRiZjJPYmJHSE5lcitGcXNxd252?=
 =?utf-8?B?QmtjcnVVNkhQcTl0OHNsWFlhOVhNRHBXd0diSEdVZG1iNG1JWE94QlplRUNs?=
 =?utf-8?B?KzhtSzN6WUUzNnlITU9SKzhWeXY5aHZ5M0I1cXk1N3hEdGtzRWlzR0hKVmNx?=
 =?utf-8?B?RS9lRXVCQlNibVd5WXhMSDlSNFVRMHd2UFNtMGczK29mSHdSYWZKUTh0T2Q2?=
 =?utf-8?B?NVByNk5wbU1ES0pLd0N6cy9KVlhrVHpQZUpveVlpK0RvMHcxaUp0SVREZGlj?=
 =?utf-8?B?MDZYeGowRCtGSy9hQ1N0UmU1UURONTJwd3czSzRQNG1BQ0Q3UjdPSzRlcXNY?=
 =?utf-8?B?Y1g5ZmZWWEhoOFRFTDlhd25sVktUS2xIRU1nZVd5eUIwTGtySytjTlhUYkY3?=
 =?utf-8?B?RzhydGRETXN3WVA4UkkycWVZbm1SeHdGMkJIMmdHQXdxb0JpYXVXWTFvS3Yr?=
 =?utf-8?B?c1FwOU9qOC9LMXRPLzlrbHM5a05udFVxMnZ5TFZ6NUk3TEpkbTN6cG5uakFN?=
 =?utf-8?B?c2twRTNIOGk4US9uRUJ0eVF6Z1loNUJ3b2tBYzgyeGJXZU12MmQ1OEdBeXY3?=
 =?utf-8?B?bFNlalNUNkxjZHdZakYxcmo0K2xSVEkvVVpnVk9NOUYyYUVMa3ppVTd4VjRG?=
 =?utf-8?B?a0xkTCtJTTQ0Q0ozZUY4Ylg4RVR6UW5Ob1dFSHBscFRlZ2haVzRpS3RUL1RJ?=
 =?utf-8?B?U3ZNbXh3RkREa2NsTzZYWXJQeGpqM3FKbVI5NFg1bEJFWlhhZUMzVVcxUUZY?=
 =?utf-8?B?RmVkSlQyaEVNU1RZa0hrbVlpRm5HcHVmWGJxVmNwb0xZOStHVUxXaTJVNXJ3?=
 =?utf-8?B?aURibzlqYkVtMFVSRWJ4SGhJT0l6VmEvMFlXOHNrOXNrYVlOdy9WUkp1V3Bx?=
 =?utf-8?B?RGtXb1JXc1QyWWhDR2szK0JlOEdFWE1CVlhRRFZMS2lIL1g1Z3JVVXl4MDB4?=
 =?utf-8?B?NUVubXpLTHVaOVI4Yy9iNWJhUVFjdVFha2J4eTl3Y3FkYWF6cGE3MUk0dXNx?=
 =?utf-8?B?VUNMV3U1WndVSlNNM2loVWN1TjJlUGhZMW9yUnF2MzB5ekdSL3prU25GVDdr?=
 =?utf-8?B?cFAwZHU4N3lSQ01xeDlMV2NqODNZRWZDbnNiNUh6eU8wZmF1MzdDNVVJVTRJ?=
 =?utf-8?B?V1l3N1Y5bVMwdzNvRXMrc2R4MG5ET2ZSNC9ZSFZkWURPTjZxUVlMckZCSkM3?=
 =?utf-8?B?QVIyeDhwUENWTm4vNC84TW1XMUhEaWU5dHA3QUUrVUpkMmlpRkkweFp2bXlK?=
 =?utf-8?B?UDc2M1pTaC9YVnN0ck5CUFJITXN1bDJMcXpIcS81L0Rpayt6SU9Hc1VhOHh4?=
 =?utf-8?B?R0drZUFSZDZscW5CQVlwL1d2NUduYi9RU3N2OW9LQ0VZcEpFNXh5VTgwUW5J?=
 =?utf-8?B?Qm1RQitYT3hLR2RVTUlGNC9XTCtQWTV0TlRxUGdIajMzK05EOEJtMHp5dHo2?=
 =?utf-8?B?b2R3UDQrL1I0WEp5T3hWcnh3WXF3a09UaWVCTzZTaXYzQkdpRGVmRkp0ZU9y?=
 =?utf-8?B?NGtpL0YzS1Y4MUozOTAycHhjdEorc3NpTVJXUmljQ3U4Tks4YmxzKzlyUzBZ?=
 =?utf-8?B?TlU4Rmp6UFNzN0JPOXo0UDJPdDBtZGpXVUM2Q2ovekgwN3YvY3hjVnZyakpW?=
 =?utf-8?B?UDUrdU9PUEU4NTBiT3poaTg3bk1CcVV1Q3ViRWF5M0lONzhvYmVTZ1ZrdFRM?=
 =?utf-8?B?ZEpab1dMd3hyTFZ3cDhVRGY0cGNtZnR0c0JVa3ZjYldCTG10cHcvTzMyOW1H?=
 =?utf-8?B?am1JMmFaVnd5USsvb0pieXFHNHVCa1VwYk9CYUxEdFAzOG5scExraWhTRlhE?=
 =?utf-8?B?Z29zelYzcFAzUDVpN0RKcVBxY3huZTFIUmpCMG1GNTFCbVQydGNXTElFcWlV?=
 =?utf-8?B?aW5LRGliSlI1TTh4SHNtMHVTMUhnM1ByMGdZQk1JUU1vYUZIeWxEV1pVNHlX?=
 =?utf-8?B?d0ZoZ0pLaktxRDNsOUppYnRFOEYzZExnYS9VQkVxRmYrMjl4MWZmNy95cGVi?=
 =?utf-8?B?S0lmVzgwc2dDczlIL280czRlUXpuaDVObG4rb2MrUDBqZFprSXhVUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 87919f8c-d94b-4023-ad6f-08dea874102d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 17:55:57.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGLzbp5jNSGc0T8OLnOsPbgYvaB1//1mFAC9hMss747mBlf75rgUyvZScBMtQg6RMdxZQ8Jsdq2N0bK1HzjkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2400

On Sat May 2, 2026 at 5:27 PM BST, Onur =C3=96zkan wrote:
> Add a Rust abstraction for sleepable RCU.
>
> Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
> Provide FFI helpers and a safe wrapper with a guard-based API for read-si=
de
> critical sections.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 152 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 154 insertions(+)
>  create mode 100644 rust/kernel/sync/srcu.rs
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..0d6a5f1300c3 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -21,6 +21,7 @@
>  pub mod rcu;
>  mod refcount;
>  mod set_once;
> +pub mod srcu;
> =20
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -31,6 +32,7 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use srcu::Srcu;
> =20
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
> new file mode 100644
> index 000000000000..7bd713e96375
> --- /dev/null
> +++ b/rust/kernel/sync/srcu.rs
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Sleepable read-copy update (SRCU) support.
> +//!
> +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
> +
> +use crate::{
> +    bindings,
> +    error::to_result,
> +    prelude::*,
> +    sync::LockClassKey,
> +    types::{
> +        NotThreadSafe,
> +        Opaque, //
> +    },
> +};
> +
> +use pin_init::pin_data;
> +
> +/// Creates an [`Srcu`] initialiser with the given name and a newly-crea=
ted lock class.
> +#[macro_export]

#[doc(hidden)]

Given this is a new macro, let's not encourage user from using it from crat=
e
root.

> +macro_rules! new_srcu {
> +    ($($name:literal)?) =3D> {
> +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $crat=
e::static_lock_class!())
> +    };
> +}
> +pub use new_srcu;
> +
> +/// Sleepable read-copy update primitive.
> +///
> +/// SRCU readers may sleep while holding the read-side guard.
> +///
> +/// The destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// This represents a valid `struct srcu_struct` initialized by the C SR=
CU API
> +/// and it remains pinned and valid until the pinned destructor runs.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct Srcu {
> +    #[pin]
> +    inner: Opaque<bindings::srcu_struct>,
> +}
> +
> +impl Srcu {
> +    /// Creates a new SRCU instance.
> +    #[inline]
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> =
impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_stru=
ct| {
> +                // SAFETY: `ptr` points to valid uninitialised memory fo=
r a `srcu_struct`.
> +                to_result(unsafe {
> +                    bindings::init_srcu_struct_with_key(ptr, name.as_cha=
r_ptr(), key.as_ptr())
> +                })
> +            }),
> +        })
> +    }
> +
> +    /// Enters an SRCU read-side critical section.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned [`Guard`] must not be leaked. Leaking it with [`cor=
e::mem::forget`]
> +    /// leaves the SRCU read-side critical section active.

I generally would prefer if we could use guard-like API instead of forcing =
a
callback.

I suppose the only reason that this is unsafe is the "just leak it" conditi=
on
when cleaning up SRCU struct, which skips cleaning up delayed work, which c=
ould
call into `process_srcu`, which accesses `srcu_struct`. This however is *no=
t*
leaked, because it's controlled by the user. Only the auxillary data alloca=
ted
by SRCU is leaked. So UAF is going to happen.

So in some aspect, the leak caused by `srcu_readers_active(ssp)` can cause =
more
damage compared to just continuing cleanup despite active users? I think th=
is
could be changed in one of these ways:
* Have SRCU allocate all memory instead, and user-side would just have a
  `struct srcu_struct*`; then leaking would be safe. This is probably a bit
  difficult to change because it affects many users.
* Continue to flush delayed work and stop the timer, and then leak before t=
he
  actual kfree happens.
* Trigger a `BUG` when the leak condition is hit for Rust users.
* Declare the `WARN_ON` to be a sufficient protection and say this can be
  considered safe. Kinda similar to the strategy we take to the
  sleep-inside-atomic context issue.

> +    #[inline]
> +    pub unsafe fn read_lock(&self) -> Guard<'_> {
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.
> +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get()) =
};
> +
> +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for this =
`Srcu`.
> +        Guard {
> +            srcu: self,
> +            idx,
> +            _not_send: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Runs `f` in an SRCU read-side critical section.
> +    #[inline]
> +    pub fn with_read_lock<T>(&self, f: impl FnOnce(&Guard<'_>) -> T) -> =
T {
> +        // SAFETY: The guard is owned within this function and is not le=
aked.
> +        let guard =3D unsafe { self.read_lock() };
> +
> +        f(&guard)
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed.
> +    #[inline]
> +    pub fn synchronize(&self) {
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.
> +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed, expedi=
ted.
> +    ///
> +    /// This requests a lower-latency grace period than [`Srcu::synchron=
ize`] typically
> +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synch=
ronize`] by default
> +    /// and use this variant only when reducing reset or teardown latenc=
y is more important
> +    /// than the extra cost.
> +    #[inline]
> +    pub fn synchronize_expedited(&self) {
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.
> +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) =
};
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Srcu {
> +    fn drop(self: Pin<&mut Self>) {
> +        let ptr =3D self.inner.get();
> +

This needs a comment on why this is invoked. Something like:

    // Ensure all SRCU callbacks have been finished before freeing.

Best,
Gary

> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`.
> +        unsafe { bindings::srcu_barrier(ptr) };
> +        // SAFETY: Same as above.
> +        unsafe { bindings::cleanup_srcu_struct(ptr) };
> +    }
> +}
> +
> +// SAFETY: `srcu_struct` may be shared and used across threads.
> +unsafe impl Send for Srcu {}
> +// SAFETY: `srcu_struct` may be shared and used concurrently.
> +unsafe impl Sync for Srcu {}
