Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAD41C79;
	Tue, 12 Nov 2024 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386275; cv=fail; b=B0rnwUAd5FmbI2iVEFTjYTBOgBJt0y3YK4AJWMeVTTLCmBqd4TjugUM5f1If1ph/3ecgjvp7ya0XyEr76/8GNyonl37iicKpsJt1TVe9y4AoO5BqQ/+TAHBX5Za0ELiHxRcudn/0yswYDtD6MJYM5UsJ7X3qY0g/bRjI9hMRwL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386275; c=relaxed/simple;
	bh=YIp/r8esns0sMS1A2fHX5ZTfFYPKpJwmhLpgs2HK6TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbGXg1OADdtnRAZ7ylMdrM71JWgjS0l+gVttGTRRFj87RaBYyBSM2OYDIDy0Ku0dhUGvrgRpngZ+bXYVxJ5/K3utgVzw5bcgUQMrY9uB9RGYx2Q46a1hXAnBGIEbKjJORwdX3vjRfl4PFdlowM9RQq/a4duYziug5n4rYyziE/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVey2z8o; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVey2z8o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QElJw4A1fTG7oT5fPmqwvqEe0VZJ1vt50xfyzfcUhkR4EOGzFa6Ah3UawyTtwU8ceBCTIHvzb3ToQbj4tK1dyf6W2rQHxWM0MYg/CbOHTufIujKcKRsH0oUpL7SjEO5m0Brr4tWSnKiiAQk5F4thKBPCQcMvHI/gVWOZ0Z5gMZwHMQjkuMvkV5kWFG3tkPuXxIATOu0F/CLsv1p2DKguQcfakepjI9HLguNUHgMznESogWaWdZNDXX2gEpp+5PnalT/njXd1ZA5a7KSwognMcIiWcwneze4X9rxejmkcRa8LFv/T+a/+GeZ0xBRu0LDpvw2RU77WQXXdPnSFs+aHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMk94nRAjyz+csVcMH9ERTuVIVnI34+JTkaTNVOCZ4w=;
 b=Q1B3K5wOuCut9pF6uIUYHZcsUDBlfX6eScR1uCV1ZKfSgvzIBv2gKijnDCj1tZDXYaS5k17H1s1gBbUUJd3xF96xPufyYfR1KMWtkuCZSRVM6uCFTn9WmKI0Ss4qij05Qn5jsJELVw9R0SB4/SAVVz95U84ej0I2xxWgafxlddL1p1VeZDjgRoxeFEHeCI3B8qsFTUaCYvpIREUwPvKwa6Hr6F7xfi1MvdtyK8RKsOzU3KSXZNy4uP9v/X6Zusi8P+kHFMHqsgXg+epccDVYECCCXZFxg+5CBFsRjoHujAe7hjCp9dU4cL6Oh4U+JKm4KKDIhPNqDwvGemPnLfaOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMk94nRAjyz+csVcMH9ERTuVIVnI34+JTkaTNVOCZ4w=;
 b=pVey2z8ojJ6ezQniSP5UIIAJKuvY5C8iFGbLA1GI5Zb6Ytdmq2QNfXz25I/Sti6JuM00bzBWPTM7c39nmvMI4atC+yTk7aV5DzbsdySNq1fFm8yQgivqicFlVyUulfs9pY5IcvVDHGEc11419BABx0ALlpZakuM98QuKwA+MsHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 04:37:50 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 04:37:50 +0000
Message-ID: <48dfaa56-4d1f-47e5-8174-3a433711e0db@amd.com>
Date: Tue, 12 Nov 2024 10:07:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rcu 0/13] SRCU-lite changes for v6.13
To: paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
 <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4077e7-9a39-4149-3f0d-08dd02d3c3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkppMkRvQnBqcll2T1pKZ1lZbTU4WnJQMHovdEl6R1pLT245VkdVOFp2S3I1?=
 =?utf-8?B?UkE1QkkrTy83M3BjdlVsV2UzQzFQUUxBTmlIRXRhcUNsSHN2S3Brd1hHUEdJ?=
 =?utf-8?B?Y09mVThndkNuQTQyOWlDMkJQWmFDYUlXMTVGWXZad1FZQVVQT3haN1dZMDhz?=
 =?utf-8?B?UnBjc3pmUHg1UHFVYmVkVExIMHMwQWZCTEZLZlVSeHNvOUx6N2VrcXE4dmcx?=
 =?utf-8?B?WW9LSVgyNlVxVUpJMmlKb2xydzhHVCtXSTFoejhPVEQ0dWI5QlZRbDBlSlRB?=
 =?utf-8?B?a0k0TkV3Q0NXampHYzFWNEVRcU9RUWNvWDhoa3pxOUJESEdVZkxaV1F5RHRU?=
 =?utf-8?B?SzNqbG44dFVTdkRCUlhtQVBzQkJVQlBySTFWeXVjNWNBcDhWSWNVQWlZdEJx?=
 =?utf-8?B?ZWg5UEdYZ1d6eDV0Si9ZalBmNzJPYWZBVlcyNHV4aDkzM3BXRDlESHYzd25v?=
 =?utf-8?B?SWFoaDJxcTB5RFcrWHZsalhabEtEdnh0N2pubUpaY29jK2lrRnhEOG51ZjY5?=
 =?utf-8?B?TWVMRjJ5SmZ4R3BDL0V2ZFJjQzg3LzI0VENGVXdDcjc5WU85VlpLc1RyL3cr?=
 =?utf-8?B?UUliZUNVSCtSOWdaaWk5YlR4c1NHbXVQMDFwaEVMK2tMdXJnVGhIczZwNGFQ?=
 =?utf-8?B?N0gwQ29ud0dNb1IreUpSQklhaW9ETzZWeFVXMGxKZnliZDRveGtGWGNPUXAw?=
 =?utf-8?B?dzVUNGtSUFpCZllhNnM5MFNEMEFNbU9oQ2JMcm9hT0MxT1kvdlM4VEwreGFV?=
 =?utf-8?B?d09YRUlBUVNtbFE0TG04dTRhWU5iTGhVaFJ2RkhFOUtCemlrOGxZNGQxRVB1?=
 =?utf-8?B?aEU5RHpxTkdzTGUxT08zTGQwLy96ZWw4bGxPMlh5Nm5oanVXVEEwWTRIb3pI?=
 =?utf-8?B?U2Vha0prYVM4T084ZGhUd2l0M0haeVNlbmN0VDhFM3JpYjVQdDlkdit3NzEz?=
 =?utf-8?B?d0QxTU9yQWMxV3NJV0ZyUXFJWmFBVlFvQmtnMStLYWJxYW8yem4wb0ljT05k?=
 =?utf-8?B?Ulk1RjUzZHp6TnZub3VoQW1Tc3hOZzd3aFVtMVFNZjBZbGw2VE1DclBpOEFS?=
 =?utf-8?B?ajJFUlNSeU5ub2lvVVRoaC9OUE1vUjNxK3ZqaElxRVdJVmhZMkN6RUJDaFdj?=
 =?utf-8?B?WFNPWWFmV0o5NlNqeGxqYnlycUw1UjZmbHlOMkJSZDVlNXF6bDAvU3czOHVO?=
 =?utf-8?B?MFZnSTYwNVg1T1hIT2NmRk12RGQ2Ymk0K1BDblQ5a3lhZnNuSFFhVm1PbXZs?=
 =?utf-8?B?RWdHeWtXU1ZNRVlwQlVvV3VWckxpMUxvNDZ1ZmhLdkNxVU9DMFg2MHdlZ0dV?=
 =?utf-8?B?UW5JR0ZXekxxY3Z5S3k3QkMrYVdFSlF2ZFE0VUVvanBPVFA5YzltKzJCOUdm?=
 =?utf-8?B?RzFXRmFoUVh5WWRQYisxVWxQMGJWd2J1WWVsNy9GVi8wRE9CVXV3UFhKcHFJ?=
 =?utf-8?B?WUlnVFR1RXc4UlpNaldIV1RTYTdNTmtqWG5VaUtoa3YxNE9hNUVKL1ZZWnBo?=
 =?utf-8?B?RDdNWGkyVDBxMXZSdHBnR2ZMaitMZSt1T0VkQWkyMHMrcEFQZVI0ZjFzS2V5?=
 =?utf-8?B?Z1N2MElXTXpCcU5sMmh0dzdWRDNQRFlvdy95QVVJUjFXY3NxVitwY1o4RDNX?=
 =?utf-8?B?enhJYWtMM2Z6YnFSY29pbDh4T0t2NHk2TWk3dUVsUTFWUnVaQUNXY1JqT1pv?=
 =?utf-8?B?TnNmaFduYUdtNVpGL2RRYTFKYi9NSURyeVNWZVNzS3F5bDdZalhBR25lbHJ2?=
 =?utf-8?Q?8XnNiUZsjtjcXZZd1gF/2V6mW92pzndWOQV7b5J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UERTTjJrVk1JeTl3OUZSN1d4QVJtYk9tSU52ZlB1c2JDWndWTFovTTI1cUJ2?=
 =?utf-8?B?bEFXVm9wWFZielkvRzhxWDBHVy8zTjBLdG5tMmp1Ly91R1Eyb296aGlQbFdU?=
 =?utf-8?B?blk3SWlTWWZvT0ppQTFtRjd5aU1sSVZlRTVMZDJaNHV3dmQxSEp1bXUyNlZL?=
 =?utf-8?B?ZlBhcHBoS041YjBJMWJldFIxWUlFc1p5SElGbGUvemxKRmFJUVVuL0pVK0tW?=
 =?utf-8?B?cjdhOHBEQkxiRU1GOWF3ajdiUkNZRTA0R0pQd2I5ZnFiM01lV29memowc0Rv?=
 =?utf-8?B?WFdVUStUY2VZS0N4OTVpSzNWWUpqNUxHS0xENVl5cCtsMjBwby9PUHdvQmdk?=
 =?utf-8?B?R3o3VlFYUEdyUlFsVE4xUXF1RlhqZGR2ZHRGNi9jNmpqSjd6K2NEZVY5R1di?=
 =?utf-8?B?VDZ6ZGNQV1BRTERkQ29TeitIZDhEL3V6bzRVUEkyTDFaYzRuSUN1eFZINXM0?=
 =?utf-8?B?V2NDcWNhM1ZWVDBmRUlvSW5BcllzWXUwRnluUU15TG9HNlBFb2NlS1JFdzBo?=
 =?utf-8?B?M0JXa3M0cGNiaXl0ekh2ZWgvclZTOXZxMkFqbThoOXRGYXBuS0x4M2IxUGps?=
 =?utf-8?B?NXVkOTY1aU1VVk1ROVI4WTRTMXRCRm1MNGpoUXh3N3psMitmOFlwT0h5MVQy?=
 =?utf-8?B?SnJ6UyttWTN0OTA4WmtTRmxnWnp0ZUxUNEFhcWxRMzNNSENXeFZnRjYwQ29P?=
 =?utf-8?B?UEd3NGR3NDhaRFFSUDVaNTBaMGx0Zm1JSEpHdVR2cExpUFJscW5MZ2lscFZX?=
 =?utf-8?B?TjE4Skl5aVVxTFZ3c2srWjJ4NE43SDFySzhrTGNLTkk1c2FoWG0xZE9OWTI3?=
 =?utf-8?B?WG40U1hIbUpoMnZDYTFHdFVmZFFQZlJFSi9kMzhBZG9wd0lhcWl3Wmsramk5?=
 =?utf-8?B?YklzZ3liSVpOWW9xYUJaeG5vOGdaWmsvUjF3ZktoSGR6VDJ3Ri95WUV4S2t0?=
 =?utf-8?B?UkNwVDU3VVpSTU5BQkFEbkxqWEpySzNQRmRpMTNmcE0rallmYW1weENhSGJP?=
 =?utf-8?B?c0NuU0ZxeXhxb3NoVGJhUkZYbUNsUlEybkdPNVlTU3FDTElGMzBQZFp5L1Bx?=
 =?utf-8?B?L2FFZVhXZnZOc3hiY0EyMnFPWmVOS0Rnb0hkS3ljbEdRS3JaUUVkOFBFUkRr?=
 =?utf-8?B?SG9qZVpoTjRNN1BkWXpRNUQ2eVlLM0k3MjZRL1ZEWTQ4bWo3bG00dmVhbVBQ?=
 =?utf-8?B?VVB0ZFM2ckNpamVYSGtPQmxSSHpCTGs1ZGNHUjNIb2lYK3FiUkg1eCtTZmI4?=
 =?utf-8?B?WTdNa0lQaVhESkJjaTM5RVRqQklRNWdMN1JnaG9YT2dvbHBCUERlMDQyUWt1?=
 =?utf-8?B?VDZTQVpKcHc4L3p4Qlg4ZzZQZERvdmc2cERES1ZiN0xPVXRLRTRaTVQ0UWRL?=
 =?utf-8?B?SVZ6RmZpZ3p3L1RVWmI2ZzIwai8xL2FtTW84di80am9SbUMzSkIyOVZkV05F?=
 =?utf-8?B?aXJtOWJTa2VURmp5aXJZeERmQWQ2TW9LaXVva2pFdEpmNDk0aDB3dHJZV1hp?=
 =?utf-8?B?aVArTHNRVXo4cjRxa2F4ZEFCa0N1eW1lREVjVVlJMWR5WHhHQmpWOGwzWUJl?=
 =?utf-8?B?RFR4ZldvRzRpQTdtdkpjeE5GZ0hJQnhCRk1xcCtaTmVoUWFWTmNPRSswODAy?=
 =?utf-8?B?RDEwUDRHZDhzVFAzVUlaTWRrWVZYd2FQazVDaUYxcWtFTVBUa3NvWXRpT0dw?=
 =?utf-8?B?NVJnOGN3WStOaUhUOGdUL3JaWCtuZDhrVkU5MDZpOEFubUU5NkNCemlsM3Jq?=
 =?utf-8?B?S3BPRWZqSEEyMG5RWjFxMjJ6TzgyTzhXcUpzbUJMSXJnS0NHaHNtb3ZXSTJW?=
 =?utf-8?B?RldBMytMTWJ2bWxEV3dhbWhpQlBaSmFYdlRMM1dtSkduTlV4b204VUJGeTRs?=
 =?utf-8?B?QzdJaG9ON2pqSUlwdFJYTmRZOGtUZmwzZDRQTS80MTVObXpjSCsxN3kwRExX?=
 =?utf-8?B?WFlLMjM3bEVmNGdvdXdwU293VGIyMGtZemljSlFhZDQrUzlJdk5aUDR6OThz?=
 =?utf-8?B?aVB5bkh0Q1liWjJNVnlZN0JuQjc5WW9FbENKVU9DV3NQdE4rMmZZRVlPcnRC?=
 =?utf-8?B?Sk9vODJRQndYVEpJR1RUbmhHeTFxa1hjYzVVSUpwbjcra0lLY2pXOWY3MnFx?=
 =?utf-8?Q?1n2b2RjcWsrLV3ZMyogG21UrL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4077e7-9a39-4149-3f0d-08dd02d3c3c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 04:37:50.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+Asj0UdifTz/J9x+LvJN7pwBI4BdQO6CAgg5viDd4g+LgvzkD6/5Oy4YBSDhq0a+46+5K1CsS9pWHkVwIJWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

On 10/15/2024 9:41 PM, Paul E. McKenney wrote:
> Hello!
> 
> This v3 series adds support and testing for srcu_read_lock_lite()
> and srcu_read_unlock_lite(), which avoid smp_mb(), but add a couple of
> synchronize_rcu() calls to the grace-period processing and may only be
> used where RCU is watching.
> 
> 1.	Rename srcu_might_be_idle() to srcu_should_expedite().
> 
> 2.	Introduce srcu_gp_is_expedited() helper function.
> 
> 3.	Renaming in preparation for additional reader flavor.
> 
> 4.	Bit manipulation changes for additional reader flavor.
> 
> 5.	Standardize srcu_data pointers to "sdp" and similar.
> 
> 6.	Improve srcu_read_lock{,_nmisafe}() comments.
> 
> 7.	Create CPP macros for normal and NMI-safe SRCU readers.
> 
> 8.	Add srcu_read_lock_lite() and srcu_read_unlock_lite().
> 
> 9.	Allow inlining of __srcu_read_{,un}lock_lite().
> 
> 10.	Expand RCUTORTURE_RDR_MASK_[12] to eight bits.
> 
> 11.	Add reader_flavor parameter for SRCU readers.
> 
> 12.	Add srcu_read_lock_lite() support to rcutorture.reader_flavor.
> 
> 13.	Add light-weight SRCU scenario.
> 
> 14.	Add srcu_read_lock_lite() support using "srcu-lite".
> 
> 15.	Improve srcu_read_lock_lite() kernel-doc comment.
> 
> Changes since v2:
> 
> o	Apply acked-by tag.
> 
> o	Split commit per Neeraj Upadhyay feedback.
> 
> Changes since v1:
> 
> o	Apply reviewed-by tag.
> 
> o	Link to performance data.
> 
> o	Add commit improving kernel-doc comment.
> 
> o	Pull out into separate branch to avoid dependency on an otherwise
> 	unrelated refscale commit.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 

For this series:

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

