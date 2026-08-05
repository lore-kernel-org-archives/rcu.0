Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DED3A0E99;
	Wed,  5 Aug 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956918; cv=fail; b=Gb5c2CoDP2l2cF4sFZeOlY71G2rKkebiqHtZ0Aljky5ZPC9r41vzzNROST3oF+l+Nyz7QsNF+4s3b0iBWociFriXKZJmmeiArvsSSpj4FUfFxaB47tWgYMMniazwXanRVFSO/aqglBjYjTRn8VNEhMLljNRhzltaxGIm5GP7MV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956918; c=relaxed/simple;
	bh=xDsbwwRsMPaDRZnuaiClh2Sh8SG+E9TXpEKYfMXpbWA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=f8UHHhug3nzbyUWCGE7vhrDQyA2vDW0YfQzor0DLZL6HkRPas1faY8rVIrHAjuT6UfQaGlyg+hV8DI9Wu9bV+OMMwISFndr4qfuIMIMfXX4+UJUOnu65LE6crPPJcwkmUVGo2gkXkPczV0hK1bJCf8L8D1JBwyY03daczOrWyTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mM0kYcc3; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mM0kYcc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1EOx/5fYvCLvqyrRdtevQrRsqSfeb3nZPTHm6iVYqZYKpnU53IT8jm8q0knqBz4vemytmZ6bQlJ8jVOuW7PtJBhWAelILpNf/GsIx3uWOQnwVseacG8AzPBDNn8rGJ9N6JMbZPUy5mcRYYt3cNvfQZUDRdmvlBtqPKjIWibc5+BN9rLs/a2/s1hqlgoLsnjhJlqSEbdGTLML1b3D1exdEeBLPkqeS8/zg9gDvnItv1U6VSTHC0nEwdEnYAMpgQ0l5YbFoZfOpa0qXmJnVe19LhLMQl344VNHIFWSGZdQAZXUF+emsD+JObx5lnBA7mjPLKLLNsfZPkMhWk5eRQwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPp4m/WvIoiEWOkzVlhX0LmXd5VncSdZuqX8H4yeCTw=;
 b=P0eGoPwWdEz/HlbmUr5/ectdD4YyLNJWKsfhCzI5W3QX10vMjmbHZsIHeLVTBgG/w8PYElZL35rl4jYbTDRxvIoIzC1HP4LxaMeJsQ5ChwleqTlGwQwZ/5szbijwHSJqPO1xcuXNempTqBkbtIsTBnyGxEP73MJeRazFIzlo93wC321tp5xtl+LYoEM8BGU8w//bjbjZjmVb6OuMeL3GzY0Mi3mbNw840ET4MUnLdbl/KbBypKVxjn/HVnxO8T2OYmAdMKe2gc8aB/0dQD6ChUeEM96n7YrGbKD5JaISRrZK8rfeQ0FbQhhfUN0+x6J8ojYYAa/KMtqLB3McaN01ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPp4m/WvIoiEWOkzVlhX0LmXd5VncSdZuqX8H4yeCTw=;
 b=mM0kYcc3EoW5HpdlRmd7JXV2lsxXk9fCBIPUNEfykJsRNYXi7q81lDrlhZsgViz7eA5BTIbqR3mhwLmgs3pgyqwn+MiCUGkuV92r5mpluRUlLXSYXm34f2Ae2b8UcF0Fj2F4ZZi9j0r54JA4srNM24Pgc1m93Gk704jLnlFN/uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6144.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:08:33 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:08:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 20:08:31 +0100
Message-Id: <DKH8VYS6DMRS.1K1JHX4IVMYZ0@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v9 3/5] rust: sync: Add abstraction for rcu_barrier()
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
 <20260805145949.938505-5-phasta@kernel.org>
In-Reply-To: <20260805145949.938505-5-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f20ec9d-08b8-4b1e-c9df-08def324f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|921020|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WSzDE6KP42SAODiL4HCeH/KDX9JNnAmMYbM7iKBacaJBfR1oxy1At2VZq2iiR74MuRqxGjImHl7paX2Nu4tvLPI3Pad1Gy2PCACGiio7qf6kKjZDqMX62Z9YNDCo3Eabc+blqipBRmw584r2pV5BtYF/kOXfEP9eqrLp3qK1xzSeOAyNSj55H+pkVQ7mBQNUKnYTf7vGsN+mzMOdCWgPZdbcO6PvwgkdD1sWtFwjZbz6mtB28rBnEmnbCYQPUYhif8r+PGp79FKZV+lUsWVr4dJnI62HGJgWjJA3OB/aFMtxonRMbQtnewmVfqThY+zbeWCVCvFOBj/4qzubeFWRY15VoQNqt3rdDdJDCtTMw7T1AoeFwEmfrVIq37K2S3eBtC1T9K8x5GbDx6GGzn1AhEO8zELTY6llOFyjY1HEdJ0v/LQ/oZF7vpwMkJ80Oe3FT+30w0/uArtBUOcClh+IwyhLWXbFhDGsU9UVdzNFFQwC8lu0jFLXg0mNhYuCfTu8KgZiEUQ0KZW4VOJL3uZsNPCyr9o0Hi+VPER2H9Wt6Fk6BoDXpFnzU6UiaBgp504NacBWiVW5CZryKr2MI2gGkgWHONy1AP0+CNj7x65E7G7C7Q4E3+w2k+zPtCJHn1IucFcM6EV3c/xUc4l7YaCW3cJGi4186KS2Lus1v5BmbsZcY1ypaPzbGfsO+nwEBQZ8oj1fwkhkw2btZpJnQfV78A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGIxZFpvekJ0eVgyNzlIdjZrY29rMWwvK0IxVWRCNjFCRlJDdzRGc2xubFZ1?=
 =?utf-8?B?eXlKWldLZGEwRHRTMmlTU2xrNUM3TzVLQ0lpN2JtbVlsSmFxOWFvNTJzcnkw?=
 =?utf-8?B?R0xRZm9KUDYvemQ4MVZFb3lvbmplU2hFb09kaDZ4dEIwSWo4QWszRUhrdHNr?=
 =?utf-8?B?anRkTkZva0tzYnNvVk9NMDd5cUlvUU9GMDFBRHlSY2NHUVh6T2FhR2NMWXI1?=
 =?utf-8?B?cENlT0lXVUdsNCtTR1dTRGNTbk5RZ3ludDd0L0RLYk5TYkNzUEN4SU42NUow?=
 =?utf-8?B?Y24wWVljRU8zaHZOZ1UyRTcwQ2dCS2hyMXY1Sk9HeU13RDgzNG9HQ3cyZVJI?=
 =?utf-8?B?QVFMOHdvTXlHUzRjcllMMDRBQjFIR1hQVEUrbGJmMnBCcDB3UTBaazdpNkZn?=
 =?utf-8?B?d3QxaFBoSzNzRFJ6WlNsQkJ6Tk0wK09qMGc3SVlCOTVFKzFBVllReTlMMGRS?=
 =?utf-8?B?eUdTUkVONWZ1ZnI4NUdFeE54Z21EQkdLdnpzMzBpcFpzcDNuUUhZWGRxemxo?=
 =?utf-8?B?MFlIVml2bjkvVitxNmM2MDZCYTk2Vm1KRDBCWUg5YXMzVXpldDJ1VHZLc2p1?=
 =?utf-8?B?dkpNMms3cDkrQjRUeldXMHE2Qzl1bkFPZVJqdko1WTdzQnRHeHhYU2hDUmh4?=
 =?utf-8?B?LzRqcHYwQk14Z0NTanlGY2ZpMmJVQ3ZlZHFscG5QZ0lqZmZORHNMQVpXeFlV?=
 =?utf-8?B?WG5PUVVvVkxISk42N0NkWE45cXQ4MCsxWjhwUHRnY3pZV0d6dW0zeWFPQXh1?=
 =?utf-8?B?QmRDNTJiZWZnR2RFQ0ZJNk5kaTR4SklyREdMdGd4ZktJVThrdjQxWUgyS21x?=
 =?utf-8?B?QXlqY3FkNnhyOVZzcHJQcWQ5U1lnTTVjcGNwTzMwMnBlTWRQL0ZmcUpETEFn?=
 =?utf-8?B?T1FRMkh3KzRqcmpockN5ZWh3ZlRiTEpoUDg4WU9HWEFRRUJ3aW9pMDlHMlZr?=
 =?utf-8?B?M05jMWE5UXhTTHY2QmFTZkFOcWExM0RjMEFhMXlHaG4zVGRjV2t4eVRrVTcy?=
 =?utf-8?B?M2IxdkM5dUFMZG9WUmJyTlcybzFIY3F4QjV2SGU0VkhwT0VMTHc3UmJqWFJj?=
 =?utf-8?B?SXRFWGpPNkhZYXNoYTN5QjAvT2RCK3ZHZW1DWXh5V0lxNE5CR1Nlb3l6cHJQ?=
 =?utf-8?B?b1RCN0dWR05KdHNXekRzUE9YbktVR2pKVDdqNnFvZ2lHbW9QNmV0QjlQblZu?=
 =?utf-8?B?R2tSK1lHWnBTakE5UUFuaFNOZTZyN1h5NXVTamM5UkNacjg5aml0d3dBRDZI?=
 =?utf-8?B?SVlXc2p2OVVDdXFZNk42aG82SXRPMFltbVhDV0VJSlJPM2FIT1ZuVUJWVmdQ?=
 =?utf-8?B?ckF3dnMrNGlmVXNOUVFDdm1yNDJlZDJpeTczZzlXWlc1QUQ3VkpYTURXNVRK?=
 =?utf-8?B?b3VwWDZKK2cyU2pqL24wNDQrVGZ2OTRwaHJDNncwSFBEU0NvVkxnWkRSS3FI?=
 =?utf-8?B?U3A1WjVoOG03R2dlTUhCQnlGL3NyUmlIaHg0cFNOaEtFcFdBcGJxTDQyM3Fl?=
 =?utf-8?B?QmhrckJMSnhNUDk0YytCTXcwbHBHcm9wOEVvMUlIc29YVk1DWTZWckxMdWtv?=
 =?utf-8?B?NkVnZ0hDUUVDcGlMOVFUc3pSVGVIbXNCUGJ0U092Q0ZyNlNWV0pXNmM3VWlB?=
 =?utf-8?B?NDd0RlZmUEU4WGE3OE11TnNEMUNYSFd1anlQWlowdmtQNGYyRXBoS3hmd0ha?=
 =?utf-8?B?VDIraUlVY1ZTNTBaOGZmdnBINTNRM2hqaVFGWGhIdjk0WTMwaTlDY1E0ejdo?=
 =?utf-8?B?aWIwN0FTbzllbjJEMHBIQWRiSk5MTUlsbXVBWENvUFNIbGV0dVJLRTYwekZj?=
 =?utf-8?B?RFJPeWc5dXIzZkwySmdDRCsyT1dySStCTExXVHVGNklCT0tWTC9QbHRSbFk2?=
 =?utf-8?B?M0M2RkNYSkhCM3JOaUxHaERKOFhBRTlqeTB5bUVwYlhVNStXdk1oTXNySTFE?=
 =?utf-8?B?TGVvL2hobm5hU2Q5QkF1ZVRUWWVKWkg3SkRHZkwrRjh0OGZvcFcyZU1FTms4?=
 =?utf-8?B?OC9lQlJ4RVVqNGorVWVaN3hRalFnTS9FTE1GZDc0dnRuMVNFN3RsYmJkZ1Jt?=
 =?utf-8?B?NzFvNk9pY3NEYVJvYnpyWGhkaUNUelN6d1lxT0VyNjZnZnh6MTd5aXhlSys0?=
 =?utf-8?B?Q3lwWmVXVDd3NkkvS09MRVFOZzlyczFKK29rTEgxaFBlWUR0aUptbjF0cWtw?=
 =?utf-8?B?YnlGRGJPbERYV20xQzNMazZmZXEydk5IQzY4RElqT1NzYzV6ZnFaRi9HS0Q1?=
 =?utf-8?B?M2psMkpnck8xNldEOG1JRkUwSnlheHhHcVpwTG9KRDRVd3phRVNrQXhRWm9y?=
 =?utf-8?B?MDlqeWF6Q2dmWDNUUUxLMkhQdGlUWE5kQlVhazdEWXRhYjdyNmh2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f20ec9d-08b8-4b1e-c9df-08def324f16b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:08:32.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nFcTt7H9AWK5ztZlB4E2xOwgxY5cavNJmVE+BDlEZAW7cZL+Klsd8cDFWSQeNFNXoakwB16WeQ1dXVnXKzjjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6144

On Wed Aug 5, 2026 at 3:59 PM BST, Philipp Stanner wrote:
> rcu_barrier() is a frequently used C function which is always safe to be
> called.
>
> Add a safe abstraction for rcu_barrier().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/rcu.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..7031ca5d2473 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -50,3 +50,23 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +/// Wait until all in-flight call_rcu() callbacks complete.

This misses some `` quoting but these can be applied on fixup.

Best,
Gary

> +///
> +/// Note that this primitive does not necessarily wait for an RCU grace =
period
> +/// to complete.  For example, if there are no RCU callbacks queued anyw=
here
> +/// in the system, then rcu_barrier() is within its rights to return
> +/// immediately, without waiting for anything, much less an RCU grace pe=
riod.
> +/// In fact, rcu_barrier() will normally not result in any RCU grace per=
iods
> +/// beyond those that were already destined to be executed.
> +///
> +/// In kernels built with CONFIG_RCU_LAZY=3Dy, this function also hurrie=
s all
> +/// pending lazy RCU callbacks.
> +///
> +/// Note that this is one of the RCU primitives which must not be called=
 in
> +/// atomic context.
> +#[inline]
> +pub fn rcu_barrier() {
> +    // SAFETY: `rcu_barrier()` is always safe to be called. It just migh=
t wait for a grace period.
> +    unsafe { bindings::rcu_barrier() };
> +}


