Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA41DFE1;
	Thu, 10 Jul 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176501; cv=fail; b=ibVw6ZxT3XP4Q9qiGzhO1i8YmDpF57auYDoAbPZ/70pe2b4sX+B7j5tITYxwM9ygVVa0iaN1U/7/6wbNaWvvpxIe/WwQSJLsQNloCefEv1lolvoKkZNUCSg8Ww4b7Kocl8lcLCL/LZqnLezMiayuNPnj0IK7UONM6vM50OCTXc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176501; c=relaxed/simple;
	bh=UFsUV5/NrIK2A+5GZrBF8XzZyPNAA6UBg9BYNx1bH2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbdxqycOdjkmVcfB4w+x7uHm33RNllj5BSbS3W81/yyWpYoduA1ebIBihHYupA8lVhj1j38/R8BFJBGYvD370ZRmzMBDSgCB29WXH4HzvJetCPMRwtceI5X6h/G6W70oxuuVdCtBJLXt2Uqck9koMHsmZpoYFbrjHHhn57F78qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fymrDTJw; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fymrDTJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugY9eP0LaQaj2deCmB1r9m+sRomO88egVm6/4Ojxngd9tHHQYsWfDnT2wwwovW6ILh+EZEuh3E4/u6LYWr/jC2vyLLwY13bxOj3Nly/JVkbP0s26uT6N/fQoxr/hmQSnToCVpHB1jM6trjQK3aQ2mXLJ9JWDNOxQ3aOodMUP0LtVDcMuXCmcuf3mr6tpPtENBkndtbDRslEeeK4d+ncfshL6poO6505arkyA5M68dqPxeUOTM/CO7+52Cm2ZVFrONNlhfXVODGrjNw4epdtpdoZCOvfY9i2oNbzyda8mLKtiFmLv43fSAS24VCsnRSxjn1k+Jiw7S1Mn8qkf+uCZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBbHhj8Gci8sbna2uJFjHXZgueXQJhnWHC/3XoOjZDQ=;
 b=XCfBPV3Zm/OkT5+TK4PYny/5xGQ3eEM0ZLagcKEUSdursgBq9VltXYxOzsIeMYPjEPuzYTAT5Fm3APUhjGagiEPPYhbLR9+n4ilhqclRgI+ikS1S3r7HjJk1jNHOpn8Y9/+tHPRLOI49+QqY226Dz54neAqXUR4837/mYRjHO1uYxzyDQmAxXa6cPaq3g3gOxxwhpXWtEdKqJ3MSaI4CH8lm62eYtoO/1A88pXGZ5Eomr/ibFkuHVfVKkTWtlEMIcYoHw3/Kc4yY88Ah11Hq4WWh4Ouw1BgYaZuXxP5HZNmZfvmc2YO9Ehj69ZTIufcnPGpSXYt6fKr667E8Q3QOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBbHhj8Gci8sbna2uJFjHXZgueXQJhnWHC/3XoOjZDQ=;
 b=fymrDTJwgqBW5oTRPGgMstg/Za1M134Ze/PCVyfqgeoICBDgPOlPh4ADMN2gnRU+0uxFU9HxdANd2J2FgYS46QhV3u2ueEgY+95w4lGcn8d/TM1t/wPhKLIAU6j/vMAStwavIWqHGbQzFgqt2vpQpZrAmYzOvPlURu116fjfVz0BEi+/DUW0ZN/uHrNZ9mVXpLAZfOtzRSt/FzjIDXrGnzCIr/QRA5T4y39Fu23Y9RlP4yKM8YJO6BowxWEJJnOVNSpHpy2dNgLvTSkqw7Y8ztDFi5lrP0lTyMExfKZBQHXmRQCuU+OCccAEGjbBbbHxwQNoaQNY1VS2PmDAuOX8vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.30; Thu, 10 Jul
 2025 19:41:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 19:41:32 +0000
Message-ID: <f3239ca1-81a8-468c-bca0-e439a18cd304@nvidia.com>
Date: Thu, 10 Jul 2025 15:41:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 5/5] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
To: Frederic Weisbecker <frederic@kernel.org>, neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com, neeraj.iitr10@gmail.com, neeraj.upadhyay@amd.com,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>, Qi Xi <xiqi2@huawei.com>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
 <20250709104118.15532-6-neeraj.upadhyay@kernel.org>
 <aG5lOzY7s4GKjCOT@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aG5lOzY7s4GKjCOT@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0339.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0cdb3-2153-4d42-d4a8-08ddbfe9c59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm91dlhZME85SU43WFVRc0cwYzkwTDN0SDB4bXFSRWJqM2pCeWIvSFpuNHVS?=
 =?utf-8?B?RG90M2JRT3duZkVjSVlrQXY4c0I5eUwxR3JTMWw0ZmhTWUhSalpyU3NCMHdv?=
 =?utf-8?B?d09oeWhPcVgzSGkzUjZON3Ixc3l5T0swWmRHalRWNDIvNEg4VFZIRGo5eHlB?=
 =?utf-8?B?NXp2bVVXTHdud2FqcVFEWU82SXNFZ3hTQ0tuK2twVGVBR2taY2QycDFKUzNR?=
 =?utf-8?B?K3p2dHpkNkJQSnowdThaQmwzSTRiN0FNQWNYaTJOYXl4d1l5alA4emkvZWJH?=
 =?utf-8?B?N2JIQ0IyNFZ2UENUSnR2Ylc4T3dvRzdhaG1TY3lDbW9UTXQza3piTDRETUIr?=
 =?utf-8?B?SS9OU2dka0JhbVVBY1ViNWttR1ptbzRWaU8xbUN3aURydUxpVngwYVFJM2Jk?=
 =?utf-8?B?NXgxRGtIRjk0VG9TOFhlRDZvK094SWtQU1d6cE9NSWRoU3NJaENCN2NqTElz?=
 =?utf-8?B?OVByVzhwUEpxWkdmRlhVeHFLTEJmSlVic2RvM3dEUzZqQW96QWJBK3VnNGlo?=
 =?utf-8?B?aTU4Uyt3SG9FN2krN0htMTA4U2VTRVJQcm1lTTM4czUwUCt3dFJsRGlmUEda?=
 =?utf-8?B?eEE0THQ0ZmNQdlE2K2pQUmd2dzNwbkJ1MjAyQ2hSb3l1VFRJcm1EeTBGMVMr?=
 =?utf-8?B?Tk1JMExqbXRXWTdXN1ZLQWxTVitaeVF1WmVZWkJBcDI0UC9HNXhVWTM2cDR6?=
 =?utf-8?B?cDZFc1NNVmNZak9heDNrZUdEQVJaUTJJRGNSTE50RW9LQ0hkNWlNcGhvVEhT?=
 =?utf-8?B?a3paSWFlanl1S2orcnNPMWlXQ2o4MVZVSVZxWWlMQWRrSWVmNGpWUHhheWQw?=
 =?utf-8?B?cUVGRzd0U29ubFhLVmlKYWtXZDlCL1JEWG1BYnhDMzR2RTNHdWVLZ2xGc1BP?=
 =?utf-8?B?TFJpZEJXVDB4d1FOY2p3QlVydERlbkN6QmttZ2prSTFWNE10dFRDejlnTmpj?=
 =?utf-8?B?eDA2VWhnWUpCc0QzSVpNMGh3RU5sWGg1SXk3eUFxMXRFZnVkYnRpUW9yVWg2?=
 =?utf-8?B?aFdRcFVMWVNZYXNsK29ydExxK0d1aHZHVHhnTi9DNStxV2MvU1dMY0VLeWpp?=
 =?utf-8?B?aHh6MWpTaHA2c05YRXBTcFNtOWxxQThGdnhUOGdDbTM2dWd5OTBtdVlGT1F6?=
 =?utf-8?B?VXIrbnJvaDlVdytEb0ZnVEdHbTl2K21EeDI1RFhjVzRTd2E1Y3BRRXNEWkVl?=
 =?utf-8?B?NENrVVg4YVIyd25DTyswOVVrMVlsN0hmTkZRdE00MVVJT0lYVDB5aDFVMFQx?=
 =?utf-8?B?NnpCd3ZuVml2Q00rRkpxbi9XU0tDd1RIYWFiQldrOSthZUlwZ1V6d0tlSGtk?=
 =?utf-8?B?b0FlcEx6VnJSN2cvaE11ZlVoUDFGTjRkS0NQZUlOSkpNVEFha3BjTzIwZkNr?=
 =?utf-8?B?Mjl5Z1IzMm50WkxmUm9zc3dQQXJSU0Z5ZUI0dklUUXY5MitvVW02WnhqRFhp?=
 =?utf-8?B?VHloekpwbXJwak9tM2M3NWFMYWNiQVJtaEdmR2MxYWZRSGlDQnh5eEZXU2d3?=
 =?utf-8?B?ZlkxTWkxanhuMTFwMEhSaVZ0TVZFMUg5d2pQTEFuWFRka2dCTFpEcDZJbkdz?=
 =?utf-8?B?VU05cTJEa3JoeTFHTFJmcGhBM01DMTAycWJDbTlqcTMrM2dsSzY3NkticDk5?=
 =?utf-8?B?YWFYSGJZVktCYUdHSUVpZzlML0xIZGhpaDd4eTJ4RDRCaFBkUzRaZnFhenNi?=
 =?utf-8?B?TDgrM25EUms1cWd0MGhoYUhNWkFkYWRCTUlEZWJnZnlzNkZ4T3RqcGxZQzZE?=
 =?utf-8?B?bzFkbDFzWTMxK0dwZFN4R244eVY4QUlVbVBWSEhxWHYzYmlCZWhJMjJMVld1?=
 =?utf-8?B?ck5IRzVIbDdkR0JOakpyc05HN2dDaTRzbkJWZVh1b3hCb0xnOHBMUWg1RHRm?=
 =?utf-8?B?M2RXWnl3dFQwbFZldDU1MGxTdmpWVU5ZdFg5ZHJ5dDlKa1UwSzZOVEJpc3dT?=
 =?utf-8?Q?H0AuuSgqCFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJxY1dDWkl3WTdyUWxwYkRjdGxMc0dFRFRsMHpjbkg1N0Z3dGk1TmpacCs5?=
 =?utf-8?B?Y1hOU1BCOWRkeW02Ulo3eTg0c0ZDcEpEK044aENSSXc4VWNMNkpGQnBKbU53?=
 =?utf-8?B?bzUweEQvNk9BdmtBSTcrMUNwcmpscDc3b2srL2RLVUVWUVFBRnduTWtReG81?=
 =?utf-8?B?UVBBMDljTUhFMWQxcmZaYTkzN2s3d2NXMlViR3NqVUlnWkNpU3MxTXdJTnZi?=
 =?utf-8?B?dnpvV2NPcXNlV1YvbHF5VXNLTE50N2VsK0JIT3VLZjlaRzBlWjhjUW5EdFVO?=
 =?utf-8?B?TXlNVmFBaHNWaVFUT0JxNzZRenltYjZncUd5NTBvVDV5QytQdHk0Q28rZDJW?=
 =?utf-8?B?aEhnQlZ4bE8rZE4zeGxxb3ZRYjZzaFYvSzVScUI4YnZBOU9MOE9ZdUtHRGFV?=
 =?utf-8?B?WEU5UnFzcGVDL2xNemtjcFVua054bmh4YllPODhObUtzbG54UnEreldWRTQ0?=
 =?utf-8?B?QVg0clBKU0gyaEhVSHhwTTd6WmZYd0thQ0NRVTVLYVVzajdhMW9TcVJ2UU9u?=
 =?utf-8?B?d2tyNFNXWXNLSFVvcGN0MzJiK083aUR2NU5YSS9DWnJJOUxOalZqSnIxc0Vu?=
 =?utf-8?B?Wkp2NmxRZEpucEJnOFZVQlduaXJTdzgwQ0lqOG42UXRROSt0Q0hqREJ3N2Fo?=
 =?utf-8?B?cVhtSlNqRmhXWDJwQWJPVk9VbC83MkgzcUlWQkdOaFk2SnVJVll2S0lqTnM2?=
 =?utf-8?B?U2VqVlVwOXhXVUVFaVAzR2Z2Y2JsdkVTVHp1OEJuY0ZBWDdzdERRQW9MOEN3?=
 =?utf-8?B?ZVN5SzA1TmhXUjc4eVozbEVKWUNDd0ZWdkI5eHRPZVV2R0tpMm5oWFBkZlpt?=
 =?utf-8?B?ekZhd3VScExBQWhmS3Q4WDdDRTFJUVZkZWJQaWo4MEEyWk9nZHNldGs5c2Jn?=
 =?utf-8?B?VndsYlZDM2NuMzU1MDM1N0cydnkyMDFNMmJhdkgwS3lGL0FFVXdiUWsxV3Ba?=
 =?utf-8?B?a0E4L010a0NJVlVzakU3Z3dqVEJXN1BQek1RVUloOWRXNCtnV0RxUC93OHRy?=
 =?utf-8?B?Y2sxcWw3UGRxNHZUVFNPd29iUzVnN0tyYlNhSzJyTmJTaTM3OWJ3eEVEdlda?=
 =?utf-8?B?SnBDb0pBS3hOVDB5WkJna1Zqc2RUeWNxdGpWT1ZXUHJ6OExOTWMzdi9UZHRh?=
 =?utf-8?B?QnFEYmk3MVVoQnAzbTIrajRUOVgvZzBEdGtKL3ZlcUQvbDBNeVdjNDNna2tF?=
 =?utf-8?B?bGRvREdoenhFRm96Rm8xZjk4MFQyc2I0RnAyNWlZZ3JXbEZoWm01M2pPb2V0?=
 =?utf-8?B?SmhBOEtKQzBpMkdPTFVTcXBXYUVpcmVvV0RHNUhmU0c1K1M3V0JIQ2U4VHNI?=
 =?utf-8?B?Z2w2Y0U5VGRXYXk0bHVNWXhVYzB1QzZqWFIwdFRFNGZJSkZwVVRXSWViUzhI?=
 =?utf-8?B?T25PMHVVQ1FNd1RzVjFOSE1JajV6dEVnK1RzcXZkclUyWlNLMWdyQWMwTURO?=
 =?utf-8?B?cnRIVmw0QnY0U0J0YkNFR0lxTVJTblRiWk1IVStTSjhEcm5SQjl6VTRuSUtF?=
 =?utf-8?B?cyt2azM4elBuZ2JYWkpVWm9zeXFMaWkwc1FSNVBIbnJYNCtxUmpYVHJaWGlX?=
 =?utf-8?B?bWRtU1FDNUVaNXdHTDVUR2NmRmF5SENJRUEvT2hsUmJZcmNkWWVkRURmQ3ZO?=
 =?utf-8?B?WkpqKzRIL3ZvOEVCSUhkNDlxcERnTFRyUUlFaVpzUndTRTAvREVCRDVNMm54?=
 =?utf-8?B?OE43Wi8weUVjRkltblFwU1crZWdNSWNicFJnUXQyaHE3SUxuWFhKR24ya0dj?=
 =?utf-8?B?QmFqUWdDRndDajFlOGFldkordlVmdWIzRk1TVkF3Ujc0clQzZGxpVnI1U3F4?=
 =?utf-8?B?blZWbW0rclFwbllCNmFXdmFIS2tSeU1LQmdMQkxxQVd6WGROVjd0MWxSOHZz?=
 =?utf-8?B?MTB1THpHdzQ5SjVCdTNZc2F5bGtQcWhHL3BTNWpvOWVXb283c2IvYjF1MXkw?=
 =?utf-8?B?WTU2S2ZXQThnTUhnTWFNayt3QVJBWWlJYytBUWNlMHhKRGs3M1RPZ0xjamxi?=
 =?utf-8?B?NENFQXpkZlhkcGpMNlQzSmdBUUx1Tll5bWl3SUp6TVVWd0UwVFNyQ3VhdUVX?=
 =?utf-8?B?Q0ExWmhOeHg5dW42MEsrdGltZWtHazZ5NlR3QWQwUVpiRnlmdVVGeVFOR1Ny?=
 =?utf-8?Q?PIH1ZT2L5A9KRW4cCuaaI8rBZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0cdb3-2153-4d42-d4a8-08ddbfe9c59f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:41:32.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2+Xp79y0e1kngiYZ1oN7TaGImFGtBnJtZf9cjg32iN8cPDQuCT4ZbdWPDvxOD1hiGSvIzWM2csmZgtMTy9/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248



On 7/9/2025 8:48 AM, Frederic Weisbecker wrote:
> Le Wed, Jul 09, 2025 at 04:11:18PM +0530, neeraj.upadhyay@kernel.org a écrit :
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> During rcu_read_unlock_special(), if this happens during irq_exit(), we
>> can lockup if an IPI is issued. This is because the IPI itself triggers
>> the irq_exit() path causing a recursive lock up.
>>
>> This is precisely what Xiongfeng found when invoking a BPF program on
>> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
>> managing the irq_work state correctly.
>>
>> irq_exit()
>>   __irq_exit_rcu()
>>     /* in_hardirq() returns false after this */
>>     preempt_count_sub(HARDIRQ_OFFSET)
>>     tick_irq_exit()
>>       tick_nohz_irq_exit()
>> 	    tick_nohz_stop_sched_tick()
>> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>> 		   __bpf_trace_tick_stop()
>> 		      bpf_trace_run2()
>> 			    rcu_read_unlock_special()
>>                               /* will send a IPI to itself */
>> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>
>> A simple reproducer can also be obtained by doing the following in
>> tick_irq_exit(). It will hang on boot without the patch:
>>
>>   static inline void tick_irq_exit(void)
>>   {
>>  +	rcu_read_lock();
>>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>>  +	rcu_read_unlock();
>>  +
>>
>> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
>> Tested-by: Qi Xi <xiqi2@huawei.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
>> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
>> ---
>>  kernel/rcu/tree.h        | 11 ++++++++++-
>>  kernel/rcu/tree_plugin.h | 23 +++++++++++++++++++----
>>  2 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index 3830c19cf2f6..f8f612269e6e 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>>  	unsigned long   jiffies;	/* Track jiffies value */
>>  };
>>  
>> +/*
>> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
>> + * It can be in one of the following states:
>> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
>> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> 
> Never as in "never ever" ? :-)

You're right this comment needs an update. It should be "An IRQ work was
scheduled, but a deferred QS hasn't been reported yet".

> 
> I'm not a native speaker, so you guys tell me, but isn't it less
> ambiguous:
> 
> - DEFER_QS_IDLE: The IRQ work isn't pending
> - DEFER_QS_PENDING: The IRQ work is pending but hasn't run yet

It actually could have run but we could have been in an RCU critical section at
the time.

> But then the name are already self-explanatory. And then keeping
> it as a boolean should be enough too. Why do we need these two
> states?

Its just more readable, IMO. That's why I kept it like that.

>> + */
>> +#define DEFER_QS_IDLE		0
>> +#define DEFER_QS_PENDING	1
>> +
>>  /* Per-CPU data for read-copy update. */
>>  struct rcu_data {
>>  	/* 1) quiescent-state and grace-period handling : */
>> @@ -192,7 +201,7 @@ struct rcu_data {
>>  					/*  during and after the last grace */
>>  					/* period it is aware of. */
>>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
>> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
>> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
>>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>>  
>>  	/* 2) batch handling */
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index a91b2322a0cd..aec584812574 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>  	struct rcu_node *rnp;
>>  	union rcu_special special;
>>  
>> +	rdp = this_cpu_ptr(&rcu_data);
>> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
>> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
>> +
>>  	/*
>>  	 * If RCU core is waiting for this CPU to exit its critical section,
>>  	 * report the fact that it has exited.  Because irqs are disabled,
>>  	 * t->rcu_read_unlock_special cannot change.
>>  	 */
>>  	special = t->rcu_read_unlock_special;
>> -	rdp = this_cpu_ptr(&rcu_data);
>>  	if (!special.s && !rdp->cpu_no_qs.b.exp) {
>>  		local_irq_restore(flags);
>>  		return;
>> @@ -629,7 +632,18 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  
>>  	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>>  	local_irq_save(flags);
>> -	rdp->defer_qs_iw_pending = false;
>> +
>> +	/*
>> +	 * Requeue the IRQ work on next unlock in following situation:
> 

Sure.

> s/in/to avoid/
> 
>> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>> +	 * 2. CPU enters new rcu_read_lock()
>> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
>> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>> +	 * 5. Deferred QS reporting does not happen.
>> +	 */
>> +	if (rcu_preempt_depth() > 0)
>> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> 
> Why WRITE_ONCE() ? Also this lacks the explanation telling why it's not
> unconditionally setting back to DEFER_QS_IDLE (ie: just a few words about that
> irq_work() recursion thing), because I'm sure my short memory will suggest to
> make it unconditional for simplification within two years (being optimistic) :-)

The previous code was unconditionally setting it back so we would recurse before
the deferred QS report happened. I can add more comments about that. But
unfortunately, there is some hang that Neeraj and Paul are reporting so I'll go
work on that first.

thanks for the review,

 - Joel



