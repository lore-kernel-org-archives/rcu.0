Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB432ED37;
	Mon,  9 Feb 2026 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628147; cv=fail; b=QwSqyoQXtV0SK22xNr6HRiB2tcYKI69GIa5Qewr6OBLApGKmyRTK4l/CNdjfE0WeUgVjH7g+AlSdCiKBQYKHN60lAZA9FUdtWxi1CjYTR/kG2QVO8W+DG7+RBMD7kMQhGxBX0B7Nh/tKs4lU0DOZmQGZQrfCtvMb0JMBl9tFT1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628147; c=relaxed/simple;
	bh=07OVSIbBbvu3h0f3MucxKaekVLlwvH7rEBw4bEv5Z6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ozihkFH0Ic0MYo08e70MOUqrIqJSEPK79JpWB0ta5fury8+dSRQGhLyd+BbtVqQXH68BX+WIoz4PwQEtQ0p1A2RTfEk6QDOfIZx6ukYv2S4GQAurFbwoWCXfYQXDG68gVmpGW8zjX6sPUCvaDT9ATENK11NMD3V8k66O+Hip0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m2+dizeQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0N1idnB4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m2+dizeQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0N1idnB4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6192btdn889638;
	Mon, 9 Feb 2026 09:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1+88Kfzu1VgpJ+KglJi0os0RIjXXNEzbTH5m+aiMc44=; b=
	m2+dizeQU/XOqiFn2Azsk3mDP3qGUx5RzmQiQyh7eweBdVOOuMpFnwaPmks7sJdf
	z0UwijLFTBPDFJFaIOHVVb5G5Cf6VkLeqx1OSM+ADuU6bUpQmTRzoOz86cRTfZM3
	sjgSk39bVEstDXl2gC3mkPpk6gvK3UiIAzu/RxDd8X9gkzE+qhMj9Z7fiB3Mx/fo
	JQIBdQvjsRBLOKVjA0RJgdJMb8ep+WF6L6xIJMF43ITCM3SRNC0OkNAI2Xdpb1K6
	HdIiQe/DfpqedrdBxrzfevEDh7YfQRO1vlNkgBk6CRvkbsvRCp8UGPRLJVN6+U46
	LB56HkWrNdbzCHMeRSMX0Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xfp1mfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 09:03:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6198dOP3020849;
	Mon, 9 Feb 2026 09:03:20 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c625gh8bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 09:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faSsiLz/n1gVky03eR2+LI4TC4Jt/rOq4TN6vhmb63fGpNpimrwgFYQ5oN6BfwTLMh11FvMUQ3rDsBLxIzbleKSaQrQG9sX1pgGfo1e7JmBrBCJj/iwDWnMFAe+LolkQlKOHB/bVE9P7TZnhjXAr1Ta2USr6bmDLtS/ChZYHcMgn7p7g8841X4GigXSJ1FZ0Bt6N/upo4YDIOWGHC4hh2DHBcBpMVxLhfD1nhchlTIXiiSzqcsHCE/28Mf6dV59pc97uwlfuUXrNoQGq0KbCveanSYLGmnlYSG6BlLJVsfu6q6ChEkVqW3f7TH4N8iy8lCVVYpi032lYJz4OPcJRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+88Kfzu1VgpJ+KglJi0os0RIjXXNEzbTH5m+aiMc44=;
 b=Q9MyAUExZCKASG+6g+1KLelWHECpTWVIAa6YE/OV5LdLuqpkn6Z14gIuAaX2ObaY+GVlqWQz4p4VmZ05Yd/bV4GO40dmqej+VQH/vlGDbxK0+DS0DaBTjbqLDSgFSZwUtvvb0qe4GNE07r8BAK1Z5vLE+QP5M5qGj/OkmA4vG147WrYiH3zlFCMHsaJDtRoJRhU88DYANeJnUSsz//gZzVq25IVqff5Fq/J4JeZHkjta1vbSETApJ1VP0AUZ+oykb1muntcSWjso/ceFHNUijz9mNOYwyxu8wHN4I2JdEthMYtpkQzE5tOTz37fRKbMdQbC+qn7hG1i6Ret7LBTvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+88Kfzu1VgpJ+KglJi0os0RIjXXNEzbTH5m+aiMc44=;
 b=0N1idnB4LIwFNsMhFNhWRkzYXiqxw2UWVRIPojZFi9LbzDrhFgm1PjOxjVoqDP4dsWPUHnIN5v0yoOpQRa1OpiCFmdFAP/YtXnkwG6UDX/vEh5BlBg9TKcQHOk+5cg70QTOJUkhx5Bxe6HwbSjFAUNOIMstvT/Rpw1nc5bK9WCI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB997782.namprd10.prod.outlook.com (2603:10b6:510:3b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:03:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:03:06 +0000
Date: Mon, 9 Feb 2026 18:02:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] k[v]free_rcu() improvements
Message-ID: <aYmivqZKklspsa_8@hyeyoo>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <3069e76d-5c7a-4c3f-9b83-43ed1700b95f@paulmck-laptop>
 <aYaTluYIbqt7xSC5@hyeyoo>
 <a49009d1-a0f7-4111-a148-c94fc6e506b9@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a49009d1-a0f7-4111-a148-c94fc6e506b9@paulmck-laptop>
X-ClientProxiedBy: SL2P216CA0164.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB997782:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d99a10e-ac23-4cc5-a50b-08de67ba0a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2xVRTRJdERDRUo5WG9sMm5Lb0ZlWWhoNDVObzJ2cEVYKzc4czdzTDBMN0Ji?=
 =?utf-8?B?ZHJIdEowd2dIRndCNTJDYlJVWTZFS2Eza3BNRTROSnZVMENIOHh5Vmx1TVZs?=
 =?utf-8?B?NFcrbWVPb1poa0dPK0dVUDEvZGoyS0tsNDJFMEVZbExTV0tVcmhvTDNrYUQz?=
 =?utf-8?B?MVhhd3ZMRXFHaHdHeGtVRjQ0dmtCVVluN1g5ZU1lQjY3cXN2b3cvRFVGUlIz?=
 =?utf-8?B?RVN5WEdnWVBYYXZ2ZDd2TkE2N1E3SDg0VEZTU1ZUS2JPNnlNMDErcTU4OVU4?=
 =?utf-8?B?SnF5SUhheXF2MFN1cjVkS0ViaHF2QVZpYVpxZEtqbXVmRjNrNEwwZXFraHBL?=
 =?utf-8?B?aXcyZXFkd3k5K1R3RTFiRTZIcGJOL3VlQ0hmU0FmL1hXcmFoV2dST1lNV3BM?=
 =?utf-8?B?MklUbHVzTHVvZzFPNVBmL2dPbm5VM1A2YU9HckdjamJFMG9HZjJJelhMd0Nv?=
 =?utf-8?B?VEdrdnY3dDBId01uUVZsZkEzQzVhdnB0QksycXNLNGV2cGhEVkcvdWVCQ0dz?=
 =?utf-8?B?bzBYN3pOWGZheXdKclR1dThaVXNPRzFHTXc4eCtaS3EyMkcwSEx6a1prbzlq?=
 =?utf-8?B?S1pMNEFROGdad3M1U01kcWFNVTZmWFFjc2tYZjgrTU9ITkVWSFdMMTljekFM?=
 =?utf-8?B?aDNOdkpVSm9IYTFuakV0OExRalZWU1BhOXU1dUtaRm9JcUdZelB5YUhaSUhW?=
 =?utf-8?B?Q2pkc3UrVTNRcHVhSVA5UldZMVMyMFJJRUZXOUl2MTJuNnVpaHpKdTl0cTdi?=
 =?utf-8?B?SDlVZzNVSjVDZFgwUVFVYkxKUXlYVnNsK1RGVnR4bHR4TUpCeEhza3JlTTZF?=
 =?utf-8?B?ZVJOai96dG0xZjFYdkl2eGJBYS9oNjAxTHdKRHdTdzNYTFZQWktkcWlJSmdV?=
 =?utf-8?B?d3hINFBxUGkwcS9oTFpxTXRpbThNYlpBVXRTOVNpZUp2YlpJMHJiYjhBQ1Zp?=
 =?utf-8?B?SFc3c3p4emxhYVNQVUdMUUpuSlVhbzU5KzI1RlZaTncwaTV0L3ZNTEVaQ1Rv?=
 =?utf-8?B?d1Z6ZVNQbVc5ZVhsY2Rib29IcWRqZ1NiVjlzSGdMQ3pIcE9RS3JGeHJDQ285?=
 =?utf-8?B?NUVSNk1DYWhuZWsxRzBDc0NvOFdRZkdqMzV3bW5mSzREZ1E0OXhIZXRUNHBh?=
 =?utf-8?B?WXAvaWNxaCtvRTBmN01NWTVoNERRaXNoVFVydHNJNUJiNXFiaWFVRDJ3aUNP?=
 =?utf-8?B?TmlScHpVNG9mV21xM0wwUDY0Tzcrb2d3QlB5RG85U0xUamFVWXNPVnNmV2dT?=
 =?utf-8?B?a1lvK3F5NFE0WklnVHZ4QWY2Sm1SWFArQlhFUmoxVHExQXBkRVlmVFNyekc5?=
 =?utf-8?B?MUxueXdrcDdFbGhRUXlSOE9td2JpMDRPTWRjOFBHdnVObi9EZjIxZ1ZpKys3?=
 =?utf-8?B?SXhES1RWRWpNaUJWVzN4TWEvVDRJei9KSm11K3JrYk51WCtpK3RBMlBzVjJB?=
 =?utf-8?B?S21xWE5Wc1ptYjdveVpxSHlMN1VqRmNmVXFVb3ZUZUpaNllNNUdaeDlicjdt?=
 =?utf-8?B?RHdyR2RRQ0IvMStoV2UzSk9BT3pCak9tSjd1Zi94UHYvakJtNjNmS3pHRUtY?=
 =?utf-8?B?SWY3azVkTVYwVU1QNTAxckt1OURobU54UzBnZ0tPc2pQMGJ6bVBKTTFIMWgv?=
 =?utf-8?B?SlVwcDdwQXh5TjBja0o1WUNoSVVkaWNockc1dkFMTVE1Y2k4QjRrK0NzdHdZ?=
 =?utf-8?B?cWFKYy9yMnM4czBBTHZPTlZURkpmckJtYTJIYXQ2dnF3NGdZalJvblFTQXNz?=
 =?utf-8?B?SStZWGNPSGRBdHRDWlZmUDJINnZHN2MvS2x5NE4wZWVOSE5DMFZ6bGlkaEd2?=
 =?utf-8?B?clF4YmVRcytCT25TYkc2YzA4UDdpM050RlViRlZZN0d2ekF6THU1Uys3VGY4?=
 =?utf-8?B?c2pBaEdIWXVjMlZ2ZU8xTmFnY3g0QVdjc3FLcnJYUmk2VWwyWDJ6NGloR1FE?=
 =?utf-8?B?VXNLSGE5a1paQ2dJWDhJM3IrKzFTMjB2bWFVOE5SOTM5WkEwaFc5RGdPT3JT?=
 =?utf-8?B?OTlnVW1FVW9Udkp3QkRGTHBXNkFCb21rOUNSblRDOSttVWNpNTlqZHNoNXN0?=
 =?utf-8?B?ZGQ3d3FRR210Z1l6dW12MGpIQXJlYlNPMVJrS2VqYjFRaHdFSGxRbWYyb0xJ?=
 =?utf-8?Q?RU+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWlKTi9HOTJ4R0gyTVJWbnRueTdmQVg3aGVlS0Urajh5SnFucHZxVGdieXRX?=
 =?utf-8?B?eVJKdklpRFRZQUFNdW14RnZMQXNOekh1Zm42QzRZcURjb0RjOEZ6Ri9YOVJB?=
 =?utf-8?B?N2g4a1U2RXBsNmFVc3lodDN5M0hZSVV4ZWlBazcvdWs2Zm9rcXpkaEp6WnRU?=
 =?utf-8?B?b3JvdnJDZER2UUlMZXF3TlJPU0d1QWxyOU5PVitVV2VQYjVFcVZIdDRuWWJy?=
 =?utf-8?B?KzcwMjg4MFZIZTRwMUFQd0dpY2ZiY1NnMk1Cdll4cDc3dkdtWGxzSHNCNXdY?=
 =?utf-8?B?dVU3SEViQzc5NURlc0tJNUt0NUJMd2Jwb3BhK0pWUjdjQ09sOFMyTWVnZ0Fz?=
 =?utf-8?B?Y1BLMndWQW1vYlo2RHU1NnVteUxFQTZQblIxM3gwM1lNWGlOME51SW9pdTZK?=
 =?utf-8?B?SGZjS2ZhZno1bDV1V1ZrVnN3Uko0dmhOZjBmOVVBOHBUSEhUemUxUVczRlNV?=
 =?utf-8?B?eGlKcjJZQU9RZDhqRW8rTFY0ZjNRNkFwWlZkYU02L05PQVBML3laWDExZlFY?=
 =?utf-8?B?MXMxYXkxM1ZOZldGa25wbDIvVmRrY0ZLS3dzUHZpNHBjcUtZY0JUNkpQclRZ?=
 =?utf-8?B?VFVYTTc0ajdFNGdGWkgrR09mVHIvS3dvQ0NuOHIzVkVab1d3Wlo4RW1Wdmll?=
 =?utf-8?B?NWFBYlFOTVlrVkIvUUlWVnNpRU12OHVRN2tjblNVMk9nVVN2RXF5bUtXZnZl?=
 =?utf-8?B?OG1ua1NaY0h3UGVPWXBKUnRPbWxkbUYxQTNldjNKcWYybHM0MWNIdlFFUWk3?=
 =?utf-8?B?eElWalA3cHIzMmk3aXRNNkVnUUtUWDdUSUp3TExSRGd6d1VjVUhKb3lJV3dq?=
 =?utf-8?B?cUdmN1BaZFJZT1VneG91dlB3M1E3TWR1UFlOeS9INVF1N3FNazFhdHUvUjlp?=
 =?utf-8?B?NndWdjFUandhQW1vN0h5aExQMGRoY1hDSzJ0bFo2bWkwSkE5YzJ5N1YwL1F3?=
 =?utf-8?B?NExmYzU5UHhVK0x6Y0xYdFpKWjUvVkJvbzdJYks1NEZzR3d2ZXZDb0h5R2hX?=
 =?utf-8?B?dkYrS3dyb2xheXc2Ky9jNmRQWFp0NzdoOWFZVWdLV2s1TytRU3pYUlJyRk93?=
 =?utf-8?B?T3Bwbm5MbmNPejU2WjBaSHlXVXEyYlhZTWQwTERoVkcrN1E1anJlS2M1dWN2?=
 =?utf-8?B?dlBZSHRBMlJvVnNKdFd3eHlaZHBPTDRWRzM5SFVFOWNpU2syeTZKMXVicGdp?=
 =?utf-8?B?cDI0NllrN0tvUzRzdjlVRDR4Qlh3MDJWRWJ1VUlpaC93YWQwL01ETkdVbUZJ?=
 =?utf-8?B?MXdvNzMzdTNPNmRTd3huZ21qMjE0cWhWbTdodkZtNmFlUW9XYmtWUWFLZFFW?=
 =?utf-8?B?V2Y0dEJkOGFyUEw3UG1nOTE3VTN0NnZFemFxa3NBdGtmemFxa05JTkNWK2tl?=
 =?utf-8?B?ZGI2YitZQlZDdUJoTnNhZFBnVVFNNXJlY3BMVmVXNmFxN1plOW9wOWpxZm55?=
 =?utf-8?B?NytxOFliRXpkR1UyUGZ1aVp4MlVBb0NsZEo4N3AzakhaS1Fmc3U0K1dlUzhO?=
 =?utf-8?B?SEpRQlp4cW5saUJEMjYzTHUzUUFHcnI2MzFGckJTTzRTaWwrVUZ1dGtjWlpI?=
 =?utf-8?B?cFRDWCs4L0hmNXBCenZ3OVJ0T3JTNTJlV21zK1VaTDc4MWQxZll4cGtUeU04?=
 =?utf-8?B?UlM1dXhFbFNKMmFDKzN5MURFcFErbzRSTFkyYmZ2SzBCOFdCbWRoSVBCZk9v?=
 =?utf-8?B?US9iaWVsTU5xZXM4WmRBRWFrQnRhRERxdGo4UnZkUXNUUG9JNHBGSGhxS2c0?=
 =?utf-8?B?cDJuMGt2Y2dEbFRRWmUyNkpSQnJoUGtzNk5TVUQ0VlJTYkdUWHQ2TllBZjlQ?=
 =?utf-8?B?RDdBYVJBb2RDNWxPbXZSUzQxTXcrSW54TWlISEFsZWlSaXU4Ry9nbHdyQ3RE?=
 =?utf-8?B?NzBYT1NzQjhXQWY1eTR4RnpSR1JrWEtlQWlRWmN4NGUvTzhjcFFueDNwdEVl?=
 =?utf-8?B?aGk1KytJZTNycmRRRnBEcTNDRGZkeTVzMHNRYTNQamhndDE1SjRjZisvOThC?=
 =?utf-8?B?eDkyRFJzeGNjSlNrRTg5b1NpdVdxS0h3cWRDanFrVEJESnZNLzBpeXVNeE1w?=
 =?utf-8?B?cDdQeDl4a3RraTZTcCt5L1ZMMEU1S3hPNTZXYUxSdUx3Ymh2WUdqYUxEaERx?=
 =?utf-8?B?QUxtN29mWHl0WU4zZGFaaHBWRTlhcU5rWGNMWU4xbmU0Rkwwekp4Vm9EaFdS?=
 =?utf-8?B?dG9USGcrcUJwMHlwUGhSYTRHTVpvTkFMMUZTUzhLbnpCZjJYbFlpNVcxWVdq?=
 =?utf-8?B?VWkwVDcrN3pQT3Jvc2psRTdSWEMrMFlieXFuRVVDOVhxbnVldElYa3NOd0wx?=
 =?utf-8?B?VEJKOXRTd3YxQndBMU05WGdoaDZKUE41ZVZiRWY3U3B4bFRSR0tVZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wi7fY2vgfTm412FIn+Ad+o+aqzUduynCxy1A2NCdskkSDZsGg9EEPqi3ElFG8nX0YQhmW+xxcP/ke9wgIA3wTUcofWFXnl0+Fkk9k8GQfjPyTutIhYM91ZoYtARL/HfoI8vCSA7h3jMEOAAO4lYM+UCgm+OzyBCfAbiUbwBuBTzsCHfYGZBADMzG7oBitNbmK2C2+nSSoNCHcIlEDSA4L67DC43dit0kySHAnTCijnJ3sXGz0kGMJaVxjvA1502aXAJmt3MVf8+5AN0if+BKugX6pTsxm8nT6FXuCSAeWYOe6TiKE7k6n8ZLT9bZHGM6AsH28jQ6rg7VaVLBS5PB1OHgAhI4hQIhGUo6jePx7kbFwieUmZ44g+5vH9pnmhYzmPMkWSlm7EDn55IwCpk8W0cyOOWnshGtxf1M9Wtd3Wj2Spdu/7Xo8BjW/UwrqdsHMqZ1z9GjbcEPT+Qk+ORt5jY/G/O6Qd8kjkwI0j5OM1hhcte5lq+W4LpayelwiJblkRiYgItTl0KoAL3tOdBg83Q+MmuGISkLXT8VTt1+KTAbctORELLijnwpNmher3d/pyXsylAQ7pzo/EonabLQG5FTdzEc0wEjxDrQHwIueAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d99a10e-ac23-4cc5-a50b-08de67ba0a35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 09:03:06.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlsyYL/eL/NMLvqvBDR/hY7kCiJn3mU5VLZPdOT0vbmC5Jskz3vQ/8SG2XHvRxn7Fc750xIteRFSCtCBFoFoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA3NCBTYWx0ZWRfX/cubW8rV6Xit
 f7g2YbCPtWId2NdMHuS2WrTVlX3nrIv83YosVLGOIqqqT8qhTcYftwf+un84tGE+KOp1ntAoN/I
 bgkXyscM9I3PRYnUyV1AhbNRD4MUEB0iYSwZbMSzk6eVv5mR4J2pqdZE+quRcPyk0H7GSsVwebq
 mhkEcXXsFt75PCltlb/9EzBp6GD0kmfuY5LmUyE09R4udDjQ8Dq6xu4+PSL9R1A6QCB7uYMM8Ay
 rbNqYbIWwxuZ/2GlEd0vwJSLaZxsjGXTvLu2qAfEWgBiycateJYyZsJhLBCXfSEH4Z6hsa4n8ax
 Y6Xcn++rd87A894qsMW5AaRjoBhuDVCzPIyQPVxohq5seNXmj4Pq+4JlEBR1jYt3Tff7KTmqlso
 ZMdIP4x73kcmV25njFVOTm4DzUPh4Pm1PIP8enSYjZz8uBJa94HVCMdTuLASUXszsGN37d3piSn
 zPW8+m+pE6CgbKnhmtw==
X-Proofpoint-GUID: RyfEPIzy6KNTn3aAjUZmQJ8-_Wvo1h8o
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=6989a2d9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=bteKsnxhL8QTyr7ZhhYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RyfEPIzy6KNTn3aAjUZmQJ8-_Wvo1h8o

On Fri, Feb 06, 2026 at 05:33:52PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 07, 2026 at 10:21:26AM +0900, Harry Yoo wrote:
> > On Fri, Feb 06, 2026 at 04:16:46PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 06, 2026 at 06:34:03PM +0900, Harry Yoo wrote:
> > > > These are a few improvements for k[v]free_rcu() API, which were suggested
> > > > by Alexei Starovoitov.
> > > > 
> > > > [ To kmemleak folks: I'm going to teach delete_object_full() and
> > > >   paint_ptr() to ignore cases when the object does not exist.
> > > >   Could you please let me know if the way it's done in patch 3
> > > >   looks good? Only part 2 is relevant to you. ]
> > > 
> > > On what commit should I apply this series?
> > 
> > It's based on Vlastimil's slab/for-next:
> > 
> > bc33906024eb Merge branch 'slab/for-7.0/sheaves' into slab/for-next
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next
> > 
> > > I get conflicts on top of -rcu
> > > (no surprise there) and build errors on top of next-20260205.
> > 
> > Interesting, I don't get build errors when applied it on top of next-20260205.
> 
> Here you go!
> 
> Here is my repeat-by for these build errors, perhaps a .config issue
> or difference:
> 
> tools/testing/selftests/rcutorture/bin/torture.sh --do-none --do-kvfree --do-kasan

Haha, thanks! The kernel test robot reported the same issue on the
weekend. It seems I forgot to include <linux/irq_work.h> and it's
accidentally included on my environment.

Adding #include <linux/irq_work.h> in mm/slab_common.c fixes this.
Will adjust next time I post it, thanks!

-- 
Cheers,
Harry / Hyeonggon

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> mm/slab_common.c:1475:21: error: implicit declaration of function ‘IRQ_WORK_INIT’; did you mean ‘IRQ_WORK_VECTOR’? [-Werror=implicit-function-declaration]
>  1475 |         .irq_work = IRQ_WORK_INIT(defer_kfree_rcu),
>       |                     ^~~~~~~~~~~~~
>       |                     IRQ_WORK_VECTOR
> mm/slab_common.c:1475:21: error: initialization of ‘struct llist_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> mm/slab_common.c:1475:21: note: (near initialization for ‘krc.irq_work.node.llist.next’)
> mm/slab_common.c:1475:21: error: initializer element is not constant
> mm/slab_common.c:1475:21: note: (near initialization for ‘krc.irq_work.node.llist.next’)
>   CC      drivers/tty/pty.o
> mm/slab_common.c:1477:17: error: implicit declaration of function ‘IRQ_WORK_INIT_LAZY’ [-Werror=implicit-function-declaration]
>  1477 |                 IRQ_WORK_INIT_LAZY(sched_monitor_irq_work),
>       |                 ^~~~~~~~~~~~~~~~~~
> mm/slab_common.c:1477:17: error: initialization of ‘struct llist_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> mm/slab_common.c:1477:17: note: (near initialization for ‘krc.sched_monitor_irq_work.node.llist.next’)
> mm/slab_common.c:1477:17: error: initializer element is not constant
> mm/slab_common.c:1477:17: note: (near initialization for ‘krc.sched_monitor_irq_work.node.llist.next’)
>   CC      drivers/tty/tty_audit.o
>   CC      net/ethtool/eee.o
> mm/slab_common.c: In function ‘kvfree_call_rcu_ptr’:
> mm/slab_common.c:2097:25: error: implicit declaration of function ‘irq_work_queue’; did you mean ‘drain_workqueue’? [-Werror=implicit-function-declaration]
>  2097 |                         irq_work_queue(&krcp->sched_monitor_irq_work);
>       |                         ^~~~~~~~~~~~~~
>       |                         drain_workqueue
> 
