Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F591EB5DD;
	Sat,  5 Apr 2025 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743856269; cv=fail; b=BPHKhRtMEdYXcNp7RCjkhx0QJoy7sXiK1t6Vme+zBwKm105XG9ikzZ9ABUYiHBxxsmd7LceLSFzha8o3bXKUXahHYbdZ7O3A4Q8i1/91sGwmhxFBpcDvCJi10ScAhk9eqKXrLsqRdqTWNEV+1GnKG1kOwFLL3cBrvxaBUk8VOlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743856269; c=relaxed/simple;
	bh=i8wm2fstLXbxGc8gAXM8JOMxJOogZpwSc45ehsPl6O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hY46WE+Zv419ZAOUEojqYIPmVeTU02ycb/LFlN0mWi5Of24HLo64gt5a7TzK0ofQ33Z2+hfugJBv0U4gtng1kbTAHN9HM+5+WVzJPqonSl11W5uslqCPcDn8Nh+E53O74svbnShhttzzi0bjhxLDyg+X2i0qAhNn2RvE4/K5so4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1tm0oHS; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1tm0oHS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4UIh2cSbe7h+6U0CJ/KlTJ28Lf5gegg37q0QDwtMlm3P9JSJvTVb7xqhLvNC7ftivJDWeJzEMJJCiz+1Ee8paOvdcXzsTdJRwcsrly7E4Q/tL2FP3TOhZUSolWE58XwyuLW1UlMcgUGIovUzSEogyng0IPP0oGeAuf1yPeE+AGstV26ogF915pffAYJ7w1yp0LjzmwP99WO74unXDAcqZ8YLjoAca2Er55i04cNxVYeyO5pL0xA2Xis5TJcdakjzsJj3EMTSTZM03e4p29+5GQ+UcQBu9DKukRBrJH9thOpX4z1iE9dv/xwIfbzTXWE/KKZOWDVq0h4WM7tH7h1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PwdThN131nIQ12vps7TWJhiN41o1kDNvrtq/cERQsY=;
 b=UnHjzOcckASd7GnATysCHxtX9nuYzGOu88VRJjjSVAm9dYwZCBbguFKXY3lmA77wu/fhypKe65mFhJxqdZazdUrvpyyimXObYNrRRasSABBuTRfhpB10Fr2IAS8a86neCXqJPh7qUysQAES+0hzjdxRdMKAJq2CVHgZqx8vcw+7XQFB3zAmQGTV9n49i1yfgO5Ca+ODhmUi80/ULKlcXLMRvRCbXBiKQpkXna+HDAJr0vLNBvBScvoIh1vsgfEazXcgUg5qlroeVfmWRC3uIA3UvyhHmlwZPBQFrq3IpZ2KQVjoMe5KeUeyqEKeWCiEoiH4ZX0nfdHdXkpSokeU77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PwdThN131nIQ12vps7TWJhiN41o1kDNvrtq/cERQsY=;
 b=t1tm0oHSK8s7axVMMP6QuDP3ew1j6FqEstGYJGrqx3iQVywnjs/xRuyY75j63EYXaCBX8PL//gPkPy5sAiAHexa35IJnOkvFVT+9KwFh1FrtYeasb+WqIoCVL6DX2PkAxmcr4QPA82mOeEVSxvSj3x6alw05XBEI+zLPRIXfgXpCXOGPElKY+8ZOhvrE4hd4reXcNyPhwPet7Ha5VpkJFqyKTHE3RRkXyENknnbMuZIrnO827Jqvu/Q/r8Q5yQA6fYTQ5DeUcuTmODWCEaG2B4w1rIsi5oTIqloP8jtyh5h2yRsy2NxEmXbfR51U8haoZVsLEWvobqYqmhoZyrxlzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Sat, 5 Apr
 2025 12:31:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8583.045; Sat, 5 Apr 2025
 12:31:00 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: rcutorture: Perform more frequent testing of ->gpwrap
Date: Sat, 05 Apr 2025 12:30:58 -0000
Message-ID: <174385625883.111.5710608020798879272@patchwork.local>
In-Reply-To: <c9c19caa-68c1-4012-bd82-38a24c9edb60@paulmck-laptop>
References: <c9c19caa-68c1-4012-bd82-38a24c9edb60@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0523.namprd03.prod.outlook.com
 (2603:10b6:408:131::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0434c74d-631d-4e24-83b7-08dd743db939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFpbFl2TDFVN3hFNjYxV0NMVUtNQ3JPdVpvN1NtWStGaWtmcjNpV0g2bFY2?=
 =?utf-8?B?UUhtQWdoL0ZXME9KZzFuQ3dpOHcvYXZvakp0YU9IcmxIKzV0UGgxM1ZPSk5X?=
 =?utf-8?B?V2RxU2Q5OWF3Z0M2NGpralQvM0JPTHBseWlFWUpWV1QraWRKZ3oxaTZkeExK?=
 =?utf-8?B?ejVGdm9GWXA0ZFZuRDJCVVY5QUt2d05JM0x1bFhubGZPSHJlRFZkMFRuYVJr?=
 =?utf-8?B?dVpkWDhKRGRxdHdORlVFaEdXZ0NBeFJzR3RjK1R0N3ZQRTRhR0JENnVXY3Zq?=
 =?utf-8?B?eVlYMU5BUnFyRmFxZVkyNVgrQUF3Z3ZEU09nMXFOaHNGR0YxZmRQazdHUVhm?=
 =?utf-8?B?K1JQVFc2bXBmV1dUcGVuNjFCcEhTSlN4Yko3TWNibE9EUUZLMWpBTFZ3NmNZ?=
 =?utf-8?B?bDB5cU53Si96MU9zRGRjVUVDRHJIVkhkV1pTNmhvVVFDUHRzMFJVT2VYSkg4?=
 =?utf-8?B?T0srSUtoRk0raEhSd29xTVh0ak5vV0wvVkxYeWlCa3lkTXVlRGV5b3J2bEd2?=
 =?utf-8?B?VC9xTTE0amgySDdaVGg1R3N1ZzFodkh1SWszQTd0WmtkcElNdGlCL095TUNU?=
 =?utf-8?B?bjhvVlk2V3hTMEFUMjkzbjQ2ZG80UnNMZ2JEYUErWERaelZYTUFwRENLbHo5?=
 =?utf-8?B?WVBNa2JuNWhpUUhacmZCZTZlVUhIcGZHZHNNMUlIYVpkQW56d0c0WWhBdERY?=
 =?utf-8?B?d1pYejZRMWRNVHQ4TGxBS0h4dXcrRDBHUUU5NUNiYStFSC84MG9LcWJtdXdR?=
 =?utf-8?B?K20yVVM1Uyt4VDN6T1ZDZXU1VFRCd24raG4wSXU4VFVab1Erc2daMzF2UEJk?=
 =?utf-8?B?R3g2dFFaamZMUExRanNZZ3lJUnRyaW9zWXVyVFY2Q0J6eVpGSUJtWDh5T0Zq?=
 =?utf-8?B?aklCNCtXZExLQVpwUG53L2ZhR2RuTkV0QWhoRkxmbXNIajJYNWtxb1JlQnda?=
 =?utf-8?B?Wm9Hc24vMlJmZ0xiQVprSWJtNk5aTlFrdjdmWFM5RE9KQU5MWURXTENaQXNm?=
 =?utf-8?B?R0o1YjhjYkJHc2Z5RXRRUFgxdFdVT284c0ZodVdlUGppZm1lanNZZ0xaWEdQ?=
 =?utf-8?B?OTk0WDdqV1p3eTBFUG5UMXErYWZJVm5NbEszM3BOQ1I3NFVpQjZmTitUeE1U?=
 =?utf-8?B?QWJaaHdYTUhlWll2aE91VW1ML1Z3QmsybnFtNFlFdE1NanU3RlRFOWtkdWlB?=
 =?utf-8?B?YThRWFpidWdYTnlWWlhYY0liSjJyVTJTNmgyMzZXYTNWdU5CZVBIblJ2ek1u?=
 =?utf-8?B?TWc5OEJBUGYvbGM4cmdZc3dOU1MrQ3pmV05KdnNTWmMrWHc2REFQNXJkcGRL?=
 =?utf-8?B?RFUrMnFiZlE2RFBVM2VJd0xWbSthTlA5NlpzNWNBWjRwdUEvaGRBY1ROUWRG?=
 =?utf-8?B?ZCtNRUJ6K3NTUGNvdzlZUllaVkRZQjBCVWZqdUtFZmJzRGVNbHk1SmJPS1dH?=
 =?utf-8?B?bzkxMU5wZWpaRjRnNm1GcDl2eFpBbUxIK1dONEtqbm9POXdBWlJUMTNzMDRs?=
 =?utf-8?B?NGlXVmZaSkJVbENkWlYyYzZDN1BQLzdwV0pSNmNEU1dmQmgwaDFQMWFPOGo5?=
 =?utf-8?B?KzN2ZGZSV3Q1QUZhTXhkaXN3T2pnM041M1A1ZGM0VjlMcWhnTkZPalIzSzZX?=
 =?utf-8?B?R0p6eG03K0lXazcveFYxSVBpVXVqcEkwODFKR2xidzl1WHJrWXhvNlBWZEFD?=
 =?utf-8?B?MHBDdkN1ckw0ZldaUE80Q0V0ek1FMXlZZnByTkJNRlFZOUlqOU4xTy9mYmJP?=
 =?utf-8?B?dXU1eC9iT3ptMFFCRFE2ZFFnOW5uamJiMDZvMitHa2cxaUtmaUFndGZpamhx?=
 =?utf-8?B?eUxQUFd0Q2R6aU83UTV0YjBxRFNFL2xENFFMZEE1RGlOMkFlOUxac01VakdF?=
 =?utf-8?Q?yXNKwKYlZMRje?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFlPaG9FbkxBR0Z6R1BBN2xBclN3OUFxRmd0UUx2ME9qUVUrenhGUGNkaGNr?=
 =?utf-8?B?TGx4R2kxRDhjalpFME5kVmRwRnZQVkRDYXg0L2RNWk5TMEc2MmQ4T0xpYnk4?=
 =?utf-8?B?Z1V5QWRYTFZhR05XN2dnaStQV2NVL3NXNmJmNzBYc0hNSjF2KzFMZTVobnNU?=
 =?utf-8?B?eHRQaFZQb3J3dnU0Z01WNmw3cXc4UFNFNUt5cWtGYkV2MEpTckZsU0NVM2Yw?=
 =?utf-8?B?em5vbEo5ZHhaTU05SlRwR2QzM05OaUphZUVmTEdzL2lseVFPRzNKQkZpSE8r?=
 =?utf-8?B?M2RyN3hVVXhvcUNEUWRJbTdhVUpkenBMSWFLWHlaN3VMblV6ajArcm1tQ2g4?=
 =?utf-8?B?enFLVkdKeXNqb1N1a3MzUlRtM2dSb3dycmdJMHowVjVtVmJ3aVpzVUU0N2pJ?=
 =?utf-8?B?Nk9mang0bm5XMHV3dVRqZ2hlaVFxK3diZGU0WmkwMjUxaWdmRHJvUEs0R2Fx?=
 =?utf-8?B?MkhBWUpaaFQ5eUYxUkszOE5jQ0tyMGI4MGFGaFlONE5tTnZEbWM1QlhSTktl?=
 =?utf-8?B?UDdaNTZRbms2Y3pnNjkwb1ByS0FWWkRrcjZWSWorM0pwRVBodHFGMkhCeVpL?=
 =?utf-8?B?U2EveEhna0pGb2tXMTBCeldQR2FiWFhGaWprNXhhMURRQmlSNnVQd3NtS2p4?=
 =?utf-8?B?ZVIrenV6dVRWWFFlRW45MHJVR3lZVlM1VWM1Q2UyUEhGRXZINGZjRnlPTldM?=
 =?utf-8?B?V0xRV3Rzdjg5N0JYQytFM2FieDhVZUh4KzZaR01zYmpwcmVpYnNNTTdvdHpQ?=
 =?utf-8?B?L3I0TTdzZ1g4N3lvVTVSbXNTLzNGL3ZsdEpoMU81aUwvd1VwZWRCN045cUd2?=
 =?utf-8?B?NDBkMDRYZmJ1a1RMcFZidFFMbmo2Qzlzb2RvTHlaTXlmaHpuei8zSHVmdkZy?=
 =?utf-8?B?a2dkeUtEVDJFMkZsa3lwS2pRcFBIamtJOXI3VEFQMmE4MFZmczY2d29NdzVP?=
 =?utf-8?B?S043b0IySHpwK1pKRi9wRGFicUkrbTFXK2M3Vys3ek5rTzNiVXVmaDBzamI1?=
 =?utf-8?B?UVBWODhLcGNwZHV6d1FjN25BejBUa1J5WlJ6RGJPN1YrN1hXblZScUJxWEtT?=
 =?utf-8?B?cXhZU0F3aEczaWlqNXdGcTFRRkV1OEp6SFJHY2IramJkZE0rNGNVZnVVNHdy?=
 =?utf-8?B?SU8zUWFqV3ZMRnppZ2JjR0ZyNGpMRVQ1WDZXTitXd2cybjdoTTVMVzcwcU9h?=
 =?utf-8?B?elBzZkNGUHR6QmUxekIvTUFJMHFvSVZjK0J5UW5zYUQ4WmVTaG84NVQ0amFZ?=
 =?utf-8?B?aXloVWY4eU5rMFI5OXF3UFhOa1lTb1BtWFhjNTF2ZVRWdDVSNUxHUjV6ZGFS?=
 =?utf-8?B?RTVodnErV0tzTkRRaEpjRml6S2NNb2dzejRVWFFxaGFhT25hckk1WjB1NzZP?=
 =?utf-8?B?QjBacGdYNE9rVm80RW1MVmRYN1FCcFdzN2RjTno3TnFMSEdJbG5hSEt1ZHMy?=
 =?utf-8?B?SmcxN3VjbnJHYWppZm0rUC8xZGZmaDhPZmYxQUozdm1NTStSSm45Mm9CZktC?=
 =?utf-8?B?dDlQS2hsbFRncmVNRXNDODFiWlpIWmVyOVVoM0ZJLzQ1Vm50UTQwbXZUK2dL?=
 =?utf-8?B?SWhtdlRtQ0dGejNyZjNnMEhWQWtnM0ZYNzRQaHdvcDc0K2JWVnM4V0htZGU5?=
 =?utf-8?B?VmNLc3BINGowVXZiRXh4ek9MUDE0Q2ZFY1BTN05qS2lQMmdMY20xdUhkYzFu?=
 =?utf-8?B?c1krMmtVRDA0Q3NUcTFSUHUwdWt3SW96SEdhd3ovK2dnMnFJczJpV2pqa1FS?=
 =?utf-8?B?a0VKb2dpZVp2NnBoMjlvZldlOFlEcUhWdkxBUkdnNUhkcjBCaFV4YUI3TUla?=
 =?utf-8?B?QzBCL0hvYWxkaktiK1dWR2R1Y2I1ME5pa3Z1dWc2d0p0UDJzY2E0NEpOeHVN?=
 =?utf-8?B?QVpOaFFncm55YmgzUFNSdUt6b3lHTW1KNjIxVHY4TVMxenRNeHJmdWVYM21W?=
 =?utf-8?B?dTZmb1JGMTVOeVVlUEZVMEM4QjdUNzNyNjF6Z2JXNU1zbTEvUFhCblRvWmFy?=
 =?utf-8?B?V292d1p1bkVHeEdJUkFXanZkUE5Ka05iWXlUQTZwY0hWdVk0anlXZnBKeXht?=
 =?utf-8?B?SnoyaEZ2WWIvQzIrZWoxdlpYMlJvTzE3YXoxckxZWjRCVytyRTI3b0ZUNCs0?=
 =?utf-8?Q?0V70pmRPYOn5ej+L7vl2z6wFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0434c74d-631d-4e24-83b7-08dd743db939
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 12:31:00.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/QRWWFfKy1yetvSiK91o0jArcH0l6uVFjCHRirEIQdji+ud5w5OCPn1BSK/2ebOOqFYWm5z5/J3jO6ZeLqf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

Hello, Paul,

On Sat, 5 Apr 2025 12:26:12 GMT, "Paul E. McKenney" wrote:
> On Sat, Mar 29, 2025 at 07:01:42PM -0400, Joel Fernandes wrote:
> > Currently, the ->gpwrap is not tested (at all per my testing) due to the
> > requirement of a large delta between a CPU's rdp->gp_seq and its node's
> > rnp->gpseq.
> > 
> > This results in no testing of ->gpwrap being set. This patch by default
> > adds 5 minutes of testing with ->gpwrap forced by lowering the delta
> > between rdp->gp_seq and rnp->gp_seq to just 8 GPs. All of this is
> > configurable, including the active time for the setting and a full
> > testing cycle.
> > 
> > By default, the first 25 minutes of a test will have the _default_
> > behavior there is right now (ULONG_MAX / 4) delta. Then for 5 minutes,
> > we switch to a smaller delta causing 1-2 wraps in 5 minutes. I believe
> > this is reasonable since we at least add a little bit of testing for
> > usecases where ->gpwrap is set.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> I ran this as follows:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10m --configs "TREE01" --bootargs "rcutorture.ovf_cycle_mins=7" --trust-make
> 
> Once I actually applied your patch, I did get this:
> 
> [  601.891042] gpwraps: 13745
> 
> Which seems to indicate some testing.  ;-)

Thanks a lot for running it. I am wondering if I should check in tree.c (only in
testing mode), if the wraps are too many and restrict testing if so. Otherwise,
it is hard to come up with a constant that ensures the wraps are under control.
On the other hand, since this is only for 5 minutes every 30 minutes, we can leave
it as is and avoid the complexity.

> 
> Additional comments inline.
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/rcu.h        |  4 +++
> >  kernel/rcu/rcutorture.c | 64 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/rcu/tree.c       | 34 ++++++++++++++++++++--
> >  kernel/rcu/tree.h       |  1 +
> >  4 files changed, 101 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index eed2951a4962..9a15e9701e02 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -572,6 +572,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >  			       unsigned long c_old,
> >  			       unsigned long c);
> >  void rcu_gp_set_torture_wait(int duration);
> > +void rcu_set_torture_ovf_lag(unsigned long lag);
> > +int rcu_get_gpwrap_count(int cpu);
> >  #else
> >  static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> >  {
> > @@ -589,6 +591,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> >  	do { } while (0)
> >  #endif
> >  static inline void rcu_gp_set_torture_wait(int duration) { }
> > +static inline void rcu_set_torture_ovf_lag(unsigned long lag) { }
> > +static inline int rcu_get_gpwrap_count(int cpu) { return 0; }
> 
> Very good, you did remember CONFIG_SMP=n.  And yes, I did try it.  ;-)
> 
> But shouldn't these be function pointers in rcu_torture_ops?  That way if
> some other flavor of RCU starts doing wrap protection for its grace-period
> sequence numbers, this testing can apply directly to that flavor as well.

These are here because 'rdp' is not accessible AFAIK from rcutorture.c.
I could add wrappers to these and include them as pointers the a struct as well.
But I think these will still stay to access rdp.

> 
> Then the pointers can simply be NULL in kernels built with CONFIG_SMP=n.
> 
> >  #endif
> >  unsigned long long rcutorture_gather_gp_seqs(void);
> >  void rcutorture_format_gp_seqs(unsigned long long seqs, char *cp, size_t len);
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 895a27545ae1..79a72e70913e 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -118,6 +118,9 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
> >  torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
> >  torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
> >  torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
> > +torture_param(int, ovf_cycle_mins, 30, "Total cycle duration for ovf lag testing (in minutes)");
> > +torture_param(int, ovf_active_mins, 5, "Duration for which ovf lag is active within each cycle (in minutes)");
> > +torture_param(int, ovf_lag_gps, 8, "Value to set for set_torture_ovf_lag during an active testing period.");
> 
> Given that "ovf" means just "overflow", would it make sense to get a "gp"
> in there?  Maybe just "gpwrap_..."?
> 
> "What is in a name?"  ;-)

Sure, makes sense I will rename.

> 
> I could argue with the defaults, but I run long tests often enough that
> I am not worried about coverage.  As long as we remember to either run
> long tests or specify appropriate rcutorture.ovf_cycle_mins when messing
> with ->gpwrap code.
> 
> >  torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
> >  torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> >  torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
> > @@ -2629,6 +2632,7 @@ rcu_torture_stats_print(void)
> >  	int i;
> >  	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> >  	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
> > +	long n_gpwraps = 0;
> >  	struct rcu_torture *rtcp;
> >  	static unsigned long rtcv_snap = ULONG_MAX;
> >  	static bool splatted;
> > @@ -2639,6 +2643,7 @@ rcu_torture_stats_print(void)
> >  			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
> >  			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
> >  		}
> > +		n_gpwraps += rcu_get_gpwrap_count(cpu);
> >  	}
> >  	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
> >  		if (pipesummary[i] != 0)
> > @@ -2672,6 +2677,7 @@ rcu_torture_stats_print(void)
> >  	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
> >  	pr_cont("nocb-toggles: %ld:%ld\n",
> 
> The "\n" on the above line needs to be deleted.

Ok.

> >  		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
> > +	pr_cont("gpwraps: %ld\n", n_gpwraps);
> >  
> >  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> >  	if (atomic_read(&n_rcu_torture_mberror) ||
> > @@ -3842,6 +3848,58 @@ static int rcu_torture_preempt(void *unused)
> >  
> >  static enum cpuhp_state rcutor_hp;
> >  
> > +static struct hrtimer ovf_lag_timer;
> > +static bool ovf_lag_active;
> 
> Same "ovf" naming complaint as before.

Ok.

> > +}
> > +
> > +static int rcu_torture_ovf_lag_init(void)
> > +{
> > +	if (ovf_cycle_mins <= 0 || ovf_active_mins <= 0) {
> > +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > +		return -EINVAL;
> > +	}
> 
> Why not refuse to start this portion of the test when testing CONFIG_SMP=n
> or something other than vanilla RCU?  No need to fail the test, just
> print something saying that this testing won't be happening.

Got it, will do.

> > +
> > +static void rcu_torture_ovf_lag_cleanup(void)
> > +{
> > +	hrtimer_cancel(&ovf_lag_timer);
> > +
> > +	if (ovf_lag_active) {
> > +		rcu_set_torture_ovf_lag(0);
> > +		ovf_lag_active = false;
> > +	}
> > +}
> 
> Did you try the modprobe/rmmod testing to verify that this
> cleans up appropriately?  You could use the drgn tool to check.
> See tools/rcu//rcu-cbs.py for an example drgn script that digs into the
> rcu_data structures.

Nice, will check!

Will work on this and provide v2.

thanks,

 - Joel
