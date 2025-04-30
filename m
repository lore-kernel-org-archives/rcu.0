Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FE1494CC;
	Wed, 30 Apr 2025 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979637; cv=fail; b=o5ObGnl0E69Wi4nT257py+CD3wUzsbguAkdNiB48dV9DG/GikamdqRQ+3vmt1f38wAWa/chEqv+5BJTU4zmPT5+6RYDSoB5T5OQOy+4Capgo1EpqmPIoIEbrODdrIDF/R64HmOee3qmbX6PjPVirWKmroFhMqHBr5VfGgGUpGjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979637; c=relaxed/simple;
	bh=FPlXRs+5SjZOyM1MUBVoFNwrFoObyduYiHH80N1hn9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YV4CfNSreTNjjcCLJajiwbQ5vHMJ76vgDMyF2rMcWR+Lfw8174zeMMfvDvwPTy/Q33epoS1bnD/jvI+X38IDNEtRpeVP/jmsrXS7bZXn2eeJD4qQ2B9x0xG/9b3puXBQLMgLL3OZ3/TOkQ8ogE8srmz1TGtrY0zgn6vtLQ53ha0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=of4PMtKq; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="of4PMtKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvjBV6MDdh3sAsPon1ktl0MDfDl82lcgfYRwnKUIyRco2r0qvOxP3puyOSzNwBzqzS7NxbB3XD+Yq1wJjN7uoF+paV0/+xqPBLzrKwUk1wojhrfUDnjGE8QQh+vzrCuqBObAs4C8HYwCc7DjP1ZRozHoDgijcYTlKsZLl3aApRfN41sptnNrri8CcwrTlGIjquHAU2FlhZLuDwaNvTai67Ujz+Z0qJ0yqmmrJonTwARwFFoI6p8uLl6/sO9wq+H7aABsI3oTLtjFVVL+oteQVD7subpFTVqaUS36lptq+yXUI27lYd8OcrcKaxd/XOct+8jKyhbsYY2Lg5JLtjRMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPlXRs+5SjZOyM1MUBVoFNwrFoObyduYiHH80N1hn9Y=;
 b=rOh5Mhs7BbWKC5ve2lhKf18OsfU97N5QRmUtTzMTlNfdqvb/qo9yu4hehBdYkpt24EYHpi1H4Sv8pX9uStyNVbiTR0muAjvn9HMIXmczf/DaK1iclUDWPctY9Jz3n/GCgoB04Id4RUyp0M8/fSvj6VPva5BMWrFiVgiXe3IfWEZd1/5Q+nhVVsqGMYcfb0aPLrPefMqUvU2s2WNcMhKl+1mheee2SKADuEAqDtC2HUfwOC3Nan/DgSmmQpTOOky/VOy+Hh58VEXdqrdMNAXbRW0YJg6YPIY8pvZxC8EY/B0fPA0tyydHJFUhx8p2ISrLmt1JrHvbJFXG7MRbz0k9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPlXRs+5SjZOyM1MUBVoFNwrFoObyduYiHH80N1hn9Y=;
 b=of4PMtKqVHh3rboW1Qq24o6d2uBD89MNpC0W7Zf9lLlmG3P2JdY+4oR0JP5nZGw76PMDI3oIgmtBwouLEVfw0kB/L3yaBLFIvhkXT5dC/JZW+g+nYAKWPooPcShW7JndpF0TVQx6FOgSUBHyD1LmSByrPcSikwhhspPSQCY8bhFXExMtXzlatNdmp/Q8nG8CONWRA3oC/rDBFelF7V/Fc9i6Zxqfr+0BQ/Ud6FSf1iLdj1lwDm5ksf2d4gott5kHHDq726YW3JQXx9/jj/85dHFSUX4sIOoMOC0r5oYUTwONGA4g/66q7DEQxD4BHNnMDzQQxuqD1yTQV1N8VIUX8Q==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:20:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 02:20:32 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Paul E McKenney
	<paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Zqiang
	<qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>
Subject: Re: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
Thread-Topic: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
Thread-Index: AQHbuQyvmf5VhHGEGkWMHjVV468LWbO7eszi
Date: Wed, 30 Apr 2025 02:20:31 +0000
Message-ID: <8609B469-5CB0-4EBC-94D3-FE3F90697ABC@nvidia.com>
References: <20250429134304.3824863-1-frederic@kernel.org>
 <20250429134304.3824863-6-frederic@kernel.org>
In-Reply-To: <20250429134304.3824863-6-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8977:EE_
x-ms-office365-filtering-correlation-id: ab0ddf01-8c7c-4841-f891-08dd878d953b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGwwL29YTGk3U2lZeG85OThXbjBTQTdEUXNkMUVXbHJCekVxUklBTm5YMFZh?=
 =?utf-8?B?S3UrUVdmanYxL3VGL0RQdXV6V2ZDZzNtbnY5K09mQ3ZlT01YYWJSUzQwV3lq?=
 =?utf-8?B?bEIvQlBZb29HdHh1UE85b2pMK2FsWXFXNlllaU54ZHYyZGxzSW5MWHFvMEt3?=
 =?utf-8?B?MDlJZWdnZnVkSUFGRmo3dDhuZ29wSkZ0Y1lnamw1cE1xRy9jZUk5WE1hWTJa?=
 =?utf-8?B?UWhCN2cvT0pOa0xoY0gyT3QxUFArdE1LRzRHLzNOMmZ3SFBIZHZuOFlYV05n?=
 =?utf-8?B?RzUwZE9pNzcwNmQ4TGpya2hPZFNFRGE5VVM3MVRNVjQvNWJDV05mUWZIcWQv?=
 =?utf-8?B?azZBSFQ0VzlhQnRQU2M5LzM4OXVQcHV5NGR5cHFqaTRDUlJKK096UGRkUkVk?=
 =?utf-8?B?bEd1VmxETlM3UGoyZ3FiKzBKMXpsYjliRGEwclpNSndJSjNSNEozcUFmNyt1?=
 =?utf-8?B?clNTWmRhdnBqREFzNXFoRFJzOER0ak9hZGN4U1hQKy9OamdWbVlHWUdxeEQv?=
 =?utf-8?B?WDNDWVZHUnFwSGpRWkhqdTJDUW9WQkhhOEpRUGVGWVk3UlRzRkF0R3dKdnNM?=
 =?utf-8?B?SDN4bTBpNDhnMkNCMHRRV0FNanJrWnRkemlwSlFVVEFsc1hpRkFzTHhBNkh3?=
 =?utf-8?B?SDZkUk10V1lxWnE2YWhuOHdjRTBaNW5DcitrUU0zVDZKWnIvN0h0Q0FVZzZR?=
 =?utf-8?B?Z3R0eTBrV0FLNjE1R0xma3VHQU9HWFVMbFhVaHFjTXdOZG5FYUpUWEhVQ0Zk?=
 =?utf-8?B?RytRQU50UHRFR3NwditIWEF1ckVXMXh0YlVCcXcyQzJZTEFGSWt6bTBlaWpl?=
 =?utf-8?B?eThHOWd3ejhzOXRyVGN4WGZVR1VUbmg4ZEVyTG1IV1lkTHUvTkhxZUZzODJO?=
 =?utf-8?B?TWZyVXlUQVVxZDQzNzFwTjRiVlEyL2RQNU5NTE4yb1gxQml2MC9IRnk0QUo5?=
 =?utf-8?B?Rnd5bWQ5ZzA1cW5RN04xZnNTMUZEdnVFUDdWMVRHUWlwQVRSVkpBeXNoK3Zy?=
 =?utf-8?B?cS9lemxwRjA4dWFJS2hkNnkzNnlhUmNDNUtWSlJCK3BUanR3Zy9Ga3puVkVR?=
 =?utf-8?B?VzBBRENjRWUxUFVTOHFYZG9kU1MvNXIrOU5jYjd3R2V5N0t0Qm9HZzhTOGc2?=
 =?utf-8?B?ZmxCeS9hRUNSc2pBL3VFV0FLT2FuYWVsSHU5VFlNdkJKSWNGbURicFpnZmJi?=
 =?utf-8?B?SlhJR1JDNWpRcUoyWTUyRm5odGp5QVFKTTREOTgreEpBMG1INmdiY3JyUWRS?=
 =?utf-8?B?WDd3dEVqQkUwaHUyVHVNTnRXQzV5YmtwdXl3eEFSbVNnL3NQaTlpZWYvNUNG?=
 =?utf-8?B?WFFmSmJia1RtMlBkZ2xDZ3lHOFdKTGEySThOc0FOK2lqL29mVWxab1p4aTZV?=
 =?utf-8?B?QThOa0dRdThxTWZSUndBd2hrMXpEU2RlTERraDJFY3BzS3I3My9Tb2JSc1pY?=
 =?utf-8?B?QzVrTHoxeForenV4OURqTjF5ZFhlVGhDQzlsVnpyYTdTNi9sUExOYlB3ZEVo?=
 =?utf-8?B?ck9TRnExL3FWZ21vMVlFazFuR0llWkFoZ21DYkU0dU10Qk43Q2xlZ3AzR2Vy?=
 =?utf-8?B?Rm1QTWhyZGpMY3dWaWlrSmFuWDNqdlNIci9iMExHVWxPdnpsZElZOTlQQlQw?=
 =?utf-8?B?R05pS2tWU1JLTElhS2hVOEFheG9CSHM4WTBoVnJVUWduYk9FYUo1RnY1VGxy?=
 =?utf-8?B?cjN1R0lnSkUwZFIrT25iUFNLbGxUZHhTSW1PeC9TNFNHY1h3NEtZRXpmT3hj?=
 =?utf-8?B?QTlyWUVLZ0ZtaGN1dXVmUTlrejkvcDF3eTNNYXJLZGRrVmpVQTRmZU91bEhu?=
 =?utf-8?B?VlNxdG1GUm8rTWVxaEQ0dDBqd0VaZDJST1R0b0ZZczYyS0RZMWlrUGE0V1Z1?=
 =?utf-8?B?TENGMFdvVE9kNTJNQTBEazlpTTRRZVdVN0dUVjdMNCtjb1ZUZVQ2UnJxV1Q4?=
 =?utf-8?B?MU55N2tQR0FGYnN0cXh4QTZQL3pYQXJHc3dFMFZDODhFZ3RHWjF1andmT1FH?=
 =?utf-8?B?L29hRUszOHhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHRnZDR1VjNZMFJNUGtaR3VabzRPdVFLN2dEOUhYZnhGOVYzK3p1aVhBbTRq?=
 =?utf-8?B?SFlPcVJoQnc3NWNQbHBSWXBFTzNGZHlIQnFyeXVZUWVSZ3BLcVNSTm1TdXJk?=
 =?utf-8?B?ZUhLaEJLcWJFNTBERjdtcFdrVE54YUFtMFp4TVN5VkVmTTBqdXhnMzNYVkp1?=
 =?utf-8?B?azdJTlJCYVBZNWxHcCt5QUhjM2hUZGh2NXJHd2QvY2oxRG14Y2pUTml1WDVm?=
 =?utf-8?B?SlJ2dXRDdW9zRW9FWjRoVnRObWFPTzJBM0hHSElZVk9WUDNSaDVVVXAyanFV?=
 =?utf-8?B?NDM4aEszeFRSSEF1Sk1QdHh1Q25ZQ3Q1M0x0U0lJTGZFY1llSUJPWW1ZWXI4?=
 =?utf-8?B?cmJqZVlpTGR3WnpaeUxzOFBBR2VaV1UwTFo5OElheGhlWGs5MFNHckdBUTFD?=
 =?utf-8?B?a0g5cWNJV1czQ1hodXFiZDNTYXFhbG02L1lGZ1hQWmpYQnp1MnpieXBiRjMx?=
 =?utf-8?B?aXgyanIycWJaVkRTU1d2VjR6cmNrL3JHU3ROaWxMYU0ydjFtOTNJNVlLWC8r?=
 =?utf-8?B?YXhDMUVnY2V2bXZqSCt6RXRzQWpwbFN0TFJDZEtpNTVvTnl3eENscE9hZDQv?=
 =?utf-8?B?WTc1OUN2cGttTnQ0YnlXUjhaSEEvcHp4YlVvMngvU2d2VFphNklGM3YrRG1j?=
 =?utf-8?B?ZUlCT3U2Y3dyb3BxYm1vN3gyMjJnaEFQbm9MUy9YUjI4enJ4bDUzTSt1bHBw?=
 =?utf-8?B?MXlZZTFuTUN2UjhIOTJHTTBaZmxKYnlnUG5aNEViUkRaSmZSZzA1cytTODA0?=
 =?utf-8?B?MWdhUlQ2OU45V1pPMU01NWJWNTVldlg1cFcxeXpmYktOanBjaThQWXF6ak1q?=
 =?utf-8?B?S05WVko3MTZzOGxUQW5IdGg0NFZrU1lEcmY4bmwwYWlxQVFFZTZpWjNKa0J0?=
 =?utf-8?B?SVZUemRTTHpLU3VhbXgycnZGSXpPWUoraVFXd2pDN3lGVnFpVm5NMXRqdjNx?=
 =?utf-8?B?eGNPclBuR0JRUk5LSUdhTTcrT3hINzlOZk1UcHZ3cUp1SHlpemNoR2Q1cFZq?=
 =?utf-8?B?Si85QWVZayt4UTA5VERyeEt1QXlMdS90Vmp2Z0NhUDRnRWxIdUlQVU9FeHQx?=
 =?utf-8?B?eStsU1FFR0o0YzdBQlRVWFlQVDl3Vy9uVk9rcG01YWFtZVMyTklnMUk4ZUlQ?=
 =?utf-8?B?OGwrNDloWkQ4YjM0NHJwbDRnaXZ3cWRlcjA3RnVQY2c1WEhGK21FUXJuZTZ6?=
 =?utf-8?B?Yk93aUE5cjUrS3lwSXBXRFpNUzlobTVPL3pmaW9ZbzNUL2FZa1E2OEZlWTVO?=
 =?utf-8?B?S2lrV2lhTVVoS3lXaUh5a25zM0I0d2szL3RJdUFPcXdlaHhVWUR5TWZUQ1Vl?=
 =?utf-8?B?cjliZ1UvMERMeC9HWHYyR3IzMm5TUi9jbWxLTUcxSkRBdEhhZmZKbFA1dEVq?=
 =?utf-8?B?Yk5jeGlxZFRvcmxFek4yS1hGbldOdmRxK2x1UFRpYWxWbWpiSzlvWUg1WG9p?=
 =?utf-8?B?M21LYXU3UHBpOHVVclBuYUhSc2NjRm5uQkNKTk9MbysxRTVicnNMcWpjcDNL?=
 =?utf-8?B?ZzdQc1lUbjZUSWlKdTdRY1Jld3E0VFJlQVNIeU1TcU5XRzlxbTNZano2UEtM?=
 =?utf-8?B?MEFXMEIvWkpPVU9SZjJGekdCTUlEaDVjbmRlNEx2OFRVb2NWN2p0OElESnpz?=
 =?utf-8?B?Znh2ZE1MQTlTRkpFNVQrSzQrVEp3RUVNQ1V3RnhKc1RselNBaVlmT0ZxSGFN?=
 =?utf-8?B?QTB6Z2xsampYZnRxTDBZYUk3ajkyYk51Vy9FSEJUcElJdU0zajVTOEpqWWdm?=
 =?utf-8?B?Wjk1VlJEV1o3VXVTME4zeFdUcFhvaVdMSGh4NTRCQjg5VHBMVWRVZlc3OWNw?=
 =?utf-8?B?RTMyQW5UTVk2K2xCdHVDWGpwUzBxRVcrQitkMWxtUGNVbk0xWVpYUGZneFFq?=
 =?utf-8?B?eHduV1VWSnRiUTFGcCtHSmU2NncvajIvQTY2ZUhDQ3pSY3RXa1FhUXdDaHMv?=
 =?utf-8?B?Y2s1T1UwRzNwbWI3eFNwUVQ3NU9yU1RjcU1QS1BhREZGTjZCUFp6Y0h4UWJN?=
 =?utf-8?B?NTc3NUVNb01ydCtDdGU2TFdQcytLTGFnTFl0Mkwva3k3ZmVEVkM5MStwZSsv?=
 =?utf-8?B?ZENOWnRKYUNacEUyTDIrMG50OVJnTWJVeVJQUzB2elhyL0xMdlBLNzhiVkM0?=
 =?utf-8?Q?3q2WFGNKK3vhtOsmJyWNUB2y2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ddf01-8c7c-4841-f891-08dd878d953b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 02:20:32.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud40GYO5RAQiZl7oNfBTFE/68LqoIKwQtC1+lA4b9o51KrbvPYCsWDqUTiprKMjypZO/hMqbemOK1Xf6FPl05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

DQoNCj4gT24gQXByIDI5LCAyMDI1LCBhdCA5OjQ04oCvQU0sIEZyZWRlcmljIFdlaXNiZWNrZXIg
PGZyZWRlcmljQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQpIaSBGcmVkZXJpYywNClRoZXNlIGFsbCBs
b29rIGdvb2QgdG8gbWUuIERvIHlvdSB3aXNoIGZvcg0KdGhlc2UgdG8gZ28gaW50byB0aGUgdXBj
b21pbmcgbWVyZ2Ugd2luZG93IG9yDQpjYW4gSSBwdXNoIHRoZW0gdG8gYSBmb3ItTmVlcmFqIGJy
YW5jaCBhcyBoZQ0KaXMgZG9pbmcgdGhlIG1lcmdlIHdpbmRvdyBhZnRlciB0aGUgbmV4dD8NCg0K
VGhhbmtzLA0KDQogLSBKb2VsDQoNCg0KPiANCj4g77u/QSBDUFUgd2l0aGluIGhvdHBsdWcgb3Bl
cmF0aW9ucyBjYW4gbWFrZSB0aGUgUkNVIGV4cCBrd29ya2VyIGxhZ2dpbmcgaWY6DQo+IA0KPiAq
IFRoZSBkeWluZyBDUFUgaXMgcnVubmluZyBhZnRlciBDUFVIUF9URUFSRE9XTl9DUFUgYnV0IGJl
Zm9yZQ0KPiAgcmN1dHJlZV9yZXBvcnRfY3B1X2RlYWQoKS4gSXQgaXMgdG9vIGxhdGUgdG8gc2Vu
ZCBhbiBJUEkgYnV0IFJDVSBpcw0KPiAgc3RpbGwgd2F0Y2hpbmcgdGhlIENQVS4gVGhlcmVmb3Jl
IHRoZSBleHAga3dvcmtlciBjYW4gb25seSB3YWl0IGZvcg0KPiAgdGhlIHRhcmdldCB0byByZWFj
aCByY3V0cmVlX3JlcG9ydF9jcHVfZGVhZCgpLg0KPiANCj4gKiBUaGUgYm9vdGluZyBDUFUgaXMg
cnVubmluZyBhZnRlciByY3V0cmVlX3JlcG9ydF9jcHVfc3RhcnRpbmcoKSBidXQNCj4gIGJlZm9y
ZSBzZXRfY3B1X29ubGluZSgpLiBSQ1UgaXMgd2F0Y2hpbmcgdGhlIENQVSBidXQgaXQgaXMgdG9v
IGVhcmx5DQo+ICB0byBiZSBhYmxlIHRvIHNlbmQgYW4gSVBJLiBUaGVyZWZvcmUgdGhlIGV4cCBr
d29ya2VyIGNhbiBvbmx5IHdhaXQNCj4gIHVudGlsIGl0IG9ic2VydmVzIHRoZSBDUFUgYXMgb2Zm
aWNpYWxseSBvbmxpbmUuDQo+IA0KPiBTdWNoIGEgbGFnIGlzIGV4cGVjdGVkIHRvIGJlIHZlcnkg
c2hvcnQuIEhvd2V2ZXIgI1ZNRVhJVCBhbmQgb3RoZXINCj4gaGF6YXJkcyBjYW4gc3RheSBvbiB0
aGUgd2F5LiBSZXBvcnQgbG9uZyBkZWxheXMsIDEwIGppZmZpZXMgaXMNCj4gY29uc2lkZXJlZCBh
IGhpZ2ggdGhyZXNob2xkIGFscmVhZHkuDQo+IA0KPiBSZXBvcnRlZC1ieTogUGF1bCBFLiBNY0tl
bm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogUGF1bCBFLiBNY0tlbm5l
eSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmVkZXJpYyBXZWlzYmVj
a2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPg0KPiAtLS0NCj4ga2VybmVsL3JjdS90cmVlX2V4cC5o
IHwgMTAgKysrKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9leHAuaCBiL2tlcm5lbC9yY3UvdHJlZV9l
eHAuaA0KPiBpbmRleCA2MDU4YTczNDA5MGMuLjg3YTQ0NDIzOTI3ZCAxMDA2NDQNCj4gLS0tIGEv
a2VybmVsL3JjdS90cmVlX2V4cC5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KPiBA
QCAtNDA2LDggKzQwNiwxOCBAQCBzdGF0aWMgdm9pZCBfX3N5bmNfcmN1X2V4cF9zZWxlY3Rfbm9k
ZV9jcHVzKHN0cnVjdCByY3VfZXhwX3dvcmsgKnJld3ApDQo+ICAgIGZvcl9lYWNoX2xlYWZfbm9k
ZV9jcHVfbWFzayhybnAsIGNwdSwgbWFza19vZmxfaXBpKSB7DQo+ICAgICAgICBzdHJ1Y3QgcmN1
X2RhdGEgKnJkcCA9IHBlcl9jcHVfcHRyKCZyY3VfZGF0YSwgY3B1KTsNCj4gICAgICAgIHVuc2ln
bmVkIGxvbmcgbWFzayA9IHJkcC0+Z3JwbWFzazsNCj4gKyAgICAgICAgaW50IG5yX3JldHJpZXMg
PSAwOw0KPiANCj4gcmV0cnlfaXBpOg0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBJbiBj
YXNlIG9mIHJldHJ5aW5nLCBDUFUgZWl0aGVyIGlzIGxhZ2dpbmc6DQo+ICsgICAgICAgICAqDQo+
ICsgICAgICAgICAqIC0gYmV0d2VlbiBDUFVIUF9URUFSRE9XTl9DUFUgYW5kIHJjdXRyZWVfcmVw
b3J0X2NwdV9kZWFkKCkNCj4gKyAgICAgICAgICogb3I6DQo+ICsgICAgICAgICAqIC0gYmV0d2Vl
biByY3V0cmVlX3JlcG9ydF9jcHVfc3RhcnRpbmcoKSBhbmQgc2V0X2NwdV9vbmxpbmUoKQ0KPiAr
ICAgICAgICAgKi8NCj4gKyAgICAgICAgV0FSTl9PTl9PTkNFKG5yX3JldHJpZXMrKyA+IDEwKTsN
Cj4gKw0KPiAgICAgICAgaWYgKHJjdV93YXRjaGluZ19zbmFwX3N0b3BwZWRfc2luY2UocmRwLCBy
ZHAtPmV4cF93YXRjaGluZ19zbmFwKSkgew0KPiAgICAgICAgICAgIG1hc2tfb2ZsX3Rlc3QgfD0g
bWFzazsNCj4gICAgICAgICAgICBjb250aW51ZTsNCj4gLS0NCj4gMi40OC4xDQo+IA0K
