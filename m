Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428022;
	b=JRAFU5RwVcFbC6zwzgnjGhQI9VlKOJrCnbr43vkFPI8S7ipgtbjgK6WrehlOLYpf35gI
	 6j8JIVkwZlgdDBz63UOn7mcmIOwLrdhsF7cG55qN34yylqjFAw0bjki3bOa7PYOWzA50F
	 pW9jnKB5+m8jkwfwN7lQa36ScpiIKeTnwyLjPo4Q1rMjDpSgyC1+yme9FCt6gtybsIazT
	 6rbWZHWnmc3SlLZk1Kelxm8fXnmC2py5owEn095xn3EbvIW2dR1e8EHV7KS83xNoorL5g
	 S4EKGjRGdn6KDfY/Yt3V5KMXnWo9MQUzps5vHyAY9lMX6jLM62hanSCPUKz6EKRV+DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428022;
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
	bh=ucQwetZnQ2Ct4H24+wGMBUWT0k6dfRMIRjTKTk/WqHc=;
	b=M4OwGkZbrFUxuHPu1keOnIVovuL9K/wMXo6kkTfx/H3WR+lztxrj6IzCSDxFtGaBHwQL
	 uRZneaSUG7oPTkRm0mwI+HmQtyrJkag5661Oz71yqvrg3wZ4Rbp4jyHc/Uk1nXBW6ILWk
	 6vPaUyInQxmKZ98/sxiMIH+fg8SdaZJRQ0DXe91MDXWsCWgy9tSMsClp2p/Wiay6shAcD
	 oGse/RrBbOecvb6V0y3w8q5XicT+mqNIdztzj0f9zbDhryq8YE7HbQ0BHWMZ9/StoYk3U
	 Y2IiYx52fAsP8ChxNaXH9LkEjnSDsh2gDJG+e7us2d7xySYATQW2ZgkZrpBAj6M7p/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rOVrsQB9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.109
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021109.outbound.protection.outlook.com [40.107.192.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11A606A31C;
	Wed, 11 Nov 2026 20:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC11A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=rOVrsQB9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBHswym/fxGiRsaoihcdgpCTJkmqY8EnZLDCrVCY69HZ9UlRNfx2y2s3f3PsgCqjgNqO4PTxOXAkElEczHjGOpNapjxn8Y+X1RJ/Imwz+oy33+is09Bdc1QGJNKTwyELePQTDuahOv/6AnqVE+yIu93mcV0Gnjl8UdUwBNW7eqOIoMxAqj8sryskKQjb15oIkX7FGvwzmwY2Y4Fj9v67zP+yM8cZ1bnl4e3v5Bb8yNM3sfrope+K9IZCH/Hhdt55r5zjV1UpTIb8Oownr2va3jY5sDf7t5RQ5gfhUl0m4gRl07CxcZZIU2MQeMMw4y4yqUSIEVMtsiUTteT4irJUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucQwetZnQ2Ct4H24+wGMBUWT0k6dfRMIRjTKTk/WqHc=;
 b=BhzKpncbqmcjr7H/OEtI0RpNh7ACWsorFI5eKjtZZnkPtURUiFEwYQnNquIxTOzTCjTmOrPm5EeOizV0b/i9Te5FaOU19EbfNSMv9w2KqlTuB3fSiKuCZO3/SQRO82zTVr878TlJl7iTA3vbYF/uk8iGt9VCMDOxt4RsVicER62HBKEQ2YpRVbsEIefFAxrXnAvadR8FrRBl7V57ghf86sNNvfxhPcx5a55RUUrCCNxdJVhNX1QfBl+WRFbvDFNEj5201kKv/uHF7mDzSsgtgyN8wZURy+Fc6I/4crDR7RWjUizZ9ReKbd7weTlBm7JMoQZSngllK+TnsnbkVP85Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucQwetZnQ2Ct4H24+wGMBUWT0k6dfRMIRjTKTk/WqHc=;
 b=rOVrsQB9oro6kFggQGgDmCNoc1WwWOr0ehMUplAG/6u/jACi+DIX/zINBlgZ0ox0PcHM+2hmMKfzFE1mXfMLDSPbUoaquB66LFlByskR4Vqy49DMy04YKruJ1p8fuGFC7qhL0LjjadkbNWk2BBCJauyz8gbj7Tqx1LR1gnjEfbN55vzHKF5ag569aPm3BKl5yCF/YxNpHt6GMSsqnWY3zfprw8ipKf/v3H5vXdInogqqu3zBL6hB8Wgqo9rbZZtogem+pY39u6Ux4NXvPwuLNhHquAy7SV02P+Y2CNfUv4HokDVUxqVw8QpuX88KisdiQPMFRLXZ4tlBubqBukoa4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB10389.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 20:13:35 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 20:13:35 +0000
Message-ID: <9207ad1c-fe1c-4041-80c2-52723bc58486@efficios.com>
Date: Wed, 11 Nov 2026 15:13:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
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
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
 <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::32) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: b708e741-bf4f-45d2-97e8-08df403043d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|4143699003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qdovxbixs2Mx/m7dfE/LoDVrkYfr5Fz5pMGkM2YqKkG8H5cVpJ2woTsP8EA1RMLg/CiSYnweONlEuRdx1X3jV5EOFch/55nis6wDFLEaTk22pFG6S+WtWT06pv5rxR7yx02FlLAUtcWyXQ4+aIFbMrH5afKUgxamiRqXk7UF0Rx4qAj/3/rao+65vjMs/CzBnvoNg5cJ1v1lQhwyPHV/JDhnDHgDXfcK48vhJd9fmE8mv/bcn9kEry/UUkON9K2mkHMPKkF3vF3+SQRyQGPmVqjArm/qcBoGeqcxM5k+D2apzhssenK+FvJNd0WD3IUCwkE2nVFrmCT9Ty5QBDN6JU/jQQmpeYSdfYyUco5RckSGzqmAdEHanGAxvIfBCucuRErJIPyVq4njlmyVNkKUB61uR1IeViU7xE360blsZoGidYeos9Pm/FG3A/KFJt2dsQOaP59yWAnlXaU2pLACFiFfmtC1HE2S1ItVyYIksR0hNPkQ3EiKeMbAkD6Q/qJ+iD+ngPlstWfltV9aK+DRpgtYesG3s1PU1UFMEvduBn1ZQXBRs02M36UeYE3U/M2Rz5tW8EyaBEmiFVW4gLQTnNu7KyNBhZ2RBPqDgfC8YRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBJM1padDhMdGJBTVhObkFna3loMVk1VFZ3eEgyQk5WSER1SEgyajJwaUps?=
 =?utf-8?B?ZWgxeXRydDRISk5OaGdZUkdBeXFhZ0JKcVFkOHl0QXpncy9lcXh6ajMreVBq?=
 =?utf-8?B?TG82MWdxTGt2a3RiVGw0eFVqdDY5V3ZONEs3RVIvRDUvL2xJejhXZnJzYTRr?=
 =?utf-8?B?ZmViMThZREl2Q1pveXZnSzFhb3RMRWZvRFRnSnlhdU13dlNrT0Z4am1lSllF?=
 =?utf-8?B?bXZJeGFnN2hFYW1SS3lwd1FWUnNNSjhvNjFUZ1haQU1hVUhZY1FiOG12cEpL?=
 =?utf-8?B?aU9wR0lpSTNGb21wZU9KajQyYmRrOGFuamZJdEhlemo0R3NuWW1mVGc4aUMv?=
 =?utf-8?B?WFBPa0pRbGl5SEo2bG53YjlCUVIwOHRZWENZV0pQVWZkejRrY21USmZFVmRJ?=
 =?utf-8?B?SzJQZDF1cTM0cXZqVWVtNFhFUnhoMUxyU2JGYmVOWGtUNUcxcHNwSXZCdmJN?=
 =?utf-8?B?Q0RkTjZ1ZDlpR1g2LzE1Zy9ra3BJK0xmVFRYWFNROTdid0xTMmZ3T2FkU2E2?=
 =?utf-8?B?c2ZqcXVQTCtFTU83NXRzUDZGQm43dExkWmJzZFJKZTYrUzN0N3p5akI3REY1?=
 =?utf-8?B?NjJYQVBOWGV6TFZJYkFXZ2w5LzdPNnp2ZlIzeVpBUXRrTkJ6eG9MTXZjbm5O?=
 =?utf-8?B?L0dXK2xBamxlWUdmcGorQnJteVVCTDJNRERsaDRMOFZhVjdUUzB5SG5nYUpN?=
 =?utf-8?B?dHl1YklsRW8zT3dkLy9mVVZRa1V1dmhKSUFCanZPdTZFWVFaQWRiNEFlTWV4?=
 =?utf-8?B?ekg1QWdiVjZ1S3c4Q3JYck9LSTJGdDhmZjZTS243cllpb1hQRldXd2FYVDFN?=
 =?utf-8?B?bmkwZndQaU5KeDR0UWJmZnRtdjlzaTZtUFVsTjhwT3J3dmZ4NVVyVEhvU3B0?=
 =?utf-8?B?cVU3UDY2cEtYZUlaRjR2T2kxNzhyUU5hWDlVODllZVlUbEpNNS9SNDhoV3d5?=
 =?utf-8?B?c29KRUR4cWJRMktKVThxK2NyVVBRRElHcEZaUEVhK2RPVXU5VFd0R1FYbWVJ?=
 =?utf-8?B?VmhpZGtKb0gxZi91MUFBL2c5QzFzS3Vvd3Qyc2tYaDE0VG5XcjlnbnNERmh2?=
 =?utf-8?B?eENUTzJXNlM1elpKNVBCaHNRL04wWDcrQXNxWmN3b05qYjJsNXpiSFB2bDdp?=
 =?utf-8?B?bXM1NUlsMHFTeDJINnN2OWNqNnZUUlE5QTFpdXRqa3l1UDU2VW01Rnk4RFN1?=
 =?utf-8?B?R3BsblRVM21OZmZmUFNGZ01QTjBUL3kxQk5UUW5oVC9xWlpLN05SWHo3K0o0?=
 =?utf-8?B?bkNkc2daMFRqM3pwWTlNRnpuTGc4MlhJbWFLdzFhRDZzeGN1Snpkc250ZFg4?=
 =?utf-8?B?TnJZNXRlZ1JoZnVZOFRXVUVzUlhmR3hPakVheFQ4bUxWR05JenlYTTQxUTl2?=
 =?utf-8?B?aHV2VTZCUzJYaWdPSlIvNk1PNU1vTmVkYStsL0lRUjYxaGZoMzkwd3R5RllW?=
 =?utf-8?B?TVYxa2hjQWNxelRmN2xJTUtya0VvdTFpY3I2eTNub0VDWDZ3azZtNWl4NnBx?=
 =?utf-8?B?UEtPaVpwVlVWdTZCNEthdGdBRGQvNGNRWHpiN0xuWXZnRTlQWHYya3c0RHUx?=
 =?utf-8?B?ZDdHdGJodDlKWWQrS3d1TmFEQ3VaNHRzR3J6QU5ISHhhSlFVTzAxeGFzQUsv?=
 =?utf-8?B?bWNaZ3hkNXl2TnNFSkQ2NVg0Q1ZWSEpRcWxCbzRyc1F1bzdnRVA3bW1hTkZY?=
 =?utf-8?B?aHJtQkN0S0tQcHRMTWRWQThiNlkyQXFheXhsU1o4ODh0US9xQW45TER6T1ox?=
 =?utf-8?B?Mzl3a1Q3cWNiVWg3cUhYVytiUkNmMkVBSFJKeGRuWTAzekRMR3F1WHBiSEVD?=
 =?utf-8?B?SmR6WmZQazFyUXBiNXVJQWwvVC9pVUM0UDVCaHE1aW1rSzFGRzhrNDRwUmYw?=
 =?utf-8?B?UUZkclNiaTZnY21CUi9ORXNIM21KZ3VBK2E3cWRsejFmcTMwRU0rNEZiTWF4?=
 =?utf-8?B?b0loN0JESTBjNHNJOXhWVXpZSUF1bjVpOTlCYVIvSE1jN0xncDVtYkxwWC9l?=
 =?utf-8?B?RG9zWnBtNEZUNksxZGlxWXdPcUUzaWtoYlA3WlA2YUZKY09xK3pYSisvZFh4?=
 =?utf-8?B?ajQvODdWWVcySzJlaGRNU3hDUXdiNFEwbmRvTTdBMlYyZWVJbTFCSGF4c3N6?=
 =?utf-8?B?aE02MTJwZ3NJMmswWC9nRHMvenBaMHZBKzMrL2RZcTk2aUI5SVRkZ2FVUWxD?=
 =?utf-8?B?b0JybDdySit0Z1RYVGRCdHVsMWFVY25qNGZteHpkNW0vQ0RVZ29SVFhQcEZS?=
 =?utf-8?B?THNtaTM0OThXYk5kclZaMEV4MXlTZnYycDZSZU43dTlaRURNb0hNcm8zMkFl?=
 =?utf-8?B?Y09MeVUvaHI1Yi9PZjdUZkx1V3Nxek9UNEgxQTNFUUhIbW4rekxqZXJsQ2o3?=
 =?utf-8?Q?3uCwrkG0SbQMGTwioAvC2jOQi4ChQdf0/3HMt?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b708e741-bf4f-45d2-97e8-08df403043d3
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:13:35.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCEKjBgPhH3ir4AsDphXi3x0y/w+avOkAKr1LBwaVf1B1wLd+K5bFNC+wFzPj4yVRVIovdrTS4PxC6PA9UGbjYR5g8kKrFhX9yqRTI/AtEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10389

On 2026-11-11 15:04, Paul E. McKenney wrote:
> Aside from this in the console output:                                                                                                                        
>                                                                                                                                                               
> rcu_torture_nmi_cleanup: nmi_readers set but no reader ever ran in NMI, so NMI readers went untested (no PMU, or NMIs unavailable here).                      
>                                                                                                                                                               
> Looking into it.                                                                                                                                              
                                                                                                                                                                   
I expect this is a guest without a PMU.  The NMI source is a perf
counter, and kvm.sh starts x86 guests without one.  The readers in NMI
are then skipped, and this line says so.  The nmi_calls test prints the
same kind of line.
                                                                                                                                                                   
I ran with:
                                                                                                                                                                   
     --qemu-args "-cpu host,pmu=on"
                                                                                                                                                                   
With that, "NMI Reader Pipe:" and "NMI Reader Batch:" show up in the
statistics.  The cover letter mentions it, but the changelog of patch 5
does not.  I can add it there.
                                                                                                                                                                   
Thanks,
                                                                                                                                                                   
Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
