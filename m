Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021130.outbound.protection.outlook.com [52.101.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205D42F6F2;
	Mon,  6 Jul 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341592; cv=fail; b=EI01E0/gweQ7j8bd5eqNz4EyFqHaejfShpzfOfzYuAJ68eXIc5Rgw86kelTNnBkWXBuRE3rF5Y/cG5HJNr8mpLb8Lw4DwXMO5Ic2CrEL7RCbKzqE9uDsQKXnD0cfuFWzdIFTOCMoKndsNUBEjJGSfAjFyQEf3EW3DpAXgGDjSSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341592; c=relaxed/simple;
	bh=7Kcv+tZ52AaqDNMW1W48SaUUp+30aLI99P1oiSn7rfM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=F1hsOy5QEecIo1Qm+jdw90b0f0xFzTOig8qEqVLlE6q+DEf+nSmwE63Tgg130k26WlObPY8Fc3a9VEodtRxD1Y0pDE7fcIn8Mi/jhRVg9sFnGByaBY8OSqiK5gY9HaLPTr5IOvZf9MYA5sp2S9n/w51R2Bm70rvc6bMi329DefE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vXloD79+; arc=fail smtp.client-ip=52.101.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vXloD79+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgSy+lhiHtnhw8PSqxLSOOjCghEH95+se3dfjz8k56ilWXrDBaSPC4OnJv+vCRPdCP4BqCkUTGdTYhQU/9maoZkOyf6RM986sQnk5aBz5ENeXbvjLS2WJNnpb4D76fihRRtDqaUDGwE7sCDEjSfmKLcZk5svsmVnAhDCumu05r8XB9/w6kChP7aWRkh72UCvgG1KU0MsULS7w4/fmlm+8/3rOSp9X4WFfBTEM7A5O9FE48UqeaeaWMZR+acmyeR0wbU/7/leb2XIOA+7VqsxI53f9BEWUKWT3q31toOxMH7c7uic5U1KekNiODnmXFo7+bLRwsyHNjTe7jALLeOmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p78VHKSNRETrkYr3aySf6Dwdwbd1/4uSmwe3iM3Tgxs=;
 b=UTN97fclXFJFH1etZRGzNVQ/TXWyiN8dloOi6DySuJ+Rwhf88qvkwQn4N7mkkn1igcmWbJXLMTWnKAGMIrDOqBqOlUgvfjuvbupy0VhUJHPRQRllsC3Zf7JQ+FXVXMvbLca0XTteWYk5XXnmTHuCD+VbjFGwDNfXutseKRoEgi5KQwMiiXPA6V6t9oUf5Y/wpJ2AVzGcuyLPSddSo2GaGm3+2+PQMktlnu+wHJrvpornpBFa2Lzt2FAomasbD7YAliiYO/BN5WSsP4xMRBA8yTE/CGf7rrbW1PQyUYRHY/wixLiKRN+xxLyfmABhsxD1XY1vibLos+KMJ4B1GY5Jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p78VHKSNRETrkYr3aySf6Dwdwbd1/4uSmwe3iM3Tgxs=;
 b=vXloD79+sz59ZpE3wIcu632qjjnH+EAqUbdHTeCvLwLHLVIgRYWFY77fwV7OowYkMfocCXPqexPfxyj9KZR7n06avakJKeEynrS0oCKbKrrtDQI98JyQtU0icNXCUY+/biVPLCVjs25v/sT+CrUME23tbAp+3hDBE6qIbYQY7L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8756.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 12:39:47 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:39:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 13:39:47 +0100
Message-Id: <DJRHTZ6KPOFC.FEE1KH7W6SQS@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <boqun@kernel.org>
Cc: <rcu@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <peterz@infradead.org>,
 <fujita.tomonori@gmail.com>, <tamird@kernel.org>, <jiangshanlai@gmail.com>,
 <paulmck@kernel.org>, <josh@joshtriplett.org>, <rostedt@goodmis.org>,
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 4/5] rust: sync: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260613065348.96750-1-work@onurozkan.dev>
 <20260613065348.96750-5-work@onurozkan.dev> <akuXpnwb_y4R7ekV@google.com>
In-Reply-To: <akuXpnwb_y4R7ekV@google.com>
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: be7c5742-2b8a-494d-50cb-08dedb5baa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|10070799003|6133799003|4143699003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WBKzF/hSyh7Ot9TwR7/xluw1yQDEDV5UDxW8ePt11SFEexwBMRNhoxeCeQvi9wO208UwuB/z5gnXXmJB9k57kAwyJ5yKxEP+cZiuzKplmb99us75bhpLyb7OywcyAeT+cjHWhqKu1pDH9NHdJzI3s/2C/P8aNwulItPd7nbtgfcUkl37hXlQzWgAfPGslGJy0qQnQ+lOHKVNjokat+eZ/UMUCtU68Wn7T1jyl/HKvYhGlQAiC7CdKew577l5R4s2a5a8hoBipj1c4A1+1ddQMlqFWKdDAhoEY7ke9rTFda+0/NeGsLTgOX7pmsRIifAJWdta4Nm7J+rzUe+JuO6Us7Ic97Qf/CecWhTVuyfKqV16mp2ZWuejnXh9cM42Htg9T0uDurC6dUvI6l8grJp/IzwP/hNNkgkEZ09Y5jJMpA6AX07BTxI2ff29qR/DJ4s1CZ44sYy2y24gptozPJ/v7qmyUXnEZBCoZEqNp0Z8+U475QRwizI1S4phGievSne4+9yEUkIl2tqgx3tbi5UF78yENRBUmSAjE66ceHPqT9/u18jjdS/z4NJqV5fY9eoWOiLf/zJ4ejKnxh27OJxUlmlEBdiUbMrjFjwRcO3YbvOejp0T287rtPKaakNNnqdI2mvgHJP/G0k88LSTO19Qd2kBapYBwrB39lbQ3Yzsavc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(10070799003)(6133799003)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtXdDlOU3d6SjFpS2w4YWRxbWpPN1YxREw2dit0azdJT0Z1RjhGLzdNZ1hl?=
 =?utf-8?B?aGVjODFJdHhjME1HTXlvZmh5R1JkK0NPYjlUYWF0b05XcXhDRDRLbk1rM3B0?=
 =?utf-8?B?K3BVcFhRSEE2d0JkNnlLUkREcmpoSmZOTzljeitGWW4zS2g4QUxidTgrOEJo?=
 =?utf-8?B?dUJxcG1vME5WWG1STkM4cnJ4Y1dUYVpCWGdNRGpRZ0NVVk4vN2ZNNDU1VzZj?=
 =?utf-8?B?eWFCMGdxWUJFdEVHL3NUNjN6UUtQOVdSY1greXlOUk8wdHpWRHB2QjJTUzVQ?=
 =?utf-8?B?TTg5RWwwMEp3NmdOMWxHWFlGQ2NjSkVFRGxWbDF1T0N1S3BJNGp4eUlyTnBn?=
 =?utf-8?B?OUJkWFU3STV4dmltTU9uVnV0S0wxS2QzaDE5ZVBPYXpkUCtJV2wwQmZoaTBR?=
 =?utf-8?B?eXhZaEpaZTBLc0lwZFVtQndXVklaZGl0YUhWZ2ExbjlrcGRKRFdycHBJUEI2?=
 =?utf-8?B?ZndVTGtBT2lYS2o1SkhZZnVtNU40V0E3RXlCRnIwYnhkalRzZlNvR1puRnVQ?=
 =?utf-8?B?SG5GOU9TU3JOT1Y5NXFNWlNMMHFqRWFIdTZMRGR5TnVHVVFhMHJHbVQ2MjJZ?=
 =?utf-8?B?WllBa3loQlc2UUNNRHpyZVJaSjIzK3hMYkhxeVpiczdNZnQyZUh2cWpVTkxV?=
 =?utf-8?B?QVBsa1RLSVBta0oxdjVyLzBsa3dud3RzbzJHNDJmUW8rWUIrd2hQNzEvdFo2?=
 =?utf-8?B?MjdRelVLWHRGMHpYVDNQYzRMWUNjekZkZDBnSHdSY2V6aG02NEV3VlZUbXlG?=
 =?utf-8?B?NVhyblNVYVlxejVsZGxPZHUraXV0c2RScktRN09CN3pyK1RNVSszUmFTYXBP?=
 =?utf-8?B?dGwydGk0RkZqdU11ZlRrb1RWUVVJcmFVWFZFUkFTdjdyb255RGFBWXpiM0pB?=
 =?utf-8?B?WGwzZ0NBM1ptR0ZhQWkrZXUzQWltdW5EdkErb0N1aHZCMHJ6UzcwTWhNMmd3?=
 =?utf-8?B?bVhkYTJSQU1sNU1iVFVIWFhET2h0TDZjN2tqeXI1QmVrY3p4MnNOQkhLQ3pa?=
 =?utf-8?B?UG5xV0c2eHBEaDBmK0loTHFHVnlnaU5kaWZDclE1V1A3VGRJWk43VXZvVXFS?=
 =?utf-8?B?cHlJaHVyS21mQk5HQ1A3dVdGOGZkOThVSTJWUnF1MTRocUppdkgvdU53MlJJ?=
 =?utf-8?B?Q2RsZ0IwVmFnZGl5V0xoWmRQSzVjSWNIU0VPbFpPNC9qZmwyeGl2NHdPdE5C?=
 =?utf-8?B?Q0F0L0FhY0tHU2gxM1RRVVQrWXB4eEpQbXMxcDdNdGI2dDhLYUZ0WUJlQ05X?=
 =?utf-8?B?VDFhaG1nbDVoODQyYVVGbncxNGNyQTU3RXcxUVlqZGdtVnJoZ1NWNzFJNE5j?=
 =?utf-8?B?cWV3KzRrT1NhWElNQmRIZHJ6UngyWnY2QjRycXlUZlRBblJ4NjlnTWdQNlls?=
 =?utf-8?B?VSttU1FnZjVmWjRaSGUzSG9oblVheVhBTlNFTi9qQVQ4K1lFdjVXUExaNHJn?=
 =?utf-8?B?UjF6WVYvK1AvcWRJaHNzRjBIUmo1cCtnVGpxNGoyb2l1T3RNSVhZcEFjVlND?=
 =?utf-8?B?SXcvOGw1Q2V0bG9LdEViL2YzY1RvSEtBK2ZIODViU2tVVUwwOVMwaVZuOVhs?=
 =?utf-8?B?YkoyaWNqaUMra2pQL1Q4QWZyK0pxMGdSbzZaSDNtSDlPckhOUVRPWnR0SHpM?=
 =?utf-8?B?Y0lVNDloRVczZUxjTnVobnEzK21raGI1Nit5SndHelRGVytwdU9zWkl4K0po?=
 =?utf-8?B?QTlSU2lOaCtzQzhsaElKMnNjKzlwOGtnelRkeGRJR2tJRGRHcXJvTmw0cXha?=
 =?utf-8?B?Uy93ZTVNQzlHdGVhQmtseFFhUGNWUmJlOGNlbXhWNVU5WEtzdU9DYjNSelF6?=
 =?utf-8?B?dFlIcGNzNExaOGM5TVRGRERVRmUvUWdpOHdJdmkrMnQ5TXlZQkZmazN0YkRY?=
 =?utf-8?B?L0lxSzh3VDFpTlluOE9kOHRUem81d01STnhlb2tUMDVpNkk4NDJMUVUvZUJr?=
 =?utf-8?B?NzZ4VENSTjdDMWpRUnpVNCtBRnF1RlJPck1UZStPN2VDWGN0WnRld0NhbWJW?=
 =?utf-8?B?Z0tuNkdqK25BMDZKMnp2SURMZEVWZng2ZWpSOTNVdVo2ci9pMkYrcHlUMnlj?=
 =?utf-8?B?VWVUUDN5MVN6eHJOTTVFZU00WFNrUlh3bHZUSUh3cVpzcEwwME1HYy9oNUE4?=
 =?utf-8?B?aFNoMkd2alhqNVVCT3dGUFVDNkE5L3JaMEwwNGg0WEdqM05wdWtIc3hzSkFl?=
 =?utf-8?B?Y1dMM3laVnFuSzdJcFpMNWFTaGkyQTFIRml5ZWsyQitEUTZ2K1RBTnBSTDNY?=
 =?utf-8?B?MDZNSzN2NVpReHZ5cWI1R1d6dW1Sazlab2dQYWlhUlRFNW81anEwWUtJV0Qx?=
 =?utf-8?B?WHJzdEg4R3FoSlA1VDJQZW9pbGdEYk5VNk1yeDlLb0NiMTAreXBhdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: be7c5742-2b8a-494d-50cb-08dedb5baa20
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:39:47.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj5WozWBUXIUbqi61tvNsmOYLzD/ep1wxgbQynMo5VnsjGVFsaYboE4lELUzdzcL+JXlLg3kmmsARzTWABO0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8756

On Mon Jul 6, 2026 at 12:55 PM BST, Alice Ryhl wrote:
> On Sat, Jun 13, 2026 at 09:40:10AM +0300, Onur =C3=96zkan wrote:
>> +#[pinned_drop]
>> +impl PinnedDrop for Srcu {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        let ptr =3D self.inner.get();
>> +
>> +        if crate::warn_on!(
>> +            // SAFETY: By the type invariants, `self` contains a valid =
and pinned `struct srcu_struct`
>> +            // and `srcu_readers_active()` only checks the active reade=
r count.
>> +            unsafe { bindings::srcu_readers_active(ptr) }
>> +        ) {
>> +            // `cleanup_srcu_struct()` may return early if there are st=
ill active readers.
>> +            // This should only happen if a guard was leaked with `mem:=
:forget`, which is
>> +            // "WRONG" code and may cause a UAF because Rust will free =
the `srcu_struct`
>> +            // while it is still referenced from the C side (e.g. by `c=
all_srcu()` callbacks).
>> +            //
>> +            // Another consequence of leaking guards is that `call_srcu=
()` callbacks will
>> +            // never run because the grace period can never complete du=
e to permanently
>> +            // active readers (i.e. leaked guards).
>> +            //
>> +            // If this ever happens, that means the guard was leaked by=
 mistake and the
>> +            // caller must fix the bug. Sleeping here is intentional an=
d less harmful
>> +            // than risking a UAF.
>> +            //
>> +            // SAFETY: By the type invariants, `self` contains a valid =
and pinned
>> +            // `struct srcu_struct`.
>> +            unsafe { bindings::synchronize_srcu(ptr) };
>> +        }
>> +
>> +        // Ensure all SRCU callbacks have been finished before freeing.
>> +        // SAFETY: By the type invariants, `self` contains a valid and =
pinned `struct srcu_struct`.
>> +        unsafe { bindings::srcu_barrier(ptr) };
>
> Hmm. It's not entirely clear to me that synchronize_srcu() is needed
> here. If there are calls to srcu_read_lock() that do not have a matching
> unlock due to use of mem::forget(), then either there is a pending
> call_srcu() callback in the queue, in which case srcu_barrier() already
> sleeps forever, or there are no such callbacks in which case I don't
> think this actually leads to UAF.
>
> Thoughts?

If srcu_readers_active returns true, then `cleanup_srcu_struct` will hit on=
e of
the "leak it" code path, and the question is whether that is okay.

My analysis in https://lore.kernel.org/all/DI9ADEUBBUD2.22OR0R12PKVQL@garyg=
uo.net/:
>
> But after taking another look, I am not even sure if this is needed. A qu=
ick
> glance of the code it appears that __srcu_read_unlock doesn't do anything=
 apart
> from adjusting the counter, and the SRCU grace period and thus the timers=
 won't
> actually start unless there's a pending grace period, which won't start u=
nless
> there's a call_srcu or sychronize_srcu. And we *know* that none of them w=
ould
> happen, as the lifetime guarantees that nothing accesses the `Srcu` struc=
t when
> `drop` starts, and inside drop we have already invoked `srcu_barrier()`.
>
> So I think, even if we hit the "Just leak it" scenario, we can still safe=
ly
> deallocate the backing storage of `srcu_struct` and nothing should break?

So I _think_ it is not needed, but this is quite heavily related to interna=
ls of
SRCU implementation.

Best,
Gary
