Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04492E337A;
	Sun, 16 Mar 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742135032; cv=fail; b=QA7ts6XHPVM+shdzyjxuJhI+LKh5IjEXb4Omg9vq1aS7jHRR6sZRydPYu11L66uEiHA7Q4xc6lEu5C5p3Ox3p9Wyo85yQ5/4ynI/hAUDlgGWBxbYYka8cgasZpwOvXjav3VijHVz39o4clq3L/ANYjixk8IfG3XY6023PAuUR/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742135032; c=relaxed/simple;
	bh=FIl3xzEkPWjjyVyLkcD9jDkvzE7u1MVAHZxcooKFikc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mRIexG5hbAgdeFiREQgysYObQikehbE/y/wXoBRjW8qdABvir1wGNHIKiHLNDDNCtmGP0/aJx+3SGAu4yAxU95sRcw2ZNKlxcIB49Pcnd7FffvXeuq5H4h39SsxT5hOp4EkK+s+y4rKgMrU+CCH4NxCL8JFpMIbUI7vSZ2DICmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmcOk+qi; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmcOk+qi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj/DOC14zfIc7tC052Io6U8eoqayLA0iUJbQntKkJ0Xfq/OS4+VQaLMigO8z7AadanqKEt+Z61Fy08PGm+TxlUDogy5tL81Na6S7sHqFVrQJ2aILfpghkaQdsG0mwSUaD+NTbXG3yUK4W1dARtWX9r37MXKbSVmdo9O1oYRsWmNmmC1NM6KgmpiHvdyMLr5nbIIrlCMw0Cuf7V7VvCsIr1Na/CQ3r2dd0WL635NKCz70doczlKW2m6M3uBMXtn0oS6rhA2Fz+99uTF7UPjAxyYeT4wbSBVbzR2E8aVw0B8I4VY03CNect7UsCBCWLFRZuJnHwhgekrRTk4NYC7uEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RwMvjZwBf4ZgyYvMqW70gLMN19z51RolHw2LyEuXNM=;
 b=H2K22j0bQHkjUM9mq2iTo042pE4k9gDQld3RbIm3x7Mp8CviA1hviGnMGAzEWm6Z+IN2TvJKtnmlrG1vOHD5ILM9dqoLW2slaltAyH3Xc0XR3QJjslYiqNwRONTVvDHXLXEyFshOtQnWrseW2DXdEU3AcuPsLaP15r/o3HyXO/FBUZy2iY5GJk/L2G97mQ7jZ+Dg4xqd9IqAKofGoqDdCJj5rhtmKqk34s6lDWML9qlWI/OgJrhpuqbqqzXaX+hRM64w/xPRf9cjpaDL9+ZyiZ7y7mp9qTmkRJAqexPA4IQzPYZdz7Xiw5QaUlcw1iW7CNP5Rzeq6ezDu6czCNm/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RwMvjZwBf4ZgyYvMqW70gLMN19z51RolHw2LyEuXNM=;
 b=kmcOk+qiu/BUXRzTCDDBKGfXhkygBuAT0Vak7B1hmR1tWQkkKkSaMDOAsVtWOYOsxJH4v4BNATjQooV0aszLBFHxWT/UbIbrk6IMx6irWG/URNd096AeyBbohc0680S/FJxMYfBS3vHhuQ03toe8AyTv83bYEBRr/2WCqHKtT1pMmMkeAyllJzPJ+9hrAL1730M9GunaVeTMYlbsaF+JQ271wiMRoJtx34MyL0xAAenj8/J5ArzkTF7SZxgYAMxCpx8dcM7em+7s0dCJbViAFc1ZPEmJSedTVcnT8+YfkkoNYJ5QL/kkx/HDhoxtMnaadov34ofVi7cCQBoTkwmAfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 14:23:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 14:23:48 +0000
Message-ID: <65d7e2db-2293-4fa5-ae73-bcbaa60c01f3@nvidia.com>
Date: Sun, 16 Mar 2025 10:23:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
 <20250315235945.GA2634509@joelnvbox> <Z9aw252VPvW9K4Wl@pavilion.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9aw252VPvW9K4Wl@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4d2bb5-48dc-4168-3841-08dd64962ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cSt3cGtxSWVIalZHYS9oZkFabDVPdklXOTZkUU9EUWxEM1V1UlExSjZ1VHVO?=
 =?utf-8?B?Y09yODBFUnFTNUJMNDdoQVcrRW1WNGw5bnRvcVU3MVdJNnRyeVVYd0o3Q2dl?=
 =?utf-8?B?NWJITnBMRkN0N0xCZ2NwK1hEWHUxbENlWEttYURBdnRqZ21yR21pVWwrQXBP?=
 =?utf-8?B?bnlzZS9VNDFBeURySjhoT3ZBTXF6a2prSHh5RUpMbndvZWFWOTRyUkpDQnpH?=
 =?utf-8?B?UkxrcE1zYlQzRVp2M1JaWFZYNzRBeTJwcXVHR0t3WjhsTjh2RUtwUlVDTERB?=
 =?utf-8?B?cUFYNkptT3JjblRteldpL2pZTFlndm1JWlhMUHVLbStnMkNBK1FCTXdVL2V1?=
 =?utf-8?B?d0pIZjUvdGkvYVh3TTJIWFdXUnowc3ErUHNVZHVpSVBrUGVaSTBVRXo3a3B4?=
 =?utf-8?B?R0hrTS9HWGEzWGU0OU80K3NnS3ZKU0t4RDFQY1lKQnVXc2NoN2hGNFpRUUYr?=
 =?utf-8?B?T2I1NExCMHcvSG5xY2s0LzU1T3R3b0NjTW16WWlpZ3VxdmEydzlZbDVtQ01M?=
 =?utf-8?B?L0srQUE0MXFreDlmVXdqb1EzVG1aR0NsWWlrL2FjWnB4R2ZrS1lEY05paDBI?=
 =?utf-8?B?akZQOS9kYUdwbUwxL1hHT2ZzQ2E1QTQyT20wMlNLUlBnbDRsdHh4ZU5GR29L?=
 =?utf-8?B?WmhsbUhiN3VYSjJ1Y3VzdCtLZWExaXIrY2JPU3htUnNKSVhnUHRDVDlWTnRW?=
 =?utf-8?B?cThyeDRiR29MOWo2ekxvRU5td3J5UlNndFFtem1hYTUvOFR4cTlOcENiRGxN?=
 =?utf-8?B?NnMzaDBFYWQ5TTl2djJyaEFlVlZPZ01WcGlOUEpEZ2ppRFlabFhaR09jcFZr?=
 =?utf-8?B?dVRaaGFYZEc0Q245Y2JDTjFFOVlUZUxxdkJaNWdpeGJWRjY0dFVzdDhPMUN0?=
 =?utf-8?B?cE03RFROa0JzOEY0aEVObVhnanBUM2NPdk80TlBpSVAyZ0s4cTlxays1d1c2?=
 =?utf-8?B?WG5TeEhKVDkwUHFXbHdobW1mbi9xQ3VFZUJjVmVTZzROb3ZDaEUyT2dQWnMy?=
 =?utf-8?B?bGxLcDNwSG9DWnlQbVNQbWZEYjArVUxRRnRZWjRNaWZTTkt4dVNmVFNIbDFG?=
 =?utf-8?B?VHhtbklicThPWGdlN2F0UGtPZXA5Z0lHWnZ5eEx5OWtBMUZjVjBUN1ppVkNL?=
 =?utf-8?B?Rk94MlE5YktJSXVPdW5KSWtsZmpid3BaUmZ0SmdqWFlPSzRDajNKSmlhTGxZ?=
 =?utf-8?B?NGFha3V0bTFZc25YNlhJUFlOSzJlSFE1a05vd1F1cUJEMHNzbTFqSVlIRnNk?=
 =?utf-8?B?RXdpcWZFazJ6clFRc01Jd25NR0xscUhWd1JTWk9PWm10ZEM1aGFwSEx1YlVv?=
 =?utf-8?B?UmI5NnNFOXF1Uit0RitGZkJRNmxLZmltYkFpWEtwb05mL2U4aEZyVjV5YkdG?=
 =?utf-8?B?d0tmRzFNNjRoUjlTeGpnZmd4dzlzS0V5TEk1N2tWN0dRRlRHaVZSZ0xsUGxx?=
 =?utf-8?B?WkV4ZjVSZVJ5ancwVmlKanRxRlkxcUZySmIyWkRPclhGV2NlTzNNZVp5Uklk?=
 =?utf-8?B?MnB3b3lINnVISm9lL0Z3STBiekREQ3gyMlJWRCtKY1k1SGVneWhPM2RTWG41?=
 =?utf-8?B?VjBka0ZqaTZDR2svaTFnNXJya0pHOS8yUDdvU2FUTzhXVzRFT1g5NkVZV0hC?=
 =?utf-8?B?QWpKNllnMVhWdHRPWHZIeHpyK21mN0dSVWZFcm9ieUpVY3RpVkpjWkprY2Y4?=
 =?utf-8?B?V3ZMaExkU2FnNHVNU0xJTFFmZitwLzJLOHpFK2lCQlVyaDJheXRtb1hpclhn?=
 =?utf-8?B?RmFxeEtPaTZ6THgyQVdxQy9HZ2k1U2dZcU9id2pDWS9zV0ZrOHRIa0doZTNW?=
 =?utf-8?B?NkNWSkQ0K3hQZm1leWNoV1Q1VzJJbkJ5NjZENmVrbXc5L2RKZ1h2TThtb3Fj?=
 =?utf-8?Q?dLe/lwjY1C2XW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFlaEJ6K3RSa0Zla0ZqL3kwS0NDL3RucWRKdGtPOFRTMkQ4RTR5U3NrZHk3?=
 =?utf-8?B?UHc0d3FxSGFwZnErY3FxMFFxZmJBclFHOFpCVGhzcDJFcnJYaFJTNFptREw0?=
 =?utf-8?B?Y1dBMnpzenNMYXlWOU4wcGFuSjdUWElUVkZVaThhWW41dWJzUEpvSWVrVVk0?=
 =?utf-8?B?aTRGbm45TDRtVWsrTDRVdGR5RkZLZG9NVmhjN0FISEFjeFBsYzVnSEhLZUVW?=
 =?utf-8?B?SlZzN0t0ZHJNVmk5cHpPVllqUllQN3RHRGh1ZkNsb05KWExPWFhPMTF4Titr?=
 =?utf-8?B?Unl4TWpCa1NKcU9mUTl3V0JpTEE2dUVwZ01wK24xc2NjMkx4S3lYVUNaVFBH?=
 =?utf-8?B?VjZCNlJJQ0F3ZncyUGJaVklVVFlxaEs5VVNyckZySmVqVHpCVkZubE9OQWpq?=
 =?utf-8?B?NlY5eUErSENrYWN2aE84OGRhVmlzYjJzeUpBNDZKWjhrT091eWFQUGRwRXk5?=
 =?utf-8?B?Vm41OTBZa3Z1dHRhdVoyWXA4QmZQU1M3MmVnMHdVT0hBbGFyeDRSanFtQjZl?=
 =?utf-8?B?RktyeFF6QUplalhmTlNUMUhjbytxaU52Vk1HMS9wNnR4N0RDVzF1QndIUjZE?=
 =?utf-8?B?Q3ZaWU5lVzRuMTVMM3ZyVUl5MEJXMGNGckF3SzNmMVBIb2RONzh2dGgwVkVL?=
 =?utf-8?B?RU16eTBiMFJEWW43cE1XL01saWRyRS9Nd2tpQmxHdzBvZXVHZ0NkaE81bHdj?=
 =?utf-8?B?Tm11MDdCV1NqdTl2K05mMkxIak9WQTdhcjRyaVBVTmt2cUsyMzNrRGhRQTYz?=
 =?utf-8?B?RUtLVnJReldJSWZLbWwzZ29MV1c4VXFnNzJJbUV6YkxCSXZiY0t4OVBlczUv?=
 =?utf-8?B?cE1NVk80SGRkOVoyYm1FYjg3cUdwU29zSVIrZUF1b2djK2NDZjJHUjQyakY1?=
 =?utf-8?B?NE9QU3g1UkUycGhESFRTallGdWViUEg2TkEwY0t3SjdJUk5hQ1dpaTNYWm5Y?=
 =?utf-8?B?RGRUbmNLWGRrUVZvV0lQQStORWh3WTNNRXJuQi9DaUptQWNIWVErMTM5Ris1?=
 =?utf-8?B?alo0aFJycDY4WC83d2VrS2I3RFltYzBnN3ZlZ0dWSUdoS0RNb2RFQUhndEIy?=
 =?utf-8?B?VFFSbjYvSitTZFk4VkpyejRPZGJBakNwNlFuekk3RVgrMS84Wk5jaW84Vno4?=
 =?utf-8?B?YnQrTmZpSVAzNHgvdlRudEZqdXFySHlWdmp4NE9xZGs2SzRscWxCSC9qTW1F?=
 =?utf-8?B?QjZMSTBWcGVHWDgyMkpmMWpxVUE3NCtFQ2E5VzFtUGZFN3QzbTQxbWVMUG5Q?=
 =?utf-8?B?VHdNQ25PVEtnSm4wdTR5YmR2SGZSckdpT2QxcnNRSmhjRXhQQys4d3ovYnlm?=
 =?utf-8?B?V2p4eEltSktRN3dHTmZLRzY2YTl0a09PWStSREJNUWNLdjJ4aWZvU3BYTSts?=
 =?utf-8?B?Wkx2WUpUcUJqdjB2UStTaXVrTFhsV09uRlpnamh6am9YT0IvUUI5WkxFZ0oy?=
 =?utf-8?B?bHNXL0ZhdlRJblJmWVIrMzRnUDdycGIzdGYwTHJYQ20yTTdpSUl0RWJmWTRL?=
 =?utf-8?B?Sko2MCtocTg0SStKVEwrZDQ0MWp1dHdzbW9rRXRBVUtRcUV3OXdXN0RDaWpl?=
 =?utf-8?B?VUZMVWFBNFdmdWkvZ1JEdFR1THNaR2p2UGRySkhSRXNLTHRabFhPUHJ4QVRG?=
 =?utf-8?B?bE9TK2JmL3JWdEtlRTJxblpJNFdEUC83TWJvRFJJSFNmUEE0Yk9aeUJ0VUwy?=
 =?utf-8?B?MUpRemo4U3RsSmFsWVNXL0hMK1IvZ0o4andoOGtnK3lmNFU5MUlxSVNsMC8z?=
 =?utf-8?B?bmdhaU83SnBTa1M2dlp4UEszWDVoVGhwRzlqZFo5ZlZKeWxiWHhraTlBWnV2?=
 =?utf-8?B?UnNnUzQwMFNFUlR4STR1NEt4TzhPbXBhVVFGbnJFclRyNXRYUG5kVVVVQzFH?=
 =?utf-8?B?SmRPcGxESmdqZ1BHeTdvNzE4Q3J2K00wZGN0cmdLSFBQSENKZ2tWVHZycFhY?=
 =?utf-8?B?VzVFK0pTYTVKb21CUXRVQ083MVAyU2g2a0xBZFpCQkRoamZSSktVOExaRm80?=
 =?utf-8?B?dUEyeDRtekZ5alM4alJibHR3ckI4ZzlXSWxmNmtUVVJmUXRtNE05dU5yd3d3?=
 =?utf-8?B?c1p6U3VNczZoSFFzcUkwMGNmRlZPZCsrdWliK3BXZ3h5SlI2SzlzQWQ5c2Mw?=
 =?utf-8?Q?h+4wLLdvxzFHuDudCv72fSb+b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d2bb5-48dc-4168-3841-08dd64962ad8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 14:23:48.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNH8uLl5kNUmvTRV/AME2OeqBuTW3Jpdc8+MR+88ZsEtgRGd8bQ23Rloreq5/J+xq7gdmneGYHf/EiaCPzuuaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761



On 3/16/2025 7:07 AM, Frederic Weisbecker wrote:
>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>> index c36c7d5575ca..2fa7aa9155bd 100644
>>> --- a/kernel/rcu/tree_exp.h
>>> +++ b/kernel/rcu/tree_exp.h
>>> @@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
>>>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>>  		WARN_ON_ONCE(rnp->expmask);
>>>  		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
>>> +		/*
>>> +		 * Need to wait for any blocked tasks as well.	Note that
>>> +		 * additional blocking tasks will also block the expedited GP
>>> +		 * until such time as the ->expmask bits are cleared.
>>> +		 */
>>> +		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
>>> +			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>>>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>  	}
>>>  }
>>> @@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>>>  	}
>>>  	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
>>>  
>>> -	/*
>>> -	 * Need to wait for any blocked tasks as well.	Note that
>>> -	 * additional blocking tasks will also block the expedited GP
>>> -	 * until such time as the ->expmask bits are cleared.
>>> -	 */
>>> -	if (rcu_preempt_has_tasks(rnp))
>>> -		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>>>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>> A small side effect of this patch could be:
>>
>> In the existing code, if between the sync_exp_reset_tree() and the
>> __sync_rcu_exp_select_node_cpus(), if a pre-existing reader unblocked and
>> completed, then I think it wouldn't be responsible for blocking the GP
>> anymore.
> Hmm, I don't see how that changes after this patch.
> 
>> Where as with this patch, it would not get a chance to be removed from the
>> blocked list because it would have to wait on the rnp lock, which after this
>> patch would now be held across the setting of exp_mask and exp_tasks?
> So that's sync_exp_reset_tree(). I'm a bit confused. An unblocking task
> contend on rnp lock in any case. But after this patch it is still going
> to remove itself from the blocking task once the rnp lock is released by
> sync_exp_reset_tree().
> 
> What am I missing?
You are probably not missing anything and I'm the one missing something.

But I was thinking:

In in the original code, in __sync_rcu_exp_select_node_cpus() if
rcu_preempt_has_tasks() returns FALSE because of the finer grained locking, then
there is a chance for the GP to conclude sooner,

On the other hand, after the patch because the unblocking task had to wait (on
the lock) to remove itself from the blocked task list, the GP may conclude later
than usual. This is just an intuitive guess.

Because this is an expedited GP, my intuition is to unblock + reader unlock and
get out of the way ASAP than hoping that it will get access to the lock before
any IPIs go out or quiescent state reports/checks happen which are required to
conclude the GP

Its just a theory and you're right, if it acquires the lock soon enough and gets
out of the way, then it doesn't matter either way.

Thanks!

 - Joel


