Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02A2BDC3F
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765754777; cv=fail; b=m28VDhTrhXwioiOPdw7IbqsWdSGPjgtiiFnkLbyzxoq15VjLLdw9yB9jHcNFPnnV0H3jjHvJ8x0aqQ7I5f/sf1JKkT4KwMozuAhYl8TzWb3aygCaX8JYT9XmBB+uad2CnctLiOu5cL9Wf/ypuVw8cQuYA8KhQzdd6XBgmocNAjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765754777; c=relaxed/simple;
	bh=tf+uThNRlIy7TBh5VHVhtwzmg+V07qQHFn8E8Dq00O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dt3ZjS2lEx1jKrXVVoaPMgh02e7seQT6Uy6H8UwGJ6W2+c1wHwECThT9gb2UanCf0oo78DkigalzXuPHgrQMIxRCM8XBVKNbG747LzOduh+AwYLVm4XjzYdxeMiXuWOyYuwPyWJJPDozrkuopiFQhVAs2GxAkQUkexv/iKXhiyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaYlUZnN; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaYlUZnN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6ptipI7bXoLIKs67czhjJZkGqQ+YGu7nh7Mmgqrv9XSbMokXgYCHh4h2brdrzIh20BLw1qpZbk2fAs9XOjURX00Ieg13IpjSvb5fq7PWCOwdLRBgjMEP4ZSGZSf1cjrJx7Dvl1+GjeP1lkp2B3/d2hH1qi2C3aTEcDRavQOXQmgSwg1erzNCtJ1F7zwo4tNU+sS7TdSa/DmdeJIXy1M3M1RvcXEQZH0gLmwHsV8qzAYurJttITcX5Os1KQR/ewQa2UzocSDiV/vxjTCEY4IVuE9Xwt8Y0g2Dwu6V6zfKn4T9TViTryDwjIbKVCfoBjfJRDUq1v2r7Ws6c+cQobF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf+uThNRlIy7TBh5VHVhtwzmg+V07qQHFn8E8Dq00O0=;
 b=Hbnz43KxUdW44Ch4IUCG6OXSShvSHHS5EheWrp4jPE4sWT4FY1YnJOEwo2paq46ihkisJXg5SajvcjPKuwMDSQL3+NaU16OGNsowWXfrzltd2xClISZMPqnfprcEO2k/AIgERc/2DzXWCDYt0iXBJmBQbK2jiUWGn87fpCW6TEJygR9QX/WPqRrLGJlcalAzn2Hz4mHr66FnAa04Pa4d2EdNJvhgsL0qUOm4fb8Vtdf9vlUA5tg3/O1ZWL6TZtErsFveBdseiK5magVGIpliKN67eX3r3zkeT0Wt0cNXr3rRgC5JmEa27bXl6iqYKDzN/3U8Xp9Do2Xw8gvNh/JwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf+uThNRlIy7TBh5VHVhtwzmg+V07qQHFn8E8Dq00O0=;
 b=AaYlUZnNCdOY6dy+9PNUg47SloQZZ3p/vJYho5GgcYehc1y/4yZf/+gvSiYFajlDh8+YbHT/G/NAI+h3dgG+EC1stuy6PwiWY7yuvzh0/vnMFmXAmCPvJXShkEcm4TCCbT4rxpajegc3/am/cyeEPFBR9BR7iTT70ZEB3cSmAvP+nP2ydKGFTacSblVjy2d/UF/Hy5OXIQJbfF5WfhrX5MRBxvRM16qhEzwjW8dKAk1lTggP5QOhQP8nHrWrFX7bWcV1r1bh0yvQKTR9Gbx2c1o9xYNofOjZDjhqm5eqOG/QMFTVAVYOYyoI6cK0avVEeBD96TH+AzhsoYRBOM5XHA==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 23:26:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 23:26:11 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Joel Fernandes <joel@joelfernandes.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: Re: Handling large numbers of hazard pointers
Thread-Topic: Handling large numbers of hazard pointers
Thread-Index:
 AQHcbIJJolJ1KBXZHEWgN4L0FEUAXLUgbE+AgABC8y6AAApbEIAAbJMAgACU44CAAA34GA==
Date: Sun, 14 Dec 2025 23:26:11 +0000
Message-ID: <EF62E36B-7A3E-402F-ADA6-A1D443DA0ECE@nvidia.com>
References: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
 <31331836-E9F9-46DF-A8EA-010379A56677@joelfernandes.org>
In-Reply-To: <31331836-E9F9-46DF-A8EA-010379A56677@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|MW4PR12MB7286:EE_
x-ms-office365-filtering-correlation-id: 7475e75a-60ee-4973-926d-08de3b682abe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDFEZ2h1VkZHWXNkSlRkQ2JkVkxzbjhOcGhOMWM5Q1QvNHNrcVFlM1pkUjhz?=
 =?utf-8?B?aGVab042bG1ZUkRNTjdHRER5aStkeUZUbkU5OEZtRFRtQ2QzZk5QdzdqT2Jm?=
 =?utf-8?B?UzI5K3ljcXRtYi9kT2VSSU9xUVJ0eGVsUXRRSU8wV1paVkpnVXJzaVJ5TFYx?=
 =?utf-8?B?Umo3ZDdaSTRXSTZGcll2U3BGVTR4SisyYi9kclBMdG5oSVRJTVlYd2duNmFQ?=
 =?utf-8?B?MzlNMDdSbndqUk90SUwxOWZjL0s0ZnJyMXgxb3l4VE5jYmRObmVDbGc2T0ty?=
 =?utf-8?B?aWViMjdteExydzMrUnJTS3p2d1MrSXh1QmNMbU0xZVhTOWd6YW1JaUN4dEdZ?=
 =?utf-8?B?QnNWTkZ6Z3B3UFE1OVd4eGVidlJDQ25kRE5vK3JpN3R5WktVcmtYSXRQSHlB?=
 =?utf-8?B?SDNBbUxFQlhra2ZyZUFpWSt3dnpSVUFERmcxNUZ4U2tDQzF6MStsYkRUVzg5?=
 =?utf-8?B?UDR4L0gwMHNZT0htT0w1cWdXK25BaTZ4YnRJSnd4NGdMc2owdVk2Z0VLYzRH?=
 =?utf-8?B?UGMvM3lYZml3Q3NONHlDalNreVMwVmtzZnQ3cHpkbFhzZ0ZnOURYNmtqbmp6?=
 =?utf-8?B?SlF0ZnJieDVhN2VhOUtVOHlyQmJGdjFScmUreEdETUFjdEpUYnFOSDVaeFI3?=
 =?utf-8?B?a2VaYmNCVmp1eWduRVhZdTloZVlwZjc1TVY5STF2N3p6NTc5RUdzRFNJbzZl?=
 =?utf-8?B?RElrMzRSa09RNVV6dVlWWmRUVEhXUDNwQS8xZDhNMG9UQWIzNDZNaHBUd24y?=
 =?utf-8?B?Z1BPS1pOS0p3WGQvWjRKOE5jbWdGRW9HMHl4K05mdWJNcjEvWW43TWtjVGZi?=
 =?utf-8?B?dXlUWkpKMmU4eWdjakdzcGUwZTFQUEpxeWZUNDE4MUFkTTdXNUVHWmVwM1NI?=
 =?utf-8?B?QTRoYXB1Rkloa1BZdnZkVWFlOVRNVFUzb3Nxczg2VWZTN1FzN2haK2ZsUjRn?=
 =?utf-8?B?VURUT3dtSmVqRUlqeEFOT3pJSTZ4bm8vZTJid2NkRW0wNkRxYjZ1VnRiTi9U?=
 =?utf-8?B?QmpoZm9LMEJhb1hIRzBEeXYyNHB2bFlsSzFPc1k2YjhLVy8vWTA0d0VKRjh1?=
 =?utf-8?B?MUJJS1U1cjVreWxoQXlJenZzMTJBQ2dSSDFjSFRyQjFsa1hsb010U1AzMXln?=
 =?utf-8?B?d2c5SVlGRHZJajEwUWFZOHZzeWVmSHZxV3hlTGJXd1ZYZlYyTlNQRENSRDF2?=
 =?utf-8?B?aU9CbWRhTEJoUENybm5JcmVEaU11bVZzVmszTE0yYXE1SDZXOGFJaVk1ZlNo?=
 =?utf-8?B?bjYwWHg5OXFMSVhaVjlJUENYQTVyekZiVHNyQVpnQTZwaEQ0NDRhSHJMYTY4?=
 =?utf-8?B?RUprMTBGZmk0dk5EYzBBK0oxdmVHbVhIcWZEeU9oN1hwSjkzd3VEblBSNG9o?=
 =?utf-8?B?K3hnTkNhQTE2ZGhxbFRRNkh2Z0xOVHlvUFFDbDNVcUx5TzNPU3Z2ZVIzMDkx?=
 =?utf-8?B?U3liNHZjVVVZT1lJLzRRUk9WTnU0dURRYncxcTg4dGhReEZaQ1UzWHUwNWtw?=
 =?utf-8?B?OGNQajFZMnJXV2Jaa0dZMFhGcHgzZU9mNzdTeW5tTFN6OWJFc0NzNUN0b1Ru?=
 =?utf-8?B?cXpZWURrL0tZOTRRMTdvamdIL0E4RjNhZFlUZFpiU0J6UFlYQnVLYmpxVm9L?=
 =?utf-8?B?MzQ0TUtTWXRaVjU3MDhsT0E1R2pRNWVFbm84eGcrNlZvalRQeXBJc2RaNHhS?=
 =?utf-8?B?L2RxR3hqcVBXMmxLVG1XZEZLbE5OcjNTcEpMSHJoWGFTajhDT0VjandEUm1G?=
 =?utf-8?B?Y1NYTEZYSmRCSjdKMnl0N1gyRWp1YmpicmsvdkN5VW1Cdnp6NVM2cjBGblZF?=
 =?utf-8?B?TGczSS9BRmplWjlWRlM2UzlEMmVlU20yM0QzVXBJWTNSM2N2V3lCWWpDejFJ?=
 =?utf-8?B?N3ZjZHl2OGlVTmR0VDYwMXJ5WXJ6ZXRsbWdISU9TclRzeExxWE9FaUhIR0RC?=
 =?utf-8?B?WEI3Z3pBK1lteDZwQXN4TnhKamo1OGtReUNBUUdCU0s1MTJRTkZpcWhueW5x?=
 =?utf-8?B?d1BocG4wRENHSHA4ZlRSUTRpaE1henFEVVJKM2JCdjNFZE5NTzVSZzdhSEdO?=
 =?utf-8?Q?sGEiAj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N29ZNkgzRjNhYW9XU2VUaVc2L3JJT2tWSXg2S043c3BLVFF3TkNrbVhYakx0?=
 =?utf-8?B?OFNTUms5UkJ6VHlMRGFDRnFWVjRkNjNxV3Y0dVYxVVJESWlwMjloR1M0ZHcw?=
 =?utf-8?B?NFFtaW5hcktQdFlHUnQybnNmbzBuLzlZNDYzT1BOR0ZNbStOQlQ3cWtUY0d1?=
 =?utf-8?B?RjJrTmRocDZMVTNmcXF3bUloclhmaEZ6VHpEK0NBNndCU3ArNFNQdXdaODZ2?=
 =?utf-8?B?K2VCUk1yVC9qWEh3VWxUWWRmZnRoRTFodjJXQWZKMFRtcURZcnlXZGE5MEhK?=
 =?utf-8?B?YVNqUUV1M2h3MS9HWlR1djkzcWRTandOZUs4K1BtbDVRYmpDZlc0NW5qVHlE?=
 =?utf-8?B?UUVSYWdFSFcybHdvcmw5alptZDRxVXBLbmE5RHJLS1Q2cnNIK3NBc0syQVhn?=
 =?utf-8?B?Uy9BUFIrT1ZXbm9INDI3Sk80ZDkwa3pVZC85STQzOGs0TEEzSTNwMDFVUmZP?=
 =?utf-8?B?R2d1Q3BKMGZxaU9tdTRFakFZNUFvYXRZZGVvNjkxWUVneURpWkxSaUlnNXAz?=
 =?utf-8?B?V005ano3WkdzTk9kWUN3VmhGdkI3bE9Zek5zbnV3QU5KZ0U1VFJsYkRtdzV4?=
 =?utf-8?B?MllJd2t4OWdQZ25HTkRFY3pYb1E3ZWZJZmdTa2QwclpPQlN4VFdIdzFBVHc2?=
 =?utf-8?B?bG5JMVNTM2NQZnRZakJEU3pNTEY0MG5neURjRUZPQ01Sd2Fyb0pEakpDTWlJ?=
 =?utf-8?B?RWxycHVUbzVhWGs2ZjY0UE9aTGFyWm56bS9ReEFYL0hyQXQ1Zlg2bmQ3R0tG?=
 =?utf-8?B?ODFDbUtib2pKY2pYRzQwU2lhQ0MzUFRhSFRoR2RKNUZjWCt3NzBaNTVodDgz?=
 =?utf-8?B?aURTbEljOW1CUFVTL09URmIzcEpnWjdhdUVFSFVGYS9jK0JoQmEwVlVyK0Vp?=
 =?utf-8?B?V0VzQndDY0VOdjJWVGtoeThhWW42MlpteGpQcm1mUUovNFowMlltTVA5M1J2?=
 =?utf-8?B?WURSUVFiU3U2RGdzZDVCNXhJOXRLeDdrNXh6SUtEMFR2SVErdFFCWVdaOWpq?=
 =?utf-8?B?WXBpZ2VtQ25GZytWVzVaV2kyL0hIVlRlRTJHdXRjUnRjTzNYcmVMaEtBak14?=
 =?utf-8?B?OEhKeU1zUjg2VGp5eUd1azg5czRZanNOMlVNUzZjMVlpU09sWDlLWkxlVDcz?=
 =?utf-8?B?Y2Q5VVptejRYemlCbC9BLzRnRjg2VXo3RllYTFZJVld3RFdMTFlsRnJ2RGJT?=
 =?utf-8?B?a0N0c3I0eVpVRlNUVlVTVHUwNk1JdEJXUG1tcEREa0NRSUs5WVp2WEUzUC83?=
 =?utf-8?B?VHk2M3JNdlQxaUJuZElGdXU1RTA4UEI3b3A5T1BkbWkvVmNjRDd5cmQvSlAz?=
 =?utf-8?B?QzhoYTZIK1MrNENyRUp5U2FSbjgzWHNldnAvcGtXQk54dENZcStYaVlFK2Vq?=
 =?utf-8?B?b2pVaWYyNTdZK3RVeldBeGFxWkU3Skdwak5SL1hTL2hYZWpLL3ZhbEVydzFp?=
 =?utf-8?B?NjF0aHVwWXFwUFFKSksrMEY4STMzV3kvQmRUOHVsbjBZaGVydjhlbW0wRFU5?=
 =?utf-8?B?WE85VExma0dYVnQ2M0RjcUFGM0Z2L2M5dG5ZekhWOENsS0t5STlHbTZVMTVr?=
 =?utf-8?B?WVFnZml5azY0ZTM0WXBMYzFLaUkxRkJjQWFIZy9Ya09jL2FwRXBLSHpsRXpY?=
 =?utf-8?B?bGhXcU1PaW9xZTN1N2dCNWlJNmtPV1RjM2RsNWhsZFFhek5UUlRIYWF0TnMz?=
 =?utf-8?B?RzdGdmlWYkE3TFBlVkY1Z3NxaUlxNzBRZ1VxLzlqdWs1WHg0aDJBdE15M0M2?=
 =?utf-8?B?dWpKeUgrNGFEN1FMSFBicDdUNk8rblZBSVQxSHhqSllPWTJ4Z09zdkFDd3VZ?=
 =?utf-8?B?RW0vOGxzK3pvSXZOVHYxUWltbWpRQml6Y1dpNjhXUWZtL3RTcE4vejJ2RGow?=
 =?utf-8?B?Z2hBeVZ2eC9mQnU0Z1luemJLMi9xL3luK2wrVFVUU00zUG5LMHE5NFB6bEZ1?=
 =?utf-8?B?UUhyOEZqd2RJak9zVGhPTlNtdUZodVIzV2lLaHlSdlppd29Da3loQk5uNnJ6?=
 =?utf-8?B?NEErdzVKUC9YeC95akE4dU5hN1VNN0wwUVprMXQ4MFd3RURHK1ZGcUNQN2VQ?=
 =?utf-8?B?T1FwWUpwWG9nbGZtMXE1STA3bW5LRmtFOSttOUt5MHVJT2ZDNVpobjVzcFZU?=
 =?utf-8?Q?CmCU9aT2HCMPWFfpmL7mbbSAA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7475e75a-60ee-4973-926d-08de3b682abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 23:26:11.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXMcBN3ycG3LRbHTjpuyWHHrnInIbJBoWkjQ9HdoUs2w0jtm13k1aPoucCFJqDHADAXMjau8NQ36GzJ/RX/xcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

DQoNCj4gT24gRGVjIDE1LCAyMDI1LCBhdCA3OjM24oCvQU0sIEpvZWwgRmVybmFuZGVzIDxqb2Vs
QGpvZWxmZXJuYW5kZXMub3JnPiB3cm90ZToNCj4gDQo+IO+7vw0KPiANCj4+IE9uIERlYyAxNCwg
MjAyNSwgYXQgMTA6NDPigK9QTSwgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbT4gd3JvdGU6DQo+PiANCj4+IO+7v09uIDIwMjUtMTItMTQgMDI6MTQsIEpv
ZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4gWy4uLl0NCj4+Pj4gV2UgaGF2ZSBoYWQgc2ltaWxhciBp
c3N1ZXMgd2l0aCBrZnJlZV9yY3UoKSBhbmQgcnVubmluZyBvdXQgb2YgcHJlYWxsb2NhdGVkIG1l
bW9yeSB0aGVyZSBtZWFudCB3ZSBqdXN0IHRyaWdnZXJlZCBhIHNsb3cgcGF0aCAoc3luY2hyb25p
emUpIGJ1dCBmb3IgaGF6YXJkIHB0ciBJIGFtIG5vdCBzdXJlIHdoYXQgc3VjaCBhIHNsb3cgcGF0
aCB3b3VsZCBiZSBzaW5jZSwgc2luY2UgdGhpcyBwcm9ibGVtIGFwcGVhcnMgdG8gYmUgb24gdGhl
IHJlYWRlciBzaWRlLg0KPj4+PiANCj4+Pj4gUGVyaGFwcyB3ZSBjYW4gYWxzbyBwcmUgYWxsb2Nh
dGUgb3ZlcmZsb3cgbm9kZXMgaW4gdGhlIGFwaSBpdHNlbGYsIGFuZCB0YXAgaW50byB0aGF0IGlu
IGNhc2Ugb2Ygb3ZlcmZsb3c/IFRoZSB1c2VyIG5lZWQgbm90IHByb3ZpZGUgdGhlaXIgb3duIHN0
b3JhZ2UgdGhlbiBmb3Igb3ZlcmZsb3cgcHVycG9zZXMsIEkgdGhpbmsuIEFuZCBwZXJoYXBzIHRo
aXMgcHJlIGFsbG9jYXRlZCBwb29sIG9mIG92ZXJmbG93IG5vZGVzIGNhbiBhbHNvIGJlIGNvbW1v
biB0byBhbGwgaGF6cHRyIHVzZXJzLiBJZGVhbGx5IGl0IHdvdWxkIGJlIGdvb2QgdG8gbm90IGFs
bCB0aGUgYXBpIHVzZXIgZGVhbCB3aXRoIG92ZXJmbG93IGF0IGFsbCBhbmQgaXQgdHJhbnNwYXJl
bnRseSB3b3JrcyBiZWhpbmQgdGhlIHNjZW5lcy4NCj4+IA0KPj4gV2l0aCB0aGUgcHJlYWxsb2Nh
dGlvbiBhcHByb2FjaCwgaG93IGNhbiB3ZSBndWFyYW50ZWUgdGhhdCB3ZQ0KPj4gcHJlYWxsb2Nh
dGUgZW5vdWdoLCBhbmQgaWYgd2UgY2Fubm90IHByb3ZpZGUgdGhhdCBndWFyYW50ZWUsDQo+PiBo
b3cgc2hvdWxkIHJlYWRlcnMgYmVoYXZlIHdoZW4gdGhleSByZWFjaCB0aGF0IGxpbWl0ID8NCj4g
DQo+IFN1cmUsIHNlZSBiZWxvdy4NCj4gDQo+Pj4+IA0KPj4+PiBJIHRoaW5rIHdlIG5lZWQgbm90
IHdvcnJ5IHRvbyBtdWNoIGFib3V0IGNhc2VzIG9mIHByZWFsbG9jYXRlZCBvdmVyZmxvdyBub2Rl
cyBpdHNlbGYgcnVubmluZyBvdXQgYmVjYXVzZSB0aGF0IGlzIG5vIGRpZmZlcmVudCB0aGFuIHJl
c2VydmVkIG1lbW9yeSBuZWVkZWQgaW4gYXRvbWljIGNvbnRleHQgd2hpY2ggbmVlZCBhIG1pbmlt
dW0gb2ZmIGFueXdheSByaWdodD8gQW5kIHdlIGhhdmUgYSBib3VuZGVkIG51bWJlciBvZiBDUFUg
YW5kIGJvdW5kZWQgbnVtYmVyIG9mIGNvbnRleHQsIHNvIHRoZSBudW1iZXIgb2YgKmFjdGl2ZSog
bm9kZXMgcmVxdWlyZWQgYXQgYW55IGdpdmVuIHRpbWUgc2hvdWxkIGFsc28gYmUgYm91bmRlZD8N
Cj4+IA0KPj4gU28gdGhlICJzaW1wbGUiIGltcGxlbWVudGF0aW9uIHByZXNlbnRlZCBieSBCb3F1
biBhdCBMUEMyMDI1IHdhcyBsaW1pdGVkDQo+PiB0byBwcmVlbXB0aW9uIGRpc2FibGVkIGNvbnRl
eHQsIGJ1dCBpbiBnZW5lcmFsIHRoZXJlIGlzIHJlYWxseSBubyBuZWVkDQo+PiB0byByZXF1aXJl
IGhhenB0ciB1c2VycyB0byBkaXNhYmxlIHByZWVtcHRpb24gZm9yIHRoZSBlbnRpcmUgZHVyYXRp
b24gb2YNCj4+IHRoZWlyIGhhenB0ciBwcm90ZWN0ZWQgY3JpdGljYWwgc2VjdGlvbi4gVGhpcyBt
ZWFucyB0aGF0IHRhc2tzIGhvbGRpbmcgYQ0KPj4gaGF6cHRyIGNhbiBiZSBwcmVlbXB0ZWQgb3Ig
YmxvY2tlZCwgd2hpY2ggaW5jcmVhc2VzIHNpZ25pZmljYW50bHkgdGhlDQo+PiBudW1iZXIgb2Yg
Y29uY3VycmVudGx5IGFjdGl2ZSBoYXpwdHIgd2UgbmVlZCB0byBwcmVhbGxvY2F0ZS4NCj4+IA0K
Pj4gU28gSSdkIHJhdGhlciByZW1vdmUgdGhlIHByZWVtcHQgZGlzYWJsZSBjb25zdHJhaW50IGFj
cm9zcyB0aGUgZW50aXJlDQo+PiBoYXpwdHIgY3J0aXRpY2FsIHNlY3Rpb24gaWYgaXQncyBub3Qg
dG9vIG11Y2ggdHJvdWJsZS4gQW5kIGl0IGFwcGVhcnMNCj4+IHRoYXQgYmFja3VwIHNsb3RzIHBy
ZWFsbG9jYXRpb24gaXMgdGhlIG9ubHkgZnVuZGFtZW50YWwgcmVhc29uIHRoYXQNCj4+IHdvdWxk
IG1vdGl2YXRlIHRoaXMgY29uc3RyYWludCBzbyBmYXIuDQo+IA0KPiBXZSBjYW4gcmVtb3ZlIHRo
ZSBwcmVlbXB0IGRpc2FibGUgY29uc3RyYWludCBhbmQgc3RpbGwgbm90IHJlcXVpcmUgc3RhY2sg
YWxsb2NhdGlvbiBieSBzaW1wbHkgZW1iZWRkaW5nIG92ZXJmbG93IG5vZGVzIGFuZCBhbnkgb3Ro
ZXIgY29udGV4dCwgaW4gdGFza19zdHJ1Y3QgcmlnaHQ/IFRoaXMgaXMgc2ltaWxpYXIgdG8gaG93
IHByZWVtcHRpYmxlLXJjdSB0cmFja3MgcmVhZGVycy4NCj4gDQo+Pj4gLi4uIEJ5IHRoZSB3YXkg
SSB3YW50ZWQgdG8gZW1waGFzaXplIG15IFBvViwgdGhhdCByZXF1aXJpbmcgc3RvcmFnZSBwcm92
aWRlZCBieSB0aGUgdXNlciBzZWVtcyB0byBuZWdhdGUgb25lIG9mIHRoZSBiaWcgYmVuZWZpdHMg
b2YgaGF6YXJkIHBvaW50ZXJzIEkgdGhpbmsuIFVubGVzcyB0aGVyZSBpcyBhIHNvbGlkIHVzZSBj
YXNlIGZvciBpdCwgd2Ugc2hvdWxkIHByb2JhYmx5IG5vdCByZXF1aXJlIHRoZSB1c2VyIHRvIHBy
b3ZpZGUgc2VwYXJhdGUgc3RvcmFnZSBJTUhPIChvciBtYWtlIGFsbG9jYXRpb24gaW50ZXJuYWwg
dG8gdGhlIGFwaSBhcyBJIG1lbnRpb25lZCkuDQo+PiBJIHRoaW5rIHRoZSBzb2x1dGlvbiBJIGhh
dmUgaW4gbWluZCB0YWtlcyBjYXJlIG9mIHRoZSBuZWdhdGl2ZSBhc3BlY3RzDQo+PiBvZiBwcmVh
bGxvY2F0aW9uIHJlcXVpcmVtZW50LiBIZXJlIGlzIGhvdyBpdCB3b3VsZCBiZSB1c2VkIChzZWUN
Cj4+IFsxXSBmb3IgdGhlIGN1cnJlbnQgcHJvdG90eXBlKS4gVGhlICJiYWNrdXAgc2xvdCIgaXMg
d2l0aGluIHRoZQ0KPj4gc3RydWN0IGhhenB0cl9jdHgsIHNvIGZyb20gYSB1c2VyIHBlcnNwZWN0
aXZlLCBpdCdzIHVuZGVyIHRoZSBob29kLg0KPj4gDQo+PiBUaGUgdXNlciBqdXN0IGhhcyB0byBw
cm92aWRlIGEgY29udGV4dCB2YXJpYWJsZSBvbiBpdHMgc3RhY2suDQo+PiANCj4+ICh1bnRlc3Rl
ZCBleGFtcGxlIGJlbG93KQ0KPj4gDQo+PiB2b2lkICpwdHI7DQo+PiANCj4+IHZvaWQgZmN0KHZv
aWQpDQo+PiB7DQo+PiAgIHN0cnVjdCBoYXpwdHJfY3R4IGN0eDsNCj4+ICAgdm9pZCAqYWRkcjsN
Cj4+IA0KPj4gICBhZGRyID0gaGF6cHRyX2xvYWRfdHJ5X3Byb3RlY3QoJmN0eCwgJnB0cik7DQo+
PiAgIGlmICghYWRkcikNCj4+ICAgICAgIHJldHVybjsNCj4+ICAgW2NyaXRpY2FsIHNlY3Rpb25d
DQo+PiAgIGhhenB0cl9yZWxlYXNlKCZjdHgsIGFkZHIpOw0KPiANCj4gQ29ycmVjdCBtZSBpZiBJ
IGFtIHdyb25nIGJ1dCBJIGFtIG5vdCBzZWVpbmcgd2h5IHN0YWNrIGN0eCBpcyByZXF1aXJlZCBp
ZiBjdHggYW5kIGFueSBzcGFjZSByZXF1aXJlZCBjYW4gYmUgcGxhY2VkIGluIHRoZSB0YXNrIHN0
cnVjdCAoYW5kIGhpZGRlbiBmcm9tIHRoZSB1c2VyKS4gRm9yIGludGVycnVwdHMsIHdlIGNhbiBq
dXN0IHVzZSBwZXIgY3B1IHN0b3JhZ2Ugc3BsaXQgYnkgY29udGV4dCBsaWtlIHFzcGlubG9jayBk
b2VzLCBJIHRoaW5rICh1bmxlc3Mgd2UgYXJlIGdvaW5nIHdpdGggdGhlIHdpbGQgY2FyZCBwcm9w
b3NhbHMpLg0KDQpPaCwgSSBtaXNzZWQgdGhlIGNoYW5jZXMgb2YgZGlmZmVyZW50IHRocmVhZHMg
cmVxdWlyaW5nIHByb3RlY3Rpb24gb2YgZGlmZmVyZW50IHR5cGVzLiBNYXliZSBpdCB3aWxsIHdv
cmsgaWYgaGF6YXJkIHBvaW50ZXIgc2VjdGlvbnMgY2Fubm90IGJlIG5lc3RlZC4gT3Igd2UgY2Fu
IHdpbGRjYXJkIHRoZW0gb3Igc29tZXRoaW5nIG9uIHByZWVtcHRpb24uDQoNCkkgYW0gZ29pbmcg
dGhyb3VnaCBhbGwgdGhlIHByb3Bvc2FscyBhZ2Fpbi4NCg0KIC0gSm9lbA0KDQoNCg0KPiANCj4g
VGhvdWdodHM/DQo+IA0KPiBUaGFua3MuDQo+IA0K
