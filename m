Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35723BF96;
	Tue, 10 Jun 2025 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584021; cv=fail; b=ahkLWG4Q+HwJgmdzsv48/4LG58Hj7832h1TGjc7tLZbbwouQlfxrEQp8z4Ra5dfiSoYBfAdlTxN17h+T7o8Jw277QtBNG7k977f3JL1vxTVVdDGjx97yNRTqDwiJjbYKjYjp134uLoT0k82gSovUF4IoFXcfwruTupL7fmihosA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584021; c=relaxed/simple;
	bh=HiD3GAnwXpwUwATn/JAG9fclfI3fO25ub0V+b7WTx+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BD8O9BPjpV3Ua3RDyJ3yGignMMwBNkaUV2zMyBpS7ULuijP1/RZ3zLF+yscIgQywCRoNwE6sqKg/xPXqFCXxwsMRLxJ6DnhNs0O7hiioZJdvRHklhph+KjsYyeJDmJTvSpKvR2ykBo9H+HjjQFzATe5LulgIs1cu6LUsjESSA9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oerq3tYO; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oerq3tYO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNloMFPMg42e9P/bOiDJ7J7Ir8AvGOByjCWZTUMvvi2Iilumyu6m/kguamZoomhjQ41eYnVyNAaigqNXeiMvt0DW8C6CtCHQXQ4GPcLvPjHV+hDSgmFRRGFzixWuGgWkgr6fdqOL7Y99AkHM8FVfK2eGG4nXN58Vt2eB4Dc03k/Ck888c4vxTWp29LyckCiZCHrPcKXYT3SkOJlRwkCuo1j84MP6a1CiW1WqbQIgBgyNc3IoMDdT+8Cgj50uS1N3s3xraEy2qUJCDPGcx16BSROj1bO+g8azttaHBDGVAUsFWU3L7yRbYoIFY1xz/SuXLSTh5EDm4evrFu18wOtNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opREgZjoj7uhSoWKtMUe/5E/X40jYnmy/38r5Ez0ux8=;
 b=b/mv/darXS1NbUf8zoW9wHeeMj6CAr0BWdyBRCdwJyfhPLcYkqmtU/qIK8CDWk+QmDKuhoWOPUhdUOB8NVqJSKq7ZQIzp/JmA7zaIuWoC+A9KPFwQL+ggVsmQdaoJmJ+Zx/4igEZstVa4muMIixbl/Z2DfPCeN0mJaFC3jqU3AhP1R0pN1viP2EurpcLdfcVNCRDIZXgg3TwHVSdXSnpUGhUFxWQE2HwZ4qTtGuJfYsirydDSRRJbQpvsRugs7fz7dJh3Nf6IhZWd7UwZOZQSPgiQJOXAbw3+yQXVUBvWXbZEQuvfP3kshPZObClDPS1Dif80o7jY9eunKX/8A1axQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opREgZjoj7uhSoWKtMUe/5E/X40jYnmy/38r5Ez0ux8=;
 b=oerq3tYOOBTbCBUBmJdnOpWrV3zgHSrqWpQ33VR4CuBP6m9oSXmASQgi78fOA5Jd3xNXvJzdGy2pjv31oEF1cKHjtHoh5bo+Ou8zIBOUBjF7mzE4Lc6ULhNc2qfaLdjLiQlSxBVr/xNshcGTfYQ7ntieW//VHvXF3lEd0AWwmdYXY4xHC6Pttb0H/pNRVECrknB5J9qBj8dSJeLeBXYzIB23vMlDDhTyNYRdh6fr+/BzF65o9dWiLurW40MoqZw0HDQR1bBIgXSrpWJOLaorOKlrXjpoXzhZ67lHRUtRMVTa1BMMXQWEouBoTK/vp7a9YIE862yBE2kCm4GBrrJx5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 19:33:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 19:33:35 +0000
Message-ID: <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
Date: Tue, 10 Jun 2025 15:33:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20250610173450.107293-1-urezki@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250610173450.107293-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: d93909bf-5514-4583-a99d-08dda855b0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTBQakRJS2JiWEZPaXYzRkhWTjZCY0pxQnpHaHZNSkkrRmh1U0FnbmZzbjV3?=
 =?utf-8?B?MWF0UWQrMDJlWmJNcGZsbXMrcmpDaUlLckQ0K3crVmZLZ29xbUhuMEhyaS9G?=
 =?utf-8?B?NHpmS3ZMVUhMeGs2Q2Q4R1hibVl6RGl5Vm1ncWgvRE1veEwwblBPbmhDSFlS?=
 =?utf-8?B?aE83KzFTZWZLVmR1UmJuNmhVc0VzMFRIeER2b3pDR2lObnlIQkgzejNEbFhS?=
 =?utf-8?B?Q25HY1p3WWt2WWtHQk54SlJZL0lqSytZdm5DTGlpNFRab01nd3oybklWM1JS?=
 =?utf-8?B?OUZWQ0l0N3VycVo4dW1xU1BCS3duazJDS0pPREVscElqZ1IySHFiNmxxc1N0?=
 =?utf-8?B?ajN6YUk5ZDVIUWU5T21heUluTStKS2U0bG1zcngwbSsvdUdiQ2l4bUE2cVgx?=
 =?utf-8?B?cTB6WnRpWm4zZ01HNEdVeW0wVmRyZzNTVWtsNVFxSzFDQWI3aGVUbG9mQVRT?=
 =?utf-8?B?L2tONVJaM0ZnM1l0YndsQmUyaVVEd3RIbGRMb0tQd2FuR1o2SVpwWVZZR3Nz?=
 =?utf-8?B?L3VacSt5dytPaHlGbFpVdVJBdys3WHBlVTFVT3lOL20wMzUxQy9ueHVVQmw3?=
 =?utf-8?B?U3dxZ3JzWnlzSlpDMTk2dHJLRnlveStRQTlVR3kwdC8vc1NhTllRRFhLRm9G?=
 =?utf-8?B?Q0dnODdPT3ZRcG43SVpnNXg2NFF5L2xLVE5lS3VrQ05Nd3pkemZiOWlYRnc4?=
 =?utf-8?B?eFl4VEZ6YzNkUS9XL1VWcFhqYzI0VVE2aVhIZGNrclhPUTVxUW9WcUJQTi94?=
 =?utf-8?B?cUpHd0VTUUFGQnJ4TSsrL3htMVM4K1J2Y2o0ZmdNSWlQcGRKYWlBaUcxNGZK?=
 =?utf-8?B?MENNcDkxK2FWSVFScUxyaE1yZVdZWmg3NmY5TjBWN3hWTWxwZVZmYzNHM0la?=
 =?utf-8?B?bFNjc3hLTTRXODZEQmpkVUg1eVNPcGdGTUJSMm00Nm5jTlYzQXRYMXVVc0JB?=
 =?utf-8?B?ZWxpUHQvenZ6T2VyTkRkRFlicmgzbUpjWmNOU1RUUFNWeTlwVml5Slh6bXBK?=
 =?utf-8?B?QkdQMTRITDdqOTFNRmtHcnQ3WnVyVThZYnBWYWhCT2l2VElmNmJXS1FJMVhU?=
 =?utf-8?B?RnQxSjlRdmFsMDdoYSs4ZlF2ZlRJclNQZ2ZxNkx3N0QwaC95UnNOeUxVc3lF?=
 =?utf-8?B?NWM3c25STjFWNWpRbDVUajBDMEJUanZYdTlkUnhRek5icWxxTVdVRUE1M2tq?=
 =?utf-8?B?N3AvWi9Wbm1lbjU3MFF6RlRHVmZZbU1yd01tS0wyS2lWSlNWUExEZXZXcDNO?=
 =?utf-8?B?cUhVMG0vUis4OTR2YlJvNDBlSUYvWDV1emZyOTJRRDg0cGd6OStnZ1loK0d2?=
 =?utf-8?B?VStMUE9JS1pQNDZoWTVRR3pybFBIZW4yY09VZnZ3REZEWEpZbEpZWE84Tm1Z?=
 =?utf-8?B?TFlPM1pIU1FxZWJ2V0tQZUNTSHNvT3FKYTRpNS9KU0UwMU9TWmlVZHFSZ1Nq?=
 =?utf-8?B?WW1QeDhTTWxWd0w2QkF4SkpGRmhSM2dJNk5OdC9ZSi9vckxRV3gwY2RBRFd3?=
 =?utf-8?B?ZEhCQ3lrTUlHVDBUZ0dsNUw4eHdNd2dqaDFhc2dXcTFDWURhM3Zxc0J5UW1B?=
 =?utf-8?B?TVR1U2Rvell1WllIZTVwYTQ4alpPUkV0MmhzTExSSE9lbmI5YjI1OVE3VnE2?=
 =?utf-8?B?ZnZBNDVqaUppUzdsQWU2UElwWExGTk5YNW0ySjY5dDc1UmlXQ2RJenQ4bGY3?=
 =?utf-8?B?OVRoUHRVZFZsam9wOVp4UWJnVVF2N0UvRG1IRStVdTZ0SXhiK3Fsb3FYZWxE?=
 =?utf-8?B?RlBScmZPaGZWb2VpNjhoRjY2RFZSZzRnVjZrR0R6OUlXZmxYeElyZll3NTJS?=
 =?utf-8?B?V3JEczlRd05ScVdVNlhiTlF2ZjNwdUd3UVNIUmNwcms0UE90dVM3SUoxNXZ1?=
 =?utf-8?B?cDdNSm15emU5Y1ZHRXRyeTNhTTFSZG9qdmxmR1dTOUVyTks1UW11QXRIbmZT?=
 =?utf-8?Q?OrGZbN8ooRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVE1WUdJbU95aVQ2aUtNTVRNZ2x0OGZBNWVGbStaS3U2YVpzV1d4WDVBcW42?=
 =?utf-8?B?MkMyUCtpVHhYZW9uVDFmMU9KM21Rb2Z4c0NMZDRBQURLc0R0QVlZT0RPUnpB?=
 =?utf-8?B?d05KQVd5dFc1bTRwbExEaXlITG1PR2dOaW1udXlTbUpjM2JLd1lRb2VoWG5k?=
 =?utf-8?B?Qy90WEo5Rld1Nm1Iei9wNWlEdlZVQmtLUitmaTh0ekR1NGJWbDhLVGdmVW9M?=
 =?utf-8?B?WmRSSFhBWGZHR2h5RWV6WU9Ga2ZQaGJpYTUzL2NuQllWczFMT2wvWHZwVmVO?=
 =?utf-8?B?bXNvUmJuM1E5alVFYnQrSjdJOVdEVk53bGZPbzFwc3I3dHVOeDlzTDNXTVhL?=
 =?utf-8?B?SGk2OUVQUU05MWRCMjJBbEJkRyszVlFySUxDa0JQbi9UUlhMS0RSY2EwVDhE?=
 =?utf-8?B?VllhL08wZHNwVjhnSGJ4U0VaVmNOVGlKSGdtYnI3eTZFUW9vbnRUeklIaS9N?=
 =?utf-8?B?aXh4YytoUzNOc0d3cFVwekN6ZGxMcUR2YjFuaWQ0bmFsRWp3YTUvU3pxeHY0?=
 =?utf-8?B?LzZ4UHFiVGFMbGwvYjM0OUlPVHI5WlRuV1hWRjJjVC9tb1daUFNnaGlYcysy?=
 =?utf-8?B?TWFpOWRSejVNNHBtU2J5aDJsVEowN0hKMGw2dDFFaUYvem5DQmZUbzhFTlNO?=
 =?utf-8?B?MEJPWkxqVW5BL2c3NkJ6WC9mem91cWdzVnl4UWwzRllTYVVJSHQ4bTNNREQx?=
 =?utf-8?B?emhnSjFTYXUvUzdPSUpTTXhwL3gwQkhYSHVhUWh4QnpHZmRnQkFXN0lhRHl6?=
 =?utf-8?B?eTJsWkJhMEJaRTFkczBMbXJ0TmNuVXdHZ1NxbHg3cEQwQ21RakI2U29RS1Vs?=
 =?utf-8?B?ZUkyMTZ2dkhsdGpDZ0xJeUExSHJOdXV1UFZhcUR3cFMwNnA0NGYvTi8wZG1N?=
 =?utf-8?B?K3NTRkR1YWFOM2tpVVR5d2UzeHVlMCtuL1RqOVQrajFxUnpFRDlFVVRwcndN?=
 =?utf-8?B?ZFR0c1dXY0lNM2l3M096K2NHUldLVW1lUmdDdmVNMkFIQnlHd2NjZkw1TExy?=
 =?utf-8?B?UEtZVWE3ck0ycStZbGpuWkY4dk4xUmZucG1Jd0xBTzFmOUk0cCtLWUxQQk5H?=
 =?utf-8?B?NnNjTEJhK1FlZlgyK043Y0xMYzk4S0pUUWdKU3NmQzhqZU1iK2lNRC9aZkt5?=
 =?utf-8?B?TXAvVjk0M1djOXF1U2dDN2Ria1RuemxNMGhUK0dwSlNPUkRRdW85eldqTlU2?=
 =?utf-8?B?MzE2ekh2SEJaMHJNalhzS0JyeXA5Y0VSVURmUWRrS2pqMmhGWUx5M1VmRTAy?=
 =?utf-8?B?QjVxMUQ4TmpNV3VIMmRJUmxIZVljdGxVWnRKOHV4ZGFvWEhzZkg3d0lwNFRY?=
 =?utf-8?B?dVVHeFJCZEpXWjNKWndDckVWbzcrTStod1N4anFoK2hYaG1rWTlvZnh4ZVY3?=
 =?utf-8?B?WmRXMDlYMW91MGZmaWhob0FtV0dJeXNRUU5SbkVRajIyQ0lOZm05djNlNUpD?=
 =?utf-8?B?OUQxbXJtL0Fpb1RMZUVaclJ0dDhMVEZmcGxwdEhxTDVHZHNzRlFBNlhrZ1Fo?=
 =?utf-8?B?T3A5aGtyWGtXZUJpOHc4eUlqR0c5cE1pUEZ1SGhmSmRTZGF1bCtUY1c4eEM0?=
 =?utf-8?B?a3EzdlZCempVRmZ0Qnk0cks5RWtEd0dXYlNudEFJWlpqZU9PZ0t6V3ZZNEdP?=
 =?utf-8?B?MDREWHRJN2lJYjhnMUxFVXZNelNJa3JpV0x1UzFEMUU4MDZsRXBJVDhZNFNR?=
 =?utf-8?B?V3lsdFlRWURFVk1FdUVhSWpwSEZOU3REbGdjY0JXQnpmeCtESENYMmluMllU?=
 =?utf-8?B?RS9IS25MK3pHemdQQWllb2llY0MrZm1lMmVJL0NBN3ptOW9CRzZacnBPcDhC?=
 =?utf-8?B?dTR3M3QrMHNFakpQci9UejZjQjAwMVk5RFhIcEx4K01xcTAwbTBxbndlNkwv?=
 =?utf-8?B?NWJyYmdrdkYzU2RTbzNrQ0x6N3JNNTEzSjhBRi8vMEx2cXV5V1NlQVdLMXo0?=
 =?utf-8?B?L3FlRUJ1NjV3NXgyQWt0UFRTcmFjMkc0dGJBK3I5b0RubXV3NDZPQ3RFamV1?=
 =?utf-8?B?SVBqVlFUaEFaTm1idjlvSkZ1SHlubENEaWxuby9pQUdkYmwwbk9PV3hSemNJ?=
 =?utf-8?B?OE05Q3Z4N2lQRjFnblBCeE56cmxtdlBXSGJsbGtleGdzcFV3ZHEyOGU3Ymta?=
 =?utf-8?Q?+RrHvclu3yMuO1XHnGudJTQ+j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93909bf-5514-4583-a99d-08dda855b0ee
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 19:33:35.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1vAn5g5nbXXC/KscyztWDUnt0ydykTzVOHyMqqBd3v8uvuRwGjUj6AI7UUL2AbXFUNuPylIHIrwMemayWkhXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656



On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> Currently the call_rcu() API does not check whether a callback
> pointer is NULL. If NULL is passed, rcu_core() will try to invoke
> it, resulting in NULL pointer dereference and a kernel crash.
> 
> To prevent this and improve debuggability, this patch adds a check
> for NULL and emits a kernel stack trace to help identify a faulty
> caller.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

I will add this first one (only this one since we're discussing the others) to a
new rcu/fixes-for-6.16 branch, but let me know if any objections.

Will push that branch out during -rc2 or -rc3 after sufficient testing.

thanks,

 - Joel

> ---
>  kernel/rcu/tree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e8a4b720d7d2..14d4499c6fc3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3072,6 +3072,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
>  
> +	/* Avoid NULL dereference if callback is NULL. */
> +	if (WARN_ON_ONCE(!func))
> +		return;
> +
>  	if (debug_rcu_head_queue(head)) {
>  		/*
>  		 * Probable double call_rcu(), so leak the callback.

