Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22B28A40A
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296414; cv=fail; b=ddAVIYrg91zUExXVHD2nLXeZy49Rf4oYV7TijzUNRT7RhW+34WdJT+ii5uXz9ePc2Y+DX5M7cM/a+sIJylC4BVn5AYDJyXhANmPsmeo61i5eec2CaoASIV6M16ERApglrnC+RbwZ0MW0kWSn5oucQUIjQT7tuICBBBAd9WEvF/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296414; c=relaxed/simple;
	bh=aeXVJ8fxTNmJrDikdVHZi/DhtcotIJQ4q5gjEHl89mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ir6Gf8YFVjHrMusuV0PPIo525aMWGhdXGUR671EJSGomcOQfebH5CUx0cBS6l/DwWBbw/+m9v6tKYnKUwpou9M9v3eBu3nt5RjtRfMqSLJIeImfOdAvxv1M1aDi6BdgMR9bJvlKlj18pnN1DjF31XbXh3jUhvNl0mLGdEcZuXDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGk228Rw; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGk228Rw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcFH7PvWgCF8463ewPSMqKfK8ZooN1hjp+522EAzRKFg+31VbB+EVoHo4ImKrxl+myvzS9vF5clDvFhr9UIyXM4Gx+kK4cISCnpxHKMNLG8OJZ/5/CCHvbAurDCm5OfBn/aAzabxp6kbETafXMHIM0tpGgDdmlvvDhQ5f3ZSPwgoQz+wyXWeuuV+wsmINfm/BO8UpzyhK2M8SWnO69MWtqSYlQdyk8RW0b4fYkcWiAm9ffZqxuHeVDCZbOanVVZ1bGCEXM3vHb9jeGWtF9BbnFPS5uPtYnvi9L2AMTtR7z+eAsLtTk1PV4NqqKd2HC0wuFeLXdhF/luGtFo/uRM3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukx/yFA+AcCcl4xa7UAaOPYo5xSjg7pkDpvrFofzKuc=;
 b=ZZcf4gTnHb9mEPSo3EHBVlt69/A5bibitofGSCXePRvZWVQlGqWxPgK5BtWs1Y7UCntIp2VXpTdSib/qvvzE1PK3VdLhkNP5K+o0Ay9XvfP8lBMv2oBNSYwh1AzxDZjNDiDGYiTQpFNUYrZN4nUWVGDebBYNHCvV1RWIOXna5eOchlzAywVB64femGzF/bKTHO9zA1oi/UtaVjm7+LOXMz7O0iCfyMg1lChsBBKa15f9KMv9Xx3T82SXF2S0uY5X+m3RYYUUBSym3bblCo0WIPb4NVOiK41IWvKFsim3EzeA5EShi738NQ+ZwOFZX8/Y/qUGUtp8xlE/yfxwjBpZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukx/yFA+AcCcl4xa7UAaOPYo5xSjg7pkDpvrFofzKuc=;
 b=uGk228Rwk/bTfHzCDg8yeHE0/x1Gx7pG1GiAlkfswYWWkuEuMcioIy2IzJDo3Zp3m8n2E+R/XZn6PjWLy2Zcqqfg0+B4KRd0s/rfGryHDZRCDQ1LFC3hKZj3gGU4L0Au6HT1nRMQeJm8J5I6RpL0q97a12L/C7A+IOhMAnMzEW3Rz5N9qMp2gaOgC6mFz3VrIJolNSBKgSVJRcFkAAWl5EB/4//1X0vXURZAf1v+s/dtwyR7Jw1bqquM1ik8Ac4yO6jJxOBs20R4YOrJ+tfRNRpCd3DEYAS+HmAJKVwFgIiL35PCLoHH9JTxPBvCfMQHYCIr5Ax3Beni9HoHsAgsDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 14:46:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 14:46:49 +0000
Message-ID: <302722da-aee4-4f87-9fdd-f75b65df2a4e@nvidia.com>
Date: Thu, 10 Apr 2025 10:46:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Possible scriping bug in rcutorture/kvm.sh
To: paulmck@kernel.org
Cc: rcu <rcu@vger.kernel.org>
References: <a6039f75-3662-48cd-8346-4cb8ac929685@nvidia.com>
 <6c3c4861-a7ca-41d8-b9b5-0dfb226f54d0@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6c3c4861-a7ca-41d8-b9b5-0dfb226f54d0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:c0::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 488d72bd-024c-4982-de56-08dd783e861d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDdvWmN3ejRvaG5JTmltQlNTZit5dDlxaHVrMURvSnVsc2ljQmRUYWFMTGxD?=
 =?utf-8?B?dVdsQ20rTDNJYjYyMGhSN1NVTUF3TlRmaUw2eWs3UEJMbEtVSDh4WERSbm90?=
 =?utf-8?B?a2xOM0g3VzFBTkpPbzlQajRLZUk3RXdtemcraUpPSHprRS9raEY5ZW9xc0VM?=
 =?utf-8?B?bUJNWm1rS1lib2I2RzBrS2pEV3cwVFVRQ1dTcXVDeXV4bXc4SEFoWUpGaDRW?=
 =?utf-8?B?ZmxMYjBVTnJ4SVlGTEZ2TjVwN09qZzFGczJvR2ZUQXYwR3FtNk9CSU81dTdi?=
 =?utf-8?B?Q25VdzF5TXFmcm9uK1RXQTVUTGkzdHJuTFc2NE53bnRyM1FOL05UZnNqMkc3?=
 =?utf-8?B?Q2tGWUZ6N3hjUEd1QnV6QnFGSUt6TGRVTjVlUEpXZWNUNjRVTzA4aGEraDMx?=
 =?utf-8?B?Q3UwM3k0eVN6eVJqOHFuNHM4a2ZvQ2ZBOW56aFpzQlJoTGdEQ1JnN3lYdmN1?=
 =?utf-8?B?UmpkMTlBY0hzNWg1M3g5ci9iSnYyemVFZXNtNHBTdmVQTVJXOVBsWXZiVmJy?=
 =?utf-8?B?RXRjZmJ3Z1ZoMGtuelNIVnB3Rkl1ZEwybW9VUWI3OTVkTXdCa2ZGZW1Gb1BV?=
 =?utf-8?B?QmZXczJnSTZGVGx0dXFORjY3RkNWK1ZCWThJUFhldUFrMFhVeXAvTDUzQzdi?=
 =?utf-8?B?U0d0UXlJK0w1WS9yTG0yeWdxcjUwamJnalF3RHNiZkFxSHQ2bnIrdE9LcHI5?=
 =?utf-8?B?ZFpQcnk4VW9TMlpqMldHYVlvYm5KbjA1VkEvb0VVL0syUEJpbkxROThPNEZH?=
 =?utf-8?B?dGt1b3piWlVFRTFJS2JEa2diME5haVlJVlpoTnVqQnUxV3g5U1pxZlJLVEdD?=
 =?utf-8?B?cUtJU2pnOURWQnVudjgxWURkU3ZhTGY2U1dDU2pnclRDVEExOXhlQTUrUCs0?=
 =?utf-8?B?NGgxRzUxTzdkTVdydnhIbCs5a2hvWjM0K0NRZkpyT1cyL0VwYzNoTC8rbnhG?=
 =?utf-8?B?Unh5bVh1bXRaZ0tEcGo5ZHZnKzVRekJRTHZXcWs5Y3l4M0VYRExWV3pCeDVs?=
 =?utf-8?B?M2hub2FNREQ4enZVVDdhUmRDTUxpcGdxSk5TdXQ4WEtoYTRBMlY3UFRGWDlx?=
 =?utf-8?B?emVUSU1icDFIMmlOak9BMVExN2VTK2tpbkVrTDUzcHBpLzYwQThQWkdDZG9u?=
 =?utf-8?B?MDNEUGxPR3k3cVJxOUlzZ1VKdnAxMVg1Vm9YRXAvT1FrMCtqQVplaVNXbHhx?=
 =?utf-8?B?TWY4RkxLVFdvN1NwUUVoUnVvVHY4ZHRhWGZtMEJ6dHB2U1lJQnhCZWpHVWln?=
 =?utf-8?B?Rm1ZeHh0UWhwbVBXVWRlckFscG0yNGpTL3MxSkpDVjRHblZ4UzBqSnR3eTF5?=
 =?utf-8?B?QlRqc2JBOFo3NFVoZjRUOVdZOXRVajZPdzFzcW5QU0xUMmE0WHQ3MTIzaHA0?=
 =?utf-8?B?QzNaU0pndGdBeUtsN01vdnBWS1JPTElyT2tnS3FQbGIveHk3M0ZOd1dTWVZk?=
 =?utf-8?B?OEErMkJKY1M1RDBFa2s0MDFEc0U4elpZNnp2OHVYYnZCSjZULzAzZnorVDha?=
 =?utf-8?B?aERIT2xva2pSTytCWVA5aFZmZURweWVQT1AwUTJkMjNxR1V5OWZkU0xuWkdx?=
 =?utf-8?B?LzJ5YURpaTZYbkhJV09GNWptczF2U0Z5Mks2Tm1wUmdOa2pJZC8zZDhuSHl3?=
 =?utf-8?B?SnpWaUp1cUdoZ2VmaExoWDJaR3Eycmw2dXlOL2xHaVM1SUFhNFBsZTlLdld2?=
 =?utf-8?B?TjcwaDJJRzNzazJrb0NiSERxRFMzUXo4VXpuK1kzSWhrcnJ3K1RCaER4SDJt?=
 =?utf-8?B?SVk2Y21zVWVLVzZRVnpSQUVYc244QWFjQTl6N3BQUlJtZU13QnJSOEVGekQr?=
 =?utf-8?B?cWloWXR5R1RwcFM1S1FxclA5ZkU2RXFSNU96c2k4TUdqNll6WUpLYzZlcE90?=
 =?utf-8?B?K2FtQ1drUmFIWng0SDVuRFh0M2FHcUhnL3ZKaUxmbHJKd3kwakJZOEYrWmdw?=
 =?utf-8?Q?gU4yAKf6U78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnkvSzJhWVRZd3M2V3MrRXhtU3l0NDhxSkF2djFPODNjQUx3Wit0enV4MWJm?=
 =?utf-8?B?SUE1QTAraUh3ZTk4OHlBcnBPWDA5NVNiR1ZTbzB0UzBrNlQ2cWNJeElVVHUv?=
 =?utf-8?B?OTdIU05OZzU2emFNNnRXQkl4eDhscitFaTZRYXFicXRzejYxV21uYVF6WWJJ?=
 =?utf-8?B?UERMbnU4L2ROcFhSdXlsS1AzeWl6RzRqYk1WQ2ZkUWM1SjJqRWtJai95MXgw?=
 =?utf-8?B?eHJWcTgvOHI0K1hqaWhiU2VYaFBvbzJwbk9CR1locVN5NlprdTl6S2V0Qkp5?=
 =?utf-8?B?TmpuaU82SDF5WlV4SUhoTkczZ291eXdpbEhzdk8wbG9zWklVM3dmbldEczUw?=
 =?utf-8?B?eHphYW1CT2FMaHZoQTJNb3U1Z1lTSEVNZ3NDVVczZmVCaEkzb01OOUF6bmxN?=
 =?utf-8?B?MjBHY1RPazFpRVJJc0JldzM0WUVQc0RaYVYwQ0NCOWdnNEhrZ3VFWjN4cXg4?=
 =?utf-8?B?WmYwdzlzUU5hSFJmMmJ5WUI2Q1ZnU1B3MEVpbFpOdHVjUG5NcndZeUtGTTY1?=
 =?utf-8?B?M25hTUpFdFdjUWVNeHdVbXdzRVJQNzlVQXRaZUx2bEw0NmxZSm1oY0JhM1V4?=
 =?utf-8?B?WDlCZERnVGJ3bHdKS1U1cWkwajNtS05WYXNDYjZNbnd6YnJLRkx1QVZxbnl4?=
 =?utf-8?B?aWNMTTNaU21tdys0VWs3ZE82QTREUitSRWtDMVlnbmlTKy9IRy9DTS80Yjlr?=
 =?utf-8?B?aHd1ZjNkYzg3MTZvSU5GbXErSHZEdDVsMWdsdlh3NzRhSmlJM3lVNGdOaGcx?=
 =?utf-8?B?Vm5NVEx1enZ3NjNSclFWcjIydUtndjVCd05Ibk1PT2h3bWhsSEtjZ1NKUGtW?=
 =?utf-8?B?OTZuZXlTL01hTTVsUnZrc3NTOEV4M3dpUHdVK2RmOU1EcS9hTFVGKzRveWds?=
 =?utf-8?B?SG00SkZRaS8rclNjeFh0dzY4K1ZVQTVSN1E3MHpKdytlLytNVVdoaE55RXFv?=
 =?utf-8?B?SW81azJmQkVtU3c0OTU0SzU1SUR3TVNocDJyUFRjZnVFN3kvZVlDVDMwZEtX?=
 =?utf-8?B?d1h2OEk4MGRlYmIvb09zMVVZZ1FVbXlwZjFqVUZKd0NWL3MxcXlMWkR4K0tU?=
 =?utf-8?B?UTZ2VFZLY1k4TmtDZlJvaTEySHFRY0NoZGhkWXJUeUN3SmQxVlZxSzcyS2Nw?=
 =?utf-8?B?c3pmUUVZbktWRXlSd25WZVc1TmhpYWhyT1NTaFRCVFBvNjRRbFhiRmlHeS9y?=
 =?utf-8?B?STRHRTNKYTIzemc3TVhXMDQ0V0ZQMlBTcm9HNURnUitZQUxJaVp3SzE4NGp0?=
 =?utf-8?B?U240RVhqd01hRTlWR2ZGdHhIcGNOSHVvMVMvR3NGd1NJTnF5aTFOcnBOc0Rn?=
 =?utf-8?B?eXVaNVU0b0xJUTlEMlRXa0cvUEdOcDdlTFZCZElTNVd3ZDcrd0NUckQ4bmRM?=
 =?utf-8?B?OXQ3alFaQW44c01lbkl6dFU0TWR5Nmd2dEo1bmUxU2NCbmhIZkFkTVRaaHZv?=
 =?utf-8?B?dUtwdkQvZUc0bk5NZVZDU3pRaHcxMGJjTXFCUTJ2QzFTRCt4QWhweW1pdGVJ?=
 =?utf-8?B?SWh2bUZ1Wm9pQTh5bW1uTFFNaDdGcHRaL3FidGNXZFBwVmlBUDZ2anpBSUI4?=
 =?utf-8?B?UlJvOXcvdU9SeUxtWStWYmYzcmtjZTRac1F6emd5NHg1QkliL1h4OTlvZTA0?=
 =?utf-8?B?blNxUmcxQ2lEZGh4c3ZaV1pTdDlIbFppR2p4WHpiOTJmNUovYkdZQlU5TUVD?=
 =?utf-8?B?NkF1VHJEcHVnWmtaQWhFNkRSUUp4b0UvNjRld1A1Rk0xcjlGY0xWalJNckVT?=
 =?utf-8?B?ZDVwVUZndllBU2R2M0pzYjlOd2ZtM2ZOdmtXOGIrc1g5TjdpcHhCemNBWmx1?=
 =?utf-8?B?blRsRXhBTXpqbzRoUFlDeG90ODZTaGpaMGl0MmUyVzlIVlRBcms2cndCZkZx?=
 =?utf-8?B?SDFoMVh0cEZLNkY4d0xNeUhvcjlid3pRKytSWCtWdjMwNEgxWGxMVlZXODZ6?=
 =?utf-8?B?czRlKzlEZVFWZkhiWG1YaWdWTEduUFVycXdVVUJPbXNMNlBLcFV1Ny9MWDJv?=
 =?utf-8?B?Rk82M0k5ZzVRUWxNVEYzY3VkQm5UMExFcUhFTXVYY3I4bXdXbFh1SWpYWDMw?=
 =?utf-8?B?cENUWkZ2dU1HQ253OGtxNHJhUHlubGRGU0E5US82dHQ4VEJqQThYWFpJQzUz?=
 =?utf-8?Q?eTHT6a2qewRxEZFwt+0BKJkwS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d72bd-024c-4982-de56-08dd783e861d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:46:49.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrgCup01G604O5HWLdMdyt8tMC6XWZ/bxJ+QbrwcOcrB4dXUP27iMvx0gveSNHEM8kPNbEa8dJli6BpAOxH61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633



On 4/10/2025 10:31 AM, Paul E. McKenney wrote:
> On Thu, Apr 10, 2025 at 09:59:07AM -0400, Joel Fernandes wrote:
>> Hello,
>> Currently with my ARM machine of 288 CPUs, I am only seeing 56 of them used at a
>> time. Any ideas if this is a bug or I am doing something wrong?
> 
> I regularly run with 80 CPUs, but perhaps the script's check for the
> number of CPUs is broken on ARM?  It currently relies on this:
> 
> 	getconf _NPROCESSORS_ONLN
> 
> (See identify_qemu_vcpus() in functions.sh.)
> 
> What should it be doing instead on ARM?

I am guessing nothing different because it still gives 288:

$ getconf _NPROCESSORS_ONLN
288

> 
> Huh.  56 does not go evenly into 288, either.  Search me!
I think its failing because its only running the first SRCU-P for me and failing
for the rest in the batch because:

I see this for the rest of the runs: "Initial build failed, not running KVM":

I think its because this line is failing for ARM because it does not have a
bzImage (it instead has Image):

if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f
$base_resdir/vmlinux

I'll try this and see if it works (sorry my thunderbird is wrapping the diff..):

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index ad79784e552d..957800c9ffba 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
 cp $T/KcList $resdir/ConfigFragment

 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f
$base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && (test -f $base_resdir/bzImage || test -f
$base_resdir/Image) && test -f $base_resdir/vmlinux
 then
        # Rerunning previous test, so use that test's kernel.
        QEMU="`identify_qemu $base_resdir/vmlinux`"

Thanks.


