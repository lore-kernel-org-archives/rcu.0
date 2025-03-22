Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A89235C04;
	Sat, 22 Mar 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654463; cv=fail; b=PJKAK6orum5ocKYG/2MIwIdBpQeNJZpIZYHdtkoHFwB/Gtrk+VE3JRgLp/haPXpe2JCV0maF/e5eEAwZdV3y+bA/lq6pVtIaq7he+wEo65BQHBrOil+A9soihf4fnHezx+XmKPD3xPtoXn82ejdmoGnhnqjbMG5q2VQo49NmU8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654463; c=relaxed/simple;
	bh=v8lTgjGDvicB884P5Gm8PFKVExR0gfnpV9BHWl8jX00=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLO5Qu9wjGYf6N9eQXPi6RwrZ5Glo6TibvHibTYmlxVCf7ucHbcOa6zPNOakzGuAjCd6N2at3onQQKdtdTu2OvZ5TYx+LDW1RGb+i3Gkyl+dY1xyJyt5lUFPd481Dw6pTzsMURnXk4P3TaFBNIUjGdPMu9qqEngSDntZAHNBREM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lWmcovRb; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lWmcovRb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bskXfEyaHWIGp2YhlLZaHZ9uhaWk4cveu9MUREw6L9wEw1cvFpqVfJ01dPDeFgJhBnJojFLEPjQfsABh82tGwi8SSG4HlcTR7WJVa6TJniXD9BQimvqnNcM4xII6/6TJxFYpxZxDGosDhrwWF1vJyQmt8mPtgIXexTmAAIstvgMJBNcmAvPM7Cqp1CUyCV1o0O6jC+TvyX+KNyzJY+T5stQ5xJy2Yx3cHcs9O3zmZLv372VzrMY/aKtxNiX4IgbieJ9DyXdsZoutwIzlrQV4mOhNYQ0AJ+TS8XVQibTF//zL7dz65wX386MMMnrMnmVEIANKMscgJSvwGwv+aYpn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzFLu0Zo6zyT0nZNgRjuShCLdLCPWW0R5A3HjXWeXIU=;
 b=kzRemeMyRidEKkoLcRIxOv8ckA2CkB7PsGcYLx2uHGucBJ4cyVsGar8sz181dHqfeFaM2rpidOQbVV+Dpfr2ukzwbaTHUCko8SRT5cS4+yE9OagbMt+Z13QBN0/DRfIKHT48IrTSLk5H3bfdsKkhDmLQXRqOS4sqC8ILhB0VygjvuhIOEkMWZi7+mZccpSEDRQ4twsaDersFC3quW6nO8oTx88a9R2jGURnh1mGHD7uyDCRp7LIZ7cs5IYxMZuJhBi/fmoQeoX5SaUbW4O+t2+xzRT4hxvflXYvipzNPdsrcanLp9rUGkM7j13GaNigtJqFN3lpqVu4kL9iK7jqhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzFLu0Zo6zyT0nZNgRjuShCLdLCPWW0R5A3HjXWeXIU=;
 b=lWmcovRbEm58pBJ1pv3Krpwiewj5zXgni8A14JMQA+a9YA/tCwgU8Xt3w/4gZ8ky+jxfUUKnr3Uzpvm4ySffYh76WnJI4uf8PxNJgpOdijaa8Hlawn67EF3I1x6USLSMHjSRQTcXywxo0gLCBt7mt/9cWKQykzK28JFtvMrmxCVXgzKc7u+q9Hic1XHwUtd4Xz16kk4+vzkJ8ZA6WW+VQPQYmtyiAYHEy+affD1R315CMnr3le9Z/1FWunwHPSAuEXBdSJmdMwFrUOavMFLh4Vgg786cZBivmicSnA/5ytNkEgN3Sa3rmNQKWTWeRWotu/fkYwbpMX3yAmBKBXrLXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Sat, 22 Mar
 2025 14:40:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 14:40:58 +0000
Message-ID: <42297734-44af-42f9-8544-f3b25e35d3ef@nvidia.com>
Date: Sat, 22 Mar 2025 15:40:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
 <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
 <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>
 <Z96P_K0kt-FumSjz@pavilion.home>
 <a2b9d79f-5406-422c-aa79-f0fd1862d4ab@nvidia.com>
Content-Language: en-US
In-Reply-To: <a2b9d79f-5406-422c-aa79-f0fd1862d4ab@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 28237bd9-d7d7-4099-00ca-08dd694f8f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCsyYnFBelZUVGgzcmlpd1VYMlRXNTBwL2tMZDFBQ2JkbEdha3dzelFGUTVK?=
 =?utf-8?B?RWRZM0JLaml1ZUQ3d0p2VUpPdEJJMUt4Q0QvZk5WTTZiaDg0OEI1VkNNY3VK?=
 =?utf-8?B?Qng3bi90MGZzNVFLbHh2c0xubEE5aDZoaDFtV0VidHFpajIzelovTEE3dTlQ?=
 =?utf-8?B?MWx6ZU9QOTlRbEUrRUN0azFjcUdGNUo2YUdiM3dlRElMdm9yN2c4clVCeWRQ?=
 =?utf-8?B?cGt2bDBybXVBM05kNUJUaU9oWFNpdkc4UkVGTEV3cFNyM2RoaWhtY1BoVWJz?=
 =?utf-8?B?TVBEVVRWOFFHVUJYWmVyeG92U0dvbEhhSCtQL2d5NHoxbW1hdkVGa056MWh3?=
 =?utf-8?B?Q1N6YjVMeDJzSzU4QUpOK3VPTVMvTXV1c01IdFhpN2VtdVd5eDhnNDR1aGhR?=
 =?utf-8?B?Ry9wZUNsbFB3U1Y2cjNlbzRxL2hHQjBJcXdzaitEM0o3dzdxbXZPS2VrZzZ0?=
 =?utf-8?B?NlZKaGFpc2VlY1Zhc0Y3blUwMWc3ZTZOMWpPUEF0a0N2dWRtZGNXdXYxaDZY?=
 =?utf-8?B?R0NpWDBDeFE0bnJhL09FN1FOU252dmpXTzMxU2ltVWp3dU1ha0l4amtXbWFt?=
 =?utf-8?B?Sm9rQjl6TEV3MWJqbmp5ZmNYeHN2YU5HdmZDcFpCZXM3cW9DVXkrbW9UZDBv?=
 =?utf-8?B?b29vWXp5N0FmVXpiUGhmcEdsbCtML0x3T3RFSXBVekNBWE81Y0l3Q3hQZ2Vz?=
 =?utf-8?B?TnhjYXJKZURzS1hiVCtiOHNCQnJ6YVZqbVZjY0Z1RUhld0xtcFpYcFQrMkg3?=
 =?utf-8?B?NFlCczRzOVN3N0d5VGdsSW1iRCtMN1ZuYWxnZ3hLa2RzQ2VsNU91TXJYK3NB?=
 =?utf-8?B?SEcySW8rRHhneFM5OGpVOUVIdjMyMldLSE4wcHBSUWVyMm5ZYWtuOTJwVVZJ?=
 =?utf-8?B?Yk9ER3dOczFMcXJkVEV2SjBxOXptNXd6SjJWLy9UcC96V08xTmI5WWlKak9L?=
 =?utf-8?B?YW5HeXlYVU9lOXZYYlZqYml2QUYrMXFhTG9GdDk5WXRTUER2V2JVK3FQeFJ2?=
 =?utf-8?B?M3VHUUo5dHpJVmY3QllMTURlUFFOSlZKWDQ0bDRPNFdJY2U5a2UxblhHSmxW?=
 =?utf-8?B?VXdUUE5DRGVDWFZYYVMvcVdsTzA2eEN2bU9Hb1N6ai9uTkNaeitLREEva2g4?=
 =?utf-8?B?MUsxcHdaVGJlQ3hybitGM0huWFpaWHAwNzNFaUtDQmNVMkQzUjhHUW8zdm5h?=
 =?utf-8?B?a0VqYldhUDMrRTdwZGNQbE5kb3VQMHhMZWM3bk9HY3VURjliVXJHR1h0dGZY?=
 =?utf-8?B?WGMxVUg0aVVFa1RBaXRBbUJ5ZlZNSGZrdytDc0ZZaERDMm5hTXF5bUVlWEV4?=
 =?utf-8?B?RVArbzcyTDV3Z25hMmlZQkY2NklXQVVlS0ZQYWVET3JlbUk2RXh6c3NDL2E5?=
 =?utf-8?B?QWVsdHVyUHVtQzkrOHhPL3VWWTNOa2lVdytDZkpsUTJpaGZMRlN1TGVOV0Q2?=
 =?utf-8?B?ekxYTEVqMUE1b0JHYWpVUGppNHFoSjRsUFhLdzFmREFIU1g5R1NDZUNFL3pk?=
 =?utf-8?B?V2VPS3NiN25pbmszRTFicUw4RlZlUUhxb0JUWVlBeCtGOGdqRE5hNFg3RVY2?=
 =?utf-8?B?ZkQrdml6N3M5RzhUbGl1a3JxQlVNbHFKNFRLb3lLelliT0RUNHhWU3RNQTFQ?=
 =?utf-8?B?VzhDRnF3bkwyNm1JRUU4a2J1dWlHdmY4R29hOUpMU3NPOW5FR3RVUjl6eUcv?=
 =?utf-8?B?TEFJOWRCTHRTa2tUaGdHM0ppZkkydmdoaExYRGNRNWVhQ2krakJFUVRsWkVC?=
 =?utf-8?B?bGp6cElCdVBqSVRwcWE2UGFodEFWTUZmSXRFMnJ3Q0VCYnpERGxPN0hqR1Jj?=
 =?utf-8?B?M1hGNzlkcHhSempBL3pyYWd4UEJlTVpkRGZQbE5DYnB0WUdHV1p0NERhS3dw?=
 =?utf-8?Q?2UNI3zrAFvKmu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRqZjJISGlsbXRqOVpmMWl2Q3F0M1p1N2oralA5cTBqOUxHRDhzZG1iK3dn?=
 =?utf-8?B?TFJwTEZSUW1PVDQyV1pTNjFReGZZMlQvR1B1NHZ0cGxRV2ErSGYwRWIweUxX?=
 =?utf-8?B?YWx4cjZFSHoxV3dDM2VUYUJJVXlZVlNDNVl4THRTdHZUeEFvTnZvMGxmVlBP?=
 =?utf-8?B?TnRMdkh1eDJDRS9Pazd1bEl1Q3htWHZwZkZKTGVHYlk1SUhlWmNLOVlYejhu?=
 =?utf-8?B?SFFkamNTMTJpK2EzSjNTMlhJT2Y0MERUVkFUZ2hWTEpBTFJuN29uVHhuTkxm?=
 =?utf-8?B?L2FQWGswOTNHVkV5anBxZkE1ZFgwaFNxbzBnWlRkQWJITUNEVFdFMldqZjZY?=
 =?utf-8?B?dFMyZXdYajVCZDBqK2p6eGQ2c3BsQUM0c0VMUEh5eVd4Vk8yY2VDbXF6R3FN?=
 =?utf-8?B?b1RsWDZDY00yWjB2SndaVjRmZHJhWnJ1N21hQW5aem5ub3VLNzlURDg2TGho?=
 =?utf-8?B?K0E2NXZjNWFVMDI2RGNuRi9xbkxQTWFydm9SaStkNHhOWTdYbkkvTGJwaXla?=
 =?utf-8?B?U25Ua0M4dFNTbWhTZm13dWd4TGs3SUNONmtxS1ZMY1ZhZDFqaUpEb3I0YmVL?=
 =?utf-8?B?WTFFc0RsZHY3RkF1YkUrUE1yNS8vQWt5RGdwNWszMS9UMWtEN2J2TEwxcUZV?=
 =?utf-8?B?Y29DVXlGRStGQ0VPTTFzZHI2WUw2SWkzTnI5bDFQODVHS1JCMWhDS2Y2Wkc1?=
 =?utf-8?B?ZkthTDhQUkJ1dHpQTWVlRXJYcjk2UThpVTdTNmdUbWRJN3lnQUl2SE9rVU1P?=
 =?utf-8?B?TDlUTXM2Rk9IUkRyejg5cW9iN0ZuL0phdjBkL09zK1I5WS9lak1SV0hMcGND?=
 =?utf-8?B?K0pZTzVUYTkraTVBbFZ4MHp6MlRIb09STGxVak1XcG9xYUJlb1J1VlIwS0tP?=
 =?utf-8?B?eXZyRzBZVDd2SUJuVGxEOThtaDZpYUhHNUx0WWdydkEzTzFYTjU5VTVLaXFh?=
 =?utf-8?B?dFF4OXU3eURrRjc2WWxaRS9PWEdxaW1DOWx0TThzcDNQbnp4K2VPT1M3QmM5?=
 =?utf-8?B?ZWVBSkowYm9qT1JHNVNtc2FkNVlINCtOSzVuWnZ0S21vakNmMHdTSnB4MjY1?=
 =?utf-8?B?RDRQR3l0UGtFKzlPKzgzVTExWW1Dbnh0aGV2UlVVcjZENlM4aVVoSlNFKzZK?=
 =?utf-8?B?MVByNjErZGNham1Nb2tNekQ5aG1peUp4NXQ5K1Y5Q2xncDgySWd2YWVVVlYv?=
 =?utf-8?B?dkFnNFlIMU1ZMnBYL1dSb1ZiNTR4aTl4bWVWSURvRG5YLzFVcTB6YkxENEZO?=
 =?utf-8?B?cTdLYW1rejJpN2RsYi9nWHNMS0dmeTZJeVBQQWhGTkdOb1Q2MERUc0liaWQ0?=
 =?utf-8?B?Tnlxb3VJYlVEbm04MU5tSW01WjRSZ3d3R3JJb2NkaHFhbGF0VEVBUit3RWh6?=
 =?utf-8?B?YnlpdzArbTcrczRWM2JxVDZjQnJJbXMzK09xRUtuSHlnL0NOVzFZdklVZUZm?=
 =?utf-8?B?bTl4N0c5YlZ6ZkZGZzV1akZ6Vzd3SExIYmFUWTNyZEZoMDIzU2ZNNlY2QTFX?=
 =?utf-8?B?ZmkvSVVudjdhZFZGbHNwc1QzbGN2eTZvNDNEalFFTVMzTUxEV2F5ajlpdi9I?=
 =?utf-8?B?dGlBVG5OaDlabFNnNEYydnBDblplVFoySFVKZE9tem5xRDRaOWFCSUt4WU14?=
 =?utf-8?B?NG9nbkFMUUVhZ0w2azgxV3JaMlpJMkdFajF4RkwwL2hZYWRRWHA3MERxaVMx?=
 =?utf-8?B?bnFXR3d4T0phakRsejAzckpjVnhrZEE0ai9WVUNjWmpQelRPR1dwZVl4enE5?=
 =?utf-8?B?bHE2bWwrS2xMN3Flc1BHUXh2U3VkV0pDZ2paYmpERW1LM0U0cnJEK3A3Q1J5?=
 =?utf-8?B?SEhBVFd5WUFwZTd1K09MdllPaGFQNU1IYWpGTnlJcXJ6WEZDTnFKT2hhVkU5?=
 =?utf-8?B?SHRjMEFWUzB5c1I1eFFqU2dTSjdHVkFWRnBydnVsY0wwaDdmSmlTWmY1VWRJ?=
 =?utf-8?B?ZHVqdEpYMzBsQkZ6aVRiZnd2eVNPT0s2djRzV0hBN2tvWjFqZU1tUVVGdStw?=
 =?utf-8?B?S3BvMDRSQ2FsUTJDZ0owY2lKZzd5NkpzYTZPUk02SEtyUEV2WHpNSzFCZjJj?=
 =?utf-8?B?bnZuOU1XMkdGUFdsT2hxYko3d25TSVR4ejVBd1BUbGhMQ2NJMk5CQkIvaE0v?=
 =?utf-8?Q?cvtJE5Snso49VEUqu9nOcQlsG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28237bd9-d7d7-4099-00ca-08dd694f8f48
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 14:40:58.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qo/BU08HrZHBFOqeVXfwdhpdL7Lsy0TVjBh1Wyh7f+fI0BQV2ffuF/1NZKKzGdiAaV7K6aITiHg7U1ka47PCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552



On 3/22/2025 3:20 PM, Joel Fernandes wrote:
> 
> On 3/22/2025 11:25 AM, Frederic Weisbecker wrote:
>> Le Sat, Mar 22, 2025 at 03:06:08AM +0100, Joel Fernandes a écrit :
>>> Insomnia kicked in, so 3 am reply here (Zurich local time) ;-):
>>>
>>> On 3/20/2025 3:15 PM, Frederic Weisbecker wrote:
>>>> Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
>>>>> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
>>>>>> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
>>>>>>> The numbers used in rcu_seq_done_exact() lack some explanation behind
>>>>>>> their magic. Especially after the commit:
>>>>>>>
>>>>>>>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
>>>>>>>
>>>>>>> which reported a subtle issue where a new GP sequence snapshot was taken
>>>>>>> on the root node state while a grace period had already been started and
>>>>>>> reflected on the global state sequence but not yet on the root node
>>>>>>> sequence, making a polling user waiting on a wrong already started grace
>>>>>>> period that would ignore freshly online CPUs.
>>>>>>>
>>>>>>> The fix involved taking the snaphot on the global state sequence and
>>>>>>> waiting on the root node sequence. And since a grace period is first
>>>>>>> started on the global state and only afterward reflected on the root
>>>>>>> node, a snapshot taken on the global state sequence might be two full
>>>>>>> grace periods ahead of the root node as in the following example:
>>>>>>>
>>>>>>> rnp->gp_seq = rcu_state.gp_seq = 0
>>>>>>>
>>>>>>>     CPU 0                                           CPU 1
>>>>>>>     -----                                           -----
>>>>>>>     // rcu_state.gp_seq = 1
>>>>>>>     rcu_seq_start(&rcu_state.gp_seq)
>>>>>>>                                                     // snap = 8
>>>>>>>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
>>>>>>>                                                     // Two full GP differences
>>>>>>>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
>>>>>>>     // rnp->gp_seq = 1
>>>>>>>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
>>>>>>>
>>>>>>> Add a comment about those expectations and to clarify the magic within
>>>>>>> the relevant function.
>>>>>>>
>>>>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>>
>>>>>> But it would of course be good to get reviews from the others.
>>>>> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
>>>>> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
>>>>> because the small lag can just as well survive with the rcu_seq_done()
>>>>> function in the above sequence right?
>>>>>
>>>>> The rcu_seq_done_exact() function on the other hand is more about not being
>>>>> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
>>>>> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
>>>>> least ULONG_MAX/2 AFAIU.
>>>>>
>>>>> So the only time this magic will matter is if you have a huge delta between
>>>>> what is being compared, not just 2 GPs.
>>>> You're right, and perhaps I should have made it more specific that my comment
>>>> only explains the magic "3" number here, in that if it were "2" instead, there
>>>> could be accidents with 2 full GPs difference (which is possible) spuriously
>>>> accounted as a wrap around.
>>> Ahh, so I guess I get it now and we are both right. The complete picture is - We
>>> are trying to handle the case of "very large wrap" around but as a part of that,
>>> we don't want to create false-positives for this "snap" case.
>>>
>>> A "snap" can be atmost  (2 * RCU_SEQ_STATE_MASK + 1) away from a gp_seq.
>>>
>>> That's within "2 GPs" worth of counts (about 8 counts)
>>>
>>> Taking some numbers:
>>>
>>> cur_s	s	delta (s - cur_s)
>>> 0	4	4
>>> 1	8	7
>>> 2	8	6
>>> 3	8	5
>>> 4	8	4
>>> 5	12	7
>>>
>>> The maximum delta of a snap from actual gp_seq can be (2 * RCU_SEQ_STATE_MASK +
>>> 1) which in this case is 7.
>>>
>>> So we adjust the comparison by adding the  ULONG_CMP_LT(cur_s, s - (2 *
>>> RCU_SEQ_STATE_MASK + 1)). i.e.
>> 3, right?
> Just to be absolutely sure, are you talking about the value of RCU_SEQ_STATE_MASK ?
> 
> That is indeed 3 (RCU_SEQ_STATE_MASK).
> 
> But if we're talking about number of GPs, my understanding is a count of 4 is
> one GP worth. Per the above table, the delta between gp_seq and is snap is
> always a count of 7 (hence less than 2 GPs).
> 
> Agreed?
> 
> If RCU_SEQ_STATE_MASK was 0x1 instead of 0x11, that is a single bit (or a count
> of 2 instead of 4, for a GP), then the table would be:
> 
>  cur_s	s (snap)	delta (s - cur_s)
>  0	2		2
>  1	4		3
>  2	4		2
>  3	6		3
>  4	6		2
>  5	8		3
> 
> So delta is always <= 3,  Or more generally: <= (RCU_SEQ_STATE_MASK * 2) + 1

Oh man, I am wondering if we are on to a bug here:

From your example:

    CPU 0                                           CPU 1
    -----                                           -----
    // rcu_state.gp_seq = 1
    rcu_seq_start(&rcu_state.gp_seq)
                                      // snap = 8
                                      snap = rcu_seq_snap(&rcu_state.gp_seq)
                                      // Two full GP
                                      rcu_seq_done_exact(&rnp->gp_seq, snap)


Here, the
ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));

Will be
ULONG_CMP_LT(0, 8 - (2 * RCU_SEQ_STATE_MASK + 1));

 = ULONG_CMP_LT(0, 8 - 7)

 = TRUE.

Which means rcu_seq_done_exact() will return a false positive saying the GP has
completed even though it has not.

I think rcu_seq_done_exact() is off by one and should be doing:

ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 2));

?

Oh and I see from an old email that Frederic did ask about this: "Should it be
ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?"

thanks,

 - Joel




