Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841B2EF2A8;
	Fri, 11 Jul 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251982; cv=fail; b=nn73D3HWThquI7qEC9Qtp1jHkFtGJEocZRElc+joqDgbCUfE8iqLZ5+JmFGY2YUX2ijXhls/w+WRU0lmuKO5cZfYwW2ntVHI5QEabNvFnfZB1z4gbpZX5NH+M4W2ArzQXUmt6S1xFj60T7VmKcl2Qy8NvEACtXmsPmiMqR1VdZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251982; c=relaxed/simple;
	bh=K4ysjbRkI+5kP58VgQ4TTCXGXeYCkNm0qslCKfVq8co=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uPA3wD3wxU+K43o5mNVNlv8CMEUNPwtQdBBhywscwfJyG1genRNJJpxvmDgerxXAeNPa4hcAgAjvsYpAJ3NDsmQW7ehQE9WbfWDYPSJSsCjMluroYlthbxmnj/C0pIkEcZoDi+pzRgoeGODYLFkUeNRBAs85ent7bME7lENEdXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QmZcW5jC; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QmZcW5jC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjmJ9C1B/DkGPnBiIqInoW4wuMDHdjk6YNrvzNfSltoIX8CJ1yh1KlPNtvccncXPs2JE6ONzw9vqGsrwRK9exv4Vc8W8sFgliV1Ah0z7rfjhZczj6Jzn8719mssnkJA+6ndtRu3GEtGZouRRaPWq4NdENU6sySRSGjBxEfFFImrVNxLhwr/gzTRsTn39kv8l9c9qoxTOC05O3Z92ny/JOvH007ERveKpyelNunOdcoMZ7datynTeqhOzAp5qj9iAUEsp0Qjs7ju3MhPJ7XMIGi1cLhwSQuzJs9SXP6LAHcSB6gdo2sBQZHM2iNajgnWad1n2GsO+oNJl8hsFXrhA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNLdPImc6WZNUupPhRBqZgrFccLzxaF3iLh9waIJ2Bk=;
 b=eh8JFy2C8XK62h7eU9qSxchb+SD/OxtjmAhxnwJZkXsliQsF4QKx03u60txAT0wpsQ4rOZFwfW04ObZv1YrfkAQj+mP4Io43tO72GJpPDnKPaNJpAZd96Uj1qrwLdWF93gpx+ZCmAKSYZtW2XLOaRBtP6OiW6vSnOJJw7DbxBwcOnEsv71Siq7wJ0SCZtWHm/kdkJ7DVkM3lZxWLxvLlyQ9SjXA7J8AZpjK++yEjrHhgByUMqvuQ+R0IH/cyJLIv5INAmGxi6VTUwOU7FIrtFFIt7QiLQOdrPO5+e/iZZCpGt7O57EdGlNasOrdPNj3TkmCewv2Kw5ubgDOY8aCEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNLdPImc6WZNUupPhRBqZgrFccLzxaF3iLh9waIJ2Bk=;
 b=QmZcW5jCHqtK4ZPDnEYiq0RTnCrpiaVcQk9q4lqn0W3+IBSIvgiPfgh1DyeTE2z13Y00G+QZopP2zSJZ8v4W9fnFoYivVFoWMqFK8MZxPagSdmrIODPWwOZLGXr8uz1FmO4gSXn8SzuDoU2CFOqI5EKWvYudRdtdvVlym9caRFE0x/ujfrDBqHqxObch+ltpWOUcn9mV3hgl16aBX9YJKpthfx3veAwV08MjSkdjl+4gkxIibNPW+QMNCd+EtczTcM0RjI8zksJw2io0PmgHz9zrgDQzW5YyXEAFJmy9qZoAQW0pH+3QnRWXFyVEB/diOhAtKVqBQtFqs2axcE5XdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 11 Jul
 2025 16:39:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 16:39:37 +0000
Message-ID: <6174e60d-6973-4307-960f-27f31657b12f@nvidia.com>
Date: Fri, 11 Jul 2025 12:39:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
 <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
 <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
Content-Language: en-US
In-Reply-To: <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 40218201-865f-459b-bad3-08ddc0998634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTZUL3puVUVsendHZjAyNjg2eVdlMTJnUzllR2FhUDIvL0lranF6VGNDQUpl?=
 =?utf-8?B?VnEvRjlyc1hmY2ErYVRiSnFyTjNyWVVzMDd0bzBLVXpkRnZLenphaVFHa1Ew?=
 =?utf-8?B?Q3hCL3dJNVFFeGtWSUdiUWpOaWk3d1pVMkFOUUxBeDZxVmpwb0hMczNSUWNQ?=
 =?utf-8?B?Zkwzcmwxa0tNeGxRMFI0a0pFTFlXZ0g0Rjc5eG5kWGV6WHlhM0hlcFBPOHNo?=
 =?utf-8?B?d0RIMkZqNmRTTWFGWFBmWVZWUENhaDBjNnduTWN2WXhrSnl3eGplMFJmZWhL?=
 =?utf-8?B?OWlycE1FNmszaTIybTN3MEg2cHQ0b20rN3hWK0ttaGZUOU5yeS92WnFoQWFj?=
 =?utf-8?B?SUpLamJqZ0ZPajlNQURraStIT3RDd1U2M0hFQ3lGVDlsVDRhV1lLT0ZKWTJT?=
 =?utf-8?B?UW5RK0JFUWg1WGJkSTcyQ0hMZVFIRlVMYXNVZkh0NHFwUURYUmRXUDlnY0pG?=
 =?utf-8?B?SlhRSjVCcGFkWUpDYmdmdE1QQkhVbmVsNXU4djdqK0RiS0d2UnZEdDZsR2tR?=
 =?utf-8?B?UmNxY1hJb3hmOFo0ZkdaOE9xb3JHeXJJUDlSU0crbytJc1M4RDA1Uy9HVEts?=
 =?utf-8?B?WU4rVk5qNzd0b0V4Zkh3dFVXOFVZcmlwZTZ5UFg5cnlJSWQzellBNEhvQVJn?=
 =?utf-8?B?bTg0TXRtM3o1blpGeEZDenlJTWMvd3ZPVVlGblJaZTFXRUMra3FJWTFHNTk4?=
 =?utf-8?B?VmVKeWh4cUJwZmZnL1NmODBxQjZ0cXp3Z25kYnVnYUpZekttQWVvWTlJYWZ3?=
 =?utf-8?B?SVM1d3MzMHNPcXJpb2VieHB6NGNKZGduVXVlMEQvRG52YVFORWxUdjBnTUJF?=
 =?utf-8?B?MUhxUldHWHJrTGErUnhUTWtSUjh1WW8vSU9BdVN3eWYxU1A2aUlWSGlVWGFX?=
 =?utf-8?B?cU5JZEhGTjdPV1B0anRZZkI0ckFKM2V1Nm5yY3A2Q2VVNEVjMFVGeGxIWUdW?=
 =?utf-8?B?M0pCSENNMXB2Q2pLSWdLaFVjeHdsNHpSZ3pPalR0d2dWTTh4OWFPT0tRMUQ0?=
 =?utf-8?B?cG1JVTV6Q0Y5VmJWb1RPWncrc0xTWlF2OWk5ODVPdjJXLzBTTGErUHFCT2Fa?=
 =?utf-8?B?RWhKU0p5emRZNVFSeHhGeThOYkx4cTlhL2w0UTRIMHJaUVNMb0lwQlBRN2li?=
 =?utf-8?B?ZWlMTy9zdyt5VW1yazVzc3pOTk42c1R1R3A4Z05sSE02dlVSdm4xVWpMa2Nq?=
 =?utf-8?B?MFh6eFBMUEpUSlY1dVBUS3JTK2VtRWZUaGk4U3ppaTUzNUpwaTYreGRwOExD?=
 =?utf-8?B?WHF3TytMRUl2NTB1S3NNVGlVdUNaaEpYeGkzbk8vTWxHVXlsMlBvd0QrSFNu?=
 =?utf-8?B?Y2c0dE1XUnh0OVFOU2NlYXNXbitkWmR2a3pCbm9Pa29zbXZQZVlpbm9iWCt3?=
 =?utf-8?B?Z2IvV2RjSEMwR3J5dDNtRFI4OGFUWS9mTi9TT3lqT0tsaStXeEk2azA0YXBk?=
 =?utf-8?B?KzVMMTR0YzVFbnczWE1EeXVrdEhXSUhtZjdWd2N4NmFmNS8xRkNOcmtQYXNQ?=
 =?utf-8?B?OGxDMzlOR09IQUxyblhMdVlwWkR5TGZkTzdQWFVBbjkzaU1qT1gvVVFkTDgw?=
 =?utf-8?B?ZkxLK0ZKUTkyYjNjQ2thaWkyT1N0c0V3b2VLU0FqNTNjTzh1Sld5K29kNXdy?=
 =?utf-8?B?Y0U0d25kRDNVSXpjbVpxY09FTHFqVzRub1NEWFk5NFJ5OVlHdTFPSnpwYkZy?=
 =?utf-8?B?OEIyN1JaWG5vZTRZZjZIcG1xRjlUTnR2Q0VPS3h1c2Z2WUZFMGxiQkdZZExu?=
 =?utf-8?B?QldERHI0ZEZCNHhuMFZjZENFTnVSUVdHVFNtVzdmL2s1eS9lWXhZL1l4VGE2?=
 =?utf-8?B?c0ZocGFoVXFnOFdxYkFMVHczYVducmRPNUhzQ3R1NXg5amNLK094S3B4eGFr?=
 =?utf-8?B?QkU1RDRZdzB5Z0pvM3ltR1dPR1BDNHVrZmpGaGZObzRUclFwa215U25tUVRR?=
 =?utf-8?Q?b5lUwFDanT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRnZGpJN2IrU3BObDJvUmN0SmlveFZjRnpPL0hacFNuQlpod0tJekY2aVNw?=
 =?utf-8?B?aHBtb3NGR1dod0UrQTdaOTBBejlhZVhFZ3pyQ1VWaEhvNXhrTEZBd3djYjlh?=
 =?utf-8?B?QS93dG8xeHU1R25GYy8zdGloSUUwVWNtb2hxZUFvUW1aNXdsKzF2SEJFa1E4?=
 =?utf-8?B?L2loNEJETTdqYW5POXF2YmRwUDZyK3pVU2N0M1lZbTJhUnlFMnV5d2Y3UmtW?=
 =?utf-8?B?cjNlNkNlKzQ5bWM5K0dBQmllMkZzT3lKWkVxSktTLzBTaGRjVWhCWXpacnY0?=
 =?utf-8?B?YXBHWG93Slo5OGM4WE1QR1k0RG1Qd1JUY041c2tFRWMrcTVadTBqcFNob29o?=
 =?utf-8?B?V0prMjZ3OCtnbWRheXYwKzl3SnRRVEdna25nUGpWb1BWVHU4WjVLS2dMcXoy?=
 =?utf-8?B?UThBUXh0aHBaMUV5YkZKR2ZGS3V5L2tVbVdVUEhyTHRyZjBvN0xOVy9ZMSt4?=
 =?utf-8?B?S3R3K0tMSnVGMjBJSS9VbnhDN3d4WlF0Nm1GbXcvOUdpZklEckFDcmRkZEJX?=
 =?utf-8?B?bnpnY3pBUmxHVDdnZFlOTzZlUjVpMERCTnV1SFBGSmwrTkVmb0U5aGdFV3R5?=
 =?utf-8?B?emxWbkJIbEJKc3NUQ1RtbkZVWGV6N1pOSUFxYzlVWllCMXRRZG5rOStOMndM?=
 =?utf-8?B?bWQzMWE0N0pKaU1lSlJHWDRqYjFDSlRSKy9yeDF2RFhxRnptVlF0T250d3dK?=
 =?utf-8?B?YzZ1R1JmSWdQLzlDV3FiYS8zYW1NR0IrcE44MnhpaEZhdW5NOEh2dktHRzZ0?=
 =?utf-8?B?WHNKQU5heko0ZW96VjM2dXdpZjZQc1J0RVpISWZHQ1NaZXF2cStOWm5CeCt6?=
 =?utf-8?B?T0Zpc1kwNHJnSk44UTh6b0IzNVVBK29MYWliQkExRXJoSy9wMkpnUHFzY04x?=
 =?utf-8?B?ZzV2MDhRdHNrV0VPMzk3L2xWQURMVTJBaVc2TjVaTUkyd2lNZlBaTVBoZVNY?=
 =?utf-8?B?VXdsL0dhY2VyTVVEMm9JblR3a3BCMXE3VTl4ZkM2cmFNZVlESE50bkVnTWdX?=
 =?utf-8?B?RmI3K1YrYy9STjRzRWdhY0lXQzdHK2NaSEJ5cXdIR2VoMlBqTE16d2w0Qnc1?=
 =?utf-8?B?NTZNOWZRSENnd1ozdjJJbElCcnMrQ1hKemowUHZ6QXgzR0NlamJTZkhzcmtq?=
 =?utf-8?B?UVpsU1o5UFdUd0lDYU5NbkEyYXRvb25KOWtRNy81Sk5CeXc2K0Fadkl4bmtv?=
 =?utf-8?B?RW12VC80TVBEVnJFZkJSakV5UkVoNmdFTEtJZUowdUwwSzhnb0FjaTkrZ0h0?=
 =?utf-8?B?cWZsbkJKeWora0tlVG5raU9aT3diUDJ3Rk9kZ1l4Si9jVmlNWmxVcFBhYWdV?=
 =?utf-8?B?OStnSWoxbTBuYUF5WmxVQ2hTL05YeVVvck9nZ1B0a2MrMGQrdTUrcDk2RGY4?=
 =?utf-8?B?bkhSVW1mK1ZpTTYxMGtqOHAxQjl1R0paMlR0K0xSSjFnR1hrcm44clhQRFZF?=
 =?utf-8?B?QjB0a0xEUkNlUSt2WDNnZFBKcW9sYWo2QjFHUnpyeFBYWTdpZHBCMEp3ZEJN?=
 =?utf-8?B?UU9rT2J3c0VDUTBrQ1lMd2VBZzJTUlRkWHp5dys4NUJ0M3BZcWtMc2QyK3ZX?=
 =?utf-8?B?eTJlZzl2d0hqMHFkZStlT3pMT25Yc1JhMWtFb3RFZEVFQ3VpSzJRSXhQNVc1?=
 =?utf-8?B?OXBMTEovSDFZaXZBRFZTdVdsZ1RJZStjd2tYUGhFY1JCZTVTVlZhUERDbVBV?=
 =?utf-8?B?SlZ1d0ZNdm9UNjg0c3Mra2I3VDhiVG5RQmhlUzN1TFJBdE9sazFialVJYTZB?=
 =?utf-8?B?cEh0VkdEbkNNZ1dtSk1Ea1dGWjVMMUI2OU5FWFI4b21odnk0WDFKQnN4Rjhh?=
 =?utf-8?B?REdtYXJEcUdOTXMxQkJuUUVpUUJYbjJyOTJyOEdZbWhKVElJM0NYMjNRbDR4?=
 =?utf-8?B?M0pqaEJaQkZxN3B0ZHlhYk42L0RreHJYeGVYQkhMSHloWmhUMEdJMVo3VVZO?=
 =?utf-8?B?RmNzVTVVNXRueVJHUUVENUpraW9LenFKT01ITGMrTnRSMmQ1c25vSEVocHZ5?=
 =?utf-8?B?RFZkcXBSMkcrZ0s2UTE0MjlsT3FQMEtScWNQZjJlaWlWWDRRdGpoN3g3Tllp?=
 =?utf-8?B?WGkwa2ZlaHFmcWVEVkR2cnhjMHk1MjhqKy9RK1dmSDlqZWFFVi9lTTRZUmY1?=
 =?utf-8?Q?QSmkPhX+rr5N+HLlqHh7xd7rC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40218201-865f-459b-bad3-08ddc0998634
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:39:37.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dwfZkAHHlv8QT6K7miLLYW0u/3PApcdladkzhDoIo3wTSBBOCWkB/vZ27aOb1B2kfhZkvYZtLuFEF92FZgtSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923



On 7/11/2025 12:30 PM, Joel Fernandes wrote:
> 
> 
> On 7/10/2025 8:00 PM, Paul E. McKenney wrote:
>> On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
>>> The check for irqs_were_disabled is redundant in
>>> rcu_unlock_needs_exp_handling() as the caller already checks for this.
>>> This includes the boost case as well. Just remove the redundant check.
>>
>> But in the very last "if" statement in the context of the last hunk of
>> this patch, isn't it instead checking for !irqs_were_disabled?
>>
>> Or is there something that I am missing that makes this work out OK?
> 
> You are right, after going over all the cases I introduced a behavioral change.
> 
> Say, irqs_were_disabled was false. And say we are RCU-boosted. needs_exp might
> return true now, but previously it was returning false. Further say, we are not
> in hardirq.
> 
> New code will raise softirq, old code would go to the ELSE and just set:
>                 set_tsk_need_resched(current);
> set_preempt_need_resched();
> 
> But preempt_bh_were_disabled that's why we're here.
> 
> So we need to only set resched and not raise softirq, because the preempt enable
> would reschedule.
> 
> Sorry I missed this, but unless this behavior is correct or needs further work,
> lets drop this patch. Thanks and kudos on the catch!
Btw, Neeraj, the related patch 3/7 should still be good for applying (which has
Paul's Review tag).

Thanks.


