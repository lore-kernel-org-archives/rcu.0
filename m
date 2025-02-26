Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132A22157E;
	Wed, 26 Feb 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583599; cv=fail; b=mZ3fDjecFhOmcQ0akZIHy00XqXFQWmM9ny2vS0CDvYdWBoK2fJmcyKrAL+LsYSSL9oHJRJAjWe695Z91JtIFJWUZ//icyxTUnegku9Krv6OPicSiKUEVXgNSIdp8RR1qAzmWJuNNavInRix6UXgpsIIjocFytkg5+OFLoYJObbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583599; c=relaxed/simple;
	bh=MAFkSkAjGTNQrYcULi0TgWS6X/w7UxYBfqJ/Z32MAJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htTyhcYxROjj5shEH8KdHRnNn9Eg2rpBoiYZoqNGZCQTcLkLSCySnhV2ZIDTZw3K5vTv+dGRywiCgRNBZxB4LukayGWWLz1Xvo2WmH/0DZYsa/L2B0vd+mWYXgGrRFHqHzXmKwBpltXWR3GZYdhC2zdbx10VQPmPa3REv90qOek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tT8UYGGB; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tT8UYGGB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY/lL7eYPxKtpFSPF3Hcrsc2TXnMlqtb1B79F1k+fIDgocz3ZU8VrvPlgtC2I+K8bxAr06hEu71Y7jDIgrTh+y6aELkkbFLRlYlc8FQGoiSBN5iILWooyk8UHNR2vEBLSUzaAU2aJglpVtqipu5TzH66/PsqkDVtO81tEr5DKRSaLaav6VSXtbZrpUB4BtXWoFKZBJCbDO6tpZMyw0EZifICCDV2R7TDZzXysOgiMZ9jSijiJVdpbXlKVyssWTRvHKleB5UfKskeEDo5b+CHtKrtomMSUZpa63WZYCrhVEtUky0lu6+gtUriYwHBzLrWBkE+u/yOa3utY/i/z7EdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrxcJSf7+SzL4RxPn4AHjAed2RdjRBiwzWzdZWzeib8=;
 b=o26eyrRr27PWYuzoDqX7+P/OXGe1+WByrcBOZSm9g8jPk79KVZG2MGmMUmEzyNqTxuU+9V2ESWp3L7b+3C42CTwjJ0TSn5ZCiPyJMmWp7etIV5wWT73RhdE8L2tkbjbldOXTeJZpipjDFhpeSY46c9zV4JBPiJLarSz9aLnFWLnzteQxVqAy/iq0C7veFi1eSq31fhauCI4XorT7MsacmfPf/gNhY8+gz3ZLdnUtV3ndGdfERmFDmGtveh5HgQrZUeQBIUITOjkIyMMSwFkFWL29fZYaFDriEhR1E40HRa8WA/69l6AsXoBEESfKZYsolGkIYga2T0n3KjMKoiYLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrxcJSf7+SzL4RxPn4AHjAed2RdjRBiwzWzdZWzeib8=;
 b=tT8UYGGBTGFNJPYjNJrDrWdNFnDJdzoZKOqmgzQBflvCeNTUSU7LceN0GgMqAy4HWx8OGmwIfjelzVQ1wcdzJnm6+d+sqsm2/OMuxg5Df7Ihc3lyk5IE5GBV2F9UNF8ptVmrA6jYqqBVKHvIyQxEedQgrvwdbXrPBN4zFUp42TViYUIjNAOU66gerHJr18Atb+r7jB5cNbQ6Wwe/LJbsY1MWAgjFVtir5lS7687w3jwh2WLg4aIfkyacg+2RmG1sLZkrQ4/Jyj1+3BAgPl0dOqqJcmsDONhzJyNVBEHN+vDYerHmCxVtgb4pdimN25KWBCnWvNnAYo17TmMibOaLLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 15:26:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:26:35 +0000
Message-ID: <c0c0f393-fa50-4437-80b2-f38d65b43fab@nvidia.com>
Date: Wed, 26 Feb 2025 10:26:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
To: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
 <20250225215908.GA1812344@joelnvbox> <Z78OeeyarjDB63Dj@localhost.localdomain>
 <63cbab19-a7d4-4daa-8b54-58665e159e23@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <63cbab19-a7d4-4daa-8b54-58665e159e23@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:32b::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc09354-7aa2-4757-a385-08dd5679f4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnllcmRsOUtpbkI3NnJiVVBiMGJpamVXU2M2VXkrN2xlWDFvUGxlQktML1Zz?=
 =?utf-8?B?VFpRUzhHaE55aWJnUEpscGZkOXpIVEZrU1lDcFZ2YTdhOGVtUnhGNE5mVnFQ?=
 =?utf-8?B?NThid3BmQVIwSzBRQWFpZ1NoRS9RS1cwMmZ4S2NiTFBPNXZuelR0cWlKWXhC?=
 =?utf-8?B?YlNEZU5mK1B4cE56dFltTGpJQVNwSjJIYy8vS21nZ3ZGWDR6NjdjSGNSUHFJ?=
 =?utf-8?B?aEo5b3p6UkF0ZW1BWnVpT2ordjFVdmFsc3E5WnU2Rldnc2MyOStZdjZ3VzVt?=
 =?utf-8?B?RENYcVMvdDVDNFpDMnZsWTY2L211T1dFajJGTEJocEdVckU2SzZDbVhHeDFX?=
 =?utf-8?B?blVodHVuaVZtYXVyVDFTWlhITTY2Vm1NRG9nRU00bGtVbXd5Y1V6ZU9GbnpR?=
 =?utf-8?B?a2dkOVNTdFN1TCswNW02SU5OaWhHaDUrSFo2dVp0akc4ZTA3dVliVTFha0hK?=
 =?utf-8?B?OU1jck1XUUpXenlyOGlaNkxCMzlQd0QvdE9wMzVRbDdEWmp2VGZEelgwa0FC?=
 =?utf-8?B?RjJ4TkhweGswYkdRK2NMd09XTE9uOHJvL3B6Y05qclh2UlpVL0YxQkNueHUv?=
 =?utf-8?B?a293ZVV4ckFlZllkREpKcHFYQmY3SXVyT3h4dmM0SzJIS2JBZk9QaUhOL3By?=
 =?utf-8?B?SVFVMkgxRGgxRkEyK3I4bVppSzZseWhRbDVTZVlMTlZpQjJDMlM0aG1HelVZ?=
 =?utf-8?B?NHZKcjlrVFdCd1NPZjU0akxWNFF3OWphTjF6c01aSHNDT2tNSEltVHZTbERk?=
 =?utf-8?B?Z0krMFBEaTJoMU9ZZmxLWlVkcU5xT0NwL29ZRFRqL1RLbkZjcEVFNWVXTkJl?=
 =?utf-8?B?UUVaZjBPMVQ1eUUxelRUcXRpZ0dnWlkrWHhGZ2pTRlJHQ2dwWFkxeFJ3S1cz?=
 =?utf-8?B?MU5nbDNjTXNFQldFa3UweEFYZkdqOU1IcmNpc1lMb2hpcmhTVGw3dFdDN3JV?=
 =?utf-8?B?N2JjenpLWXl5SEEydndVRWdwbllCeElmelNVQlR3d1E3bDlaNzVuQkRKZGdV?=
 =?utf-8?B?elprLzdKWmNhQnZEMjdhMzFvVDlRREQrcTJoQ0ZTelVXdUw1bWZmcnV4Sy9R?=
 =?utf-8?B?bVFrNzZqSHlrZTdLYkhhcUtmWmtzS2U2eGduTVJ2TFcxMnJZRk5BTUh0VFFs?=
 =?utf-8?B?RlAvSmRSek1WalR1UXZxc1gxbmRaRTdiWVR4c2VqUjhWRjBibDV1QzBlVmQr?=
 =?utf-8?B?ZjlPeU10dFc0MVZMKy81aytvSk9SazNoWWVNMk1uYjA3STlVYjQyVTJ3cExz?=
 =?utf-8?B?Y3FqaTBtVnBGWm0xdk1ZV2Vsa1RxNFlZR2VKMGZLaUN5a3dKMk11YXBRNy9D?=
 =?utf-8?B?SFk1T2kwNlg0Q09kdTFDaE5rS2trbnUyTGxiV21hMVBQRkVPRzJEenpyOVBY?=
 =?utf-8?B?djgyWmpEZzFwWTBGYnpjZmVMQmxpczhZRWJUMGxXaDNwQW1vaE1qOUd6YThN?=
 =?utf-8?B?cjdGcmhqTWRBMDFrRERvM1pJMTIvUXlxY3Z1TjhMdWZveGVENktWVDVpSHl6?=
 =?utf-8?B?VGNJd2QwN05odlNUdXJVMVdnUkRGSDZlMzBoSkJ1c0NDMGE5ZkVLMjFNb1lx?=
 =?utf-8?B?eDJVRHAyQzF6V0lPVkdoK0VZdFA3NGdsOVRoSXNmd0V5Q00xVHVoMUNBQXlW?=
 =?utf-8?B?NWtUWlU3Zjk1UTc0OFZPeG1xd1V1aStwSkpLamRaVnNubHRlSGhLQWkyTWJD?=
 =?utf-8?B?OVVmck4vRS8rbUU5K1EzazhFcHlhZUN3TG9iR3doVncveEcwRWpYbVFJbWdD?=
 =?utf-8?B?Sy9YS0hBVEt5eGdIaU4vWGdaekc2c1cyZGRGZlVNbjYySmU2bzFMQ0cvVGFh?=
 =?utf-8?B?bXZvNFM2YXFrOVJkRTJFVTExa0U4ekhPSDBzSDRYMFdUZHBGRS9DVjB3QkhH?=
 =?utf-8?Q?5nu6XKQUO+F4G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmdPNE9jWDBHWHNrQUZhTzc0K25iRDV0VytRRGMwYXBMVDl5c2FJOWVqSDNn?=
 =?utf-8?B?UjVvNHdMdWVoTkQ1UCt2UnRPLzd5bGVranVxT3hvRFVMTEVOY1JUdEdYUHdX?=
 =?utf-8?B?QzRjYnpDb2w1cEhlY1dTb0NhaWpEcU9qeWRsdFZTY3VtYVVvVFQ4MCtNazBD?=
 =?utf-8?B?N2RMbEtxQ3liMlFFTFVHRnpzMC9tOGVwYTVnSmlhUkVocUF2em5KTi9XZGky?=
 =?utf-8?B?U2o1ZkJkRHhzQ01xQ2JOOC9TeFgraXhqVDE1MEJjU3pCOVJpOWlCR0kzbWc2?=
 =?utf-8?B?SlNZSk9jNVhGMWtESlhaK3daOSs2WXF0dDVaTDFFU0tkbDVkR3BjZjZETHJv?=
 =?utf-8?B?d3FWVXBVOS90RkY5WWM4VzcySzh5eXFrSngvdk1qZm9qdndCdksxa2o0U3I1?=
 =?utf-8?B?MlZ1TTFMcHpyR21GTEsxcDcvYkpUVFoyWkJMWUwyTUpBZjArQ0grajdSSFE5?=
 =?utf-8?B?aVY0eVYvWU5kNmxnN0tlWVNnTFBSTWNsUmdMZE1uVzEvQWEwUXVqYlR2dHNm?=
 =?utf-8?B?RjlTRy9NeGg3K2RaNjJZTzhaN25oS1hyaDJUeTNMK2Q3NXEvOUIwOC8vdEMy?=
 =?utf-8?B?YVNxT2MzdW9LdzM3ZFE3SVBmc25CKzVmN1pGSkhDT0RuMzdVTnBlaWl5cU82?=
 =?utf-8?B?VlA2aFY1K3BjbGRabVVCQmlpTE9SRlVXM2MyYy9NWVFzNDg5M1hnR0pQSzUv?=
 =?utf-8?B?Qk4wZVA2eXlEbnF0WnpCZkRraUhZeEZIbk0vRkxTRklpem81eE5UMGlObDFM?=
 =?utf-8?B?K1JOSVAwQ3JRdTAyN1lkVVlQTU5kd1YwSUFOb3ExanNEY1padXJDMDZkMkIv?=
 =?utf-8?B?ZHY5R0dYS0wwQ3I5VWlxemhFY1d6NXErcWsrc0plRU5PZ2p5YXdaeE1SMlp0?=
 =?utf-8?B?Zm9BUkZGOVJZZllrWDVFTWN4TVVmS2NwajdvVEVieGdYd2ZkR3NVSCtqbk0r?=
 =?utf-8?B?TDRJaU5IOFRIME5qZU00aUxTTFArU0RzVVZQWTRYVTZSUGFKVDlmQUd5WXdD?=
 =?utf-8?B?RE9IQkt5R1Q1SkpmSGw1VEVsOUZxb3JlYXdnMUMwY3BuTXpiQVQvczJ5bGZz?=
 =?utf-8?B?anJVVU5zTzIyVW1Ia1hSUHFBcmdsdjB4ZWVpVUFTMmNKUWlKTk5aUHVtUHNw?=
 =?utf-8?B?Qno0UmRETXptMG4yZzU2bzBXb1Ava0NnMmw5ZlVrL3IzSVhhOENxVVJWRWZr?=
 =?utf-8?B?K1p5NVNOSmtwV1RHRnBabU5sS1BlNEp3S3JKVHFkaFNoZDc1VmhnWW4xeTRB?=
 =?utf-8?B?aUhrdUFOaFVEQmo0Zmp3NGppdTdtaG41cE5zTUh6K1lUTzRoVk1SR0w4Z0lw?=
 =?utf-8?B?Q0lmeTFvVlFJNkZwckdwVXZmK1lKamtDeVZIbHk3Rm9SVGllRHlmU1NqZysy?=
 =?utf-8?B?TGhqRHpQYWlFMk11ZTR5Zld3eFBadlBmWFhhcXdMVmFYalVwNzZHR1NjQnRQ?=
 =?utf-8?B?ZVFPai9jSWZCdVc2cDJFOTNXL0pMSlRQSHVWVkJUbWFSb1R2b2g1MWhobEhx?=
 =?utf-8?B?eEFkbVJEWlEveGJJQ0YvbHFDaFB3VHIrcUYrQmsyY1d5RjFKUWhzMzFNZk1I?=
 =?utf-8?B?a1g4RnFxenNaSjFiZ2NEYVZkZ3Jib1dnY2crY3hpWEZzWk5COE1CSWI1Y2Fq?=
 =?utf-8?B?VlFDUk8wendxQ2diTmM5QzVTcGIrcXQvTFJUREJ1eTJCbVRvUWRkVm5qTm44?=
 =?utf-8?B?a2Z4N2g3QXg2V2VPZ2tJNjIwZUlXd0x4MTFFS2dXREI1a3Q4bFYxeG1iUmNt?=
 =?utf-8?B?emxwRG1RT0RqTURCTTBPMVl4NzlOSGFqZkpyeUhsNW85Y0pTZUcwR3lweVZO?=
 =?utf-8?B?NkNoOWVCNm5TZG94SEYzeGlRZ1JSWTd3aVhKZ1VJVTBvTVVDQi95SzlvQnpi?=
 =?utf-8?B?Q1NidzBieDVYQTR0anJxdDd4UVBEQWQ1b3k3d2I2enpvcmNTcVNyQTlaYThw?=
 =?utf-8?B?TDZsd1RBOURaUkhNWW1kZ3VWTk1nVEUxSlNaajdBTlpzVVZTcU1rL25WcTdt?=
 =?utf-8?B?M0NZeWZMZWNJWFJlRElieDcwamhzcDFLeDZHZWJNTVF0SjY5YzUyUW5wOVF0?=
 =?utf-8?B?Vmh2SmU4RjdKZHRSQzZXNUVNTktweXI3endJYm9JTU1vclhTOW5DcXBvRG1x?=
 =?utf-8?B?RjlPbkY5Uy9kTHBlUWtNVjJ6RjFldFBxWjAzTC9PamZYU1VWMlIxVElrZ015?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc09354-7aa2-4757-a385-08dd5679f4f7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:26:35.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAMDFCDWVepKL7Y2o1kWapKzjB3wa8QtifALA/qoQrKhzO/RpsTdsvEeqF0sZx3mIkHVr1jKgQ3+PtZGg2Bhtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475



On 2/26/2025 10:04 AM, Paul E. McKenney wrote:
>>> I was wondering if you could also point to the fastpath that this is racing
>>> with, it is not immediately clear (to me) what this smp_mb() is pairing with
>>> 🙁
>> It is supposed to pair with the barrier in sync_exp_work_done() but then again
>> this is already enforced by the smp_mb__after_unlock_lock() chained through
>> rnp locking.
> You could interpret that "Order GP completion with preceding accesses"
> to include preceding readers, which to your point sounds plausible.
> And in that case, again as you say, the raw_spin_lock_irqsave_rcu_node()
> in rcu_report_exp_rnp() provides the needed ordering.
> 
> I think.  😉

This is for the case where readers are blocked. For the case where readers were
not blocked, and we exited the RSCS, we just expect the regular QS reporting
paths to call into rcu_report_exp_rnp() and similarly provide the full memory
barrier (smp_mb) on the now-reader-unlocked-CPU right?

Just wanted to check my understanding was correct :)

Also if I may paraphrase the ordering requirement here, we do not want RCU
readers to observe any modifications happening to data after the GP has ended
(i.e. synchronize_rcu_expedited() has returned). Similarly, we do not want
updates in the pre-existing readers to not be visible to accesses after the GP
has ended. Right?

thanks,

 - Joel
