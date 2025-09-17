Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AFDBA45;
	Wed, 17 Sep 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108809; cv=fail; b=ELjNSdcKRSQ43d09NIIzVpG9cPc1BDkNqleePdyDgw40Z+ghi1gT4HpKX1EuCW0soWXSFvcVXClGoQqIQNS2ecdAHYW+LkVuAkwo3FcVSWNyp+oxSx3Fp25Xf1vtluYl0kJWMmHMa9l8tU2/8XmR4IZzG72jR6UeDRwTkREAxG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108809; c=relaxed/simple;
	bh=bIB/jmYH9OxZaONaBCCWnZVeHy4w11DSIkrjNM0EcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4NJxIV0nwp4yfZ0B+a+9QtL5g7uWKUa/IcWMQA5tel+jRLcBTGWP2FqxNtcjL8w6/fsS1DkzrTYbTikA5V990l/FLwyUYMDS9McmHwMkIM2QGT2pVyzzbfA3V/Dv7qyOLIlicHkdAs4/kXZgxpCaQZW+hUucFthuqCxxR8UwoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MEYRvK9v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RSvBbnM8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MEYRvK9v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RSvBbnM8"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAQeA7010035;
	Wed, 17 Sep 2025 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HzujZ1k0diEvBsD+HC
	44myJOrJxJ3dzQ948TcQvBEns=; b=MEYRvK9vkWNsyxDiJ3dG8sVzIQ1H0l3ahV
	7LZ5sryPkuXlWcOWt1ASXDJuYcl6snNDG6YT8/9RqkIcBh+HDWZsLuyh7rUfRhCO
	a21aN7zUbfmlH+jjH0hoRz7IrGZoaes/48q7o6zgPkChZcPgr4A5/WDJmlb+fGIY
	zxSP4rz2YAGhKsYAzAk100GjfPAfqSbF+xKtYZszzyMRd8uwAi65e9flt9Q096qs
	UbKfxtY6pzr2iE5kei+3XV6jQ2sn80BL8oF59A9Cli2Itoyfo6omzwHfbeW5EQJP
	bb2xQOp3ep6lsdbA9ZFanNRavUQz9/C+ee5YYvoO0v60gLD5JLIg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8gymd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 11:33:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAj3Du036742;
	Wed, 17 Sep 2025 11:33:11 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dnnfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 11:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6FkogneBiEXVIskdfVn8zUn4DbXa3MGx/DcNh0DVKWu82oNVjZcFce/fLl2u/nIAMu84u5hd/xzPrP25PO3DBNhrxOU5JuJwd2m4DpWV997pexj/ngoCyY0DVlCxZzRnCwF45yaqm2veWD+H8qFU0ZxWVOvcAZOA02c5RvVbfgblHzy8gm3DvuhC1yKmZJulpoIRDx3NpIdN77lNMnkegoPMQTiONW3H/1mP7e+u7/7zvPi3B3OYRrNLUVS+DlIWORYjchTRZc6mgHD6XKfRrZj5FY97tXEr5coYSBQHZjmBFQA7ilIvRnFamcdASWWd16wAs7BMja2FYjpituOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzujZ1k0diEvBsD+HC44myJOrJxJ3dzQ948TcQvBEns=;
 b=Iqrcuk0B1pxz1YgUmDIXGHclmF6QC86qFsKxZ0SODRtpzA3MRZ2sDzi3yOPKwn2vKXClSYNrNjvFzAMQQ8zY3E8ahJL9gyKFmVrhCAAgFhOqw0wLy64wX0fEbLR6RfYw/nMWdUP51S2UFParSfO5QCKCe4JGUORrVgxHWRRVm6r6TE56Vu+Ix7k/WNJ7R7nYD7xCf2+5jaLRwG1gwLHSOIxxE8So4r8ul6H+6hUQc1sCjqkkBPp7opXyuFCboQk/njl4aTSiNwD7xxY6Y3gu0XZ8TBn/17fxpOVd9ZCc9k2yaH2NqgH2fDdXHvWcVhV6vbeDPyg6mYGTRqKpC4yyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzujZ1k0diEvBsD+HC44myJOrJxJ3dzQ948TcQvBEns=;
 b=RSvBbnM8RE54ous3smC2uC1vOZcA5CTdD7RcboQW+W6pwouSi6LLT5YmgeqjN8yeivEjN6a7rOV1OyH+W0ljLd6SLQ5gIYkvP3y7xMS18CMgeDOGu7eMV2fMCG/FDJZ3EEl8HVO3QOtTXx3CQXR3/Mfj3vRlG6WeEoNAAsn6vkw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7920.namprd10.prod.outlook.com (2603:10b6:408:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 11:32:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 11:32:55 +0000
Date: Wed, 17 Sep 2025 20:32:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aMqcXyKRlZggLxu_@hyeyoo>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz>
X-ClientProxiedBy: SEWP216CA0030.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: cc04901e-6c7d-47b5-729f-08ddf5ddf1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmuNZi7FdgYszWQrPkFPo675gjXZoU5JWs1PYWr2zP6byGNl5Y6JzXxBpBHt?=
 =?us-ascii?Q?rx8MygJ5Q+XCnxhtqUPuF/jRsTqufrqfsKoRYHIPJLWAYxbbxiMuACevhgjY?=
 =?us-ascii?Q?bvSsG/xagYqOz6l2mv9+NHLWkDV07QBG9pyH4jEHQq27rpnqQSOKDDR/kl9o?=
 =?us-ascii?Q?/ApJUMQZpfLENrYlD5TDXzweIsWtcdSGZvbxM2gMQWuEM/HIjI5D9MMyJUvN?=
 =?us-ascii?Q?zphd314S0Dplz3WXuLsuxLLJsxlm6KAyHGqFqgDZ+a8jvrtAZXn9jqyHDF+z?=
 =?us-ascii?Q?bNcjamQXyKNsR9j4UcWetXqMrjLTBEZKUL8gfhAjJ57or5a1b+H1NzmCavL2?=
 =?us-ascii?Q?Fhc5okCoJ0+KGniacz1z+u5p3KrU0gq+bRfqDWzvpWD611oWZRrgtCSXfS2U?=
 =?us-ascii?Q?06KAb68GpH5akPkTQFT7Xvb0ux/gA04hNDQ18QIcq0mt7uUrxPgfCgUqS8EG?=
 =?us-ascii?Q?JD7v61PTl5onVlUJ2ajXLhLD4Fz7XqcG7QgzzPHJLPIhnwBCVoE/R5tUamHT?=
 =?us-ascii?Q?pghhk9WBg8e/iAk7ia9jYyBZd9ZLV++W1KhamVvPma3n4Vs8gp2KiYtmF1LM?=
 =?us-ascii?Q?ATiPL3eQeYWZ2qS1WKLJzJfOBBt3fGYDqwDFxiffCQdtOH/PQJQzaIlt8Vly?=
 =?us-ascii?Q?BUXw5X3nnUfIZfuAA7o0gFj1hUjkABxRfuChVkvikorTJbi0xs2NM1fwWMmf?=
 =?us-ascii?Q?h+pbUfV+noEhf6lOy2mv/ujNAVmEoB4MEVay5YK49TMdmgMFUzim4/VmUiXM?=
 =?us-ascii?Q?/h4conYbPrEiL6It1+5+rY/GV0djeLoAIjaFSk0Yzj7DMY4a7YwH4+SOzDTp?=
 =?us-ascii?Q?byf+WTs/m5lhz6Uuhul0t4AuUKSQ/+yerCLFkfkczTt5XvvNaH1Gi+IaCVH3?=
 =?us-ascii?Q?QPKJA1DYzCu9Fn0JQXVww+2y5bCISbMGC6vDGUwqJOByPgYnbSZ3cOgc32NP?=
 =?us-ascii?Q?B3Aln2nJR9eQx8LzLXhKcq45AYap68bPfjdCCTgNK1+kvs60K3ZuSeNHlmGn?=
 =?us-ascii?Q?BJUJlT6PVZdpMTzufGo/aWUY2+Re7C0ldaJ2ltiE64EdbEMfrd3ri2LJ1iIQ?=
 =?us-ascii?Q?hDaMqbGrvt7RZae29womy62mPHjWL9vLuYf0+mRH589XJMdn0/MdDMi82hCc?=
 =?us-ascii?Q?yPSj2V0yiWAxEPh9oPhU7EpQdaMYhlkoZTBTZbVr/rVEK0AynqUk8PnFBR1B?=
 =?us-ascii?Q?akgV5noWDeReZTqYEzbntc6lOYi891qUWHrY2xtHU1igeHBa5qYQTJNuOjb9?=
 =?us-ascii?Q?Nv9yt2tzAHbidaqK9LQ4UqP1FhuXcLKVR5nfGd5/cQMpSdBdL+WbfUpHe+mL?=
 =?us-ascii?Q?xfwaA14nMOMMXHAHevKV+HkustHQCp7TXgF4b/FHeBKS+H+PWSkGUgn7GFcR?=
 =?us-ascii?Q?Zw223+4Z4oBWQnF6aop8bAUA0DJu4X5B4JswFK9GBDJyJ6i5sBZ7/lX51VPD?=
 =?us-ascii?Q?b/idXdj0FuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tdFz6fvk+ITsNkZ41gN1/v7ZCJvWZudhQueEA9+VoHEL8/Z0eASyfJTBzcy?=
 =?us-ascii?Q?rkRSxzO+Lv+/wF5RN90CG2CGHT696xIf+soX6ZoykY7Bag4GFfbJrSge/Fkh?=
 =?us-ascii?Q?IK1i86HV6DDCortFUfMR1ph+i76jEK7YnkKA47ZZSjyHc/fAEikikhm0sgBL?=
 =?us-ascii?Q?40uIviI8+3uhpLMCLIyeqGj9MS5BZqBsTydPlFG+CsvkTBNg6qgRrSL0K1dW?=
 =?us-ascii?Q?oH5g8w1lVANkHVaN6uEAxIS0eFtaePvyUX2kq5RGCrIs12AtzRjak7lNDfh/?=
 =?us-ascii?Q?vm54soGqypqtBVsb4y3iUet76R7Lr7D9yKcj9yQFtodVzO0c0zOMbm/smX4b?=
 =?us-ascii?Q?8QPaSp4Kheu5eQSJ+I1eF/G1FJb0Y0jbsDGOlNqmIX5Wn6etMUy7SQMxGvza?=
 =?us-ascii?Q?ZHiAPrinNSGfXWIxsO/zS6+3yFC+fRYlXHXf+GMqJQbfHdj2idbT3k3oRt8M?=
 =?us-ascii?Q?CuyX9cl3L9+cNq5Ho55NegHnm/f4fayOcjGu5+PvyA8dZ6b7eMw2Tc1bkEf6?=
 =?us-ascii?Q?v6p1dNl96aNXQBx7V6kSgM2IJ9BHo+RRN2/+TdulQa7/Y5c/dLL+Pn05ffBY?=
 =?us-ascii?Q?A/d2bPnoGxpQnjl/94/xcI07t6OgoHWudXUM+6gCHzHDlsUuCGphQidvXu0F?=
 =?us-ascii?Q?cDoj4v2LBOspqg/Utrwnrrg2R/nVaP2eHga/Dcz9X4/z21GnMC/fQtTH+fFd?=
 =?us-ascii?Q?yJZ1RqqzC810R1pvrETOWcP3fY6aPEyV5RaB7rPnb2fyf+NSQpEVOfH6yNgB?=
 =?us-ascii?Q?yjUzd/kr8/+qxMTJAlymo1GxxI8kjrzk87iurCcy4ppgGM8bPYO9DGjiaPa9?=
 =?us-ascii?Q?rk0S2PV3AOoPKsiH8qP4w+yBZk0GjlWVT29KcBLjhTEU+qdByh6OoF/MSvES?=
 =?us-ascii?Q?4PS5rQcysglvXsIwatZKNIoRFWmhCWfPDISvVAzhfajBwjnR2K8NIfMsrbDl?=
 =?us-ascii?Q?G/gqyKIXFIn6V+9GrYH+L86WorYPjTEokKsY+wgvZihni1XkWGBkDr7nZwYg?=
 =?us-ascii?Q?ef1U+r/HzUZybBjewQNI+rgxuDp1zHNlAUEpIhcDz+igS7pNxjGjh1qAT0z8?=
 =?us-ascii?Q?QOemxv8UQVtUWsrSIC8RpwWjKrkVTOi09t1YJSlNAQkliPbiH3TBi6saFhke?=
 =?us-ascii?Q?ZoeBifdQ8BD4xhwX4NbbdKRIYETOIzjBrwv5fSiTenQt4IAu9U9kiV1DcNL6?=
 =?us-ascii?Q?l3EfEEOFWzukQXoa/wpHL4FEarfcruUFjsqV2jbq8y6UIsSUKKjI8MZY4a6S?=
 =?us-ascii?Q?KBqec5csVsXGhzQtooJHf/c5Vl2+CLrnIV5nk/y3/YQ3lNJEwENOyeInjONz?=
 =?us-ascii?Q?FVf8xEQTxSAcS+0vtEBKLiWkB/cuSKWcJkTeXe8Jb3XGCkI002oWS6U6MBG9?=
 =?us-ascii?Q?1pVJwjqJsCE2ZkZYiija1kCaw3tcnWfSnoK2dP5L1naXtVI6S9P7ftkHVI9K?=
 =?us-ascii?Q?rhh91387MbtE07ffapE6sPm9ah4+gEVOev+dIVNaXX6Wz2//IbRUwp3pRxyy?=
 =?us-ascii?Q?ioHZoaWQNnv1p5uSy37WuNyhwS/st24aYbc9Y3EhARs9aaZNw2UoxZ/c7kwf?=
 =?us-ascii?Q?Gj9szgATV/n4rK4oVVO8fhlVUOvl+0HgzRodTLET?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LY1jlsxhZ6YIVEF/esdTMj3FUq2M1fQhTtnwd2k6C06MrFgHbcYXBOF3N5vPZMMyu70P5ACRSJK6bJ54DjeDmMhDm3LgEV7ncXBNKRhZMl9qv2sOkKCC3ixbzD9Im+5yG7uTcZQm2BbpZhDX6DKjOUbKtfgKYkrSZAYaXX9XungpEILXKXZLWFRvICaZknbetiRpJrMvT/yfIwEWFjSsMGc41o9YnyrbVXbSVQnrB0tWQkUrxsMIGz9QUmS6+4LtVEFlgbIZewNIKy8lNaeAlX88Zlcwv7JoMqyYQsRh0tNCVbVA4zjy5OOhub4HrvDV+einOaIaaq5B6zDcKHnp1PnAolZnGnEZGnJqHo/Gr3h+ZE1+GoILKGHjI27NgcYZaVqNByEZVapJT+avoVEGekGzrVUPnDG4YXvv/h7rHWq+757D6Hrht9DAIIjlY4bqCbf/IFqi0QvgT30Jb8Zhe82hmgrZ4oN7fA8m+qeWRdDC1VmoH49S5UnyYn2okvmsu613e+rb+jNbp/Y1uX6AcVLHh3D2loDct2lSf0TMuPvbJ/cMnKoa8jCNqIAK1SyDxfxH9kpCTtGazIq/LgtVTHTXpyGmXfsuIVMAYPLbE5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc04901e-6c7d-47b5-729f-08ddf5ddf1b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:32:55.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wqLd9V47GOa+o7q8EtzCSLFx223ACD5IZJomowQN93kJD0i4nQ88MDbB8hMtWoltDT49xJGwUJ6P28cMWmO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170112
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68ca9c78 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Aey1uuj-h2jjhqrsljsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: 6pjBNmpLjLaGQw5uxqPbsopd7_I5E1ec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9ay489ATfdXf
 6K9960n2A5ufWAM8Py0sW+bHgfuiYGLIHAD4MjG62pxY4IGbqT6jI5XAOmciCy9KhJdLYJXNBjL
 qu7sYhHDhsPS7Hu/rWjI3WF9hla0d5z76VEjTtJ84KNlIaiDDc/xNvZk3eJlmrDrJFxNA1cBfMU
 zOmgF890d8wGtU/1fUqXQiAXRq5gxrG7RrxJzmTD4+EruDbekYplLxmYTIWxNka/vV90qjbR1YI
 YHcBqYd6dpdWmqSEL6RTZf1uiUrbjpdsAWKoMxm9WCS5yMKDYYRs4C0F87xXZ5zvzilz8LMzv15
 69TKHTyzZGBtgynXq2843Za1c4c4VCMPKREzafGkUY+ffm7qZkL4XQoBj+Aw7Mp9EEH0BaIvVfJ
 OKu5u80WzTKerxZKC9EfSZ2MDGHfMg==
X-Proofpoint-GUID: 6pjBNmpLjLaGQw5uxqPbsopd7_I5E1ec

On Wed, Sep 17, 2025 at 11:55:10AM +0200, Vlastimil Babka wrote:
> On 9/17/25 10:30, Harry Yoo wrote:
> > On Wed, Sep 10, 2025 at 10:01:06AM +0200, Vlastimil Babka wrote:
> >> +				sfw->skip = true;
> >> +				continue;
> >> +			}
> >>
> >> +			INIT_WORK(&sfw->work, flush_rcu_sheaf);
> >> +			sfw->skip = false;
> >> +			sfw->s = s;
> >> +			queue_work_on(cpu, flushwq, &sfw->work);
> >> +			flushed = true;
> >> +		}
> >> +
> >> +		for_each_online_cpu(cpu) {
> >> +			sfw = &per_cpu(slub_flush, cpu);
> >> +			if (sfw->skip)
> >> +				continue;
> >> +			flush_work(&sfw->work);
> >> +		}
> >> +
> >> +		mutex_unlock(&flush_lock);
> >> +	}
> >> +
> >> +	mutex_unlock(&slab_mutex);
> >> +	cpus_read_unlock();
> >> +
> >> +	if (flushed)
> >> +		rcu_barrier();
> > 
> > I think we need to call rcu_barrier() even if flushed == false?
> > 
> > Maybe a kvfree_rcu()'d object was already waiting for the rcu callback to
> > be processed before flush_all_rcu_sheaves() is called, and
> > in flush_all_rcu_sheaves() we skipped all (cache, cpu) pairs,
> > so flushed == false but the rcu callback isn't processed yet
> > by the end of the function?
> > 
> > That sounds like a very unlikely to happen in a realistic scenario,
> > but still possible...
> 
> Yes also good point, will flush unconditionally.
> 
> Maybe in __kfree_rcu_sheaf() I should also move the call_rcu(...) before
> local_unlock(). So we don't end up seeing a NULL pcs->rcu_free in
> flush_all_rcu_sheaves() because __kfree_rcu_sheaf() already set it to NULL,
> but didn't yet do the call_rcu() as it got preempted after local_unlock().

Makes sense to me.

> But then rcu_barrier() itself probably won't mean we make sure such cpus
> finished the local_locked section, if we didn't queue work on them. So maybe
> we need synchronize_rcu()?

Ah, it works because preemption disabled section works as a RCU
read-side critical section?

But then are we allowed to do release the local_lock to allocate empty
sheaves in __kfree_rcu_sheaf()?

-- 
Cheers,
Harry / Hyeonggon
