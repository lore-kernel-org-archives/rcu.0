Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B60346E6D;
	Tue, 23 Dec 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511010; cv=fail; b=a5nOlVJsdR1ejc7Dk2/g08MzsSwS8zuM5fi/LErrDbTHd0X/WaYBwp6X4QjDu8hmn/mPTQFGRiQc1UEYNRnZFkcOVw47HCPibFmo6sq/DVWmMmcSfdmaMUNskm/3qqxprB9cUYHeww067N1GWZBS1TKI9vLQW56sBW5fjBSYvOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511010; c=relaxed/simple;
	bh=k46ThUhUk7kxWVvmn6DMt8H5CoKlKkC2P1PhIZqtSSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aP69wLk9yEahrdA6+upAsnib5mKDsUq8qQG1TrjKCMYWyxspyhNRWEOHlNStXkT0kb2fThODegP0/XNxPzPFoPmvonJLN7xQq9xHEx14AQhOURWhQsxKYj4CwAHhwNtFjQnw52ZxgndT6sAfMYEbPvU6Jnb1oSShfjwO1+6blHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcKDfVa4; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcKDfVa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDF1PfxL4xoCvjGsxalSGQpVSB7S31tpsi+lRJjWGoS/hHiKVjDeDiFUPUbsA6QDxyMpOKmiX8skyoEcyLhL29fvEQOxQfBMPkCRUZQZygLMotCx1EBkCqNwC4lBFSAzjnjbVljlhctTWnPhrTznMc8raImitMwt20gyZd/HVlNf8wVqdwp0ZML0VRsvNku6u1suL1s8pNR9xy7VPN4mYBTnqNNPPkutKKdd3H/H8ARjlgav5sgt4SXdBzwIfBMq/lwDinIrSwkCWpLQcH7aLKx3Eqk+Af+T8ilIP5IrM8qoLy2Kdf+8XVYy/6hLQ93YtsynTvVEaKENxJ5ktbCu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94P/KhJy8hrv94Zy8M3nNsR8lEu/8D0H28AYcDJao/A=;
 b=hqVauFONFpFFX537zZw6VAY3B+upRdXAa9DeX0lcLItnZGj6LjosYrLxKtDpbnfsLDSNyp1otldRex4t4BsC2JdtLQneJt77Dh9QRA16iuCEYwcqe3wKqdgqoGvdNZs+yb4vFkEsavaTPSRHIEcjv4d5o+k5/pTHR0I6SMeLzdtn/Jv4cZec9SgAxxXgGlDoyWtltGAdsZcZv+AwfmHOTjvlk6Pejj89B9LOdat6rWxfhYFEFZfmsXq4n5po7uljZx4dxvBiE9oE86SV+VgVe6OkXkijEvFG8cpLfj1iQWI1zFhy86cJxXj02dzTi3PfLqgitB26ZrN11Rf8dIaFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94P/KhJy8hrv94Zy8M3nNsR8lEu/8D0H28AYcDJao/A=;
 b=GcKDfVa40xqjm+QPHiK/zNsZusqs8wpKF48yN0eMbuwD4pE5LNQ1MSPaWqcFMhfRhEje2uXyacUisvkF1V1Kch8Vd4Om1yKCRHERzl2AXhKCmuFRXn1h0UMZ8DESQv3dyHjRo0466k4JESUTsUVmIDpxdsCaOYhopgtnmiBJsBZoCyD40dp7jSvi5PO6zSvu6YIi6I6mWvo7tueC+GmwkpOJsTFd933/+1mDnnE6tCHvXheZHhK23W1fv1D9bMQCDZhRCnm5Hzbu4n7TPyanfBXB6F+UENACuDMNOZWaJut9yF7y+awDuIavxR2xaXquv1NAYbVVyy/9HBw8ZuHklQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 17:30:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 17:30:03 +0000
Message-ID: <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
Date: Tue, 23 Dec 2025 12:30:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org, clm@meta.com
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
 <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:208:237::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e09a09-03ec-48b3-b845-08de4248e7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlBOGh2dVpiTWYxQ005WnVRVHVVRkV5NlBCWGZnVmx2VnFZQ05pU3h0RFg4?=
 =?utf-8?B?V00rMEJXS3NpTEtreUlRenl1SURjRmFnYnlob2I2bXBaQ0hUdWUvTlYrSDZw?=
 =?utf-8?B?QTA5R3BhM1hsU3NNYmFCM041R2Z4dHduUFpXSU1SLzc1bUtDNlc5UElLSDl2?=
 =?utf-8?B?ejM4MG1CVDhDVThNSGNTOW5IelhtTFM2S05BYkltSU9mTmkrcFFMYSswQ1NR?=
 =?utf-8?B?cUk4bVNnY1J5NlNpd0R2bVNYVmR3OHRIaHppVlhxa2s5anZ4UHA1dzFQQzRP?=
 =?utf-8?B?Z3RQWjllRksycUljNENyc3QyQlU3RFM1cVZjbkR0QVY3VkxiRUIwQVZiVFlM?=
 =?utf-8?B?Wm4vb0VYeDl5UTR1UEZBOTAwK0l6M3VaVkVRczk0Y0hSZm01WGNMQmRXK2xz?=
 =?utf-8?B?djl2NkFZWmlJUjVnZzRLZkhQSnF5OU45REdEbVBUd2VkalFmaGdweUc0MmVS?=
 =?utf-8?B?bDNLejFpdjVWaUkvRUV1cmw3eEhLMjhpQTBSaWVDRHMvU2I4Qlo4eVc2YkQr?=
 =?utf-8?B?VHVsTEZWZGg2VE5XL0tOYWpIekcveTJST21sTlhMSmVXbURoWGN3S3dLdlRW?=
 =?utf-8?B?TWpFUHlpcFg1bEU0dGExbGdWZVFtakpyN2lhOGp0bjhLSVA0Z1NQaWtQT3NJ?=
 =?utf-8?B?K3lTdUxhNGtZYi9wSkhDU3ZFSGhmV29pdW5zVkpwczd1dk5DaytLUWFDbmpB?=
 =?utf-8?B?RWtQanlYcDY2bk9LQm5jUTBBaTVpNHdnRGR2QjNCMnNaV2JCRWFFV1FmUEpG?=
 =?utf-8?B?YTFRMyttZ1NvOTZHeFc5MXlJUGJacWJZUFA3RW1qeDNMUTQ5K0piSWltZ0Ni?=
 =?utf-8?B?b1Jjb25rc2RwU3Y1SC9rRWhLNEtKWU4rL0hjaGtRQUVhWm45VDNyaEI4emNG?=
 =?utf-8?B?YmpyZUpoZGtpSUMwNCs0WjgxNEZkeW1idHRFWlkrc01MS3JHbjYrSDBueE4r?=
 =?utf-8?B?L2huS1ByZ2YvRnlVNmdoeFptYS9jbEtkVjhXdVBXc01rRG03VG1XRno5Tnhs?=
 =?utf-8?B?TGdpYTRIamFuQVI3U0U1SXo3UUpQVGZ6SW9UYUdMR0I3c3VSNnFoR0dzRFRv?=
 =?utf-8?B?aUY1UGI0eFlVdFMrMjJpV3JJdTBiTWVLREtqcUxGalpBR0FOUVgxYmJrNFZZ?=
 =?utf-8?B?aDRmblNLTU03UXh3NlYrT3N2NS81aFBEdm45aGhNRTNIS3pKejY0ZkV5S0Vq?=
 =?utf-8?B?Yk11NHgyVGZLdjd4aXhCNlhpUDdHOFlNT3hIUnpZdGYrbGNqMlZaWWYwRlFK?=
 =?utf-8?B?ODBTMmlSbzE4ZCttaXhlWjdsQ04rZFp4TWN2dmtsWWxIODJkTnEvUWh0cG9o?=
 =?utf-8?B?SlNxZGhQZUo4OS9lRGpFZ1lubXBCMjlmbk5ic21EYThtcjZzSFBzdUs5ems4?=
 =?utf-8?B?WnlWVFdPYStYNElPR0VZdDh4bHVkdGR0TEZ3ako1OHBZSXM5Q0RNSmMvU0gx?=
 =?utf-8?B?VzdlZGxnbU1FUnNnbDdrQnF2bS9uZ1IvSmZEWDdYRGxLbDlWd2NmQndYaEZz?=
 =?utf-8?B?U1I1Yko1OTFNZ3QrZUN2Y3BjSDF4bm9pcWdscE9UZmpEeUpkRUJjSFZidTQz?=
 =?utf-8?B?Q2JJT29VRVk4czZqVnd6RzBTQnFTRjRIb2p5a1pCNnpDV3RJUTdBeENhQnVI?=
 =?utf-8?B?NEsvRy9rM0dIUHg5VHZ1U3VFZ05xMHdnZ3NhL0VHMjJsdVA0bVdMbHUzeTAw?=
 =?utf-8?B?SGNoVFVLU3dSZFpDSTVPRTJQRHhXVUtHZ3VheVgyNGV3WjhGck1teHU4YTVC?=
 =?utf-8?B?VktjaGdVMEVkNXF1T3E4YjZJdzgxWGR2Nkt3dkRzWEZURmdNZHFEZkZ4K090?=
 =?utf-8?B?S0ZpZC9EVE0xY28weUFhMlpFZTlkQU4rTDhhRlhYTnRId3FiSmlUMEs4TEEw?=
 =?utf-8?B?WHdmMmlyUUZJMnlINm11d2hzaGJuTldNOHIwY1RVcFpNWGFldDNpNDdmeUNS?=
 =?utf-8?Q?+dB2+mypOrit5yxtIkP87oaAC1HxM5df?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRJenhZZHRQZUZsUE1iYWJYNXhGTS9nV2ljL1lSOFkwWm9BaUlURkg0aUpv?=
 =?utf-8?B?RjBRT09WbVFuaE5lczBzdjVoaUZJaFNGNGprTUt4Y3MzdWYvZW5sRit5d2xj?=
 =?utf-8?B?NFk2NU90Nk9jRC9lYXgvTkdCckNVOUt0NmlGcDZYMnh6VTBDMjNoWjFLQWFL?=
 =?utf-8?B?YWNzUE5kcTVtY29SQ09XdU5HV2M0eXpEd0pjUzFiM1ZFQjJhNmdLV25lUklC?=
 =?utf-8?B?cFBTcW1VeTFaSVJiRkhpMmViOGMwbTkrbldtTkZOekFRNEp0dXRBM0ZsZm40?=
 =?utf-8?B?T1FDU3MyK3pLN0VFNkJKQkNNMXI2VVFkV1ZqQzAvTE44SFZWOTAxUUh2WGFO?=
 =?utf-8?B?VmlyS2dybTFGS2FkNkZNekx0MFFnVXNObVYzWlVuTk8ybUdRejNVNDJPM01j?=
 =?utf-8?B?TWZoNXRWTmthclZXVElVdllBRzFWQzh5MkF6N1RzOHFBeXhZcGMvUmFPYkZJ?=
 =?utf-8?B?K21wNU04UU1GT2YyYVRuUUx4ai9ZRWFIVTl2L2N1ZUtkVGtlRUVmOURjMzFP?=
 =?utf-8?B?SFFOQjFtT1d3TzJBL1doMGZZNDl1U09XWU8wSVloWXZyT0E4ZE5YU29GczBi?=
 =?utf-8?B?SWtOS0JEaERSUnhKNktuZ0FrTktSd1dYY0l3eW45OE0reDlFRTZLTENkcUJm?=
 =?utf-8?B?S0Ewa250cC9oMVhxeGYvbjNJVXdWcjF3QlZib05ic3M4eWdINnBCd2ZVMEtQ?=
 =?utf-8?B?RjI2bjM5c2xVODlMTlBTbk0wY1dQNm5uT2JTL3l2M3RaT21aV2ZrUVVQWnVP?=
 =?utf-8?B?TmYyQmdmTlpucVZpREtiOVJXZ1N2THJiZ3VYNmRaMGJmdlN6WHAxZEtLalFG?=
 =?utf-8?B?SDlSOUkwT3V5YVpqaXlPVkEzWHBPOGV6YitETzRiS3pRYTRoSEZkMEtNQks4?=
 =?utf-8?B?ditRdVgxWGxWbVk4c001Sk42cURzQ09WaW5oaE9pVlNmR2hkZzFEZ0JEZHB6?=
 =?utf-8?B?QTFZSmwwTjY2U1BPWXl6OTZLVGFRU3QrakgrZ0dMOVkwZ3UwTllKUytESnFK?=
 =?utf-8?B?RjRna1RxSFA5eE4yaThRZy9GaGU2alovb2tmQVNrMXN5RXIzVnlXZ1JVSVVz?=
 =?utf-8?B?R21IdGRyR1dZSEZGcE1oV3NXKzVHL3JDQlNXYmkzQW9zYVFOaTdDU3Z3cyth?=
 =?utf-8?B?eXJiMTBTMVJVY1I4OTd1TnNCbm96U002RzBSUUFqK2RWbS84RmhpWWYybkNv?=
 =?utf-8?B?R2lIU0V2WWtPbjlmQmFDbGE4alhOblZySng2eEtKYVI5ZHJHSWJDaGJObTZn?=
 =?utf-8?B?dFl4Q29kS1podnlxeXpyNmhlUlVQZEt6UW5MVENPcVc3RHZHekxSL29RNXpz?=
 =?utf-8?B?VnlHRUN5Q3I3V3dmd044cWIzZk5IY2ZuVVgyWmlkVmNkRGpwczJON0FUV3Vv?=
 =?utf-8?B?Zk9LYUovZllsMTJMQTVSVEtXSlBXYW1HZEY4NGFwb3VFK3RvY0ZmbzU2OUgv?=
 =?utf-8?B?K0ZvaXdkZmE3U2JicWViajBSaEQvdXYrbm9NVHlucDBDOUJObitlOXFRZDVl?=
 =?utf-8?B?T25weGd6cm9UNTFlQ1EvMUFzRm1xQXl5TG5KYTg5aTBCcytMVTNUOHhtUUdI?=
 =?utf-8?B?czdKT2dCYURoTExMSmU0RnRjT1E5Ym11THRvaU9OTU1LRWxnS3ZIVU1xS25v?=
 =?utf-8?B?S3NkWnZLSU00eHZtUmxNNWxCY2RlUjdkMGJ0K0F2aSs4djF4QVVDYTZuVXFC?=
 =?utf-8?B?cTBxL2lRZDh3TWJvNmpHa1lRRXAxWVYzbVpBQ29wU3B1WDdUQ1E2RVNxUVZ2?=
 =?utf-8?B?N0QwMmZTZUFMQWZ2d3pVYVZPNkxZdjlTV0xQVmlTdG9RamhOajZWRk1mVWpm?=
 =?utf-8?B?VW1CdVlnenF4WXlXV0xUdHg0NzI3enFnTkNaMkFwRFdDNmlKN0lHd0xoZG5u?=
 =?utf-8?B?bmk3TEw2RnVtQnNvdm1pU0hNWWZpUXl3S3Z5NEJPL01iYmJYSTdkVWs0ZWFz?=
 =?utf-8?B?YjVxdHhQYmtiQm9FMFdLb1ZSR1l1RG1YSG94SmV2N0NLT3M3bkZZNzgvSUpG?=
 =?utf-8?B?clh5Rk9MbmVKV1BFaXBSelZKd0RJc3hLd1F6bG1hOEFTbFRER1lGYTdzT0NT?=
 =?utf-8?B?SzIwWXBxeXpyK29JSGpySHZ0a1VtTXNDZllnUTU3R0Mra2FDV3JNVXhtNDY5?=
 =?utf-8?B?ODR2LzF2U1FvMU9HVHZzSHJEemlFMk0rRlZoOEU2QThRbGpSWEJuM1ZRV3Nv?=
 =?utf-8?B?b0lHWjB6N0kzY1A1TUN6bGUxemx3cDFWK21QUTYzS2Z5T3Z4YVp2QTlpQmpX?=
 =?utf-8?B?RjJSbnRoSmUrcXN3YVFRakt5MzNhNFhEUlV0ajJDSUl4RWRZelZRNG04UUJF?=
 =?utf-8?B?RFhGeHhCTXhtZUZmcnlsYmNsdnpSQk9YWWFlOHZZd28yUEtYTXdrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e09a09-03ec-48b3-b845-08de4248e7fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 17:30:03.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldqAm94ug1xhqFKJkDKM8udI1pXrjnT8Vg3U99a9KT1rAmy1+Z+BCPdBjcK7TpuromcbW6RUS9Flfaz/50YzLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400



On 12/23/2025 12:28 PM, Paul E. McKenney wrote:
> On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:
>> On 12/23/2025 11:37 AM, Steven Rostedt wrote:
>>> On Mon, 22 Dec 2025 17:12:18 -0800
>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>
>>>> Good eyes, thank you!
>>>>
>>>> Unfortunately, Chris Mason beat you to it:
>>>
>>> Was it Chris or his AI? ;-)
>>
>> Does it matter? It is like saying, was it "Chris or his text editor". ;-)
> 
> Adding Chris on CC for his thoughts on whether it was him or his AI and
> whether or not this matters.  Should he choose to share any thoughts on
> either topic.  ;-)

"Was it Paul replying here, or was it his email client?" ;-)

Sorry I couldn't help. :-) What is a Christmas holiday if not for poking some fun?

 - Joel

