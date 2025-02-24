Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFE802;
	Mon, 24 Feb 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402547; cv=fail; b=cFEdy1duZUaATvWyaUijX8rA3XhNsEb7lp83wiVeXNY9kPN5maeyx6j59i0duqIWNlqudVxqTpgyYGDQu6xsBnHtlsHGcN+eROf2qlJAuHkqVJjLOThQH2k9VqErYO9BFyuJF0181AJnpwbl7zGnB2HSrzUTDDG+PmrHqe4zTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402547; c=relaxed/simple;
	bh=BJrgQMPJmbdm0DroKoxmcvzNAPTNf5AB2zLP/DF/jng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBi2+Ti98IjSGdML7HXZVEMPs3TQyhZdM6vdW3BJzBEpI0n1xsl5F2GVjVEwlVIahHozdiBEPpI2ip66vr2dHKEWB6kRoihTNnkpwr+5RgEfH3tnLdHKI6iS6hAlnyCQ/qedNasZAFZgSDnFW0l5HngYSKKyivOp8XtCu6luG+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QtLHwxmI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nwQZidE+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QtLHwxmI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nwQZidE+"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBN6R9020929;
	Mon, 24 Feb 2025 13:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Yd16uS5CV87KJnQUNd
	1Qckd2EylXdikJw5JILATrUyI=; b=QtLHwxmIqlzpUFsvlFpzMkIPLgpFv9sFEP
	zm7jxa4lxQ2w24ti8XCsqcEkKs1UQXDE22FuFP+OKj9uSKUIOkygx58sG4cV1Re9
	EuQuC8xmOg1n4d9mSYhcZT7QobZLqlj7YvoxuZwpW4MuMS3EznOHTLO1uFnZadrW
	g6eo+cQ/TvY9ICXX1PFP49adfhENJLgYBBFASwn7ju3OJcvFF8Wnd8NY15WFHc5c
	EEWDlUQrDzK/ObtkYUOW7vDBaNAYmRNnsEXPuFEn01D56V9OC338txrmmiiHePtV
	jcY2CXJlbEPrhP5W9QXCc+MNlQWZYLF+rxCzsu4QpFM2fHpXHedA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2aj36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:08:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBAAe2002767;
	Mon, 24 Feb 2025 13:08:39 GMT
Received: from outbound.mail.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517v9ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaBT0L08z4dtyhzdYVwye7KvcMtBFqEzdD9+TtN+H8C18wVF1X6I0JfaGxAQ3HHN4aSjxsCo9lk64lrD17ZPnaVeIc2eWimfvGW+77Lu3q+RPjxmX8I2nji0MmPK40LPPlKac/BWAMIcz8MT+2Y3pF3PTypBqKMbeJT0oVNcwlgWqz6j5Ws3v8u1EHOPmxA7H3KXcn0LjwU+d7ksDxpOO4xEPU+cWhKBDpjBtAjjMD2Ofm88qFBkUryCUGLgsxmQhluZ8V6Bat4Qrdh4zvBXl5TfkEXM4TJJCQ2v+2N/Wh2K0Co28AvsBrg3FtaaZoG3QipN48wYuP/J2H7gbRNU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd16uS5CV87KJnQUNd1Qckd2EylXdikJw5JILATrUyI=;
 b=Y+lXGP7Ts3tFPaBFomyqwTXBooXMoOmi7crJZUHToUcPNzVaVO+6cHJbIyCGyPsuiTqjDoIK+VXw1DH2CsxSrUtCVFd++xWLnj19/1IhfRdzuLW1UVv8TYUdKYMYtN1/HqU/t9loYeLBIIN+YGv6s9MdIo47lTUv7JvreCvwkl/g5F/bCGklu/5+awOxsJhoBREz0ZcU69IXHDKJ+cJCEmFuiZwCnBkGKnJL6KJD9GZzOtNxpVrjG12wtlZ/FWW7fyKTBjpIa7Ry+RxvkcOlBJoLZ0cZQEtpArt2DDJw/y5wA2IkrQ8oXjlWnPIU442hT1qcCDKt9qTGtN3rgRD5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd16uS5CV87KJnQUNd1Qckd2EylXdikJw5JILATrUyI=;
 b=nwQZidE+T7pGrSEobvdCtlby8sVajFUSUMqMPEiQGpXPb71B8oTy/s73HkbXfTCirwUeWt2PF6tUOlbdSn8hW0LuRaCEJ/yLAAA/sfZOu00qBp0aDqDP+vUcTcVbdnfjfdS6bpB/mITMAfEFtXyOcA4eznAhDAoBoix0j0fBx9s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 13:08:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:08:21 +0000
Date: Mon, 24 Feb 2025 22:08:09 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 05/10] slab: switch percpu sheaves locking to
 localtry_lock
Message-ID: <Z7xvOdhbXdRp3YPU@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-5-88592ee0966a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-5-88592ee0966a@suse.cz>
X-ClientProxiedBy: SE2P216CA0022.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 268aa2fc-fcb1-4ad1-ec0b-08dd54d45052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mroBkW0UqAo15RsRPnEn1jFKWFtRLcL/GghtxhXe9ZtINggvun1FAp4c1+j3?=
 =?us-ascii?Q?wVTCNRxaSL7cymC7GCXjlVe+w0XmbYrX+b3rbReSMJ+w8Ng1IjyvG52lWry3?=
 =?us-ascii?Q?gY4JexvJuaJEkszzz5ZQHjzuhRJLaYcZvVKTJ1m0UO/2564m6P2crJ+x/x4R?=
 =?us-ascii?Q?5aS/hoe4dW2pY418fOZ3l9rlRNJQ4kCUuF882AaEqGHuwyz9ryOi/cut1YY6?=
 =?us-ascii?Q?2kxZ71IK6lRc+fT1ycBRDPInkJ+U7z4COcEu191qzBz/Wz2B3jkwBbXcge+S?=
 =?us-ascii?Q?JiTpxRRxcvPMU6GG7wx72mB5y4dclNv6cVTzWIk9Ifkl9xHSm/PIiCsvDpZb?=
 =?us-ascii?Q?rImayOrbt60mlRMC+Seq1u3RzC44dkit+oZgn3xPB+4WvKIqSUZgQVbr1ufI?=
 =?us-ascii?Q?okSQ6GYNovZpFbLi6gJIOvpcnLCMdIVl2pk9Npy39lS/nUWL62UW5CkuBV8t?=
 =?us-ascii?Q?QnE9WvVkef2xcSjakm93M/4qPkeTBfLmdV6TqwS9Xusk0tOw90pJmvV9sLAy?=
 =?us-ascii?Q?qiQMiLxrSjzdo578c5r4/BxCYxcA/Fzre1zm5SfvjA4lQIgLMBO3cMpRD5fu?=
 =?us-ascii?Q?HGNKlvEHNW4KQJ8PKJi4XiR3ZAflYjzYgegtjxZYAk0ZIzpOObFxjNB7pOM3?=
 =?us-ascii?Q?VMAyy5CF2NZdqULJ89PVna8yYA6nnBOdCSrEJs8HYmLtJOwwABzvj3qZxmPk?=
 =?us-ascii?Q?zWdYm4IIykxFmUIsYzt5zFgY7d9V6vEbJqu6VlL1pFIWNZcvnhi+gRN1FfD4?=
 =?us-ascii?Q?loFImcoPLywME5aUpXWs063khSW2meWH1vLMpTGnIoPBmngu3XK8JnkF3lpT?=
 =?us-ascii?Q?MSmBRhAHJIACS47KSQbXkEnhKRip/FnSiiFT59BK5jc1YZWc+HlWzrabU833?=
 =?us-ascii?Q?HRjR4EX6KmosrDJ8bs/KE/S9025Pbr+t+r8wrmTJPggofqe9ai2iLM+6R9+M?=
 =?us-ascii?Q?OUnxS/6KYLx9PTR2C4B9rwuKVpvuNUP6INUxvkLWnDhR/9eLv6Y0Xw3MU6xa?=
 =?us-ascii?Q?7XpYCBsgozyi2IgAxVELJicvEDLICbHurDZ7ifjFYCUIGmrIHFQtm3kzP3+U?=
 =?us-ascii?Q?AKhaD73k6jRjVkJDVOIq17wsXSeBmb6D3KOpa2wACpju9gFK0UpK6TVKeXXj?=
 =?us-ascii?Q?Au41deIfQILhdeglYlaYIplWaAUmz/MnqQafbRW3hHrLqpSjFOLNS8OXe8P6?=
 =?us-ascii?Q?q1Geqwga2LOAX2nG7mUSxYVx9MSFEHbJR6ye4XDvFhm18CosG9rrjZ8T7wWn?=
 =?us-ascii?Q?WwF8Z/3aQAbT4+nhHaTlB/eisgYsCbBXO4CH8TEpsKMdUZ08m7QeciN+7CLx?=
 =?us-ascii?Q?y8pdv8gnW30D+TWqDK9Q76c9rdonqgH7GWwu4b8np+XPdAFtET1gb+BQ/Cou?=
 =?us-ascii?Q?Si6aCy3625XoiE6R59c7iexornVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0Yim9ICJ84vqdhbvehood8P4fnjuLVj3QbYN0L2FuKObdl6RTHQ2OwJJWN5?=
 =?us-ascii?Q?4bUcyuncREsjicxhy/KS1H5PIVW47RDMfT0goMn9tCyVhftx1vYeqL7f6fJ/?=
 =?us-ascii?Q?YQMkrGj1QIbGbF2A6GLRrEIBfFa37/cfQLsT9NiQNT9v0oFonmE3ARiDaXXs?=
 =?us-ascii?Q?paexLq6PXKIoXBOtPM7SfZaiWdfSBln81ohTyhtA2VSIAELmLkd1sO7nbNVO?=
 =?us-ascii?Q?yIzbg3MtPXStyE5wyiGgjVJOwr+sSyA89QKRHDMP3RW2guKqT/6l3q/S4Y85?=
 =?us-ascii?Q?H6dCkrcHI57HlJi2nYA6gJaMtvYMWzlm2WIl440HMnBqyTCJg+fMvNwfsxbJ?=
 =?us-ascii?Q?ehG/wHNvXl662EMqNX4YvHZnaektrhgRiYgwbu4NJK3e+QnaF1XngdiuKDUS?=
 =?us-ascii?Q?460aWi9r1bh5IYgWDDrxdwmF+jryzTmnY8dsgpMeghCW1AO+WZXkLv6AVIwu?=
 =?us-ascii?Q?BjJTMhsYl4N8Qbchcg34Tc+eA7fhHmMQ6mc8pRp0u+f5ss4ipodEzzp9U+JQ?=
 =?us-ascii?Q?bRqilqFSZNZwIiVMebRtAGDAvRn+6zKNMLmHoO8MNEs1SFARht0QNfIkZwii?=
 =?us-ascii?Q?9bZDDPmKaocwHgVGqqo6QBWpSLW36xM1hCYKh9l4+nLTlFJKzOH+nDo0Ww+T?=
 =?us-ascii?Q?caIK2dN/W1ap5x17Hr+jFFIodGNwOpEWuokTzTymLR/sM6hQzZCxknoZMkne?=
 =?us-ascii?Q?iAYqCXth083x9BG1tslS2j3h/1zbYAn1QNkv3i0fo1eklcObFLpFqZUfH+nm?=
 =?us-ascii?Q?y/EWhrG2FVYhqkHeDLWw4NuVIa1Nd0T+eOpzbj4QgffrNSsB5ysNa6ZSdnYK?=
 =?us-ascii?Q?KMbJTQkFmjNqwadapll6Yms9bW1tlh1VkiXnDMmFS/JzJiUaKLvbxW9Ntibz?=
 =?us-ascii?Q?vv5kcZwXiQLSY7FYpeAxUXG/HJ2ahv08At+VD0Q5WaDdV8s669cNX2iiSkBR?=
 =?us-ascii?Q?kPPV0NjvAd1OlxxxLTO5+k6+htMnHQDTW2zaW3QsnTHeNhirgB1DF/H8rto4?=
 =?us-ascii?Q?9WGCbOqMVtgWqxEE4Xbfwtr3YMyPVbnZSW/np+TqsQYd7zxsg3lI2N4uEMXy?=
 =?us-ascii?Q?6H0KYqI2lPu+Zt4oT0qveDCLRPbcprKP/gCFHBVbQeM2srMGd7oOsUGi2xcp?=
 =?us-ascii?Q?jYH90dLQ4ZIO9H9/4AzJ5tqlGw133+wJFxidv0rL82dqy5t47+c1+WoRfOIg?=
 =?us-ascii?Q?4Po+14+FHBs94s9s6DeRwo7v7QugXySlFoIiW4UOppf9FOcgJNNDfOCFvJfk?=
 =?us-ascii?Q?XseSsLd55byD1Z8+M4Zf4PTV8mm9XiYaTGVSHjgOt+voBB5a7nmVDloR40l6?=
 =?us-ascii?Q?y1Y6Yhx52X54yi/7rVqkqEMnmobqh3zq3L3dN3r4Z9LuGlDA/Jc6ZFGMcyKn?=
 =?us-ascii?Q?/977zxkK02nzQMjX18cz6v2qjd/zeKfF0F4uB8lrZglIuG+iLUyd+S09gtsv?=
 =?us-ascii?Q?9skUMxzBaVapZyXoLG1fFatdRs4yeS2UJ6DH5ZmOC0vrBXNXawqXQnPhDLY3?=
 =?us-ascii?Q?sgaCwdtanvcyUOrKdmQtV2sIm+IcouH94EpCE5cd2lXDEGl3VX3f3fcFflR/?=
 =?us-ascii?Q?DcEunVOz10GLtjw/m2hPekjK7tp8AbRAEsjOjxWVmjTEycjIyjHMzOtGG485?=
 =?us-ascii?Q?Is5BxNaL+dGngnp9L4/Zte8OvTB9ZDiZhFG37nsv88Gu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L0gy8+6J3rtwBz0w1hNTw5tPzZW9U13hfHnSXqwrb9m7wXujk4OXFnH1Z1mOjak9sbvqz/zfgVR6LAd/fjmLfk55pAtxvRjmHeCE3oDNf7pHswjVE0hZlG95LkHrFs3ko/pdbJbMFUjG+NiyZnxq/87E2HB6j8q+Vo/cusRZ5HGFZpsB0gIMruYE7zQY6Jp391Qy+2iCrOfKbRlpb0inbS2wA7sULsuXI7w1XMtsJfKOPU0FDOGzktMbDWeugbw8ePHAdpNLrTeJaxxQHIF5auWN7bu+J614FB9aTA3RkQ7Cvs+Uj3PRLaLYY2TXOa522Lj+VunP9XyP+3rnvmLEx5jjexG6jDtO8rAHerWAYnFR49qOmOfZpBdh9E2dOTEeKKJ13S7/TfqyZzcFW/gYDP8rseoHW9rqXKWUeE8lckYqL5eiF3GhIps2XbfonfCVni63v9RqfLZbRcsjxDQ7wsbX797S46YsMN6sz5iG3ico4SqGnoZh8oHRvcIuK5HPK0fIcXGLJhsAz44rc6rVLkpgbzec81xHsQdNAgN+QG/USBYYGqccPGtXxH0eLNGAuRcPsszN1bAladwb2IIwohyhn9hxNoVJ8BlRNbiqMu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268aa2fc-fcb1-4ad1-ec0b-08dd54d45052
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:08:21.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCQ+2nw5o+lESdPlL6KirSsFJzuILO0f+NkxMKSoXtwtRroUKMAJGIxWXEJl3+av2QEt/q/L2+p7NDw5Ga7ygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240096
X-Proofpoint-ORIG-GUID: XNdOnLmLGNOlDntL2lE-ptjQlNhez3OD
X-Proofpoint-GUID: XNdOnLmLGNOlDntL2lE-ptjQlNhez3OD

On Fri, Feb 14, 2025 at 05:27:41PM +0100, Vlastimil Babka wrote:
> Instead of local_lock_irqsave(), use localtry_trylock() when potential
> callers include irq context, and localtry_lock() otherwise (such as when
> we already know the gfp flags allow blocking).
> 
> This should reduce the locking (due to irq disabling/enabling) overhead.
> Failing to use percpu sheaves in an irq due to preempting an already
> locked user of sheaves should be rare so it's a favorable tradeoff.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

> ---
>  mm/slub.c | 122 ++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 76 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 40175747212fefb27137309b27571abe8d0966e2..3d7345e7e938d53950ed0d6abe8eb0e93cf8f5b1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -450,7 +450,7 @@ struct slab_sheaf {
>  };
>  
>  struct slub_percpu_sheaves {
> -	local_lock_t lock;
> +	localtry_lock_t lock;
>  	struct slab_sheaf *main; /* never NULL when unlocked */
>  	struct slab_sheaf *spare; /* empty or full, may be NULL */
>  	struct slab_sheaf *rcu_free;
> @@ -2529,16 +2529,19 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
>  
>  static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
>  
> -static void sheaf_flush_main(struct kmem_cache *s)
> +/* returns true if at least partially flushed */
> +static bool sheaf_flush_main(struct kmem_cache *s)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	unsigned int batch, remaining;
>  	void *objects[PCS_BATCH_MAX];
>  	struct slab_sheaf *sheaf;
> -	unsigned long flags;
> +	bool ret = false;
>  
>  next_batch:
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		return ret;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  	sheaf = pcs->main;
>  
> @@ -2549,14 +2552,18 @@ static void sheaf_flush_main(struct kmem_cache *s)
>  
>  	remaining = sheaf->size;
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	__kmem_cache_free_bulk(s, batch, &objects[0]);
>  
>  	stat_add(s, SHEAF_FLUSH_MAIN, batch);
>  
> +	ret = true;
> +
>  	if (remaining)
>  		goto next_batch;
> +
> +	return ret;
>  }
>  
>  static void sheaf_flush(struct kmem_cache *s, struct slab_sheaf *sheaf)
> @@ -2593,6 +2600,8 @@ static void rcu_free_sheaf_nobarn(struct rcu_head *head)
>   * Caller needs to make sure migration is disabled in order to fully flush
>   * single cpu's sheaves
>   *
> + * must not be called from an irq
> + *
>   * flushing operations are rare so let's keep it simple and flush to slabs
>   * directly, skipping the barn
>   */
> @@ -2600,9 +2609,8 @@ static void pcs_flush_all(struct kmem_cache *s)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *spare, *rcu_free;
> -	unsigned long flags;
>  
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	localtry_lock(&s->cpu_sheaves->lock);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	spare = pcs->spare;
> @@ -2611,7 +2619,7 @@ static void pcs_flush_all(struct kmem_cache *s)
>  	rcu_free = pcs->rcu_free;
>  	pcs->rcu_free = NULL;
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	if (spare) {
>  		sheaf_flush(s, spare);
> @@ -4554,10 +4562,11 @@ static __fastpath_inline
>  void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
>  {
>  	struct slub_percpu_sheaves *pcs;
> -	unsigned long flags;
>  	void *object;
>  
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		return NULL;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == 0)) {
> @@ -4590,7 +4599,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
>  			}
>  		}
>  
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  
>  		if (!can_alloc)
>  			return NULL;
> @@ -4612,7 +4621,11 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
>  		if (!full)
>  			return NULL;
>  
> -		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +		/*
> +		 * we can reach here only when gfpflags_allow_blocking
> +		 * so this must not be an irq
> +		 */
> +		localtry_lock(&s->cpu_sheaves->lock);
>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  		/*
> @@ -4646,7 +4659,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
>  do_alloc:
>  	object = pcs->main->objects[--pcs->main->size];
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	stat(s, ALLOC_PCS);
>  
> @@ -4658,12 +4671,13 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *main;
> -	unsigned long flags;
>  	unsigned int allocated = 0;
>  	unsigned int batch;
>  
>  next_batch:
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		return allocated;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == 0)) {
> @@ -4683,7 +4697,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  			goto do_alloc;
>  		}
>  
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  
>  		/*
>  		 * Once full sheaves in barn are depleted, let the bulk
> @@ -4701,7 +4715,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	main->size -= batch;
>  	memcpy(p, main->objects + main->size, batch * sizeof(void *));
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	stat_add(s, ALLOC_PCS, batch);
>  
> @@ -5121,13 +5135,14 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>   * The object is expected to have passed slab_free_hook() already.
>   */
>  static __fastpath_inline
> -void free_to_pcs(struct kmem_cache *s, void *object)
> +bool free_to_pcs(struct kmem_cache *s, void *object)
>  {
>  	struct slub_percpu_sheaves *pcs;
> -	unsigned long flags;
>  
>  restart:
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		return false;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
> @@ -5162,7 +5177,7 @@ void free_to_pcs(struct kmem_cache *s, void *object)
>  			struct slab_sheaf *to_flush = pcs->spare;
>  
>  			pcs->spare = NULL;
> -			local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +			localtry_unlock(&s->cpu_sheaves->lock);
>  
>  			sheaf_flush(s, to_flush);
>  			empty = to_flush;
> @@ -5170,17 +5185,27 @@ void free_to_pcs(struct kmem_cache *s, void *object)
>  		}
>  
>  alloc_empty:
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  
>  		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>  
>  		if (!empty) {
> -			sheaf_flush_main(s);
> -			goto restart;
> +			if (sheaf_flush_main(s))
> +				goto restart;
> +			else
> +				return false;
>  		}
>  
>  got_empty:
> -		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +		if (!localtry_trylock(&s->cpu_sheaves->lock)) {
> +			struct node_barn *barn;
> +
> +			barn = get_node(s, numa_mem_id())->barn;
> +
> +			barn_put_empty_sheaf(barn, empty, true);
> +			return false;
> +		}
> +
>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  		/*
> @@ -5209,9 +5234,11 @@ void free_to_pcs(struct kmem_cache *s, void *object)
>  do_free:
>  	pcs->main->objects[pcs->main->size++] = object;
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	stat(s, FREE_PCS);
> +
> +	return true;
>  }
>  
>  static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> @@ -5270,9 +5297,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
> -	unsigned long flags;
>  
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		goto fail;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(!pcs->rcu_free)) {
> @@ -5286,16 +5314,16 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  			goto do_free;
>  		}
>  
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  
>  		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>  
> -		if (!empty) {
> -			stat(s, FREE_RCU_SHEAF_FAIL);
> -			return false;
> -		}
> +		if (!empty)
> +			goto fail;
> +
> +		if (!localtry_trylock(&s->cpu_sheaves->lock))
> +			goto fail;
>  
> -		local_lock_irqsave(&s->cpu_sheaves->lock, flags);
>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  		if (unlikely(pcs->rcu_free))
> @@ -5311,19 +5339,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
>  
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  		stat(s, FREE_RCU_SHEAF);
>  		return true;
>  	}
>  
>  	pcs->rcu_free = NULL;
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
>  
>  	stat(s, FREE_RCU_SHEAF);
> -
>  	return true;
> +
> +fail:
> +	stat(s, FREE_RCU_SHEAF_FAIL);
> +	return false;
>  }
>  
>  /*
> @@ -5335,7 +5366,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *main;
> -	unsigned long flags;
>  	unsigned int batch, i = 0;
>  	bool init;
>  
> @@ -5358,7 +5388,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	}
>  
>  next_batch:
> -	local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		goto fallback;
> +
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
> @@ -5389,13 +5421,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  		}
>  
>  no_empty:
> -		local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +		localtry_unlock(&s->cpu_sheaves->lock);
>  
>  		/*
>  		 * if we depleted all empty sheaves in the barn or there are too
>  		 * many full sheaves, free the rest to slab pages
>  		 */
> -
> +fallback:
>  		__kmem_cache_free_bulk(s, size, p);
>  		return;
>  	}
> @@ -5407,7 +5439,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	memcpy(main->objects + main->size, p, batch * sizeof(void *));
>  	main->size += batch;
>  
> -	local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +	localtry_unlock(&s->cpu_sheaves->lock);
>  
>  	stat_add(s, FREE_PCS, batch);
>  
> @@ -5507,9 +5539,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>  
> -	if (s->cpu_sheaves)
> -		free_to_pcs(s, object);
> -	else
> +	if (!s->cpu_sheaves || !free_to_pcs(s, object))
>  		do_slab_free(s, slab, object, object, 1, addr);
>  }
>  
> @@ -6288,7 +6318,7 @@ static int init_percpu_sheaves(struct kmem_cache *s)
>  
>  		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  
> -		local_lock_init(&pcs->lock);
> +		localtry_lock_init(&pcs->lock);
>  
>  		nid = cpu_to_mem(cpu);
>  
> 
> -- 
> 2.48.1
> 
