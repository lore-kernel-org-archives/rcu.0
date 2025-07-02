Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847630115F;
	Wed,  2 Jul 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477047; cv=fail; b=RGu1y2UpxjyOS0oxStAWYiaoZ2AywFc/sLTXAUYPchOObT/nAZzLMl8BUSPMfMR89GkGgDaDzdFGeADdqhM6NZ4VhMImeQ7JT78swES+oPLk8rIe0a3+1sNM/ko2Rgl5bZrR66fcsoZ4V2EAsVpDhseNmg8AjaH/2xtRSIBkn8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477047; c=relaxed/simple;
	bh=PUzsJfSfqvIBidNrXY6otpw7gEtvxvfTTN4iQrhae9s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePfZuQX1wlP3QWqAraWDga6UTVX49c5NtNNK0L9nXMmI/Zo5gpYv8ddKB4mWLUJvHMXlT4yO+oDvLqAngQUYY0gdidu1G82VyOhuQ7MxpZVVtZAXJU/+TjfKnnL58vYzR8tDWhE2UMEI7cV1TANSNxXYm9lDBljRAuy4D4MYJ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEoUn0ah; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEoUn0ah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLIDQwJUdYzfxW8Ws4HF0uqpY+rV4cghR5qgY0cS/qC9UVJvjpJ1y+BPsbxE2rB8xMtV9cwFYFzXxWjtLFUAdoGFI9rYPlmdG7QjclyPiQvJWWE2nhY1TF7SX4nUTNAPliutV7DsFdChKnaXttKvYckLYFv2DyENzB+4jdNiQVLkCNg8TNgV2zSkOXO0upXgiy+gyTjZ3TB4s/lrBZeevUoXrPm/wFmGyuJPm6ruPeR+Fs0ItZAAeB1aBu+BO0lkKWDK/87IO3pA4imykzn5v7PyEjEJBgGe72v7QQesxd2tyJvvgT0DRPJmN0ZAtdUM0z8FNMBfk10Byi2wJ0NHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuJrrjvngbNPnVBWP3h8EWrRGaY20L2HEsGmfNElbac=;
 b=spyM/jHWrfg+GUXa+cGSQRaweySU0a1daQU/sPpRZqZl548P/kWnyjU59Dk78MoCB6MXUj27g/BMeXMZZzrpMYQQbEmhfpvn7k2I3RHhrI3c6NKjXqTRkwYpt5gPcOIcZQfVxBIZUl3cyd4TLJy7TrxqGKgxi4DXyDsHF/YPYKfaTalTGaDUphDGr/Y8lQhIcWM17FPlhcHqcOb1RuVBO8P8QSElwTwJbbPnH0zfKaHZyROmC1ISwA8b3OmsTZoj3De3BTqWw9H1xAm+QLglOz/NrTAvrQGPIh22R+kmuYpQZmKnAXja4bWm8j7+FpU6bTk5qOTiecWViY+zMuMr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuJrrjvngbNPnVBWP3h8EWrRGaY20L2HEsGmfNElbac=;
 b=kEoUn0ah9KhQTWo0QvJk+Gx+ku9whrqmS9WeAQLU1QBMjeT0X+4X9EWnCEZWouBOHYId4ajKjkMI5HdCpfdcBCS1/sj7S5Wno36iYrKAGf5Al6U5756p//ZbuEEuGe09f076FMKdTNL9QxDaHIoYuO9TpfwJuOKN5iiF7DjhjdGJZ5tbuCVaUTAa1ZgzFZVB/0lIsrBqW+rhq0pj3OUvLyLnb1+XlUfGpz1FJqFx6HOURGm+OTWYqUEUhIfKZGIz8eq7VStC026y4z/2D/SzbMZBqDRkK1LPLTjSjDDnTaJA3/GwbAuw3pg/LJxzK/UVF5xlkpu+/xQf/FhYMe6Zdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 17:24:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 17:24:02 +0000
Message-ID: <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
Date: Wed, 2 Jul 2025 13:24:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Qi Xi <xiqi2@huawei.com>, paulmck@kernel.org,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org, urezki@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
 Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
Content-Language: en-US
In-Reply-To: <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebd29ae-e6bf-4570-ee19-08ddb98d3d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGUyUnJYYlQwQ0tGQnZ6YUxKQkd2SFgzY1hLZHhZS2QwSExqZ1pSUWVaUzl1?=
 =?utf-8?B?dXkzbFcvU3hyZjV3Qml5cWgrYzhGUU5aRXZPcm1VNWk4cDRpQTJZcGg2UlJt?=
 =?utf-8?B?ZE44MmRBdndydG9CaFM0ZjNzeUVjbzZlVlJ2dW9VZTVmNlJkdEVkYnlPQWhL?=
 =?utf-8?B?SllaZGZPeGJPdjY2ZFhSWjd3SEQ2dkQ0dDhmaW9TUFNJdFlORDJ6NURLVFBL?=
 =?utf-8?B?NG1UNFcvU20yOWtSL0QxWDdBREpXY1lDT2diK1dmYytvdEZUSW5POUtoWCtw?=
 =?utf-8?B?N0pRZ0lZUnE1d2xST1o3ajBUTXpucnNYV2hvYWwvLzgyTVRjeU51clFmK1lK?=
 =?utf-8?B?TlNjd0JrWXdwZ0ZhWm8rYTYrOGR2QTI0aXlZTWh0K3Z5eE9mbzdRRVZoVHFQ?=
 =?utf-8?B?RVhyNWRnMlVHK1BkQnpqNzdrUWwySmduOW95bGdRbk1KeHdUbHpqa1JOSlR1?=
 =?utf-8?B?czNHemJ2ZlRoNWR4OFFiaGkyb2lnTlBzelNpZjBCUURHSmRNdzErdjlrclNa?=
 =?utf-8?B?ZlcyMytsdSt6VFNmQUlkV1U0NkdqTDBsY0pmNEZzOUt0Rnk2SENHOEZLdmZB?=
 =?utf-8?B?M0Y4bVlOeHlkNFpoMVYwSzhWbVhBNHZaMndENzdmTU1mL1E0dEtJRDJkYXA2?=
 =?utf-8?B?eCtDdklGei80VkFybXp4L1FoYjhFM0prZTRoLy9KWnFPaTJJa1I4MGNSNHVX?=
 =?utf-8?B?WEFSTDg3Z2x2TS8yNyszQy9GTlBPb1JmMGhseVIrRklCL1d0YTNzNVNTRXdI?=
 =?utf-8?B?TXBheWkvcXY3Vktvb2JRWE40eTJraUhpSlFvTDRycG5GU05tc1ArZC9uMDZj?=
 =?utf-8?B?dElwVEdZc0Z4N3lLWVJJczVqanNpSUtDZDM4b3dsVktSNkFMY3MybHVDMDFr?=
 =?utf-8?B?cGJ1QllxVjF2bFIvNVhNQ0M5dEFDQStLNHRyczI0Nk9BSjJkcml0MWVQUEpu?=
 =?utf-8?B?aUZVYWJYUDJlTStsS3grVC80Q216aStHV1lLTEdSTHIra3paUEhTbXRibHln?=
 =?utf-8?B?eXg4VU1QSkJ4VlRaQVA2S3FDdDd3M04zRE54eTNHaHBkeExhVXZUSlBvSmVm?=
 =?utf-8?B?eEhtQWhvejlnVlBTNTQyU2QzbXg3bENMZk9KVUxkekkrdDVlc1lOYWdGaDJw?=
 =?utf-8?B?SzJOSmZZaG5SZ1F3Y0w3L0svaVY1N1hjQkNxOXNhRXRZUVJFRXpMTHpXdFYx?=
 =?utf-8?B?T2hnUENoNmQ0UFp2ZlIwOWYzTTJMMmJxSFlubHNQZ1RZUmc0aWEwSld5d0NV?=
 =?utf-8?B?TmYxY2pMS0Q0VkRFRFh4YnJhVEM0UkZJa3lNY00rNDc0Z2NtZWhzdTZGU0E2?=
 =?utf-8?B?aCt1T3RzL2EvdHpXUXUzQVNzRFUyMWtITXdZa2w4N0crQy9zRVZZMjBMTDFo?=
 =?utf-8?B?Qm5zK3NmQXArNFo1b1JMZG9TaUVzVnRoNFhCV1pIZWQ3a1BrZ3NpUVFNYkZX?=
 =?utf-8?B?T1Y3Wlk3QUJFZGNxRVdKSU1IUmtEMktNR01WcjJGNEs1aWxKSWNvTzQzVmc0?=
 =?utf-8?B?eXQ0TTQ1ZkFTejQ2M0MybTlDT2VsZXEzQXNmdFord2hvSC9mWGlZRXhEVFg3?=
 =?utf-8?B?QmU2aGgvNFIrMGtGNWhUQ2FlWnVib0JTblh6UWxOMFRSVGZkdFlEYWRQWVhp?=
 =?utf-8?B?RUhaSHo1MDhuUmtOMm1Cdmo2YzJJdmdEOUpCMnJ3T3V0Uzl6T3VNR1E3ZzVV?=
 =?utf-8?B?WTJhcE9yTkdTV29HL2RVNlZadTkwNmowR0d5cEh3K3oxVVBNelFwMGxjZmJy?=
 =?utf-8?B?TEZRd29va01PNHZxMEpjemFtazdCMnQxRklJWllLM0N4T2o0ZE0xZmppcDVZ?=
 =?utf-8?B?UlVnT3paVG1qQkI1NWg4WFViSXhKdVJtcEZ5UTlYWkF4L3pGVFBLeVU5VE54?=
 =?utf-8?B?MzNQYlRNdlVadVU0SkQ5eGdiODQ1eUNpeTlCMndEcEtqNFlmT3NlYTlBSXFw?=
 =?utf-8?Q?pz5xCAMOHdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2t6TFdCWnJMNlBLTHdLcjlBY1V5bnpjQy9GL3NsYzFhR1FiTWJLcUcxaWM0?=
 =?utf-8?B?cWlqZkpGdTFhMk1ZZ25hNHhBSVJEUnBrakZWZkZ2WUg4WHFvdDVONmtQQURy?=
 =?utf-8?B?dWNHY1ltemc2QnBLTzJlMW1FWHZGQ0V5V3lNUkl4MjU3UFlJZlIxd3ByU0ti?=
 =?utf-8?B?UjRiaEV3Y2VhSHhuVWd0SlB4elZIVFdPdktBVUF6cGMybWdWcDgvNEJBQ1N2?=
 =?utf-8?B?bmF4VDF0VHhOMTRQeEY0dU9hRnB1aXdqV2VCT1E4UHFsbkJ0U0E0cUJPUnRp?=
 =?utf-8?B?c0N2bFNHS0F1THh6ZGpLKzRTYW1DZlYrNEtmWCtDdE4wNWJYTEVDVDZ2Q3p1?=
 =?utf-8?B?WkVMcDZxRWttK2cwQmhpazQzZHRXRVIzeGtlQUdCNnhzc0swcUNhZ0o3NHNz?=
 =?utf-8?B?TUFRanNvcldLNjVSeTFjVXBHN3d0MUs4ZXkwVUxBUzFSNXkzbjc4YkllSlVI?=
 =?utf-8?B?eFhMQk1tckZDQ3orcmhKWlhvZlFHOVJ5MDlqcDh4b0NQc1MraDZGZU5zR0JV?=
 =?utf-8?B?V3FVK3RSRzNXSXlHRmJVWGJnbi90UFNTUlpCOG5vL0xYUGgwUVI3eS9sT0tm?=
 =?utf-8?B?QnlIbnZPT0Y3VHl2RnZ0T1ErYTlPcjZwK1l0RVFacGJRQm53U1U2NEFDMXQ1?=
 =?utf-8?B?WEJXaHdRKzN3YTZtTGk5QTdyaWtoNXpwMXY1RXZLelR5WC9KRS96a2xtZ1Bz?=
 =?utf-8?B?RWMzSmp6OFFIM3Y2bTNPNVFVcTRHRzN6L1UvMDFQRExyTVhWZFhhVCs5S0Vu?=
 =?utf-8?B?dmwyL0gvY0hvV1FpQ25YN2hHcm9qYUUrVURTUXprOXNOTHp2d2lrdjN0SjQ2?=
 =?utf-8?B?R3A2Z3pPa0djMkRRQVFpUi8zSHFvMkJ3N0IzSDNvdFQ0WXRhSE5ud1U4Wjcr?=
 =?utf-8?B?RUNNMW9kdFVEaVVRV0RIeG1ha3oxeE83QkczMzQ4VmtRVjEzSjBYUVp2TkR2?=
 =?utf-8?B?WGw4a3U0UDdvSThwMGZuRjcwRjVERkdBT2R6djd4K0tRY3FCNGhLZ0JadXZN?=
 =?utf-8?B?R3lCQW1aMXJmM29WTmdaL0IraGh4OS9KMTNkb1ZFaVR2TmE2OWNHUlpRR0RS?=
 =?utf-8?B?SjB0VTNKaDFBOWYwNmxyZkhLMzBpL2VzRmRqSUkvb1FNNXJjVVRPT0pGUDZn?=
 =?utf-8?B?dDZYSjFGRWxPQ3l5Z2pjbG9EN1VScDZBbWljemo1WVhZeE4yYm5CK09mTjNH?=
 =?utf-8?B?Nkp4b1NQZHJpZnU0WXhUUmo4MUx1YmdoNTNmMVJ1UlRhZVUwM2pUUE5OUjhh?=
 =?utf-8?B?ZFVRZlA5NHVvb1pyaWRLNXRhMi9qanhlWTRTN0VIclpPVjI3bEZUVmN0b3Rv?=
 =?utf-8?B?QjJXSjFWWXR6d1RmeDYyc0lsUG9zWmdGVGtXN2drWjdneDZyUVA3UHd4OTlP?=
 =?utf-8?B?ZnVyYnBCUHV2Nk1UaUhkd2gwWnEwbUltY0w0blo0U3c4V0lqVEVYQXdHR1NQ?=
 =?utf-8?B?UmxMaURMTk9CbVlocTk0NXQyV01vTjIrUnFUTW5Ybk5IRi9qOU11UmdvVzRo?=
 =?utf-8?B?UGVmbWhxUjVBN0NuRmlkTUovM0NIRldkWHNZUXNOT1VCRUxMNUdVZ0E3WlJn?=
 =?utf-8?B?dlBmNURXL1hSRzFZS29OTWQxQVpKY1M1aG5FQWcwa3VKd3BtMmY2bHo1dy9H?=
 =?utf-8?B?ZCtuTVdjOHhpTDdhR0FNajlod2pHMDdaVWhlQ3dEQ3RDU1JuVnljbldmN1RC?=
 =?utf-8?B?dmdPQzZCVGJqYjgxWExKZ0ZaVVQybEp0REZHQkJSa0Rsa3hUTWpGVEJTUktr?=
 =?utf-8?B?NFBwdXU4dWx6MC8rUDd5WjNvTU02RThibDRxZnNtbFVxWmtGVWUybFZLYlFz?=
 =?utf-8?B?cXRiZjl5d3pZclQ2Z2tzY29xRWVuRVRjSVBWV1VBWTRWVUEzZ0dLd09rWmhI?=
 =?utf-8?B?UmxmcHY4RytDRWNxL2xodjR0MDMvZDR5MDBtd0p0T0F5MTRVWURkM0s3RTI2?=
 =?utf-8?B?czRBNmFXcVBITXQ1Yk5WeDdpSXI5YmVwWHhvbjhDaG9oRko0QnNkbTVUVldk?=
 =?utf-8?B?ODg1ZnZYSkk5QXQ3SzQxT1hyZitZTFdWR3FXM0ZNQmNMNHNHS0Y5YUJxQVJH?=
 =?utf-8?B?RXZra1RtN21iYks1VFR5RkpaZmNVdUJ2TnZxQ1BGNUh1M3FZOVFaMWgyQXBv?=
 =?utf-8?Q?nky6gVxPUs9CifYe4CFnb0iVm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebd29ae-e6bf-4570-ee19-08ddb98d3d20
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:24:02.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B9ghDPbzXmJqgmWXEhrg+9jIJg/9a2CJ9RkfKKk7nb7EkbZV8Qdo8n3vSnTnlrlTivd63JwKKR+1Y2NEWXU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728



On 7/2/2025 6:59 AM, Joel Fernandes wrote:
> 
> 
> On 7/2/2025 5:14 AM, Qi Xi wrote:
>> Hi Joel,
>>
>> After applying the 2 patches, the problem still exists. Compared to the previous
>> fixes which did solve the problem, the difference is ct_in_irq() in the first
>> patch.
>>
>> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
>>
>>
>> (previous fix: problem is solved)
>>
>> +bool ct_in_irq(void)
>> +{
>> +    return ct_nmi_nesting() != 0;
>> +}
>>
>> (current fix: problem still exists)
>>
>> +bool ct_in_irq(void)
>> +{
>> +    long nesting = ct_nmi_nesting();
>> +
>> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
>> +}
> 
> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
> version but applied an older patch. I will fix it in the tree. Thank you again!
> 
> Neeraj, would you like this as a separate commit that you can then squash? Or
> could you fix it up in your tree?
> 
Qi, Xiongfeng, I am currently working on alternative fix after discussing with
the crew. I will keep you posted with the fix, and would it to be good to get
your testing on it once I have it (hopefully in couple of days), thanks for the
report!

 - Joel

