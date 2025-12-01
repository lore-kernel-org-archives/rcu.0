Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B521420B;
	Mon,  1 Dec 2025 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625917; cv=fail; b=Ka5MsjTrzBKwOpyAhg9JaFKf7k0tWaTIE0cnPkLXB9JtJXupSFvTNcalmhWL2NXXxIq4gLsaK1gqP6DCNxhUfxC9tn0X5Mu3YCPZHJMZ+w7kOTv2v/l7PNpFRGxIsD2WVwzDbdAlzGNi6ReZF2PdK6YmoAFrg6M9ELQklnI19FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625917; c=relaxed/simple;
	bh=Dlrx68zu/Zs4f/jcbMhFvRLz29RT5n9/iK3X/jUfyac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7WsDTtcSr2nHh16N5RQxLP89MCLQdYSBo1jPysCAKrpmNG3hgA2vwmzwQWwmwj8Rabn+KkoOKQjH+hR+qDbrsg9EcgFWWHcduKFYZAQX/SqBRvRfMIPSVwOyW09qq3GEINZhA3OVxQl6+60nIYrZURUzQncducUoQjhe2NVT54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dAMNqQFs; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dAMNqQFs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/foO+bxeloEJbaqgEFkDo2gOaOG28U5P+dH4bUK3mdylIRsT/37dVU9BBcEiIRlV6AbK/4RiKzNWpiophXD9mcslJqqO2RbzwYR74jQ89Yp4k8C2w0yUB8dYtZJ7P6pJxpilbsUvCKaDgU6TEfvQ4Aj3xeCLvAA6bl8HDhHGxGPwrHxnMKcvjDFAxMK8i2cy48sCpCOt9OyZlF5bI2yCuCHs2trOHpW4yI6m3oVL5FwhWwF77cYMKHAbjhw7HiQvELtBVffk103I//abA3lp4lT0txUr4gevzhwkSlL1E0CYpC6Kb+j1llX/Ky28j+bO4fUQin+oyikE3Rlo8VLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTM+4XN7qOiTh82crBx+l74f9baUodYXoSjWTZ5Cn/w=;
 b=QSnCzuGSyk3b0vafcktnC+inQJc0lyqXWQ4Nx1dOf9FNdZnfTXuF4SIOwS957NXk2NI/XMadMvuZWvNkRDCjoYbgxKfX/YyllIyFqVy9KONMQy9Us7l/28U0VQqOjyKVufHKlbOTyQAanQddTBgCEJ+8jBLQ1LM4d6jGB7mAn6oKad/9WjaWIm071lLEng0k9Y91kPrOdmpZc+sbumFTNls0klOKErwvT+XNOFuOOSc8Kw87IDNzsuAV0Gkezw+IOcyUGbzA9puvsl50YvaGZ8SQH+ZxjMAtW8jbaCmQH7gQH+e8mDRPnVgy0kciWqUPzNuestH1U7weSTh/zpB8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTM+4XN7qOiTh82crBx+l74f9baUodYXoSjWTZ5Cn/w=;
 b=dAMNqQFs1c2wU+th8vcfHkJ4u/l+JlGUrPKXXpaOHezKDASlu8Txta7mky+QTKzuQvFZlxvHRfCQgDVlY6gFD0Mezolnhgriqw5r+3JEpFUlfYcytcGZhTj3ZQd50x/ujmAW01ruhz8jloxwHyXymCrxcX0Uiuwa+RTeSR1h3fZNNnfhkh46LyfeItQZGcpYvwKgN0LCTlcs/CSdZIHgMnC8+KSoyo6ZLheFe25P8vPBL7DRI9+UtMkDhy5amNlDA572JRizFD0GzJo41fVPUPkdph0JwBjOHItrY7VjF6F1QWLjE1dVoN/szAdGcnWG1IQuUVs9PYjOLXji+ZUqag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 21:51:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 21:51:52 +0000
Message-ID: <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
Date: Mon, 1 Dec 2025 22:51:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 stable-rt <stable-rt@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Pavel Machek <pavel@denx.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241106150419.2593080-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9fc8e4-76c9-4781-b10a-08de3123d62a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJUTzZDY3d1UXRVVlYxUUYyZzZsYnN0M012dWtMWHE0NUs2cUtzcWtCREdN?=
 =?utf-8?B?bGl0NERZanFpRlVZOUd6ZXp1T3p3UlZCUGJBU3FHNHlXK3p6RFFZVVNnbnpQ?=
 =?utf-8?B?Ynd3QmMwL0RhK2FmMGpydkE2bzQwdXdsV3ZodUoxUG16VGp6Z0R2NWdPTnl2?=
 =?utf-8?B?MStmeTFtNEk4TVJZVGVCSnozampkekQ3ZTJtWEdpbmVaK2N4TWJzS2NtTmVu?=
 =?utf-8?B?SVh2YUtFeUhCUXE1Wko2Mi9CQ2N1NzlobWZRcXVHS3ZKbW81Q2hxdmVwM1lq?=
 =?utf-8?B?ckFDQ1VuNk41VnZmS1pmdlhzL0N0YytVWTBuaG1sQTRSc0RnbWM0NkNrUWkz?=
 =?utf-8?B?U1oraFV1bk1TdXphRjg0VTBSc051RVBYNFZsY0k0djBJVm5aNTRjb1IrOVZB?=
 =?utf-8?B?WWFaUTgyQndmOHZ5UU5WZVIveEJqam1hbGJTRkREUThCVzYxWkpIVUo0MHFw?=
 =?utf-8?B?dnBOaitobmxGU0xHMlV2N3V5UzkyYm1zMGtZQ0xwVDNTcCt6U3RkeGpZL090?=
 =?utf-8?B?dENwM2NEKy9iN0FuRmtSRVF0TUJJMjBab1gxeVFaM1lJWlRMSktaMmkyOThB?=
 =?utf-8?B?NExuZURHYndGWVVxMzlzaDVhSVFrY2hHNVR1dTRzMWM5bkljcWZNeHJLY01S?=
 =?utf-8?B?bEJPN2M4TGlETG1LN1A3UnVZQ0sxSUlrK2MrWlVsdGRTMUt4eml6Zmt1MDg4?=
 =?utf-8?B?azZvaVY4UUxvL1Z2YnQ5cDVDWDVlSlZLSnoycDd3Y0Y4NXNxNkFYbzNFR0pu?=
 =?utf-8?B?U1J0UTlQMHQ3d3FDblhmeUpyQkRDbnNMTkUzeEp1bzlmRHpaNzB4cmNiVjIw?=
 =?utf-8?B?NGRtZ2FyZjFtS2xwRWtqb0tOc0ZrdnJWNWpTRXdlL01lQW01blo2azRWajhM?=
 =?utf-8?B?ZTNCVlZoakNQZGRVNjZiV0lFRVF1Z3V6N3p3L3ZEWmtkOHl3NzJqSFRoQjBG?=
 =?utf-8?B?bHQvQUw4SHh0ejV3ZjBkeVVRK29CS3NSd0p3bW9COXlpMnEzVUNXUW1HM1RR?=
 =?utf-8?B?eXRtWWVhS2hCMUdQbTNMaWhibDBBL0NpZjE3QkNIS0tpZG90MU1jNEc5Y2tv?=
 =?utf-8?B?aTE1Unp4aEFwdmttTEVQMzFzWFhqeWU0U0NXMjdwRDY2d1NSdUxYRXg4REJh?=
 =?utf-8?B?MWxZZHRCZ253cHhLWlhmTUdiL1lJcmI0TVlpWGUzYy9FT2kvazBRSnZtbTh0?=
 =?utf-8?B?Q0xhUStUTnBYa2kvd05TcU1mWWFvZGV1UDVqUHVHeVNnUlRhYmV5VHBoNGgz?=
 =?utf-8?B?YmpNSnZ0bEY3cm5rMVQ0bnJmUlkvR0c5SDI0M3Jvb281OC9OTS9xRmFsUXQx?=
 =?utf-8?B?OVMyV28rd3k0RkFNbG1yQVJpL2hhVlEvNTZYNk00bkJERzFJdUhxcHpoMEpK?=
 =?utf-8?B?VG1VTElrSXlGUzFZRW51VU42ZmdXZ1VtY3BCeWhJcTBjNVF6dWloeHppWnBj?=
 =?utf-8?B?a2xpSFFZaStZNy92b1A0aXFsaEhkbkFXb0JjeERxQzVLZUwzN2ZHTFg1aXZs?=
 =?utf-8?B?ZEdMRWxrdVpFVWNtNkVkdTJIWllTbUdlMWlXcUxCa2k5S29mSlZxelg4ODIw?=
 =?utf-8?B?cm5DRkh3YVYzVWFTNzU1OHdmblJvSFBrRWx6N05hR1lUMjExYXVnQ0xmc091?=
 =?utf-8?B?MGhDRXVQdVVRdTBOc1dCUzMxd0N2U1BCSWZScE5pMjNiNkpvK0M5ZG53U2lH?=
 =?utf-8?B?U2hEeUlnOCthaTlRZEorbHRSWjBuWG80TDBIdWcyU0xGMkQ5UkVlSlRlbWVl?=
 =?utf-8?B?VzNtZXI4NWdlV3pZb3RqQ3N6TURYSE8rOVhLRERubWF6SkVVK2YybEFuRW9u?=
 =?utf-8?B?Q1ZOdGFGclYxWTI3V255TDRlQ29YS3E0NUtiL0JLV2RZdi9IR2xSYnBBMVl4?=
 =?utf-8?B?ZGtEbGt1OVBibWpBbWcva29md1QwZERNbDNDWVNqV0FDTDNWQmt5RndvQkxZ?=
 =?utf-8?Q?3D5BGJiNaeAvFsotynQTSKjCiXgP586B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0dRTEZXc2dLR2VJT3Q1N0xuOEVqc3BYSFEvVmVSZjFicEZYUzhJVFZyQnJ4?=
 =?utf-8?B?VVZtUDFhL2FUTEhhalM1OGEwMkd0bmdTZEt0Y1pIL2Noa1dNZHJsT0dGK1h0?=
 =?utf-8?B?bGREbzdXR0xYQTZNTTJFV2czTGNjMDJYNFpadkdnM3hDaEhiVE5RcDcra1BO?=
 =?utf-8?B?Mm9SeGg1MDMzT3dTYlI0THF1UGkxWW0vcks5Z0NjU05FWTVHczcyRlVCbWo2?=
 =?utf-8?B?cHYyOUg5cmdzY3l3aEM0NUlGQWl3TmJPWUt2cFM2a2YxK3NIZHBwamNkbE9z?=
 =?utf-8?B?c2M5RlZ6WWx6ekRrRnhSRk5ReGxhQnM5cEkvemI1NFhaR2JYOG1rQTZVdWp3?=
 =?utf-8?B?bGtVZmdsVE1RMzBIL05xRnIwZGo0dWpiSVhuQ0NvV3l4RmRibjIvbG9YOEVt?=
 =?utf-8?B?R2lGNGJNQVNNZkJkNG5yNEFOYkVLcTFWU1ZJdlIxeG9jT1hqWjhuV2J3Q2NW?=
 =?utf-8?B?MHVyRnNWWXdKMkRTcW95OEN0aG5mRzFoNEJQOXcya0l6aVlaVUJCSDUrMWlR?=
 =?utf-8?B?RCszMFRVeWw0ZlVsVGlDc3BTSzdDNWZWcytJUGsvTkwzZWVMaXRHUTR3UXYx?=
 =?utf-8?B?SEF6azRzWnB6eno5TXY5blRjcXBucjhYS2ZEVlU1UlExNmpVVloyWHZwQXZ5?=
 =?utf-8?B?ME9CMmJSZjlzQjFwNm9IbVdFRVY5NnJCSTd4YzE3T1c2WjZMM205UEJoTzF2?=
 =?utf-8?B?cGF1QTZSSHg4MFRocUVyM3hCS3B0WFNmWGg0WnNhS3hBTGV1ekJVTWVZTGFN?=
 =?utf-8?B?WEUvNXJWRVpLRjduL3BUUWUxWjBUTENFbXdYZlp0czZVTzdOejJFa2RIWjky?=
 =?utf-8?B?UDRRVmJGcXhCbzN5dkRPbmxWaWVLTDRscGJmTWxBdVpOV2JDUElKbDRZZExF?=
 =?utf-8?B?T1p3alBYZEJXTGw0eThlWGFOT2owZEJDZDNIVVM4MUxsTzl2NXpGdll5U21M?=
 =?utf-8?B?K2hwSVYyMEVrNGZZTjAxWGJjcWZTaVprL2RveWJ4dmJYZ2lEek9hN21aSmhn?=
 =?utf-8?B?K1VzcmV6UlBqV1g2TC9DYWFkd0pka0ZQNjdhVzAydGNoQTl1cjdTOVhnRWxY?=
 =?utf-8?B?cW1SK3ZUUFdLWFNTQmdwM3psQ3RaajNFWll6bDlLNWdKdXFYUXJiM0NVUzkw?=
 =?utf-8?B?aEM3cTdGN0RSWVBlbVFMNGR6TUJxT2h4VkU0WElkQ1BIYnNxd1NMVWN5OHg4?=
 =?utf-8?B?ZWR4blFuNGM5WWlmbEtSZ255MTVjclZGRUlOamtGaGI1UUV3eHJkczFYSEtD?=
 =?utf-8?B?Y0lEWkJBMHA1dllrN0RWaTI0ZmVEdVJ2UmZIMStoUkZYcjc3MDVBT3RrcitV?=
 =?utf-8?B?SU1DOTR6ZGkwSEFxdVQzZmk5VVN0K1ZEUDc2MG1SWjMrRENsRXJlYUxuSW5U?=
 =?utf-8?B?dkhNY0RTcUVlQmFicGZoaXdxbFpHeUFTRWlualNKRlFqa3AweHVCYTRzajl5?=
 =?utf-8?B?eVZmaExaYVBGRFhZSzAzR1FWSUl0Uml0SzVubjUxRWh6dFlMOUI3OXM0aERi?=
 =?utf-8?B?bEhrWTFwTXZhTGl5VFFEcyttSlNLTHR2NHZ5NXlKL1pBNjBmcUdXYStsanNW?=
 =?utf-8?B?SXYxRnpyTlhJaVFaNG9odkt1S0JtMHZBZitodUt4VWpYRFluZDJYWU9QdW9J?=
 =?utf-8?B?ZFR3NklpNWswa296V3dqaUJMRE1TcC9tLzNwajUwMklnNTBxdnZkRTNLdDJU?=
 =?utf-8?B?Y3hUVDRZTlhOUnRsZGo1RnNQZTVuMHYxQ3h0N1BUZ2xXOE5hdzNQYU1MU29n?=
 =?utf-8?B?aHpNV3JVWExwYmFpdDZnWmJVY1hiZlQ1STl4a2EvVVduRVdBaE90WlZFWVQy?=
 =?utf-8?B?d0hwQXpPd05jVGJGM2RvbElUczRYTUNHamVOdERpQ3pVV09ab3JOSnY3U3B4?=
 =?utf-8?B?RzJpRFg0alAyOFdyVDFoVFl2alU5ZG52Zzh2azN0SDNvcnhPczB1dkFBd3ZE?=
 =?utf-8?B?cGV4aEY1ZkpGR1ZoK24xd2MwTGFUYTJtbHVoVEhERTFaUytKd3U0K0kvOU9F?=
 =?utf-8?B?aHNRZ0RHbWk2dHdPbDNJYWtPb0VCU2VlczJUTGE2SU52b2JpNkg5OWlhWG4z?=
 =?utf-8?B?WmNOVElYbzN0Wk5JbnA2aUtLUWYxYkp2R0Q3VUJJVFBjN1NZTTFnR2VsYkVB?=
 =?utf-8?B?UlVOOHJKMTgzVFVVZmFubEgzd3hPOW5Sa3ZQR2NWQllNb1M5cm1hbWN4b0pN?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9fc8e4-76c9-4781-b10a-08de3123d62a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 21:51:52.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv0OnOw5MHEHYGTbR8B3gz1iz3xZLSbQtmuoFwlpPHIhoHSJrMeHNo0FSwELxwKU8tbkOXva8nTHnRf4V9zJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6843

On 06.11.24 15:51, Sebastian Andrzej Siewior wrote:
> A timer/ hrtimer softirq is raised in-IRQ context. With threaded
> interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
> for the processing of the softirq. ksoftirqd runs as SCHED_OTHER which
> means it will compete with other tasks for CPU ressources.
> This can introduce long delays for timer processing on heavy loaded
> systems and is not desired.
> 
> Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> timers thread and let it run at the lowest SCHED_FIFO priority.
> Wake-ups for RT tasks happen from hardirq context so only timer_list timers
> and hrtimers for "regular" tasks are processed here. The higher priority
> ensures that wakeups are performed before scheduling SCHED_OTHER tasks.
> 
> Using a dedicated variable to store the pending softirq bits values
> ensure that the timer are not accidentally picked up by ksoftirqd and
> other threaded interrupts.
> It shouldn't be picked up by ksoftirqd since it runs at lower priority.
> However if ksoftirqd is already running while a timer fires, then
> ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
> Ideally we try to avoid having ksoftirqd running.
> 
> The timer thread can pick up pending softirqs from ksoftirqd but only
> if the softirq load is high. It is not be desired that the picked up
> softirqs are processed at SCHED_FIFO priority under high softirq load
> but this can already happen by a PI-boost by a force-threaded interrupt.
> 
> [ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
>   local_timers_pending() for tick_nohz_next_event() ]
> 
> [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
>   softirq is currently served. ]
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This went into 6.13 and was never backported to 6.12-lts. And that is
why you can easily stall the latter with a workload like this and
CONFIG_PREEMPT_RT enabled:

echo "+cpu" >> /sys/fs/cgroup/cgroup.subtree_control
echo "+cpuset" >> /sys/fs/cgroup/cgroup.subtree_control

mkdir /sys/fs/cgroup/stalltest.sub1
mkdir /sys/fs/cgroup/stalltest.sub2
sleep 10000000 &
pid=$!

systemd-run --slice "stalltest.slice" taskset -c 0 sh -c " \
    while true; do
        echo $pid > /sys/fs/cgroup/stalltest.sub1/cgroup.procs;
        echo $pid > /sys/fs/cgroup/stalltest.sub2/cgroup.procs;
    done"

echo "1000 20000" > /sys/fs/cgroup/stalltest.slice/cpu.max

This triggers a lock-up if a holder of cgroup_file_kn_lock with
SCHED_OTHER is scheduled out after using up its timeslice and then
cgroup_file_notify_timer fires over a SCHED_OTHER context as well,
trying to get this lock, failing and then never being able to reactivate
the lock holder again as well.

I've nicely reproduced this with upstream 6.12.58 while Debian's lastest
6.12-rt does not trigger because it additionally has the downstream -rt
patches on board.

How should we handle this? Consider 6.12 mainline with -rt and cgroups
as potentially broken, asking people to user 6.12-rt? Or port this back?

BTW, the original report of this issue came from an older
5.10.194-cip39-rt16 kernel (based on rt94 for 5.10). When was this
feature introduced to the -rt patches? Was it ever backported to 5.10-rt
or other -rt versions?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
