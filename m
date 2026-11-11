Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425604;
	b=YeGiUxzu2jwddtYfLF/lzpyUFkbFUB/gGjJLe0o0TeU0GPPDov5xQP+hNlAObp2cJEur
	 2cUzc/vB50HnUm6rsPnac8DXTVK865a4eMCh9nwsSnrs0gWgM0Pc9AdiogTxIjlOJyIgs
	 CudVEXIaxyM/q8v7Vt6R8fELbuYtepkSwLxR6XPYXRIy62tgHGglcsXsHyMRmGYx3tUCZ
	 rRQxgZ+UN1iHmKioWylioZA6RileSNM7IsWuRQg4unJRZhdGNq/n4XZivGdfgVCFDcEG0
	 +/1vC6JzxzCEyVdT/I7tq0JKhR+ycTRIcP5oTW3N7pqX9Hs7OwFueHh9U3R7lRzZpcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425604;
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
	bh=9ofh99GKdN0JxVDZX8AC4F/bSt0E+i8rSzrxeLSrH6o=;
	b=UeVTCgX40XA9ydVn/Uixeeb+hEKbxvkJNCY8grHW+sXnYqHUqD6or+NIFn2cIQKDY2Mf
	 h9MUWTvhdUiqZK6OrZ5+39c7rVPtRvSU7YztEdVFnq+JA0yc9Er1csxkThdUhSdnFQ2b8
	 PaX0awGrvULVg4XW1bwHsOUNJfTmrAYrAurDQVdQ3lZkpKt1bDN3katZapgIC4U1sKvyt
	 EnqvlMSqPIE8LpUoWmLwwP/TXm+jLIoXyzbXNbqec31Nu1bSA0BU27ZtY8ZZZTBGwPBv/
	 dE7+++u1mqzXxKZe6Q3zOEwCyCLvJhoRbyVcdMBOmyc9H7trTWURl7pQOXyfxyId5oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fy3E7jpu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.142
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020142.outbound.protection.outlook.com [52.101.189.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5E606A327;
	Wed, 11 Nov 2026 19:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B5E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fy3E7jpu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9e4YePtLQDBJkr12AYWSiHf1oc8YkkcT2uHvw/gjb5qB+zhrmZYPcAazulN7RAsL/yGNWgEm2mSfL5/vhSnuzt9i2WgFFBXYVICZNHHqfGcGXlAb1QoeyXSVjAZ0aVZGWomAOX8E8QWN795N9u7PZbgMJ38mKyuakR8vry0gsq0smNsK25DyKuJTvFB0X+bwk+cFxkOTyvLDgAPYefL+5A+tzu0VQHCHf/IruJxusRXJuffewbNYvAAyEmgNcWpzlS/O+Uw5/uD9Ldzjqhotp9zJN7jaCk2BaJ97JZD4xSwcizy656S5rK/q0YnFiG0e3OUKYB5ynEw2/B9jPISYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ofh99GKdN0JxVDZX8AC4F/bSt0E+i8rSzrxeLSrH6o=;
 b=aJ2Co1gSdiPrrkzyFayCX0Zl5DexJ3JQ+TTPU9AFM4cpvcDY8eqF0gk4fK53JuphbXIA+wXb8pAMp9eCHIkifGQVs6zs6VeDJzwAKaQjBnP2FTcVNyAlaDKbGDpHUcI/FhnLsPWYX+oTjBBTCm3eZ5hGLvd8rkvvrKSN22iNMsFl0gMGv87OlVwdHSm1gFAJyZ02yRUf6WpgOA0zl1d37u6FJCboGY9k/HD3mMTWhj34OvcubNMeDWRUIc780v0vyTl9boZqC9Y7oKQdK1MF/t/7qJFDALf23v0pRy4vXnYGns4A1wHakJv1eUxU+8OhSjy5tkoP+L0gGuad6G81ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ofh99GKdN0JxVDZX8AC4F/bSt0E+i8rSzrxeLSrH6o=;
 b=fy3E7jpuQ27tU8bQdVYybBvc8pkb3ZZivRvcxgldW/S46ljtqqLVxQzApoZbif9S7w+u26LXFIytcjm+RlXEPYsE7O5+9cC5pXXOXONBR7RDl3kICHHDjPk95L9MVrIkczre//9p6g8kHzYAM862pnf2Y8JtzEA0faH9awNedfDGhtXzEiSMiQAe184PId1ELIIawu4rMV/KJcB7nX3N3PrpulpVI1m/ieePPEYmPt3BsDypZq67qfMEKkKnO7D8+CTnyVVqTHZmnLll8NiWD8NgTNHiMo4pyiwTZdCKoovwOrURRuEXLpXONVUB8XMDmHlCprDdnLCtBpYRX7JKtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB445669.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 19:33:20 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 19:33:20 +0000
Message-ID: <0782c3e7-9766-440c-b21e-e89b822927ee@efficios.com>
Date: Wed, 11 Nov 2026 14:33:18 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <50d177ddb1de4b84e9fd2cbd2ec5bdb7e32845d4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB445669:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d93325-9fc6-45b5-8b33-08df402aa450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|6133799003|261009223027099003|56012099006|4143699003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Sr4YyYmmicZ9L0ljF7MARlNcyB++wOpQ1Rw/qcWmkKRzngW/50UDIeJNPgbWS9UFaVNhUtqGdEhRBYEME67J7buVe+yLNZ2QELC8/1YjWzxII/JEWtwbzhu8RWHSPsFXRW2Aya/Xvi9VtUlTzVQX/on3QkFSic/a0TcMSWP3FH2BxawwPjtqJfsOdThWiAFLAnJKGVZ9iZFXlCs1yOSYRtK2OUbaSt/eHYI/Ve0CtA0Vs4FelSVtnSunE4+4G4olfLAbpr9NVM0jS/3OziEvfnyOocROEflfY+r1gPvdGOBD8ST87sHf2wuZjlBKoJn1FTPxHAck6G2gZpDRNwTCss1UnHeJXGBJxgl2Y2syxwvN+aOUk8NU3yMvbgWNYmXkuKE0eCdFYd6Wr3j9Yu2YpTRzrtsm4sZiW9r9Idw8TBc9m36EJLGMyawIGQk4vgbG/MUaAXLCP8qbwPDZqR9Lr/o9qgACYXOI3gRvoP0Mm8DawqyFWohSs7WZ5dirizljV+AJnBxuNVk9WrpF6xl+WkHkzr2Mua0qTFl6VUDfqr3bCyhbX4FJn8dXpDmwS3MkgNkv2LHMqdYbcZOqRdqxi2Y05374MQbyC/w90Ns3P5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak91ZkVqMXFURm1qUnQyVGova1RkdE1lTHB5dXB5V2FURWNiRkZTMGx0R3l1?=
 =?utf-8?B?QkIrNHRSUDRsREZIU21lY1lIV0V2emNzM1MwWXEyYjFaWTBzZmJINzI4aWw2?=
 =?utf-8?B?aE51aFJzdzJzR2d2Z0paekRjV0I3OGxkZkpHbHBsUXV5NzBpWisrTWtmaVlT?=
 =?utf-8?B?QzI5QStFbnU5UStDbEZKdjhuSlZHcDljbjlrN25kMzNSRDZXL3F5MnVOOEpM?=
 =?utf-8?B?cDhLSDZuSlVKdXA4a2tJSytwdzZtVDNxbXRwdHVLajF6MW1EZzNLcG1ncHkv?=
 =?utf-8?B?MDhaNjBqajNxZk5rZzRHUlROeFlWSXdsc1UrcTlCc2p3bVNjblZ2N0VjbTZU?=
 =?utf-8?B?MElGWmEwSXFuUEtHcUM3VUdJNEE5ZHpJUnBQUnNjMmVuaXY4VkVpQWw3dVkr?=
 =?utf-8?B?MHVHbno4a1NPUW91TXVNRFNSNUU2Q1FTZ1Vha0tLZWUwK3labllHUVZVS0dG?=
 =?utf-8?B?dmVvNUVHTUh5VTBkZ0o3a1kvY0NMdDI3bmc4WVVya0h3SVIvWlhRUG1IWmts?=
 =?utf-8?B?S3pFR3N6Z05FNUFuQWJXMTdVQjVBUW9lMFhRMFZjeURvWU0vYm1RNkMyaGN2?=
 =?utf-8?B?QXV1SXVEVHp5S3V3TW9JMHpXWDN6VGdjaWpkUVdBY1Q4KzNZTUpMd3ZXdEpx?=
 =?utf-8?B?MDR5bHdhbTJCdzA5bGZpbk8xMktZc0RwV3VGSHhMcVJMWEp5ZEdIbHg5cDB6?=
 =?utf-8?B?eWpmVjdZNXBGVVBlT3lNbVdFcWQ4NHYyeU5EMGhrVk1KQUhMc3FvSVBvaW55?=
 =?utf-8?B?VzJ2OXg0STJ5VWxTZDFjMlJseTRnem5xT3J0QnpwMjdqT0diZ3FvSFN4VHNX?=
 =?utf-8?B?RUVrblRMNFdJZ3AzUFQvQmkza1BEeTlMMktYbjhhRCs4N1pDZkxYZDBFRCth?=
 =?utf-8?B?U3czQXJGblE1M09UQzR5ZThQTTlQWFJ1YXFmQ1dHWlc3VFowREpWWDhTZkFk?=
 =?utf-8?B?QWhrWVo2UUQ2MFJBQmJoc3VzOWtaSTFOeHhDanp4bXpUUE05dnZDejY5cDk1?=
 =?utf-8?B?UkVnNGJUaFY1QkRMVkhWS085Y1NKRTVmL3d4a0pEaWlRaFpEa29iSHBWZmhG?=
 =?utf-8?B?TXpNZTZqOGpsTG9iMFpNd00ybk5YUHhESU1BR2tIMThYVFlaS2ZmT2w3MnJM?=
 =?utf-8?B?TWxmY0YvZGVMZlZVdTZobEZiSnhVYmhoMFlqalN0UEwyNTBZakZ5eTV6ZGR1?=
 =?utf-8?B?TUlwdzE5YlhYVmxBZGxEUmY1Qnc0YXJ6Si9DMWVUYVNjaWRJZnNyRm05VHc1?=
 =?utf-8?B?T2FPN0FmWWVFdEFsZmlQQ3hrVnduSG9EQmZLZHN0RG5iNnhiNkpUeW5VSVNW?=
 =?utf-8?B?SC8rZUVWOHVSc0JzdmhJcUM4QkwxdjlQQThnVHd6bG9vTXRyTWMzTkZWZEpW?=
 =?utf-8?B?bFZvc25rVHhqdVVPaTh6eEFPQ21wRmYrMWNSYi9uWWlOK2pjTVFONENFV3JW?=
 =?utf-8?B?YUIvOXVoS2kzODEzbjBBTkVtZThyS2FRbkFpKzlha2xTWjM5ellWL1hXSVBF?=
 =?utf-8?B?bnRrTFBWbWZtcjRVamY2MFJYMHBiOXRWZ3pJa0ViR0Q1MVY0ZTYwRkhVc2Vl?=
 =?utf-8?B?RnJQbTZsaHJrMGp4bWJ4Rk9KRXFwZ2crYjBKenZQREVyYlhCRy8yOU9ZQVVp?=
 =?utf-8?B?M1g3a2tubEV2T2d4VmFneHZHcU1LSDFsUnNnY2IrNXc3d2lYck52ZDNObnQz?=
 =?utf-8?B?VXlqNDVaYkJDcjNkOVR2bWZEUmFoaWh5aFBYNS91TGVzMTlhZHAvT2pxOGE5?=
 =?utf-8?B?RnpmVmRsWmw0cWZlN1ZFWTZMVTZ4WmFhUUlpMG1iYzJmc3VqY2VTUy94Wkpw?=
 =?utf-8?B?LzhHZkxYWkJoUDRTM0R3TnpvR1p5cFA5QUx4RGZzZjNrWldhKy9PeHBaaVRQ?=
 =?utf-8?B?Sm9CdnViREJNVk41eDFITGZqUjBCU1pNbkRESnNFZmlFVU51bFAzZ2RULytX?=
 =?utf-8?B?ZE5sM2xKQ1VqMURRMEZRb292YkY3SWNYMmRXZTBKV0VHRU0rSzVPekNWYTZC?=
 =?utf-8?B?ZWc5dldkN2pHbHdXTGRERUZDUktoVEZkMHY3clZEcTRPSEQrejdCRUdQUkc3?=
 =?utf-8?B?Q3cyc0xhVWlJM1BsL0c2WGNZZ0J5cUtnQ0c0MmRXOFZRN28rZytPaWs2Rits?=
 =?utf-8?B?eWp5WGpwd3VzbkxKRnhhTUxUVzJjRGs3dVI2emdwVkhiWUdXenIrZmh2eVFP?=
 =?utf-8?B?Z25OU2FmdnZxOGxQZzJBQjhPUHlhbFVnaGppcFRLSlZZUStiRUdyMlNoVk5B?=
 =?utf-8?B?cW5GelJNN3dGNHhmWks1NXRicEpURnVRTCtZVGFUN1JmSWRxYjFWeXlGSXZv?=
 =?utf-8?B?Um80SkdFWTRmYzVmQXptSkJobVBhOEVBWjZtWkh6UHZiUzYyODk2QVErcHN3?=
 =?utf-8?Q?AlCdcIIZ2xO5vYjRSXgLtcC6offwZSoOX8icn?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d93325-9fc6-45b5-8b33-08df402aa450
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:33:20.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWcc12LGTSDJKj1fjNvjQX+OrH+qWU+syjGOLJTRj0+9qN30aXc7JAM/3sHLqCDjsDcirO2IsbbHH9Ql5gc44UMe/eVK+z/i8FLoacSA+9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB445669

On 2026-11-11 14:02, David Woodhouse wrote:
> The latter claim is only true in __srcu_read_lock_fast()/_fast_updown()
> isn't it? Not in the atomic-SRCU. Unless we do something like this on
> top?

It is true for the atomic readers as well.  Without
CONFIG_NEED_SRCU_NMI_SAFE, include/linux/srcu.h defines
__srcu_read_lock_nmisafe() as an inline that calls __srcu_read_lock(),
and the same for unlock.  So x86 keeps this_cpu_inc() and smp_mb().
Your diff selects the same functions by hand.

Only the architectures that select NEED_SRCU_NMI_SAFE get the atomic
increments.

> I set a test running (*without* the above).

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
