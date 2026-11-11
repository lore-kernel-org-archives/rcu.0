Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794406242;
	b=lcnoLRuFMMZrmsrBKZTNRUU7SXWSeF2fKC0ftq4aQXCePt4LY1u0YdDbD/z60xjcisZf
	 HAooIUKlcTNka7yh16NXWmuqduY9mLVmOlYcScHCXfaInaF9uoqBoiVfeSurkF6AF55Le
	 S2dJFS9OI2DU2AFfBwobdRAidwIi6vI1lv66tpKk57ASxP/1f60cnRg6FtdmjWFSvYR0I
	 gbNFpKrdMDc4u233fDvRLRbRXSy/L49+7WKQ5f/8AGveRDJQ5oz1o3rc+IaCPZs8sIuV5
	 IG06MN3jYsrDSHLyVMxjt1TGEsf3WntJULRIso7TFehjudhhy3HUzDa6pf4kD3Gg3WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406242;
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
	bh=xciVJSnV5F1ezlvJN2uLB4v8cZPFRgysUkH00GuICPU=;
	b=q6Nw1GHkUjW1vx8AnY+D0xF4yw8w4fRiCt3JYvvjyT4UGoKq3uq5+UTDbbWL2WOnGV7E
	 F04mglCstEIlskL4v+oaHkE6AdQBBbwLEGojVTPKSwfYsCrCxrNCDfqT2KUJCyrB20xhu
	 oG4rjN7Cbvig7cjJOUctmrped+LCKBy6C8VxS7lGM8Ew9oGVKr7oK5G5sMuGwdb7VTDuL
	 WTkjSpxUQ7C1uALSxXBDhdZFhsA67zl1d1b6m7BjPrjxwSjKLExauQ8mteFWucjQuemt7
	 TFT84od4JrbgUOlJF6zqGcMJPGwcSnXPem+OxGUcobiuzEYREGby26UEvaPJ+VTU/Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dy80FJwm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.114
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA39606A321;
	Wed, 11 Nov 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA39606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=dy80FJwm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIFjXgp6zQVgIyr64MWBNf9NaISOFvBwIr/TAhTDPgTNlX4Sl71ZqbPGUwU7gAt/FUfoQlVNWSu3q2dWbTt5HjlEe0p04JKlHcodjNTDMS+dWM89moDZu7JffAPPrvwPRWQ0JcEmIn2UEu5485y+aepiC1V16+I+OiRkJjApGzpzT3zn8ZtSY5d0UmBGXp9Gbmy2YNZsrhiuav6u8Dh83if6qr3ONDKSVeBtQ6Onm+7frQM5k12qbcYxf0hlH5oloPmUnQAjeTHhUV8D9YG/jMHEGkXGB7/wYeZQl1Jxp8bOkoc+CGtnaJHvCz+kc/uy48Ah/x7f+NyQqvH0nEE5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xciVJSnV5F1ezlvJN2uLB4v8cZPFRgysUkH00GuICPU=;
 b=wcG5mimlFA/FrEs0Npw0yZtDxW3f28ua94YcezfxLCvFk9vmOz7XLXE5zuY+OKsuESjBidHFTgkD0lWQiN2iPK/E0ZW0dyMJYikd+WFbYHBgFgpXmL3VJKjRZSQm3IsBe+52Mye7VTiegiuUmA/3aXFOGBci05lKnjfYpOBZoiOkfn3qIIDYmSXX6WWY28UZzaoWaCbW4ge9/LG89NJPqOWQnZAIz+Ci0xLagawpECp7wGrDU3y0K6ikp5XNcs1tbb6eXXYGz4oNhEwXasBTzydZTgPmI1ct7OOByxmHP/bcvIcOi6Be3EQf9xDp4kEQCCgrYvTKrD2tPakFNJ+T7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xciVJSnV5F1ezlvJN2uLB4v8cZPFRgysUkH00GuICPU=;
 b=dy80FJwm5rkkgeARvYy28e6OhaNtATz4/r1T5VBxP6bszzHRAQqsztx3pheau9j6MaAQTjlf1dZhnV3aUluHA5DH+dOvbQzTnryWHWd/TX2anPyHw1Z6H+SHpEE/444RtxkrmpfgMCgaP3RYsidu0qWeOGfh5VptVEcvwx+U6Tv7XmioTRHxRyLhoxUvlesA/Q8WCP41Kb/V0e8DUHaZz3v5x1X+y6jSQ/7CyWAeV7oQYDhCBs85LM16jL8uG1ooKYmtqCO3lTqSUFPmp8R4/l4T3Hlwk0Ji7hG3fYjBYx30jLUuA2gXoO5AA81t82vDTwT9xnGSKsAeerQHxH6bNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB6499.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:10:37 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 14:10:37 +0000
Message-ID: <3f6746a7-e1eb-4463-aec6-687489d7c637@efficios.com>
Date: Wed, 11 Nov 2026 09:10:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rcutorture: Run NMI-safe SRCU readers from NMI
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
 <20261110192844.44713-4-mathieu.desnoyers@efficios.com>
 <9fbcb43b-ddea-44bf-b339-d01ba723d5a2@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <9fbcb43b-ddea-44bf-b339-d01ba723d5a2@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d9ea19-6ad7-4503-49cb-08df3ffd8f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|5023799004|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oMFp6RQICQffBDnDBBGJbfN74sMR/qYqD034HeYPbBKol/vjiQRuDWOKzCZY7LDas66+8Oev1N43JR58HiFNf17fm3KHHb1VOVWmwaDgnNeAf4gHXmVeLc7czpOXb1JcB5QKmWiTuXww9io/nakKU90vZOHUSBM6EUre6F3FhIoju+9OX4bo9ZdVZGhyMc9UV8MUbkNj1XeaqhV1UVERIlJ3c8f+66s7fnhUi5vHUUzCbDbStwKgYodYW+Zio4c1TPDV2UQbGmrf8DoMsQnVu3AcBHx1NLHEvWqyLNdSNoMwQzmCSBbeG5k1pdPQuUp2ibV+RIFXLFOMQSjlYmNrHDDU3ys07aQcCJa2JJY4WtdsEbWsXhIyCtmm4HeQwRlz5FQ2SELZY8vPkHOqRzDu54iK5etuMnJHv46Hxq3oo/Fh+hE4QJiJSRABVw57l6J5qfFuwfz9TTXwAU1GMhYNvTsmO3lp39HTxg87W1W4JWXN5FqdFDj+Lsq6JdJmR/niixvXC8yvOpsO6o65YRMcV53JF7dS1qgacF2pHlgLPsr17ual959Y1TsPjifOOMC/McVQ06NGK2Lz3Alo3E+S3+Gs53QApBiafcoABMvFlr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(5023799004)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhBUnl5TnAzTVlNcjdLMmdJRGV6WVRZRitOdGk5bVIzVTZLdndPTGhjT1Nt?=
 =?utf-8?B?VXVKaEZWcTV1cnJ2ZVFpcWN0Q0ZQVEFSbGhEUDVMUy9QYW9xZ2pQdTlZK0tr?=
 =?utf-8?B?akZzVTJ1bmNyN0NsUytiNVVxOUJVVjAxdUZXRGhzc3g1MXJ6bEVkbGRjN09X?=
 =?utf-8?B?ajRBaitrTVhpVzFyYUVhSEZVRk8vQmFwd0lCdDR0VEQ5TWcvR3VTeEE5TjVk?=
 =?utf-8?B?aHlqYlJvUG45L3k0VlBvRXpmQ2V2VGpRcjJlQktxNC85ZnVyVW83WDFoZ0tW?=
 =?utf-8?B?OExEWlJERnMreHB4YnIyV2lqSXU0NVVVcWlyRHQ2L1dJYVQ1OXFrUFJIaFhn?=
 =?utf-8?B?dXpLZXcraEF0eTN6S2RWdDlreSs5YWZsb0d4WUFJYk9rdThoWjJZSmZoanFv?=
 =?utf-8?B?czVPWnczd25yOGphY0M5RTRXcWFBVDNMU0JzazNYNWFhN2djSEFHck9sYXoz?=
 =?utf-8?B?MFZUU2I2R3AwSGx0ekx2amVIQkxIQ3VNQnowMkVKZkRkN0ZmbkJFUWVRdncx?=
 =?utf-8?B?TkZmZndacnExaDh0a3hwaG1SWlkrNEhPK0E3dzlTNnZrcUZiajhtVTRVZU9H?=
 =?utf-8?B?ZEV1eFZ4YXJibzNNVmNuM1gzTVBIaEplditCSFNBWHVGU3BpWmY1TTQ4QVpT?=
 =?utf-8?B?K2FJbTUzc1ozaFd4TVlORldRMnpjblg5WEo0ekRiM1EzMVIyc2FNZEJ6QS81?=
 =?utf-8?B?Y2NpMkp6Wm1pMVhQdWl3d0owVTFWUEhEMStTSGFudmx3STNjOWFuMjF2UUF5?=
 =?utf-8?B?RVErU1BJWTA2YWlZN00xaFJLdmtaQ2Z6elIxMkVoMjhsY2x2VVA3bnpHUE9T?=
 =?utf-8?B?UUYvUWg4enNRTDYxdkJMWG92U092QW9Xd1JxR2h4R2FraFhER1NmTGMvM3Rv?=
 =?utf-8?B?cFZOZDAzMW9QRkMvcXJ5Ri9iSEZJTWI5S1k1enBzaExjRkpiL3ZtS0NIRWRh?=
 =?utf-8?B?N2NpN3lNbDBZT21PWnFHdi96eUVwQ0tRYmZXbm9YWi9jOENZT1RTN0hNRzJL?=
 =?utf-8?B?U2VHUkR2eWVEcUZ0RHZvcEVBOWg5QkVPQ25abUxaZGV3Zk1wNTEydlRISmdY?=
 =?utf-8?B?RHg4VWlFTVlZVmtZeW1vMk5tOHJaeWxvZVBTZHU0V3o0UThmUmpPM2VWdWl5?=
 =?utf-8?B?ekcreHVFbCtZUFVqaVZWR1ZzQnFtczJTRjdRc0lJbUJUMnU1eUNTSnF2Umd2?=
 =?utf-8?B?MzVVZUg2Yk11QjNlZlpHMDdFSlFVSEhHb1d5ckJhZzlpcHJrb3JNM1JVUjBI?=
 =?utf-8?B?TGhkMWI0bXhtbEFSdXAyc0pJaEZIaWdaakVWRm4zUHNqUWNuSndXcnNobmpE?=
 =?utf-8?B?bVRuSVFPRFozTE4wVUpZVDdUQXZGMFVrUlpYVFV1TWgxa0N1T28yVXQyL3cx?=
 =?utf-8?B?cFUyRndsNGRMQXFjVXpEcUlxNk0zb0JiaFBUREh2TWR3cllQRGFFdStybW1H?=
 =?utf-8?B?NE9NdHBBMGY2QmZPYWcrMmt5T2c2c040bEFiUnhLT3Y2eXZxbmdraTdxTkI5?=
 =?utf-8?B?bUxaN28yd2pRUElleU5QZXNXOGljQWppRjhzQnJXUXFMTHBCL0JBM0RLRG5R?=
 =?utf-8?B?VWpUa21tdDB4VXJSdTNFRlJ4b0dyaGZINE1NWjNEODR0Yi9CM2EwR2ZCQ3dW?=
 =?utf-8?B?WlppQUdRYy9EWEEzaXREa01TZWhXR3lDY09SV2szbkRjN2xUQ2FLNEl3RXZP?=
 =?utf-8?B?REhJcUhjektHa3BXbGwyaVI1ZHo5bWRCb01kMFovZGZ4ZmwxRG0zdEhhT1NJ?=
 =?utf-8?B?aTRES2wzMkFMbExxMWprcGI5V1VzOEFOVlh0OHFsUTh6NGR2aEFUdXhGbUlu?=
 =?utf-8?B?ZjI1a2dEa0ROMVY0d2ZZVFlud3ZkdExTUlZTcEF2bWcwVzlPMmpmdlhIMUg5?=
 =?utf-8?B?WDFPZlYxOGQ1NzZVREpua0VoSlk5QWRKb2tyQWJhaHlNUGhIZ3BDUkZUMDRw?=
 =?utf-8?B?OW04SGxyQlRWY2MyR28wNCs2ZVJ2cVhpV3VnL0ZZMWErajBUUGV1cHB4bi9Z?=
 =?utf-8?B?RTFRSG1rcjZnK2lyZURnQUE2aVNMMitjNHF1Vm5wU3JKTXJjcWJKSjVmVE1L?=
 =?utf-8?B?aTlCd2VrWWJVdko1WDROQWZabWZVK1dxeFNXbWpoa0cwZXh2RFl5THJ5Uk9h?=
 =?utf-8?B?ZVZGTHZLbDV3czhCT2ZyckM1ZXhtMzl5Y1d6cktGQUQ3VXJseGUwRWRDV2Ex?=
 =?utf-8?B?eWgvdXBnbUxNaUJ0VllqVzNEUHJmSzdQQ3cyTHYxSlN0dnMzU1dmOFVoR0RN?=
 =?utf-8?B?WHdOSUFDcW11UHdEdmZ2MGd0Y09oNjFXNFpkVUkzdmNLaStoY2Zhd3VDYlh4?=
 =?utf-8?B?WkN4Y1pKNW5JVE0xaDNHdm9zZmVEMTFDSDVUWHplemgzc0FjZ2Iyc1dFcWFM?=
 =?utf-8?Q?mY4nPa6x7N9XsJ9YBm70iCgZHAMa7x7bVMp1m?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d9ea19-6ad7-4503-49cb-08df3ffd8f19
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:10:37.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp2vpNwLQenR28T8FB4A9w2PPWtiH50b1XGEV7v9jq2KY0PlQ9efjWdMSq9P3NDGAVGHKryyrlF/PYKZmp9HGdmZnj+6cyvMQVEK5Vk686c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6499

On 2026-11-10 17:46, Paul E. McKenney wrote:
> On Tue, Nov 10, 2026 at 02:28:43PM -0500, Mathieu Desnoyers wrote:
[...]
> A good addition!  Vanilla RCU could benefit from this as well, but that
> can be done later.

Thanks!

[...]
>> +            if (READ_ONCE(p->rtort_pipe_count) > 1)
>> +                    atomic_inc(&n_rcu_torture_error);
>
> Doesn't this miss doing a splat on RCU too-short grace period?
[...]
> Maybe a separate global array for NMIs, parallel to the "Reader Pipe:"
> and "Reader Batch:" arrays, that is atomically updated and printed
> separately, maybe "NMI Reader Pipe:" or similar?
>
> Or is there a better way?

It does miss it.  The test still ends in FAILURE.  But there is no
"!!!", no warning, and nothing in "Reader Pipe:".

v2 takes your approach.  The NMI reader counts its pipe and batch values
in two arrays of atomic_long_t.  rcu_torture_stats_print() prints them
as "NMI Reader Pipe:" and "NMI Reader Batch:", only when readers ran in
NMI.  A too-short grace period in NMI joins the "!!!" condition, with
its own WARN_ON_ONCE().  So the other readers keep their this_cpu_inc().

The NMI reader skips the trace event and rcu_ftrace_dump() of the other
readers.  The "!!!" and the warning then come from the statistics
kthread.

I checked it with a mutation that makes every NMI reader see a pipe
count of 2: the run splats as expected.

[...]
>>              cur_ops->call(&rtncp->rh, rcu_torture_nmi_invoked);
>
> OK, the invocation of ->call() without testing ->call() is OK because
> rcu_torture_nmi_do_calls never gets set if ->call() is NULL.

Yes.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
