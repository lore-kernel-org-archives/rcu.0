Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A6EAC7;
	Sun,  6 Jul 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822020; cv=fail; b=qQHfv7278aoXbzknUIVunfkV4Ctxp4tByJi3/Wqtf6oY7pazHEsQtpr2Tu5Wfrn5XCXtHKeA7MOvk/9ESbDBfynnpxAs8DNgmqt1zpaJy8ZNy9TAaFIEbvW0QOoJXs9JPxwHPaX9HuMwFvO4ckb9jk9hnUc5VcbfQzTEKepcFws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822020; c=relaxed/simple;
	bh=eXEzjOkLCpuObGAs/dB5DQFHeAc6YKz0iJNqosjiQGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S/gHZPMWnQVFqVOIvfp+V5W7jdDGi88NyiwwE8/7cVNh1q+8IrV7GXzdSXAuJF2RTy0Cy3Egnl4inKdt73qHW/v05pU0ePitYOLQImnwew5yuuU18b3qdCHqTLJ4KodOW9eVNmcMFwwBQ1w+VzBK6zyglvTTD/dt7RWHNwOFlIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYJReDKd; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYJReDKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSTxAnYT9DemhV8HRElkyxH5Y7jh7SJDipU4cvYBqa8S4MdFrZStUXGMKNeMiksqfIyuwFuwH+a9bT3pHF2dKPUvNnMiSn1FRdj4pzSfS5Yq6upefVNbyBZkay9dsu3+CjEuSdCCGoIkhAtWEQlVoglkm6tHZzMLzP39kVuMhosWrjbppwSqzeRAclNmPR139psDPbWznHYHIyyl0ym6pyV8E1pE/42N0lNlxXPB+1sEtqcTR43sjse9dBRrUO1GlXPCGN3n+ZlXl+kBDay7DQmSAgZdC99q7MbbMU5bBELSUn8HD7xTtmSX6HnOD8rKB1dQRSmElazFMPB9wJzqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLJZxnCLZlbnS35HRTIo2PBAlaj3LmnaDh/v81n2c+s=;
 b=Wvpyd3atBV/DaKJgTsxxy4mKRKeI9Fe4tliMe5DX6snMiB0PlDml4gc1UIritg49n0iTObw5PPkfTkei7LFEnCZiEw0fdWQ2mDknJFDc6OAC3I8UnpFYcStagbkfShGLbJkmaSQB9VlBTTdNwjz1GIZGTbQCv6mvSjg5N36OqV8NgrVkzseyvr8H2gj1AL3w0StQbdcu1e9VsYPJDvon0ZWQLGxiLCsSSt5wbQfB/YESbHB1aVH5uMV+YIq7BKGtsZL3/KZGrCsl0jOFeXipTPMt1k/4QgG7F7FMcSglFmtGSG9EXVUlfWQVl+SKkbzAlOJT9iaasSZR8kceLFHfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJZxnCLZlbnS35HRTIo2PBAlaj3LmnaDh/v81n2c+s=;
 b=fYJReDKdppz2mjZ3C6wsWAvXhtD5xRMIzAAFjTZY+8mJORnU729tJlnh+t4jXoSNfZpX9guYN0FAVWZaSnRHsojJIc/oYtNUYsErUAVbRY4vDYa9dqLt74Nop9u/PiPdR0FojiIugvqJ9T0WIEJp6r5Qh/eLGz7p4AkgzO4TEGn79YWOiXerVIv731cRN8oeubl4Q3vjDV1xNYatxrtPnMiswadzJ9wRNVjm2lWiX93OqgyIIk7GkpotTNxh+PbY62XipZm1JTBDtL0rEpMR2i3cnMl9+MkdfHJ2uPgPwO29AtBkZLpkztwnCFLyHRmtWq2ZQraX7aeGkeqlp77lRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sun, 6 Jul
 2025 17:13:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 17:13:35 +0000
Message-ID: <40f98744-2289-4695-aa6a-4019913920d3@nvidia.com>
Date: Sun, 6 Jul 2025 13:13:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <960035c6-c5f3-4c31-bd0f-f57d79b040f4@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <960035c6-c5f3-4c31-bd0f-f57d79b040f4@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c024fde-afa7-4cd0-1415-08ddbcb070b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkNYM3pQTTlNSCt0QlEzdy9QalROeStZdUcwUG1VaWlITy9yK3FVUkZqWWp0?=
 =?utf-8?B?MWRzbnRMekJ2TmFCVEpaYjBHZVpSczhidG5tbGlkeUpuck5GUWdrbXNmTW44?=
 =?utf-8?B?bmEvemswUHQxa2lOVUpTQkhNQ0tIWTZLWGJrQ3Z1MHhyMkhiTXI4WkJkVm5v?=
 =?utf-8?B?dnNoZVpxNWIrNnpidWhvdjdlZXJsaHAzcWNnZ08xVVp0bHc2cGRJSXFmdHF4?=
 =?utf-8?B?dzhsZ2ttTkZGeVBOa015RFI4OC9EL2RwbFhGUDhsTisvbmdXb0FVcmZLVmhk?=
 =?utf-8?B?Y2N3RUJHZFd4Nk9vRDZLWmloOGhoVEcrV0lOUGNqN3U5U1ZpbzBFVUxxV2Fa?=
 =?utf-8?B?V3VicmpKa29PWEdLVWpybTFWdjVQc3Ryd1lFQ01uRnNhT0ZrOVZKQTdJUDlW?=
 =?utf-8?B?dUpBUzFOTTczVGNhMnJORUtza1BwcHp5Zzkzd3BUL3pwWGVPRnllYmMrU0J0?=
 =?utf-8?B?bFdTT1ErejUra2FPREVFS1BrVUwvR0g4clpnSEd1aTVPTEU1dnFQWHptNXNW?=
 =?utf-8?B?NVFEY3k2Wlg2YlF2NGFhZ3RpWkFXMktpRE5IQXlQT3RYSWszbEpPTC9PZ2lh?=
 =?utf-8?B?bndSRFhhaWhIc3pjREt6RlZhcG5FdlJQUXl6akdDbU5SWDZNZjhtYW9nd0lF?=
 =?utf-8?B?RGxjSUYrM3laZ1ZFZDBqYjQ3cWU4TURvMFhZdzNuRW5Edk5Rd3BmdGNkV0V4?=
 =?utf-8?B?cEMxWUk2MUM4bmZ2TnR4SERyMmxsd1JEN3BuelVvRDNWV3dPUDBsem5xZjY0?=
 =?utf-8?B?dndMT2greGVweXlTWUxTTmhiOGRmN1dldDkxNFV4eVY4K1BBM3pEY3oxUmtn?=
 =?utf-8?B?VExkQi93cHVuVHB3K3ovTjdSdU41VUxiZXRvUW9KUEYrZlpEeldCSmFuZlZ5?=
 =?utf-8?B?MHFscnYxL1JJa3B3MXJSeGYwMjcrMHBtZDJ3MHdXbitNMjBhY2tmUTloY1dx?=
 =?utf-8?B?ZW9NNU5vNFUzekw2Rm1JanVmRlJEb1Nvb1RpL0psZDFZSnE4YjU0cEc4RlNw?=
 =?utf-8?B?c3c1d3czV0lJZ05weFNIOXhjeEZPUC9FcG51dG5OK1NZajVOQWZGenRxRkV0?=
 =?utf-8?B?VjhaeUZaWWhNMi9Va2hYeCtFQ1lJakVjOXA1YlJEdFJTRDdlSDJzWmpFRGwr?=
 =?utf-8?B?T3o0WjlGSDNadXRKMDNaZlR2OGlMb0JaNlJHR2lPTkFGK3VzNndRRFYxK0F1?=
 =?utf-8?B?dHJxSGRyakV3VDI3WkZSdDg4T2NudWZXd1BHcVJzZCtLVHk0TzR4VzU2SGN1?=
 =?utf-8?B?eXNZUk82TDlwZGptcHdBT1kzUE5RTEcwMk1rcFBTNzRmelBvZTV1bHBNbWFV?=
 =?utf-8?B?YjFxb1crNjR4QXdhOXdkdkZaNmFqMHZLbmpZR0ZVQTZDVzg4cU9ld1hUNVZW?=
 =?utf-8?B?aHBub3VxUlJtNUZSUlhmK01tSTZtNkYvMlFPTDkrVk80Sk9uTWZmVWZDUjM4?=
 =?utf-8?B?TG9HZ2cvVTRJdHZ3c0tTUElKSEEyYXZ6RjIwMjNJVjNGdElhNDNRaG1QazBx?=
 =?utf-8?B?S2FhWUpEWEVpQ3JhUXJ4N0NwaHUwYXcxY2lHVVR0Zm1pc3JkT3U4QU1mVHVk?=
 =?utf-8?B?c3NoN2lGWVZING9DWHRFaGdvN1pMNVJlOW00ajg4S1BuZFg1U3FKT1MzL0dZ?=
 =?utf-8?B?dGVWdnhwd2JsQy9rOGZDRGg1RXVjYlFZbFNPdlFEN2M4V2haWlAvRFBPdzdC?=
 =?utf-8?B?dnVXSVRPUmpIY3JMc1N6K0FnZmRHbGVET25ORENsU0tJa0lIY2pINlZsWDB5?=
 =?utf-8?B?YXF4L1lkY1Rnb3UvYVFubk1BcEZYa1RiTWFRTXZMRjR0ZVNEM1hkejZJZFU3?=
 =?utf-8?B?bWtCUUViQUhqbWNHQzhvTXJHRlF3QUtPVjFqOHFYdHJ0Yzd3MklVNFRCbHZa?=
 =?utf-8?B?eEJmSlpXa2ZOWGZBSXQ2bzRGK0hZbVM2SXVoN1lLZjhzVVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEVqQmUyUFlRekhMY2tWeXM2UVNJSHZPTSsxc043Nmc3S0d3bnBOUTZFdFRN?=
 =?utf-8?B?aGtjUEhBNEtqbm9GakJtbUU4SzlHcFgwSVY3Y3RSeit1Q2FqQlZpbDFQVFcr?=
 =?utf-8?B?THE0N2VYNVY5Vm5kaGpUR3paOW1ZRzNxY0V5ZVRVQkdHWmtOZUdnWnM2b3Y0?=
 =?utf-8?B?MGFQTWJLak0yWFNtM1FDQ0ZzOUp3a1Y4K1RPd1VzVkh3WTk1YWFVV3hZNGxZ?=
 =?utf-8?B?bDBnTTcxSzZ5MXZIbmk1ZVcyVll1WU4zSmk4Z3dYcGhUWmhHNGtBSE9sdlhL?=
 =?utf-8?B?T3dGclp1M1JITTZtQXprRGtmeHFSQUhRdS8xSUVBOVplQk9PQ0ZvWjN4NWV0?=
 =?utf-8?B?Nm5KS0VnRVY1MmlDb05iajlyenJCUjZienpVaEswN0ZhNkRCeVlnNnRFdXV6?=
 =?utf-8?B?dWhodGQxZytlNWtSY2tPcFNISkhta0NNRFpqKytSTjRUYnM3cWFyLzdZQWo2?=
 =?utf-8?B?dGlrRVZDRFZOS3RuS25FeWpIaXZaMk16NlVNN3JxMEpQbTR0QTM0aHVZb2Jv?=
 =?utf-8?B?cTVlYUVnNG1iNVpGVlFabzVNeGhPT2NIc2E0Uk9nUVNxN1FoM0tLVE9RWjJD?=
 =?utf-8?B?UGpsNGdtRGg5UG1GNU9oRlozU2Z3VXdtTEQrei9EYUVMN0F3T1V2ZGtpTUhm?=
 =?utf-8?B?ZGxHYm1ObGhicTNTRFhIRnk0cWlTL3lqUVpVcnltYnd1U1RwVXlnQXo3MCt4?=
 =?utf-8?B?Y2tmb0xibXBWQ3BveVAzWE1WK3VZR3YvNUZjRHdLdng0ZWdJbzFoMGlHN0lO?=
 =?utf-8?B?TkY2bnBhUlBCem1TekpJTjF6VmVlbURNbkdNeERYd3RaQzhZaHdjb1QyVDRL?=
 =?utf-8?B?VGlFdm1iV1RiQ2NGMUdnUmhyNzNlVldsTlloTW5ITU9qdjlZcytkUEt4R2VM?=
 =?utf-8?B?Z1FKT3N4T0FMWnptUkdxcVZEOEd2SlppSnlPbmxCYXR5YXFRSGJKaElNSlor?=
 =?utf-8?B?eGdLUlZmK3Avc0s1cTVZRE01WHVEcWQ5Wi9wY28zNVdZSW5hdW9uQUNoMmZZ?=
 =?utf-8?B?STVxNDU1dWEzeWNZU1h4U2xjVFpwcnRLdlo1NndaM2N2eWNnamxERVVNVEVj?=
 =?utf-8?B?WHVocGZabGRNTW5za3BRdlZqeWM3RTFhdDBkQ2JLdlZ4cTZzK0FGaHY3K1hy?=
 =?utf-8?B?ajh2WjBFeE1lbTFRVmFTL1ZaOGhSM3ZYVHdVZStXeHd4MlFWMVhWclhhWnZZ?=
 =?utf-8?B?WXhSZE41THJtcmgzQmVTdUxnZUFuOHZ4UUY5aEdwSUhzbFBiaTMxRjZwcW5P?=
 =?utf-8?B?TVFYQk50cVppQzlZa1pwOXRPWVdDc0M5SGdOMERZenhzTGtob3p0T0ZuRUo1?=
 =?utf-8?B?SnBZZVoxb2hHbUJjWlZkdC9DcFcveURsamhXellPRWtheDNEOEFjclBpV2F4?=
 =?utf-8?B?d1g4eHc0bXRoN2xQejJhSnluNjlhbVJnbVh3K1FCWlU2ei9Nd251VTc4cita?=
 =?utf-8?B?Yllqckg3ZzZLOXJuNjVNZFFYNTJDeExVVjBVck5yNndhSTF5cExRa2VFVTl3?=
 =?utf-8?B?QWRKWEF4aFFwYjRrZHZxYnRNelk2WlZKbGFjY0JlVDRoVldtblRpTlcySkdm?=
 =?utf-8?B?ZXpvaTNaSU9PbEM3R0xuVFJaOTB0d3lnU1piSzFqcUJXazRZN1F3cmZoT2dF?=
 =?utf-8?B?aE1nZFoyZnNWVzNCSUNxMUw2MGJrdTVVT25aczJvN0k0c3Z6YTEwNEdXbElN?=
 =?utf-8?B?NWZYaC9DQ1Nvc1pLZm9acFREV0hoMGJHYVdraXJGTldmRFQ1eTFWeUdsbzVv?=
 =?utf-8?B?U3ZoeGJLaHhlSjhVa2lyU1VOdDVscGo3WFQzZnJnclJ6TXVpcWcyWmVTNWlj?=
 =?utf-8?B?RnVmM2FMRkdGMU1SSXhxeEIxYXdEOTdZaTl2TWkydjJJcUUvN0NIaW5UWEF0?=
 =?utf-8?B?V3ptc3NzQ05vQ0p6bWZ0SElWMGxONDc3RFkxOGdaWE52SHZZREQ4b0FhYUtr?=
 =?utf-8?B?b1JYTkMrQ0VMVmh6UGNleUhaM2VUbkFEWkp4TUJRdTRLUHJnZ0ptWDgxczJi?=
 =?utf-8?B?NGJNM2Rabi8vOG5kTUpKdDZXMDdSL1RjR1RCVnlKbFM2VUMyT2ZPcXNOdjMr?=
 =?utf-8?B?ejJnWEZMeEpSQ3NRUmhKR2pmaUdsbUdPSXNNeVIwNDdaWko4TXFBNzhEZUM4?=
 =?utf-8?Q?037Jcj0zk0p6WzH9WdYTikrnZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c024fde-afa7-4cd0-1415-08ddbcb070b4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 17:13:34.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vigj7Cclfb5aG49jGj2dX4KNGRAezTAzEEcAHgWdO20H7nb4bJVSAujs8uPkQMbWYp0Ie33i5U6syEx6tA/Gvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251



On 7/6/2025 1:08 PM, Paul E. McKenney wrote:
> On Sat, Jul 05, 2025 at 04:39:15PM -0400, Joel Fernandes wrote:
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Definitely headed in the right direction, though it does need just a
> little bit more detail in the commit log.  ;-)
> 
> Also a few comments and questions interspersed below.
> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree.h        | 11 ++++++++++-
>>  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>>  2 files changed, 32 insertions(+), 8 deletions(-)
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
>> + */
>> +#define DEFER_QS_IDLE		0
>> +#define DEFER_QS_PENDING	1
> 
> Having names for the states is good!
> 
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
>> index dd1c156c1759..baf57745b42f 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>>  	struct rcu_node *rnp;
>>  	union rcu_special special;
>>  
>> +	rdp = this_cpu_ptr(&rcu_data);
>> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
>> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> 
> Good, this is where the request actually gets serviced.
> 
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
>> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>>   */
>>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  {
>> -	unsigned long flags;
>> -	struct rcu_data *rdp;
>> +	volatile unsigned long flags;
> 
> I don't understand why this wants to be volatile.
> 
> Unless maybe you want to make sure that gdb can see it, in
> which case, is there an existing Kconfig option for that?  Maybe
> CONFIG_DEBUG_INFO_NONE=n?

This does not need to be volatile, sorry it was an older remnant (back when the
handler was a NOOP in the v1, and I was afraid of compiler optimizations ;-)).
But its no longer needed so I shall drop it (the volatile) :)

> 
>> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>>  
>> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>>  	local_irq_save(flags);
>> -	rdp->defer_qs_iw_pending = false;
>> +
>> +	/*
>> +	 * Requeue the IRQ work on next unlock in following situation:
>> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
>> +	 * 2. CPU enters new rcu_read_lock()
>> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
>> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
>> +	 * 5. Deferred QS reporting does not happen.
>> +	 */
>> +	if (rcu_preempt_depth() > 0) {
>> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> 
> Shouldn't we have just this WRITE_ONCE() in this then-clause?

No, because if we let the IRQ work handler do that before we can execute
rcu_preempt_deferred_qs_handler(), then it will cause infinite recursion,
because an RCU read-side critical section can again try to queue the IRQ work
(before entering the scheduler). Also testing shows doing that will reproduce
the hang we're fixing.

I think we should rename defer_qs_iw_pending to defer_qs_pending to better
clarify that we are tracking the "Deferred QS" reporting than if the IRQ work
actually ran?

Thanks,

 - Joel

