Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323506;
	b=0URrGT04AzqXGnAvALVs/uRfWLhKNbJCG6dbj/HD+XxcFE3wXmsDJ/ukz1QbVHc6y6c+
	 uwbJ+cu4viz1hRO9xEHSbZZIoW99Vla3vgN2wTIKvRbXvo5E76uq73vKApFbYY0fF74SQ
	 v1sWhMwT7B/8n44eTAIa6ggYM/IEEL/Kv7FjXLgNC9PZGNWx7I8He2cKP6iDd7kv5QaSG
	 snZvonDMv5QGV113qQ2IFk/dtTX96X7Rwahh70/Q2pFPG0gfrG9AjzsBxFqLAoqbwep2x
	 KFS+Kli+omL48E9kOxvFKGWInEdiAbyC5o8m67txQnHHF3RPavYsDzHjbgNpgqAh90Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323506;
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
	bh=8ssnSa15iSeyd8+t/f9rAc/rL+fjYvYduUYhggt2a3Y=;
	b=VBEunY/9idkqe0UW6rXsJNObZdDSM9wiW2n+/KFBYzs7qbAUmPk8H26sTpKdUG8xS1CR
	 l29NHNusCMTsPVo12/su7mOHNmn/Iu+8GR4XkMOhXxG96Z9sdCNRIchqYuB/+34QBUaaP
	 eVwuWyEWnU/kUr6YAVOTd6alJYRWjdB7i7DJMaIwsPaQXQyowJYLbIscJFd8EKFGnIqtQ
	 dDQINaxQekemxu8w3/ggqMMO2BWuofr439RLnDKfdyre5kCrAa0sJUH/aDg1St1mBN1Vq
	 /Z8dNiDA/sTHVM45ywn0bi1NlksRtufntobyBxcu8LIDTA8EAUVUwBH068Kw8wwRYMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Wu+ymlmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.129
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020129.outbound.protection.outlook.com [52.101.191.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26300606A320;
	Tue, 10 Nov 2026 15:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26300606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Wu+ymlmJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl9vTzWlVVNr77QLonbilmv+IcPgRGJ/fca1aa8FJMnDOGNta8i+3kHGT9I1cdqxHul2f8fKKxDYp1CvugrvQIZCAf2fU9IgMDZM70e3MNICC94J6yscGOJ7e60U82OTTcyzUQYdUKO74Tu777jK/8Knq/tQKtHszURQXiFxElSHtqC3t31xFQSW6lZKuNp8R/X2fI5xB/Nt76kr4KqaAMRHx3hE0Dq/NJrtljywNw+3YQMJWeTFW7oKV4ZwEGVBhx6zstXWrKjbNONjl7NfphWGTswcvH9zW98fxNsqIIpyJDWQtfP9FAm81hVhZ25pCQdfNltIeaFEOo0WjxW7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ssnSa15iSeyd8+t/f9rAc/rL+fjYvYduUYhggt2a3Y=;
 b=wgTXtoSnpoWN5pC6VENNQ66p/HPABGtb/rD/kof6UR7USikcZgBDL7+Qu4u68WWT3y8aDVauBvmxbUnwrRClowChl6f+LCTKHhiOLNeOBSsvhuT6BfUHGZSZhDJ8OVlgZzUG178xAr5dnm05nBZ+8PkNzWxmzvAn1/8N+QZx49HnNissfhS8vwY1tq5Sp+7n+540jRUnN5P8rZlMUEJ8XO2hibN8+9pWfUjDyL/uVTCvUlI3Hu5OceYzL5zGsRJiOM5WsS1ysAj5UaN8Q2fKzk2zR/F7U3asK2whou835aA9PLdXUQe9jkPNysqHE1joszJU0ICOhMee3XFlx38agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ssnSa15iSeyd8+t/f9rAc/rL+fjYvYduUYhggt2a3Y=;
 b=Wu+ymlmJ7nVk9gqL8HICLAxWUVXH9PYjLfhY9eAghwcyrHaTAH8V3S9i/qmwkElZ5psClD4u7aQb/wL+2Hvm6I5oxol7atgcOsq8Rm86h6YeqRio4BGHIRE/koqjjv++kpNKYesFEUY2eEVcoaiPl7vZbJ7wa8Dr9LAVwDCi89SJTuQ+HeCx6yyaxZo8Vq9R4CmVUh+AsPGZ36N9ae4rXWP+v1PTbJ+fCVl80rpu3KdbYzKkQlc8DVA5Xfn45frliA6XkHsuiVOHNePthj84UeqjV67MRLegdYITtOmJn78xCcvUQ9WnFXsHFXs52/pAWavaw4msKkSs71a11/xMXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB6179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:68::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:11:41 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:11:41 +0000
Message-ID: <10289b55-2ff9-4317-9515-50b0915b1998@efficios.com>
Date: Tue, 10 Nov 2026 10:11:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] rcu_txn: Add single-writer RCU
 pseudo-transactions
To: Puranjay Mohan <puranjay@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
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
 <20261016133319.433617-2-mathieu.desnoyers@efficios.com>
 <20261023182218.479327-1-puranjay@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261023182218.479327-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::34) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a717a2f-dfde-4788-6ff3-08df3f3cec9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|3023799007|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261022075727099003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KPpSoV+ifBOwk4OCFCeyKmB9uopMYZddo3lLW7lPh68Krqc7ZLwl55Joi3/bTyJ7J9+GMzFAtzZ5832J7+PbBhXuwRVG/WCvBdEK44GCPPojkRDew0A3FRCsc2d3F0f5AzPvVlzrZgsuUcC6tS11jnteyj1AE+n34p2vGLpFj3NZHtnBtc6YZCVYqeJy8prgfMLacVvYFFPi3/vH57fYZSgd9lv5OdnQIp54n66+zepjf72nttifZ3i6h2ABxBtTaCh26QXAKriHTcLTivK3W+lHtIJQNO5khmfjAnbMKGCvHbgPhZ/Nq9/J82aDwNyf7TDoZAE34XWNjRUtCddbp6sBjFvXjSvfYKknj5pBNOydgZ1Rsu156mNnXjkEREl6PxFf9+Z798TUNseH7cpaw4aniSz6QAdLHK5uiFzvVPe1409EMEIG7kVK4J+Ds7eG4bFa51Gu/BYNO9G1BeUN4iTfe1t6j42UgEIr3isBo92GQnXbAbeviJiofNzdTssOM8xdkR2icOlifq4sklaxlNQAY06DwmcpSHSA2EQWKPQvyw6rao7gcQvsdb8olrsAcC3aftHMjmQqG3tBwFwIH57ILaNGm2ZKqQlsbEI8q5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(3023799007)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFl3UGlUbWlFdlluOWFzRkNJMFpXNk5hL3NYRm9UbzE4d0JVY3ZtRzd4MkJ6?=
 =?utf-8?B?WG81c09naXB5NU5NL29lR2lCU0I1L3N2b2JhU3lVNzMvRXpja2xTMFpUWHEy?=
 =?utf-8?B?ZEhIcGc1VHhQS3RvUlVhQ3ZET3ZDS2IzSHdneWZ0VGdENGlYVlREVGZocTZI?=
 =?utf-8?B?T2MzWGZlcE4vUVNKK3VneTFZamNiOFNCWTJUOTNBVFluTFpWdTZhaktHd1FQ?=
 =?utf-8?B?eEFpOEFZMTdETFlkcUliRWdwSXphSVJtRFdNSGc4R2VVK1FBTVh1bjd3V09M?=
 =?utf-8?B?eXduSUUvejduWjFjOWxSYVROMkxITnR5VEJPU3pHOVZFMlhRdzdpdmxOWXAz?=
 =?utf-8?B?Vk02am84Z1VSVEZPbUtzczdsY3FEYUdWVHhDUUlYYkJ1WjVtRThxbXUvNGpN?=
 =?utf-8?B?TGpKRVR2MGtqaUtzSDlRS282b0F4elk5UHA4NjZoeDdCOS9RSGNGRGJDSHJh?=
 =?utf-8?B?WWk4MjJlN0d0VzBTMTViby93MUQyNFFTK2x6eXFyRGtpNTd5dW13RXJqZWVK?=
 =?utf-8?B?UHNTWm1pUS8yY3NrNGM5NVN2MytZR1ExejhTWHRJYXZuT2srcTRsM0tFbktB?=
 =?utf-8?B?cTFadllZa1FTanpLUEhXd2dFLzZ0eTdDbml6eEY2c2VVaWJ3KzAvRi91eTly?=
 =?utf-8?B?WkxCNnkrRE5TNTNlWXF1THZzR2JVZlZqVGp3Y1pIaFF6Y0VvOGI0eFhKQjdM?=
 =?utf-8?B?NEVTVmpRSGhGVHN5dUtpWUtnZDFJK29oZEpMMEVCM1IrQkIvZ0hZRDBzU1g1?=
 =?utf-8?B?azVrUUphKzdXaTR0UXE4cFRGeERjOU9Vc1d3MjFLbndjcUVtd0dzaTN1TDZH?=
 =?utf-8?B?Z1NtZmpJQjZQaGF1a1hYQ0VGMVN2OC9jOVBKcTZPWWFTaGVtZnBqYjgxeldz?=
 =?utf-8?B?amtQVWtQNDZBMU1uSm43bjhvb3lOMVpIZ2grR24xY0xla1o1Y1REYWZRWUhp?=
 =?utf-8?B?c1MzdWIxa0g5bXJ6NFM0ZlllOTdUU3pmRUVQaXlqbXVOSktzbzE3WW5XN1dq?=
 =?utf-8?B?aWZheXZ1aVU4QVplbERKdnF4TGlJTkthaGtrNGE2ZzZ6elIxRmlaUG5KckpE?=
 =?utf-8?B?MWxGNS9EemtReXVnbys3ekRidXJwanlvSjZZNHlJUnVKbDlueXN0eGZUUDdI?=
 =?utf-8?B?eEJHU0h4LzNneTAybDlzdVNyVW1xUGZoQ2p1cVVrODlUVzZWcHFYZDVNUHY0?=
 =?utf-8?B?VEY1RzhIbXlXM2gxZFJvclgxYlhlM2tIRWp0Y0dFWmpSdWp5Z1RxUHZ0dFJK?=
 =?utf-8?B?UHdvUmpCN3FtaHZrSWxMajd6bkR6N25FWlVxZTREMWFVcFpUcDFZQWhVcXcx?=
 =?utf-8?B?aHd0U3hlbkpzR1dZTGdieGt1VkxHUE5nT1ozZ04xY2ZidHo4bGdyK1N2YTlP?=
 =?utf-8?B?clE4SnN6VlFLVm9JQ3QxNEIvZGc4aTV3MTJHSWZBc1VaSzhqaW5JV3NnNmZy?=
 =?utf-8?B?ZFEzaWo3bmFMcFRmdWpycDFTdWF2R21HbmRrbzUvVUZ3SGRQWks5bTFlL2JQ?=
 =?utf-8?B?K3NLS3FRUmRjcURvZjhPc1FHYng5ZEpJZEtJY2tUNFhCZ0RlamNseTJCL3M0?=
 =?utf-8?B?REJ3c016VGxtWDFXL05tUmxxT2R3N1RJWWJvaU5RT3RuTWpqV0tRbXpCR0Zz?=
 =?utf-8?B?NEZvUzhqMFg3Q0UyaUQ4ZEZIUlpQdlZjM2N1MHpQdXMzWDI3a2dmQmtPdXA3?=
 =?utf-8?B?aE9raC9lekFlZWVZaEQzdmJvekpSRzA2SnNtZTNMbXY4SFIvdmVJTU1GcXd4?=
 =?utf-8?B?TFByRXpzZURBaHRldnFtdWJMS0Zadnd6WHREZ0hTUytuV3U5d2ltVjlabW4x?=
 =?utf-8?B?cTFtWkNmM1Rzek1VL3I5dk1xREhxQnRDcVltLzlySE9DU0ZGWUR2T3hMSDJG?=
 =?utf-8?B?OGYyc1B1bnF2UlhtdmpNUk4ybGRyR1pndVJtMXJaS3dMTXhsdUNPcU9tcVVx?=
 =?utf-8?B?WHdhNWpQTnlGRDRia3lyNW5mazkwOFZwdE90b0VyWnBQSXk3cFQva1pYU0lQ?=
 =?utf-8?B?UkNHdFZNN3FtQ2lFdHVTMDB3cDhySTNNSi9yNzJtUlppZmx4ZGpiNzR6SFZ6?=
 =?utf-8?B?ZW5YSzUxRTlPYlo3OEhpRk5xQklaWnByRVUwNFdYNVFWeXFCQWFkRld0Q2N4?=
 =?utf-8?B?U2E1eWI4WU0vb2lSTVNtUmRGZEU1Um13MTFvZjFxUXhMUlU2dnhlTVgxZFpm?=
 =?utf-8?B?U2pidW9JSENmYklYbktLQkN2eFdzaGx4eHUyRHJkL0YzTFRxM01pcXlObjBu?=
 =?utf-8?B?TGFPVVBzM2VNU2trOURxaXJMa3FkZmVhTWRmbmNqci9Vck0zRmV5ZlYwcG5j?=
 =?utf-8?B?bzA3MHVsSiszSDFQSW8wMTl2eDkwbTErbUhaTE9zb2N5cHZJK3VlcjJGNlJj?=
 =?utf-8?Q?ENHm7/bXVRzAjCbu4uAx/5NtwCQBRzInM4h9i?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a717a2f-dfde-4788-6ff3-08df3f3cec9e
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:11:41.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMUvjpH1O2QqeXySbUvTIUaBYLtJIgKvvaWV9SQnLGSFSK6hMh88tOaiT5tIT2mVvuGiTbqoisSGVirSUz8IV4WK3IgQXinn9rd9dFdnD+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6179

On 2026-10-23 14:22, Puranjay Mohan wrote:
[...]
> This isn't quite true on !PREEMPT_RT.  As far as lockdep is concerned,
> kfree() can't be called under a raw_spinlock_t on any kernel: once the
> per-CPU sheaf is full, SLUB takes barn->lock, a spinlock_t, and
> PROVE_RAW_LOCK_NESTING flags that whether or not PREEMPT_RT is set.

You are right. Thanks for tracking it down to barn->lock.

[...]
> The cost is a grace period of delay before freeing descriptors that
> never installed a proxy.  I'd take that over a wait-type override
> around the !PREEMPT_RT kfree(), since it also removes the RT/!RT split.

Agreed. The next version will free every heap descriptor with
kfree_rcu(). This includes the old descriptor that a grow replaces. A
grow can run with GFP_ATOMIC under a raw spinlock too.

The descriptors of the per-CPU pool, which the list operations will
use, never go back to the slab allocator. One that installed no proxy
returns to its pool at once, without the grace period.

Updating the comments and commit messages you listed is planned too.
The atomic-context test (patch 10) will reproduce your splat when
kfree() is put back. See my reply there.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
