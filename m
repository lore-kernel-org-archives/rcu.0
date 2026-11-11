Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426044;
	b=GBsezmkDaY/XJOqbtOs+b/5WZOK6HlUUGQULa672tITQzH+SpfqXjqwgffofLrpLUppd
	 pVvzwko8ZWk5+qUPGvQa7V4u+Z3MuG9Z8dfhgA3UgEruSdh1J9vVSZaKBUr5vEMIu4SDy
	 XgqL2SvMH51UXcjDgDY7Mwqk3wKmeyaoznMXxjN1aPAyfA4+gzK4WlL3l1H+GdP0Zroro
	 LbN3VLhGlgwQdR3h1OuAZnk/ZMcrGDdK0XHmiOc1FgNradwuC7saTrogvI8KHpMbUzkgS
	 wmxHF5+npf/sZoaVeYRCY4qb11mhLAp+KuKSuq6x9meTcEORgzPGVdysJTtBU3Fy1rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426044;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WP0cE8WjmIrevco+KbOKhE0slZ+RtPcih1peDujnq0M=;
	b=5G2/KS6uQ0RW3B2dtZZtwa12/OLroQBYfKUsE9Koh0F3eUOuToMHC5grhqF/l/wi8f1q
	 fd7N09o9ta2r5xEOpdIUOjnp6prE3sBsIuQuNhHyWp3wRpZQpkXyUIS5oCSEBHn1HkSYP
	 dLQiD7JqP7BrZA72QhGP5o1pjDc3hfRzetKBs6THAhKL0r+PkxYR9XmSm4OlfTKSZ9KbL
	 zLz7CDAoprmKcSDp2IRt3U6G2Eovhch+kgW5OMXmX/tDAph2fgaCh6UrbqC0PetytmUDe
	 lJ/w/7V4RbaRNzQdooDUnvSrl+9/KcZMB78BqJfBqyBDcc1v79yoMLnDiQpB54rpZPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=miAansDu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.122
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022122.outbound.protection.outlook.com [40.107.193.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CF60700BD;
	Wed, 11 Nov 2026 19:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2CF60700BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=miAansDu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlqy0hGFyBYg6yTaVMRdquUL+eCqvMWReEyDB/xxfkF+aFq2sJ+rwkfz+ePkB0Rtk9pEYp4b5GLRYVr4fXt1Orlxnaugvlxbl3Oy6eWyGYwZbOjQt5GOPaYtQFCMm9bVvEFV61tqCkvQSdpl+MqFHGUBX/gBehL6x2G93T0Qt6+G8EoVSTY5pFZtExfJC3NvNQm/VeXD+Tmw6HnNNp6Tb/JfqJxTv1jfObMCPi/juvM9dG7k8j40zxlQ2EHwg3Fhtqge56goHVo0+qvhnXYCYNilILbbQPzuI9mp+l9Y1rVtEAOqSTmdkFtrvAd1mxR1lDd9Wf2MTUq3B+xC17L2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP0cE8WjmIrevco+KbOKhE0slZ+RtPcih1peDujnq0M=;
 b=PrRycyenVQKM7e0lQW6za+fsGSl9i7zdnmTVu+N2f+F2dJRi4UCbrgK7qa5XEH8w4PV6Hd+aHCXjqWWPxGkr0GYcAx5QsHZlpc7V5i52Jw2zv6OeaaVjcO8XNDJJXSLDYeo2WC2cxlGiBGuVEuMQXE8z0bfIixDWk5fAqMjDLg/uAlzRzj0sljaWnSZ+klQa3TeRvVuVGsUxKEFsxoQEcWvSP2ydtwJZKyoz/2fbLbbYlTJX6+f4uqEGyDRo2FcBLTSBvVc38EyFm2+kL0SwrcGXY/s80yN3TkvUdHII8CC2lR8NvM6Hnkzk3ZLvdA7rUQdbiXF4WpY7nyFiy5J6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP0cE8WjmIrevco+KbOKhE0slZ+RtPcih1peDujnq0M=;
 b=miAansDuCe1ku0cZEWtWEQPCXumtADUY+G+tzZtNMyH0er2KQzBhkptIFIieOkJLDzvTwsObdSU5aPaocuFjeOyUbLyLFFGWh7X8a7Ul9uCqdm5bZ+yj/mdiI3wKC5taVLOy3JdF2T+C0kM3nIdmZpO4z6ggtm+jro2SynS22zQ1YLQDmLoDQny7B5Bl+YPEvkR20ITVWGmq1p5wEiXPA9rO+PIadxJSFPRYf1mUlB2m6ss5SSYCCYB9x2jl7qBXJQrAKvOhQcWs3DXOzwWEfHMFaZ3LL+xscYlJzWeE0Hw0OodjteTi2sTcwx5/lSVIxC4lstd6WbZkfpNLjH3hKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT1PR01MB8652.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:c8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 19:40:37 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 19:40:37 +0000
Message-ID: <5edbc292-0004-43b7-9371-c3695afd9128@efficios.com>
Date: Wed, 11 Nov 2026 14:40:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their
 irqsave forms
To: David Woodhouse <dwmw2@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>
 <0782c3e7-9766-440c-b21e-e89b822927ee@efficios.com>
 <a8b4f18d81397124690a567b6a42da83ef2bc757.camel@infradead.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <a8b4f18d81397124690a567b6a42da83ef2bc757.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT1PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: a749226d-8568-44ff-b58b-08df402ba8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|22082099003|18002099003|6133799003|56012099006|261102123227099003|261009223027099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|10067099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	jpCdCVpcir0OHoG3wrZ5viWjiSYYck1a3jc5cVZjWONwHLRMGlNyrkH/rN3PRnNcT3U2mGcTcmcqqtnKSas+UHTdGrWL/gmOvYKQdDT7i2kvTL9y2b7cGWGzWgSli2GWxENii/XjAUUi6m7D7VsqfSeMxS8oKccgXoCh93HVRf+i/bnrEbpdaG3RSBidcWnxGknoguFNbbyl9I3JFtUvW1tl8NygEmSrVIAyTM3J4o6gKD4Wn4y9ESdQ5SiOYFtKfvFwrXhNNc7YKOY9YMQtavimmmx1TTXZmt3TDxsFo6l7HfYt5HmhzykRxdHs/Hx5YOMcfY+AUGloXRHI97vADuEp8shOERTmD4p2EPuP3i8cdnlLLzKVEEDsBVZTtcVdETn/OL+SFnWUbKlXZ84lBTYeqKUW/YZz7DHO0Y9TJqNaOSWdKvyOsRBNJqEWC6yFxq37rga4MFmM5aOgvzTavuX+bPKXPoaqFSnaUnAlabUWokUXxfiyn3RxCtW5nGBhDSAsQGU2N5ys3UXE94tHzty4Js3SKAa3XZr80qsbQ3RmR5cENEu0UBZCqJgQDWlEEfmDF+zSdOQGBwoxkXQxLa65QDMyVE/59/iXo0xs738=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(10067099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTIxSUNDZVhFUnMvay9WekVPSFhyUlBybkNIVmE3L29iTWdRVlR2OHI3Nzhs?=
 =?utf-8?B?TGRTaUJCNjZqMXJZTUs3QjNSTmRDTmVUNktKY1Z6OHZmbVB3cG5meUZvZldi?=
 =?utf-8?B?OXdMcEViQll6cjNpTmJJeGxVckdLRVoxWnhyeDNEV3pLQ1RIb0Z4c05sY04v?=
 =?utf-8?B?RmpTYVpDY3lscnJRNXRxQ2RVUXZCR0dqMUMrMjVoVFA3RWcvemZnSmhWeTJX?=
 =?utf-8?B?VElRYU1FeWZEY1EvMnF5WUc3Y2ZWYWdnd0kyem8xb2JKTDUzdjZTdVVHVkZC?=
 =?utf-8?B?TkpKdVJ1UU5Yc2F0aFpvd0VBS0MwQWVzc3hid1k2MktHL2EzbVlXYjJ2ZGMw?=
 =?utf-8?B?bmRseGxETENyYkVUVlpDZWlFYXYwSzJEdGg2YmVyWWx0QnBxMmFtMVZiNWRN?=
 =?utf-8?B?K0k5RVlUcFdObmU4NkZ3dG5SZ0d6NGs1dVp3K2h2eURrTTZ3Z2cwaFlMb2JM?=
 =?utf-8?B?bHhpaFk4WGUvSHhRY3V0elQ1aHVHTFYyclJWOXkrdWhmeklwQUozYWcvcEVB?=
 =?utf-8?B?ME5EMlZrZHBWUmVoai91akIrVTJaUXNsYk55Q3Jjalg2dHppWE80T1l3Tmw0?=
 =?utf-8?B?aXlYOTJJUDFMbnpVSjZVZkRNaDZac2JubXFna3QwRVJQdmJkamFIdWdLS0dO?=
 =?utf-8?B?dWpRRzU1UWIwdmo1TC9QVGZENCtDaENJVlJ6cmtQZEVTSFJ0ZlBWamlKbVRt?=
 =?utf-8?B?cnFFZkcvUnpCUlFCVllidzhaaS9CbDltQ0h6M3VVOXB4d1JzSjJ1RFkzK2RG?=
 =?utf-8?B?Y2JNZG5QRzc5OXlHWHpHVkc2K1QyR3d1Y3ZpYUU5SFFXRWV1NVkxS0lKQVky?=
 =?utf-8?B?VnZ0WnNMWk9NWGp3MjFtZFhrOWZlRHlvRDlRTEJvRUdBbnBSSFNEblhaa251?=
 =?utf-8?B?b2hBNmsvWHZHeURLa0gxcVJBQXRjSHpmNDY4R2Z4S0wvUEV1STlVRFZLSE5x?=
 =?utf-8?B?UlRFSi9haVAvVVJOVStXT0tzVGNHN1lMUTZOczU2d2kwa3NqM0hvek9WOWhO?=
 =?utf-8?B?V2c0ZitVU2NXNUJTOEdJNGM5RFlkOHhFTWlJdzIzUlFCakVpb0RWUWw4bVBN?=
 =?utf-8?B?aFNDQkIvK1pZbHhKLzNoVURvUWJaYkJzMkNnaGZoZjlsM3VGcDUrQTFsUUc5?=
 =?utf-8?B?YjZjNU5Oc0dwcVBOVnN2bkFZVTh0WU5PZ29jb1JHaWJOOHFIS1VHa1dGR1U3?=
 =?utf-8?B?NmZhVG93aU5kRjR4L1hwSkRIUGp3NDB3cHNWVERrUFhsSitIQWJPaHlRZnpS?=
 =?utf-8?B?dFdwbzZZSjlhM0xFQUhsOFN4aWFsalFOMWtDOGJUNmJ5Ukhxb2NyR2lTRFdO?=
 =?utf-8?B?UGEyYmZDenlNUDVIME5kOC9YNzFyMEJ0Rm12OTBtUm1zUWFEOE1LbEUwVzFq?=
 =?utf-8?B?ZnJRNUswVmc0eHE3aFQ3MW1RZEs2T2h1dHZ5YkZtRDhoa21KN0lCVVhOdHph?=
 =?utf-8?B?K0I0UGhOSTA0OWMwbkt2RjVEUEdHNkM1dFhwUVhlbElWSGY1OUlWYWNTMWJu?=
 =?utf-8?B?VTlkMFVqazdVMUswSjFldVdHRmRROVVPbmdQSUJMOEhhNHJWRFZIaEdRNEY4?=
 =?utf-8?B?b1Bnbjk2Z2RPdFpMbEM1OEo3Wlo3ZXJSYnJIdFZiNzdTb3dVWkFGdDlrSW9v?=
 =?utf-8?B?REN2NUpLeS9QZEhKMmxzL0UyQzFyeWd5OEZOWTNDVzg2ZVJnMW1DTzQvZHhY?=
 =?utf-8?B?OXU1Sk01c25qQno4ck5ab3h3VmlmMTVSbHBoRzJGbzhjcGNvWG1NRldZblcr?=
 =?utf-8?B?c3lZVGlvTFoxclJMalpOYXl2OEZVWjZYdVpMbWR6Rjk1NzBWS3F3N1dKdW1B?=
 =?utf-8?B?YUlBaldremZ2UTVVQUxBZmhVV2dvMXVlODlGYWR0ZFpPUElYaVB2MExPL2NZ?=
 =?utf-8?B?Nk5KYzJOZ3NFS0dNOVUvbUprYkJZcmZweHBaOHYwc1hZMEQrdDJXdWo3bWZP?=
 =?utf-8?B?Y3lWTStPVXNKSndWei9XZ201WkxSRmJxN0NMam9ZMDlOUkxEVUpIMVhVK21p?=
 =?utf-8?B?SUE5THdockF2cVhqRW96dGNPVmNHOVduOFVLVGc4ckdWcStpeU5XWU9IWHdq?=
 =?utf-8?B?cXdkallNNVRWS0dBN2dHQ0dXZk5pZWNJVjVJMzUzeXlPQ0FVNjRQYW1sT3hv?=
 =?utf-8?B?Ti9XTHBvbENOTmVWVjQrMVYxZU9CWWdDd29KL2VnVG9SWEtIZjMrY2NvR3FL?=
 =?utf-8?B?WEZVSkdtL2FHb2laaUJCUVIwWkdUVkJ4NElrZlZEL1BsdmdZUnFsMTFJT3E2?=
 =?utf-8?B?eURMcDZMNUdRTGx5ZnBsclVta1dicEhqZU9ydWpBL1lKeTYyNkxoWFRkbmpq?=
 =?utf-8?B?R1F0eHluL2NVZ0xQd3h1SmY3QTV5U1dUTTlEcC9ucjQ0dlB0MThNZ2Z3N09Q?=
 =?utf-8?Q?RWwatamlpsSHOQ/yvPhJIAClnY0GGYfke9V+1?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a749226d-8568-44ff-b58b-08df402ba8c6
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:40:36.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68D1PxKBYgjcpUEzlcDCQX2GbIBi9VJqkoUunHU75U1VG62yy24E+5eh7KLGIO6N1Aoo2XCbW0s3lKDItccJFQosOtiob3DnvEzkjwPwihs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8652

On 2026-11-11 14:37, David Woodhouse wrote:
> On Wed, 2026-11-11 at 14:33 -0500, Mathieu Desnoyers wrote:
>> On 2026-11-11 14:02, David Woodhouse wrote:
>>> The latter claim is only true in __srcu_read_lock_fast()/_fast_updown()
>>> isn't it? Not in the atomic-SRCU. Unless we do something like this on
>>> top?
>>
>> It is true for the atomic readers as well.  Without
>> CONFIG_NEED_SRCU_NMI_SAFE, include/linux/srcu.h defines
>> __srcu_read_lock_nmisafe() as an inline that calls __srcu_read_lock(),
>> and the same for unlock.  So x86 keeps this_cpu_inc() and smp_mb().
>> Your diff selects the same functions by hand.
>>
>> Only the architectures that select NEED_SRCU_NMI_SAFE get the atomic
>> increments.
> 
> You are lost in a twisty maze of helper functions, all alike...

I guess I had the best mentor in that regard! ;-)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
