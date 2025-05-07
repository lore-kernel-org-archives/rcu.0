Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFB253955;
	Wed,  7 May 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609382; cv=fail; b=Fh8/cKu+XALAkGrKfV7eH20R4kRZfvse/XINqJw9sc/jTeI3LakTla3gm+/tTdx2DOKMGKjqnc28Fqm15P8473toaNYUGRO5dLtnr1dNbi1nckfqJw75bUM6aygjQ0plPvhOdYZni+waZ1xMvXEvqqhWBuPWJYGAUHRS6j8NH9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609382; c=relaxed/simple;
	bh=ktQIAgHN+GTTkMHpFVNO/ICmj3tFGhdbKX7mpfqpSpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imfmYugVz/Ke2qApKmRdxbT89FAn/U4BDWv6rjMb+mmFLbG42rNAp5XzVBe6E4btu6N8ltnXK1rVz9CaNKD1Lz9TZRFWowFzhjAR2NKK1pwxe2amEGJh6FW+PDu3qUObkirG22GfjUFSSAJSKKaB803N/flPVWTWBfcEYGJcovI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZZhDfDD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H8MyuoPw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZZhDfDD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H8MyuoPw"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547921i7006455;
	Wed, 7 May 2025 09:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4AWtiVLwnYl7W2/t9d
	jWcFyEuFj9D93/Ipfh4pLaHZs=; b=BZZhDfDDxPEwilB4QMbB+u3kjQeapzPm9H
	1GzCIU5dB5ksGNLfyjhZ85u5ns4DbqSsToOYiw8jyBorTDGHJQrmYbxm3aUgPdNn
	pRhF7qet9FEGf9cxdfcjhsNj7HBT3hOxGGi1YElrmXrfvHLBOFYUyWgntR7NsYi+
	b/4t5dJb/d9VG7RQJ7BrRCrO8FO0osLJvZkJebN71Tb+YAaOaaf390E3dcKBD2qv
	X7M29Nccuzn98J0zFvu5EUylTbVRyA3QScvezzK7opTPO/W9zcPfzIByj21Oi12V
	cYdgCcEQFkUG93/UmWV68xHNOEW6UyYvSsmA4Rh36rr3+hT5dY9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g4hf01m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 09:15:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5478INTX035351;
	Wed, 7 May 2025 09:15:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kgd3jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 09:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsOSxOsMSSQO8xblgUbptI4b7PItvJCrP9n1ycO6blrdJWgbhCsmK7nZ1uPwowse7ut127j1/EaCzNRnj94dp9+YSCx9rGUH121JI7Mrl0TwQTT+MsfXwFkIqkddgX7hQVSgaSPwQGSm8hmxeBgUGBjDUuWwfo6sxf/UNdGvXYlSpRqisAP1LbLF5ONgbqu28PEM0p0BiYI3VuacAFQrzts2xXntsv9C46CfHoL27iZhekzvLJL6q1wFWR4tlvs+cqOpkvNI9cZl7BCmDgO4ShnoaoRA8sTN0Boqe7LgPd7Fm0Cn+cBmfpkRI5JEufvFfjj694ff8LfeTrG2lRYmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AWtiVLwnYl7W2/t9djWcFyEuFj9D93/Ipfh4pLaHZs=;
 b=FXw87wre09yFV7cV1r5TYO1V2HjSGxyKmfdUqUlkA40zguhhPYQToZT/2n/IofLOQgXh9MX8GvYaYfc58RWZWuOMCzTQx4LDmR1iJxBi/CmY8GZi1ueP8+c04dmlVvu/e+6E0SAiuD1l1iIwQCwyaJ9I5EqBekdBjYFAwQI018lcv4wC/hgj3zu4PyqwMRT2+oU9SkIlDjnXP60zZyheulMPEOyBSkTVvGDEiq4HIlAQM8ES27+PoFDH79UMYgl+mVtigqQ9T/ZIJrZiV2TV8QinH8YkmFbe/9Je2FTu7Rv3q+2lQwRSrKJd3md7Gu1zYVqtTnMn8AsRwa9eb2pTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AWtiVLwnYl7W2/t9djWcFyEuFj9D93/Ipfh4pLaHZs=;
 b=H8MyuoPwiz9gwDTNdyjbRxOGNjqbWNpKclWdxULL1gQddUE/JykYaXxZAcftJ2NNMwd/Y2r7Tvy7lnT/juxROLYGpNUnZEAIotv0Kbwhxllo3CTzhD4ZWRGYpIuliYUEAN5Mew70hy1gdxphWqU2fOIs5iT3L/HN1+7uQsQyOT4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 09:15:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:15:42 +0000
Date: Wed, 7 May 2025 18:15:34 +0900
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
Message-ID: <aBsktvf4VjQfXGST@harry>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-slub-percpu-caches-v4-3-8a636982b4a4@suse.cz>
X-ClientProxiedBy: SE2P216CA0196.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d1081b-1b43-409f-b678-08dd8d47bda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bNHlcY7Sfdh7IIk1FpYV2NwBBXhOUoSZ356YZNXxi7Sl7gHbRGimRv0HWqbG?=
 =?us-ascii?Q?XNWvTAsiDp/e3qkdpqgcUCntYrI+KzPj486TK38OPM+Sn8xSRrL+mq9NYpEa?=
 =?us-ascii?Q?dOxfPnuQhF1N1Dq7N33g9Ws4dKIi1OMyYTJNDbupJhF3ACAIxzzRIrxcZa6L?=
 =?us-ascii?Q?DtfYGn4AFbQg7xlMClgAwPLdKHkxQ6sgqznNQE5G83Zqs6mYXxgFxa7zzUF2?=
 =?us-ascii?Q?UTgytVGlvbGNWonSh45Jt6IyrvJ7Wfab/gcPbjbyUBlwDJQUE29ya0TgmNAF?=
 =?us-ascii?Q?mklPcZ5tx2IHHOgq1LxwkX1MjaLZfL67ovIQl6ZHJK3XDi5hsZDHgGu9++sW?=
 =?us-ascii?Q?6OADywKX7PXYd7XSfCLSBJ4d9vufcZmKncdURD9GwQwyfTKXQhx3VMP8bqeE?=
 =?us-ascii?Q?40nsf5U7piA20lNJDRQoVTgqavZ7cSfdgHwOXKTp92NP1EyR1Dp9Sb2P3FNf?=
 =?us-ascii?Q?Q9KgXp9tgbtsXlEu7BsZyLKyR8tk5f48OKuRjsbSRT4o6NTEefmNi1EY/5Xs?=
 =?us-ascii?Q?weNlVz75NKL0NFtATmyQbA7vgKT3nivI1/oGq16Rqv2TPOS/KNUCZCGDuUF4?=
 =?us-ascii?Q?1etFnavYOHgxMPopqZ2tVZBDWCmILChpet+xMaofF5S83DJUgd6Bkf9Jf3r+?=
 =?us-ascii?Q?0pG7lAB9KMBlahgbeS1lnq3/l4CIHoYGRdvKZKWRQzW0f2713/MyyuTUTQ9t?=
 =?us-ascii?Q?jlKwi+VXF58v8tktTHpQYHdVn+eYsozqr2Lf0Rxfos+wmcDxYaqGsmCxoc2G?=
 =?us-ascii?Q?tPqg32FN58vUuySXjxLASYCvFtt77Fc4ke2zvQ+lvlFFe5VmRHs8iseOzXEu?=
 =?us-ascii?Q?PnVcCxUvGBG3QMMwGF2CbuSYxlFoZ3GAaEyfYIijp84qqkOXWjioZBEWYEeO?=
 =?us-ascii?Q?NLJVsJTw486jBWOwjHMu8fs6eVcgsUqWXllnAtQKIy7nxlH0dJ6rIEwghpFl?=
 =?us-ascii?Q?GIm8ZUHoADdCzcMBeQ2I9M+2Ie4XJioCv+mI83LPiigR2huzXn2sfcLtyEyS?=
 =?us-ascii?Q?Ca3uqB6DDE73VXRt/qI6ou1Gl24Ew6lfD25dQNY+S0OFxICDugUr8LkGXKlh?=
 =?us-ascii?Q?xsWG15I0oWKlWpEw/fQhLHs9VVQ5WlV4XRoT9yoBwo1BfjHUCAqEVoK6Mv+u?=
 =?us-ascii?Q?WSi2E7AMCrLD4totwJCohfchFfz/SdkPmw+vuGX35zWyTqcx1QYR24oIl/mi?=
 =?us-ascii?Q?mDLJAUAsfK+7IGFpHGGyglwCkp7eELzondKtRZSuLr9BXhvFhTtE1t1QvYFM?=
 =?us-ascii?Q?LnzJwUICnC8ugBVCmoSxxS3q+gSby/Jaw4gWHU4XH2LY7xt/ul4nTAFeRJRU?=
 =?us-ascii?Q?8Wgq5/VZDBR4nK69P4yFCzL861BV9asD2VGpjsDS6Ku/FFHx2PyMr1TGxyOE?=
 =?us-ascii?Q?g/IGzf2HINlir2v1OBtg7U7evHL6uGcildsGPL1r+KuibuV1FHcSPaf62Nz+?=
 =?us-ascii?Q?a6OF8pGqUbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0LWkGzZ1uxN3qrlEj3W+lbvRmpI/vU1+nCBh2njiKc9Xne1UD3wXctEC3hA?=
 =?us-ascii?Q?eGxVW8WMtaUT+6B0PJEv5zfhUOgx8mNgXRIC6jzRjbpvc5jztjtvzjKeurFH?=
 =?us-ascii?Q?EdLJcRLNt4D815wVtOJncaeJUVwUee60/b5KSqOGQRJL9GK/q0qdHTUhUV3X?=
 =?us-ascii?Q?4edhvZ3IFJLSq4LlJUzi3l0POwGwgz/2quFwjMwqD1Lndjkm5DKkalUJWPw4?=
 =?us-ascii?Q?ozhAuKHlc+F8V2sqJInCI0Wg0dJ9bVPQ1YHoWpe/Tue6Uh95VJ1UNyCyl6LU?=
 =?us-ascii?Q?b8zz9hTZr9y9yzBxXC29KcOieZCLeJ076oWeocdFedLeUlzsnMdiiXICAH+P?=
 =?us-ascii?Q?firmtUzqZY5LEqe/8VSVGVr5nrlJYwRTvaMsCQTjGphaqmgJoyk3cAylFPGt?=
 =?us-ascii?Q?AdKHRINzp90jiIkgUOc4XqZykoJsRs02EnADHmONr20kszGxlrTeqs9RjK//?=
 =?us-ascii?Q?5m/SPdKcfUOiKDxCrvMhB2kQkQOemfB7pnv6U2OfXt2PNccysMyadEa+KCg0?=
 =?us-ascii?Q?NQS06JaqKZT1rw6eWa5kF9nttJ4M/ukEMei+ujjZY0GPoPozxtydcoRSG9W7?=
 =?us-ascii?Q?xT0V1iOdc3+sTfH6HLKz90cO37fBmRt/oeT4uSlnKvE7FtPOOXfrgNa6QHvg?=
 =?us-ascii?Q?cF9vwrzECEXIEVr91jtwG+WSiAo8AjRi3F+rIeQRMSp1xHboDGndJn6dmKYK?=
 =?us-ascii?Q?+hHGpvsoK88o4WQEdVbgzZ/PYHh1wNtzFFl53+edg1Op57cF2zPhqq783C+C?=
 =?us-ascii?Q?wyBsYhrg9eOsk5jVq2zgI2Z1AvhmFf0akTxBnVpeRGgmh48+oCUiLRdV//N7?=
 =?us-ascii?Q?PGa+PIQ6dUqBshIdRuTKrDlV+2MdukYoQP888JCKQZ+imnPFWv2lc2uJ8zai?=
 =?us-ascii?Q?CSpHOlFwStKTkIM5+FjkP5Bp8clf4tx67v2sbBtDVU/04rA5F+rEwnTt10R6?=
 =?us-ascii?Q?7dqS00sNy0/i/y8mgE8ONUoX2+IEoZEvqXon3U+P6PeZavjdWujS0ld9Wgeh?=
 =?us-ascii?Q?eF7CLj9d+8r+GOT/LaiFM17jtUPydDBO0VlHUymzl2gM08MtbbNIyMhRrgq8?=
 =?us-ascii?Q?B/RckL7dnxwK/O/TRF14vxl/WqbbmalfZwQx+0zCr8syCLk7C2q9EFVyk+tf?=
 =?us-ascii?Q?2rW2uMoo4QTmGjVBBuswvhRwccqflvIsLJnRozPzCBplhKHX0gbFPqjJHXpL?=
 =?us-ascii?Q?vSM0UucucBVYL3xLc+gsWhBnUrEYJQ0vGGcJHdn/D43J/BP4ToW4cfLOfSwz?=
 =?us-ascii?Q?4s5BJ5a5D0nphtXi7pqVfuPsnphPdwxVVa19WHKbr2t3woWSWVBRnvkPV5VC?=
 =?us-ascii?Q?lcCPg1211iA7BaYpQ0bJ4xNY/OqpXQwmWmnABfibv80TRnRNqXsFlGSETwJo?=
 =?us-ascii?Q?DMpF5tSUDAEIU8iReFAQMeTSJs0k+5aN0hpxsUtUgL+V0IS2EiZ5NdippQy7?=
 =?us-ascii?Q?pOgy4VVH9q96QursXoLy860LGNaWT+aEC7DJzhd13EC6bfMCTNuvcdEHMnD6?=
 =?us-ascii?Q?pqqZ9Rqey/h/y3aMNX908caJEayFjUDT4k0v98ksS9EzL1ucZ78VSbYPq3lt?=
 =?us-ascii?Q?iU0N44T31JZi34Y0S+BgZF8nZHc5aECZiYSENW8u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wod5h1ztPPe1oW+m5g+tylfTRrT0f24IvvPJrcx3ZiV9+OJdMUkP265eAZ3NQpmZdLWAZmjbZjNKI+MMatbRH6GPu3cGZUNM6diCsmqZTN8KNAbXtp4gUlIKYHbLLi+vuvYxB8+5ZB9cQ7SZvI0nkstCnAWgt50Do1v7WyJSzatxk/0jhJmdyqjybhVhphjspRhTNRUzQwohZL3mk1qFtxwbpcue0R4wXvtCW4YQgs/MrPDqdOyZsq5uzx/IT5IdwE8IHXQREGlnGmAz5cVpkTnJNG/2whas+B0pxATa6tlj0IpNAFo5Sv/Z71gNi/xwT9RUyF6Zb9fNzIEcZkjIjnn9BEgx/7+e8J1Bvt8hvs3jrGebhHn8BXn0LF+qwZr/03YqN9kJdXPcEXFZVb99SOCYfHJZBbf6e80ohjesxGoKyyyG1NDkaDOs4gUwl5o6pa64nxN6AivxlhMFIcPBZZZUMF+NQe/Yrevpg/McuLyEdCBeewRLbE6KHpvMr407eLI9686rLl3V9LYRwfQZPLAxkrZ+n/p6OshbuJMPivMh+ASoZLWLPweezwmq7d3elYfot8NVfZDeFJGGMgFPxJeX+X7Q6T+kExW2VYJqEgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d1081b-1b43-409f-b678-08dd8d47bda8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:15:42.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTAHfrAdj3JxNpR3sJH/9zskcX4gl1AcSG/EOGWr3XEyH5pTcTXfloDFyGgVtaaNslFx7pYmtS7NEKTDRMDBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070085
X-Authority-Analysis: v=2.4 cv=R5ADGcRX c=1 sm=1 tr=0 ts=681b24c9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=QOL_H-a4InYEQcX7BWwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA4NCBTYWx0ZWRfXzYpVC66oPwwG ziLi7+21U+16pHQh6iQuMsz8PQgVYtnqDl4gaLq1+SHyzwEb9SkDDce6UPVr13qzzHapHeMyByI wB2QJ0yXXDPhPi1jrwTGc6lNj8fX7nDwOum0f10S7nzr+21YrhhtupvSdb1GpAoK/mcdYgcTjLK
 XVHiBHpc3L8mFP/8lTsKBurKUBrdMnzCFkM0HdDiFnra9ZhvyUZ4aQHYbjNZeJA9vBlayAc/e0u R6osYZ4ETVTYhOdwfuGPlLPu61BaCnIeXNj8sCeI2PIeluHgyKwu7E0/3iy27ygEPef9ChC3AuI loKuCFBs0dDjBCLG6W8QmymVDIt8EMZNi3zJZcJAlGOYM/b7Ket/1LHoDt6PsMFFSr8d1PIdIgw
 w9+9qYczNN7WFOOWlgzPeXurgVL8pBCFYMkq8PMnI2tfAH/6rKJfDF8rhZmD47oqjk0ogiEr
X-Proofpoint-GUID: DL37EzRgGg0k8iEfHEz-zeRnCIz1YuAN
X-Proofpoint-ORIG-GUID: DL37EzRgGg0k8iEfHEz-zeRnCIz1YuAN

On Fri, Apr 25, 2025 at 10:27:23AM +0200, Vlastimil Babka wrote:
> Add functions for efficient guaranteed allocations e.g. in a critical
> section that cannot sleep, when the exact number of allocations is not
> known beforehand, but an upper limit can be calculated.
> 
> kmem_cache_prefill_sheaf() returns a sheaf containing at least given
> number of objects.
> 
> kmem_cache_alloc_from_sheaf() will allocate an object from the sheaf
> and is guaranteed not to fail until depleted.
> 
> kmem_cache_return_sheaf() is for giving the sheaf back to the slab
> allocator after the critical section. This will also attempt to refill
> it to cache's sheaf capacity for better efficiency of sheaves handling,
> but it's not stricly necessary to succeed.
> 
> kmem_cache_refill_sheaf() can be used to refill a previously obtained
> sheaf to requested size. If the current size is sufficient, it does
> nothing. If the requested size exceeds cache's sheaf_capacity and the
> sheaf's current capacity, the sheaf will be replaced with a new one,
> hence the indirect pointer parameter.
> 
> kmem_cache_sheaf_size() can be used to query the current size.
> 
> The implementation supports requesting sizes that exceed cache's
> sheaf_capacity, but it is not efficient - such "oversize" sheaves are
> allocated fresh in kmem_cache_prefill_sheaf() and flushed and freed
> immediately by kmem_cache_return_sheaf(). kmem_cache_refill_sheaf()
> might be especially ineffective when replacing a sheaf with a new one of
> a larger capacity. It is therefore better to size cache's
> sheaf_capacity accordingly to make oversize sheaves exceptional.
> 
> CONFIG_SLUB_STATS counters are added for sheaf prefill and return
> operations. A prefill or return is considered _fast when it is able to
> grab or return a percpu spare sheaf (even if the sheaf needs a refill to
> satisfy the request, as those should amortize over time), and _slow
> otherwise (when the barn or even sheaf allocation/freeing has to be
> involved). sheaf_prefill_oversize is provided to determine how many
> prefills were oversize (counter for oversize returns is not necessary as
> all oversize refills result in oversize returns).
> 
> When slub_debug is enabled for a cache with sheaves, no percpu sheaves
> exist for it, but the prefill functionality is still provided simply by
> all prefilled sheaves becoming oversize. If percpu sheaves are not
> created for a cache due to not passing the sheaf_capacity argument on
> cache creation, the prefills also work through oversize sheaves, but
> there's a WARN_ON_ONCE() to indicate the omission.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a nit below.

> +/*
> + * Use this to return a sheaf obtained by kmem_cache_prefill_sheaf()
> + *
> + * If the sheaf cannot simply become the percpu spare sheaf, but there's space
> + * for a full sheaf in the barn, we try to refill the sheaf back to the cache's
> + * sheaf_capacity to avoid handling partially full sheaves.
> + *
> + * If the refill fails because gfp is e.g. GFP_NOWAIT, or the barn is full, the
> + * sheaf is instead flushed and freed.
> + */
> +void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
> +			     struct slab_sheaf *sheaf)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +	bool refill = false;
> +	struct node_barn *barn;
> +
> +	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
> +		sheaf_flush_unused(s, sheaf);
> +		kfree(sheaf);
> +		return;
> +	}
> +
> +	local_lock(&s->cpu_sheaves->lock);
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (!pcs->spare) {
> +		pcs->spare = sheaf;
> +		sheaf = NULL;
> +		stat(s, SHEAF_RETURN_FAST);
> +	} else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
> +		barn = pcs->barn;
> +		refill = true;
> +	}
> +
> +	local_unlock(&s->cpu_sheaves->lock);
> +
> +	if (!sheaf)
> +		return;
> +
> +	stat(s, SHEAF_RETURN_SLOW);
> +
> +	/*
> +	 * if the barn is full of full sheaves or we fail to refill the sheaf,
> +	 * simply flush and free it
> +	 */
> +	if (!refill || refill_sheaf(s, sheaf, gfp)) {
> +		sheaf_flush_unused(s, sheaf);
> +		free_empty_sheaf(s, sheaf);
> +		return;
> +	}
> +
> +	/* we racily determined the sheaf would fit, so now force it */
> +	barn_put_full_sheaf(barn, sheaf);
> +	stat(s, BARN_PUT);
> +}

nit: as accessing pcs->barn outside local_lock is safe (it does not go
away until the cache is destroyed...), this could be simplified a little
bit:

diff --git a/mm/slub.c b/mm/slub.c
index 2bf83e2b85b2..4e1daba4d13e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5043,7 +5043,6 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 			     struct slab_sheaf *sheaf)
 {
 	struct slub_percpu_sheaves *pcs;
-	bool refill = false;
 	struct node_barn *barn;

 	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
@@ -5059,9 +5058,6 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 		pcs->spare = sheaf;
 		sheaf = NULL;
 		stat(s, SHEAF_RETURN_FAST);
-	} else if (data_race(pcs->barn->nr_full) < MAX_FULL_SHEAVES) {
-		barn = pcs->barn;
-		refill = true;
 	}

 	local_unlock(&s->cpu_sheaves->lock);
@@ -5071,17 +5067,19 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,

 	stat(s, SHEAF_RETURN_SLOW);

+	/* Accessing pcs->barn outside local_lock is safe */
+	barn = pcs->barn;
+
 	/*
 	 * if the barn is full of full sheaves or we fail to refill the sheaf,
 	 * simply flush and free it
 	 */
-	if (!refill || refill_sheaf(s, sheaf, gfp)) {
+	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
+			refill_sheaf(s, sheaf, gfp)) {
 		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
-		return;
 	}

-	/* we racily determined the sheaf would fit, so now force it */
 	barn_put_full_sheaf(barn, sheaf);
 	stat(s, BARN_PUT);
 }

-- 
Cheers,
Harry / Hyeonggon
