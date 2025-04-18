Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71338215F4B;
	Fri, 18 Apr 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993404; cv=fail; b=Pcfnt90Ws7wolotUCXflqt191eO0oPozwjMppk+QL91OSOOln6lP5UW0JpT7fsRZ3La26r1dPRq+MDo4DHsRVEHC0MOhln8Vs3VrLl7VEcInS+X5Gg1dam30MZfmsWCgpV3cKZbUbHAFpdRevS1gbHCNeVcgzNGnZInWfUemDP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993404; c=relaxed/simple;
	bh=ietLSlrPVDSiVwwxDpbuA9QpAtXtVWFrt6bBbugJmHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UrzVSma7z7LUnxPOX6+gxAE+EGI4iXckJrHRy4m0tLv9sg3YA9eA3rkex2VBAIjEkqn35XZkD0fOU6mYhd4/+CaZP5wmv4PDsE8RtIHpA3yshxdjM8YfyLzTRl50z/KOp9oU5fgj8nr8XSPmcwc8s6iy47lzjlFT0t+9CECeDoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvW+3INb; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvW+3INb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7eE23XLoJygQ2BPRlO0qY6ydL4i1wkmX2gK5SPY+IrkjCjYAlpNlMrJD0MuVcafSk3LGlp5s8XW5gwA7NZCrdxnGHw3jrYpbg++fOn9ZywXnIRVZlUMV1B//Lr1jBosoOrl71XZaT+yKtSWTr2WLOD1e+RyOiIsfavo1CP15Anf7w9dFHqAKBx+Gt7FHp3OSab7PmP15Qw4ush7ZccyTyCxfTu4UUVMLE8twK++sdzkUcGAy7FkN1ChhURNsjMtTGaDpBOkcsJij9GrD4ttr7QjnWldnR0Xl5LClTWT8hWcHxueE2+E5repruSc2meXxSgH7J7RAlupvwG/T1nqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UerI16cmWNVMPBZ/CFs+wgBL7SRYGYJjH2zEDX59HUg=;
 b=tozEKvtsLv2EePm4B8W5v3i2bD9di0VZ4tAyWR6vSOKgDeqgagrFFp3Fo5MIFr1xcH/5Dua28ssOYtkk1C1iUZhn7DhvpceE9GsVQPkzm8sxJSGDBe34oTsPg3PHP+uoTSiWonaPuqKqOGnqmkWPLSTna6b8TODMVIFNL8r145xzj/4uSNTLe5H4JpZgpHVCXk+deCwyDpAtmv+PmS/mZvgcyy4RyOrM12q1Pvrryh0grGj5WLd/4c4ZZRGXsBpXoebZNb7yeuMYn59Sagp2VEpcLHTTKSOHwnfbk0+84nYVma5Z97kn5FbO7yqnQbI5iX/qIHVsBg87tJV4zbKVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UerI16cmWNVMPBZ/CFs+wgBL7SRYGYJjH2zEDX59HUg=;
 b=JvW+3INbvkFkcnAtyVN5iCwnpunXWUVcJrrBVqmPY2p3vDaA6zpxVMdZg36SJIAMn862a3oFYLzxnLQe24/MYa4ESsAuUUGOIUefn5fnYOyazbWZHdV8E+AeWI4OEqG0tkzV92TxKkjd58ePfA0go+VX9ezqeIUNG0QW3SmzcjKNuLwDP1blfDFIB8R0+cHgvtHyOEwvMtxg5uIQ/1GNrNVsUwUSXURk4Q/A+HYjnrs3aDLDr9PyMYeRrgG23WENOF06OafAgeCv+esX7GNAlRkn2UZZuzxgY3UfscQqhOarr17U5Flo0tWDzXtEHz3vUWCE4Lao53/aXvlKSbQREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:23:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:23:20 +0000
Message-ID: <7ce2d107-bae8-4c75-8988-31ee59c8cbdb@nvidia.com>
Date: Fri, 18 Apr 2025 12:23:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] RCU torture changes for v6.16
To: linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 rust-for-linux@vger.kernel.org
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:408:ea::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc1fc91-601c-47bb-e2e9-08dd7e9554ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNQelZGV05vdnIxR2sxWkpBaEZMNWxmeTZEbXVobEFOczJDcU5yRFZON3JC?=
 =?utf-8?B?eXZqbjYwMWVKR3NEMmhKa0tFcWl2bEx3dUhaK21EWGVzSE5ILytxZmVOY3hI?=
 =?utf-8?B?OHV1SXVCM25pQWtwTjlaWnUyVnFuMnhTVEovMURGY3d4cFVXbHJhUmcwRStU?=
 =?utf-8?B?Q3RhSkZoUW40eVZxU0hudVR6cjdWNVF5NGNkYnlibkVvajRLWFdrWEswNGFy?=
 =?utf-8?B?b3EvOE5VSFE5LzVBQi9nZ3Z5czVXc294YWs1eUlJbFZkbko5bEdmWjdPYmxw?=
 =?utf-8?B?Q2tacFJxaUVwTmlZNlpuek1LNjdVQStaNitLMXdCMjgrODJNUEp1SGFDd0Nm?=
 =?utf-8?B?c0tqR0R2WEdzcEpsU1l6OEVMNFJnckVjYWVsc1BZbmk3TFdSUE5iOHpIcFZQ?=
 =?utf-8?B?WDdEMWRzODJzazJ2WVZ5WFBoMW93NUx6U1NBWFN2YUR6NDdiMHFxdTZSQUpP?=
 =?utf-8?B?aGtYNkJjd1gwUVVpQWxua3hIUk1hMGdqZHkweTNuVHhNNko4ZWl2U0pBZms3?=
 =?utf-8?B?RE1OMWRmSzByLy9HWkd4THZ3MllnN1BxNWVYMGVQazhFOFJONlpOL0wrWTBN?=
 =?utf-8?B?Nk02RFdWZkxkRXBFTkR1MkhtMnUwT0tBQlc0STNNNjBsZXpvUi9ONUVjNFZS?=
 =?utf-8?B?cHVXZnlWL1c5TnlsUTNrRDJyRXBGQUpPSkNjSndYVlNXcUNRdW0xd3FyUnJo?=
 =?utf-8?B?K0hGZ1JlT1BvY284WEltNDhNby9JZzZCWUJhVHIyVytaK245N0ZCSVh1djFH?=
 =?utf-8?B?eXlnK0VpS1hOWnJWZlQ4TTh1c3dTcEZiMkU2Sk53ZEZ2eVlCVTY4emRROFM2?=
 =?utf-8?B?ck9uRWp3bWxRYVZ0S3NYYXduNmQ3VG5ieVMxbmdQS25Yc0p6aHA4S3E4RWht?=
 =?utf-8?B?dVMvRTljQjJXN29rWXAzODdDeE9kQXgxdUl1Z1NIZCtLR0dEakN1UllmVlky?=
 =?utf-8?B?SHo0N0Jqdmo2YnNJSG83TUxrUFIweDdGUjVtM1JHZHIzZ1JpNXljdnFmd1Rv?=
 =?utf-8?B?M3J2bzNCSmdiUk9JWWVGZ2U2QTB6aWtZdThERjRBQ1p6U0w4dkltSit5Njha?=
 =?utf-8?B?VW1HckE3ek55TVlSdlJXTzcxZElub294SG43MHdsTmQ0ZGJ3cTFCZnlhb2Y3?=
 =?utf-8?B?OXlCd2hCWk1UZ3J3emk2eklKa0xQSFhxOWFiTENLS3lIeVg5elBjcm5MMXN5?=
 =?utf-8?B?MitqSFNjaEpBQVBBM0dKbXUvaTJXbVlwVXVzanVwZW1UNmp0d0UrcHJOeWE3?=
 =?utf-8?B?Tk8xd00vaXFEcWdLdmZOc2pRNTNYVlZta25IUGxocTNvWHN3K3ZjWjhRbVg3?=
 =?utf-8?B?L1AvTHNzL25lSHRGMllhNnFIdzBoSndsTFh0aklGd0JXRklTYU5YakVjWm9W?=
 =?utf-8?B?SmRmMFhIaVExdkNpQ3NxeEJraVRMSk5PVW1ZdER0dVNxOHlZbHFCTXN5RDNy?=
 =?utf-8?B?MDFNVXhXT29CdTZTZnpzVEM4K2FPS1RwWldwbCtqV0hwbWFrZFpjM3FJdHJD?=
 =?utf-8?B?K0xBODM3eUxDU3E2dkhpY1VodUh5anA5cFB6Q1liOEJ3WCtIeDhmbTd5VUFh?=
 =?utf-8?B?OCszRm9zQUVQRFN3TFpjK1QvSlZiL1ZsbFNIUXJ1OVdYd1o4eitPWWdtL3o0?=
 =?utf-8?B?MjZvenVXZEtzdmRXRGcyRVJlOTNUcWh4VGJEMUdydGFlUXRBaFM0bEo1VFJh?=
 =?utf-8?B?NXpGSExIdHozVk9meEpGa3ZnZTJ6NGREZFJEKzdOQmM2WENzcjE2ZDEvY1ZY?=
 =?utf-8?B?anZmd2lheUY3SWJzMFpFYUxZS1VNbjdUbXQzN2ExVUEycVo3MHFLSUJUZ2Nq?=
 =?utf-8?B?aWZCRzdMdXJVekJ3b0hwb3NCMGRZUDI5REpXbDRET0Uvak1RVEdIUGVNNWVM?=
 =?utf-8?B?K3RuMGxjYjJhQmlPZHUwNGFJRFQ4ZWk0K3NleWlIVmZ1eSs2cjFJT0kwVTNE?=
 =?utf-8?B?azc0UnBscGpRT1BTLzc3eHhWbXpyMmdlc25nemxDdWF6Y3VsQnFOTmNsQmtk?=
 =?utf-8?B?WlJ5Z1YvaHhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnovRDl3a2MzT3QxTWJOTjVzOTNFWHJseFFzcUhjU1pJNk5EUSs1Ujk3dlo0?=
 =?utf-8?B?bkVlc2x6VDJQSXI5alB5S2pRU2RIVUQyeXg5ZEQycEZHT04zbmZyS3EzMndP?=
 =?utf-8?B?VVYyVk56T2Z6SDRqdWtsQkZvUC9iSkoxVE5TU0dMY1lISGM2RWJuNXZqcWZO?=
 =?utf-8?B?KzhOOWRFN1NaNkx5L05wc25LSHlQM29Fcm1Hb2Q3UmxOc1RNWVhKL1RiT01M?=
 =?utf-8?B?b1JBMWNHRVNoTUhnYS9ZR2VESUE3TC9aVEVNZis2ZStLajZwVFZHcWZKU0Vm?=
 =?utf-8?B?ZjNpUEErR0RVbTNnWFk1QmxKSHVVbVJ6N3A5RWRGY1lTNklXVG1mWXZ6Qmcx?=
 =?utf-8?B?K2xYMW5mclVKY2U0ZUxzcS8rUVF0Mk9WSUpsc1FOelhVcHZiVVczV2h4azNl?=
 =?utf-8?B?S29iaTA1SDFnZjFZYmpyZnB3RW4yQjBYSEFwVDA4aEFPYXZnWDAvdEFiSTR2?=
 =?utf-8?B?VW5peThVaTAvOHNsWkJ3am1paXp4ZW15citqSmpsTnFvTXZhemZLTXpoUkRy?=
 =?utf-8?B?Q1FsL2cyUXF0TFEwUzJ4dG1VNXR0bXdEMi96L0Q4b3JEQkV4bEY5Zk9PMVhE?=
 =?utf-8?B?OGh6V3I2R0FpRVZ2UzNwVFBxRUJBbnV0ZEdlTmtsMXZOOUU1bHAzNWtSd0Nu?=
 =?utf-8?B?VkhTZFQxMkY4eHIwSlhPMzRSR3ZtOUFDR2FiN2JYWlo2Q0R0cTE0eHNkYmNH?=
 =?utf-8?B?QzFLNnFtTkhBTkZEdUpOdGl3akhaK2lSQTIvOGkzK2pCVlBlYTc0VkZDNTQ1?=
 =?utf-8?B?cENudURMY1FTaitMVHExNit2US9UZ1FJRUlibm0xZzkwYm4vbk1xblpLYzRz?=
 =?utf-8?B?VXVuWlp2d3NyQWFpUDVOUitWRUREdHBSanpoKzkvZk8zN0lVNFJPMU5MVEw4?=
 =?utf-8?B?bDRxR241SnJvSk94TnkyMkZOTGhBUjBWZFVHU2k3VWlPeDFlS3REdjhlU0No?=
 =?utf-8?B?UC9taExtOXdXQ01Gb3o3V1hydG9NSkNmSDcyN3g2U3FqVkVlVVFLa0NheVlL?=
 =?utf-8?B?OGJvTzZsYWh4QnJTOExvdE96UDEyVWhLOVNZRk1UOUxOdHNzTHBjS1Z1cWtp?=
 =?utf-8?B?RWlLWEcvREQ3ZHhlalpYVjlCbjI0ZFRkbncrRmgxUDk1cHBtYTFQOEVBSjIx?=
 =?utf-8?B?aWYxVTZBSFN2VW5BRGVWc3pRWUZmY3FtTEptL2RYeFRkM2RWWmNpcDlQMit5?=
 =?utf-8?B?eE5RWmRBY0drb2JWT01oak93TnZiWGV5ZncycWdQWmlUK3hGdCt0WHlRb3FW?=
 =?utf-8?B?dHpZOVBnMVg1bDVvUW96cSt6M1Z1T3p4Vnk2UmQxdHVpRmg0SjZ0WWhnTzls?=
 =?utf-8?B?dG15ZVoxcGlHbElEcnBMVlduQ0Noc0tGcWk0cS9KTkxmRGwvUEdFYms2eXJr?=
 =?utf-8?B?UTJBWjl5K3p4WVBLMnJFTHV0N1NRdEp5dzY2UHVRSGhwK09JZ3U3L3R5V1k3?=
 =?utf-8?B?YlI3R2x0T2RLcUxHVmZ1L2JtbFRBQTdVd3hIbnc1UkNxdUxHTmFKNlBEd0J4?=
 =?utf-8?B?SXBEdkQ5RUVsOHJDbGlRTjdIanhwUmZ5SGFUdWhML2NBZUQ0Njl0QnF0NlRm?=
 =?utf-8?B?Y2k0RUxLVEluVXZ6Y1R5QzUxdEV5V2xOZUdhaVJ1MWRLU3YrVVVmUmllWjhU?=
 =?utf-8?B?ejNzNE9rZ3MxNUg0RGI3SjRmTzdidnFtcXVkY3JVR1JXcCtXd0V1SS9qck9R?=
 =?utf-8?B?cFVYbEk1UjdETW9BeFo2WVFseHZZUzlHV0xNYStzTGJvRWFSVTdGbkhDVmRo?=
 =?utf-8?B?QnZ4OVRkRUt2cXdYOHBnbEpMQWJxNEdjMUVpMWlaMlRTUktoRVFqTnhtMVB5?=
 =?utf-8?B?cVVoNWlsT3pWZHhtK3dzVWdrTEdnaDc0Nm1Wc1V3V05kbU5wN1hIRitXaStK?=
 =?utf-8?B?dWF3azBCU0FVNnB2RmtITElIWHZ6cGZNbk9zV0UxbmlmREhqaGdndGhmNldC?=
 =?utf-8?B?RlM4WWVOWng1dERrcjRxZUJISFEwR2MwbmhUaUU4akU1NjN2UFNudFlOdWVT?=
 =?utf-8?B?c0xha1ZxWTZXWU91MTBMVW9aVDF3Z3ZOTzVoRjNMTjZaUVMxdDZQVlVFdW1k?=
 =?utf-8?B?cVUvY0FpbWtUWkFyV2UwSFZEcHI2ZGNMQ0RldWRkSUNOMUI0QTJVVlJRcXlZ?=
 =?utf-8?Q?xyjwf4LtXUT00aiG17woY/sgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc1fc91-601c-47bb-e2e9-08dd7e9554ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:23:20.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFz1REFnkNzFYra5s3Vvf+mrS/MFsTNVXKB+bklwHHg4c9zJwZ195LvtqZmc1VsRrO5sHHCs7pHIGSnfEuITRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

On 4/18/2025 12:09 PM, Joel Fernandes wrote:
> Hi,
> 
> Please find the upcoming miscellaneous RCU changes. The changes can also

FYI: Sorry, s/miscellaneous/torture-related/ here.

Also please ignore patches with "XX/12" in their subject, that was an error on
my part.

The rest of the series stands good for perusal.

thanks,

 - Joel

