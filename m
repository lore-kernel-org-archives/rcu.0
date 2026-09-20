Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021092.outbound.protection.outlook.com [52.101.95.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD52BDC0F;
	Sun, 20 Sep 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919866; cv=fail; b=PUxIYsngiAnISjALMjE9FTx8S232HGUdOuhBVjOlBTUt/ASIb5m1c1yk61J5vyyAOvWHf6kytipDR+o48scKD6DjpiUKHN5596GagW8U1R6shZjJJsBMOFucsiQj80AXFspWyWz0t5657wJ4VhgZ38n4Dx/Nk1ZcwMycvDE/tXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919866; c=relaxed/simple;
	bh=vqC5oYyTNgIW+WKHAg5iBtq3HF/94lrEvbNL7k9JFiI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Z8Zdo5ahj/NPfM2DY5udSg+KLHon7Uo5dEuQZV3dY4AMr5+pVuehhFItiSMlrlbx8IbQbXFDgSrMy/yDp88R2oPY7k9G0BM2NSFYRrk1F599hiOWcoQyg3oEU+2bUItHNgdVplPzw0CooYpwO4d3z+o7FmmZNuWA8T9Rvcbc7RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sesO1D7N; arc=fail smtp.client-ip=52.101.95.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sesO1D7N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFi7wLc/p4hNXTApQtQGb6Z4PxWG2ted3TcKF5ldsdfaU3eGGbRbMkmHSqlca+ug9cBN4UezojRRLmca9exP/5LEJwbPiy3rfT4Em9P0g6ufIKgN1EWi7mrn0/x2WQFKllrzVN7Xj5fECgyJG1I3O38s7i5zubr+GJFubQ0N8u1VD7kS2V/PpWb0sA7GwSjkpocn8gbkcwjIGGUDX8BxQFlP/NfbLVcGT2fsXkdmxQ63FRh54J5IanGM1tXR2832MEwhJYIFMkIxucmKsKut40316CsJ1ygNvuAUOOwRBUVVSsoIBFENJoccLL8j+bHvVJSOZSIfoNLfHFGhVfmrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqC5oYyTNgIW+WKHAg5iBtq3HF/94lrEvbNL7k9JFiI=;
 b=aubKa7JTWARrfaXM6y5EB6k4ERHNTuEcBJeZwZi1dzWDRaWTbR/M1Y7dK0gliZGD+/ffBn2r5PUrSGysqCotYp0f7kbyUBPF/YoO0yJyFTYM1mvCMVE6/+eZhZCLTPOM7UkkZCbmNV8UopJjA95J+8peEvJGRRbcQcyrUo5z9FCp6I4EfIDfUw3XnRa39/tuJf3D/diI8BTEI7gm2D15ir4/MyKftAodoT+lQdZgivxccxJbuZ2F578hl4fW0EXj5toiw2F0PfGf43nepN6ohMo4FXP4TQwv4/HLtlezK+IgD+IntjCciJxW9zCYEFolXlySwkbikE+0s3u11CeIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqC5oYyTNgIW+WKHAg5iBtq3HF/94lrEvbNL7k9JFiI=;
 b=sesO1D7Nb2bX74lpU76SlMV08w6cZsywDPBGAEjAdP7vc4qfKXLsj0eR7RNbNPpu593ABfA1gWxqVrOEeCUaqCZgVzekjOiqWP40LBAYjek4XY1RXEvMaaBLIYoHPNB3RjX+iC8P4P7aGxyBnhb8/kkdQfaSh162h+MC7garWUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CW1P265MB7573.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:57:40 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 15:57:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 16:57:40 +0100
Message-Id: <DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Gary Guo"
 <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <kernel-team@meta.com>, "Boqun Feng" <boqun@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <lkmm@lists.linux.dev>, "Zqiang"
 <qiang.zhang@linux.dev>, "Wang Lian" <lianux.mm@gmail.com>, "Kunwu Chan"
 <kunwu.chan@gmail.com>, "Bradley Morgan" <brads@mainlining.org>, "Bradley
 Morgan" <include@grrlz.net>
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
 <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
In-Reply-To: <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
X-ClientProxiedBy: LO4P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::20) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CW1P265MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f9d6ac-68b4-4dc3-ac14-08df172fe667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ovy/Zs3a8yuepaoZpTnL3JSXTjFNkq9W+pPB8MWEV+151O9W0h5iA0Mx8J9FJv6poMkLBw7jSDJ8+AyQJfgGI4KgDTcOS46otOQ87CZYWeJAINeKxTaGVmOS/9HA5eTxyeKYXtPZ+Jm5ww8RTk0MFdQLevxHRAId0yQgNVo24xRx/Fq1OouIvrvXbahL/RTEOD6mDU+i5ObksDSedczG2lAkRGRo8xM8uMlsqR6w6L4iHPP8J8hLjR0kubBJG7NYwjmW8Vci/CVHO7wof/2eiUGlUwIx8a8Fhck3j8jVqlKf8sVBKVS+8saGcV6Lz67JKk0elr2REY/fX04HOohMVbMwWCc4n/WLz1nfyaK6vU+fC313iyUWvk8z+1MafjtIDyz40sAd4ON4laIbQT0259FCwF+mCWrFWEYUYnVO4iC2CazeBDrtT0g7qXJ0uuCML9tj8x8GGm738FdE44yukFJQCMoHv0pMea7Yye5lghEO1nTT35diPRK4pfTbxj7fozoz94WwkqROAEDMZnYa8ZQFmv00vuvK6tjtzmCmHY7as+E3ZTNuN4Cc/zUd0t7kmuZjLHx729FCLRLYp3RIFdEovCcelBGt7EIxBfILVXyLgsNJyQ0Sq9N78Yt8dG0sYbiVIfvmuaHMq3/jdigtkv07KAdT8uFpZ6EAPBiruls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhLZXk1SkxlUnI1L0xzeUJyUXNwUGY0MkZwRHNsNUhwN09LVXdxS3Y1SzJG?=
 =?utf-8?B?N1hIY0ZlNFRHTFpzQmk4RFRVeVZoTWpFc2Y4RU5idG56UVZ5THlUczVVQjdR?=
 =?utf-8?B?ZUphREp2ZVZKVHpRVWxKb3RYbmlGQ1E2UlBucm05a0RlazhxSEpzN1d6WlYz?=
 =?utf-8?B?Um5BSFBQM21KY1BxS2JoMlFaZTkxby91NlNvRHA0YVVqWkVUcWZ0eU1WYmZB?=
 =?utf-8?B?Z2F5RVR3d1lReTRJOEZQSDR0b0FVWWgwbEFxSk40d2dWYXM3N2cycDRBWGNL?=
 =?utf-8?B?ZTZaRVN6bUZ5NUM4Z2ZtRGp2NE04Q3RUb1F3b2xqZUc1N0VydUpKYTJ4ZmFK?=
 =?utf-8?B?NG9xMVo3MFV0RXFNQzlwYk5DWm5jaUlkQ3o4L1gxa1NwWkkrc0IyL3R4NHo2?=
 =?utf-8?B?U1drY0VubXI2WiswcGRZeEM3RnFCUER4eGF3WEMrWFZHQ2svNmp2bkNLMTBj?=
 =?utf-8?B?L21nL3I5Z21BK0d1RGg5QnRjbkZvTUFOZGFsb09lc1ZMQm9LYjRGQm5BZEFp?=
 =?utf-8?B?aXNxMzdXTXJvamEzSE1IY0MyblNkVklGNTFKR2g2Z2V5Wkszalp2YWFlc3Fq?=
 =?utf-8?B?Zm1YSU1kWjF5c0FkK3EyN3Y5YThsWDQ2dUR0NVBaazJUaHNlcHlKZU9wRTMx?=
 =?utf-8?B?a28zU2FyQVFaMGVwNDZhcXZKenh6M1I3QkVSSGZHMm9UYkhWT0M5YmkzMzMx?=
 =?utf-8?B?bWcwUGNmYWN5OWdXdStOZUplUklPbnRNK2dveUI4R214TVdIdDdVRFJ2d1Ix?=
 =?utf-8?B?ZHRBM1RDQzNMVkRvYkx2bGVKcmRsN3ZjV3RUbEhWRlg2MkozWTJjbXR1dEs2?=
 =?utf-8?B?YThQZGlWWUpYUzRQTlRSRldxQVpWS3FDSWNYOXF4bFRQeUxRWHFiQzA3cmxI?=
 =?utf-8?B?eEpmWmwxOFNwcXJXVlV4T1o5UktuOSs5SXJTUjlnQlNFL2Q2ZjlJUzcwck1j?=
 =?utf-8?B?RWVHOUxLYk8xY1dEOUptVXMvUUJmRTNGbWxUNyt2TlYyK2srTGdlMjN5MTR3?=
 =?utf-8?B?SnJKTzFicHNOZS8rZVJxSTJYVjhOQmhERyswRGFpUlNEdGYzaGdPek56Sk5T?=
 =?utf-8?B?bDJsRUp6aUY3cThBQWw5Z3FkWjNIaGNIU1plU000aTlRRU1ZU1R3ZmRNeVBP?=
 =?utf-8?B?UHhKMDg2V3FlZ2IzdmxhVXNZVnlmZGQ4OTltTVlxcmFYcDlmQUd6c1p1T3h3?=
 =?utf-8?B?aXlqMkpXbEt5SHUrbkR6a01zR2pWc1FzUHNVNytNbFpYd2pBUkdQZHlWWnMz?=
 =?utf-8?B?THhtOWdWR202ckV2NnZ0MzY0UU83aVFheHN3dTVTUE5kSmlLYkRnSHdoMm1n?=
 =?utf-8?B?QWdTbmNGamFjMktia3dTN3Zjbk1QdDJoQjFZNVdrenRHRHgzMlpsWWZ3ajhl?=
 =?utf-8?B?aDlKdnMwbnRHd1FRcFRvVFJGcUkxQ2xWSkRrL2RNVTF0ZnpFUkFURklSVHRV?=
 =?utf-8?B?ektNWG9TeWJJclh0cmVWaVU4dExRc0FNazRDSHc4bkY4aXgwNEIzNWp4NUpB?=
 =?utf-8?B?UW5FNUlPcXF3aHVEeHNMd09yL1RKaTc3aUwvdkRsS1J6YlJIUXVGMVNKT001?=
 =?utf-8?B?YWV3MDI4MFVYb2tjS3p6QzVXdUpYUndWVS9Qc0tkMXhxdUhIbzNpOTJ4ZUVQ?=
 =?utf-8?B?MEZpdkpUSEpJVklTZDRhcWgwSG9UL1Q0Z1NkN1RJdWcyZ2Y1R3RRODZQckhx?=
 =?utf-8?B?MXdCWGI2MHJ3Z1hkcjh1TUp2ek84TEFmY0FhYXFUNTlERXJKNDF0RXYzdFNv?=
 =?utf-8?B?b1RmemV1VkJWZUVEV2ZMZHRJMFM3ai9qSjA1RUhUb05tZEJzcUZDVzJLVE9W?=
 =?utf-8?B?Z1pxUVNhZytHYlJ1YUY0QVhtUzhwY3N6UkxDKzU5QUpqYW1GQlBhcHdrMFRF?=
 =?utf-8?B?Um9jTHArUGIrL3prSGF6T20xQlJ5K01IR2tvRVhmTkNyd0tRbWlaRnVSWmtn?=
 =?utf-8?B?eHk2Z1llNTI0K1NhUXdkZVgybjg5ckJDbm8wVDQ0MVp3TnFZQ3JBNyt3Vk9Y?=
 =?utf-8?B?REF5TkpaU3NyVjNnRE9HcGxucDBxMFBuY0RRa2NQSE55MDZuTWNDeEpUaC8z?=
 =?utf-8?B?aWtZalEvYTlBNjNCMEpvdGVaZkk2bWk4Q2d2a0pYTVZQLzJ5NnFYVEhIRi9T?=
 =?utf-8?B?Z0phNWlraE9Va2J3bXdJR1RsU1VyYUZ4Nm9UYUYxT25jd0kxL3ZhQkQ2MWdk?=
 =?utf-8?B?bXhXQUorL1FQZjRLMG5wOU9IWkFaL1dMSzlqdG5qRHRXaHVZV0ZTNE5jNTV6?=
 =?utf-8?B?TUY3VGp6SzI4VW1tWE1nSnFEaTB1OHZDL1FLSmJwUUlKZ3hoZGZQSElMejAv?=
 =?utf-8?B?N2pZUHFGT0dEWks0WHhuSytKWW1aei9HRDNEUjRPSVR5TzdNaXRnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9d6ac-68b4-4dc3-ac14-08df172fe667
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:57:40.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F596VerL1wcJTZDo+g+Tp+N5ZTYL/IkaXOqi7gwucOohyWa95TFxcM17iRGZnjei0akR0ubkqYFdAfb7NVYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7573

On Sun Sep 20, 2026 at 4:44 PM BST, Mathieu Desnoyers wrote:
> On 2026-09-20 10:46, Gary Guo wrote:
>> On Sat Sep 19, 2026 at 1:00 AM BST, Paul E. McKenney wrote:
>>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>
>>> Implement a two-phase wildcard scan to guarantee forward progress of
>>> synchronize_hazptr() even if there is a steady stream of ill-timed
>>> readers which populate wildcards into per-CPU slots.
>>=20
>> Hmm, I am not sure that I understand the problem here. The per-CPU slot =
is
>> scanned only once per CPU, and patch 1 already introduces flipping of th=
e
>> overflow list. What prevents the forward progress?
>
> A steady stream of readers acquiring and releasing various hazard
> pointers happening concurrently with the percpu slots checks, being
> unlucky enough that each of the slot is constantly in a "wildcard"
> state, thus preventing forward progress of the synchronize, just with
> a steady stream of individually time-bound readers.

Oh, so the issue is that we cannot progress over a single slot, because wit=
h
ill-timing a new iteration of the inner loop of "smp_cond_load_acquire" cou=
ld
see a new reader while waiting for the slot to be released?

So, in essence, the flipping is used to prevent ABA problem on percpu slots=
?

>
>>=20
>> I think having a shared global read by all CPUs sounds really undesirabl=
e,
>> especially that it gets flipped for each hazptr_synchronize -- this mean=
s that
>> in the pathological case where there are a steady stream of hazptr_synch=
ronize
>> calls, each fast-path hazptr_acquire will have a cache miss reading
>> hazptr_wildcard.
>
> There is a straightforward optimization we can do if this happen to
> cause performance issues: only do the flip when the synchronize
> encounters a wildcard retry delay beyond a specified threshold.
> So we ensure synchronize observe the absence of both wildcard
> values in each cpu slots, and only flip the current wildcard on retry
> delay.

Another option would be avoid using WILDCARD if possible. IIRC the wildcard=
 is
used to ensure forward progress on the reader side, so it avoids the possib=
ility
of READ_ONCE(*addr_p) changing before and after protecting.

One option would be to first use the typical hazard pointer impl that read =
the
pointer twice, and when that fails, use the wildcard protection. This would=
 mean
that in the common case where the hazptr_acquire does not race with a point=
er
update, the WILDCARD protection is not used at all.

Best,
Gary

>
> This would prevent the common "frequent" synchronize case you
> mention from causing cache misses on the read-side.
>
> But I preferred to keep it simple and wait until we hit this
> level of synchronize call throughput until adding that extra
> complexity.
>
> Thanks,
>
> Mathieu

