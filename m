Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020113.outbound.protection.outlook.com [52.101.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF303CAE80;
	Sun, 27 Sep 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548746; cv=fail; b=VRwicndJfCYarcvyHkUTVZjdt9fL9XxpB0WDWJWDY7Bo3KxwrA0PlkYHMGnI8qnD18zE2YsnAKk0IlM/4hi7Ko7L08pkI+d5bO10meyoaAR8NojJLv7ePOcolRqX8rR7SoiN0DQlaFFxZZeWIqDg3hYiimIPLPXg7MTK12HYslg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548746; c=relaxed/simple;
	bh=3YV2IhT4I5W5MVHJCpyEONh+UBROLraX0BFj7k1z7uw=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=gYK9+Q/1psvqBzN6gzm7xsBRYiufWi7rc5BUNAtsKdztFwOx5bSt7sAA1q33dPPkzhRk3inHRi8aBul7C8Ma7IXTv/vUi4fD2TXpWvtT6KBi2eA8fLF1PwDjecHz/prVgHixfQHZozg75Z58YNDQsGlI3cQQep0h9EvVQUe5yVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sh7hz0EJ; arc=fail smtp.client-ip=52.101.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sh7hz0EJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syeZhoXXSXULMJVk9WE0IXs9pRMSKSSnOiY7YBbSmLb6pr/QSFzw+GhyEbQcLc9G+hsJNkBgkNCfboUaxEbkMRfUp2KCFvMz9+lH/zxCsxKNOr2n7KaTUYJQq2B/Pll0i2BuZF9TugtMgU7OxLMJd0U3vbf20W/YJW8jw1rT/ApS3qIdLrl1g/9M1VyaREY6iPik8D3BODjLeB5wGhwpfMe7qodpjymjk1VkyuHceFwJkHXNuULpJUoUUAw+rnQCjTrUKlSOZeO60PHAnNLrNo9f4aGwSCickwCwJ9HaySXQV9Sv2yl+d23RZA5DT0G2GKuWKeEkST3SjwUCMDwGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVsrDW+NyBH5ZRfp++rZrTHxYCdSysr+c2oVvOR2UTU=;
 b=bskyVbc9C3JU/ybfNbYaol7tW0JP+9a+O+sYP+IzD3qXkB26G9hXyY9IY9ZjBH2n2nXifmui73iwdY5x520zhsNQixak32Irw6qntAdPH8JlEBnx8Ehbm1ykKP5jPPZGalIbNWZG3tPP+ZjDdcXaGLkGrsaZaA7nTG5NgKtran28XX/3Pu4uai/0xapgBRg0Yh2tIaNEkIjS7laQW6XUKAeZoP0zkjJ0p3ufMvijDxQjPiAZjMllNIhZpi0z3XMR0isj0+j3SbbjYMh5iap3e5zxkwnd2Hr+2pqBEYtKSaFIhu4Yyzc1NfoWVGOwxhiMecy3EoeWeO6ZfLIyTMPTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVsrDW+NyBH5ZRfp++rZrTHxYCdSysr+c2oVvOR2UTU=;
 b=sh7hz0EJSk0ENDK7m5RiG+iD+t06526wWX3hKA0+jBVukijmNlKZ0l3c0FODoe1TNFaXWOy0/5Z3sExBDZrGOIJmrcAIEsIooA85KUgfTrvaDM9CMvBci/XhV4erM/u0oOsVEUY7wQ9gnDhk5pRjvqXDeBTV84qqi7lyWa91nRE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6132.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 22:39:00 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 22:39:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 23:39:00 +0100
Message-Id: <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Boqun Feng"
 <boqun@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Bradley Morgan" <brads@mainlining.org>,
 "Gary Guo" <gary@garyguo.net>, <rcu@vger.kernel.org>,
 <lkmm@lists.linux.dev>
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
X-Mailer: aerc 0.22.0
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
In-Reply-To: <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 22954e15-b2d4-42d1-5ab0-08df1ce82019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZnouelCz1Zz/zJaeSA9VQEwJ0N4Fd6fOzVyZKzzVaoQCZIT3mZ7hqU8IK79lltlCrJf/zfSvOWf1vkoTnm9u5yXg33v9sknjinVxRyAjsUkDarm2YUPYBlekGmqJipgtvLIcc58rTQhVZUozjoGEklETzRKa1No9jzDaf6WgilPBVqKLEfhqEzs8A4HxrgQH1lnr8uvRdbx/ZjHjSjN496rAejlx0SDc/6pYzsNizilWUarhWTukd1sHEBqsx1me6PivziSzB4QLM/UYAgzjTEogh6P8aA7xoxhhW5/SnErB/JBZLaukUesPu2h/mR5PVbjmXEl7wqplRIplQnXMMZgOKqoqwmWdyoqfaioz0Lxly5DUKfuBJxsP/QccauYFSoEqVrRXiIwFSnpvP+Xv0tJHjFEm9HRhcaxry6CsrFUvK/HobQuXpjhjKmeDyXFEOcmtTMty+yEovc76fnx83UHskJzte/rZtyqw99u/8+3FAUTodvfIfGrbsZNGQtCqtCW1GsdqpmOadbjCTjHV7eBnkdSwjmfVjv4ST4y7KhN5L2/bgyKKMX7bSX4r6Cmb7n0W2pPlTJ8n10NRTDWSXbTUixHzIpNUQ3yQZoGssZwXJipwz1XFKMIMfa9wmN59
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU0rLy9ZSXBEaXNqQWFZVSs4azFJaHBZM2w0NTNGRWVJMFlFb2FiQUpPdGJD?=
 =?utf-8?B?cXpQODE2WWI5bHJ5aUNWU216QWJXelN5cjlTTENzWUZvOTMzRDcvK0hBQmli?=
 =?utf-8?B?TGdhandiR2x3SDFFSXY0Y2ZpYXJqTW5SYlp1R1FpclVJYUFUWXlzKzR2Vnli?=
 =?utf-8?B?dEhDUS9Pa2VML0s3OFpNQjJkYXp2MDVTck9oTHpReDl1RWZTV0JZOTB2aUJU?=
 =?utf-8?B?blpQMWVlV0dYblZqUW9aN0ptR3g1TUFIcWtqR2tRRnZIOXpMMEk0dUs4V1A0?=
 =?utf-8?B?a3V6Qk8wR1FRb0o0djNpQVpHR2txN0FrNzdiUG5HeWNuYTlKUnRrQy9hY3Yy?=
 =?utf-8?B?M2tCUHp5RzBLR1JlS3Q2T281amNTSmZpL2cvdFVVWlo3MEpCZE53RCtPWUx5?=
 =?utf-8?B?NDg2YVJSNlM3MFh1a203bVJFbGRrcW9CT3F3WUVSN2RXdFlmb2EzTzQyWVFy?=
 =?utf-8?B?Z2d1VWtzOVRFWk9JMWlleFFGekRkK0F1VU5EaDZVeDhGYlllS0owTFAwdmFI?=
 =?utf-8?B?SDdORGRHUWJIOGk5OEdWT1dZaDlFK2puS01WNThzNEFGOTlPaEdOWm4vWno4?=
 =?utf-8?B?dDJhVENEd2o3bWNyOVhScDQzTnhydXZjTU0xTngzNFZXWVF1bFRrcUhYSzVZ?=
 =?utf-8?B?eU5sZlArRDNMbkZoZ05qTTFQWS8rUDZKRHl2ME1yeE1wdHU2cHpodTJoa3NT?=
 =?utf-8?B?ZysycmhtT0NaWXJ5a0Q4M054YmNiQVhvY2p4VFR2RVV0Mks0OWVxakNTTlNm?=
 =?utf-8?B?ZkVndmdCWW1VTm1xOWQ4YVJ4MWc2VnhySmQ5UEJ0bndRV3ZGNzFQQkpvc3Zo?=
 =?utf-8?B?SkhqSWc1RjVOdWRaR3hQUnZqcWNqOUpNakpBMVVKMHd1cGM1RVVTdDRCLzBn?=
 =?utf-8?B?cTF4Q2kwdUZWZGwrRi9yQ1VCZSs2aVZ6MXU2dlY5eEd6U0RWUE5kcWlhSnZy?=
 =?utf-8?B?TkZTUHlhaFprZk1Kd0ZqaW1sQk1JclJKaE1ma3pmcUNuazhtQnRKV1ZHQ09k?=
 =?utf-8?B?Uk9hWHZNV3dVamhKWi9rejlCaEFFOEtQVXZvOEJQS0pCdHZvOVdkaVlCbUNl?=
 =?utf-8?B?U2JHamRCSEJOa1FUdHZLT1hZYVE2K1FYWVlyZGNNL0xIZm94SlJKZ25IeVd5?=
 =?utf-8?B?MklhMlRTakFyRVFJdGw1bXVzYVNqQTVPbXRHbDlYRE1KYTkxTnRCSnRWZlVH?=
 =?utf-8?B?MEVJWENZWmxvbnNoTkFMN0puU29nYkk1bDdhajZQUUhRaTcrYWFETFUwcE5E?=
 =?utf-8?B?SmdKV0J1RGJueHFvbWlLMzR0VGlNTVJUaFN3cW8vRmVPaTJLNXd0YkJqbXpO?=
 =?utf-8?B?RUJSREJQQ2xVQUxsV05BRW5HNTdudUQ0amJ6QzJ2MHNUL0xZbnNkTTJTWHFn?=
 =?utf-8?B?THdCcGMrSjUxTFZMNFdiTTBVZDUvYk0zcWtwazBsRkw2enVmbEN6NWR2MVpp?=
 =?utf-8?B?ZTVveFdDQTl6NUJMMGdXWktpNitrRzdrNkF0aU0wdkRMVUtBbjE5bXIvWmI2?=
 =?utf-8?B?eThtc2d6UHpPMlBINUVBK0xSRWk3OHhMKzZqZ3A5NzFFUW5oNzJneTRoK0JK?=
 =?utf-8?B?d3ZYZHpLT2ltZ1VLcmV2Q0VGMUlLL0FsMUJJeHRwZFpCMTV2a3lsQ0ZBRDl1?=
 =?utf-8?B?aTFnKzJQRkpFdnVWS0dHbGgyR3RybHE1N0xEaG05K2ozVDlDQjQzaGllL2hE?=
 =?utf-8?B?OElNS2NIdFVBbDlKam9kcVBZMEFvaDQyWFJ2NVJJcG5KTGdjR2xDZ1dmNFZL?=
 =?utf-8?B?MVlqcWhpN2NHakVPSSs2eDNlWC9BWHYxQXIwNzd3a0F2WVdOdnFhS1N6a20x?=
 =?utf-8?B?MmhxTVVUOExzTVlVdEJNNVZhVFpwam5HTUJ6K01XVlpTWkhRYWxpZVJTcnIz?=
 =?utf-8?B?SE1RRGtqYXpKTFJqQjFqZFJLL2dmeGpoVHVtZ2Jrb2Q2bjVlZ2d0cmxSU0Q5?=
 =?utf-8?B?aXZXRVFmY1czenZUdHlvKzdaY3k1TVNLaTJpMnlZVUdtZmM5RzJTQVRNMHdr?=
 =?utf-8?B?a2lUdW9sZVc0dm00L2pqT05ISzhXZ3lmK1VLMkptdnhCUXVESTM4UmJtSUJT?=
 =?utf-8?B?OWhzd0RUWFBBUlJpclE2elljdkRmaEsvVmtwWHN4OU9Eai9ub3JyU0lqSy80?=
 =?utf-8?B?MkR6YllFU3BLbGVqZzluRXVURVhWUHRRKzQzRkh4TmpZVFo4VVVwVnE3bG4x?=
 =?utf-8?B?R3VSbHZhaGxUdkQyVWRxbWRBZDJPa052dS90MldMNExZMUduUUR3UzJVQVlu?=
 =?utf-8?B?TUFMejdOVFgzM0x2RkpaancxQ1dvTW5ydytsNENYWWNQUVlwUVBjSldUeUEx?=
 =?utf-8?B?K1JmQVFPRkhRZE5SbGN5SGd4MjRsVHVJR0NrVWJwRHFwWFgybVdDdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 22954e15-b2d4-42d1-5ab0-08df1ce82019
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 22:39:00.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZvQNoCPdbu8cTJLTzdcSyNNurneEi6QSwh/Ka+DB3BMwx8iZVAQ3Dlx/pCW6EzrIqKYQ+OuLJi3y057X5wC/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6132

On Sun Sep 27, 2026 at 6:15 PM BST, Mathieu Desnoyers wrote:
> On 2026-09-27 12:40, Boqun Feng wrote:
>
>> I want to point out this is not true for the lockdep use case, because
>> the we need to protect a hash list deletion there, and we use the
>> address of the hash bucket there. It's proven fine in practice because
>> the readers are rare (we only call the reader is_dynamic_key() in
>> register_lock_class(), that is every time you have a new lock class to
>> register).
>>=20
>> Maybe what we want to say here is that "if the users guarantee no steady
>> flow of the same hazard pointer value, we guarantee forward progress".
>> Thoughts?
>
> AFAIU, your approach to protect lockdep linked lists is to use the
> address of the hash bucket to protect the traversal. As this address is=20
> invariant (global array item address), that address should be fine
> to fulfill hazptr requirements, but it has downsides: rather than
> protecting the specific nodes being retired, the whole hash chain is
> protected. This means that, as you point out, many readers retiring
> nodes from a given bucket (except the first node) could end up holding a
> continuous stream of hazptr for a given hazptr value, preventing
> progress of hazptr synchronize.
>
> It's also coarser: per-bucket rather than per-node.
>
> Am I missing something here ?
>
> One honest question: is this pattern something we expect to
> see often ? If so, then we may want to introduce a notion of
> hazptr protection "period" flip (similar to some RCU implementations),
> where we tag the low bit of the slot pointer (0 vs 1), and alternate
> between the two periods in synchronize. This would prevent a steady-flow
> of same-value readers from preventing synchronize forward progress.

Slightly off topic, but I have a use-case in mind (in case you're not alrea=
dy
aware) where the address is fixed like the lockdep class, but it does not s=
uffer
the forward progress guarantee.

I have been wanting to use hazptr for revocable for quite a while (I think =
I
chatted with Boqun about this last LPC). For the revocable use case, the
protected pointer is fixed, however there is an additional boolean flag to
determine if the resource been revoked or not.

Something like this:

    void *revocable_try_access(struct revocable *rev) {
        struct hazptr_ctx ctx =3D {};
        if (READ_ONCE(rev->revoked))
            return NULL;
        // note the & cancels out with the * in acquire, so the address is =
fixed.
        hazptr_acquire(&ctx, &rev);
        if (READ_ONCE(rev->revoked))
            return NULL;
        return rev->res;
    }

    void revocable_revoke(struct revocable *rev) {
        WRITE_ONCE(rev->revoked, true);
        hazptr_synchronize(&rev);
    }

So while the address is fixed, we have a different field to do the unpublis=
hing
part.

For some context, the current Rust revocable implementation uses RCU, but t=
his
is limiting the case where it can be used. The current C revocable series i=
n
https://lore.kernel.org/all/20260912123529.7951-1-tzungbi@kernel.org/ uses =
SRCU.

I think this use case is a good one for hazptr, in fact, I have encouraged =
Alvin
Sun to try it out and you can see an implementation (Rust) in here:
https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-6-074badd=
18716@linux.dev/
Although, over the course of the year, we have been reducing the amount of
revocable usage and shifting to represent things with lifetime..

Best,
Gary
