Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021141.outbound.protection.outlook.com [52.101.95.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587773C8724;
	Tue,  6 Oct 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273691; cv=fail; b=RJ+AiTc59bHXPd34CMmUh8MPYQVvJQJimj/C891fuzeQtPfidrT96MzYiWH0TopZTjIed+UE08JNwuoH5BPq9g0qLujMbJv95GpPfJFluXfRl9NGgog7BM0fqOY0BzRnyr9RBlV2PIlkseUWGUUMSO8nFg9hs9gISJ4tyzCqQtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273691; c=relaxed/simple;
	bh=k0J6vSnbHVUseq3sVwyfiraBmrAgFFShWudOG0R7J68=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=papIPX8uSB5VpooGZLZ/ZTnEDt7shGsOE6hIRjC+XhzMKP1qJZt2JLGmgxtJZvU6yPmTLzv5Fv8pZLzWSW8sC087ERmqOdKNHr0yQXGi8L2gyif2edabaeyazlt/YPI9FeuaHvKvo33dwu6Z9/dXlJMnlqfyk1MjIGBP+STSPQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=e+NQMuX2; arc=fail smtp.client-ip=52.101.95.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="e+NQMuX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hApbEdJg/Uv3oDWIPdkXeJdpN7DIWiDXViWNjCmIkV8LNIA9CSlteTaGZkXUzrGzsz+0WowakAszrL5kkcftNP5q1ifG+unNDvrZCsBA3s8EjT9V8vDca/vd8AR5iJHqXWcYw3xD/w2ap+rLsMT9n9bgrX9jA8fTzwDsZQw2ZfetouVg1C1LnwWXLGdXNGJYeSC0dKhcNdLdJEXlkKEgcVs1LCoOxxa7xZzfNYRobW+LtxRP/fNRevw61hMw6Bw6O2pc/JyN/9G5igEgDDXC5S6mGrtHngf3IrDb7OLsBsrfaHcoHYZ5ooTg7KifCfp8wIul7gxaZ+mJTTFfEyW4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE9HxxPNYs75AN+DUINh3qATOrRVbQSnM1h+y0N25Io=;
 b=u99E7tIftEj1icIJDbjod9ictQATULpR5fiH9NPw7ohCWa5exnfS4M0ff1avuwPMXm0GpcmCgl8WJktCS7UrEA29lUhXMHIvYBiJhSAgZeP96w7dgOZ62SSUjIeRriNpPQS3+wNW5JXUL0smB2DLVRIga/JoOiE/vLmvq15qdu3iFMegg8BoMZqBzusAxoobXAhmXuTZmYfyeKxyVhh5TiFmmAibxtlgNz3oMAqmuiCCtBOYHhxqAM4qo0flD6jcIoho7jdPfmxZ5nV8gIZEHsCRCNnlIwZLSg23wzi/IO/UJEDEtdjbFjP6VF1GFSCrF6oaNpwYU/LH8eOL9fmBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE9HxxPNYs75AN+DUINh3qATOrRVbQSnM1h+y0N25Io=;
 b=e+NQMuX2YLquQDZ8W3SvK1CeEhcTxRNYLXYMywMbsKKyCmxh9MleNOz573hSJCnCvXq4JC+NjFHJ6GsQPa48IZYmkUFsCdarlcD5z1XlxeLoR4+AKx43t2Lz4egRwFmLDAZehgMFnLdFJ14ZUPgHwR4KhYhZ6vyxSPtyRohEriI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB1799.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 08:01:25 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:01:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 10:01:23 +0200
Message-Id: <DLXLIXXAPVD3.1XAPJZQAQGE7G@garyguo.net>
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
From: "Gary Guo" <gary@garyguo.net>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Paul E .
 McKenney" <paulmck@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Bradley Morgan" <brads@mainlining.org>, "Gary Guo" <gary@garyguo.net>,
 <rcu@vger.kernel.org>, <lkmm@lists.linux.dev>
X-Mailer: aerc 0.22.0
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: VI1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::36) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB1799:EE_
X-MS-Office365-Filtering-Correlation-Id: e82351a0-578a-42b1-86b8-08df23800462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cqMusLkleccOUYjV5jy/gMEAxIf7T+vvLIJwyPiuUgb1kN1DRJnfcI63iZbaZiwjIa+/EUYQzV1rgylxOzqYMm+y09LDRtFLwSPGAFJMwbfF6dJAzVzb8ekme3J2cR5D5FBjUArGKxBLA/MSHsgc91HS9b9ubTQKxdTnSdsnMRQeGT9CbGTTgcpr7C9Ewc274imDDTxjbwSL9tIwc85Pa/BKo10YeJkf3vuhlIxog6w9ZwULxwvbxJq2KTIBon95AxOmnaY9hMPXBBt2yIWA9BK5ZS5u4gaOMYGKPXzy/0g1/Y1UZvXvcaxFMEzUk36YRFvXO2Crby5+vT7RRQAPUUijJMMBScrSGbVpjgTC+ptRbfqNT4POd9sywekIRv6+6UTn+7UR5EVJgIiHxCPKTvch820oTdeP4SWQ8obci7GzVpLqWD3T3CEy9mmJv34xjSt7o0pFf0tB8ejvUUTTMKEMazFBVKHg7RjOlhQbb3Ley+U922v52JM5jDTKgd2N4Govr0ovOAnIDbT7kb9C/MgF0qqkNlu0nb+dzZwtcmLqTgyUejL0RZ3xSC0GW23C6oNtxyRN+WHp2+/kqAuz24XxEmGckeZzOYXCtD9+mSZzuOi1HodFA7mWO+S1McI1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpXRnpyaU44UGIrNEtadGF4bU0vblhtS2lXMWpPS1hrNFZrSllmRmdhSHQ4?=
 =?utf-8?B?c0E1RldRNnJsQktwejAvSElWTnRvQnJBREoydE0zVVNiRkVvSXVCMHFLd296?=
 =?utf-8?B?NDBoSkVpNXdaWTJDSVFlSTdObFdmMURoYXV1VTRsZVh1RDdIQk5YNi94TVdo?=
 =?utf-8?B?L1I4ZVpSckpXZTVudXF4c3dkekpCeTA0UW5iWWRYR3JDb1k1dGh0TFozcnoy?=
 =?utf-8?B?SVBsNGM0d2M3VnlMaHZtWHVXWUc3Nk43V1lQZHJxMVBqcStoYjNEMnpwRTJr?=
 =?utf-8?B?czhEWFFMZElQYWNlS1VmMkdWQ242L2ZkUGtGeE4weXlTWE9LMFB6WWVCTmtO?=
 =?utf-8?B?aU9JUC9hNVF4RThYNTlkQysxaWovMElvOUlpSzJ0c0JDb2dxL3U3eEVYQTBL?=
 =?utf-8?B?QWtNNzZLSVFXMk5YcStrdDk1ei91S1NGa0VnM01yQVMxZnFOTXNlejQzM2VG?=
 =?utf-8?B?V3ROdGFzdE54bE9qTlZEamRVQklHUC9aWktGbUlJL0VQaU03R1N1SExwZEFm?=
 =?utf-8?B?ejhwaVNveU0yWnZUVTJ4UDJ6bHlTSFpMVkdSbFlvVE9Vc01EY0k0bGxTdkJT?=
 =?utf-8?B?VWVjeGFpRDlDTzFmeWhMTlcxaUh0cHJwUWRNLzZNeTY1WktYcWtwUHNpeXZB?=
 =?utf-8?B?cXVncnhiV3JodzVKNGdmdmRMSTZwYTE3RWJDL0twRlc4M1EyWis4RzhONm9u?=
 =?utf-8?B?UkkyNDZkNHhyVjNwSXQwRmpJcmR0a2JwN2pTU2d3Q2EzSmwyRTRaOGVpY1hJ?=
 =?utf-8?B?ak4zUy9FeFYyU0xJTXo5bnl5UW9VbzFZUGh4TUE0eGFEQlp5YlpTUUVZdERF?=
 =?utf-8?B?Y1hJcjNycWo5bDZpNmg5V2lWUllKb2pDaFpHVm1KSWkwc2wrZHhEcmFEdDB0?=
 =?utf-8?B?UnNtS2l5OHYzQlhZZVZ2bG9BdSt5MWN2VlVWU0J0cHhsWXMrM05NakhxTHkv?=
 =?utf-8?B?WXpBWVpmVnNnUVJreU1acXlYczNiTlA0TnczdnpJOXVJbkY1ZGZZQjBPcjNL?=
 =?utf-8?B?VHozSnAxMjRUQ0NEMWdYS3NXR1FEcDcxa1I1ZTM3TU5OTjkvR0tIT1htWm4r?=
 =?utf-8?B?NWZBYVMxWnhPcm92ZGNkZzNyd2l1dUxEUnIzcUlGcm9qUjZJVHNTWXJDSG1w?=
 =?utf-8?B?NlViWkl3dDc3NkR3cUJDanh5bWx4azM2QzlSQ2dBdmlza3dJd1JrUGVCNVR0?=
 =?utf-8?B?SFo0c2N6emtGWnlNMFdOTjlvNW5OSXJTT3B6TTNBKzVGY3pQNW11OVNZa3pn?=
 =?utf-8?B?K1BEek85U3BtS21YK3lvanh0MFM3eUF5NGxTYkZyRS9QeHZpbW9va1h5RVIy?=
 =?utf-8?B?b0VtRS9La2dOSXdVQm5mVkJ5Q05DdTBMZXEyYmJndXp5QTFVZ2NQYjJRVzhu?=
 =?utf-8?B?TjV5a24vRDlMWHUxOTFodDlSN2QxRWhjN05yWFRNWTlXRWlBMU1Sd0FnYmoy?=
 =?utf-8?B?VVhoVVdaZWI0MVVtVnYxU3BYOGVoSEtDdzdOQjl5V2NRdmpqY051NkpGMSsx?=
 =?utf-8?B?THpyWDBrNCtlN1dYQ2FJSE9qOFhWTUxwMVovY2lTWVlqOENiMnNtZ3VveW4w?=
 =?utf-8?B?bGxsR1U1ZG05RmN0RnFpNm9jR1ZLOUxDU0kzKzNLcDJvRGNwQmlpR08vOFo1?=
 =?utf-8?B?SzNXZG83dWx2MGovbDQxandSMHdvK3FmbWFIM1ZVVW9tWmxPb0VGaitsZjVE?=
 =?utf-8?B?VHRyUmt4WVhSZEs3UFVmVW8zYWNvWitQL0RqOHVPMzZqRVZnUHRva08ra2tv?=
 =?utf-8?B?MWxpN0FSQ3Nha05HcC9wdFIyRWRTcWJIcE5wK1RiRW04aDNGbUNuSmhLWnJN?=
 =?utf-8?B?b0p2ekNMZUpsVXpWQ1JsdFZPUzA0dzJSZXprcFQ0OEdmRFR6bXdqK1FPbUQx?=
 =?utf-8?B?ZUVaWWhhbjd6WCt2NHpZa1FnTlB4M1I2bUx1cW9SU0ZTbUhZdXZGakRWb01W?=
 =?utf-8?B?QTN1T1JOcGZZTlJRcTh5QSt3M1hmTXBRMStQS3MzNTJ3VlB5a1R2MmVZRVZP?=
 =?utf-8?B?c3BWckVpdHpuRlZQS2NxOEQvOXBIOGhBSExQMS9DWWpxZ05sOURkOE5EaHFJ?=
 =?utf-8?B?TnJTYklLR1dFWmpJYWNTUndKbm9TaVRpKzlPd0UraUlsQXExamJTcHQxTXd0?=
 =?utf-8?B?bFZOVzhKU0wySWxMRjh4NUpSK0JTbkVPYTFkejRJaFJHeGlTQnh4ZHI0RXdM?=
 =?utf-8?B?dDhWQlNMWmhKdVFaaGxNNkpHTDYzclJtTTJnTmYwOUtkVFhDaGpqZWJ0Sk94?=
 =?utf-8?B?cDRKZUg5L3hTTlhyaDdmdk5IZkdxWHM1ZHdJQ2NFMGZrVXVGVVdGcTQ4UDZL?=
 =?utf-8?Q?8gPXSv1u/oUMnOw6rf?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e82351a0-578a-42b1-86b8-08df23800462
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:01:24.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdrZPT/i8nN4bptm3U0uzsoWUDRBlEQfdravZr6WRslnSLQrNHECRVaoB8qiY4tUCggkeJ861Ih01uVS4hKUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1799

On Sun Sep 27, 2026 at 5:51 PM CEST, Mathieu Desnoyers wrote:
> Introduce a "try acquire" hazard pointer fast path, which performs an
> early load of the address to store it into the hazard pointer slot, and
> then re-loads that address after a barrier to check whether it has
> changed meanwhile.
>
> On comparison failure, rather than re-try, guarantee forward progress by
> falling back to the __hazptr_acquire slow path on failure.
>
> The acquire slow path attempts a try-acquire for any available per-CPU
> slot. If that fails, it chains the backup slot into the overflow list,
> therefore guaranteeing forward progress for both hazard pointer
> read-side and synchronize:
>
> - Readers set the wildcard, and then proceed to set the more
>   specific address to replace the wildcard.
>
> - One synchronize alternates between two overflow list periods,
>   scanning each one while readers are added to the other period,
>   thus preventing a steady flow of readers from preventing
>   synchronize forward progress.
>
> With this change, the scan on per-CPU slots don't need to expect a
> wildcard anymore, because none can be produced by readers. Wildcards are
> only expected within overflow lists.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net/
Reviewed-by: Gary Guo <gary@garyguo.net>

> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> ---
>  include/linux/hazptr.h |  47 +++++++++++--------
>  kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
>  2 files changed, 76 insertions(+), 74 deletions(-)

