Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3717BBF;
	Wed, 16 Apr 2025 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788727; cv=fail; b=F/3QlVAElUB6nu2ZFgRX9oZ5gn9Hv5qrb1ozNwXOIhSXAd1jQFm1OLIr0vTm2bMNWxEhWLlQZVplyXDBCWYpVYY8SzPmNnsKbR4EpVwFfFaoYh8uaVc8ZbGu7jrYf4yC8yErxpYhn1mZuWnXDteGQTWXCoaKYYVeJUgVfvpr6AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788727; c=relaxed/simple;
	bh=FAFhhl35hQrGaQq6uIILPA4fOfWWgo5D53c0t0WSXRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUtGnzSmVcVkPEBkYBYzd83/7DjymZEOPlgPKm6W61aJ5Wkflo7KTEhrAtUe5ioG7dVlPcjH4Q7BWmlRB96pXMzHmFrB3DZvQlyXEoCs0c5SC2YykP/5CCdJOtLN+5961rNKFeh5fYWkAynlyQgAK4o7slQsXtLO0xDUk3YO5Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LujIqZfW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vHfuFbMq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LujIqZfW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vHfuFbMq"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FMO288028986;
	Wed, 16 Apr 2025 07:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1IW12fyX1YAYHUHJnxlNxiweoHlZIKmHtK1VQxHSkm8=; b=
	LujIqZfWf9lVLKj+oLdhBwAtzyfVGpFzEktFWyS6pR+GUEqAvqqYhtfcWdJUWBXg
	ztk+09NNCbkeZ5+/MK8ygVXsvYm14aOhli7LeaLwM7wMZw3W3mm7hooe4StPMm8D
	5IMDMbWY+Nq3JrKC0rarMrI9lUuniB5J1reZAwhBpl+EMgbNw1O8MDUUBVwnEemo
	XQAJ0hB0/CD1cgj30eBmX6y4Do7cg0TBrkwiyCJsxuWZ81iXrXzlcXCMs8KUabqN
	WNB0gTude5V5croobGxsx420GPUFtUpWvy/GglQqLuFpgsBzYHwtiTVj6K406p5x
	tziENIBUDl2oSSYTb0BsZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf3muh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 07:31:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53G6u1KI030973;
	Wed, 16 Apr 2025 07:31:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbbrje9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 07:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXWqucgs0qoMYMtkUHjDlmfGxtqnVLoMO4KusitwXBSMR1sJQpXP49PZykPkck9ZMzlTdq+bib8TBsPwc4glkD4Fr7pJLh39pg5x6x5ZJAVs6jv9l8OZmD7ZqoYl4V7PIPMq8SV6zlLNn0AK6vFebJvSpb4O+jDIYjArQu58mntW6qJ8K+MRc5hfooRBmm2gMDJEUDewGIPn649xRTSOonjEtGlb3uv78dFliWofAqUyk21cXOuai5rjxY9sK0PFN3rtb2Rgyefn+5hLNVt2ouurNqP+Esc6GoHrKcsjd8QpIhjG35ALtCGcxLCMkjvb0oZTliKR62VP91K8mMclNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IW12fyX1YAYHUHJnxlNxiweoHlZIKmHtK1VQxHSkm8=;
 b=m3nyeRSL/mAhPMU39PqPoMpCoh+ZitQQZ8CAPRfMv5zRVvA0iY1W451r8wwwGpqWXGeik2lnwzIUBTPJ3gC+pi62VDNVuKtjFh80bWdsgF4hYh7NOTrshIVIPvCqu2K0e5+5erOUlaH9gVIgx+H5JKuBOlOdoqM/hgxL6hfbz1q3R8kkp68OtAFwvKBNBwndhQ4O3f8R5FFGSzZjSn3L1W8layjL/CD0uo6QzXwa9bBnadWJwP3DIjqbA5GC+gFGmWFp2vDKY58h6aRg8DGhJogYBsp2Qkq8OLaHzhmrMHmJHeEYBjWHa9LFdK4mgA7eNllqCdzt6NnC9mDDLoM7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IW12fyX1YAYHUHJnxlNxiweoHlZIKmHtK1VQxHSkm8=;
 b=vHfuFbMqMN5yS5xgxB0PfZRgC456nhcSnTHJK7SpmxMN14LnNvEOeDeTaR6cLVrqNVwbAFEHjDq/r6xYRL3dZ2jsfNBBeXDPLJ7NOJAfWbVx/DZr1tmJK5eaCN3iDMVoSm4n/1pqV5yPStt+FOah8MNATGsUHxcN0A452GQ/nv8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7367.namprd10.prod.outlook.com (2603:10b6:930:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 07:31:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 07:31:41 +0000
Date: Wed, 16 Apr 2025 08:31:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: move mmap/vma locking logic into specific files
Message-ID: <9cb5ccfe-85e6-4a07-bb4e-f17b2f04c453@lucifer.local>
References: <cover.1744720574.git.lorenzo.stoakes@oracle.com>
 <acd557ff58c49aec6a83955b62de026687a79fa9.1744720574.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHg8ru9a3jQFaGRqJA0hpTODXXstqbLAJqy7bH9RfpE7Q@mail.gmail.com>
 <70ff330e-b199-4c0a-bfda-478b3e50de80@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70ff330e-b199-4c0a-bfda-478b3e50de80@paulmck-laptop>
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: e432c62d-44b8-4956-b5c3-08dd7cb8baf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW9MUlJqd1ZnajJKb04wbmMyRnJUcWdXaTdJYjRwWUtlMmZzdnJoOS9KNmxa?=
 =?utf-8?B?WlpCRkVjc1JDR21sb1JMYnNOYlAwcDdqdjBNQ1BDM1BncC9vY2FZUG9haXpO?=
 =?utf-8?B?VFZNUjdqTWVnQlE5N2drbCtUWGxxVXRFYkE0SE9mK012eHQ1RldrVXM1Q0Vz?=
 =?utf-8?B?OFdVemRPTWc4anVST3JaZWcyZEVoUjFwVE5qQlVxeDVpeTRRQlF3ZjhmS3VY?=
 =?utf-8?B?OUFTVjIwSFFGd1EyT0JuTm1ZWWc1MEw3em5oYkltalIrZmF2N2ZxUHFYendq?=
 =?utf-8?B?U0lzYTBQT1Uzb3c2b1o0ZGppdUpkZWJ6TEljTWE3UVFvQ2c4N0JuUWlMQm5F?=
 =?utf-8?B?TG1PUVlDVXFDTW9GcE5ZY25sbFNjd3ViSDZMNm40NUdPZG02VjdwN00xK3A0?=
 =?utf-8?B?TkwxUW9SNlNaMVN4OFI0TjQybzBFMXcraGxJSzZHV0hFdFpVSHNZSURkbWdk?=
 =?utf-8?B?czJjd0xZTmprZXYzaGN1NDR6a1IwTkY1bnBucWNwYTRIbHJpY0hGWG5iMnlj?=
 =?utf-8?B?d1ArUVhvSG1EdHUvVW5vdnFGOFBiUW1PUWNKSHVEMWd5QjFnQzMrODM0MU10?=
 =?utf-8?B?OFhsUjdkRm0xNGoyY0oxMlhpbzJlZVlyYzdEOS9SYUhlNlhSM09PM3Zabi9Q?=
 =?utf-8?B?TEZrQm9nRjRYZHYyUVgwT0UzaTN4cjNUclJvOVJaZDNNSll3NGx0RVRIUUtr?=
 =?utf-8?B?dVZkVHRIalBzNjg4cGMvU3hCUHJGZ09BdUVtcjRKaDJPQ09SVStPTkFMRGYz?=
 =?utf-8?B?REw0bGxRbVAzN2xpN3BUWU9UaVZNYXVZcEdjN0liUU1Ubmx6SEhTdFVzTThE?=
 =?utf-8?B?Rm9qR1RTQ1NkZ1p3OWF1dUo1bUxCNUZ2d3IrZk02WGhRaE5RUG1FQ1Fqc0Uv?=
 =?utf-8?B?R2d1b2R1bE45QlpkRkpyVDUrenc1S3VQTlc3cG5EajZyMGZJSHhLN1M5ays3?=
 =?utf-8?B?WlRNWjB0aUROTUZSd2x6RHRIWWtJb1djU2EyTFFRalpjdldLRHh1T0lPdC9w?=
 =?utf-8?B?WDAvSmQzWlAxZ0pUQkZDYkFKRWdhUnlrcWc2Y1NRZTYrVVp1bWtpUk1sZ3VU?=
 =?utf-8?B?OEYvdVFtQzNJbnhHTDE1UTVaRGRxcnhMWldxNThBbEwrS3NJNW1hK3pjTVZX?=
 =?utf-8?B?Uys1blVZWkY1UGFhakI1alJKSDFUeFJKUlNKNGg2UzNxa1JTRmhxQitYbnpv?=
 =?utf-8?B?c0Z0d3Y0ZSsvWHZ5UmVvZEFVR3JJdktndU03YkdPWkp1NmdHT1ViK1d0bVBa?=
 =?utf-8?B?NWo3eVpaYWxZVUZhVWlYejAzRnl0QlBFQ1lMbmlIRHBrT2dudEVUN2Q2NEE4?=
 =?utf-8?B?eGVUanBNK3NKNERVSFlRalc1RkhFWTdWQll6NXJBZGRJVEtVNGR0ekhMeDJx?=
 =?utf-8?B?ZkdKS2hjWWt3c2lCUEw0alN4dTdUL2IxRlNnaDZwY0pyYXJ2T0lyd1lnR0dK?=
 =?utf-8?B?cTY2S3o4Q2J5aHl6WXJFY3FjSTZkdmp4Sy9mdzZTYWVwVHlvTjROQ2tNUzU1?=
 =?utf-8?B?R0FZYm5pazdocTVKSTh4WS84MnZoeVlPdjIwaTkwbU1lUlJGOGtIcGJKdVZG?=
 =?utf-8?B?WWcxbVlhd1g1OWN1UFNRdDhkYU9IUHE3eUo3WnZENUV1WWwzRURyanRHdXJ4?=
 =?utf-8?B?VTN0K0ZBcEF4Z1NKMjNlczZXNDZxb3FyWEdQUElMcWhDOTBuZ0JPUGNreEUr?=
 =?utf-8?B?TUxBRDlnWm4xMmZpYWRFZ3NUb2paZUxSU29WVERFY1pYekdTQXNuemliS2Vl?=
 =?utf-8?B?azBnaU9mK1NCakxDT3g0YTVoQ0lOZ21HMzRva0ZtVnVTbFNvaE8rQXRqVEhQ?=
 =?utf-8?B?N0dSVXpTTHVNSisySE5WUng4blFDUzNKRmdraXVqT0dRLzVSeWFBWVB3TDdY?=
 =?utf-8?B?ODQyRXV3OTdPTHZrT0o3V21ZWGRKbU11MFFtVGtBWnczbEd3NG4vWHl2eis5?=
 =?utf-8?Q?gBv6OnMzx4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9nRnNLZzM2Wjc4ck5jQkllVmE1bVFJUHZ2c1ZGekEwT3QzTTVwbXQvVzcy?=
 =?utf-8?B?eHpWRlJ0RlZCVmh6VXdyOHFtcFFTMEQ5dFIxYVpyMWtzN2VPOEhyTVdRQVcy?=
 =?utf-8?B?NG1LR3FKZkFReXpnS0dmSmJFMmFyWDB3Skt0WFBnTmd6ZW5xTkQvaGlkSUk3?=
 =?utf-8?B?bmZjTWpQem1VY3A0N20rMlVkZ1F0aldZenF2TjNyc204WDhlK2R2dUdqRk9u?=
 =?utf-8?B?YW55VXVZekp5L3ZOVU9lSys1R3pNUW94VWdkdG82Sng1dS8vN2JDb2VuK0FQ?=
 =?utf-8?B?bjk1YUQ5UC9BUmgvNFlVR2VZdEFiTzF1a08rSkpneGhMenhLZzFMMGltV2Mx?=
 =?utf-8?B?bzBvUXNWTUJydmo5SitUL0o5YllWdzRLaHVqMEt6SEwxMnFjSTBYVTFKNlRJ?=
 =?utf-8?B?aVRPNHNGa3dmUWZrYzJTNXdSR3lxZ29WakhrNnRYblpYMFJHMytOSk4xRGR1?=
 =?utf-8?B?SjJoakIzdDdPUGhQT1UxZjQyQ2dxV0Z5NFhUTldROElWNnl3bnpKeXVSbXBL?=
 =?utf-8?B?UzFUMXUyL0o5VklQMDhhbUhDNEl1U0JWSUVQNVFEK2xkQmlmR0x2clBObEdp?=
 =?utf-8?B?bVhwcm1NQUM1bjN6QjVMS3F4YmUxUVpWTzU3NEpzbjNZaERKSEpDRGFJYjVH?=
 =?utf-8?B?QXlLekhaTGFYcStuOVNlU0JROFdUdEZFc0RsU0VrZHlpcXh4Y3hsZFFVVysy?=
 =?utf-8?B?SnNtVC9ITXhqaDR6bEtUZlFPZnhtTU1ja0lmTTFEWVRSNjUzSnBtSjlPcW03?=
 =?utf-8?B?UkVURnpHQk5RdTdmek1OeHNHQ2FTQjlwZERvSndyekhvVGh0dk1QRUF0Vm5N?=
 =?utf-8?B?a0VWaWxBVUdrQ3dLQ21RZDdxUDZsMlRHNFlpc244NUhPS04vVzJ2VG9iM1FK?=
 =?utf-8?B?ZTNETGcvSmVrQ3JYRGFBS2U3UlBGeUxwbTEwYy9MVEM2K2I1OFBGd1pwcEdS?=
 =?utf-8?B?c1M5M1l5Q1VDV3ljWnpPSURNdDh2MmtwK2pPV3h5Z2tnMURyc0dYZjhneGdw?=
 =?utf-8?B?dVdhMDdSRnRWRlR1aFRETklFeWpKdnpzUkdQR3Z4OTNtTnltS3pXZlRYcjdC?=
 =?utf-8?B?c1h2cFkwd3ZsSmlQLzBCcXBnNTExZTlicGVEWVdQZWJuTHlmMUVDVTlvRzhH?=
 =?utf-8?B?d0VZNWxBdjArSGRYSVUzNVZtNGlZZmNRU3ZmMW83dkIveXBoRDdlV2xUcm12?=
 =?utf-8?B?QjZBRDRSSzVYV3IzTFZNTXJpcnBGL0VqQmdOSFYzaDV4U0hScldLVEpDNFM5?=
 =?utf-8?B?M3FGdkN2N2VmeEVxa3BzcDZkSTFKNUVSYVdnQlV5dHNnRStISmZvWlc2QXpq?=
 =?utf-8?B?RTZrbHBsSGVmOSs3UzNiNWtNM2J6aW1Ld0xvdzh0b2ZjUUtpWkpzRVNCYUhr?=
 =?utf-8?B?Z1JLNzhkMnN2alM4RjEwSERDcmpGbmV2RXBZVU5nOXIyNGpBNHlzeGJ5TXo2?=
 =?utf-8?B?dG10KzFDY0t5Si91Tzd4K0JvNDlTL1ZvOGVjdStxV1NSeW9UY3AvWDAwQ0dB?=
 =?utf-8?B?NlhzV2VjUENrbWtjV1dzdGJzSTNwWEowOGJYUmI4YmR5am9ZMHVFRmkvbktz?=
 =?utf-8?B?bUM1V0xRak5hNkRaSDhCRGpUdThGRG0rKzFjejBEYlZvWGpLQ3IvWnlwekZ5?=
 =?utf-8?B?UVBqZ0VHTzN6TlY2RW5XZCs3Wjg0cUZYTHYrNGljdWVNWnRQd29TQVdXWkhN?=
 =?utf-8?B?YzNzT2dtUUNOVUN3WnZHcm93bUlrWE41U2R2dDVCdFZLeE5ZZnRRSm44RlAy?=
 =?utf-8?B?ZEo2ZlF1RVVkaVBUQXBoeEJoYURUYW8vK3h1ZkEvUkFuWEo3QWUzQzJpYWJ0?=
 =?utf-8?B?RDhuaFRGNW1IOGVRRitscHRaeW5QOTJXQXM1RURHdFY4Rkp2MDMycmJYb1dB?=
 =?utf-8?B?WWh0MXp4bHZJdlMrMnkyUm9aTHd5UnhKVDZCbWt2YUhFaEZSMVRFbTN1OGU1?=
 =?utf-8?B?OWhhOTZQWjBmR29VSVc2RVVXWExlK0JXQzVtNDRpVEY2QkwycTFxTFhDU1A4?=
 =?utf-8?B?UXh5ZnA5ZEZRU0NVOWZ6Mk9WbmNsTEdnL1F1a1J0RExBWUJ1WGcvcVB5ZWh5?=
 =?utf-8?B?R2JsWnQvZXRFYzlDOGFpVStWZDVXeFBZUXdXeE1RR011MU5CVU5VOUZBRDZp?=
 =?utf-8?B?NlNFOFd6TndoZG5EVk5OS2dLV0FuM1E4cExsd3pSZlBoMDJnR0djUHNvM0dH?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BtnN9vge14ZbZnvV6286WDinQcxPWxc19Qi6i4gIVfZutJ2bm5f2S1dyXljjJGwHAMV+/bnkqR7K5OtGMW6dNDbX6L8QlY2gOkyuX7rHe8ioyYG3rRNVqE20klrARknh6k0xzTtbEpRD9099JpZtUvPSIcOsNs/e7VZe29f+lnqa6FEzofUKwGcbQqtRzD/0dUOq1fx2OmaWWXqfKFRIU5L2cz2czkAHMbKKk/weRdVmuXV9Dngii+0dBE9GzB6GfhmBfyG/+ZozaHQFbdHvDzsYrRlUOuVO4M/xEijqBaHC3lyagr6CGRGYLb4vXShzbu0Kpjvn+4tVLzglB9U2NjMkX1XGiwY4bVhpBG689iiRj95omMZ4nyXFZjWEsZPGq9ds9GMEVlbunUoaS9jrXK9zrLSGl5Kwh59T8aSMkNv1DYW9LLwcRJx1USbd+EDv42wtrgdbKkZ96PoEuddXRVn3f7Wfw5T7X7oqVn10sZ90Y04QqHCyni0YC6QekuLACuiL6LXOQfB72iA+rJ2twDO254iNTpVyB17vOftjyenRtwetyqzLdRoAzV5Up/U3zs3O6z/hsHEDrR5K6gt1iNjGEqeTjjKAS61jWRTYyVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e432c62d-44b8-4956-b5c3-08dd7cb8baf3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 07:31:41.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEt6tfHztowB+XcHGXFHlAxyX5rr6jlxugQKa+YCFWZlrNoo5iGof2z6n4DBerM9/4L3K7k5hARLn1G/rkdJPvTlyJBB/9UufxGC34Qse2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160060
X-Proofpoint-GUID: xTUWJ_ZClFnYZoqlMYSZjTQ7q4BZD7I_
X-Proofpoint-ORIG-GUID: xTUWJ_ZClFnYZoqlMYSZjTQ7q4BZD7I_

On Tue, Apr 15, 2025 at 10:58:41AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 15, 2025 at 09:06:46AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Apr 15, 2025 at 6:11 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Currently the VMA and mmap locking logic is entangled in two of the most
> > > overwrought files in mm - include/linux/mm.h and mm/memory.c. Separate this
> > > logic out so we can more easily make changes and create an appropriate
> > > MAINTAINERS entry that spans only the logic relating to locking.
> > >
> > > This should have no functional change. Care is taken to avoid dependency
> > > loops, we must regrettably keep release_fault_lock() and
> > > assert_fault_locked() in mm.h as a result due to the dependence on the
> > > vm_fault type.
> > >
> > > Additionally we must declare rcuwait_wake_up() manually to avoid a
> > > dependency cycle on linux/rcuwait.h.
> >
> > The king of refactoring strikes again :)
>
> Should us RCU guys be doing something different to make this less of
> a problem?

I'm not sure it's really viable as you probably need types that make things
circular there and not really worth fiddling around with just to suit this,
though ideally perhaps we'd put the rcuwait_wake_up() declaration somewhere
more central like include/linux/mm_types.h or something like this.

But that'd also suck obviously...

>
> 							Thanx, Paul
>
> > On a serious note, thanks a lot for doing this! The code is much more
> > organized this way IMO.
> > I noticed a couple nits (see below) but otherwise LGTM. With those
> > addressed feel free to add:
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  include/linux/mm.h        | 231 +---------------------------------
> > >  include/linux/mmap_lock.h | 227 +++++++++++++++++++++++++++++++++
> > >  mm/memory.c               | 252 -------------------------------------
> > >  mm/mmap_lock.c            | 255 ++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 486 insertions(+), 479 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 5eb0d77c4438..9b701cfbef22 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -671,204 +671,11 @@ static inline void vma_numab_state_init(struct vm_area_struct *vma) {}
> > >  static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
> > >  #endif /* CONFIG_NUMA_BALANCING */
> > >
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> > > -{
> > > -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > -       static struct lock_class_key lockdep_key;
> > > -
> > > -       lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
> > > -#endif
> > > -       if (reset_refcnt)
> > > -               refcount_set(&vma->vm_refcnt, 0);
> > > -       vma->vm_lock_seq = UINT_MAX;
> > > -}
> > > -
> > > -static inline bool is_vma_writer_only(int refcnt)
> > > -{
> > > -       /*
> > > -        * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
> > > -        * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
> > > -        * a detached vma happens only in vma_mark_detached() and is a rare
> > > -        * case, therefore most of the time there will be no unnecessary wakeup.
> > > -        */
> > > -       return refcnt & VMA_LOCK_OFFSET && refcnt <= VMA_LOCK_OFFSET + 1;
> > > -}
> > > -
> > > -static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > -{
> > > -       /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> > > -       struct mm_struct *mm = vma->vm_mm;
> > > -       int oldcnt;
> > > -
> > > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > -       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> > > -
> > > -               if (is_vma_writer_only(oldcnt - 1))
> > > -                       rcuwait_wake_up(&mm->vma_writer_wait);
> > > -       }
> > > -}
> > > -
> > > -/*
> > > - * Try to read-lock a vma. The function is allowed to occasionally yield false
> > > - * locked result to avoid performance overhead, in which case we fall back to
> > > - * using mmap_lock. The function should never yield false unlocked result.
> > > - * False locked result is possible if mm_lock_seq overflows or if vma gets
> > > - * reused and attached to a different mm before we lock it.
> > > - * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
> > > - * detached.
> > > - */
> > > -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > > -                                                   struct vm_area_struct *vma)
> > > -{
> > > -       int oldcnt;
> > > -
> > > -       /*
> > > -        * Check before locking. A race might cause false locked result.
> > > -        * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> > > -        * ACQUIRE semantics, because this is just a lockless check whose result
> > > -        * we don't rely on for anything - the mm_lock_seq read against which we
> > > -        * need ordering is below.
> > > -        */
> > > -       if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
> > > -               return NULL;
> > > -
> > > -       /*
> > > -        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
> > > -        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> > > -        * Acquire fence is required here to avoid reordering against later
> > > -        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> > > -        */
> > > -       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > > -                                                             VMA_REF_LIMIT))) {
> > > -               /* return EAGAIN if vma got detached from under us */
> > > -               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > > -       }
> > > -
> > > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > > -       /*
> > > -        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
> > > -        * False unlocked result is impossible because we modify and check
> > > -        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
> > > -        * modification invalidates all existing locks.
> > > -        *
> > > -        * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> > > -        * racing with vma_end_write_all(), we only start reading from the VMA
> > > -        * after it has been unlocked.
> > > -        * This pairs with RELEASE semantics in vma_end_write_all().
> > > -        */
> > > -       if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
> > > -               vma_refcount_put(vma);
> > > -               return NULL;
> > > -       }
> > > -
> > > -       return vma;
> > > -}
> > > -
> > > -/*
> > > - * Use only while holding mmap read lock which guarantees that locking will not
> > > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > > - * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > > - * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > > - */
> > > -static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> > > -{
> > > -       int oldcnt;
> > > -
> > > -       mmap_assert_locked(vma->vm_mm);
> > > -       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > > -                                                             VMA_REF_LIMIT)))
> > > -               return false;
> > > -
> > > -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > > -       return true;
> > > -}
> > > -
> > > -/*
> > > - * Use only while holding mmap read lock which guarantees that locking will not
> > > - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > > - * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > > - * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > > - */
> > > -static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> > > -{
> > > -       return vma_start_read_locked_nested(vma, 0);
> > > -}
> > > -
> > > -static inline void vma_end_read(struct vm_area_struct *vma)
> > > -{
> > > -       vma_refcount_put(vma);
> > > -}
> > > -
> > > -/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
> > > -static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
> > > -{
> > > -       mmap_assert_write_locked(vma->vm_mm);
> > > -
> > > -       /*
> > > -        * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > > -        * mm->mm_lock_seq can't be concurrently modified.
> > > -        */
> > > -       *mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
> > > -       return (vma->vm_lock_seq == *mm_lock_seq);
> > > -}
> > > -
> > > -void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq);
> > > -
> > > -/*
> > > - * Begin writing to a VMA.
> > > - * Exclude concurrent readers under the per-VMA lock until the currently
> > > - * write-locked mmap_lock is dropped or downgraded.
> > > - */
> > > -static inline void vma_start_write(struct vm_area_struct *vma)
> > > -{
> > > -       unsigned int mm_lock_seq;
> > > -
> > > -       if (__is_vma_write_locked(vma, &mm_lock_seq))
> > > -               return;
> > > -
> > > -       __vma_start_write(vma, mm_lock_seq);
> > > -}
> > > -
> > > -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > > -{
> > > -       unsigned int mm_lock_seq;
> > > -
> > > -       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > > -}
> > > -
> > > -static inline void vma_assert_locked(struct vm_area_struct *vma)
> > > -{
> > > -       unsigned int mm_lock_seq;
> > > -
> > > -       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > > -                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > > -}
> > > -
> > >  /*
> > > - * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
> > > - * assertions should be made either under mmap_write_lock or when the object
> > > - * has been isolated under mmap_write_lock, ensuring no competing writers.
> > > + * These must be here rather than mmap_lock.h as dependent on vm_fault type,
> > > + * declared in this header.
> > >   */
> > > -static inline void vma_assert_attached(struct vm_area_struct *vma)
> > > -{
> > > -       WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
> > > -}
> > > -
> > > -static inline void vma_assert_detached(struct vm_area_struct *vma)
> > > -{
> > > -       WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
> > > -}
> > > -
> > > -static inline void vma_mark_attached(struct vm_area_struct *vma)
> > > -{
> > > -       vma_assert_write_locked(vma);
> > > -       vma_assert_detached(vma);
> > > -       refcount_set_release(&vma->vm_refcnt, 1);
> > > -}
> > > -
> > > -void vma_mark_detached(struct vm_area_struct *vma);
> > > -
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > >  static inline void release_fault_lock(struct vm_fault *vmf)
> > >  {
> > >         if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > @@ -884,36 +691,7 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
> > >         else
> > >                 mmap_assert_locked(vmf->vma->vm_mm);
> > >  }
> > > -
> > > -struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > -                                         unsigned long address);
> > > -
> > > -#else /* CONFIG_PER_VMA_LOCK */
> > > -
> > > -static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
> > > -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > > -                                                   struct vm_area_struct *vma)
> > > -               { return NULL; }
> > > -static inline void vma_end_read(struct vm_area_struct *vma) {}
> > > -static inline void vma_start_write(struct vm_area_struct *vma) {}
> > > -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > > -               { mmap_assert_write_locked(vma->vm_mm); }
> > > -static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> > > -static inline void vma_assert_detached(struct vm_area_struct *vma) {}
> > > -static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> > > -static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> > > -
> > > -static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > -               unsigned long address)
> > > -{
> > > -       return NULL;
> > > -}
> > > -
> > > -static inline void vma_assert_locked(struct vm_area_struct *vma)
> > > -{
> > > -       mmap_assert_locked(vma->vm_mm);
> > > -}
> > > -
> > > +#else
> > >  static inline void release_fault_lock(struct vm_fault *vmf)
> > >  {
> > >         mmap_read_unlock(vmf->vma->vm_mm);
> > > @@ -923,7 +701,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
> > >  {
> > >         mmap_assert_locked(vmf->vma->vm_mm);
> > >  }
> > > -
> > >  #endif /* CONFIG_PER_VMA_LOCK */
> > >
> > >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index 4706c6769902..7983b2efe9bf 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -1,6 +1,10 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > >  #ifndef _LINUX_MMAP_LOCK_H
> > >  #define _LINUX_MMAP_LOCK_H
> > >
> > > +/* Avoid a dependency loop by declaring here. */
> > > +extern int rcuwait_wake_up(struct rcuwait *w);
> > > +
> > >  #include <linux/lockdep.h>
> > >  #include <linux/mm_types.h>
> > >  #include <linux/mmdebug.h>
> > > @@ -104,6 +108,206 @@ static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int
> > >         return read_seqcount_retry(&mm->mm_lock_seq, seq);
> > >  }
> > >
> > > +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> > > +{
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +       static struct lock_class_key lockdep_key;
> > > +
> > > +       lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
> > > +#endif
> > > +       if (reset_refcnt)
> > > +               refcount_set(&vma->vm_refcnt, 0);
> > > +       vma->vm_lock_seq = UINT_MAX;
> > > +}
> > > +
> > > +static inline bool is_vma_writer_only(int refcnt)
> > > +{
> > > +       /*
> > > +        * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
> > > +        * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
> > > +        * a detached vma happens only in vma_mark_detached() and is a rare
> > > +        * case, therefore most of the time there will be no unnecessary wakeup.
> > > +        */
> > > +       return refcnt & VMA_LOCK_OFFSET && refcnt <= VMA_LOCK_OFFSET + 1;
> > > +}
> > > +
> > > +static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > +{
> > > +       /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> > > +       struct mm_struct *mm = vma->vm_mm;
> > > +       int oldcnt;
> > > +
> > > +       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > +       if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> > > +
> > > +               if (is_vma_writer_only(oldcnt - 1))
> > > +                       rcuwait_wake_up(&mm->vma_writer_wait);
> > > +       }
> > > +}
> > > +
> > > +/*
> > > + * Try to read-lock a vma. The function is allowed to occasionally yield false
> > > + * locked result to avoid performance overhead, in which case we fall back to
> > > + * using mmap_lock. The function should never yield false unlocked result.
> > > + * False locked result is possible if mm_lock_seq overflows or if vma gets
> > > + * reused and attached to a different mm before we lock it.
> > > + * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
> > > + * detached.
> > > + */
> > > +static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > > +                                                   struct vm_area_struct *vma)
> > > +{
> > > +       int oldcnt;
> > > +
> > > +       /*
> > > +        * Check before locking. A race might cause false locked result.
> > > +        * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> > > +        * ACQUIRE semantics, because this is just a lockless check whose result
> > > +        * we don't rely on for anything - the mm_lock_seq read against which we
> > > +        * need ordering is below.
> > > +        */
> > > +       if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
> > > +               return NULL;
> > > +
> > > +       /*
> > > +        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
> > > +        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> > > +        * Acquire fence is required here to avoid reordering against later
> > > +        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> > > +        */
> > > +       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > > +                                                             VMA_REF_LIMIT))) {
> > > +               /* return EAGAIN if vma got detached from under us */
> > > +               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > > +       }
> > > +
> > > +       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > > +       /*
> > > +        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
> > > +        * False unlocked result is impossible because we modify and check
> > > +        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
> > > +        * modification invalidates all existing locks.
> > > +        *
> > > +        * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> > > +        * racing with vma_end_write_all(), we only start reading from the VMA
> > > +        * after it has been unlocked.
> > > +        * This pairs with RELEASE semantics in vma_end_write_all().
> > > +        */
> > > +       if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
> > > +               vma_refcount_put(vma);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       return vma;
> > > +}
> > > +
> > > +/*
> > > + * Use only while holding mmap read lock which guarantees that locking will not
> > > + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > > + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > > + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > > + */
> > > +static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
> > > +{
> > > +       int oldcnt;
> > > +
> > > +       mmap_assert_locked(vma->vm_mm);
> > > +       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
> > > +                                                             VMA_REF_LIMIT)))
> > > +               return false;
> > > +
> > > +       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > > +       return true;
> > > +}
> > > +
> > > +/*
> > > + * Use only while holding mmap read lock which guarantees that locking will not
> > > + * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> > > + * not be used in such cases because it might fail due to mm_lock_seq overflow.
> > > + * This functionality is used to obtain vma read lock and drop the mmap read lock.
> > > + */
> > > +static inline bool vma_start_read_locked(struct vm_area_struct *vma)
> > > +{
> > > +       return vma_start_read_locked_nested(vma, 0);
> > > +}
> > > +
> > > +static inline void vma_end_read(struct vm_area_struct *vma)
> > > +{
> > > +       vma_refcount_put(vma);
> > > +}
> > > +
> > > +/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
> > > +static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
> > > +{
> > > +       mmap_assert_write_locked(vma->vm_mm);
> > > +
> > > +       /*
> > > +        * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> > > +        * mm->mm_lock_seq can't be concurrently modified.
> > > +        */
> > > +       *mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
> > > +       return (vma->vm_lock_seq == *mm_lock_seq);
> > > +}
> > > +
> > > +void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq);
> > > +
> > > +/*
> > > + * Begin writing to a VMA.
> > > + * Exclude concurrent readers under the per-VMA lock until the currently
> > > + * write-locked mmap_lock is dropped or downgraded.
> > > + */
> > > +static inline void vma_start_write(struct vm_area_struct *vma)
> > > +{
> > > +       unsigned int mm_lock_seq;
> > > +
> > > +       if (__is_vma_write_locked(vma, &mm_lock_seq))
> > > +               return;
> > > +
> > > +       __vma_start_write(vma, mm_lock_seq);
> > > +}
> > > +
> > > +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > > +{
> > > +       unsigned int mm_lock_seq;
> > > +
> > > +       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > > +}
> > > +
> > > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > > +{
> > > +       unsigned int mm_lock_seq;
> > > +
> > > +       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > > +                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > > +}
> > > +
> > > +/*
> > > + * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
> > > + * assertions should be made either under mmap_write_lock or when the object
> > > + * has been isolated under mmap_write_lock, ensuring no competing writers.
> > > + */
> > > +static inline void vma_assert_attached(struct vm_area_struct *vma)
> > > +{
> > > +       WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
> > > +}
> > > +
> > > +static inline void vma_assert_detached(struct vm_area_struct *vma)
> > > +{
> > > +       WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
> > > +}
> > > +
> > > +static inline void vma_mark_attached(struct vm_area_struct *vma)
> > > +{
> > > +       vma_assert_write_locked(vma);
> > > +       vma_assert_detached(vma);
> > > +       refcount_set_release(&vma->vm_refcnt, 1);
> > > +}
> > > +
> > > +void vma_mark_detached(struct vm_area_struct *vma);
> > > +
> > > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > +                                         unsigned long address);
> > > +
> > >  #else /* CONFIG_PER_VMA_LOCK */
> > >
> > >  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > > @@ -119,6 +323,29 @@ static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int
> > >  {
> > >         return true;
> > >  }
> > > +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
> > > +static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
> > > +                                                   struct vm_area_struct *vma)
> > > +               { return NULL; }
> > > +static inline void vma_end_read(struct vm_area_struct *vma) {}
> > > +static inline void vma_start_write(struct vm_area_struct *vma) {}
> > > +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > > +               { mmap_assert_write_locked(vma->vm_mm); }
> > > +static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> > > +static inline void vma_assert_detached(struct vm_area_struct *vma) {}
> > > +static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> > > +static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> > > +
> > > +static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > +               unsigned long address)
> > > +{
> > > +       return NULL;
> > > +}
> > > +
> > > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > > +{
> > > +       mmap_assert_locked(vma->vm_mm);
> > > +}
> > >
> > >  #endif /* CONFIG_PER_VMA_LOCK */
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 688f3612e16d..35cfc91d5a2e 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -6378,258 +6378,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > >  }
> > >  EXPORT_SYMBOL_GPL(handle_mm_fault);
> > >
> > > -#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > > -#include <linux/extable.h>
> > > -
> > > -static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > > -{
> > > -       if (likely(mmap_read_trylock(mm)))
> > > -               return true;
> > > -
> > > -       if (regs && !user_mode(regs)) {
> > > -               unsigned long ip = exception_ip(regs);
> > > -               if (!search_exception_tables(ip))
> > > -                       return false;
> > > -       }
> > > -
> > > -       return !mmap_read_lock_killable(mm);
> > > -}
> > > -
> > > -static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
> > > -{
> > > -       /*
> > > -        * We don't have this operation yet.
> > > -        *
> > > -        * It should be easy enough to do: it's basically a
> > > -        *    atomic_long_try_cmpxchg_acquire()
> > > -        * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
> > > -        * it also needs the proper lockdep magic etc.
> > > -        */
> > > -       return false;
> > > -}
> > > -
> > > -static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > > -{
> > > -       mmap_read_unlock(mm);
> > > -       if (regs && !user_mode(regs)) {
> > > -               unsigned long ip = exception_ip(regs);
> > > -               if (!search_exception_tables(ip))
> > > -                       return false;
> > > -       }
> > > -       return !mmap_write_lock_killable(mm);
> > > -}
> > > -
> > > -/*
> > > - * Helper for page fault handling.
> > > - *
> > > - * This is kind of equivalent to "mmap_read_lock()" followed
> > > - * by "find_extend_vma()", except it's a lot more careful about
> > > - * the locking (and will drop the lock on failure).
> > > - *
> > > - * For example, if we have a kernel bug that causes a page
> > > - * fault, we don't want to just use mmap_read_lock() to get
> > > - * the mm lock, because that would deadlock if the bug were
> > > - * to happen while we're holding the mm lock for writing.
> > > - *
> > > - * So this checks the exception tables on kernel faults in
> > > - * order to only do this all for instructions that are actually
> > > - * expected to fault.
> > > - *
> > > - * We can also actually take the mm lock for writing if we
> > > - * need to extend the vma, which helps the VM layer a lot.
> > > - */
> > > -struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> > > -                       unsigned long addr, struct pt_regs *regs)
> > > -{
> > > -       struct vm_area_struct *vma;
> > > -
> > > -       if (!get_mmap_lock_carefully(mm, regs))
> > > -               return NULL;
> > > -
> > > -       vma = find_vma(mm, addr);
> > > -       if (likely(vma && (vma->vm_start <= addr)))
> > > -               return vma;
> > > -
> > > -       /*
> > > -        * Well, dang. We might still be successful, but only
> > > -        * if we can extend a vma to do so.
> > > -        */
> > > -       if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
> > > -               mmap_read_unlock(mm);
> > > -               return NULL;
> > > -       }
> > > -
> > > -       /*
> > > -        * We can try to upgrade the mmap lock atomically,
> > > -        * in which case we can continue to use the vma
> > > -        * we already looked up.
> > > -        *
> > > -        * Otherwise we'll have to drop the mmap lock and
> > > -        * re-take it, and also look up the vma again,
> > > -        * re-checking it.
> > > -        */
> > > -       if (!mmap_upgrade_trylock(mm)) {
> > > -               if (!upgrade_mmap_lock_carefully(mm, regs))
> > > -                       return NULL;
> > > -
> > > -               vma = find_vma(mm, addr);
> > > -               if (!vma)
> > > -                       goto fail;
> > > -               if (vma->vm_start <= addr)
> > > -                       goto success;
> > > -               if (!(vma->vm_flags & VM_GROWSDOWN))
> > > -                       goto fail;
> > > -       }
> > > -
> > > -       if (expand_stack_locked(vma, addr))
> > > -               goto fail;
> > > -
> > > -success:
> > > -       mmap_write_downgrade(mm);
> > > -       return vma;
> > > -
> > > -fail:
> > > -       mmap_write_unlock(mm);
> > > -       return NULL;
> > > -}
> > > -#endif
> > > -
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -static inline bool __vma_enter_locked(struct vm_area_struct *vma, bool detaching)
> > > -{
> > > -       unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
> > > -
> > > -       /* Additional refcnt if the vma is attached. */
> > > -       if (!detaching)
> > > -               tgt_refcnt++;
> > > -
> > > -       /*
> > > -        * If vma is detached then only vma_mark_attached() can raise the
> > > -        * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
> > > -        */
> > > -       if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
> > > -               return false;
> > > -
> > > -       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > > -       rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> > > -                  refcount_read(&vma->vm_refcnt) == tgt_refcnt,
> > > -                  TASK_UNINTERRUPTIBLE);
> > > -       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > > -
> > > -       return true;
> > > -}
> > > -
> > > -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
> > > -{
> > > -       *detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
> > > -       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > -}
> > > -
> > > -void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
> > > -{
> > > -       bool locked;
> > > -
> > > -       /*
> > > -        * __vma_enter_locked() returns false immediately if the vma is not
> > > -        * attached, otherwise it waits until refcnt is indicating that vma
> > > -        * is attached with no readers.
> > > -        */
> > > -       locked = __vma_enter_locked(vma, false);
> > > -
> > > -       /*
> > > -        * We should use WRITE_ONCE() here because we can have concurrent reads
> > > -        * from the early lockless pessimistic check in vma_start_read().
> > > -        * We don't really care about the correctness of that early check, but
> > > -        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
> > > -        */
> > > -       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > -
> > > -       if (locked) {
> > > -               bool detached;
> > > -
> > > -               __vma_exit_locked(vma, &detached);
> > > -               WARN_ON_ONCE(detached); /* vma should remain attached */
> > > -       }
> > > -}
> > > -EXPORT_SYMBOL_GPL(__vma_start_write);
> > > -
> > > -void vma_mark_detached(struct vm_area_struct *vma)
> > > -{
> > > -       vma_assert_write_locked(vma);
> > > -       vma_assert_attached(vma);
> > > -
> > > -       /*
> > > -        * We are the only writer, so no need to use vma_refcount_put().
> > > -        * The condition below is unlikely because the vma has been already
> > > -        * write-locked and readers can increment vm_refcnt only temporarily
> > > -        * before they check vm_lock_seq, realize the vma is locked and drop
> > > -        * back the vm_refcnt. That is a narrow window for observing a raised
> > > -        * vm_refcnt.
> > > -        */
> > > -       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> > > -               /* Wait until vma is detached with no readers. */
> > > -               if (__vma_enter_locked(vma, true)) {
> > > -                       bool detached;
> > > -
> > > -                       __vma_exit_locked(vma, &detached);
> > > -                       WARN_ON_ONCE(!detached);
> > > -               }
> > > -       }
> > > -}
> > > -
> > > -/*
> > > - * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
> > > - * stable and not isolated. If the VMA is not found or is being modified the
> > > - * function returns NULL.
> > > - */
> > > -struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > -                                         unsigned long address)
> > > -{
> > > -       MA_STATE(mas, &mm->mm_mt, address, address);
> > > -       struct vm_area_struct *vma;
> > > -
> > > -       rcu_read_lock();
> > > -retry:
> > > -       vma = mas_walk(&mas);
> > > -       if (!vma)
> > > -               goto inval;
> > > -
> > > -       vma = vma_start_read(mm, vma);
> > > -       if (IS_ERR_OR_NULL(vma)) {
> > > -               /* Check if the VMA got isolated after we found it */
> > > -               if (PTR_ERR(vma) == -EAGAIN) {
> > > -                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > -                       /* The area was replaced with another one */
> > > -                       goto retry;
> > > -               }
> > > -
> > > -               /* Failed to lock the VMA */
> > > -               goto inval;
> > > -       }
> > > -       /*
> > > -        * At this point, we have a stable reference to a VMA: The VMA is
> > > -        * locked and we know it hasn't already been isolated.
> > > -        * From here on, we can access the VMA without worrying about which
> > > -        * fields are accessible for RCU readers.
> > > -        */
> > > -
> > > -       /* Check if the vma we locked is the right one. */
> > > -       if (unlikely(vma->vm_mm != mm ||
> > > -                    address < vma->vm_start || address >= vma->vm_end))
> > > -               goto inval_end_read;
> > > -
> > > -       rcu_read_unlock();
> > > -       return vma;
> > > -
> > > -inval_end_read:
> > > -       vma_end_read(vma);
> > > -inval:
> > > -       rcu_read_unlock();
> > > -       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > > -       return NULL;
> > > -}
> > > -#endif /* CONFIG_PER_VMA_LOCK */
> > > -
> > >  #ifndef __PAGETABLE_P4D_FOLDED
> > >  /*
> > >   * Allocate p4d page table.
> > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > index e7dbaf96aa17..7e4a1f467a46 100644
> > > --- a/mm/mmap_lock.c
> > > +++ b/mm/mmap_lock.c
> > > @@ -42,3 +42,258 @@ void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
> > >  }
> > >  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
> > >  #endif /* CONFIG_TRACING */
> > > +
> > > +#ifdef CONFIG_MMU
> >
> > I think we should also move NOMMU version of lock_mm_and_find_vma()
> > into this file and these #ifdefs will become:
> >
> > #ifdef CONFIG_PER_VMA_LOCK
> > ...
> > #endif /* CONFIG_PER_VMA_LOCK */
> >
> > #ifdef CONFIG_MMU
> >     #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> >     // MMU version of lock_mm_and_find_vma() and helpers
> >     #endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
> > #else /* CONFIG_MMU */
> >     // NOMMU version of lock_mm_and_find_vma()
> > #endif /* CONFIG_MMU */
> >
> > Note that CONFIG_PER_VMA_LOCK already depends on CONFIG_NOMMU.
> >
> > Also something I just noticed. Are we missing lock_mm_and_find_vma()
> > implementation for CONFIG_MMU && !CONFIG_LOCK_MM_AND_FIND_VMA ? I'm
> > guessing architectures with !CONFIG_STACK_GROWSUP just don't use this
> > function?
> >
> >
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +static inline bool __vma_enter_locked(struct vm_area_struct *vma, bool detaching)
> > > +{
> > > +       unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
> > > +
> > > +       /* Additional refcnt if the vma is attached. */
> > > +       if (!detaching)
> > > +               tgt_refcnt++;
> > > +
> > > +       /*
> > > +        * If vma is detached then only vma_mark_attached() can raise the
> > > +        * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
> > > +        */
> > > +       if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
> > > +               return false;
> > > +
> > > +       rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > > +       rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
> > > +                  refcount_read(&vma->vm_refcnt) == tgt_refcnt,
> > > +                  TASK_UNINTERRUPTIBLE);
> > > +       lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
> > > +{
> > > +       *detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
> > > +       rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > +}
> > > +
> > > +void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
> > > +{
> > > +       bool locked;
> > > +
> > > +       /*
> > > +        * __vma_enter_locked() returns false immediately if the vma is not
> > > +        * attached, otherwise it waits until refcnt is indicating that vma
> > > +        * is attached with no readers.
> > > +        */
> > > +       locked = __vma_enter_locked(vma, false);
> > > +
> > > +       /*
> > > +        * We should use WRITE_ONCE() here because we can have concurrent reads
> > > +        * from the early lockless pessimistic check in vma_start_read().
> > > +        * We don't really care about the correctness of that early check, but
> > > +        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
> > > +        */
> > > +       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > +
> > > +       if (locked) {
> > > +               bool detached;
> > > +
> > > +               __vma_exit_locked(vma, &detached);
> > > +               WARN_ON_ONCE(detached); /* vma should remain attached */
> > > +       }
> > > +}
> > > +EXPORT_SYMBOL_GPL(__vma_start_write);
> > > +
> > > +void vma_mark_detached(struct vm_area_struct *vma)
> > > +{
> > > +       vma_assert_write_locked(vma);
> > > +       vma_assert_attached(vma);
> > > +
> > > +       /*
> > > +        * We are the only writer, so no need to use vma_refcount_put().
> > > +        * The condition below is unlikely because the vma has been already
> > > +        * write-locked and readers can increment vm_refcnt only temporarily
> > > +        * before they check vm_lock_seq, realize the vma is locked and drop
> > > +        * back the vm_refcnt. That is a narrow window for observing a raised
> > > +        * vm_refcnt.
> > > +        */
> > > +       if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
> > > +               /* Wait until vma is detached with no readers. */
> > > +               if (__vma_enter_locked(vma, true)) {
> > > +                       bool detached;
> > > +
> > > +                       __vma_exit_locked(vma, &detached);
> > > +                       WARN_ON_ONCE(!detached);
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +/*
> > > + * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
> > > + * stable and not isolated. If the VMA is not found or is being modified the
> > > + * function returns NULL.
> > > + */
> > > +struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > > +                                         unsigned long address)
> > > +{
> > > +       MA_STATE(mas, &mm->mm_mt, address, address);
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       rcu_read_lock();
> > > +retry:
> > > +       vma = mas_walk(&mas);
> > > +       if (!vma)
> > > +               goto inval;
> > > +
> > > +       vma = vma_start_read(mm, vma);
> > > +       if (IS_ERR_OR_NULL(vma)) {
> > > +               /* Check if the VMA got isolated after we found it */
> > > +               if (PTR_ERR(vma) == -EAGAIN) {
> > > +                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > +                       /* The area was replaced with another one */
> > > +                       goto retry;
> > > +               }
> > > +
> > > +               /* Failed to lock the VMA */
> > > +               goto inval;
> > > +       }
> > > +       /*
> > > +        * At this point, we have a stable reference to a VMA: The VMA is
> > > +        * locked and we know it hasn't already been isolated.
> > > +        * From here on, we can access the VMA without worrying about which
> > > +        * fields are accessible for RCU readers.
> > > +        */
> > > +
> > > +       /* Check if the vma we locked is the right one. */
> > > +       if (unlikely(vma->vm_mm != mm ||
> > > +                    address < vma->vm_start || address >= vma->vm_end))
> > > +               goto inval_end_read;
> > > +
> > > +       rcu_read_unlock();
> > > +       return vma;
> > > +
> > > +inval_end_read:
> > > +       vma_end_read(vma);
> > > +inval:
> > > +       rcu_read_unlock();
> > > +       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> > > +       return NULL;
> > > +}
> > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > +
> > > +#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > > +#include <linux/extable.h>
> > > +
> > > +static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > > +{
> > > +       if (likely(mmap_read_trylock(mm)))
> > > +               return true;
> > > +
> > > +       if (regs && !user_mode(regs)) {
> > > +               unsigned long ip = exception_ip(regs);
> > > +               if (!search_exception_tables(ip))
> > > +                       return false;
> > > +       }
> > > +
> > > +       return !mmap_read_lock_killable(mm);
> > > +}
> > > +
> > > +static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
> > > +{
> > > +       /*
> > > +        * We don't have this operation yet.
> > > +        *
> > > +        * It should be easy enough to do: it's basically a
> > > +V       *    atomic_long_try_cmpxchg_acquire()
> >
> > Is the extra V above just the result of "Ctrl+V" gone bad?
> >
> > > +        * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
> > > +        * it also needs the proper lockdep magic etc.
> > > +        */
> > > +       return false;
> > > +}
> > > +
> > > +static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
> > > +{
> > > +       mmap_read_unlock(mm);
> > > +       if (regs && !user_mode(regs)) {
> > > +               unsigned long ip = exception_ip(regs);
> > > +               if (!search_exception_tables(ip))
> > > +                       return false;
> > > +       }
> > > +       return !mmap_write_lock_killable(mm);
> > > +}
> > > +
> > > +/*
> > > + * Helper for page fault handling.
> > > + *
> > > + * This is kind of equivalent to "mmap_read_lock()" followed
> > > + * by "find_extend_vma()", except it's a lot more careful about
> > > + * the locking (and will drop the lock on failure).
> > > + *
> > > + * For example, if we have a kernel bug that causes a page
> > > + * fault, we don't want to just use mmap_read_lock() to get
> > > + * the mm lock, because that would deadlock if the bug were
> > > + * to happen while we're holding the mm lock for writing.
> > > + *
> > > + * So this checks the exception tables on kernel faults in
> > > + * order to only do this all for instructions that are actually
> > > + * expected to fault.
> > > + *
> > > + * We can also actually take the mm lock for writing if we
> > > + * need to extend the vma, which helps the VM layer a lot.
> > > + */
> > > +struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> > > +                       unsigned long addr, struct pt_regs *regs)
> > > +{
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       if (!get_mmap_lock_carefully(mm, regs))
> > > +               return NULL;
> > > +
> > > +       vma = find_vma(mm, addr);
> > > +       if (likely(vma && (vma->vm_start <= addr)))
> > > +               return vma;
> > > +
> > > +       /*
> > > +        * Well, dang. We might still be successful, but only
> > > +        * if we can extend a vma to do so.
> > > +        */
> > > +       if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
> > > +               mmap_read_unlock(mm);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       /*
> > > +        * We can try to upgrade the mmap lock atomically,
> > > +        * in which case we can continue to use the vma
> > > +        * we already looked up.
> > > +        *
> > > +        * Otherwise we'll have to drop the mmap lock and
> > > +        * re-take it, and also look up the vma again,
> > > +        * re-checking it.
> > > +        */
> > > +       if (!mmap_upgrade_trylock(mm)) {
> > > +               if (!upgrade_mmap_lock_carefully(mm, regs))
> > > +                       return NULL;
> > > +
> > > +               vma = find_vma(mm, addr);
> > > +               if (!vma)
> > > +                       goto fail;
> > > +               if (vma->vm_start <= addr)
> > > +                       goto success;
> > > +               if (!(vma->vm_flags & VM_GROWSDOWN))
> > > +                       goto fail;
> > > +       }
> > > +
> > > +       if (expand_stack_locked(vma, addr))
> > > +               goto fail;
> > > +
> > > +success:
> > > +       mmap_write_downgrade(mm);
> > > +       return vma;
> > > +
> > > +fail:
> > > +       mmap_write_unlock(mm);
> > > +       return NULL;
> > > +}
> > > +#endif /* CONFIG_LOCK_MM_AND_FIND_VMA */
> > > +
> > > +#endif /* CONFIG_MMU */
> > > --
> > > 2.49.0
