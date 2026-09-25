Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204733936C;
	Fri, 25 Sep 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367448; cv=fail; b=A15e5lRrvDrmNIEU5KGmQXbGnjrwDk9poqx8yTukr4ZoUM+k/0OXSEJHq4KJ0/Q1NvO91S7cRMGgBK5I3TiGOlGdk89zR+nBJQFVjWP/8szfChxEwEC56+9SZWIV5sTgkllRSHPuLhSB++3hEMS+4PnNO30LtgK4FVzCFmVo7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367448; c=relaxed/simple;
	bh=U+YmxpTzumv92inx4JJRGPCsPbJnRB0NZ7aO/x43jHM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ZmxoGT00PX9zYeQAOKRliZpRp4olrlyiwlCFDLxBqqFUYq47miAI6hgmrmvFTO2rEZhbqYGDa4vXa63AESu8jNs442h6aybfiJW6vXm5S2RcXW3rSJMJvaDRlc3G3kpRpXcDymP3cKI8VU+s+E12mMXiZmcv3zAZPzwfcfRUF7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nIfcwNc4; arc=fail smtp.client-ip=52.101.96.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nIfcwNc4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efIsU3h2yPH/HA2SD/hix1TxtrIdonag8tsrKijRtW7YW45KRqnSkXwF8zdxyhoAW7CMDJTougdsTGPpIfAbeDLLxVrn5Vx7063alS0jFsugQHJidLdFM0zL3RLaz35NIDF9iRe7FKF7k0MkbIrPJ852ToC1SnSwpO3SeDCFkOppgo1oC8PVNcTIrFCtvo6oWQ4OZhdtyQKbAoceOPe+7Nvw61mAiekvFDtao0Z3zcwq4gVm6yps5nHJrKPaH0wtdZYBWBeY30JuyskVCstIy5XNDe8xShrjuvBNvkIW1q0QPIy5mml50iAHlNvUa0MP70ib7t8C9HrVFl5MUjH68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5i3JU11L+tftjLDQkxsolSknhk0slDA2xgM5w6wGko=;
 b=j8NxDapTebi35jMveHfHC7hKXjgRtzu5Kcb+8t6jd1tGREz/OxILyJltyaAxEia2gnb3N9w+I5ehPRzgwX6QBA56AtXXwvxGwQ80z4C7Pj+1qOSK08rslh8XKh+h22/NJ6th8montYccpxSeY4nxIuvDqfVcrQfwcDd5R2RixPG/gc5P29vJX5Js3/3/cJzFgbbS6bzJuJ/+D25xe84P0nrENeo5qpb96JoZ8qSXBixG5lZmTf9p4Z4OSLpXzG3mJy9fEN54qYchZ7FKLqUB+xHSSvge0E4VLp/l7lyI9zLoZ7Nh33jQzxcE/crBfZqUPMDa5RJzkK5vcw7P31ATrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5i3JU11L+tftjLDQkxsolSknhk0slDA2xgM5w6wGko=;
 b=nIfcwNc4mZ+ODkpkSTK4hQY0ndOgPsrWAQUrRNgHj0LdIdpCR9KKiJVUe/HHIsd3syaYcpWuMhnerKeTfA7AsyQnFYA888jT7mpOUe+ZiRIxUThbsYfeoWZImQ9UpTk00ptDVaUZaknrDgOTVRzeu7G/Paue0ehN+rTt+QP8tKU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7290.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:17:23 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:17:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 21:17:22 +0100
Message-Id: <DLOOAGFS4DEX.2DZKMMS9RHD0X@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Gary Guo"
 <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <kernel-team@meta.com>, "Boqun Feng" <boqun@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <lkmm@lists.linux.dev>, "Zqiang"
 <qiang.zhang@linux.dev>, "Wang Lian" <lianux.mm@gmail.com>, "Kunwu Chan"
 <kunwu.chan@gmail.com>, "Bradley Morgan" <brads@mainlining.org>, "Bradley
 Morgan" <include@grrlz.net>
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
X-Mailer: aerc 0.22.0
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
 <51044724-7c3d-4200-b0d3-540a31d95804@efficios.com>
 <DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net>
 <4da27ea8-6f1a-40a6-9be1-8bbd474d8367@efficios.com>
In-Reply-To: <4da27ea8-6f1a-40a6-9be1-8bbd474d8367@efficios.com>
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: f838026d-47d4-4f2f-85bd-08df1b42022a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|10067099003|22082099003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	OJElo7rvyRxeSKP9gJfS5uHNsCX9ynafvy4MVdUbW2Bf0pNkmUhJXZmx66qmo6WJNOJ9Rfuz3h+9brsGJuC2jpVW8wi1zPRTkegjOF7qZRlmIU8ED5QAY0Y3gz8t6bwZAq7/cliIEuzkOlQNIitqZKdtV/7hFaOXf0Wl0qfId86PuPy48epzpfwcJ3Ub6Vvi0jLAFYSLqRFOVSdGJkHOqKWcXcCxiWcU9bdQKfV1ojU95/3m/8RFTD5Wm25Yhgj76GZ71gxP0t2XyDkdhcY1QFjvluXtwtHv+FUhlvgGMJJVbImY4xAGV3yFCj4wk5+G/VbDxp45aa+79LVDfyUsAOaJjlM39CuxCbsSv88h6OsU83UKrXsS8ICCFKOtSyE1rZ8GW5PsRaXhT1IQRF0SaDSgxh0g+ONZ08cmCmOiqExKlhm35mL33gLWESwp3aMbQApF+GI5FS7mJLY2SxRiFLcI7s7SoS72wCK7CBW33faawQ2rexEqMqUlXrJPNRbPKY9/tdmeZD8Zn6JenRkklN/vyeZbj5SmXCiCODhiNJaGuZhnsUtjGLGROr1Mi2v0JOpBbohrvQiT5pB0lxbRk86D5tCCdvCyn++2g3YuDZcc9qmliUVmMamA5FNQ/8JAe/rcEZhD+E38GvD1r1Bh8FWJ7xNW322QrlSpiegmX4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(10067099003)(22082099003)(56012099006)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJTS3lHT2VoN2F2czA2TVUwZW9lcVh3eDFabGdEMXlPanQyQzJLY0h1V3Ex?=
 =?utf-8?B?MXU3dmF0UUF2cE5IWnJBMFFSU2UrZXYrWGZqU2dseUhZR1BiMlJ5ai9jMkdO?=
 =?utf-8?B?cGxsYnk4S25VSGZMdWdqYTBSVXZlNS9rVDdaYTdlZmpEQXB0UU1YdmVuTHJ6?=
 =?utf-8?B?Y2ZkWW9VMWE2Qll1VTN2T2lRUHFGRmJWZ0pNN0RNWk9GcjFsY3hGeGFmMWFw?=
 =?utf-8?B?NUtxTXFCdzBwWTZnVHZTbGllOTJTVENldk1CNFBZbXBYSG10T3ArTzFRdnJr?=
 =?utf-8?B?QVBNQmpsRStRalMwWkxtdzA0Mm5iM2M4Y2l2dHZNUGh4cE10cWhNcHlPc3VX?=
 =?utf-8?B?SkdOYnRpaldVV3dwT25JeWJYRmhENVEyeksrKzcveHZXWm14MVA1NERvcDkx?=
 =?utf-8?B?UFdrZE12YkEzY3Jab2ZxV1VZaUNjWHdtWkxKcjhGeUJSL3RXaThobng1TGsx?=
 =?utf-8?B?czh6d2RNNklQRU9VTHhxUnIyQmVSM1NjU2QxZ0tvQTZTTWRBR3diQXo4MkY2?=
 =?utf-8?B?NkpTWkorVW9vYU1RZjdBT1prMDRBcFBDSGhJS1kxdlQwUG5rQ1J1TWh4eEtj?=
 =?utf-8?B?VmdJOGZpVURHdktlNXVwSDlnaVpWTWVFMUVPdmFyT2VRcFNSK1QvcG41dU1M?=
 =?utf-8?B?Uy95bEpsWHpBZWpvNXl4KzlVMHNLdUhDUDYyTjNaWlNWQ1dKWGtpYWxrVkgy?=
 =?utf-8?B?TVBSMW9sTWJISkNNMkg3ejZWdDRxZDJQZXliWGJCbjBmenBzdWhKVjA0VEhx?=
 =?utf-8?B?azFGbkpWcjRxdFpnZHQ1MXR2RGtKWEZHSU91dnFMQm05THZpWWxvbklhOW9z?=
 =?utf-8?B?MDR1NTNjOCt5ZVlzOWR0aUtyT2hHWUpraEtJNnh5eVBueTNxQ3gwVXA3M0Fu?=
 =?utf-8?B?K1AwRGpoVnZmeGpXUEhmUmJBdjBvSUIwUFExay8vYW15NjZ3VEJVQU5xVnFH?=
 =?utf-8?B?b2JnMGRoK1Z1TkY2Z25ya1dVeXJFZWFiRWNpSVJXdnB0MHFJemIrR0pFZENy?=
 =?utf-8?B?UXFobDQzYUY3c3lDRjduRGQvSCtVSnNKNlVaWHpVMGRoUGgyeWREK3FsalBp?=
 =?utf-8?B?bUtWMWlaQkR2Ym9qcGFEdmdCWTN4Y2xCSTVVMlZZcmYxYjlqQ3BmQXdVbjJM?=
 =?utf-8?B?WVBhTHpFMDhPUlFyTjAzZkgyQ2cxL1Vra2p1d211NUp6cjVtUHZkY3B2OVpl?=
 =?utf-8?B?eGZxREFZSE1OK0xxS1VmUnVlMkhQemxiSTQrQmZTSmRxMGVWNm4vTHh3NnB0?=
 =?utf-8?B?bGJTYzhjRHpPMzA1TW5aaGZuZlZPMzJ3S1Y5TXBUNHg0MTgrNDVTVGpaZmxY?=
 =?utf-8?B?TnkvWkhMd2ZnYmRYcldLdGlQbVduRklWRUg4ZGVJNkRXVzgxM0dvaHZOT3lW?=
 =?utf-8?B?MzFrK1V3d2piV1pSY0gxZkM3Qm1qWnZ6TWttREtVTmF3TnFxSzF1aGVWYURE?=
 =?utf-8?B?SjVGL21BeVZnTDA0dDJ1NWt0WDMyNW1UNDhRRmJ0cVcyMmFqS0ZYRENrMEFY?=
 =?utf-8?B?V01Hc2NZWXQyZHNyZzVIWjdsWThYMUhhWmpuVU5NTmdxZll6OHE2YThxWE5L?=
 =?utf-8?B?VmpydFhuOTJieUN0WkNRd2VIZWZpeC8zbTA4bFl3dHRZSXprdXlESzRoWkhk?=
 =?utf-8?B?M2M1QzVYbHVsTkRBdVF4Q0hWUk10Z0I3YUtpeUVqVDZSRHBhSUF1Vy9uMzFx?=
 =?utf-8?B?M1FnRWZkeTNhSWU2dmwyS2sveFVjTXFrY3l4bk1ka0VyUHhMUDhDM1hCeTcv?=
 =?utf-8?B?eXIyZ2xNYmVqNjVqOVY0VVNPayt5SXJVb3pDWTRXa2ZlSG1aczRISGRySHlz?=
 =?utf-8?B?eWFlU1gxVDVmbG9DSUJxbE1JbHVETWZTOTRHdlR3aXZnVTAyQ1JHOTUxQzJq?=
 =?utf-8?B?Qy9BQ3BrTGdyeVlNUUUzZFBwNCs0L1htaVcwTndzL3dIaFNHTVQzU1I2OGR5?=
 =?utf-8?B?L1p6NUN0V3RSVElCNFVhQmMvaWEyY0JST2hTaXV5S1dWa1U2RlV3V3lPOCtS?=
 =?utf-8?B?QzE3dGZXcElCekQ0NExjbG9BQXVFb2RqRjcrY1dKKzVHbmtJWTMvQkExZEY2?=
 =?utf-8?B?bmZLdVkreTVrb0w1YUJuQzNjM09XM1pCL3B6LzNlczEvV29VdnA5UDZVc3FL?=
 =?utf-8?B?VlhMZWQzK2U5UDlVNW5STFVZT1I0WCtHQ3FJMEFBcTRWU3l3TlRYQmZBQ1RY?=
 =?utf-8?B?TU11QnFQOHZuYzJXS29HUEpiM1FWbVNMUDVRMFQ0RnltUmNPdE11NFlCbjdK?=
 =?utf-8?B?cmV3NU5VbnZwSVU0Z0hqN1NIazdlK09FbzlsYytUUUt5dGZQQTVaSElLbmF6?=
 =?utf-8?B?NlA2eWlXKzAzZG9rSUxDL2NzWEpGbyttWjRjQjRPTEJMTkloU29LQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f838026d-47d4-4f2f-85bd-08df1b42022a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:17:22.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4nWZxULsEWMyzwd9m0R3TvGgAWuuhP/t7u+04O27ly3jqrbfU/b9Gs5uolTybfRJeFblv3HSHFkrfD+pbdsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7290

On Fri Sep 25, 2026 at 8:19 PM BST, Mathieu Desnoyers wrote:
> On 2026-09-20 11:57, Gary Guo wrote:
>> On Sun Sep 20, 2026 at 4:44 PM BST, Mathieu Desnoyers wrote:
>>>
>>> There is a straightforward optimization we can do if this happen to
>
>> Another option would be avoid using WILDCARD if possible. IIRC the wildc=
ard is
>> used to ensure forward progress on the reader side, so it avoids the pos=
sibility
>> of READ_ONCE(*addr_p) changing before and after protecting.
>
> Using the wildcard has a few benefits:
>
> 1) Prevents this retry loop on the read-side.
>
> 2) Prevents comparison of a loaded pointer value against a re-load of
>     that value, which causes issues with compiler optimizations (I did a
>     ptr_eq() patch in a prior version of the hazard pointer patches to
>     handle this).

FWIW, clang is getting better with understanding pointer provenance now (se=
e
https://github.com/llvm/llvm-project/issues/34577). There's still the case =
that
if one pointer being compared is a constant global or null, then the replac=
ement
still happens, but it's not applicable for the hazptr case.

That said, this doesn't negate the need of having ptr_eq for GCC and old ve=
rsion
of Clang. I do agree that the need of ptr_eq is quite unfortunate.

>
> It does have a downside though: given a very long preemption by a host
> VM, the guest VM could technically keep a wildcard present for a long
> time in a per-cpu slot, which would prevent hazptr synchronize from
> progressing for a long time in the guest VM kernel.
>
>>=20
>> One option would be to first use the typical hazard pointer impl that re=
ad the
>> pointer twice, and when that fails, use the wildcard protection. This wo=
uld mean
>> that in the common case where the hazptr_acquire does not race with a po=
inter
>> update, the WILDCARD protection is not used at all.
>
> So your idea is to use the hazptr load+reload approach (with ptr_eq()
> check preventing the compiler from removing the dependency on the
> second load), but rather than retry, fallback to the two-phases
> wildcard. This way, we get the best of both worlds: guaranteed
> progress for the read-side (with the wildcard fallback), and typically
> we are immune to long-host-VM preemption delays, because the
> wildcard fallback would almost never fire.

Correct.

Perhaps we can take the idea further: what if the fallback path always inse=
rt
into backup list? As the backup list uses already uses two lists to ensure
forward progress, we only need a single WILDCARD?

Best,
Gary

>
> I like it. What do you guys think ?
>
> Thanks,
>
> Mathieu
>

