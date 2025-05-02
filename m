Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAE185955;
	Fri,  2 May 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198529; cv=fail; b=cSIeQ47QyWpvrtdWSVYVTSPXkdAKakE1ZmTuBIcd++FJ2lBmZa8Y/91Xd8D5fnvvbuOhsVm+qafeyHALFO5RjYU63gfv8De1juy8/vJFND33rgIMvAB1tC32JTWdNRpxSUPW4eEyiiSPbVmwLul39U9ffTslT875bPircbMMCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198529; c=relaxed/simple;
	bh=M0U7eWl1Kto32JYvdS6A/rDiDX0QGUv3o6VmxVwIO10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mbkql1RMd8PAfCVJbfbvWL7Lt2OyJtM6NxB7jIdSZ/V/w5Uf+nogK92V0vZuRWA91XXQtM4F+q/zREDzSremPMQkQh2WKEIeBcUks7Ck9pXqo+b1nsSbg6UoB8qHpkNSvR8NkXsyu1cMMsLhBD2rMCcx4PXsMXb+CvEuzSCpfN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sXs0luHt; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sXs0luHt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGSIc/ZAomvtrVm0MRL9Va3Q6QpvNCTB8BntK1ISzOD+dBQ5/tnB8iPvIDwowSoDTj554f3Fef13PgeduRq5qDIe9TwubK0c7tAh6wvFKkZDaO/9cBeMtlHBOuf8qrhdRoeJPGC0tH7WrMB/ptJVizP5BviaVDyiRsRd+mwD1Zn8OT/h/GKWA/JLYrsaKmM5o1CF1/WUhJRjbfIa5rAi8UdWJeZ3NzD8zzqLVlF6bGE08F+Fu6S6SVTs4kILFGZ8/LuB29AZ5x35O+C+/U0HweoR9CygUUM4LP1uQlqx4qWtPUCfUgKYIfMHQixNhIP8nDnPCEIqC5EPrPjMGVLHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0bk+kqS/nBCIVrEhDlf0UiSpilYS7qhuLdnUIaQSvw=;
 b=giGYAGeRSnmvFh3HoDDQC8ah3buzEJB35Nm+09PQmjpeVfySrmEylKQKQq1O++heLiz5ikmsruxrZTGHBKzhO/4vqYZLUphZEqLEJDkDThVY5mkXMUM8ANtIaEz/rCpHytMylsU0jZTXxBFSCxbQBL0cITGTZQOV/Xotxk7WJ3UL23FeLGtmLUc/k7ULCVVmucXQ6Edcy5RgqSWpy0+Zf5bATKTrLlOrueEBrxdG9fP5BaHARgzies4iFqy3gBKcXga7M8hhHLYj/ShRS4pVPNVwVBKbm4VGPALolyLGUebbjITkyBdKwngAFIjcHS/fjtIqh5jtu/05ODILIbX1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0bk+kqS/nBCIVrEhDlf0UiSpilYS7qhuLdnUIaQSvw=;
 b=sXs0luHt/TFKLMIkMBf4+/0DkrGvifH1uITEwPO3v0X6UljgLzIBFv/SrmVzzQwBSFbBsqIOjPNzIqgQQDZjcKK8kqKmbC/BjOilrO/vX7AYWX8SdqWdtmUScOgxAeSX4dV0EAQtGzz6MHdeI9MhF5WUHnfLEODR8If/FG5fcBgzME6cp77qkqpporJ5MBb6fdQFMGnQ2W4+DTlYb/BATZ49Mh7oMKoF3lp30cFAUAaOQ/jjCEkBThQkuNdH4cbVrJeo8lSihTITXtw8DIdk15K/9dRM/mLBKBTFTZHM3Yxus89hT6Gjb/Q2/NoRWL+xnx/VUjyPk90uA9VN+ud35g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 15:08:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 15:08:42 +0000
Message-ID: <b3915d4d-c6ba-4f4f-9b82-c5d2dbbb53fb@nvidia.com>
Date: Fri, 2 May 2025 11:08:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] rcu/exp: Warn on CPU lagging for too long within
 hotplug IPI's blindspot
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Paul E McKenney <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
References: <20250429134304.3824863-1-frederic@kernel.org>
 <20250429134304.3824863-6-frederic@kernel.org>
 <8609B469-5CB0-4EBC-94D3-FE3F90697ABC@nvidia.com>
 <aBPsWkw0juAXDVU8@pavilion.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aBPsWkw0juAXDVU8@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a48ebc3-d37a-4e6f-6b60-08dd898b39da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFBDQWNvVk8rby83czdHRFFhaVZxcld6R3RkQklmRWZkZmtyWWxHT3BkQS9D?=
 =?utf-8?B?V0VlMDRidTlOcjNFN21SRmdXSDROK3FQS2lTMWRtNThRWjhoMlBvMm1YVzdn?=
 =?utf-8?B?WXIzcmwwRFowbE5wVi83Q0ZlU3VxMjdhTlQrM3VDNko5dUZxRHkyNXEwVUcw?=
 =?utf-8?B?czM2S2lyVG4wWWFuYUlZOUl2d1pzZkxoMEV1YnNCamdGUnVDcDI4V0xPa2N5?=
 =?utf-8?B?QnBwNnpPQ29SU3ZqZmEwTFMrVTNubTNvOWxmTmNwdHRoWnhaSFQxK09Jc1Rq?=
 =?utf-8?B?ZlVoditmMUNHdndxdkV2K3BPSUdtWUE5elpObEhsZlh6ZUV6Ty85cWFFZW1N?=
 =?utf-8?B?V1ozVHI5Nzd1K291NHhya2hyajRSM3dMaFRUcnlxN0RMRjhscmdGSThVOWFo?=
 =?utf-8?B?a1lEbVB1QUVxa3VaUUlzU1owRGxkeWNzSWo3Z1AraVdUT2VxbTRWRldlSTcv?=
 =?utf-8?B?a0U0SVVVZWxmRW91RkNvSnBUamlUZ1pyYWx5RVYzTVVMMUk5a3k2WTF2NmZs?=
 =?utf-8?B?dHR0bHJXeU53T0l5VHAvZktiZDhmVnR2bWVKVS93VXVaUno3cE5TVjZySjZG?=
 =?utf-8?B?a3ROUzU2TC9zWitFckJDRDVrYU5BTElvOEtpQndmNWgyY1NMdDVDVUNkNjdN?=
 =?utf-8?B?UFZiZ1JhLzdTUjZCL2hvTno2ZzBuNHhkM3hGWU45M3czNjZ6YUNaZm1UeGln?=
 =?utf-8?B?eWxiZDZGL1JVdHZiSTAyTklhVzZNRTdIOHo0Y2duY1EwMnlPZFh0UDhkQnN6?=
 =?utf-8?B?cHAxd0lMcXQ4WGNjdDVRakJKZ1NRSnQvZWFiQW9lZkRoV3BpbDdFWlNsWWh4?=
 =?utf-8?B?VWI0YlVCcy9ETCtTblA0SmFHZWxockRoY21CS1g2aGJROVNtNzFpaWZ1M0lM?=
 =?utf-8?B?ZmxxOXhyVGtzaW5VbHBsRWJ0NmJEOTFKMHU5bXlDMzdMZGJzaWU5RHJkL2hV?=
 =?utf-8?B?TlJWaHZubDdJZTgwaWlRc0ZRUDZLUmFnNUtrbGEvZHVzZ0tIdDcvRzgxcXlh?=
 =?utf-8?B?L3c1OU0zN3o1dXdDT2cvb201Wms3RVVrYzV0WDJ2eU1XYloybGNQVWFEUlZy?=
 =?utf-8?B?dWpDV0VLb3VKMHFGZDRia2lIYTh3UURkdFVzSVZBM1BmTFV4QnRYZWpjSHJ3?=
 =?utf-8?B?V2pDVDdSWjQ0OHQwM2xZdEhzbWlKbUQwM3prd2dKZW42YmRXVjJUMm5sVDZ5?=
 =?utf-8?B?aE15R29hOFZMeVAzempja0dkZ2I2VmZkTUNtYnZobGJ5bG5UZ0h1SGlPeUpN?=
 =?utf-8?B?QjAvNFdFdXdzTlpkb3ZCNU9EdXUvQVdyWXVzZTltVmJIeFgwZ3lkZU1rSXVx?=
 =?utf-8?B?dEc5S1RiUmdhbUw2clFJM2ZVL2JvRklzQ1lTVEhQV2hrSnJjT3BUWjFDREtO?=
 =?utf-8?B?NStRcHRaeEJ2cmtWUVpIQnZMUkdLZC8yZ040V21Md1ZKU1dzWjByQUdOSkRh?=
 =?utf-8?B?UlFpNDBLc1BrS2VmSE1xUUVkTXQ5T0oxKzdQWjZQc29SaHVtbnA4SHQ3Y1c1?=
 =?utf-8?B?S0swUzhKblhHMmpVb2tuSFNOelU3blRDMUo3ZVpjZTdWUlN2Z2dHd0x5Vnp6?=
 =?utf-8?B?Wk9teVRHU25XYlVSeldELzRtRkUrUHN0UVEvY1VlNW1tSnRoY1lzS3FsWFZN?=
 =?utf-8?B?YXZKZEN0OGhMaGRoNDRzSEtZaHRtYXl6Y29TL1BOYVdPZVRSbTdIaUJUMDRq?=
 =?utf-8?B?c1A1eXczS1VNcWVrT1RGNnNxSXRIem4zc3R6TkU4VUtnVTZNV2IvOXAwdjRu?=
 =?utf-8?B?by9TM1dVNCticHQyOU1wcHRNMkpDTFBIZFZlYnFhdUhzR1FocDlXVXhSZEhF?=
 =?utf-8?B?R29zek9lRHJDSDA4UWhYL0hoNlBRRnAweitNUUlETEhiOTVXT0czNEFHYmpQ?=
 =?utf-8?B?WDQ1UHI1UkhzRFpQdllBYXhVNXRWa0xlZldhN3FWenNmSmFjTjY2T3FpbzJm?=
 =?utf-8?Q?5utMlkYlkRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2tVZVR6ZHAyUUk0cDlMTW1EMUExOGN4SnpjcTI0UlZCS0M3b3M5MW5Cd3hw?=
 =?utf-8?B?UFB5dGhUWStzbWlNaEFCK3JRQmYvMU5hdVRQS2xzbDFpamE2K2xhMzBPWWxu?=
 =?utf-8?B?K2hqQ3pBUG1CV2xOL3pNcWpuWkxENlFNNXN0VmhubXcyaTUyemhxMUdXdXUv?=
 =?utf-8?B?U3hVOEcxa2NmRnVxQVkyVHVOSXFPYVZERzB4VVFvamtwVDVjMkRWWXpvaEVo?=
 =?utf-8?B?R2tDM2taUFhSTDNxbEsvZVFkbW9maWdSZjBhTUxMQk5BTitYNHhraGRsbGUx?=
 =?utf-8?B?S0l5MWF2RDlwOHVxQ0VIWHN4S3ZJMTlwS2lNdCtsZmRlWWVXbjNSQTlTTCtw?=
 =?utf-8?B?OHcvODk2cTI4cGJFdjluc2lZd0JDVm5VdytNTTc1L084VWJrSDFWSGhTdmNk?=
 =?utf-8?B?WU1kK1d3cXpmM25hRTBHR2Fvb0dOa21VQUY3YlJZOWVoYU9IYVFVVERtc3Y5?=
 =?utf-8?B?V1lLVG9QMWFtL0hLNFhkNytDV0FWNDZmV2RZQTVrTUloTUFCcHJIMXZXdFhT?=
 =?utf-8?B?V3lNVGRucEVGbU1hWmxKL0czOWZnazVTZ1FuYkE1KzE5UlRQMWhta1ViY0dw?=
 =?utf-8?B?dGdTclBDVE12Y0RGdVB2N2RoSEtPNnNaS0pmbHBodkhPUUdTd0Q5T2dwZmFs?=
 =?utf-8?B?L3JvRUpCckhURkVkOHVJVXBiNnlLZWVVTUtRcWtGc3pjcXIvYXRzQ0pFazYy?=
 =?utf-8?B?MU1FdVR6YWVsOExES3J4U0N5Y2pyRDZWTS9hM2xzcjB2TkIxRFhrcFpWdXln?=
 =?utf-8?B?UCs2Um1iNlltNHNWUnJQRGg2dFY0U1lHeXVoYnA1U1J6U2x3ZVo0aFdrZHlL?=
 =?utf-8?B?TDNGVk0vcGd2c2NVZkFBbGtDSGFhd3lCVTBremRDZlRRM3NGU0Jaelg5WWFQ?=
 =?utf-8?B?R1Q5OTNlcStGSzZmSlZtdkl2WU5FQ1ROckp4MERNT2UvU2VSREN5MjFtVHFq?=
 =?utf-8?B?cmdSMkVrNnFpcnh2YWlWR093cDlOZURIclBqWk82eFFmQ3oycy9HdUJLY1gw?=
 =?utf-8?B?elhDRkx2OU1aRnovZFhocnNxdEJVUkFuSDlSSm9tcG9ib2V3aE9BMDJ3SnI4?=
 =?utf-8?B?YW5FYjVkVzFjeFdzdEpkMTlwQTQ2YkVyc05nWHlUc2RVenJDVkNIajNMQk5k?=
 =?utf-8?B?cHc0eXlobGJHOFkranFlcUQrMy9rTDJnSWpLd3pyU0tZaDV0U2lSbkZpa3F0?=
 =?utf-8?B?bGEzTE1sbGZEMmNEdG5xdHhjbVVWN1d4MGJpMEpNZTh6UEN4ajlWWnZPYU9J?=
 =?utf-8?B?YWxuVFpTQitwTFF1UEFOT2lPK3VkNUREUTZRNmlTenNnT241SS9xcGNmWUdZ?=
 =?utf-8?B?NkxGazh5YjVMRmp2TlRZc0FuZVhkcDNhQkVZWkNTVWVzYmtSSE9NdGhVd2FW?=
 =?utf-8?B?TWJUMFFGTncxRWc4a2xvU041LzRsYklCTjUyOU4yRFp6Y0hZdUNubEpyN2pF?=
 =?utf-8?B?RFBaeGl0cFR5ZnV2SEtycXpXRExvdGw1U1dWTXhub21WQjhmR3dvTUx6dzlk?=
 =?utf-8?B?NGp2SmJYdnlSSXBXUmkzaXBIeFZyR1IxMXNHZ1FyaUY0VEhFL25sbDJKWEZP?=
 =?utf-8?B?bEFrb0FQZlVEeEZPdFowWEsyR1BtaE1RUVdtTlk5ZWxFdFdQOUs5NEhTUEM0?=
 =?utf-8?B?UFArdTVDQWJ1ZTFMOUk1N2NGQmUwcWIvOEJQVUtvQVFwSHNwUS85eEF1c0h5?=
 =?utf-8?B?NHhENG1tNzgwN0xHaUZvOGM5RE96c3Z0OFZOVHQwMnlsWm5kbTRRcjA4Mmp2?=
 =?utf-8?B?M29JUkxWSTN4N2hYZTZ0c0ZDb2NFQWxLOHphdE5MOXRWNGFaTGdzSzV3U3l4?=
 =?utf-8?B?NzNIUlphN0pDK2M2Y1ZOSlA5cVkzN3NWTldIY0YrenVPMDF1VTJtRkY2MnUy?=
 =?utf-8?B?U2ZQOElqRE1TQzg4T1dTUFNjVk5PdW9UVGVoaEdtVGczV1dkR29FdXF4SUxW?=
 =?utf-8?B?emRocCtEdWh3NFQ0dGMvWENaNjN0RHg1cGwrTXRrZGN0MklKU0gxK1Nod2pM?=
 =?utf-8?B?R2lrdG4wZmhtcjV0aEpUcy9weEVxbkVkSnN0R09vblJlQ1p0b0FBL3o0OHJl?=
 =?utf-8?B?SU9QMEhhcklvc1FIMmt6eGVKRVRuU25kVm1SWnluVXdMUFpSMUxoZTlVV1pR?=
 =?utf-8?Q?7ZguUsFELWP6tXc1ElS5K+Yv3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a48ebc3-d37a-4e6f-6b60-08dd898b39da
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:08:42.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ewx5Qnza7X1g/K4C3WdktJBWZ9KbQUQDGeV7b71OF9HXMleJQChj9cjURpR62deQKl/sAmkJkWfO3vS5TjfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506



On 5/1/2025 5:49 PM, Frederic Weisbecker wrote:
> Le Wed, Apr 30, 2025 at 02:20:31AM +0000, Joel Fernandes a écrit :
>>
>>
>>> On Apr 29, 2025, at 9:44 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
>>
>> Hi Frederic,
>> These all look good to me. Do you wish for
>> these to go into the upcoming merge window or
>> can I push them to a for-Neeraj branch as he
>> is doing the merge window after the next?
> 
> Your call :-)
> 
> If that can help, there is nothing urgent in there.
> 
> Thanks.
> 

Since its not urgent, I will put these in a new branch for Neeraj :-). Worst
case we get even more eyes on it ;-)

thanks,

 - Joel
