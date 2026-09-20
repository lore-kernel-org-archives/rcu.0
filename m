Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171425F7A9;
	Sun, 20 Sep 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915612; cv=fail; b=AS+w92hnkz7hZQ4nQCMKJiUc6JpCmsJeYtPHezmC6G1od1nYXrk3B4Kp6sQao3rjR+w8H2dDxYUOiD7VrjD9kJAxwuchk8zbIycOrOQpjtPMcNzhLjsRJAlBiT2MeDktTjNswiVReyzDdwOEzQpzh63pUSNJ8wlxl5OpJ6ip9hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915612; c=relaxed/simple;
	bh=Gy/yjGhdlo9M+QnaFL+ZAM1QU+gFEWojRrQCQoZnLlg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=azf4Nt9e8QLlkOlTGBcmswX1UApRIkIIr9FpFkGrEmHmtsAEkkwcGaqaR40kfiH1MMnEIbsneMLOkO25DkpO/1KhGQGNSzqbiI5gzyHArdhFy4a3ceQrHt/IdunxTNkO1bwT6ajw3tydbx/ZHZIqMiDg+6UII11YmiBREKJylro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ChULMga7; arc=fail smtp.client-ip=52.101.101.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ChULMga7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw+auePq1/C2i1pccsHFycVlLe+/S2lRTetB2y0oXy+zGK2FbmFGYh30w3OEQorZntvcBxVkhC9Gm3zJUPa2wTEYX9fkMil1j11a/Zab+/6yOIxjcFqJ07UibDKHJQBxS/+DeHHqpvJEPFS2eGr7OcEc0T2H/EwjUNKqyE3bI918V1hEV7tQnlJL8ArUomdcmw7xPbv0ZnYvOXU8TQo161iU+YQCxnzkn+aotfMN8ncJrHzLgc90vJtX94/busBpc/AC3+iIjlY+Qv6bvGHNDcz58PVtN3PSb5fRl1y28j2xEih67h2o2zGELBsR0oj4Oy41Y/x6DBOtNVl2UDH70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KsV/oOmuye2IwLspLDljrtXnW+4r0qhF+OUsgK4g9A=;
 b=Geg40MI/1e2TTGhjO/3duHmE9ttWzKqyC/l/QvF7xfeCdKZh+N3WbmUzMNS1nT7Y/9TlnOooaPs7iWWnq3Mx90bJ8/dGqWrQVHfxqGAuU3bsQvDOHkqfDfFEyAf1R3lc9R/Ws21HRKuMsQV1HmhwVtAUg2zaG/0IdPTrfuh0RQjgILK7vspvKKfmMxjDJZJT7v6cOii/2HRtNxmAUBMxVZTlFEQi3d/q3De+6PAETln6DEjpXM0xfzqeFHwaLZ+azbB8cJ/62QKLm+STe0afhUFGMEvzNRXOTKrD12RMlvWoKYoVTNHum/+vPvuGhBnUhod5e9C/KdAOQl0OL7+yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KsV/oOmuye2IwLspLDljrtXnW+4r0qhF+OUsgK4g9A=;
 b=ChULMga7Mx8UlQSqqKrPG/6iPIljFORvmTZP/6UnmSUZpdHZx7k/ZPU+3WTwOYRvBzmBdLVGw3tR2jEipO0oWweQJie5dsiGQ4H4DkSxUvCruSOerM3NYljC24ZSm8jy8nnA9vePREClNlFF5e+K6x0lXHcGZMXJn3MhFoXGLY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO4P265MB6413.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 14:46:45 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 14:46:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 15:46:44 +0100
Message-Id: <DLK84KYP9NRK.2254MY7D9AU11@garyguo.net>
Cc: <kernel-team@meta.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Boqun Feng" <boqun@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <lkmm@lists.linux.dev>, "Zqiang"
 <qiang.zhang@linux.dev>, "Wang Lian" <lianux.mm@gmail.com>, "Kunwu Chan"
 <kunwu.chan@gmail.com>, "Bradley Morgan" <brads@mainlining.org>, "Bradley
 Morgan" <include@grrlz.net>
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
From: "Gary Guo" <gary@garyguo.net>
To: "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
In-Reply-To: <20260919000056.3132131-26-paulmck@kernel.org>
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO4P265MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e6209b-f347-4a55-e144-08df1725fdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RK3a94A5bc4itwwDh3QLr5PE5m7iBDMIUac4tORXRYtY99sU/VodSbpNuXZZYyQRCMpD8jIBRxCGPqgFFOrXE5iYWWpKtE4YwfotvLVUZlztd4/D74nL30dPE8DMMxJsVBe3j9F0nUuBQXKl0cndjtMwB3I29cD2cTT80OR+f2vRguBye9Myi34CJ0bNnG5GwQs+SwBdbEqT0X4EMtpDUyad1izTEDhJOrQcTvGn76ccuaf03z1HV6W9UNggDZyIQoXbMOGIU9GsludblgpbQ5Nb6vc1AqaJUS8KFLGj03YJ00NiulG+oa+T/LlJFon1w62RT9T1soKoXb176cGbpXpoQO3Bk2vq/1Y2MzF4Jh8P5kkjIBtphZb3XT6rYl5kvC6R/vffbgAArA+WcDoNONqZGbOh61t20+xQt8G6x+IefqZRgerF3ZTKd5Djwv67RCHl+Rc0BychVWWSPnnEDGwQh19PZdhRXmcCCkY46b3M99BYIZwyLQUFIpr8z3nL22Eb4tuRNbuUESs1FASupLyqUtQjQ8KGsrhQ8Uy+HuFWj19sIjuUr0QSxfZwyHS8iCLo1erGA5JOX1vB/A/OHlxkfM34atfs7J9W79yJHoY8qgWCY4TPKKy8yYg0PNWP/wcJMvOGkf8cR7ktYdr6Y87JnfTw1kr63nfAgn+6cq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2QvUnh3endHTXNyWHBRbjdNVldRUXBUWUx2bDNYN28xL1l3R2RYM0FyallL?=
 =?utf-8?B?K1F3dndpQkNILzR5V285NHpUZ2hBVWcwdDI2QjlYODZ0OXA4blVJVVNkcVY4?=
 =?utf-8?B?Q2E1c21XMWFwbEtOQTFCb2R0djBJMEpjTVpBS3RzUFUwVE5vZkRzVk13MlVW?=
 =?utf-8?B?OWdBUUZZbGtSUmo1OE9XTkM4MDVrMGZtRzZZQjQwRXd6Z1FWTkxsOGdOa1Jw?=
 =?utf-8?B?VzFWN0QzT3VKbE1UOE4vYktLekhWU1VzekV1R2srN3pieTNoS25DK1pWY0pl?=
 =?utf-8?B?RjFTWW5YMms3QlUrU1l4cXBHZkgxaVNwSE1oSEJnU0U2bHV3K1hOR083ckpp?=
 =?utf-8?B?RXdxMG9PSUcvNFdmQlY3R1pDamhUWGMvVWhtRUdSeDQ1Ym16T3FDbWpXTi9v?=
 =?utf-8?B?akxIYjRRTjJrQzBJWVNlaFJkQWRMK0tBOEJoWnBURWdpcXlOY1p0YUtrVWlQ?=
 =?utf-8?B?WnRNOFpFZDJQN3h0TWwzdzVxNWxxb0V1RW4yZDRvTWtPbUZyb1E4bGFaWG1G?=
 =?utf-8?B?WkhUTUlSTXh5MG1kVzUwRUhHL3c1T1p3aUdqRkdBbnYwWXAvV0dDU2txVlFF?=
 =?utf-8?B?Q3R6ZVY5ZnFxdHJOYXlxdzJudUtJZ240U2drRTFmajN2N3ZIeDBGSWlTWEQ5?=
 =?utf-8?B?VzVyeEVteUxreTdSOGNWVjhxMHQ3Sk9TeDJ2c0dJTFdKeENUS2hvM082dUo3?=
 =?utf-8?B?bkhPQnhwQlM2VEhnQTY1RE5NMXE1VDdjSHdGdFNPb3ovT1N4bkJPMGN1aTlt?=
 =?utf-8?B?MHBCaUUzbG1ZdnVaODhGK3NyK3JVaTlySTNvT1JWdk05OGFFT0MzeStyYlZW?=
 =?utf-8?B?cFhOd1prUTBlL1I1akV3ZkJzV25XdlllUjczeTdQY2NxbGVHOGg3eDVRSS8z?=
 =?utf-8?B?R3lxZ2wybFBpWVNTdStldEFnUnRGWXh6T2g0NVBlNGpWc2ZzeUFmUFFLY2hm?=
 =?utf-8?B?VmxjTG1waENwVktxQUVCWDZLcnE2aGdyMHFPdy8rbkZ6TmRZWXpNQlhYR2k0?=
 =?utf-8?B?dk5SWklLN3RkbXVnUDJxU3IvYUlHZG45WkFPZGVkTmduY1NhYlkyTlhFdkcv?=
 =?utf-8?B?clplaGR4d2xJYU9md2t2VE5uMGtvWnF2UXdDaFowQU9VWHZlbTB6NldrRC9u?=
 =?utf-8?B?cDBEZHBoQXhpZmx2bVQ5QjRnaTlxZ29RczRpZmk2Y0hSVGJNelh2TWdyL29a?=
 =?utf-8?B?eTk2dG9ibHdGczZEVktwTHE4OFl0UDRsRzh5TC9lRnFhemZjSC9wNEVDKzdX?=
 =?utf-8?B?emhRbkFrdCs5c2RUUVRmUFFUN1JrdEdSSnZoRlNhdllxeFBZMi9SdWQxT04w?=
 =?utf-8?B?R1ZoUVhJTWx2disrKzJuVi9tK1MwNy9HY0MwSlhUUDhkUDIwK3ZtWTJSTDE2?=
 =?utf-8?B?TkJOaFF5MU1YREp5SnFDc1BURGVkTzFuaC9NZ2U1RHVacTZLQTRKaWgvNUp4?=
 =?utf-8?B?ZnpKYkpaeXdNbm10ckRaN0Y3OUc2NG4zcDZHaVR0RXF4UDgyWENtbkhjbE1Y?=
 =?utf-8?B?VEVJVWIxUU1YZDNYSi9Fc2J4QnZtUDVzMmZTSE1YQ2dEUkMrSHlheVp4b0oz?=
 =?utf-8?B?L1VPMG9DM3FXcWVpVTlreVBHS2dVVzQzOTNNNEgyUkxaTVd4UW9HcjRabWlx?=
 =?utf-8?B?U2M5N2hBTS9EcUIvektIcldPTktQdjRCR00xOFVwT1NlNGlhTWROL2Y2MmF4?=
 =?utf-8?B?azdEN3JFaWwySUtTTkxuMENSdlU4bFlOcGtLY1hHaFFTczVXQXRzN3RVT1ZE?=
 =?utf-8?B?TFBVL0YrWTZKSCtjRWhRUnVsZ2JlWUtzSGY0cm1mZk5Jb00weUQ3Rm9YeEFR?=
 =?utf-8?B?VDU4MGMzSEJoaTdQdGk4RzZtc0RPeXpXbzZUaWQ4ak1Bemh3STBLazBiSm5D?=
 =?utf-8?B?RkU5eTdQbVlYdnpyc2YrdlVrMWRuZi9ERTBRSnp2SlBRWFlYWm9nN2c2MW80?=
 =?utf-8?B?R29TSnlic01ZSVA0VWtrVEM5SjRLSDlmcWt5WWphUFo0cjJnWEpJYzZ2RHZx?=
 =?utf-8?B?SDB0SWRwcDlpM0VyMC9QbmVzQXA5RjBTV3lvTlY3SjFpY2JoZ2NjdHRGRW9u?=
 =?utf-8?B?RnFWbTNRaUNHNG80bjNLNU9iRTVMaklPZGF3VnV1enFwUG42alJtRUxEeE5y?=
 =?utf-8?B?WmdIVW1OWUFPaTlBUzdwd0o3OGFRZm5qaVordCtLS3Jobml1Z2cyamJmU0w0?=
 =?utf-8?B?YlBVMGplcHh1aVo3bGtUeDRhSkQrSEtWaFp3cnRSNW4xMnpMZFVkcVhmeE53?=
 =?utf-8?B?SXo2cWNkTWg3K3Y0YlRObkR5K3JNdklBK1R1dWNyODlOS1BaNGpONFNqTG42?=
 =?utf-8?B?OWJtR1ptMHVsd0JDS01RZ284RlhPbkZDOTNJakJGdjYvUlpsd3B5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e6209b-f347-4a55-e144-08df1725fdc0
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 14:46:44.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFsGBO0ZFkQONjYavXwCuqEZnh2S/YVZTBjFtaayPamLCMZ185DqsQpRA//ulNmwYv0UQe1joGZci6hHjFKTLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6413

On Sat Sep 19, 2026 at 1:00 AM BST, Paul E. McKenney wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Implement a two-phase wildcard scan to guarantee forward progress of
> synchronize_hazptr() even if there is a steady stream of ill-timed
> readers which populate wildcards into per-CPU slots.

Hmm, I am not sure that I understand the problem here. The per-CPU slot is
scanned only once per CPU, and patch 1 already introduces flipping of the
overflow list. What prevents the forward progress?

I think having a shared global read by all CPUs sounds really undesirable,
especially that it gets flipped for each hazptr_synchronize -- this means t=
hat
in the pathological case where there are a steady stream of hazptr_synchron=
ize
calls, each fast-path hazptr_acquire will have a cache miss reading
hazptr_wildcard.

Best,
Gary

>
> This is performed by flipping between two wildcard values (1UL and 2UL),
> and alternatively scanning for the opposite wildcard while newcoming
> readers use the other one.
>
> There is no possibility to miss a reader because all slots for all
> wildcards are accounted for during a synchronize.
>
> As a simplification, use this period flip to drive the hazptr overflow
> list selection as well, since there is really no point is making the
> overflow list flip use a different state.
>
> Protect the wildcard flip with a mutex.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>  include/linux/hazptr.h |  6 ++-
>  kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
>  2 files changed, 74 insertions(+), 30 deletions(-)

