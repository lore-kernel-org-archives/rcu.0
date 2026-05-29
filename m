Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B863DEAC6;
	Fri, 29 May 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055918; cv=fail; b=G4KhrpYTvFcfpOSYsh5Xze7iSBLQUyaSf8MWotExUdqVT5xnPiUgr8I7hRjcTSiI+16VvoASZEu99ibX5RumNZB6t8tMENcL5qxYsLkZv5og6VkRjLgw2e6LDrMi9tRwyXbMwV//hGTNc94KOqpDsC0TxJx384BCnhAZ99wh+fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055918; c=relaxed/simple;
	bh=V1qOPKOqEkL43cCpQmdFhMK7sGo72U2o2PgCEA36Ork=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=slDMqk00axLuHEVGFnSjb7UBNnDKgbAcygZ471Zwp8nvpWWqkPdwtFAjG+iKEF/i5C5sOO0kmr8SdchVsU1wqpdZpuveomjccpqa8ZsZtiTyPnYDPtHpUINO5201pVafcOdD71V+lkERtcyatWqg9erbc3ZT67XiZzdEY7BY6iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Rxo7A5/o; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Rxo7A5/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW70499GrMG0gKLvEE5Fb9/g5IoaZyfdVjYqWGzRbX/fKXL7CFhMVCP+ymumixL0ICfQ2i5jCDKNWqU9Acumx2OPUsm36vezEgCki5V1sQdcTdBRN0DSuOIpxHIX4C1WwcX6WS3bxm1kCOa552OrjUZ0Yb7RAovzU/m9iWLf+sB8zhr65WOpBN417sllPSRtieJ9O3wKImBb9h931o+j8/Y8kkKAa5Hh61vzDzD071dYmiiZSsrcFfDtDM0LFENW2zBaL5tEYxVLTHZrjZFkkcKwm/d3QSIsAefTN8lWK+zEQxJf10KgYq7tono9wA6fPvwR6GSIqAnY1sNlQ07m0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMRsqgc2Jfr+ZkeAdxi5wJZGxAdTX+keUR/Ifn5AjWc=;
 b=DIqz0OKZnbee/T820Stie7HAqEW5cv3gKj8ZAVCbPWu9LIfKC9PnRPrHnM6PLh+eZ9UnGZzTN9NOwUkvPHnT2HJLZxDQ3Kuvk4Q6OF4+mf/onvJV/fEcLN7/TOGj6g4P31fyJ2JWAdMtlomkTNqMbCZdbiV/xrX/1biw9C5Q3fMYMHP0UU0c8x3Q7g+MVeJCEq10KFuGg+7kVjtwg7fdGvEPDqnNZoctdqgtPhc+tD+3enoLl8CKce8WougkOtPIn6A3PhS7P2MoJywGOqOREnWzhbB8pnIJbfVqQ9n5V7CbGYrbQjvutP8fOttKMdh2MDN3wDaAZp6kTPUVdxH9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMRsqgc2Jfr+ZkeAdxi5wJZGxAdTX+keUR/Ifn5AjWc=;
 b=Rxo7A5/oMV+y7nnjubceON9NUgwTD/eUbfU+7NfWb7tOuxZxNvHdkYMqf2XEcuy7iyoST892Ak5LeaDj303nMLzwme1gBLO0qpdXexn3b3esyF3Ncii8F1O25IP4UnL0AnBVScNQ3KDPNzhWu0lnYbgL9ugfuZ6/GxGblq++i3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2359.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:58:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 11:58:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 12:58:31 +0100
Message-Id: <DIV55OQ2T6MA.2CZ4B7GG9EZ7T@garyguo.net>
Subject: Re: [PATCH v8 2/4] srcu: expose srcu_readers_active()
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <rcu@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
X-Mailer: aerc 0.21.0
References: <20260529114449.112066-1-work@onurozkan.dev>
 <20260529114449.112066-3-work@onurozkan.dev>
In-Reply-To: <20260529114449.112066-3-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2359:EE_
X-MS-Office365-Filtering-Correlation-Id: 280027c0-f15c-41ff-d401-08debd799aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7416014|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1lyF8TzgzOMuv+G7KAqUO8j1V+BIJ8K9MWhLJoha1UCbPjSikbcTKZV6XMiskLlvyiHUd/hfJ7Bo8HFk2YB9UN9SwDsldXq2ocCtOOF4KjBcS+TI2SKbdDZ9e+lhdsN7v15UtZKCdA6cvmffPmlIDy0Y8fbkDvsZ7GBbZw5k6i24BL2IGb/5KRAH2FgJLDySsz3weMKscWmbcsCknrbMmiLvTQXvLgY6ldRbpasegjfKSMDR9eN7A5ncqn/pgRq6LRNn9nDADL8PnFN7KemvX+fs0u+ftDw/AlWEDenzSlvxUkIwHu4ZZxZTzuP91YsCVsjxopEdRogfp3LswDlcuMDlnaGerGNQQEvgCDVl4mp9pCN3h2AkSZxHMHRzcdohtaqVmgyd4iFp+qJYSQ6XuStjh4wQaKIcuPcU9dG+kggNwxJEaTTMPtHKOYnjI07s7CBI88Ojt9mHf57WvqoQA4iMExcZK7nBqwtNmwwkMwex7v6yGg+/Kjomlycyd8DALm/wlsZHaSmttPE9IEtGQFpzDZOjUPzw1+a1lfkU+GvNJLOwe2wXM3P02HhJY9K3yCf3GVsB7sW/2whf8iIaunvYrv4UN0hArBE/SBh/2gbJw+eLpS2LGbSAQ1q0FWI/T4H7gwHr2msgoaYNAsDTM2v+EED4GvNIO0/Tzh2WXn9TWKPO6oSUNaojAZk8FJIA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7416014)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhUalRqODc3enJGR3BKeGI2akNFQTdaODdyNXZLVDFhZk51ZGNuemhxS0Ri?=
 =?utf-8?B?RTRaNHN2S0pxang4OEFpNWJFdW52UTE3eWpFcEgwZWNJc3VORkE2QlZRT3Fn?=
 =?utf-8?B?Q1NqRjVmeGJiNDZIc241MXMvWEpPTUtTQzh6Q2k4TWlvM3hCeW8vUmF4Y0lx?=
 =?utf-8?B?TnFuMDIwckxJb3hZbXcwRzNjb3ZwcVZQcThFVW5NQVdGTHRydGZOQXRPSzM1?=
 =?utf-8?B?a3N1NnRlb3VPY1NzMnhleFdhNjB3SHhpZmtrbXJTRWNqTHk0ZjRvTkpEbDZx?=
 =?utf-8?B?U3dVSGpSSnN5OE9XUHc3TmFhMjI1M3BoeW83c3RTdDNKelNUSHl2WjdsSE5y?=
 =?utf-8?B?US9jK2JHb1pWc1RtbEVOUUtZNktoU1EzK1N1dkk5VHRNRGJsdGx1S3pBTTFW?=
 =?utf-8?B?WU1qVzdTaUZCVmhob0hFY3BONFczWTU0TzUwVVBnY2hoY3dpOVpvY1lyRFh2?=
 =?utf-8?B?QlNDQStsQmFXaVA4c1h3NDhxWklqd1llVWxkaXhtVko0VVlPbEx2blgzR1Ax?=
 =?utf-8?B?cEtxZm1wZ3NiSWdxTmRpRUxLWElnTWFJYy8wb2M2RVdCU2Y2SURYMk9WTVFR?=
 =?utf-8?B?bSt0Nkk4dUlpcHVCUTFXb3J4cVE1TTIzenhjenFxTGc3MGpKV1hOY0pPcFF6?=
 =?utf-8?B?bzh2M0tGVTFDMTgxYTFYR25QekNSYU84SitaZjBwQXVMakkrUmdPdUxVdEJI?=
 =?utf-8?B?dEY2Y2U2Tkxrd2ZSYmtIeVloY3hlUFh2OE01WVNGYWFlR1ltMHJEZnljMGM3?=
 =?utf-8?B?SXoxTFVMR1ZGVVpZY0llcS95UkdodW9JZTE5VjRlTUFYRWZqTnJ3VHFRanFp?=
 =?utf-8?B?c0tGamNrRXZ6UWZmSFVPaW0xemdPQmhaWktoWnpXZVVXMEVqNDlGcW5GTGh3?=
 =?utf-8?B?WFZUQmpBM1JueTVWdzlPLzU2OWhNVUROcnpTMnRrWTBjL0JCU3BvM1A0NmRL?=
 =?utf-8?B?b0F6UE1Ka3MvTGgrNmNER2hhQkdCU1N2WStESXFLTEN4WHU0SXZuNWJVMUdl?=
 =?utf-8?B?ZFVjeWF0Q092MG9mMFArUWxaY0dIa0RSR3NGSEtyVEtQc0pmM21tdElNU0JW?=
 =?utf-8?B?QlZsS28wcnRXS25WaDRPb0VZeGRhcDlSNDAyTU54NXJMbE5ydGowTm5KTFdx?=
 =?utf-8?B?bG9CM0hZeEhRN2gyUUtsbHU5V0FvdXBCeXREdUpTYTRaTXBaYUNxNjA1QkJM?=
 =?utf-8?B?dXh0ajNhVzBIdlhOOEZ5SDlray8waDk0azMxWFg4MU5NRElYNEkzaFdRK0lt?=
 =?utf-8?B?eWduZVh3Uko0YlUzcXpuV2FmSkhtcHREWEpPelpkZXFqd1VYakxINXptQ0Zz?=
 =?utf-8?B?SEQzTWxzM0hMbTlsVHUyUFR4TEkramRYelVEcDhzYThvNk11TERYTHpuN01J?=
 =?utf-8?B?TGxhdmlpNTh6bFJPMDVrU2JoOENWQjlyMDZwaVlIdXljYlV1OTROT0cwc3gx?=
 =?utf-8?B?RmRqdHlJSG1ad2p1b2dBZjBJVS9vd0J4WVNyQmVSYnZJMXZ4T3NjVVNYR0or?=
 =?utf-8?B?MHlJMjNrUGoralVGRmZYUEhCeWhGVmh5cVhsOGpSUFNGREI4RDhZM3lqNEI2?=
 =?utf-8?B?ckxHYk9adDAvMDRzNUZidW1xMUYvY210OWR0Y3A3SVBBa01ET1lQZTYvWU1k?=
 =?utf-8?B?V1I0eXpYaG1sKy9sdzF0TzJ1VjJvdysxWVl4VVg3VjVpVlZwVzhqYzNGRVl1?=
 =?utf-8?B?N0U0YjRHUCtQZWEyazlwOWtLUVRuS2RQT0VGcDU5RW5UZms1VHNzY0ZlSHFM?=
 =?utf-8?B?Q29ZZ1Mzb2RRdk1UWXdDN29VN0hMek16VEM5QlprRTNkbUh2UkJkRmtzMzFW?=
 =?utf-8?B?KzlwcUc4YkFRckNCa3IrcERScmFtaldyNlBCVDJvbHhnc0VXTDRESDN6YmVW?=
 =?utf-8?B?Tmo1bFVONDBCK0VWK0dyNjM5VlRIaG5UOVVmUFhtdi9Wb1JKYVQxV1VhbWVU?=
 =?utf-8?B?T2VTODk4UGpjeVhVbGNqSDBPUFhKYktlNERsM0RsWmhKbllOUmlUMEpZcDk5?=
 =?utf-8?B?U01DSjZrOWo5SDc0T3BpTmhBMUp1NmJyWHUwOEdyNVhMNUlrOGlIako5ck5z?=
 =?utf-8?B?VGMvVVJCZ25YN3ZNYy9aZ0RXWDVSWnZRZ20wOHVyZVpEdUIwZkNIbzFEeTRN?=
 =?utf-8?B?RE9PTU1uM0YxSzRkSGNzVzFxRUFwWXd4L0JtbE1PaGhabThwM3FBU0l2dnc3?=
 =?utf-8?B?aXVpcjF1cU5pMlMvcmlNL0VzdW1FemVib1BTRnJ6a2l3ZFBXNmJnOG55VkZN?=
 =?utf-8?B?Nmc1NkhNYWFBZndacnFWOEwvQnIvQlpoZ2hKM2IvUHdPdzB1OXAwNDlPTGFV?=
 =?utf-8?B?YXdNTWtqSWovemNPd2RyVlgra1BQN0NtaG95cTg5a24rb1RkMVQ1UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 280027c0-f15c-41ff-d401-08debd799aee
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:58:32.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMbqfnMVmDVC/ThXN5BhLISxivKQSfTy6L7lvDrCIbby7jbn4MH7MHW2nUKKhSvtHEGz+GSPQgjocXRHghiNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2359

On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:
> This is needed by rust/helpers/srcu.c which now adds
> rust_helper_srcu_readers_active() as a wrapper around the SRCU helper
> for Rust callers.
>=20
> To achive this:
>=20
> 1- Move the srcu_readers_active() implementation from
>    "kernel/rcu/srcutree.c" to "include/linux/srcutree.h".
>=20
> 2- Implement a matching srcu_readers_active() in
>    "include/linux/srcutiny.h" and use it on the existing open-coded
>    WARN_ON() check in cleanup_srcu_struct().
>=20
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  include/linux/srcutiny.h | 13 +++++++++++++
>  include/linux/srcutree.h | 24 ++++++++++++++++++++++++
>  kernel/rcu/srcutiny.c    |  2 +-
>  kernel/rcu/srcutree.c    | 25 -------------------------
>  rust/helpers/srcu.c      |  5 +++++
>  5 files changed, 43 insertions(+), 26 deletions(-)

