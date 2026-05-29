Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020082.outbound.protection.outlook.com [52.101.195.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A13E0C73;
	Fri, 29 May 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058479; cv=fail; b=OVdJ34fTQQiXSlA02wqNXh6Sz4i3zsGWoxDNy4fHAbbDotLmFktAXYjSQJP0RAXQhDvQOX52hWGsXAzbiSjzq4m1UDkza1og3QNuMEGoQLBqqAaJfys10hgopbAiIkQl2Nn0Dlgj1HuFQ2nCqJF5u/em0I3QygvB9TDXud5MChU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058479; c=relaxed/simple;
	bh=cqpFpaTQvAqKIoRwy9RyAHov07YfBAdmjRTdnJm8AMQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BzTKmAD6VNejX71fUPILdM4/5F/c1dzFz7XTTEi0/oRZebwCnEmNJJS6pldHtnh6yiGbs2gAltfU4imYOZvl0aexePWQmudyusfxycf3jsR48O6g1hq72qmSCkcBf3pvtHSA2TwvSVHPfoGI6p7kMGQh0nkcimQtZ/hnGdx0+7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=m7ZVixRA; arc=fail smtp.client-ip=52.101.195.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="m7ZVixRA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYQPzqEAYgtplOuVCs9UA12amPgLbj5Tv6Giv2MpXBk9seu92E0hNj8X1ZKOm2gRqmlTkqO3N3rLvlRWB69Is16KLdKPhEcYZeOncGZIZYTGMxGoxHm0ZAbcveYq+Wo1Mj4LgFdZ4l2tAjDFhlEEcL/eU8TXnorKFzOxUcGhn3apwSJE7vT4N9dJduTgSmaiGCecQ7fUSdKhhQZh6ApfHdmBH7rxUdUE5fhqMHH/lp2JffOf71WCV4Y74Cj6p1067xtqdoWdVsFSutUz7+yd0KFVaDHbdi6+7hu8oSvi7rekDpazmhA5jjQL2M98ibEBG1XpOz6JPpuznosggPrk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAtQnWDsr8Md8NF5wRWyWzSE8MZhhuMrw1KFgTiGI/s=;
 b=WRCmpMwqdfSQbGLBqXc8WoJH+DwY6KxSLaJUHEmZv1b7EEQrCD/QmcSRbCEVLNo1dxalBmULTVl+VD6HqqfoeQwciJ5VR7XOyk6/6BvyGmhNb2eq2jionTvUA9M5DV4AXFpqUkjBsO2wV7M67h6R3xHJGGUekTnrgA4fe4F4XjqPcGNJgYfPPz1xbeOUWX3s0p6mNl1v4iCdC5SHeMb468SvVOcTNVrWr0b51+ZeKcM9zJxqVtOnLKPsAi5AgHoIsBLWvUKjKP9sVRXi05p2sqGCEjkOwqJFtIaAFU1S/VJQhJKFgg9puFc7RBE8HDGdxUfVPlxs2Y2n63rEXbWsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAtQnWDsr8Md8NF5wRWyWzSE8MZhhuMrw1KFgTiGI/s=;
 b=m7ZVixRABtyReMkKGE+9SpeW/RZ6GyPqMFV+vxTpCQaF8sUnJzxjGyqjjkP84klp7UZ3nxgDmRCMltapUkP8yStQr6RTlauHz/i3QA29pmZjIuwbx95G2q22xSuUXBVHQk0XzeZTbuCBwv03Q4CSFhQbDUtg9ItuqHP5JDefcNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 12:41:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 12:41:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:41:10 +0100
Message-Id: <DIV62C2KC8HW.1KB4JAT9SXCRX@garyguo.net>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <fujita.tomonori@gmail.com>, <tamird@kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260528062810.256212-1-work@onurozkan.dev>
 <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
 <20260529065744.59786-1-work@onurozkan.dev>
 <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net>
 <20260529122920.175997-1-work@onurozkan.dev>
In-Reply-To: <20260529122920.175997-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: e00bf20f-43cb-4023-f2e2-08debd7f8fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|18002099003|22082099003|56012099006|6133799003|4143699003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	IdG+vaAVLFpnHdR3yRwobs861ZB0C0KOSA5JD6pyO4ztgeLaNELoJin51XX7/UYg5AVm0lYKR3kF4fA7FrNWkg4QXJzcri7zu13O3u4zhxYvcgHOnL+lvtbSDNT8GWxgcV6c4hxNeHc6f/SPNCvMi7UImVEzTM4AeSC91T7isomz/Kv6mJn9mUfDmND1COE5WGD12jGQtwwU5ywFYNKOzxynLbhGmRpv1r50xMTzAF8YKR5KINFh+hgWa+nCo+qkzlZVIOU38GkuVwxs2ZGlYAhas8aMv3jC9D2x8wQ5ZWEa1nI6ZELwI/f2dbPQWbWOkgfJlian6ZrydHQJP5n8Upgr9Q4u4xP2As6ZrXrGmavqZP/P2jyic99ER12ejQrDp2Wjzox4EJvPauoqGz4LfrdWerH3JVqabLjXinhzY2HZ7+urFGiWtH4wuWAJu8l+9QpxcVRKb8qt4yw29YvAd6PQKATQ+lM9JKojl0Z9Nm8qlZ0RYtVU1Srjwp4ni1dP2CVw+yj7xiGqfPAp3xEnjOfAn3R3Fg46bNbSTkuIPnuxfRWko75xLyHtIb4EspLL47AgzmOlayY6lqfJDGXdtYhtYK3gsUdQ9LpsifnDwEpYeN1/x5TG9WgfECU/ZBnqJSxIdL9XZD7rt7+7zU6xuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(5023799004)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE9ZUGU2bzliTkN0ZlJERUUyeTZ1UTV1RHkvRFpOc201U2RxRnV1UkpVVWVM?=
 =?utf-8?B?bld0OWp0SFVMTmZKMkNpR3hlTXpHKzZ3ditDZjVTZGhGL3crN2V3ck45eWFU?=
 =?utf-8?B?dVJxYkJHeDZCMzFza3E3aFVXL0ViZFFtV0xFaWpMS2FuYS9NWU9sK0tOd2No?=
 =?utf-8?B?bTRaZVc5S0JkejExY2ljUEhqaXBMbm5oS1d4alFxRHVsZzc2R3pIRHNuUVd4?=
 =?utf-8?B?SkJzWlc5UTZ3SG1yU1YwbzhUZk5CU0F6NW1wcEk5Mzl0UEY5OCtabHZlUnFl?=
 =?utf-8?B?cTF2YmxVVnlRK2JkSUJBMldMN0dzc2UwTERzYWhvTDRvZWoyU25UZlZhOExr?=
 =?utf-8?B?MFp6b1BoOW9WdXZySVZkNmNxYitEamxEcWp4eXNwZUVIcS9ITEc2M3JWNERs?=
 =?utf-8?B?enlUMlFyRUZaVHk1WVF2MUZmU3Q2NENSbUluNzZCSjJ4TDF3QWUxZzQwdHp2?=
 =?utf-8?B?eXZobHYrMWo4N0hyZEtweitTbDd0c2dlemVzaTgzSWdSZ1Q4YXluSENlNzJz?=
 =?utf-8?B?SmVOZE5PWGc5VGExaDNHUndoUlFNaEpQNVZFNi9FNnRUUm41dmthZkxjMkdW?=
 =?utf-8?B?WWxCVzlVU0J0bk1kemxsMkVVMTBkdGFHQjlGOUtoQ2hvSnhCNFZWcFZMM0Jo?=
 =?utf-8?B?ZkM5ZXB4WHVLWlQ0ZVBrSy9qSFF3Z0NmNis3WGVNdDlJOVVvaERhT0N2bGVR?=
 =?utf-8?B?aVBlYUFxaTVPZ3dnVUZBbkFMOTJNbVR2aFhyYndPMFRpZnFUWlJVcVdzdWEr?=
 =?utf-8?B?NVpXVm9RZTgweGYzbGt5NEF3eFBudXJjOUFFWi9jN2k0ZzlxZVU3OXFscWNQ?=
 =?utf-8?B?cDM2cGIzMmxkbVJrbHJDdU5ueUxNLzZzWUFrWVNSWWJhblZwcTNWMGtxOW9w?=
 =?utf-8?B?dzdFKzI2RExjZ1ZwdWhFSXY3c2JFZTZWRzdVR1p4L2lKbkRydVNNa05Fc3hx?=
 =?utf-8?B?bGF0L2ZzUjF3REhqQnFWaUFlTHdZZ0lTUEdIK2NVanBTT1VVdEs2VW1BQnRP?=
 =?utf-8?B?RHN6clJjWXNlUWxXRTJ0TGY2UjhMS1EwS0NqNkpzbEEyUGJnNWhmWWI1Znpy?=
 =?utf-8?B?RUpFVUF5REpzNENXOUV1TmRrSEtpS3h2S2RFN0NPVkcxdldvQUhYZm9COXBo?=
 =?utf-8?B?ayt1UlpWMXQ2NUNRUENGL2tVTTVDOEYrZDZGdmdMSEpOL3dlZXRJTnZxWnh6?=
 =?utf-8?B?QUNnL2Z1YW0wRkhlbWptSlBPOHBxTnhRYjY4amFpd295VHp2TW1DQXFmK01w?=
 =?utf-8?B?bDFhV0VuNTlXd29UWXNhVE81SWlXWkRFaFBrdlk3RTlKbEZpbHI2VitGTkRv?=
 =?utf-8?B?NEFHUWZRRTdxY1FHdWJJbmdveUxRRXVVMEFvemJJSiszNEpBWWF6MGgvV2h2?=
 =?utf-8?B?T3A1S3IzWGx2U2JQZGdyb2hyWmZUL21nVUZzU2VlUHhHMjgwMElzV0tyckVO?=
 =?utf-8?B?ZlhHZ2t6SENzaUIxeHRCTFlqdEhQZ2tmR3BVTGNiRmMyeDJDSWhVQi9zdEps?=
 =?utf-8?B?NS9UcE84NE1tRTI2Nkw4ci9GU016M3duSkhOekhZeE43Q0YwbkJiVmVPTXZX?=
 =?utf-8?B?dFM4SjJpOXl0SmVZVVp5dEZFR2hXNGx1cTdCWnJFdC9xcm55SjRFR0NvUHNw?=
 =?utf-8?B?WngrcFc3TU41dnVCRThCV291VmM3UE9IYlZ3VlI0bHZiV3JNSUV2TmZ1SkF1?=
 =?utf-8?B?b0tjRWswaFpZUk02T0pWclJPZGpINTFTTS9KMDRKT3c3Tmk1T2FGYnpydVNO?=
 =?utf-8?B?OW5LMEtOT1lRTGVocHJMVlBJbXNiYUNiVCtRQTVxRC9YeEpVZmVpMDA4cDVY?=
 =?utf-8?B?OThnZHEzQUM2bytDMDJZZ0VSZ2pEZlhpNTZaK1Q5bllYRnNDU2xFSHVpaURt?=
 =?utf-8?B?cUVaYWJQYWVtNHpmRmFvU1UzZExZZUZ1UW9UYjF4M1ZsczdkTzUrbExqRjBX?=
 =?utf-8?B?MUtSTzkyR2E3VzExM2FXV3EwWHdjZUxPS215RFAvR2xWQUtXNWJZZGt1QUMw?=
 =?utf-8?B?aHArRWZpS0RlZkFzQ1FoekxQSU9KUUI1WkQ3Ri9xdmRkRCtFVFAzRFBrd0xV?=
 =?utf-8?B?Wm9hTW5SZmNBejVOOTV6K1JoT1p3NHZyL2lQZktIbG4yaVRoUkZoOUFuVGox?=
 =?utf-8?B?Wkg1Ym1yMVZqZUVnQTRWOWdUb2hPREwrUWxUMi9mWUxCTnBhNysycHFkRVN5?=
 =?utf-8?B?MXVuaHRUN09NV0NDSVBFY2pHSk9CSk9pQnlGOWhzc3Znc1JTUzJOWGpOVUk5?=
 =?utf-8?B?V2Rpb0t3UGtaQndKa3IwVThaai9xMWpFTkFlcXhxSlBlSS83bnAzbEFhSGFz?=
 =?utf-8?B?MjRzemg0a3NqczVqRFQ1Rno5eEZCaUN4bktNUVpHVDJRVTdrZmU5QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e00bf20f-43cb-4023-f2e2-08debd7f8fe6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:41:10.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cPWgaMU1brEmGW487e5qZgyCANWxGgOJ7No7hTa1rtqrUeAOAs2A6FTXIzRfLI1EIIhUN1hAiQUBrRYBNoFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5626

On Fri May 29, 2026 at 1:29 PM BST, Onur =C3=96zkan wrote:
> On Fri, 29 May 2026 13:07:18 +0100
> Gary Guo <gary@garyguo.net> wrote:
>
>> On Fri May 29, 2026 at 7:57 AM BST, Onur =C3=96zkan wrote:
>> >> >> > +#[pinned_drop]
>> >> >> > +impl PinnedDrop for Srcu {
>> >> >> > +    fn drop(self: Pin<&mut Self>) {
>> >> >> > +        let ptr =3D self.inner.get();
>> >> >> > +
>> >> >> > +        // SAFETY: By the type invariants, `self` contains a va=
lid and pinned `struct srcu_struct`
>> >> >> > +        // and `srcu_readers_active()` only checks the active r=
eader count.
>> >> >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {
>> >> >> > +            crate::pr_warn!(
>> >> >> > +                "Leaked `Guard` detected while dropping SRCU; d=
rop will block forever.\n"
>> >> >> > +            );
>> >>=20
>> >> I think this could be a `warn_on` similar to how cleanup_srcu_struct =
handle the
>> >> condition.
>> >
>> > We also call cleanup_srcu_struct below. The idea was to provide additi=
onal
>> > information, we don't need to call warn_on twice.
>>=20
>> If the code blocks on `synchronize_srcu` then there's no call to
>> `cleanup_srcu_struct`.
>
>
> Ah right. I can do that in this case but honestly it's still more informa=
tive
> with the current way. It explicitly tells you what the problem is.

While the error message itself is not that informative (there's some potent=
ial
to improve this, see
https://lore.kernel.org/all/DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net/), the st=
ack
trace produced by a `warn_on` would have all the information and is more us=
eful
to troubleshoot than a `pr_warn` which doesn't tell you which `Srcu` being
dropped is causing the issue.

>> >> >
>> >> > Actually, now I am now thinking about whether we can come up with a=
 better
>> >> > approach when we detect leaked guards. Initially I came up with the
>> >> > synchronize_srcu() solution because it would handle leaked guards a=
utomatically
>> >> > without requiring any additional checks. But now that we can actual=
ly detect
>> >> > whether guards are leaked the question becomes:
>> >> >
>> >> > 	"Is there a better option than effectively sleeping forever when l=
eaked
>> >> > 	 guards are detected?"
>> >> >
>> >> > I have no plans for tomorrow other than finalizing this series incl=
uding the
>> >> > question above.
>> >>=20
>> >> The best solution is to proceed cleanups anyway, given Rust rules ens=
ure that
>> >> these are actual leaks and not just srcu read-side critical section t=
hat failed
>> >> to synchronize with the destruction of SRCU.
>> >>=20
>> >> This obviously require changes to the SRCU code though.
>> >
>> >
>> > The issue is difficult to fix purely from the C side. Once drop return=
s Rust
>> > is free to destroy srcu_struct. If srcu still has pending callback ass=
ociated
>> > with that srcu_struct, for example from a future call_srcu() wrapper t=
hen
>> > returning from drop while readers are active can turn into a UAF. Ther=
e is also
>> > no way to handle callbacks in a reasonable way in cleanup logic while =
there are
>> > active readers.
>>=20
>> Callbacks should be flushed during the drop due to srcu_barrier. Am I mi=
ssing
>> something?
>
> No. Callbacks can only be invoked once the grace period has completed [1]=
, which
> can never happen while there is an active reader.
>
> [1]: https://elixir.bootlin.com/linux/v7.1-rc5/source/kernel/rcu/srcutree=
.c#L1452-L1454

Well, then srcu_barrier will not return. When `srcu_barrier` returns all
in-flight SRCU callbacks must have been executed.

Best,
Gary

>
>>=20
>> I'm pretty sure that, if we disregard potential misuses from C side, rem=
oving
>> all "leak it" paths would be fine and won't leak to UAF if all users are=
 from
>> Rust side.
>>=20
>> To be very clear, I am not advocating to actually implement this way. I =
agree
>> with your conclusion below that this is broken code and a warning + bloc=
king is
>> good enough. This is really just my thoughts on your "is there a better =
option"
>> question, and I think it's better in ideal world, but I think blocking i=
s a
>> good pragmatic choice.
>
> I see. Maybe I should have phrased the question like "Is there a better o=
ption
> with similar complexity" to be more clear.
