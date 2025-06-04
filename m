Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0783C0C;
	Wed,  4 Jun 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000937; cv=fail; b=LnwB/K7lgACQIn/xeFw2CkO/zu5/7rHDYY1y+mcRBqxqFWo0MFm/0DCAb82vT6TtyDv5rJ4an5ZU8rrtDQODe1xiEEfDDtxmY8Ol+uxrUsEpIK22eBqCRaoJJKKspfkReTKm/IImHHfboW+ZXvMqM9OArwX8DYoJibsOXsYLUU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000937; c=relaxed/simple;
	bh=5g8swG0OasQPk+R9TExxSYlDY6szZCZL7ImolD0mCwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaE6RvJJQAnuomMtqNQhcyYto9EHAJRtlRD4vYAgJktVpB9UDJvJtvUkQ2CJwBpFo/QoqCo0o/3N0kG4aB2H0DD7osiZ+3QslwWsNlL4GHhkOBOG3GOY+9VVEAd4TGyt8xm6YZcfkmzfvcdz9wBBEA0FdLNguYda30m1kaIlLdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NOSi2bL/; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NOSi2bL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geqMsOUnZLIPZSNdP5EK4a2BfprzY6NEtRqL26HIUFHc0ylQ28Cohmg0wTxVuOAoE4SqAdX/RAwSObmNGYEOiF5osXW/woynkvyBwXeSK74NWYMVF2249UE82u0J1/RYRcZywDGH2pe4BPyKhKHBF4gAuJpFTTMaa4jXUOkcMGId3jjj3Az5laIHst1HXBk9rH3D6hVgE3bsO2+jZtJXSFkB0v3IVe5Q7Yumm+jzjmiQVzFWFZndMy3bv2XNTi4NIAv84JnNZzV19Z3uOoITIFP3WqbD3v+QNHU1JutIxrWvkMYiYcZV9ej5kKA9hOmdn/CVJ/cFHAQZmXDu4K9MXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by+hiweQhhBWB/LCkCsoWdM1I+DfV0sxRLMPjgGCGY4=;
 b=SUhx+U4geSabRTu7/BoKK9bkRKe23CLmchPZrw73y4TdR/t6zpIxIOburEuUoUFYTbheBd5hYR3ZxM25xqGg+jkA2IqFNFP3AinEw4hxc8W0L1yCHQRy/60s4FaLJsKsS7I/gfpomkq2fOfvI3FvPBD64lZZZAMR+GH0RezQVq4gzwY54tpoBqqM/LFYrmgVGTGwnqCN1Me+yMDRSA+aYs+IgV/NqFoALlr8LylFWMn/AYu2/p7H/Md8qoiJkA5OVIb6wmpduD+TdMADx1e9EYS3RusX7vRULHW2c24qCLDKkF7r9mGxJLWP0mWvioCV5Rkfv7JG4QNs9xZt3539Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by+hiweQhhBWB/LCkCsoWdM1I+DfV0sxRLMPjgGCGY4=;
 b=NOSi2bL/bcXbiKoDi3TjyKHeh29T6hnXGMESm+X4eAbLNDnUAphMXYW+fUcES9KfFDLAq9rCO0yBHcwJkvpB8HuMXuHdv1JCMKPNVkYxk6ctDWqCa96NlLtJlxGrdeR/ZUciGB7f4VIMu0qxQpMyRVchY8uG1fuUgObT91gTcMcFKJ/ddagHibe3DNBhCepdOCsSWRV/ItLHbfE1dSsr3x1Md6dY/Uwuua/yjpzTt66T1FKWysIvC1IMLlcw6A81eyzirH9RYCfrNIFfnh1GQP7vnrjByORY/OES0uNRjVRvM+O/TyB9tvJJAX0WFe6okKb0/3B7DgmDGB/w0YhSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 4 Jun
 2025 01:35:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 01:35:29 +0000
Date: Tue, 3 Jun 2025 21:35:26 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiqi2@huawei.com, "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <20250604013526.GA1192922@joelnvbox>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 126363bc-1891-49e0-f6e8-08dda308167b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGdLYmZkVnBBYXNDMU9EY0h4ak1pR1Y5RkxDMTlXdStCVjFmck9OeGRxUFBV?=
 =?utf-8?B?VldiVnJiaDJQL2tncWFnekJjMm94RG1HQXlDTFFqeWJSWmwyVEdVWlQ2djlI?=
 =?utf-8?B?RzZpclQyak9QRWliKzg5emxleDBrRmh0RGo2TnRSdkkrTkxEa2g3alF5ZmFS?=
 =?utf-8?B?eGJwZVBDVEt1M1c1WkJEMUwrd3BNNTFqTG12OUNvRjlMd0dzM1JGM1kyNXUx?=
 =?utf-8?B?UVpVcnZIaWZqL2pmdlRldjdsWjc0VDFXQjJYVStIS0xlZzM0TUJJd0twemFx?=
 =?utf-8?B?bUtrZEVhUzFxTW91ZStZSnB2VnVGZWtPUTNVbnNWZHcrVjRJMnBQbDlJQzJY?=
 =?utf-8?B?aGIwUmNHdmRrVUlHRC93azhYVHNZbDVXNGRtMlF1bnZmMTFrRkJxazJPVElN?=
 =?utf-8?B?NSt6M0VJVnZKd282OTlmTFhvWjhNUFF0UkQ1dGVOSisvdU9pa2p3Q2c1Qnoz?=
 =?utf-8?B?bG1vbklnZjNjemg3NGtwQjY5TUgzWGVWN24rM2N2dVo5aHdURzZoT0ZqL3BZ?=
 =?utf-8?B?NlBnMHBrOFNaN0JsZW1KZDJlRjRvVElFY2tIdkpCd2NFTU16Vm1wWkhRUGQ1?=
 =?utf-8?B?Vmhxam1hcVBzeW5PMkhONzl4QjRVOEJHOUh4MW5VQ1RWYWIxc2wrSDRraC9y?=
 =?utf-8?B?UmZXS3lyYlZtVDBKN2d5RUhsbVZvcXdvTmExUThrRytGT29nUC85UStSeE9K?=
 =?utf-8?B?cFo3V3BkS0VSeCs1L000OTgrdzFZV1NOVWdDWmJTYm1ROURncU5FVTh0d0Nx?=
 =?utf-8?B?Uy9HWHVYYmxqMVVIVVQ4b2lUU21QOXFraFl1amcyTnl0MFZ3T3JCOGxzT1hI?=
 =?utf-8?B?c2t0UzVvMTlkWXRJYnFYSmo4WGlveWZ1cVQ0L3ZzVlE0TURCcWRBTExMVXY1?=
 =?utf-8?B?eGY5dzFhVW1ONXJsZVZ3WHJlWVcvK29ERG1Xck5nL2NGOVU1bXUrUklKZW9T?=
 =?utf-8?B?aWFrSy9GQ3Brd0l5ZXBKTWRmUWFHYkxQYlNMWHppKzZpSlNHS3RVV2dDWEhK?=
 =?utf-8?B?SU5weVM1VWZOdVlrbnhhblp0K1FHRVVKODBnZlV5YXZad3I5NWJjRCtDK0VH?=
 =?utf-8?B?cTdEYVBMcWFrQ0JUaEJESGlKYkMvMG1mWnp6MkhuN1dxOTlsaDVGUWh1Vk9j?=
 =?utf-8?B?anhQNk8yS1J4UE9TV3FGbW5jais2OWRGUFJXaTl2cHlYcXlqMlo3YzgrVXZP?=
 =?utf-8?B?MURmTnlhZGlxWlY5bDRrU1Yybmh3anE3cjFQZzYvSVd4ZitVa0pRU0toaHoy?=
 =?utf-8?B?QWtZNm1MclFBUktlTldhNXJDdDRvcHFCbWowaHFDTEJuWENlelRYWGxBK3NN?=
 =?utf-8?B?RjUxVTVnS2hIeEloaDI4QnU0RXVFN0hxRXFicmxOc1YrTExlU1EvOTI3bzJH?=
 =?utf-8?B?cGtiUThHQlFIS09lT01taGtlL3NWZmFoMzdhR29EeCtQaURURi9kWXRxOTVP?=
 =?utf-8?B?L0MwZk0vNVhscGJqSHpFcVNHSTN3WXdTc0xFQ3JxdEtCOFFzVXBqZXFQZElD?=
 =?utf-8?B?c3p3bEZiTHVxUVM3SUtoWnQweVJyTnQ3UTJ5R04zWEtUbE1RM0VDcGt2ZkJR?=
 =?utf-8?B?ZkQ5SnhaUGlibVNiNXZtTEhObUVVaXJ5ZDgwdDR0NkZjeWJZVjI4SFh3TFIy?=
 =?utf-8?B?WFg1RjFGa3BZYnVJLyttM21haDFKOWVNZThiVDNKMXI4YW5wMGFyczZnUHdk?=
 =?utf-8?B?Qmppa2t1cXVPdysxenNsSFpZSXZVbnlIR3FFM2lXZHpzUUVCLzB3bHZBeEZV?=
 =?utf-8?B?cnlYSlA3aER3VmVaejUxQlBkdTRtRWNOZU81NlhmNlpqVTBXNG1rZXlUWERa?=
 =?utf-8?B?azl4QW01dGx3N2hDNEphckw0YmsvVjdhRFN6aU15ODg0UkxXSHh1TlBHeEZt?=
 =?utf-8?B?WTd3VHBPSnRaZlo5cXB2ZWw2OHlNRFVmaVBocWxpMURMTThQSTNCdmtrOFll?=
 =?utf-8?Q?s6qOUdi/bEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdIdU9wOTRNeGhodnlPcVp2SWNqZFRqdTIzOG43eFJLYnlqN2hZRG1naXpK?=
 =?utf-8?B?SVdUK3Boa05pMHl1bVlLRVFWcTdzK2t5MzNIaEVGa2RJV1IydFU0eTJXWCsv?=
 =?utf-8?B?a3JoenFmdjE4NXFqVTRkWDR3cytaNUZzdWFRdmJpNU5RK01Udm11WUhIOXFp?=
 =?utf-8?B?bVJPazVKNmFQMnJzRW5uRHhjQk9aQlQvYlRMaFhTdyt3N2lTbDUwb0ZFbjlJ?=
 =?utf-8?B?d29iVE94SjRLbXRXelBFaHI0ZFNJVGh6UHgySUs2bkUxUzRDbERMYXlLNTBz?=
 =?utf-8?B?a01BdnM3cXg2bk5YQ1lhanRwWStzZHFWN1poTnBsSlVnQlJpQmc1dWMzVVcz?=
 =?utf-8?B?aFdUNmZRMG9wcVBDVnNOYUxBeWNJY01GL2JiT2Q3R2p5V1RHS0ZLQVhnQ0t3?=
 =?utf-8?B?V3BqWDZOMkV3b242R2gvWFlTTWNuNFFIQVNHQ2JCVER5eXZsblpYa3dhSWpz?=
 =?utf-8?B?QndJUjdhT3pNaU83a0lwb2gzQTVrclY2V21KU2o3dXJFcTVlWGJob0g5TnRB?=
 =?utf-8?B?b25iKzlNOHhIWHY2RU1BTnZsQlJmeU92UkpWbHJCTmNJY09YODR0WG80ZGNI?=
 =?utf-8?B?K2UvbkF2T3g2MVRxaFNxV09wVjBzMTZNRE54cFpGY3h0Tk1ubmdpZ2J6aldn?=
 =?utf-8?B?eG1xL29hNFgvbXR0UjBWcmt4NEtzNDlYWm95Ykc4RHVKSVVSTzFPRlp2OEp5?=
 =?utf-8?B?aEk3YnJvRE1SMjdqMXBVTFZJWmxKcWI3a1gwUEhwV2xDSlh4ZlN4SGdMUEJK?=
 =?utf-8?B?OE5BK0twWWhkY085ZVB1M1FMM2hJdDRzU2hYQXJsUlo5NmY4TEVsUXdMbmI3?=
 =?utf-8?B?eHhOVGxPdnc1OWFucjhiNzBKYk9UZFFUMUNzL2RnWVY1Q3lXNHZiZmpvTld0?=
 =?utf-8?B?OFROMy9GZUFDR2JJck12VDFFZTd2RU8rMnZ4UXk1YlFzQTRjaWllVFM1cFZB?=
 =?utf-8?B?ZUhhUWx5blNWTE9TVkppaTR4bFBGYnU1cmptMDdLN2s0RWwxMmNSQzFxVnZ2?=
 =?utf-8?B?ZFYzZzVxeXRWN1psYjFZVFNRcjcxWTBlalR4WW1QUFNxUWg2cGdGY2pHS0Fn?=
 =?utf-8?B?cmRQTWw2SnZSdHZGYjBpMzVDa2kxMDd1Nnc5U29BQ0ZWNVpUMEdlUjBnQWpx?=
 =?utf-8?B?OHZubENNcEEwSlZCZS9iZVoxZnBsWTkxVmtLVmsxTWNaejk0WURFWk1hSWZ2?=
 =?utf-8?B?UmZIOFlvRmhsdHBaOEdBN2ExcG5kUCtCN24zZlNuRkh0NkZGaXdEYkdnUFA3?=
 =?utf-8?B?Z3p5RDRqWlVCRlZydlRmdEZtRU9LL09IU3JtbkwvSlhPVm9hTmtBY3pjTUtH?=
 =?utf-8?B?ZnFOWVlOa0V2enBDSFlqTlJWclNPWGlCdGhpU3BmTEdkQ1VWZlBkTEtGKzBx?=
 =?utf-8?B?NDc3OTRBTmlJendCem92N3FOcUtaYzdMZDR1RFh4U3YwaEMrQlIxUmtMRnkw?=
 =?utf-8?B?RktpNmQ5K28xNlQyZjI4WWYrcnFqRXZRUklIMjRPUzdvc24wbzUwcVdyVFRy?=
 =?utf-8?B?OHB0NHE3WjZRajNXTE1YQWlNcHBnY0pMVnFRRm5LUHEyOGtUeERKMWY0OTR0?=
 =?utf-8?B?Mkl6NVdSbmhDSFNaTGVCb3ZjcmpqSDBBTHlRclBjcVBhaXQ3cWIyaWtnc0s4?=
 =?utf-8?B?SkpjSExxdXpOb2RUdDBpSFUwSEZFREh3K1VxQXlya241UGFHYVVWYWtXUzM3?=
 =?utf-8?B?QXczTHQwdHNYdmRjNUo0QmswV241M1haejNMSmloVlVnbjVLL3RWdjJraHBu?=
 =?utf-8?B?amNxamhWZUZHVEJqTVZzeDM4QTVWSXdQK1R6L0VBMFdhRGlmSk5IbXF4amdP?=
 =?utf-8?B?Q0N1RXlneURydXd5anU3M0poWUIrbEwrczR5dGM1eGI3U0d5R2p4eXRPa3dQ?=
 =?utf-8?B?SmJHTVZhYy9ZaFViaDJteGpXWXdUaytwRDV1YVZqbTE5cGdNV05WZUZJNlly?=
 =?utf-8?B?Um1BS1dBV01ocVBFbVhTVDRremdjanJaV080SlJPcFZDQnNxNW9jVDV2ZFky?=
 =?utf-8?B?SDMzMmZPdEdtV2JXdTZPVWJpT0h4ekllK2V5dG5zMzNZK2kybDdhQ1hHVFBR?=
 =?utf-8?B?ckxyUUMvWkduekRVNFMxcVFpUGpFVGZxMStDRU9VMWxCLzZMK2lONzVnc25G?=
 =?utf-8?Q?EnHG5SXb5DRZ64wb4zo8yQ61b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126363bc-1891-49e0-f6e8-08dda308167b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:35:29.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czHrQqhz3CCa1xL/+GoWkjGJ3MY3ToPTJaI2Oe35vOd487CBR1n4vH/yf/MvhLIs5GcWyPsnKqczJfpZpEQKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

On Tue, Jun 03, 2025 at 03:22:42PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/3/2025 3:03 PM, Joel Fernandes wrote:
> > 
> > 
> > On 6/3/2025 2:59 PM, Joel Fernandes wrote:
> >> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
> >>> Hi Joel,
> >>>
> >>> On 2025/5/29 0:30, Joel Fernandes wrote:
> >>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
> >>>> <wangxiongfeng2@huawei.com> wrote:
> >>>>>
> >>>>> Hi RCU experts,
> >>>>>
> >>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
> >>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
> >>>>> The issue can also be reproduced in the latest kernel.
> >>>>>
> >>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
> >>>>> But CPU1 stuck in the following dead loop.
> >>>>>
> >>>>> irq_exit()
> >>>>>   __irq_exit_rcu()
> >>>>>     /* in_hardirq() returns false after this */
> >>>>>     preempt_count_sub(HARDIRQ_OFFSET)
> >>>>>     tick_irq_exit()
> >>>>>       tick_nohz_irq_exit()
> >>>>>             tick_nohz_stop_sched_tick()
> >>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> >>>>>                    __bpf_trace_tick_stop()
> >>>>>                       bpf_trace_run2()
> >>>>>                             rcu_read_unlock_special()
> >>>>>                               /* will send a IPI to itself */
> >>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >>>>>
> >>>>> /* after interrupt is enabled again, the irq_work is called */
> >>>>> asm_sysvec_irq_work()
> >>>>>   sysvec_irq_work()
> >>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
> >>>>>   __irq_exit_rcu()
> >>>>>     ...skip...
> >>>>>            /* we queue a irq_work again, and enter a dead loop */
> >>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >>>>

The following is a candidate fix (among other fixes being
considered/discussed). The change is to check if context tracking thinks
we're in IRQ and if so, avoid the irq_work. IMO, this should be rare enough
that it shouldn't be an issue and it is dangerous to self-IPI consistently
while we're exiting an IRQ anyway.

Thoughts? Xiongfeng, do you want to try it?

Btw, I could easily reproduce it as a boot hang by doing:

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -638,6 +638,10 @@ void irq_enter(void)
 
 static inline void tick_irq_exit(void)
 {
+	rcu_read_lock();
+	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
+	rcu_read_unlock();
+
 #ifdef CONFIG_NO_HZ_COMMON
 	int cpu = smp_processor_id();
 
---8<-----------------------

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] Do not schedule irq_work when IRQ is exiting

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/context_tracking_irq.h |  2 ++
 kernel/context_tracking.c            | 12 ++++++++++++
 kernel/rcu/tree_plugin.h             |  3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index 197916ee91a4..35a5ad971514 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
 void ct_irq_exit_irqson(void);
 void ct_nmi_enter(void);
 void ct_nmi_exit(void);
+bool ct_in_irq(void);
 #else
 static __always_inline void ct_irq_enter(void) { }
 static __always_inline void ct_irq_exit(void) { }
@@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
 static __always_inline void ct_nmi_enter(void) { }
 static __always_inline void ct_nmi_exit(void) { }
+static inline bool ct_in_irq(void) { return false; }
 #endif
 
 #endif
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423..8e8055cf04af 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -392,6 +392,18 @@ noinstr void ct_irq_exit(void)
 	ct_nmi_exit();
 }
 
+/**
+ * ct_in_irq - check if CPU is currently in a tracked IRQ context.
+ *
+ * Returns true if ct_irq_enter() has been called and ct_irq_exit()
+ * has not yet been called. This indicates the CPU is currently
+ * processing an interrupt.
+ */
+bool ct_in_irq(void)
+{
+	return ct_nmi_nesting() != 0;
+}
+
 /*
  * Wrapper for ct_irq_enter() where interrupts are enabled.
  *
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..a3eebd4c841e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -673,7 +673,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
+			    !ct_in_irq()) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-- 
2.34.1

