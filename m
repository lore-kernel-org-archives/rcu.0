Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37A233148;
	Wed,  7 May 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609698; cv=fail; b=NDch2vmdAN/nQ+F0p7f11p1owTmlpnGQzzPFS41KHhyFSm1uPBWDNUjqb3AQUXPUBAcbkbQzN90CsU3xHk8IOSlYbqY5f2ZnPpbtyazk5dkadTtZRGi559EISzdEQRVD+2HjJ4RFr9AlCdXwkys7WV9LPXB0u/xtJOatPrCXJs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609698; c=relaxed/simple;
	bh=+e4EOKhNtsLdzemvB/VofM+e/DDIK7/duqov78RtN6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQPhk6xz79092PH4bfXPFr5W5rapXAkDryCT8claanTsG5pfjfZEd/qcGeHvMsH65NSX8r7FTiDuciNTZgo9tFooM4ySMcfbLoo0YhLEk4RtvFqbroYlA9VQkC53aCUI5z8IF1xhhld1C0UgJamr7O85QS1Yylxbi7ub9rH8OoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qSfu5ww7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wnrQMvQU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qSfu5ww7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wnrQMvQU"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5479ICqG012360;
	Wed, 7 May 2025 09:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6AmB0wwqcfVWA8t/yJ
	3AnzSPXdGPIuWjWbhp/s1x3Sw=; b=qSfu5ww7G+ONXv9A+D4o5C6RL/OfcW4X1C
	PlSMOSIidTyxv2SQOjY62xEPNJqXxK/HPxd1rKsm7ZteqvOFO1OA3QZxSkEhDOMi
	bAieKeemJHTWMjhJHVXKfdYZjdAmT/GQ5AipYoTOoNhWKsAm61FqLelZdK3QMgRG
	q5WcA5nrt/eWXiljAU2e0zhTskUQfFQCQL7r9FsNhW/X5gp7IzSrgT7Nbs8FwZUN
	Iwy3uNaBOTfIXRIs6byGh/J+rR7FMI/sryF2GpKwr0f23JBgN9nC3q/QRI2rJRZl
	tOmU7+O1ZrzYes5ggxPzp4iypcGktrJOKT3Q7F8nFgf4BMmQ9TiA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g4rkg0fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 09:21:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54786sNE025122;
	Wed, 7 May 2025 09:21:14 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012039.outbound.protection.outlook.com [40.93.6.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kgdbrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 09:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbrB91PLrrOxti6bQrS2/iuQmd/VJQSQmddCj37uqgPntiDhGyULhpAKesxV81KCbf954RvXbbYlmHcGN70PW997K3qPYHrvF+WAcbWmoFcRKTpgDpNuOui9EHkyPoVp7QJEZ6U5Qsbf9vNy+L+EcrocCy6eqZmfpBdopHsKIbjuEcyZhaXIuDwKeiKFs9xFgKZr2fkwTKo//IPn//D84n59jcL+7SSrmqPMtlnpvZ/iyYb7Un3tMS8LXf9bOOHAtcSZ+yIIb/B5Xshs+9AlqnsayC5/oP/VvHb9R4HcZRUF+k6lB9OKZZC93DDbbH+Q1Aj8c01+FzPTMJi8PZe7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AmB0wwqcfVWA8t/yJ3AnzSPXdGPIuWjWbhp/s1x3Sw=;
 b=XA9XY35Q+8bdhStc0SxUT29yebGFt5DNu4IVWjW1txGsZIADVxoxhgVXqwnmskzmPg4qcr988yaOcuT0/TW8SR0yk3LUzEawwoMr6cDRm3CGg9m2MPCUen/wNuZ/9owQe9NHxUjAXymHDOKqY+QoTlkBz3kXIptmNdHLWzloBx3DNVH3xQDYnOlfmDfXEPcz3qXNlSGMbV+a/HQJUQRdVPuo2fOxWqcSQUY5Rk2g6y9m4kUFuEAZT7PBXeTN0A4YL3lpc7l++eeXRJRkIO7dSZxa1ZrtKPfPQPV6dPOcQnuB2M/1TTzTuK1QJsT5l0ha8pRkMxySImMqnLQahWpZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AmB0wwqcfVWA8t/yJ3AnzSPXdGPIuWjWbhp/s1x3Sw=;
 b=wnrQMvQUIbpwJ0DqTyXoQSAuZX4T4ZmqbA+D0CcrSbh6yx0tr9YsYnVxqM0Mlw3kmgosownJdkOALiTuJkslagai1j3aeRjtlDEDz8u9JgUEhFUH7V8fQeT6LZa6gUqkAQCCT8hRRDJXM2JSMT+HfmS080Z8sGSUstDY38izIaw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 09:21:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:21:05 +0000
Date: Wed, 7 May 2025 18:20:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 3/9] slab: sheaf prefilling for guaranteed allocations
Message-ID: <aBsl-rfMI_5_67Ya@harry>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
 <aBsktvf4VjQfXGST@harry>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBsktvf4VjQfXGST@harry>
X-ClientProxiedBy: SL2PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:100:55::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 4370f9f3-7a67-41c4-ebcb-08dd8d487e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoGnqqpf8qLC1ps+ZFszlXJQSmvA7iFti8fhkf1YQFHrIan2zzYpo79C6cv0?=
 =?us-ascii?Q?jQYEQw48qMhL3bxrHctJLoQDh0LN07i9SuW7keElcyOOy3vd/1dxsCcV2Cl4?=
 =?us-ascii?Q?b5++EvzUIwguAAsbsKRvhcXTI1Thn1ebd33y88LLmB5O0adAPurlZp9zDA1V?=
 =?us-ascii?Q?36s0VjwCZW1kLOn2eNfpoNOdERWVGw9Ly3O0awL/aUwTglHuzRAIpUNqp9R+?=
 =?us-ascii?Q?RB479YAzRkzgOSPqPBaieCbu0RfznJfe5K3uzi+Et6FejWWA5XbUc6JCnVFi?=
 =?us-ascii?Q?SyW034ItlFu3eF5YIBbbBRgm5VQKTMKZ4+kbmpaSqLvttZnVRfHYXADBuYTn?=
 =?us-ascii?Q?eqmxkstb74M6eHazSNawzwmqCWWMTrxL6Xnf9Rz94bvV3s0D3pEgbfGIOcj8?=
 =?us-ascii?Q?waz4TEuNMpIpK1T98jyvgMTCHjUaKwKaWPMjc1JgtVXKVJ8QcNmTbFcfoMiM?=
 =?us-ascii?Q?1Cy4RFzh0mYEUkEYXZyKYBHDiYqQtXFoEDF1hHlFYdjISgoS5OoQ4R6Hum/O?=
 =?us-ascii?Q?7Zz4qeKhCgIvC0oDaG8Ue9LKGlRYRJ84Q5oXYcPp53KiUYGp+kEAv/v3YzVM?=
 =?us-ascii?Q?T8B1OqdroerXuGmtF5S6ZJ2Qj/m/qeRibJygIk7BK1qCzpDDjPkfWyYLDCxY?=
 =?us-ascii?Q?Al2w2+6pXSwXtkCPxtm2cwenTxMn4t5Xq0Atw+ZqXfLYe2klfT+StJgAvbWq?=
 =?us-ascii?Q?uzLNmCVqvHyPwdcLGZPED0vwjKQ2qjTLi/uvHioviWX0YslM34HB4Zwx6WLR?=
 =?us-ascii?Q?ZsWTJcAWE2lQrYjrVlD/HmBPshOlvC7hRb9IsvddS2oW5rdErz7weal8tW+A?=
 =?us-ascii?Q?Een7X2P7Hxz2GTzoROrcapLpabrAxFun9F3HVUGvWrGnqpBhcV2oJO/hjQ8o?=
 =?us-ascii?Q?DIZYNpM+XMPIre++zwYf6lVNMHCgOcFjCLfYC+Lb9e3YNngC5iUq2zwFE318?=
 =?us-ascii?Q?Gg+yhFUGr8Cn1+0YC5k6g0V0r7RgDtF47aD1155gUR/IvAu1MQ7uJDTyWA3q?=
 =?us-ascii?Q?XmIPgWQgwyzv4c6rRG3lEYrNy63udhGmKOgLRfuhIKkSJeqOCQlx0TLPm5uP?=
 =?us-ascii?Q?s6C+fuAgnVROFfkVjiw/p+etAYvyokTwFwo8D3bNHAH+8TSKW6RnRQrMO+Ti?=
 =?us-ascii?Q?qeKWyHEsJ8aUfP629a0N0rMfX4TJjOOSUZlzU4EYTLlRT97YJXbSkDB9hsdd?=
 =?us-ascii?Q?2GrncyWJWrz9BywXqjUjdmUVaM5SYogZp3gU8vCQwyIGD69v8OsZa1hnvJKX?=
 =?us-ascii?Q?CPqGH9lINA6LzXLMze2IbG1ClKOfq16bSI7rnee9wP4GEMs3YB4GTgGyRSVg?=
 =?us-ascii?Q?RtIubH4+q8DlmRH1w681WIrOEKI1qD4DpAu18fdpIqbhPgl1/3bw+VDEWwVu?=
 =?us-ascii?Q?kQkkvcrUIu9P7k5kQsikG23uFo71NxDMWdbYCiZziXk9flqXIH/rlEa3boO1?=
 =?us-ascii?Q?nSoU6goXpzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALsQS+e+LvLA74o81MH+/7Z00hLX8tJvQ6msCjfoMvs4A+fHpHnic6Qt8bcS?=
 =?us-ascii?Q?So/FoWKOUylIEyfoFXPBj5zLcsS2nMKc3TCUP5l150rr/3H/UWJbYnxxMyxe?=
 =?us-ascii?Q?EWU7du0WsHD671o5Ea3q4WLBmQcs810J0BpFSIhqBxqCePy+J8TFkKxGgYBx?=
 =?us-ascii?Q?n5rthhwsYyTWsIR6oKCMS/rqGpUWgbww/OUqd0ItohOkzxhM9SbGc5PJiZ3r?=
 =?us-ascii?Q?eVpV0bbl+9l/MZMTlshMM2InCcTcTOLWOM4EzcYm7Q0Q1+Svp5jcLs2AmznF?=
 =?us-ascii?Q?LlZQ5Fe49qb+lE3w29IfhkOsX00TZULbxLMc6GGjJUGbYZoPzRZtQWvpRjDu?=
 =?us-ascii?Q?sBcye9+SG/OajUyShWI6saDAmCLq9HWUU2kL9CZZobYQNZ0Fu4pRJ+MFPIn2?=
 =?us-ascii?Q?YZkNynELIDqp3IC+Yzspd/rSvhbrp+9s15VSxtO/doOSZXE7pfE1IuXf0pmp?=
 =?us-ascii?Q?/0CkzIiZUDS1U63B97fgdIFaEYJVWH6RP0ym/3MBMkxCgUtx1kcgKE5+wcYP?=
 =?us-ascii?Q?RLk2u5bKJTcyU/vdMFQKEsp4rYgdUIHHw5ySkf/B7C8f3FAtEsHxFwyby/Pj?=
 =?us-ascii?Q?H7OvB/eDW5V20VFYRSTynNujqYwx7me1NuYVR0aR2yxfaR5ZjEdBe+Elnvkh?=
 =?us-ascii?Q?0SZNMHkhiO98SXKMMNfy3M2RTe0/WlzG4oR2A6lYH8lRhf0mzawmn0rgiMG7?=
 =?us-ascii?Q?PfFrruZyykmQqL6wfXtz7BuT0N0UhDjq+Cg4FvEDrpc2hBHH3EZ+z3deWYCa?=
 =?us-ascii?Q?BzZAA6/s5Tb4WTJiq+Zl+dM4gl6wgYR+7wSi/oaka7Pph5DHaHahvTxJ35nT?=
 =?us-ascii?Q?ac0cvttBjAZWtpa8k93zmrx+JVZnOEHFG/4CIrSwc4pZwuc2vQrMcPVX6naT?=
 =?us-ascii?Q?TK0IoH6YBrdTxbo3QWJsn1rjXWrZEUU17S3jgTdpxyLCbAjGiCpoOBaONF50?=
 =?us-ascii?Q?EWhkMbEoFjNSzD7tQ84A3qFLBhR72AZyGw31ogk+qTngMeePN7DxxfXZkW3A?=
 =?us-ascii?Q?S3a4QcBbgbm4NGIPifqKN3cdlg57oIr8qFeko0+5OrI9Qjo7N+eCacjKeYdL?=
 =?us-ascii?Q?0fJab23RVY1WRB1cAyl/alE+B40rMkXYPTa+hpyF4QkDSj8IUltmMg5q8mUN?=
 =?us-ascii?Q?5eLz4zaob1kOuI+XLZGrQXoEu/4JNpaDYIi8yaKOIcDgUXwLbZtz5jJWKrYq?=
 =?us-ascii?Q?/gjG+0Ii0XSrUsnzwv37ZXrhBOX8G92qCHXl1/4c1duyCOYP9BAtj2IhvXUt?=
 =?us-ascii?Q?lh3qYTwN6qVtcVloPo+r/FsuAtt/goS9nuyELBR6Dl5qNa9Nkd9E1KWideU9?=
 =?us-ascii?Q?h8pJsD/95hfVgL0M+T01Fok7WQhWpjyj6yzXhq3lmVnI4qipUw+RsGsUL/ML?=
 =?us-ascii?Q?IdvnMA//N17xW6EZJ41mYfX5fhg59przBA5AeMTZ/5uhsP56iZYqXOg1ornw?=
 =?us-ascii?Q?wQiWsYSSVT3jBA+sdEO9vFNd6xD6QBv9j38ntAUvfsrrm4Q/UsG0pgfXIy31?=
 =?us-ascii?Q?dlMB6M+ic9fm2bf+6w78mKC+SzZb1dWyhr8nAsFK28jO4bf2S2W5PCyadyT4?=
 =?us-ascii?Q?T11K+uEQszIFTrnxbjhMiknE1nBBUN3gdltFTsWF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MAcQMe4rev5CloeFyUvWve/oiQyifp9W43vL6gYUYXS/uRgHhIm/45aiPFHP3yzHkCL3jThniwcIC+TVgGBXOCF+22imsQR3Z4aDF1YEJMwnNEXXHE6dpbU8fL6aiFFVU1V5kHNda9tSCtsjzjTSjFNW/d/lE7ZVyzEyI9Ou9OwC7A8vIeRbokv9/a/1F7Y7CkBm7z6nujcnvcoPvlYmB5n+jxG0NrPT55aS3F/aJS3fZ1OYp3QVqVO2xcGvnWtCNQPajCTbT6027q+FOaNAKdT9JJhvRh1OZZD671mqn7eY8M+tCi1XN44ZWxrt+AeDzYQj4bobdxAfic/kc5fMHCHdlNIRK8b/4K5OCXEOCX1mctYvdxOBCTEEIgog+L5l2Zg0hPj5xEAReabOKD0tseb3XtELAUTMHX7DhTwQ4ae5gphQ+akgYJ5X/+uY2U1120/GSV6UejYT4IvGiPMW5ApemYbUWCAf3xlafyJk4c02JhW8rLdT2Z4BqpYK8M++if4MnAyWRzCv0U1v0R4PWV4M5Qcp80qtDDbF31I990k67ml6k4+xVXZFIASjEnO1tpv7W9i5i+QSgf9cjg/nLO0dCxPFoBj6zvY4gx0yWWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4370f9f3-7a67-41c4-ebcb-08dd8d487e39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:21:05.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZX7XbLA3ly+xFK+mftf28zdyN4q6pRifKUq2dNo5pFq8fl3QVru0cJwtDpzW1/eW3CRM24uhmP4pvsCzU+V88A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070086
X-Proofpoint-ORIG-GUID: 39ShMfHcWocnLCiKIOed8g5b6oupO9ev
X-Proofpoint-GUID: 39ShMfHcWocnLCiKIOed8g5b6oupO9ev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA4NiBTYWx0ZWRfX6TN2yWDLkfJh 5rmmoRQ+EUSJO5DXt4/7JRDXAGxgtcXrb9o8sCtCbv35ey9ASWL9o6OHaSnXLJuGLVcrzGSyDLW Cqq2FbLiUJ3g9WawqK7uIVJrA2AIjRMPoAj8xnxIExcp1QNBck+ZQGYtLb+trfmvs8yrOENymyo
 sLIJdsZjXTKyIvp3QVhqfZNdGYuxxtCfq33PbTbe/cIwyeaMP0U/HC6EESfJW2A7qpOxH1xen4Z BcK6jJ0cWJt3LV1JMTo6X0kQx8QeN35vvhDFbG3JPHobzw9c3tP11Ul6CpTfecfXGOsv8QAKMXD nHGbyOyd8woBJJbGmbLiIa+svVJSC/k+MNwy6TMNZ3zcDHfhOs62R9OTT1W2UtyW71PWJpNm/dQ
 xrM+uo9k69u+nKw7fmQEl2X63AX8zLSAKd+bRtJ+JeC/JElgv8uyzWdgIiphFbx3X6rQ5HTR
X-Authority-Analysis: v=2.4 cv=Y4b4sgeN c=1 sm=1 tr=0 ts=681b260b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=cGB8cKK8UcuoJliXSLwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185

On Wed, May 07, 2025 at 06:15:34PM +0900, Harry Yoo wrote:
> On Fri, Apr 25, 2025 at 10:27:23AM +0200, Vlastimil Babka wrote:
> > Add functions for efficient guaranteed allocations e.g. in a critical
> > section that cannot sleep, when the exact number of allocations is not
> > known beforehand, but an upper limit can be calculated.
> > 
> > kmem_cache_prefill_sheaf() returns a sheaf containing at least given
> > number of objects.
> > 
> > kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
> > and is guaranteed not to fail until depleted.
> > 
> > kmem_cache_return_sheaf() is for giving the sheaf back to the slab
> > allocator after the critical section. This will also attempt to refill
> > it to cache's sheaf capacity for better efficiency of sheaves handling,
> > but it's not stricly necessary to succeed.
> > 
> > kmem_cache_refill_sheaf() can be used to refill a previously obtained
> > sheaf to requested size. If the current size is sufficient, it does
> > nothing. If the requested size exceeds cache's sheaf_capacity and the
> > sheaf's current capacity, the sheaf will be replaced with a new one,
> > hence the indirect pointer parameter.
> > 
> > kmem_cache_sheaf_size() can be used to query the current size.
> > 
> > The implementation supports requesting sizes that exceed cache's
> > sheaf_capacity, but it is not efficient - such "oversize" sheaves are
> > allocated fresh in kmem_cache_prefill_sheaf() and flushed and freed
> > immediately by kmem_cache_return_sheaf(). kmem_cache_refill_sheaf()
> > might be especially ineffective when replacing a sheaf with a new one of
> > a larger capacity. It is therefore better to size cache's
> > sheaf_capacity accordingly to make oversize sheaves exceptional.
> > 
> > CONFIG_SLUB_STATS counters are added for sheaf prefill and return
> > operations. A prefill or return is considered _fast when it is able to
> > grab or return a percpu spare sheaf (even if the sheaf needs a refill to
> > satisfy the request, as those should amortize over time), and _slow
> > otherwise (when the barn or even sheaf allocation/freeing has to be
> > involved). sheaf_prefill_oversize is provided to determine how many
> > prefills were oversize (counter for oversize returns is not necessary as
> > all oversize refills result in oversize returns).
> > 
> > When slub_debug is enabled for a cache with sheaves, no percpu sheaves
> > exist for it, but the prefill functionality is still provided simply by
> > all prefilled sheaves becoming oversize. If percpu sheaves are not
> > created for a cache due to not passing the sheaf_capacity argument on
> > cache creation, the prefills also work through oversize sheaves, but
> > there's a WARN_ON_ONCE() to indicate the omission.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> with a nit below.
> 
> > +/*
> > + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
> > + *
> > + * If the sheaf cannot simply become the percpu spare sheaf, but there's space
> > + * for a full sheaf in the barn, we try to refill the sheaf back to the cache's
> > + * sheaf_capacity to avoid handling partially full sheaves.
> > + *
> > + * If the refill fails because gfp is e.g. GFP_NOWAIT, or the barn is full, the
> > + * sheaf is instead flushed and freed.
> > + */
> > +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> > +			     struct slab_sheaf *sheaf)
> > +{
> > +	struct slub_percpu_sheaves *pcs;
> > +	bool refill = false;
> > +	struct node_barn *barn;
> > +
> > +	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
> > +		sheaf_flush_unused(s, sheaf);
> > +		kfree(sheaf);
> > +		return;
> > +	}
> > +
> > +	local_lock(&s->cpu_sheaves->lock);
> > +	pcs = this_cpu_ptr(s->cpu_sheaves);
> > +
> > +	if (!pcs->spare) {
> > +		pcs->spare = sheaf;
> > +		sheaf = NULL;
> > +		stat(s, SHEAF_RETURN_FAST);
> > +	} else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
> > +		barn = pcs->barn;
> > +		refill = true;
> > +	}
> > +
> > +	local_unlock(&s->cpu_sheaves->lock);
> > +
> > +	if (!sheaf)
> > +		return;
> > +
> > +	stat(s, SHEAF_RETURN_SLOW);
> > +
> > +	/*
> > +	 * if the barn is full of full sheaves or we fail to refill the sheaf,
> > +	 * simply flush and free it
> > +	 */
> > +	if (!refill || refill_sheaf(s, sheaf, gfp)) {
> > +		sheaf_flush_unused(s, sheaf);
> > +		free_empty_sheaf(s, sheaf);
> > +		return;
> > +	}
> > +
> > +	/* we racily determined the sheaf would fit, so now force it */
> > +	barn_put_full_sheaf(barn, sheaf);
> > +	stat(s, BARN_PUT);
> > +}
> 
> nit: as accessing pcs->barn outside local_lock is safe (it does not go
> away until the cache is destroyed...), this could be simplified a little
> bit:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2bf83e2b85b2..4e1daba4d13e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5043,7 +5043,6 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>  			     struct slab_sheaf *sheaf)
>  {
>  	struct slub_percpu_sheaves *pcs;
> -	bool refill = false;
>  	struct node_barn *barn;
> 
>  	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
> @@ -5059,9 +5058,6 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
>  		pcs->spare = sheaf;
>  		sheaf = NULL;
>  		stat(s, SHEAF_RETURN_FAST);
> -	} else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
> -		barn = pcs->barn;
> -		refill = true;
>  	}
> 
>  	local_unlock(&s->cpu_sheaves->lock);
> @@ -5071,17 +5067,19 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> 
>  	stat(s, SHEAF_RETURN_SLOW);
> 
> +	/* Accessing pcs->barn outside local_lock is safe */
> +	barn = pcs->barn;
> +
>  	/*
>  	 * if the barn is full of full sheaves or we fail to refill the sheaf,
>  	 * simply flush and free it
>  	 */
> -	if (!refill || refill_sheaf(s, sheaf, gfp)) {
> +	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
> +			refill_sheaf(s, sheaf, gfp)) {
>  		sheaf_flush_unused(s, sheaf);
>  		free_empty_sheaf(s, sheaf);
> -		return;

Uh, I shouldn't have deleted this return statement :)

>  	}
> 
> -	/* we racily determined the sheaf would fit, so now force it */
>  	barn_put_full_sheaf(barn, sheaf);
>  	stat(s, BARN_PUT);
>  }
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon
