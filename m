Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36531C6FF5;
	Wed,  7 May 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614404; cv=fail; b=l2898UyPOU2UgK7dXtJw41ZoiZimgXLczbxtYjU4ui6U2isnpcTPb4i2AK/HdAzQPVrccTWNnATVa/1LPHQU6T66SOcFGFgs4UcYx+c+63VYy0wVPaeA7n0w7+lS+DgW8G/+aAjRdWmqiEI3l7zRBAtVTYPDnOizjAgyvr3G/+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614404; c=relaxed/simple;
	bh=NtJ1dObN2KFoMGE4XvKrtnp6jcFVY0fg1t7mYM+XTlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O449o8bJbBWJxnB7btOaTLKo3huivAeN1XKxB2vMS1073TsPOnhaqgeRomxFNPm4VrE3hms1O1kBc/z+2uiKR9EXu9jWMkH8G+lfejFotmmzlVK9nTVM+Ak2LY9p0e9deqQVEBA2AzmxH9Mv6O1BIUjHo8xFl2cTC83H4VCSUZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g2POgFJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J59G/hYt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g2POgFJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J59G/hYt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A70cE012464;
	Wed, 7 May 2025 10:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Kqyzud5RNp/+gZaS//
	TV/1GRwO4iUFfyrHkOgSS4idk=; b=g2POgFJzk6K7ZQOVWUkeTd/eqAIFoO3tt+
	Clc7X06mp9UPvYcOW/SKzAyQBzSDFoyemblXoGvxUNA0DFMhGkFAAIl+3t8Q9Llr
	DSFnOkjklH1TiC8bVQdYRJ9sTmTVrwP1OFI+zfAFz1vZe6tAK8E8qomKylfQUy+/
	CG31MAI36pJ2Ar/06yRUUDR3bEnMr6HpOv8PkMGKqkpQTBlwlq1vsNRkbtzkKhtV
	85I/NAEc57lSs8E8Gz/Epo99EYcoUcpe9uR6w87l8+/4CwKFkSeUJ5sEvwqiXHrT
	ONrA5QA3GIWzlU6DEPJ3JrTKHyp4DEIeteFuMulugsP0rjfFm8Gw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g5fv82th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 10:39:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547AQim6037556;
	Wed, 7 May 2025 10:39:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ka024c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 10:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjRKY4Qv42CfmjD8TcoP5Z67HpmjY+PbdIKqt1BMZZmZgEHqpyMthXYUBPi9N6VeFzAzb8AkzvmOsG8XBy5bnB95lx5TdbfKgyPo0akTuHuGnjs2670a7oY9rLHJTPor2ZWAWx3AiCyjypFYPbfP0hafiWp5XkkeiN9qUW8SKdrbEM8ucJdrS7R5KdnmVMnpI43ejLD/ovj2vjX0MND73g66qfgqtoLUbcebM3nFVdm02X80ec0YkD3iO6lBx+aUhULoJYpFR6Jiu/FPDegCW8Fp08JKsQTVbmE2dCmd5rZ0dHmfLCZXuh6wmRergIVZkPXxU/Gh0HRi3LXiTl9X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqyzud5RNp/+gZaS//TV/1GRwO4iUFfyrHkOgSS4idk=;
 b=ygg21s586HWyDIsuxwMsm2vwhXWMh9T3l8eirXxqOBDAICYoTD1Nb+GTz+cS4F1cHehcE3a7TWoHa6Uo07gmonwA7kSgofY/OhJb3k+qqzaWczF8vYvYHKF5EpLVsSKm9/09P2sW82cpVQCiV33xAisPcXIb2a11TRiLeqSvhaBsVMBp7E+aO3rWpdyYTcGqlRx7fG6J386hsoXEmVfSVqQxeWv/1hNbC1+/H456rAzkv1NfN6rWTqTaROqVKLi/qAOVXgFbi+JWIJ/OEYwiK7o55LcEGzcTLmgXGRDOwnlhl7yY0zNdEumj+ZbqVOLnq8wc/1dLTyfsKkF3SYxyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqyzud5RNp/+gZaS//TV/1GRwO4iUFfyrHkOgSS4idk=;
 b=J59G/hYtz/3PAELz/Kjl3s9QLEHZEYApX/qcUG+DB5/AXErcz9ScE406Wb1VjVlhYhJope3mBlZwKW5hbhNVHN324kPGdj6gDNOR3bASjOOHIm1wM/OXp3SM3WRlmxPTke8ykat9F+/lSVlY2lCinbaIBAU/AtivFOquAvQpN2o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:39:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 10:39:29 +0000
Date: Wed, 7 May 2025 19:39:22 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 9/9] mm, slub: skip percpu sheaves for remote object
 freeing
Message-ID: <aBs4WvzJb4X50Sr2@harry>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
X-ClientProxiedBy: SEWP216CA0141.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f775eeb-f64b-4e9e-4190-08dd8d537222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xx6FbDPPihUdhtJN6nmSIFuvpZ3Ht8wMMq+TmMBKeAayqA4OViTt/BKod4tJ?=
 =?us-ascii?Q?F0E6x9rsc6psawrcdflApNhWCjhGJXn3gPWcDHA4uJYFeOLCFlIy0kk2M3BW?=
 =?us-ascii?Q?8kUqPZt4f03mI7PGb+0sGchDeLgrSZd57quaKImnOSpWOwviK+VT2yuGh7di?=
 =?us-ascii?Q?O6/mLsD5zk/FDTEAtkGWMe/BwcCvCvrCZBadIXctOTEEIwEzY9H0eBTuezQr?=
 =?us-ascii?Q?BGXCUx+erH7br/d3QpZ5YVO6BIUT2mO0+RI/3KDBM5CA0mGyZ22tCOKevKmP?=
 =?us-ascii?Q?FBtNZRMyDmKtR/9wrKaL8dn7HT3AVd5+Ivlrodxh5Wj0Re9aLd0d72XgWJHR?=
 =?us-ascii?Q?JXZsAoQX7mh1sLP5ZZGJAd3QrCQyt3v74NMdJoFfjtVc/8fdyMf1NC6aCkfT?=
 =?us-ascii?Q?5XB55WbngqEumzngcD2vuJpim33yqK4WONJoG84mqNZNSTvkG8pfhP146rHi?=
 =?us-ascii?Q?Qm+xpLBDOMA0NAXVWTTJKYdcI3GuxJzjCWjTFJnvZN4maVvW7eG8t8TcFHDA?=
 =?us-ascii?Q?jMlua6wjX3kWwmKxSEG64/obFydd9oYpc9W9zRv+B1ucbywHCU6tBzbX/Y0j?=
 =?us-ascii?Q?zLNJ4FNvnGOEikzkFxUv7fjZ8W/X4wdahZ2IBizAj2VTQs29s9MXubPsRSUX?=
 =?us-ascii?Q?yB2VOQXK6Idwwj4/5WWSgKfsecD9uMPaMQY4UtqZPIYnzsgX/NjHn9VRjbcd?=
 =?us-ascii?Q?5Ww5qAQUeO1zhHxulapb14lYWPEYCQ0XK1Z8hIsFmPrt0nggzBe4UAiu6t76?=
 =?us-ascii?Q?He9kq3XQE4QDyDM1PTCig+j/MYX61TxJcXTwe4HU+ZECxlPEXTfbII12gRa7?=
 =?us-ascii?Q?UDveKIBz61U5nPWlt+CWsq4zB1FPA6aeCBJk7OE5CIGhGgBkCa6q52zDS0k8?=
 =?us-ascii?Q?I0i0CppsZZiBTE8e5JJfpYh7b0BBpgH+HyYxKocBZ8TbfcgeFvE8fWcaIktH?=
 =?us-ascii?Q?Ujxfx2dG/Y0ExbclUQc10U+KpQafLUDQYw+ChqIiBBwIftgtS7iLZk1GKYks?=
 =?us-ascii?Q?9kuwyv8J8MejjJ4JgIfVTqzHAvGy/prXGEjuS4PfSIQtwmpQhgR77lWHEG8j?=
 =?us-ascii?Q?NpGGt+mWIEILou44uvGi4GvTRqKWauJvOi140dkhWWArwDNr2iJ2pL07oewa?=
 =?us-ascii?Q?BRHd310onLyr0TEcpYIbvUXGN1nJvKUvml5TszGothw35SCEceZg4PvDpzo+?=
 =?us-ascii?Q?vVXgtv8aapHEjPtwE+EeqVME1Y+fSguqhVPhnjrexvrlJyAwVffT/SE/tvS+?=
 =?us-ascii?Q?A5X2yFkMzW5/hI/tZxwZeGTtZDVwnyg172YJEX1tiPQnlpNFiN3A+XEbhm3V?=
 =?us-ascii?Q?6cLfeI6d2GNF98QGuOI8tDIdqs1PyC9Lq1lFzMC9pp4bAzEKdvbccJ0wyahM?=
 =?us-ascii?Q?b2TZHtOOuI56R7Wf4itLeTrS2UGzGa21CFu18DU0CzqDqcddOjwKiv1LUD6j?=
 =?us-ascii?Q?RpAF3BhHGnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxwDqkbzJFO4IqbZ5QTNWYf5BSw6K6qsDXvg52Uvkh4DqVqWorbm8XblAikI?=
 =?us-ascii?Q?mGXHvqCPKlfVqBN99XYwYOeSM5lX3wwE2jLMLZuzSsjVWTblM2nrsuM9UiO3?=
 =?us-ascii?Q?KhUuxI0cYc/WGzMaDtVGUauigpxgv1n/p4Be4SQtVjqbNeSqWUuDMF0xh/Ki?=
 =?us-ascii?Q?PET62/JzoQrdqEI9JVZvsCdyNtcW6ti5MK4MLwQX6ldMWsUPE3yph9WAvR/y?=
 =?us-ascii?Q?kNKJJpi1rwtKQkF3VSvQ9RLbjbDT7LV9dpVk4PuJQ0idC4JhjGDM9Y+XKRnJ?=
 =?us-ascii?Q?/lXRKjyGc3HujDvtKk76UhhreXETceLfV/Oan2DaqBk+jF2PdTinR+HXATNO?=
 =?us-ascii?Q?FlBlG+zc7L0A+ppK35LZaqKEwJPQzgsyqfD82xYcHo1I/Q/rIy1whXh3eL/d?=
 =?us-ascii?Q?ihjA0QJ7OvA57xaTAr5+zWzKL3bM90hujgmMkUsd1697swbrfDJ5L6R/imMN?=
 =?us-ascii?Q?oCmYI/nMnIlZo2X5s3eo0kCpQnv/naMf3ZIh0Jqa7mDEL9OBNTeZNpcl4EzO?=
 =?us-ascii?Q?mxBWINjtatOfX9bGP+cfwIYYuDfqs5Ats3IJ/mF8BuwAztF637O+CV3h9u0q?=
 =?us-ascii?Q?bDuVTSBJcATm+u9F7qiXYQP3+VQRPwtymdFH+D1tPN7+LvpZVC94yLSF96cD?=
 =?us-ascii?Q?hOVHrTNc1HetYbbmCtz/GEfzKVa+VPBH9I3Vmy7rrsIfYCL9VQreJJvqyLbk?=
 =?us-ascii?Q?ugcGbNCjSFYYRobuyX48ojwKy6v/jrkHon9pRBIJvntPwlJ2qkixXQ1hhLqQ?=
 =?us-ascii?Q?vvUeJh8/b5IisH7luu1alNREjdp2Scv3Bu03/InE7UTopHaHJNjIzY+uMDkU?=
 =?us-ascii?Q?Ibxg5w0z01fcJ0dp6+txDaDfPIm//ISXgBjV89WumUU/+SLT6SFIa43Hn4jc?=
 =?us-ascii?Q?chT9YLPTpNeg4g7BkDlqRPs6yNu/47wjyHkYHtpp1uBrOZh+kTpFxpm5rBax?=
 =?us-ascii?Q?pjHSRZCmGPjcnTXYNK9uc+1wMHJJueRqJjQam96GRfWuGrLK/69MafEZat1S?=
 =?us-ascii?Q?NwvKS8UbrnvnLtkyoNv3KNlT0ZLV7qEItyZxRckVQ7mS065OLgq9GyJrRqq4?=
 =?us-ascii?Q?cY+Pc0URJ3kJuRowkBMKySBQNb5G9SpjRV8MjFiQYhomeMFVA5ZdGs20kM2B?=
 =?us-ascii?Q?uqUimOwjPq9mhsER/2wjxJcbgZAumIxNlaKGRz3lwSu7e7Syp/K/I1rs0Pje?=
 =?us-ascii?Q?A2n35Ck9W0JxH3bNR9NSF9cJF1Uv9g8gOQC3PigVl+fl4jDLncWoVDliKu88?=
 =?us-ascii?Q?serlwZr/oZA9Bd0jal47qw32J5shAEQghDnHwMpbcNpxsnlstUYZqVdGdeIn?=
 =?us-ascii?Q?IxGKh+rPhMiK4DGMMlwFjrJFZBzyLs9nYlTZk4aEBnBJnuwMKoZzI94Ed1Nu?=
 =?us-ascii?Q?CflHg852I3F0GfrxU6NMBqWXkPZMT+erBH52Y755uWwOU0paEH0TUIu3LmDJ?=
 =?us-ascii?Q?l5HnsL/ZnHhCZa0VQBAMcGf/0ziM2/CsC1/QNcYFpYgGG7hIX3fM3XUQIyH2?=
 =?us-ascii?Q?Kg3vEnjjpsy98s/Qm9Vdn0eksupNr1MQraoaPMIsbTMeiFnxLtZawJdJt0gs?=
 =?us-ascii?Q?pNMFU1bTm3X7rsOTp37jt5YegEE9ladqJ27g99it?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ICx1jrFhTuMCxlVlM05NJNprwGjGXLmDqdnuRjMR7cDpKYHjuldHnlVs0L7UOAmNrJs53x0Ku0fRIIMu60HqxIBklo8B+EooGc9DNELd25vHRdnmmcDDlGIuplrfNhfK03b4BkV4Ym4n4azckOvcUFZaqvnMQ3f9YW0l8pYs5DxFaW/apPqQORkTMTZpJqR6nsG5N2Zt4oXVlzfRTLS9Yp6zfqOJ4kZIA8Dma5a06saK/C1dhNaH3YGMrAqpL31i7hRySPkmvoV9P0ZOthQbuX151H1kKQDZR3M+hbcbZXjrPsXkX83PhAJRV9jjHqdyZrSFYjQzUcqWPFz/AmMh0fFxxMrF7wXmztG1LbjUc5H1sDgv7pSagcqzgGmi68e9I8bMDO4wq4YCqYCDi5/nfgPU/fnve3Tl2mgES9A5U1Lr0JB4iuvcxKv/2KGc5DasuDP6AjNIp772DmPCFutS/1LUNgWxYPdAMNYHJXTUP8jGEU2RrtrYqEkdJLxDbpiQ6yeXpyPogDNjJhbcShPiU7H/qsfppYS2Ro9NcCWWxEpUMUaMw5XhWvb3TK39o0GIP/bEGo16M37aFZH8CUz9rE9fLjv4U3KYMrxbg7Qdzvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f775eeb-f64b-4e9e-4190-08dd8d537222
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:39:29.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLrpWj0vvBchlGLngdMYp8zOBLfp8x8yBdyPHFGLW0cYIRgRez4s9FonElIAoNv9fKmEegAWw5tapTshj+Lc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=775 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070099
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=681b386c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NU-prHslJhMlhDTFa5AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA5OCBTYWx0ZWRfX/6au1OcIBR3A 8GdVQ43lYJ9d5PynckkYCKP7rEv8qYg+476QcgyGhjI3E5QHb5ZDb1q/Og0CPBqV/JQ+PyfOqRk 9RXZ+/3Mx7J9nZlDlIT/v6n90dms9MM/iFpvJgB02F5alAT/O4d8QdVyFVVZJlb49Vu6NhY9LBJ
 C1KIpfp20fOuoOH5A1mFKm/93/gVQY6EDWk9oW8EBPniIHiOYirFWfy1dn7S0OUsakM/ZCU1Iu1 PGSrSiyYsN4mGAzlR+rLAE/jI/zKGSoVyMnQKUT/aYosl5539OgzEt9vxf7ihiVCaoBDyOzeR/B S3lksgUC2nmBUNgW2VRSP8A+SOTOdfMfWGmQ3aoBOUMymBH1NCmDzd4IQa5Wgqj67Oyy0aGS5Mu
 jV4xkI1iC4Edcy8zmyhEMtsOSH1uYLZToLTh/5VPTN64lB5lelp2lSbQhKzcOICVS0i53GpY
X-Proofpoint-GUID: l8vgLcc8JsWwNfmjonnJwdO_3ky2F-af
X-Proofpoint-ORIG-GUID: l8vgLcc8JsWwNfmjonnJwdO_3ky2F-af

On Fri, Apr 25, 2025 at 10:27:29AM +0200, Vlastimil Babka wrote:
> Since we don't control the NUMA locality of objects in percpu sheaves,
> allocations with node restrictions bypass them. Allocations without
> restrictions may however still expect to get local objects with high
> probability, and the introduction of sheaves can decrease it due to
> freed object from a remote node ending up in percpu sheaves.
> 
> The fraction of such remote frees seems low (5% on an 8-node machine)
> but it can be expected that some cache or workload specific corner cases
> exist. We can either conclude that this is not a problem due to the low
> fraction, or we can make remote frees bypass percpu sheaves and go
> directly to their slabs. This will make the remote frees more expensive,
> but if if's only a small fraction, most frees will still benefit from
> the lower overhead of percpu sheaves.
> 
> This patch thus makes remote object freeing bypass percpu sheaves,
> including bulk freeing, and kfree_rcu() via the rcu_free sheaf. However
> it's not intended to be 100% guarantee that percpu sheaves will only
> contain local objects. The refill from slabs does not provide that
> guarantee in the first place, and there might be cpu migrations
> happening when we need to unlock the local_lock. Avoiding all that could
> be possible but complicated so we can leave it for later investigation
> whether it would be worth it. It can be expected that the more selective
> freeing will itself prevent accumulation of remote objects in percpu
> sheaves so any such violations would have only short-term effects.
> 
> Another possible optimization to investigate is whether it would be
> beneficial for node-restricted or strict_numa allocations to attempt to
> obtain an object from percpu sheaves if the node or mempolicy (i.e.
> MPOL_LOCAL) happens to want the local node of the allocating cpu. Right
> now such allocations bypass sheaves, but they could probably look first
> whether the first available object in percpu sheaves is local, and with
> high probability succeed - and only bypass the sheaves in cases it's
> not local.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c |  7 +++++--
>  mm/slub.c        | 43 +++++++++++++++++++++++++++++++++++++------
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index cc273cc45f632e16644355831132cdc391219cec..2bf83e2b85b23f4db2b311edaded4bef6b7d01de 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5924,8 +5948,15 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>  
> -	if (!s->cpu_sheaves || !free_to_pcs(s, object))
> -		do_slab_free(s, slab, object, object, 1, addr);
> +	if (s->cpu_sheaves) {
> +		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
> +			   slab_nid(slab) == numa_node_id())) {
> +			free_to_pcs(s, object);

Shouldn't it call do_slab_free() when free_to_pcs() failed?

> +			return;
> +		}
> +	}
> +
> +	do_slab_free(s, slab, object, object, 1, addr);
>  }
>  
>  #ifdef CONFIG_MEMCG
> 
> -- 
> 2.49.0
> 
> 

-- 
Cheers,
Harry / Hyeonggon
