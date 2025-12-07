Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A181397;
	Sun,  7 Dec 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765116079; cv=fail; b=D4JFC1PwPTJDjqf31edgP5len35TGDOJH1gyJSpoyMDLhKFNx3DgAu0U7IRRKNc1w6nqulBmf3jqu7U9cSZ68mRyOqj+UULYz2Nk9i5ziCjski+dBCOWuK78EvI49A46m6/U4vs1//FkTCdYQ8R9mx+KBe9Eqdi+MTx6jMteI9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765116079; c=relaxed/simple;
	bh=scXEiNv081DSUojt9ezGbXF9+7hJTUEu2GeX2IK0kac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdunGbt7DcC3Fw7LcQSWzV5jRIdxjYHco5GWWXXqhpJQnBKLsd4uNfgPuTFX5b7liztbF6HvCE58FQCxHthqWDLvj02LR2YTyaldzxgcz5vKjONj7vvsXcu8cfes6+qoAVCEYMPHBByxMMu6PZKpKO1xPKGlVI/lldDouaFH7Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P3XspOoQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TXTwy+qa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P3XspOoQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TXTwy+qa"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7D7FlF377192;
	Sun, 7 Dec 2025 13:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sRMvZAf5h9UR6KAIkN4cXgxgRRwhR81VYk21ZZ7xSuA=; b=
	P3XspOoQyHqOXKEEyYGtYe3LTmBdjuesL4VPLZkErTlnjXQi6bY3VW1uF++GWfkJ
	FspAYovrVKaSnF00rjPQIb6FIKcNiuPCVC/ipayNk8FB9qXkqgEZ8MEzxkK8WkiL
	6e7mn64WVqWeRzi6ftnuPsqhK2/LFDh9Ft5hsXAzvKF0m8IjMLjWnQ0zdQrmD0ZO
	HTolA+odlHXA0NJtiji8xiJw/iCCucqEx1j4w/Jb/nUGic2ulnm1RTweb3ih+Uwf
	C79OnE9DeU0SNNekH9GUjigKCv139JmP6zdOZ5Hf9d6dUlbG+V6oyl2aLd/joU/G
	i9Tim9b5254q1RijBaw1Lw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4awa6500q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Dec 2025 13:59:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B78FqL3020832;
	Sun, 7 Dec 2025 13:59:43 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avax6vw0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Dec 2025 13:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCdmgzrPa4usF26Nr86eNwgyCipKHlA1r5wa5gOg84rLB8vP4triJG8sEAAiMJ1GirJdh8eqfUjZtz3lmywTK0f4ibbN66Kt/sx2SK2wDx1ShiqkqM3R/aqE+OOV1lT6IzUC1is2CGCMYqgvb9jqF/lAcX76I8uIeGDgZ6npamaYpJu3R03wthhZDlo+UTfh761z2WHf151HlYw2xzyMhypUrMg9MNDaN3JOR56ZqfyMiZM6nSIrQySlNJRZ5ypn6waHbfuFgkEhgTOeAttOwpYUjpTxR4Vqw9piEEAMsoinBtIJGIMTyHd++7p3L7tcEG2ZimAcWPX3FyVeo8wAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRMvZAf5h9UR6KAIkN4cXgxgRRwhR81VYk21ZZ7xSuA=;
 b=pxnmSF7mCOvMarBheEJ69IPO6H1m01Pjvi1GOJgsab26yIPNdvOM3lpo38vCSfEiHy2E2bZe7RPAZbtssZ1VprGn5Z2SC0V/Q19Z5gvayNmb+b7fimpWUHDKDXsWCVBMAaHGfKTwqvdLw5EezN6rTCfepp36m9Tzu9WciW/54rw4gFZ7PykVPoLB7MBEe6ZzTf7+hTFe84G3kaJT0Cl5t4fQfaA9KBwtoofJAo+19MoXo9IJxjII/JjaLqzBPIKcbxWBq7DeBco4XiMnpChTGFW/7OS77ZpYgrD+U2LeLkFCjl97s0EWKfqWcVSAuLFKtbP4vMeNtXlQkGBEGIOy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRMvZAf5h9UR6KAIkN4cXgxgRRwhR81VYk21ZZ7xSuA=;
 b=TXTwy+qaYxWWriUnMMLQC2uAawAsWSBJl4pATzrQFnw+zoCya4xercZL/iQQ04Wl2fCfjOb46O0UpTnbmwXlG2xIOZbXb00fp6KrcKw/X7kLp34i2Na/ljRsMog1COfP8pxo9FYBjxTsbAZqYPkTA6oOqKgzb6rZx3egv7vu/Ug=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sun, 7 Dec
 2025 13:59:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9388.011; Sun, 7 Dec 2025
 13:59:40 +0000
Date: Sun, 7 Dec 2025 22:59:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <haoli.tcs@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: slub: add barn_get_full_sheaf() and refine empty-main sheaf
 replacement
Message-ID: <aTWIQ0s3EbOa0azX@hyeyoo>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
 <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
 <aS_OrvHmgyhQzQIj@hyeyoo>
 <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
X-ClientProxiedBy: SL2P216CA0151.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: b0338946-930c-448d-8994-08de3598dd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGFFTlRFVnZiQmNlOVRsTXprNmtQMFoweWFjTW5SeWE0a2YxOER6eWtIYnQ4?=
 =?utf-8?B?TksrWG5WVzcvVHhZWWhsSnRadEFlUFB6eHdaRGE2ZTNWTm1SbjB0cS9zckdF?=
 =?utf-8?B?ekJ6YUQ2eWdXenJUc0pCUEtWMm9tWnhvSFZuZXIxYWJSK2JqOFZDRk5BVkJC?=
 =?utf-8?B?TnVxVWx4bDM1MzlyUjNheTNQTE41YUtiSGxnd2Z5Y1RBVkhpTTV1VE0xUExC?=
 =?utf-8?B?c295S2ZESU9ERVd0TWdhOVVLamI5dW9GZ2JaNXhxc1AwUXZVWTgrVXBRZ2FI?=
 =?utf-8?B?aWkySmFHKzMzODV1QU1TMVFydTdwMkNQcFZzMlM2dzhnb2dhVEtvWUZRR294?=
 =?utf-8?B?ZXJDdzhwaFF1eTVrdUFIVUdqNDBsczZzNENrckQ3R2N1dU9wWWdWSXlDUjdw?=
 =?utf-8?B?Sm93d2J6Yi9EZ0JaUDRmamd0cmJzSHNReUQxR3lHcUdDcDY3MG42WkQ0Rmkx?=
 =?utf-8?B?RzYzRXdmRzhsSTQ3Y2ZES1p2a0pqeTBPZ0ppamNhUnQ5QjVzTkI3YUhLVmgz?=
 =?utf-8?B?U2pGanFoeG9GRzdXc0VVdWpRYXN4VThLYUhuQjd6U0g3dG9RWDZ3eHZ3YVlY?=
 =?utf-8?B?bEk0K0FYNEVxYlMrMFZJdWQvNUQrRk9xdlB0N21wLy9kbU43OFYwQ0d1V1cw?=
 =?utf-8?B?Sm1Ec3cwVkowUnJvYmFsMnFuR1laZjZmcURZcU9ISW1nMnZoVUpvemdKcXQx?=
 =?utf-8?B?bkdBQzNoU2tJVmtkek5HcFZyVUJZYlZKUWFGbDhBeDVuVHc5RVhtNWgvVFpE?=
 =?utf-8?B?bDViNnNmQXY5bFVOMUhkQnVpQWVzV05hU01jVVZnVFZXTW8vZ0hNVU1JcitT?=
 =?utf-8?B?ZCtqNXdmTzhBU2h6TGx5dmt0RkNyTG5LV1JDSVNqcUg0b2JtaUY0TGgrUGly?=
 =?utf-8?B?SDNBYXRKY2ZJTHBGK05RSU9rbmVacUh1c2dRSExWOE9CNnpQb2g1VytqNDRI?=
 =?utf-8?B?Nis1NE1TVzVDdldtL3JYeWJPMzZJV0g2ZlYzcUJNS1hFblNwdnp2ZjB6czlD?=
 =?utf-8?B?dFZXNmJ0K0pla2Q0K25QRVhSb2J1eng4VEVtdU12QzFiTnNCdnQxcmNhWU9Z?=
 =?utf-8?B?MkJlb04wNkVobDR6RmxOdW1tNFhadHprWEttYVZXenNpQXcxUzA3cGJxWTEw?=
 =?utf-8?B?SHE2TDk1cHhjRXJZSnlEQVRDSGdqTnBXZEM1WUFTbytlWC9salJwNHhIb0Fa?=
 =?utf-8?B?WHIrNkZWVnpKOGFCdk45VkZLNmRoVFYvbUZqU0xzWnRvSklydVFNc0ZNS0xi?=
 =?utf-8?B?dlNXeDduTVhrSmEzcXNmY0xHL0liejBhdk93cFZkMmE0TXRxM0EzKzhvOEln?=
 =?utf-8?B?eSs1MmR1M0FyaWJSQ2VmRmZ0d2NDWXpXTmtDdFVucnU3MW9laW5rN2h6aHQ0?=
 =?utf-8?B?WlZlcVBXdldIS29RN3AvOFdpTGRYSlp6bjVTWDVUbTJQbDFHTjB2VnIzbWVT?=
 =?utf-8?B?TmEyU3hWVXJVREhudUFPRWpVamJ6LzJLb2U5RllQVVB0WDAyTjhvbVl3UlVX?=
 =?utf-8?B?eklVN2hpdWhxZzJIbnd5Y1B2eVcxaDB2Z0wvKzdkc2NFaEZtUERxSnVNMWhB?=
 =?utf-8?B?ckIyN2ZZYVlFY3lDNHAyYVhGNWwzVk9aR2oxVlhlR2Z6Vnp6Ly9hOXV3WDhK?=
 =?utf-8?B?djRRMTZJYUFKNkZrbndURTdPYW1nelk3QzVURkFOUUFJdlBqVWppQzBPUmxT?=
 =?utf-8?B?ekRQcWdRWW43SjA5QkxhaFpqTDNhTDFJK0xyYjdQRWNSSkhwN044SHQ2a3pO?=
 =?utf-8?B?NXdxUmVTYkZhRnVXeTVzZkZjZEMxaXpHOWRsQkpRNG42aHFvNGNKYUlicEtw?=
 =?utf-8?B?UDRQVmNCR0tXRnZSNHR6RjhvYU9qVGpWUUVNcFNwWHhpNjBDdHlsZ3lXenhw?=
 =?utf-8?B?K3hLaEVvcjZCU2pXcGFWT0dSUS9UQjdHZEE4b2pCUkdvWWtjRnUzRXJ1Uys0?=
 =?utf-8?Q?izX+wom7j71hnZND8A0yBH72SZcc+dzh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekJvNkxEajNYM0pBUmlkVW1UME53NEVtWk9oZi9JcXJUeDIwRVpqU0pTODRs?=
 =?utf-8?B?Tk9XdDNldG5QclFhYTZCUVRicy9mb0NpM2xWZjdaVXlzTUZjNTgzN1FrNFF2?=
 =?utf-8?B?SjFCaWFtL0R5dERDQjZ6anp6T0I3R0ptYStLNEFGc3pBYVZDMlhidXA1RERL?=
 =?utf-8?B?NVUzU2I0T1hGTGd6RE5jNHFqMXRGcEJPL3JXdTlLVGh1bEgyM0E0dDBFdWJS?=
 =?utf-8?B?aFlQRFdEOWJURWNKd2UzK1R0Vk1TdFY1R1NZQmgyU0ZrYnkrSHcyTlpWSHlV?=
 =?utf-8?B?c01NM2s0ck1OeGxtVENRc1dudVRaa29ucTFoVUVnWVJ4V0Rlc1FVYStFaXZz?=
 =?utf-8?B?ZHB6MlRMNWdNb1hmYjNGR1UrSkYyc3Z5aUd6RWw3bVV0eWh2bGc3UHNJd3Rp?=
 =?utf-8?B?TTkzS3M3YW9DZjY3dlYrZE5ZVnRrb0JXQVY3Z3VvN0pyU0R6WTZzb0Y0T0V0?=
 =?utf-8?B?MlpRRFZzeklWTEdmeUlLZW1QdkVWQk14bGFzVElBdHlZSVJ5bWFscHU3OVdN?=
 =?utf-8?B?dHh0a1hBOGVpdTAzSzZTOFdzS0RHdDhoVjRzWVNxakhOdytPb1l3TDl4Q2lj?=
 =?utf-8?B?NWEzTHlCaEFxaUlLdWVSNUtBeTlPa3o4c1FUUnhNS1g0aHY1Z0Y2RlFVbGd6?=
 =?utf-8?B?ZklHdUp2QVlCbkhob3JFQ0xYRzhhWENkSHdPaW9nVGlISGVmelVmVHVMVDhZ?=
 =?utf-8?B?aVBpZ3Z6eW9ocklXWGRyRlFvQTNlVjA2amtqNDZ6S0JkVWxDQ2NRTVpWa1lh?=
 =?utf-8?B?N05NSzNYMUxOaEJvTFpEbmRQS1VlQWozMTlwK1p6MmFCYkR1bG5oeFdyajli?=
 =?utf-8?B?N085ZUhUbEVIaG15NEU0RElmd2hmSlZrMHA3WUNMQytDV1BHd1RBWW1NN2Nr?=
 =?utf-8?B?NjJzeUNIb2dnM2dCYnBXMVY1blE5UTJBa0VxNEUvaE9ja2JiMDk2WUNRU0dF?=
 =?utf-8?B?eEhKT3RCVUtUaTA2Y2RXNkhMaXEweC8zdjllQVQyV3QvNWR0WmUzQ1JLN0NB?=
 =?utf-8?B?S1MxOE1wN2NnN2V1anBUWU1QdXUxZ3RjNW9FZ3E5TU0rZUZscGp2dHhXRGt1?=
 =?utf-8?B?SjRWSTFDWmJWQXRHeEJDSTJjZ2hJWWZuTW5wUXAzU24wQ2NzS3M1TEIwT2V1?=
 =?utf-8?B?cVV1UzFnRmhia21QSS9xRXpIMWs3SmY4T3BHdVNvbUJFT0RocTRrT0pyUko5?=
 =?utf-8?B?Szl5RzQrZmdYb1FXa3pTWmhhRHgwMXprZ0I0Y2hCL3VFVXNtQzBaY2REdEIx?=
 =?utf-8?B?UmdqcWxFS1dKL2dmMExGMG0xczNWanRFZUpPT3hoWmZuSDFOaStXOXBUYlBT?=
 =?utf-8?B?YUJRNVRVbkt0dGtSWFBLb1J5TzQ1QkxQMGpRWmZ0VzNRWVJySHJJL0I3SUsw?=
 =?utf-8?B?UXpwWjJ5bGxid0tDSzg0dWFJZHJqamhjM25ZV3lKRUdkdi9WM3hLZERseWFq?=
 =?utf-8?B?S3NIeWRKb0NMcXd2SUNKdlZhRXZZeUZhQXVNalp3NVlrNkg4VHpHQnFEcTB2?=
 =?utf-8?B?aE1BMDBEOFFpUkJ1K2t1SHNlQTdkajFTS25NUWVLY1NjbXA2MVpRamF0RkxX?=
 =?utf-8?B?L2MyK1pMVUZZODdPNTBLYnNmczRLNFRxTFFMTU5zeHpqUzlOYlliNXpHeWpi?=
 =?utf-8?B?UmxpWG1YeERmd1VOOGt5WWxEemZQK3pRdGZhNzhkKzFTM3NseGlEdUVrenF1?=
 =?utf-8?B?cFloUXpOTFVWaGZpQksvdVNzOUIyWUNwcEIrOVZpYk9WeHI4SUhCa2RiZlh2?=
 =?utf-8?B?TUpXV1VDcUxuSndJbGtXOFV4QmxhV2tVWEJHbmtVZldaUUNGbmYrUlcrZHo5?=
 =?utf-8?B?M3dHdGU3NUcrcUtrbjlnTEkyVURUdUFBTHFiVnZnbHh2S3hCUFpRYUhnZ1pO?=
 =?utf-8?B?WlF3SEgzbEkzVGF5K3dqMGNySFBIQWVHM3EraGgvU2pOdWI0YmNZaW9mR2RI?=
 =?utf-8?B?MUs3L1Q1a3dZTWUwWXlPczI0RnJZbmJ0RVoxRGE4ODhBUmVGbU1IV0ZHZWc0?=
 =?utf-8?B?MnlVbUhBSVJRamhFdEZsbS9yZjN3Q2h2eVRJTW95VzV5dzdBbVRyRllVaEYz?=
 =?utf-8?B?K2RHVm1henc3ckpKV3drUDVYREMyUFRQTzZnRG83NlFrY1lEZlkzQlFNTHdO?=
 =?utf-8?Q?RMCpjXxT3JdmZC4Le6odBo9k4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6JhUtBKXPv/L6ZJmKJjS1+sSwlVO5LgXi6t07B5f5JRy7qjnqEQx8KmMcLKgMeT2miKVohRG14NQ+59QnpK5OFdeVm6/nM1Fk67JmEOBUo4QC5dPhrLQ3KvMGkcn3ZDdXP7nZczHqENiIIrAa2LGgcXStkaw11mo1PuIBIjzSklfwVWQUx0go/oy6RfgqLrs8xF+w9uDFBbgXpq0CimHeuiklVnNobE791jNHUFVgd60ULc7lUSPb1jnFAw0Kj4Bq5p5rVuagx3BnUIDEBU43/bM+6L0/Ty46uOpPwNacYPS2UGmk3zEO8UFu2bShN5ip5p4Eov+igtpt+MNfQnLuqPjL75gy6pyMSF3pgfS7m/r/TQtKhdckv2WBMm4qnc9562kN50uhTQ1BdUQ5hrK8jH9kzmTe7XV/LWevyY7a2K1tMF3Uhvztp3259bp2aDdMfQha1/E0pN4uCeQ0CMK8aqcWPvdo2Y3v0NZRBlb3rZPtJtQJgzcJwk+ibKuB0lOUkC5Su8DYRTsu/tLhwNbCe7G7TRsqS81CL3bMY/wtAx2RI03FU3Uzb3Mx9wxeWQFt1fkSf1hkReSVTkfF00txH6gaOfuAgeJ4oG4ZCXmjEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0338946-930c-448d-8994-08de3598dd9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 13:59:40.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDDVr+zV2I+VDq7SKbpLwqJmnMoryZ8YQwBTrfMPKbQ11stGlpLl7+734FkP2qgJQ4ZwDETp8u3pKJlwVXS3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512070123
X-Proofpoint-GUID: JkSms4OvXWr_JOHgNru7PWyP7WJ7QqqP
X-Authority-Analysis: v=2.4 cv=H4DWAuYi c=1 sm=1 tr=0 ts=69358850 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=6GRLp79BYCWPMUx2GbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JkSms4OvXWr_JOHgNru7PWyP7WJ7QqqP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDEyMyBTYWx0ZWRfXxLnntCswV6BM
 Psjetn3aKtZKroTcxwjJiYqx8u8wJJdnUAjIzGTj7ZYaulPB9aoMoUzYBGAsDtcAtYVIGOO6rfz
 FFeTYn/8aiym67fGDKk3Pn6xEcTbamJOvVt+E1I6DwN34g/dkmKtG6/Exm7DRqqq5NGRR1PfSe7
 5fbCeKImfUpF9QrMEzLejxIh+s6ML42iRwJWC8P3JrFnVBXU6ovtdWIaaVFDE00lsv9ice90awd
 AWiTdvOy3SfYWn21SIrAqcw0FC0YKWedhrGVZFaVUrEFh7itUHozoc7S6tuZ96a5cXuft6nvu1e
 lTK4TJkAreTnSKSDWPxjGcWwzLdyruNr2V1fFT4dUB3pqKaOJe2Osd1wupetRYVDpi3NCOuNMhj
 IQtr+81Hw8qVKPz3PNkBc2SdDVvMtA==

On Wed, Dec 03, 2025 at 07:15:12PM +0800, Hao Li wrote:
> On Wed, Dec 03, 2025 at 02:46:22PM +0900, Harry Yoo wrote:
> > On Tue, Dec 02, 2025 at 05:00:08PM +0800, Hao Li wrote:
> > > Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
> > > the per-node barn without requiring an empty sheaf in exchange.
> > > 
> > > Use this helper in __pcs_replace_empty_main() to change how an empty main
> > > per-CPU sheaf is handled:
> > > 
> > >   - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
> > >     full sheaf from the barn via barn_get_full_sheaf(). On success, park
> > >     the empty main sheaf in pcs->spare and install the full sheaf as the
> > >     new pcs->main.
> > > 
> > >   - If pcs->spare already exists and has objects, keep the existing
> > >     behavior of simply swapping pcs->main and pcs->spare.
> > > 
> > >   - Only when both pcs->main and pcs->spare are empty do we fall back to
> > >     barn_replace_empty_sheaf() and trade the empty main sheaf into the
> > >     barn in exchange for a full one.
> > 
> > Hi Hao,
> > 
> > Yeah this is a very subtle difference between __pcs_replace_full_main()
> > and __pcs_replace_empty_main(), that the former installs the full main
> > sheaf in pcs->spare, while the latter replaces the empty main sheaf with
> > a full sheaf from the barn without populating pcs->spare.
> 
> Exactly.
> 
> > Is it intentional, Vlastimil?

Let's first see if Vlastimil had an intention, and...

> > > This makes the empty-main path more symmetric with __pcs_replace_full_main(),
> > > which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
> > > empty sheaf from the barn. It also matches the documented design more closely:
> > > 
> > >   "When both percpu sheaves are found empty during an allocation, an empty
> > >    sheaf may be replaced with a full one from the per-node barn."
> > 
> > I'm not convinced that this change is worthwhile by adding more code;
> > you probably need to make a stronger argument for why it should be done.
> 
> Hi Harry,
> 
> Let me explain my intuition in more detail.
> 
> Previously, when pcs->main was empty and pcs->spare was NULL, we used
> barn_replace_empty_sheaf() to trade the empty main sheaf into the barn
> in exchange for a full one. As a result, pcs->main became full, but
> pcs->spare remained NULL. Later, when frees filled pcs->main again,
> __pcs_replace_full_main() had to call into the barn to obtain an empty
> sheaf, because there was still no local spare to use.
> 
> With this patch, when pcs->main is empty and pcs->spare is NULL,
> __pcs_replace_empty_main() instead uses barn_get_full_sheaf() to pull a
> full sheaf from the barn while keeping the now‑empty main sheaf locally
> as pcs->spare. The next time pcs->main becomes full,
> __pcs_replace_full_main() can simply swap main and spare, with no barn
> operations and no need to allocate a new empty sheaf.

I'm not still sure that either way is superior, as it really depends on
the alloc/free pattern. If the CPU keeps allocating more objects, keeping
the empty sheaf is unnecessary, but we don't know what the alloc/free
pattern will be.

So strong opinion from me, but I think it'd be better make
__pcs_replace_{full,empty}_main() handle it consistently,
if there is no special intention.

> In other words, although we still need one barn operation when main
> first becomes empty in __pcs_replace_empty_main(), we avoid a future
> barn operation on the subsequent “main full” path in
> __pcs_replace_full_main.
> 
> Thanks.
> 
> > 
> > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>

-- 
Cheers,
Harry / Hyeonggon
