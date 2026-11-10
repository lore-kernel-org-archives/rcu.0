Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794272421;
	b=lzsy6nGmMgIcZs8n7VXG05UaJVzooYwd7Ieg7aYfDCBGyJ/a7x14OmOwbcyWuBubOwe0
	 E/kQCEr677Jhw5ri8shBbPadoX0fp49uCNTcwBNputN1nlAYcEtAkv2HUmzf7H5p7bVwE
	 gw1c6e+H+ifm70+AOxLkAYLig2kjvxkRkSPR0dd2naGkZQDMTU5MIM5zpRPR9TyReaq+H
	 miIDxFBTr47LwclNixYcWZKMbwzmg+QZPxMdp2n4cTv0WD1uxb3LTiJ9GxxPCaXizNC32
	 HgxCdJKjjNOXbQv9yT8cFclTPsRdYbEhBJZiaHIIBWWEqI1yZIFWQ7t6TZLevUiSN+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272421;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QxeLUwz/k2eY4j8RKgcXH0NRdAnzzCDXUYXSxE/0MMs=;
	b=PhJRwTPxqt28tzYLKeKwUENd3vIEE1NnBlQ7bZ+/+Dx7hp4c/RItKRJfat/2dbsQ2+9L
	 OosbyoY3NeZ/N936bt8tMWJzR/M00Z72n+gwdks3iNullQteAAymp9FnVcY8bpnXdq11d
	 qFKIs7g/08vyevQCe+dSSVuQcAdU3pPmffJK4NDRE6Of6fDrqHKhHNveKrFFykn1NFkqO
	 t+0bKKmJeyybmr1wNHKi1oklS/iMzz5NFCnRNHmKeI6PZMXj8NNAUbhiCXXZz2oMteZ+T
	 TykALud2uarNZGrpu0M4H9JRNDrGEGLmsuxPPthXzNTa2xfHosnwniDVyvIMRm9Qw5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Z332fGre;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.109
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021109.outbound.protection.outlook.com [40.107.192.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C28606A321;
	Tue, 10 Nov 2026 01:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C28606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Z332fGre
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg/8PK22KGF2SZqDq7kJ27WVe5SIB04e2yX5gVJDKtC0eGfV+9qxOP1PYxn2wRiybkRY+SF8Y0Pkxpe2itCgmxnpaJtvVOSn+L6Yog1134WXf+RctiWnBgDASLSxDB9Ql0LT4kBwYwquYbGF/H+dswPIuYZDAPxv5R5lZSlvEenxx/Avc8b4lLlhC6Vc+bZnSj4BZ5vRAck3ZUasPvq4lPfz0vfEA0iaseEz08G69mZqZGV2tcCsVuMTNOkT3PcMf8kw4VXEIG5dQBik1PAigkJyn45PVu1SMwolL0p1xz+jPZDmcvuE1F9oNQPdXoZUmabarauCwi2qIbnPKvR/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxeLUwz/k2eY4j8RKgcXH0NRdAnzzCDXUYXSxE/0MMs=;
 b=cb7z+8YFGTOknKks9MEC3iu353uhQakPNJjm8AKigaFSRcmZpIdQtCcQKhvlH8WoqSOJWKcDQRzeeRH/szH7BanF3X9cEZVx12/JslLVNa7NjV1A9vG5bc1Fh8clQgrntTCDyAOfnV3y5OHH0AbOjDH6V1Ah9tD9mD0gxTlu0Z2bPTq0vfbM6dM+wVlaSa3mCipFbbvVgx0mpc3lxkLSpxuYFcbjASCAAAbIFZZduPdLACEkgPqqjzTrKIEE6uStMIoKdNlJscOWXuKZw/yxb+KgYO12JhPokhD3HPbpfE/4P0Me8gErRUZGN+4MCPYn1FdXzonKm3TVClKVgmiysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxeLUwz/k2eY4j8RKgcXH0NRdAnzzCDXUYXSxE/0MMs=;
 b=Z332fGremtV+qQ2dPRvnXrz3dly8wUWCgPIlCqzu7nqONwl0NFNAkY/2a7DOhcsZ2dOBp29N8hutUJCRjODvAJ6m7WYqS36pNF6Q1Imh2ezNBymQ7EJ/mNI+tnA9+HgYGUqWgx9iAyT4Dq7knHoxndlOpWUPEPpmP9l/FbczWnQzyqmZ0sAmQsFLntPLgjw0U15O/aZrpdEwIi1CSzICdTxO5ZbSvASZq8X3H0KvI+8GBZmzzkRUT/wTguqvJVjzqQhjLaz1NQuguUZAV0B6cpzxnBjJYVTX07jUxoPaKVdlIbU0HkK78D3yaTN/ClH+twc1BJsaWuH9Wbje5RGpOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB5262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:45::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 01:00:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:00:14 +0000
Message-ID: <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>
Date: Mon, 9 Nov 2026 20:00:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
To: paulmck@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, rcu@vger.kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
 <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b203438-5bd5-41b9-12c5-08df3ec5fa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|4143699003|56012099006|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4APpNhS4J1v7Ne0lKSLk/DFS4oklWipKcegtfu9IUOYaPEJ1euC9yf20IWVmKvtnE3TaCWIMstmsAQA+g2DZTCubCEzebSjD5X74baEBdQedgnlfGZBnqh1OIGa/tMO+vgxQMuU+alaDnycnaZ47VXWwQfVP7jeF/a7XmpWlmJud4ml2DlePwMtmIWJPvGQJ5RbTPwt75fgxKENvOoJxItgjgvFOggNgFTWm3p0OVhu2WYE6CsLM6YrChu8+oeyYnafs0ApNNWwjKel7Cfx5Udx6eiEDprwlcDnhsU4EeNn+qErpB8eam+e3SfVrnUdxK0kvoCOjRmpPIbqPbHhcWjuvVVTH/0OjwHWXAd/SIVrIFLE2xY47i4YDBqHfz30Ky6sVUck45uIKnsVdcB/OkJgtcsH1VmjtO4bodYLG83WsVK2T6TIq7X9Oy71avEz1+Z5l9hOdYd7Qwf/30QRVJRvdFrFEXALqrDiy3cBiaUAkfTR/umHS8eGDaQ4SzxEF0Kfe5zPBx/QYvf0ZYs2dPYVUVTFi57Pt4U8/S42DMq3HWzFcJVoZuGJSmz9xCkr1eIJCkt5XF/LAHGLLsemG/0ur7vzPBWN5VvwcdBJ3fnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(56012099006)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0wySmpWL2UySEVKZTNtY0FITXptcCtPUFVUd2c2aWV0MFl1KzNCQkZxeXVo?=
 =?utf-8?B?U0tUY2xWd3FxLzJKNndxSGRvRmZya3dXQTFHVnRPR25Cd1gzUFhNRlJjOU9q?=
 =?utf-8?B?dGd6REhhcGxNY2E0d2l6d1Z4REpPUzNJajc0UlZqS0ljNHBXdkp4RWRBakJr?=
 =?utf-8?B?cGwwU3crRTFNVUxDNyt5OVVDQ24rTWdnQWQ2eDlWL1UvZ3lFUUxOdzhra2dk?=
 =?utf-8?B?a2NDT2ZyMHBYMU1pcnh0V2dNcjFjM1RsVzkyWWdHK1NKQTNwcUhJeFZWVVdq?=
 =?utf-8?B?YTMwcGxFbFlldm9QSXUxejIyR28vRDNFaU5ZMVVFR3orM0NxQnloOGJaZlh4?=
 =?utf-8?B?VjMwTXFXbkN3OExkKzEvd0ZqdDZUMGRvN2xIZ2M3bUNpNkhlaWQ0cFNFejRp?=
 =?utf-8?B?a3NIVy8vaHdRL29kYmRiZEpCWDlzWVZ4Y1Z3RVZsdjhZa2NEcjZYeVdKU0Ex?=
 =?utf-8?B?SVNlTFROR3ZDUzlmRExRNHBSMHRXWTRINk5iSFhOQ2lMWEg0TDN6WnF1RlpE?=
 =?utf-8?B?eFFKVUdtRUxMU3M3OEdLS2FIa2dPTFdJYXpSZXkzZXJjVkowWWhWayt5azRz?=
 =?utf-8?B?TE1QYVAvVjJ2Qm8ycmEyYWs4QkxaS3NzMFYvaStoNXFJb0ZDL0FoSzY3MXh0?=
 =?utf-8?B?TTFodjJValpBaVptYzQvYnF0WDRkUHhBSkNrajV4S1ZxSkZjYVNZcUQ1dVEr?=
 =?utf-8?B?RTUzL1RpWFVrWTFoODBiakxvWDRuOWdaU1Nrb1pzRHR6Qys4YlNMb0ZYeEFV?=
 =?utf-8?B?dU9WT0dPMVNNOWZhOWpDVGVpYnF5KzZrL0pwOTJDQVdET1RSL2RBOThQU1or?=
 =?utf-8?B?aTNyN2xvbndhZEpQYWVkUVVqbVVTd2JtSnpWdHpEVktDWGx2cFFvK0tiTG9a?=
 =?utf-8?B?WUFMQ3NCS2hmUmwwWTJSUWkyWjdjSEV1MFRFMUxqY1doNStvU1N5OGlTZytW?=
 =?utf-8?B?WnJxY1A4d3BONmg1dkdJR21OS3lKWDZsSW1xcjF6Q3BZV2ViZjhrQmp5OXNv?=
 =?utf-8?B?c2tNMG5za0FBNVk3dzU2SmdOQnVmRFp4OTVkTlJEM2tpWkNRc0RIZ25nbVRL?=
 =?utf-8?B?VWhudkhaQUVRcEZ5ejNRSC8rQ3g3bWN3UVRwaTkwbFpGSzdJdkdRa1NoRGhW?=
 =?utf-8?B?WWNOOVQ4Mi91VlB5dmROOXlhZll5VzBzM0FpWFJsWUVQLzk3NjRlNEdRV2RB?=
 =?utf-8?B?eUthUG9XT0Nnb0dTY1ZSU3pQUjd1dEZpZHVvaENINWpyWVA3UGVvcGhsNWhs?=
 =?utf-8?B?QmhhTzVKSEtkZnRCbTFKOVVldHZCaHhCNktpNjJrbGxadnA5VWtLUkRUQk12?=
 =?utf-8?B?cWs3dGtzVFFNZlpNaEFGcnY4ZTQyV3EwZFBUY1EyRW1QUHBJb1ErVnBDVTcy?=
 =?utf-8?B?RHdNTWl1UGZUR05IVmRDL2JuTksyNk1hL2ZPTkl3RHZsRlBVVDdUb1hIT200?=
 =?utf-8?B?MHJrYVdRUFFQNVNMZy9zWTVIazJaMEFTS3R4WndXOVJzTW4vcXh0M3FOSUNr?=
 =?utf-8?B?RVlRQ0twTUlQaWFNYnNYS2VIUDZsaFZrT2ExNmNhVlpMYlRJWkJJd25hd2k4?=
 =?utf-8?B?Ykp0Y2xoekVjcjA2N2luTE5aMWRuM3Nka0RIWjlHRzAzSk9VVFZ1MlRDZkNW?=
 =?utf-8?B?anRsOFAwM1k5L0hrRlVnTXNNVUZRcmRFYXRuQnd2Q1ZnTjluelMrdlJ4MXph?=
 =?utf-8?B?TXQxRForWWRDc2JhQkZiUlozYU9IOWxoVVlxZXBXL21lNzlYbS9vRDIwSCt6?=
 =?utf-8?B?SVpJUHN1QkdzRnpZTXFvcy9QL0h1RHpHNW1sV1dkRjhjVjlsTUFIOGh4OS85?=
 =?utf-8?B?NE1zZ2MwL2RMUllSQ0F1WDhzaldIZnRPNDU2U1ZENWtTN0p3a3AvTzlzK0hO?=
 =?utf-8?B?SmZpMmRSOU1JVkZQYWplR3FTVituWEVOVUJoQlNCZTZLWmt1WFZCYXcxUG1y?=
 =?utf-8?B?VHczcGJvQUpNak0vV2xWZFhyOWFpY1o4d0ZxdjEzRC8wWVdVdnoxaUJ5UHRv?=
 =?utf-8?B?ZVpkdWJsNmNDTU81SWpkMnFxL05xUy8rK1FFd2txcXZ5MGh2R1pJcEt6c1gv?=
 =?utf-8?B?V25vWUpaTFV4YWY5MnZjRXhMTkFLVitnNERZQVJrOTdFb2xOcDBWSEtwUHZZ?=
 =?utf-8?B?ZmtUOU95T2t4R0dpSFRRTG9tUDZxV215eDFZbE5XT0RGSkZLZHQvV2ZXUVF1?=
 =?utf-8?B?SGd0VVVPUVh1S0VVOFphMm9YNncxZDgxRU1hTzhPL3B6aTY1eVlxQzRhL2VN?=
 =?utf-8?B?YTNvT2JXUWZ0d0ZtUzBJcy9pem1oUStZOXpJZDhxeUpFb1c1V2d2WDVQeHFu?=
 =?utf-8?B?bVEwS0pGcWljM1pGQjhOdGpsQTlUQWYzdkhEY3UyQzJKWWducDZQOHpyZHRu?=
 =?utf-8?Q?QDDl2xjazeHLEWs4KoZ1VZ5/0Zu5PbgC0J8Bptt083lVE?=
X-MS-Exchange-AntiSpam-MessageData-1: 3xgQeSVt/KNdL0UgdW7k3ZMJRdZHfxYDmeg=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b203438-5bd5-41b9-12c5-08df3ec5fa5f
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:00:14.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIf8hXz88SrEPQD2myCuzJbD81c0C8shb1p4MP7tzdBctVEwM017THcmDhZV8GGOa1iGokqGtdSQIYwBVzJVytwR9ED2tvur+UdNQDqa8wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5262

On 2026-11-09 19:25, Paul E. McKenney wrote:
 > On Tue, Oct 27, 2026 at 09:13:17PM -0400, Mathieu Desnoyers wrote:
[...]
 >> So we'd keep using call_rcu to handle the steady-state reclaim of 
rcu txn,
 >> but use this specialized irqoff RCU domain for the empty slab case.
 >>
 >> Thoughts ?
 >
 > Atomic SRCU within interrupts-disabled regions seems to fit
 > this bill: synchronize_srcu_atomic(), srcu_read_lock_atomic(),
 > and srcu_read_unlock_atomic(), which interrupts disabled across
 > the latter two.  Maybe srcu_read_lock_atomic_irqsave() and
 > srcu_read_lock_atomic_irqrestore() if that helps.
 >
 > Or am I missing a turn in your requirements?

It fits well, thanks! It would replace the per-CPU counters I wrote
for this domain. The steady state stays on call_rcu(), so the
srcu_struct would only see synchronize_srcu_atomic(), never
call_srcu(). I see two gaps between my requirements and your
proposal:

First, NMI readers. rcu_txn_dereference() should work in any context,
NMI included, as rcu_dereference() does. A tracer or a BPF program can
walk an rcu_txn list from NMI. The atomic flavor uses
__srcu_read_lock(). Its this_cpu_inc() is not NMI-safe on every
architecture. And one srcu_struct cannot mix the atomic flavor with
the nmisafe one.

Could the atomic flavor count its readers as srcu_read_lock_nmisafe()
does? Then a reader could also enter from NMI. The code I have for the
next version keeps one counter per NMI nesting level for this. With
SRCU, the sums of locks and unlocks handle the nesting already.

Second, interrupts off. The wait for readers can run with interrupts
disabled, for example in a list delete under a raw spinlock. The
kerneldoc of synchronize_srcu_atomic() then requires the readers
to disable interrupts too. So yes, the irqsave and irqrestore variants
would help. The readers would use them instead of preemption off.

Would you prefer to add these two variants on the SRCU side, or should
I prototype them with the next version of this series?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
