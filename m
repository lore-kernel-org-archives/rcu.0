Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022143.outbound.protection.outlook.com [52.101.96.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD13AA9E2;
	Thu,  6 Aug 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026709; cv=fail; b=HxO9uEJXMMJnGp94vRG+zRJX5MsA/vNMJebTD+CFE/MyhuBppEmq/XkiOYGzoST5aM/ar3IT19FTRiID8GhpsNhbrJCDaoyzoR9HdAb90/pFSNj5KH4fSmGh5RVupaE3egtv4qK7QQIklD9AoRMmAKcsC5UClG4mZPocHRD/sdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026709; c=relaxed/simple;
	bh=i2FQuXdWXSWsUnHYZVOMZmLyYpbjUQ8uhWnDpc0vIno=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=W36+WPBzer7gnZBoFplzX+cvxc4Ng6GXqFfA49QLlnUxWDhwQUlo3wS82iLkFHq6rL6ktabLgpouPpdpvk+ST6PrTKBLXPv4oCmvJIXYpwFNJqaXSwjlgNXh63OvrBshRjX333BklNzku7DMtofEcafKxCwd+YJ/mnnMcCVHMPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PAgznlcV; arc=fail smtp.client-ip=52.101.96.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PAgznlcV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkVST1F9r6RKNO0M2RXxy96JPvRfRxQw2zutTPkAOljcU5328xXHGrm5VisyCF8D/edrNvSThkq5YTm3YhhvPzEX1zDYxRnJk2ZAmiFgtOnV8uJA79jQmoAQN8AM/gJVYDKAUjZiJCVPjdCdEjoNgF+ksF+HdKLIHUOh+OZhFUM3DDoyB7ie1oyq2s3jxdRYK73H5Qolsoo/pZ3C1op5HVGa4sRoA08Euu1lX5wN/lwTVBTuZh5SNFBR2J2KZx3DYE3HMBE9yYRVQEkW3AJXSW3eiIdBR9ks0bsdmaSXLtacDja3W5f0OxjWvucXweSFNo068PRkwjDpS1/LpgRGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b4/QpiWcT44iBzFEVJvjJouhXlMVu5CaNpiIpOjh+U=;
 b=QDqRxY7VKKOZErMi8mQMxkK+IIeqsL8i4STkwpUDFQ6e6+CqvI3PfQMxL103TURjxfi5QvgceqUsOepu/k9FQFFngI0XmBSm6LbhF4aCdMmwPrIK+p7phBYvkurnIPWHEm5GzpowxH4aTJyowUY/nHhjvPv427hplLpxBp745fSchWNfjC0/fNicV7Ook86ve1ifHVxcbL5MqamQzELHAYtoutO+AmfAsvYcA2Kn8oNuBdvRQp1IxHCFb5VrYqhTU9/Jqj1z6V8mC3T2722okX8aGBBfKbr4jSqz4fVvp4GdPNFu5PKnAuGbaj3v7x+8C3rzPr0vVhd7qT1BmCcQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b4/QpiWcT44iBzFEVJvjJouhXlMVu5CaNpiIpOjh+U=;
 b=PAgznlcV/yiLm/Zs0j0N/597XjDKwubk6csnDuTitCOyqOmlQrnmWannp/0fnrQMFXRgLgepH/hCJCtq4tCVmIl3ovEMMM8bZb1g5JFsK3rxFlUdFtCV5q1hztF2VsdVZvq8FlRI7QobWWUjO1s/llf1d/hdNT1+tUgbcOwJOqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB3177.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 14:31:44 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 14:31:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 15:31:42 +0100
Message-Id: <DKHXMKC3GJ7Q.4G61DUUAFY05@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v9 2/5] rust: types: implement ForeignOwnable for
 ARef<T>
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
X-Mailer: aerc 0.21.0
References: <20260805145949.938505-2-phasta@kernel.org>
 <20260805145949.938505-4-phasta@kernel.org>
In-Reply-To: <20260805145949.938505-4-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0571.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::10) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB3177:EE_
X-MS-Office365-Filtering-Correlation-Id: eee25dcf-78a0-4c3b-b45d-08def3c77035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|23010399003|7416014|56012099006|10067099003|6133799003|18002099003|4143699003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	hJBGW5wOqqrINZdjOJZn38+jStivcxiRUlkBwN7TPU8rbRmDMVgrxdHBfWBw0bzDyhf6zCF88GL0mW+TT1hCdoT8PbXkfOnUVWRFrdr161jnpPEJSjvRU6BzaqE8y9Di5pTQ8Xld/P90qJl6NzjdwPbWR+LlX1H72X30wU/M2Hubn9+Cb7LZ6cUWj1JjP30PPbrzuhqNVzyVi6d9xW7u/VFQlIN/YKdG7fn0eJJysdpWBTcCdZ/CVjIoajHOBG5Oe4z4+F56lAAgGanMzFP6bwcHtj9Ry+VwjSTaR1ausfsAvqVVHlQ+XtvuBlwgDR2LDGj8yB+sC5LAM690Ya1COiYX8spi9Q1tphI8XpbajRJ4/7BwJ8vHaoWQ9h92Rml4Zl8hNXpElTr5Ip3SF+Jp8nfPdQwkNYMYrUoWyJNXdeWtZu6YlRY02QJx/6/c3cFqmkofdikLwyHq/DZrxfdOI7Xo4D+i0Zqf0sirWgtKVwP2n8stSr+FX+5+VPH3Lqfo5pk0ikdUb/vF+X4Ab8XBq2ICUe0fcOcKhTSjeciUyCDVTo4WYc4Gs6+/vvy7mr5ebyY/0Gp42Y0mgnC/7BfbBvMdoRso+Se9O800FnQc0fNVynyFe6X73zomB8lIne+CXragvVBu71WiyI3yjEgvcvOt+uRUMWktgF3uoy6/627BrVFLewKhN3AyBXKMTZlZp5vlI0IDpzMNEiFoLrnruw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(4143699003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3dhQ25ieWltNk9IdGhSTkRybUdjRXZTeStiQk5lSCs0SVpSTkNaNHVhVXFt?=
 =?utf-8?B?S2RjRWlieW9pZE10dDFKdGJCTktxOXE2TStaSXhnbWVNblY2cnR0NXN1aVdE?=
 =?utf-8?B?WjFFSWp3YmxhaS85RWVaTmNqQ1ljc1dYSm8zeVhNRmkrWjF6bUF2ZUxGQkl0?=
 =?utf-8?B?aUNVczVoMXdXV2JZSExrS2tuZUtpTkd5TjRudWdjUDdBVU80cXd1RVB3KzVV?=
 =?utf-8?B?S0YxUnYxeVNtYkNodzZOWXlUQXR0NjZwTVpMWENtb0p1RGREeGpoanQxTkxq?=
 =?utf-8?B?MFZRZmNmUmxQMk05WXJERERaemc4WmYzSHh1ZTNXRitqNFNlYVQycEpwY21k?=
 =?utf-8?B?bmVoelI1NCtyY0xJUGpJRCsxdHRITEFhcEFMTEh6aTkxK0RDL3daUzkySS9l?=
 =?utf-8?B?UU9WRyt1T3NrTG1TcW9UaHJQNTZPd0JYMEtMWEQ5bUFHZWVhZFg0V3VFT1lI?=
 =?utf-8?B?V1hCbVdCbkFLODR2djRFMFpsWkFXOXhjV0xXSFZXQkZXQXJBNmVmaEhGMWpJ?=
 =?utf-8?B?dC83cG9oODJPd2lybDZKTHNHUmhjRm01Q2RjSHp2V1BOTGs2VGlNR1hJUnBv?=
 =?utf-8?B?U3U3TFVBVUNEa2FHbDRyMHRGOFZDWHF1WFNNQVJSZ0FzNFdvdWZ0cyt6enFt?=
 =?utf-8?B?N3M0S2tzSHVRRmZzbStlbStDSmVSaTdwYkhYQlk3ODRUMW80VkVBeWhvbFc1?=
 =?utf-8?B?VkpxdmlGOXJET2t0YnpCRkxXUWhJVFhvWTBGbGhYaWhWVmx1MDhwUGtNVjRq?=
 =?utf-8?B?ZkZhcXBaN25lMVJ5NjZXYzNzNHpvaHhCMlZjNE54cXM2ek5YMUVBMCtka0dL?=
 =?utf-8?B?NnB0emk4SVpMSjVscW82ekxUMUlPcC90QnZrUTJKQjFTSFBuTksrWTFPUXZ0?=
 =?utf-8?B?SFNKempBS1BOMDlmWFNOTGhqS2ZVQzdMbmZvN3ZaUVMrdEJiUk9hVGJRWVRY?=
 =?utf-8?B?SWZUZExPRGZkc2gzTWV2S2pDVHZlT1ZJUHFxb2xFZDRtdm1FV3lLN0ROSUJz?=
 =?utf-8?B?V2h3V0pyOGhNREZETjBzRWxXWXRyckNtVWg2ZkV1TmhVdENMbjVFU1lUVDdT?=
 =?utf-8?B?eEtvT0xUeDRwWDN1RjI0UkRRWHhZU3BGZW9WY1BaeldQL1V1WG1aWkZmdlgy?=
 =?utf-8?B?NUtQb3g0ZmVGNDZUZ0hvUllKWUc4YUhIU2trZVZibGdZZUVQK0U0aU11UURH?=
 =?utf-8?B?NFdYc0FmQjRobHZFTlVQaW5LREZsOWNpV0RzUkdudHNlbk92ZTRtV0Rqc0Iv?=
 =?utf-8?B?QnJmZHJxOURWZlNTZVpwNTE5cmRHUE4ySzVpU0hiUlVwdi9ZN1dxK2ZmRkli?=
 =?utf-8?B?eVMvUG12WU0weEd2ODQza0pFYlI2clI0aS9WOENrQlIyaE80YmM5dkFBQXZa?=
 =?utf-8?B?Uk9vdG1TRUFDdlp0eWJveVJzMytQcFloMWMxSENIQ3dnTlJSUGFlMHI2cjRE?=
 =?utf-8?B?MFpmVDJPK3E3OG1PVGFUeENKSnhiaGpYTktvQnlDKzlqY2NsbENMYjZXaTU4?=
 =?utf-8?B?WExZVmx5dGhMZmxwbG1uRHBJNEJpd0VvbG1CV1hwSzU4TElmQ3drNldEYnJR?=
 =?utf-8?B?UXYwaVNRWnBkSVhqMGZ6MVhvVlFnaGMxR3JKQkk0MmlacFBrZG5qUWFLZjNk?=
 =?utf-8?B?NkFTdlNzd1RJelptNmxFWHlNWXVTVWFGa3BtcFZ5eUtrRXhGdUhyNlhqeUl3?=
 =?utf-8?B?WHM0dDRnVGV5Ti8waDRmVkFadjBDNlNiWUpNL3J1b2F3MHFoWVhOU0lONEkx?=
 =?utf-8?B?RnFDYzN0TFdxQytkaEc1dXRVN1R3Vks5K213SUlFUnp4Ym1WVkRrcEFrV291?=
 =?utf-8?B?dXhzZlI5OXd3VW1qc212VWdGb2JJaEJuK3dvNUgxMUpvMktXekxYRVpKR2tQ?=
 =?utf-8?B?U1g3alg1bEM2ajN0ZzNBcm10K3JUNGhFalEzRGlHb1Z5dEs0LzAybFB4RXJy?=
 =?utf-8?B?NzhyczZRK3dMUXlGSTRGZks5SWZyY1F2QVg2dVpWQmdsSGdLWHZvcEM5TENP?=
 =?utf-8?B?U0R2TFB6dU5DTWQrUjFRQ0IyRkU1dHUzL1BjWmhGME11VDg3RElCcTBVUzN2?=
 =?utf-8?B?SjdjUUpoMHJsM0VjMzY0UUtCeS8rZktnQ0I3NFZQNVR1TmxIaEFBWk9CQ25V?=
 =?utf-8?B?Vmdvb1FDc2xwVEx1NkFzUHJPY0gvbmtlZ1NaaXlqRDlMSUJyVFFnT3BKTGVm?=
 =?utf-8?B?LzZmVUZNcUxRalJvRkU2ZnREOHhacGdRTG1JdEFyYXNLY1JFMkpaUVRQR1Vh?=
 =?utf-8?B?eXZhdFV4TDllajFFcm5TTTQrNWtldzRNUFBIS2hLYlJSWUhEcEUyR2RIaEU0?=
 =?utf-8?B?QWRobTk3eGFyMkJIakZYaU9Nb3ZJdFRjempsVStNL0pBZnpMdDY1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eee25dcf-78a0-4c3b-b45d-08def3c77035
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:31:44.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBvUAwy7HwgjRmX8E1jwCQxGu697icx5X5OJiCf/kNs+XmDO5cP9VYJoMBIwa/aqkeIKgDsaKWsGKme9/Mt0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3177

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
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a T;
> +

`#[inline]` here and all others.

Best,
Gary

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


