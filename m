Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6E2862B7
	for <rcu@vger.kernel.org>; Tue, 18 Feb 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919034; cv=fail; b=aoyheKwftBzCbX8d29F2bUV3WIgxQ4ZPvL5dKQwUoKkya6+DWMs4ucIgqeyxZV2lNS8/M6p6MNwh0MUlUyGDqWui/78T+gaCw8AaJqdoQHrmRkLCUBur6743q/3/uRTZT4pgbTMj74MOxWH2whoR3244sjOk1IAxs0/ja/7u/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919034; c=relaxed/simple;
	bh=Mgr3ID61/RY4q6W9cTDHWUVm98/oTlqxd9SujDRAsG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTug91iAKMqWkcRyDuxLe+Prx/rCc3X/Ce+BYhPqkMSJ4CaPzDh6hTv1OHsOg9hHuVishh7mu3ySLGu9lsQ4C/m8U2gH4AvcN41bu7lEodu0fU9gU5AnfqoRBfvWOAMTgWz32HQEBWbKdrDRU/CeKr8b60dnmCDkSRQNqv58oEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fT/Tjw18; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fT/Tjw18"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVMAqwIbRzdk5JVSaipRbPZiH3Zf5fAWP/PD4APKFjDpdOe3AchUwQ1qP3gA7LY9eqVdwCInZllUp8MttDoQVtHwYr2mceNgJqGP5u+1qZ2PpEkxy/ATDFpk/O9V80qm9Azijpzvn2WkGFP/N5mArOBgLduZtnmSGFEVCiMZmTOOkPc5+YrlWo9cALXBBlz6hGKhTn4PcOjqUMAX4FOStdEihGRo7fSPziFtPkJ2Dfdi85z0bdZHPCxHwjsJx90uywTEdZY/3PXHlYQk1jHhWlfQgn/Dwa4/HN52iZ683Ddl1qwccJhsPzQPX1YVpSDrIWSTY+flb8Mr3p5G/Yapew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhN+T3gViygimvhoipDL2UF4Ythxa3IQ+cKBd9VVK3Y=;
 b=gIolrwOBW6WZMg8kKOAqpkxWY6yQBayoj80K9c6ATQWUx7HTPT06eM9e2n2RuBw0SfvEhQgZ4QXfNpap8PotrbOdDri4OOhZpmPkWJAcNFNL8sVbAIIo9KTG3wTEFAUQszzFLh61p75wYP1fcmSpb+PxHt2nX9HOtXvYHAsYq37aDCavn0Y6jXw2QTAKNs4yDtUHNij6BdAnMlwSPJ+2MixM4s7oCi0iRclMEDqVWkAjy2dlPJRUSMlhwXaC71qWhu7ChkQyYTFrPIWZ7GMGPDNXfYbjvoZPFiKm2gNbZWGvaRRbfRNAWMdqNgNgK1yKQMSDqUo18Qu/Q8fO3C1VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhN+T3gViygimvhoipDL2UF4Ythxa3IQ+cKBd9VVK3Y=;
 b=fT/Tjw184byYGzgUxmUgy00fPM9qoyT217d94BrNV+/Rv8zxaS/Tuviii0hvJmjDBne/GMMRjIrCmLOY9urAEDiZiakOU9C84M/xR/F/4hXTV6XTCU6CNQ3G/m/cu5OYJcbkcUyjCd1ottCEuwDBKkYyM27U5mRCcgxi7qRMPVFOBzO5XTfcudtlsHE9QeKxu9wfS3bZvR/y0Pf2/ludTgzsb7XWoiM74/50gZjqGgE6FKsAEmEfDnvpT5boEkjkxqcU9E33AWTgv62KB41a6wCn/XqDwwc0wwfcKZO/8H/84txO8wLwHcXnIUqWkDVvvfSvpdAo+VtXAnekrm8h0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 22:50:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 22:50:29 +0000
Message-ID: <04e2c857-d66c-4ab6-8db8-33dd88160910@nvidia.com>
Date: Tue, 18 Feb 2025 17:50:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: The rdp->gpwrap behavior
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
 <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
 <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>
 <b613df84-a176-4333-8c7b-2f3a75c7fdaa@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <b613df84-a176-4333-8c7b-2f3a75c7fdaa@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bd3dda-6d59-4ed2-5ba5-08dd506ea4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNKSEl3eG1oY1phcHBsaXNhR29HTTg3M3Jmc01abXFTV0lTSHJQaXc4aVRq?=
 =?utf-8?B?bS9DNFRheDJsWnlKRVRQaVVGWkFiWHFrZ0xuTzZBWnV4MEVsb2dubW9VRGNr?=
 =?utf-8?B?eE40cy9SVTV6dWRYdk14cEtSZXRaQU5tODJUQ3VYS3ovYW81UW9GNW1Vc1ZC?=
 =?utf-8?B?MmkvcmRxZVJtTUhUTjRiNWswU2VoTUZ6eEl4RS9yWjQzRXNzb2lDa3VmQVN0?=
 =?utf-8?B?Y3I5RUlaSGQvNmVkSTR6bEo0azQyWjcrY0ZKQUJSSWRpL1FYSC9qbDdNMmdZ?=
 =?utf-8?B?dHhqUW1aQm95QmJUNTlYYUZMcktNQ0pkZ0dWTUZUNWI3L1VQVGpCNGV3Slkz?=
 =?utf-8?B?Y2wvaytSVk9mVktPL3lTSDJQQlFrakpMNlNreXNSVU5yNngzK3JUdHZISENw?=
 =?utf-8?B?VmttRlVvbWM3Y2tObUMydThQblhiWTdUUUF5RVBzN3pJeVFzWGo3Slg0Unly?=
 =?utf-8?B?TmlLZ0dmazhTVS9EWHNzdkZhalp4Zno4MTBYQTJqVC9PZUhEYWVZL1JweXFP?=
 =?utf-8?B?Y3BZNlRvZkFrYzh0SjNKWGJMTnVWc2t4UWJvM25SeDBSUEViaDVhTG9UZEMy?=
 =?utf-8?B?RUZmbXJTTmZMbGVtYng3WGlkVkNSUFY0aHppU2xFUWVONVFQWVRPcFAzMSt6?=
 =?utf-8?B?R21uK0ZZRTdWbTY1TnFpVVRUWWZYRm1IN05wNFdrUVJyRkd5YTVkcU1EK2E5?=
 =?utf-8?B?d09YQ0R2SHdOWTBoTXcxVEVBaWl0SWVDZm9uNWQvaXVTWWhkRUdxa0lSc1NS?=
 =?utf-8?B?d1lzQzNrZnlxaWlEd3BjY1lwOS92dkNsblJCRWNGNkF4TVZCZExlZHc4eWFh?=
 =?utf-8?B?WHNxR3B5NlhpSlYvUGRkdUZCRjRmcG55VzBqK3FJZGR6SnB1R3lxRlZNWXp2?=
 =?utf-8?B?MEZDemhYYTVIaTJDMTRSMkN1cktXR0RMM1ZUNk5PK3JhUVJKL0E2N0RsVGJQ?=
 =?utf-8?B?N2E1N0NmVjB0WEY4WnhySlo4RGU1TGxVVlpHSEpqY2RPNnVQNnE5cVp3c1RI?=
 =?utf-8?B?WkJZSlpld0k4Uk9ETW1kK2U4ZXEvVk0xak13eGRHK0M3T1lTOGRpUDVzUkZx?=
 =?utf-8?B?aXRodTdMZFVmeFR6cmx6dTJLaWQyN1dULytOMFNIWGpJZ1pNelRmUERqOUg5?=
 =?utf-8?B?SmdLVTdTVlAvWnFERzdXU282UlcvcEJCUE5Dbk5ROC9Pd2pqengvVFk3Q3po?=
 =?utf-8?B?a2o4Q1RsMnRRRXhpaVoyQXEydVVmSTlyZ1lsdEpmcDBWZmNFUHZSYTdkVDFS?=
 =?utf-8?B?eUZVaDFMZGpzc1UzOTFTVEJQSFMxYzNFOE50OUZFeXJ1TzhkSlhXTlZJM1ZI?=
 =?utf-8?B?NCt2a1dJREIyZkQrZklHdzVjcWU5UXNHMEJTR2U2MlBlcHQ4M0ZUNVNoSThG?=
 =?utf-8?B?N0hlUUIwbWdtaUx3VnVxcFpGRVlKdVJuZitHTUI3QURlM2d5UE5Ha21TaUo4?=
 =?utf-8?B?aWdqVkRiOUlXRUFBc3NnZ0l5ajJxNmZ3akJydDRvanRqMVQ0WExYMUpLb1Bx?=
 =?utf-8?B?WmRRT0NCdEJkakZTQURNUlZlS0tVVGl5YnczK0xJTzlXMmp4VHpMa1ZjMnI4?=
 =?utf-8?B?OG05UjJhenRzc1djSi9xQWpiM05maDZiWGowNXhtS0M3L3N5ejhFZFBFOFQv?=
 =?utf-8?B?Tm5Mb3pPZ1ZneERONnovdHFwMXU1Ui9OMW1VZkYrYk1DT1JXbUFVMGR0MDRV?=
 =?utf-8?B?OUF1bW02dEtjbHhFNmMvcm4wUndnTWxkanNoYSsvWm4yaXR0SjQ2NU03TmRL?=
 =?utf-8?B?VkdnTjQwZ2F6QklEd1Rvd2loN0J1N0J4U0lPc0VqYnRNYXRkZStadVdPUldL?=
 =?utf-8?B?UmFlN1d5VU52ZW9IM0M5Tkp1RVhNQjB2NWhIc2E5SHRwTlIxMU53VEppNHBP?=
 =?utf-8?Q?IfIvjj/FWRlAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REJkSjkwVFNtZE5mMGJVdVNjb2JLTWMwdm42VTNrcnhpUmVhZDhzSGZDSkEx?=
 =?utf-8?B?WXQxTHJHT014dThrMGlHUWc4LzdkSnZpdnRGVVV3M1NmZmZUdGVLRTU1c09H?=
 =?utf-8?B?amY5L3FvaEZ4ZFB0ZDJEWHVyQmo0YlhsN25JUHMzdXROREU3b1VQTjhCdFo0?=
 =?utf-8?B?SngybVQ2Vk9QdEUra0pjSUIzRjRwWjhHMVQ4Tnd4T25nb2M3eDI5Ly95MHlw?=
 =?utf-8?B?bUVaZ0VPd1RxK2NQV0Z0VGZManViZkRUV1l3c3VaZm5DY1lLbWVmSGhMNFJ0?=
 =?utf-8?B?dDZheDJ0MU5HRks0UlU0NzBlWGhDMkppR3lMbmt0SWhwQ0xlc1hIZ1VmTkpX?=
 =?utf-8?B?TGE0bjNzRVl6cHVhVzNMK2NmcG42UTArNXRtOTZNL3JNMXRVZGZENytFdm9L?=
 =?utf-8?B?cGF4NzBHbFFGL08wMTJVcmNYT29SK0p4N1MyZkU1b2hOVmdRdW9aUlBsSEpZ?=
 =?utf-8?B?THh0YnVWdXNLbGcxSmlKZkNiQm9zY0wyNGhySEorc0toU1o1T291NlptQzIv?=
 =?utf-8?B?MklsNW14Tkw1VzZac29CcCtBZEVzUC9LQW9LYk9nUHFteHI1TFZlemNwV2xt?=
 =?utf-8?B?WmMrRE56MjZ0aEI1RVlETFNTb1ozc05XcmVic2I3SENXMWFDcnVaRjFPdlpl?=
 =?utf-8?B?MkFhQ3FxVU1rVDRkOHkrS3Q3aEFOdDJ3cHNqaUYrdEdHQnhPUW82M3VlM2E4?=
 =?utf-8?B?cTVqbmpsZGtCa0pIT09EZDQ5d0pFUGcvN3dXYjY4Z1YzWi94b3FhbFlNdEpq?=
 =?utf-8?B?MVhhS3Mza2orQ2hWb1ZZRloxdlp3OXp5Q25XVkxjR1VBa2VTa0EzaHQvc0pN?=
 =?utf-8?B?d2JCMzZJVi9TRkRzQTdUb3JEOVkzVmtQd0FDWW5WdXpZY3JFUGZLOC9jRnZG?=
 =?utf-8?B?TzFIU0piZzcwRC9NelplT1VIY2E4eVBGOHNXZ1R6dUt5OUd6OG41Y1g5Sm5u?=
 =?utf-8?B?cXhZTFJ2YWNaNXU0SmNVakg4WkRMd1ByVmdpRHF3OTNsY245T3Z6WnVvTngz?=
 =?utf-8?B?am5ldXM1dGtCb044eENXR2p0WVpPbitEdFVFZFZtVEQrUHE4QWNqK0FYbzRP?=
 =?utf-8?B?WmNIenpJMzZvVlpTZHhMZ0ZwRFhaQzlvTnNJUG9TaUo2RlFmblByV3VlY0k1?=
 =?utf-8?B?YjdEQlJHTUE1NHhEOU1nODBXR3c4RGh1NTNNTXBlSTMwZ2c4b0RycXlqMVgy?=
 =?utf-8?B?R01CT2ZRU2lnUUlPcWQ5Nm93eVhHWlVMeUd3YTFRTzVDK1NmeThLYmpic1A2?=
 =?utf-8?B?STBGd08rVGRaMlEvVnlJL2VCeVd0dnNjTkVCaDl6aU94bHJBQkcrWVpaV2Vs?=
 =?utf-8?B?RG9xOHhMK3R4SlV4d3N4Q3hSK2JyWmFoNnVNMXNsbFZOZzl0SFZvajZLeWpl?=
 =?utf-8?B?c293Tlplb29SSms1TUNDdHFGVHF6S0hVQ01qd3hGeVAxM0JjNTQwaGI2czN2?=
 =?utf-8?B?ejJJQVZHdngvdEQrT3lvejRSaEgyRnhYa2xTTkQvMDl3aEZJUmlicjBtbzda?=
 =?utf-8?B?WDZqT3pBd05zTGVGVjlMc1ZRZktTU0Y0SXJvK2RZY0k0RW9taFhrOU1Jd2lK?=
 =?utf-8?B?K3dRTVBxTU9TUVNTbUR3Z21FZmlGYW9hWGYybWZISFJzNkM2akN6Z2RmMkhl?=
 =?utf-8?B?c09aSUIxRXlQTGM0emR0MGNMV25zSW1Gb092NFFVS0FaTWh1R3dleUU3RS9B?=
 =?utf-8?B?Uk91eDlUMzhkUEd0djRXR3dkQ3FhVDlRS1o3M0sxeVp4YWFFZjBFNXlsT2Nl?=
 =?utf-8?B?MWtyV1BOV0ZrNE54Tk1kTVRSN3dhb3FmVjYzdjhkN0ZGR2x6cE5mcllScFJS?=
 =?utf-8?B?aThJN1h4MmtZRHpDZ2g0WGh4NXhVekZUOEtIcEVEdlduU1dCODdhOFRhOHE3?=
 =?utf-8?B?Z1Z4eWYwR2ZNNkhKNnBBUzJVWmdzWC81ZXpZVHNNZjl3VURVUkhoN1lPc1FQ?=
 =?utf-8?B?NXdsdkpCQzF4RWpCR2NqWVc4UU5qcThFOFJTcC9lKzZocnJHeEdIbXhodU02?=
 =?utf-8?B?R1BrajM2NGU1RzlOd0x0Wi9OcjNMbjJwaXF4bVM1REl3cDgyZ0svY2dGbzU4?=
 =?utf-8?B?ZG1pNmhSNFFQM0Y4dUdya0pVQnF4WDkwK09SdUxkNEZxdFNZRlZFMDA5VUl0?=
 =?utf-8?Q?WtRu8ody8qFPlgiLB/aKyZd3f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd3dda-6d59-4ed2-5ba5-08dd506ea4a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 22:50:29.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCUwXp6JV2KW8kDPL+X+bR7FJJtmWx7moh3QlLC7W3C8FytiDpmAVF+eOe94xjL07P+r64/h9BmRv6d0B61IWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

Hi Paul,

On 2/18/2025 8:17 AM, Paul E. McKenney wrote:
> On Sun, Feb 16, 2025 at 07:23:48AM -0500, Joel Fernandes wrote:
>> On 2/15/2025 5:28 AM, Paul E. McKenney wrote:
>>> On Fri, Feb 14, 2025 at 01:03:40PM -0500, Joel Fernandes wrote:
>>>>>> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
>>>>>> with just boot testing.
>>>>>>
>>>>>> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
>>>>>> very close.
>>>>>>
>>>>>> Example trace:
>>>>>>
>>>>>> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
>>>>>>
>>>>>> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
>>>>>> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
>>>>>> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
>>>>>> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
>>>>>>
>>>>>> The wrap "before" and "after" are the value of gpwrap before and after
>>>>>> calling rcu_gpnum_ovf().
>>>>>>
>>>>>> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
>>>>>> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
>>>>>> and many GPs have passed. This can happen both with/without wrap. So imminent
>>>>>> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
>>>>>>
>>>>>> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
>>>>>> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.
>>>>>
>>>>> Exactly, and all of that is in fact the intended behavior.
>>>>
>>>> Ah I think I get it now, so the wrap isn't really about the counter wrapping
>>>> causing an issue, but about the design of the ULONG_CMP APIs which are designed
>>>> for comparisons that wrap around. Due to this design, there is a side effect
>>>> that the numbers being compared have to be at a distance that is less than half
>>>> the number wheel. Otherwise the comparisons of numbers yields incorrect results.
>>>> Is that accurate to say?  IOW, ->gpwrap == true means, don't compare the numbers
>>>> anymore till we sort these huge deltas out.
>>>
>>> But "incorrect" is such a harsh and judgmental word.  ;-)
>>>
>>> Somewhat more seriously, ULONG_CMP_{GE,LT}() are defined to return the
>>> sign (or its complement) of differences between a pair of 32-bit or 64-bit
>>> numbers, as sizeof(unsigned long) dictates.  This is, mathematically,
>>> how you do signed differences.  The result coming out negative isn't
>>> incorrect, but instead the expected result given the numbers in question.
>>>
>>> Current RCU use cases might interpret a negative result as "no one did
>>> it for us yet", as in rcu_barrier(), "this CPU has not completed the
>>> current grace period", as in __note_gp_changes(), and so on.
>>>
>>> Now, these can get a false-positive/-negative result.  In the case of
>>> rcu_barrier(), we get a needless rcu_barrier() computation.  In the case
>>> of __note_gp_changes(), the false negative is OK, but a false positive
>>> from wrapping all the way around, could be fatal for a CPU that was idle
>>> for a long time (hence ->gpwrap).  And so on.
>>
>> Understood and agreed! I guess what I was getting at was that ->gpwrap can be
>> true and false-negatives start getting reported well before a full wrap /
>> false-positive situation arises, I believe. And a false-negative may not be
>> desirable in all scenarios. In my other patch, I posted a scenario where I was
>> concerned about missed wakeups on a false-negative situation.
>>
>> In srcutree.c
>> 		swait_event_interruptible_exclusive(
>> 			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
>> 			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
>> 			!READ_ONCE(my_rdp->nocb_gp_sleep));
>>
>> But I shamelessly admit I don't understand this code well enough to say if this
>> is an issue :/.
> 
> This looks like RCU NOCB code rather than SRCU code?  Could you please
> tell me what function this code lives in?  The closest match I see is
> in nocb_gp_wait()?

Oops, sorry I was looking at too many things.

Yes, it is in nocb_gp_wait(). I meant the rcu_seq_done() in that snippet in
'tree_nocb.h'.

>>>>>> >From a testing POV, the example shows it is not set even when around when a
>>>>>> wrap actually happened.  So may be, we are not testing gpwrap much, or at
>>>>>> all, with rcutorture?
>>>>>
>>>>> True enough, and that would be well worth fixing.
>>>>>
>>>>> One simple (and maybe too simple) fix is to add a Kconfig option to
>>>>> kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
>>>>> (32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
>>>>> rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
>>>>> within a few minutes.
>>
>> Since minutes was too long for me :-D, I am trying just a count of 4, and I do
>> see 15 total wraps in just 2 minutes, on 36 CPU system.
> 
> Very good, and thank you for taking this on!
> 
>> I am trying this same patch now for 10 minute run on all scenarios:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/next&id=984c47eeb7728829901b33462baae2771af80ea0
>> Will try longer runs after.
> 
> A good prototype!

Thanks, so far I could not produce any issue with doing this. Which could mean
that the code is robust to any wrap issues, but I guess no harm in testing it
for future-proofing?

> 
>> Are you interested in an rcutorture patch where we force this? Would this be a
>> default setting where we always run it, or do we want to set it only under
>> torture command line options? Do we default to say a high value like 32, but
>> still provide an option to lower it to say 4, like I am doing?
> 
> Something like this would be good, but only under options.  (In order to
> more easily debug something that only happens with hyperactive ->gpwrap
> setting.)  For example, defined with yet another "rcutree." module_param()
> that is also recorded in kernel-parameters.txt.  And printed out at boot,
> perhaps in the rcu_bootup_announce_oddness() function.
> 
> We need a default setting that causes it to happen (very roughly) every
> ten minutes on a given CPU, or perhaps better, every minute or so across

And that default is certainly not ULONG_MAX/2 but rather something that I
empirically calculate to cause a half-way wrap in 10 minutes?

> the system, by scaling the default by the number of CPUs.  After all,
> we want to test both the ->gpwrap path *and* the non-->gpwrap path.

Agreed. But do we want to test both these paths only under rcutorture testing or
were you considering we do it for regular operation as well? i.e. wrap in 10
minutes in regular operation. I am guessing you want it only for rcutorture
_and_ have a 10 minute default.

If that is the case, we would then need rcu_gpnum_ovf() to consult rcutorture,
if it is enabled, about what what the threshold is.


> Then that parameter's value would of course take the place of the
> hard-coded "4" in your new ULONG_CMP_LT() call in rcu_gpnum_ovf().
> 
> For example, the "pr_alert("%s%s total_gpwrap_count...);" works well
> for prototyping, but for production needs to take its place elsewhere,
> most likely later in that same series of pr_cont() invocations.
> 
> The get_gp_wrap_count() should sum up the per-CPU ->gpwrap_count fields,
> right?  Ah, but you are calling it from a per-CPU loop anyway, so either
> way should be fine.  But either way, get_gp_wrap_count() does need a
> header comment saying why.  Trust me, it won't necessarily be obvious
> five years from now.  ;-)
> 
> And that "atomic_inc(&rdp->gpwrap_count)" could be this_cpu_inc(), or
> even "WRITE_ONCE(..., ... + 1)", given that we are not worried about
> losing counts once in awhile.

Agreed to all these, I will make these changes.

> I *think* that it is OK to have the tree.[ch] and rcutorture.c portions
> in the same patch, but whoever is pushing this to mainline might well ask
> for it to be split if we happen to end up with merge conflicts.  Or maybe
> just get more practice handling merge conflicts, but it is their call.

Ok, will see how it looks and consider splitting.

Thanks!

 - Joel

