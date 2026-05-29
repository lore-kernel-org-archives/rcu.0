Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021135.outbound.protection.outlook.com [52.101.100.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C073D9043;
	Fri, 29 May 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055906; cv=fail; b=iYWDCfmkuXlStBRR+lnnXS3aWKDk7Mdx5h8rp72ZPTlcDwV8oImAOP3qSa5ezbZ2yGYzYNlpROTrQ1htHS6FoPbL332sAfKMqDBddDaZ86GLqlNy0ttSioqKThbPG7DKFHcILjIYCkehFVIdMvvBUItegnfVgfLYwjGVbi4qdm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055906; c=relaxed/simple;
	bh=mNCbuXxY31JPeCyac9D3YI2y/1Sj5ZEG4/v/7Big2Rc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=bwmkejGhSj5llS3E9X8dOn5nqcKAtCnbxgyV+8IVhGbKGbmUw4MvZ8euy3yiQ98eOw0xeaMxefKtCAZzI/Lv28H7zD/TJCIknzHIjfoud87Cy0aXU+CtlBYtxp9Cxq9nqUhaRkDLCIjs1fqzMBMOKgSJtujZtzsHxXnDxL03Ehs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FuIkFaJC; arc=fail smtp.client-ip=52.101.100.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FuIkFaJC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPoxIkaY6v5eZrdBuhQ2IX0anPpLubihq8dmsJy717bfEShtv8L2Apx8UU8reDOUi47zfMCJ4d38IZxZvj+gxyZLp90wtNxf+qt3JPyXQp/yzfbWxUbsyB9YEBMS09EFhGTJkuF1vBYcpuBrxP0p1xR8RU23rMQ8ASpzK8l2/9EJvY6ZJkjEFql6lgP3DJCKei22TXoLiaGNI/+xE/HJgG5gJ4w/HWt9KohzXqjYUqsWPDDcg2hrmTamXUqK03/GhEOvSaS1XCcV/i+LoZTgc5GlzBZ/p/gN3pPY8d374ifYKIY0FTf+njjptGQ3zSPseGbVtwXkUF7W4CkKyXO9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EYGD5nd1ZaCjLMI+T8wItufxsxuY323SzX2AKA4C2k=;
 b=tToAOU5fEkB9eu4DpDsPFkykPyyAgYHfsrye9tHRpBI2bA76GxEzuMAA9Sa72BkLqziGK9lC6BErDhYPDyzltadMpu1jkfSMAkWq8C14VB2SGIoNCw7elrSKBx5FbVIHloFZsGGfKu+Cueu8yFIVod4CJiXwyrYWebtZMq30n97NAFjy/y1naaA8BfipzXmm6cXUxrvuKHMAhGEgOBv998M/cbgDgH2LRDF8oJX99cHVWe7IMrOjJCKFCr3nam5SvviC8uc3F0hy1Kwqq4YQ+h/Rbmnd+HWi4Azh1ZgknLDlUtV22ZaAI4t5gcPNYjNNfLpGJ9sUkHne9jkwxkV2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EYGD5nd1ZaCjLMI+T8wItufxsxuY323SzX2AKA4C2k=;
 b=FuIkFaJC3RtNiE1VO1/wqy+QwpgxPxMTLgjZKD0P/gKopzN0A3xy2JRpcuU+403zlrNYVVjHK7HrOIpWGoHBk6/gD3djxJ/GzypJ5+BT6MovfRB1BuMW5ClI/lJtjmo1VgyRgcvcCwJ8hcpXPos7YG9wQf/lIi5gTF/7SIW2iPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7765.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:58:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 11:58:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 12:58:17 +0100
Message-Id: <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v8 1/4] rust: helpers: add SRCU helpers
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260529114449.112066-1-work@onurozkan.dev>
 <20260529114449.112066-2-work@onurozkan.dev>
In-Reply-To: <20260529114449.112066-2-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: bb79dd5a-aa6b-47ba-9016-08debd799240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DYdpvbDxBmYw8IFcrtmwwu6yT5ARGypq5y+phW1MbiKLCH0PvpzMvSPLY0vOArOKav68QGb8LXANRSJaJqTHVLCqNRhe8Iwvt14sLY3XTmL3o0a28JvsHr411J0qO/QHq/NqB51dQX8YZN1xmr9xPMRFcio7gU8wLzYAqaCw/Dvy530HbNg4WNh7zNW6Zzqa1iTY6T3dxwXylqoTI8cwy5Gnriq6Wln6rNzpG6M90YIA7O/rgYC5wYXo3goaMfbUQewZZzLLMG1v0Mm3eIQJa15lT4X3lvWB1deVu1SgRbUsgX4OM5+uvM88FBVI/uaDJdYor52VoNExsNYSUlkBKoJbjLCPgZcJqQw5kvGA7r7EIQdk5PN9/6t5czTFi9KjZ2Gz0bz8vQm5RSb5bj7JmxwpZXgzxNewLfFEc7ojOrIVIfv72QZpMxvMXuGGYdwDhCYDjKVBSvHEs/QrM57TJrxUWk6VV9UijQQg88M+3gC/icDywz+I0UrVbqaEWuCjdgwRvbpnrPzV6jqJu/pKuuuI+jEwXRje3y49fE25QtmcCoeB6OF2qUGrYZCKaUvyoTy3eJF83npNIlhvYR/hXpXI7SnZs2AKVTY/MhriyR2PLx9L10fpQZ7y6zaFomdNE3gC/xgA3oaOqdwFGPfv7+B8PmXCYkA3QP+5r6ZvQ5HXv8jNGQQP4HdzuZ2VU3/ujhbo1HhZkvBk5lsPLXAFzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZ4S1N4WWxBR1F6ZXcxcG9SR2ZmVS9NWk1iSENqcXVON0hpOXB2UkhQQTdh?=
 =?utf-8?B?SUl4QmUvKzhCNHBFTFAxdnE4OFpsQ3NpZURaeStvdVN3UnRNSjdDNXJjZkVx?=
 =?utf-8?B?SU1xK2UveWZZVDFoOW45Z3pRTUx1bHVweUx1YUhZZFdZRUFPUG54WjVpRTFP?=
 =?utf-8?B?MnZJMzhGaUNML1BCRlZiOW9VbW51aW1wcld2SWdKNzVuS09oRkQyQjRuclZK?=
 =?utf-8?B?MmdUeXlsV0ExcjNjcmxIWHpMWGV1NlRSbElkRk5FbVowb2NQN0EyMm9sMEtT?=
 =?utf-8?B?OHIxVHd6c2w5K3JlZFdhbWc1Q0d4eU83bDYvTkYycHlTQ3JlZllrL0E2Nzc3?=
 =?utf-8?B?QzhhbGcxUGFqcm8rYW44Y29wQWZrSjcvbnREd0MrTnU0VXdrQndWbjlPK0cx?=
 =?utf-8?B?STJmNjdZclRlYzJIUnV0R1dtQTFTU3g1SHkwK2lXQUYxYlNxblpNWktacDF6?=
 =?utf-8?B?c05VaEkyNE1BczlrRS9DSU1kdzdFbUhJa2dWNU5rdTJveUFlYkQ5Zmt1K21N?=
 =?utf-8?B?OXNIRkt2M1pKblVVMXVVVUtxeEFaNWZHdWwrT2xKeVZuNis5TVBJY2xkaDF0?=
 =?utf-8?B?bzl0VjdrblIwZVdiWGtjNlE2VFUyNitrT2R6S0p1OGRTWnJPcmZlV2lDUGw4?=
 =?utf-8?B?Y3BNdXBRVmYvOUU3ZUdEeXpySEZGY1lYakpXc2ttZ1dSNTB6RldBS095bktW?=
 =?utf-8?B?NDgxdms5M21wN2J3Q2t2MFB2T0YvOTI0bWZ0TVZJNU1MVDczcDR0ckJRbDBW?=
 =?utf-8?B?T3dac3hkT2xmTTZQNHVkWkxKSTZmYlA5ZGl0SHBkaDE2Tkd1Y2JtU1c5dTZZ?=
 =?utf-8?B?VUhwTGo4L2gvRWxSKytVZ3d0SXI0ZjNsVm4wTi9YWmRNRkptUUJkcjRGNkor?=
 =?utf-8?B?QXozemNBNjBXOGxnY1pWbEhnZUxPRkZGV0NBenl3ODR3SXQ0YzdSbW9JK01Z?=
 =?utf-8?B?K29paWVwVE5OYTE4VW1kbVhxNlVQOFdEU01UV21VeUtkWmh3d1JBQ2tBSHI1?=
 =?utf-8?B?UTcrY2F3NDk1Sm01UC9Ra2xlUG8zUTFOK0V2VndrTkNYaVlRTHBKQlhWL0RE?=
 =?utf-8?B?YVk4WHdVbnlSU0hVN1NQYWExNEpzbUpzb0NhQ2lsVjB4cEFEWXAra0Q4Vkxn?=
 =?utf-8?B?bFRXanRzMTN4aEQwT3JpNVlKNEdnQ29oWXU2SUFXUTJweHdrTEI3d0pCdlcx?=
 =?utf-8?B?SktXeXIveTJSVWFuMkI5YVlVeTRuK0dlM1ZQMUR5azhuNk9sYlBMRGdQMS9z?=
 =?utf-8?B?NkJGblJDWXR6UUtzTGE0QXJiNmg3WWxPSFQ2UlU5VWlScGhMUE5DZnkvMzdD?=
 =?utf-8?B?dDZtOWI0Um9BREEvM2RpMVUwWFQ0MEJ3bnZHVXZZelFiUnRpM2wwZ3FHeDJJ?=
 =?utf-8?B?MXY5Yk5iSG9vSUgyazBjSTJpMTArSnllSDJhenpOdUtpMHN1Z3BYUzZQM1Q3?=
 =?utf-8?B?dktxa0xFdDlFWFJzenlMcnJycG5wMWhzMjNqK2k3aGJKMmZqbWtqMkVkK2I1?=
 =?utf-8?B?N01QSGRFWmpiOGxkaEd4ZEw0ZThmY3lpMHdVTGpHRHJTQVpLL3JVOGZST244?=
 =?utf-8?B?L1d1TFJMeWRXeWxHZTUyeEpTVFNZbFVTZk55RXM5MFNmTVpKUVlDTzdPRStk?=
 =?utf-8?B?QWpFb2VHakpnWkJMTjlLV1pEdkRQNXJ4WjlKSGdUSElkWDJOMXcycENBZ3pP?=
 =?utf-8?B?UytzYlM0ZHIza1Bub2ZHS2N6TjU2UHJsL0VkV3Z3T0ZSYWF3QW8xZGx2QlU2?=
 =?utf-8?B?VkxITVJic3R2RmxMSGV6QXNxQTYwNUU5YTZ4MWFvWDVHYWUvVy93eEV6ZWIz?=
 =?utf-8?B?ajdTVzRkR1ZDODArNHQ2NjhkZFoycWkvRHJCZG81OWo5SmhsWHIrSUpabXox?=
 =?utf-8?B?TUtaYSs1YVhhbCtsSW8vLzBIOFlabWIzdm5CUXhVckFsOFUzQmVWRWpja2dp?=
 =?utf-8?B?dHNwSFZ5RXJuMFBNVWxQWnEvWkxuV2JYbkhCQ0hMVlZZc2l2STNxZkI3bGxC?=
 =?utf-8?B?Z0ViakhkbzNQTnJ6U1NzYisrMDB1Mmk5aEE4WHRLUGFESENleWY4TFllcTMw?=
 =?utf-8?B?MkNmZC9vN0wwRUhUMGRrRHU0SmVpVlN2QmNLcTY2VUVGTWU2M1RSaXBqdFRP?=
 =?utf-8?B?QUdXa2dEOTRSaDYzTWRDTU5HNXQvdEhhRzI2YjJ3VFR6NUdweHcrem9YSGpM?=
 =?utf-8?B?RDNWcy9YK0pUVlpTS2FMaGx2Qks1LzJQZWNSWFUxVWVrMUtFSEVhS0dyRElB?=
 =?utf-8?B?WERkai9hNUR1MDkxTnN4a0oyNGxTcHpvQVN6UE81OU40dk51dVp4T1cydmVQ?=
 =?utf-8?B?RGhETTVrTEJrZjhqYStZUEdCMUdmMUMzZk9hRUNaOWJHQmJiSGlSdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bb79dd5a-aa6b-47ba-9016-08debd799240
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:58:17.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZpNPeKaBWAYThFaVSfQ7uTNULHnAGwsQR4VXybYvcytEzds5DEpIitgtf67VGFbTF67EhgZOWd/yyymQ1G5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7765

On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:
> Add helper wrappers for SRCU functions that are exposed to Rust
> through generated bindings.
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  include/linux/srcu.h   |  5 +++++
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 rust/helpers/srcu.c
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 81b1938512d5..790a4ef713c0 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_struct =
*ssp, const char *name,
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> =20
>  int init_srcu_struct(struct srcu_struct *ssp);
> +static inline int __init_srcu_struct(struct srcu_struct *ssp, const char=
 *name,
> +				     struct lock_class_key *key)
> +{
> +	return init_srcu_struct(ssp);
> +}


This looks like a different strategy than, say, how mutex handles lockdep. =
IMO
the way that mutex handles this is more clear.

If we follow the way mutex is handles this, the `init_srcu_struct` would al=
ways
create lock class key and forward to `__init_srcu_struct`, and
`__init_srcu_struct` is an inline function that either calls
`init_srcu_struct_lockdep` with all args, or discard name/key and forward t=
o
`init_srcu_struct_mutex`.

This is beneficial because the usage flows one way. You don't have in one c=
onfig
`init_srcu_struct` call `__init_srcu_struct` and have the opposite in anoth=
er
config, which I think can be quite confusing.

Best,
Gary

>  #ifndef CONFIG_TINY_SRCU
>  int init_srcu_struct_fast(struct srcu_struct *ssp);
>  int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 625921e27dfb..f3562d3b3888 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -88,6 +88,7 @@
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> +#include "srcu.c"
>  #include "sync.c"
>  #include "task.c"
>  #include "time.c"
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> new file mode 100644
> index 000000000000..225b3bf9334a
> --- /dev/null
> +++ b/rust/helpers/srcu.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/srcu.h>
> +
> +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_stru=
ct *ssp,
> +							const char *name,
> +							struct lock_class_key *key)
> +{
> +	return __init_srcu_struct(ssp, name, key);
> +}
> +
> +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
> +{
> +	return srcu_read_lock(ssp);
> +}
> +
> +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp,=
 int idx)
> +{
> +	srcu_read_unlock(ssp, idx);
> +}
> +
> +__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)
> +{
> +	srcu_barrier(ssp);
> +}
> +
> +__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_st=
ruct *ssp)
> +{
> +	synchronize_srcu_expedited(ssp);
> +}


