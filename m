Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FF3081B3;
	Wed,  3 Sep 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906312; cv=fail; b=YnRnRiX3489UfnJS/DYKX89bBEmictZAC/w4oIizh0xsxtvRejx23X+Z6iVpsp7wzD+MHRJrVbecmamUolL7GKOwr0UvxQWTsXghkayKkvAGC16DQdgeJr5hnceRNJrxhFtWApeKSyPcVI3kqfjgVEY0QTpmtZdALAdgSCVjLR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906312; c=relaxed/simple;
	bh=xsMU9HG5gnMpejZyZDlAJ2yH5naWPMEpKiGfJZrD5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vn5fHRNysQbLpe/T/DlJCuSH2bSK2C8rac8Vw9j/M60vuvS2DfUG40173GmvPcz7h0/JxvtIZ67FjZxJfPfZmqC0Ntjfp4mQ5ARb1hYSILM3HXJcZovtZINmFA7jnjT5ZyfGOlIjbMIkYwl6NUcVONlYcoCIAdsZgaGCkMzL4F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VMjjh/rB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ToWrSJiI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMjjh/rB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ToWrSJiI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NBfE016008;
	Wed, 3 Sep 2025 13:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=l/EpbuvLeFPhLUleXW
	HHd3jJ+QYN6Ooc8sYw1uQqZno=; b=VMjjh/rBm49hdP2IIr68VAZQsah60tGRKt
	EXRgNXUtoRiyBcWJYPrc6ExD56F/u3lIfEacKQFZBOWfBHr0GwhFSZ2osEoYw1eb
	muxTb+PfTLLrJkzLRsWxRa8cFyNUHjUMBiPCmch8fywv3Kj1lFcfWyaDcOKwHsRM
	/iBhoL6U7Nq0bP4UfQhwF3D/6ph/z8AsxM7GaZylmpFnnTT3SkMpwrFN3uUB6Qng
	Vui3Qi1lCySBa2NfN8EN9F2P2ICgScZDLKNAhy7qmpjZM2l5nqltc7ve5s/XQi1H
	MjDVM+MtjAzBNJOln03xCvej8EcNepd6+sM2mTbJV9W6jntxrJbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussyp7nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:31:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583C8ZKJ040798;
	Wed, 3 Sep 2025 13:31:26 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqra3j4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULCdbcJ7sMnRzzFLeI2m3RyyDnRJ7AXkDKSR/5cJgmi+NnmwVBlG7yF99ubtRpAytXa0AqXmnDuPo0oFaR5+AEUWmqRcdIp8cgpJMDgHP5MY8a23wSlz5h+oD1i3ZzZXtlLRxsLy2CBZtdNjCILwEafK/pc9NKpGCRVl8HFa06ZtdKqAZYS337UIunhVG1AIcQNU5ebPryPqZxhmVUtM2U3qXciw5uA3eQi3uMTdGtr4iBLRCuxu4y5kEpyCHmEnVdzweR2pD3CrtFVkuvk2e7DUfbLka590Vp9bojfbgdmmUAfkbXAKt4FJct7Qf9c1CfEyNDapG1rW64YcSX/Q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/EpbuvLeFPhLUleXWHHd3jJ+QYN6Ooc8sYw1uQqZno=;
 b=AC6FyVeTnSGTaFn0palENmqRrdT3Vw7o2i+Zj1nSbestem+XNyre8zUuiHS9os+hO94LaZO4M2krDLm5H7mxE3OJmXB+/wan1rhr9gxFuhR9acQifsIExu/TuuikNVoL5KX2ORd+zAlKnnKKbPpA20syUaxkE0Ke/fvMQUuPBlopweaOgD5aAWbS/0/i68K4dIW9Jc7VvIPrmmj7lbSue7k+TPb3skdWLEJUYs9WsUyL4rNPPmFcKk38O6Ltwil3UAFtA7jBIfiqK+EnnQqStMHkTzUlQLW0rsW9qKbzhriwwjxl750Ugh4sNLbHkCeU89s5H7dfvqG7kDhqMvVfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/EpbuvLeFPhLUleXWHHd3jJ+QYN6Ooc8sYw1uQqZno=;
 b=ToWrSJiIOdqh8j//uzHzOqnvl0U1RonX8vJrmIf7cqdZsaBnTjN4/HdKH+B4yK/fdLqUhPyxdJ+Zlusu7CoG4u6a+iOU0j0WBYKz3ooG4p98SnDGSj4edsBwlhHw++wcbTFlkJaAlPvyJ2iUPB1TZOiLTcNybD7rBi4qDkmAslY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Wed, 3 Sep
 2025 13:31:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 13:31:23 +0000
Date: Wed, 3 Sep 2025 14:31:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v6 08/10] mm, vma: use percpu sheaves for vm_area_struct
 cache
Message-ID: <d396be64-3a95-499f-a074-68297fa7bb48@lucifer.local>
References: <20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz>
 <20250827-slub-percpu-caches-v6-8-f0f775a3f73f@suse.cz>
 <195d00ab-5429-48ff-b5dd-a45b26cd9ea9@lucifer.local>
 <814c7054-3a43-4190-893f-22e074dc93cd@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814c7054-3a43-4190-893f-22e074dc93cd@suse.cz>
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 57898ee7-5da0-48ce-33d2-08ddeaee2d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dugPAJbwQDvfYR2acVkGTEj+ZT88gkHXVrIrvKBBuslgPryXWeDu7tIWwpr2?=
 =?us-ascii?Q?VAlU/UlDtDA0kAINhIxJSWkfvBEZBAxZOs4hlxHROrh982Dqsx4Cph+vS6lZ?=
 =?us-ascii?Q?ok1MrOUleE1U2efQkt52qP1rhVmkLrb/YOqDXFjfI0/QhX0Q9X5C0Ka6Rx+f?=
 =?us-ascii?Q?g1HInm1Fd14rpQs7JBzVLs0UzYZnn3UkFxWQhXtNJq9UOsKquLf6L/z0TJRC?=
 =?us-ascii?Q?jUMYNm+D7XBb4+GsdgH/1wsq+AoU5TCOlcYfnllBeai3uN35+nrWdd/F9Riv?=
 =?us-ascii?Q?VFn94VQL2zOx66NMU7zyciX5qESGcXJOTGo1rwMd4uKHQoIJwlcxCoo1wiVZ?=
 =?us-ascii?Q?C4TET+Xyj9LPtv/ktciqdZ5teWu//bis1ilBEW4KypAiusl5TomH79q39gRH?=
 =?us-ascii?Q?ta3CHJgJB9nemmSwn22JcLPG4HWI9GKQv2Vfxq58syGI0aEMCwFbDFdsV3+q?=
 =?us-ascii?Q?/yNz/stcY5A9n3CBOGYO/y1htbWfQDERGKmYeGYLkXv0v7ZFp3PYVbhR5MbM?=
 =?us-ascii?Q?TVO9Kk/gVZPc/XuIRM3VpWFZdJNaT4Phd8E6UETsjiSJepqiqX6oAS0U9arw?=
 =?us-ascii?Q?reI1gL9IAHVN5RgGPC2/SlvxgcjUaTvz+ZIHKeO004InKCdE+FrpCMiJyJE0?=
 =?us-ascii?Q?zjrOIB3NEb94c9NEfJiKiTkVMWDHSqzswBaTyAEQiLHSTsxBrXrT3JcP7vfI?=
 =?us-ascii?Q?Odi/Ruoo+UXqULz8ZM0ZndaHl5ulDYHrgZmFHt3OHZ4u4cdLatwD877v2JK4?=
 =?us-ascii?Q?82ImgShNbeNsEEP5IOCSBlDtkQWeWd9wX8yTN/qMVT9XLthOHzIBRnO1VFbB?=
 =?us-ascii?Q?7y/lz+0EmMRLRclQ8isO+aCktjrpThLloWLNFBc2hGc1i8tGMpG0J29eqb5u?=
 =?us-ascii?Q?o//RVWQ+L/o/CFcubGnOBoXE/swV0VAsfTc82ByHMPZ5/MrNuMQTSv/zZkHj?=
 =?us-ascii?Q?hOAm/XbdsdATjBMF8jqMfDZggiZCAUTq4I1zAnjTbeDPHzwI0quTi4R0b78m?=
 =?us-ascii?Q?ocqGqBAg4z6zlfyPpUgOZSjR2kka27sasxHVHg+dZ+WEfHFGLrbiwhNQhYQB?=
 =?us-ascii?Q?JWNP26IFgnkO1qx9A5gZ1rgpbOEeavdpuiAsb8oEz5ftzevah0niaUy0oQO2?=
 =?us-ascii?Q?fhn8maZnMN4VC5UDPbDPqKKU74Q8igl8ByXivRjx/on6Z2rJy6VYnz0SjCDe?=
 =?us-ascii?Q?uRVkHPYAdWQ4QKTA5O9c8mgslDUBpCdoVI6jkNgKma5Jjr2ho6Bh6MOa2cbP?=
 =?us-ascii?Q?giI8MwP86yUuHb5pz2J5vsN3MDKObcoj2NWqklYUqZgJkhCrbNCa0Ty+mjuC?=
 =?us-ascii?Q?AobCPzPDWAC8AINeSZETpj8dgLg8WpqXLl4uW43gqFbnNXEhK8VKkVUxa9yB?=
 =?us-ascii?Q?Hm6OfQ+dOeXWBR1Nc4aCKpR1pYkFrQAGEh3w2/cmrc9sVpURYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8AaZm1+cRWfN7SuEoP/3d6C0LdvwzIdtYLhIsO5utdj3Kf9YgWq4P1M0vbr?=
 =?us-ascii?Q?0NoQ3heUvI9ugMXxIrCPm6aIJj8uVPLlYMupCZIsEfVXcazjASg+qdYFlVkw?=
 =?us-ascii?Q?d0eSneQbIYUxuQ0ytOSOfNNsMgwbt+7R6JkuyTK/iBf6PqqB4x4rLrg/UmAR?=
 =?us-ascii?Q?G2ps1Pha+V9PB8Bu0C/t1ZjLnnIMlr6NrSLViEa++4nDELYC8EBPc8L5Sm5v?=
 =?us-ascii?Q?yeIaJEohOXssJylCdeHOe6TRYl0MlGhEfdVQGUK0E+S1WHpaVxscQcmUATGK?=
 =?us-ascii?Q?ptTmFkI/yd7JjBTQ4p2oL+Ysy9yZhItounxj7cxBXhopARDIOdMNHe1q/OgI?=
 =?us-ascii?Q?u4HtTLF6pSaMpdSkPwyhzUlit0CsuGvzeSDkZWKqZBD5dClvRWj0hcYGFooH?=
 =?us-ascii?Q?uUfosWc3hKjyU7+os6p66xGn8ocpIlUh21kjuUqF1b4caFmzxhb3rovpaLvP?=
 =?us-ascii?Q?QbEt/fyPHjtMi4OCcDmSwPkd7XPgYoiZBILaYElfyJMTp+IvsfRLgqOcIiMu?=
 =?us-ascii?Q?dBHmD/wmSoHhsRxXNS+XDmyTII3ymBPbHD3s674t+6h6MpST7/ZO10p4DXHW?=
 =?us-ascii?Q?u3GAONoXjVB9D7pI4W+vyggaRg9kleXOsKCc54Xh2muMAvn0Q5iN9UonnjEu?=
 =?us-ascii?Q?o3WkGw9XUoFAR1H9vQk4G63dxdfeP+3iCNs84veJVq3P2F9Phggbtd5/yMTG?=
 =?us-ascii?Q?Z1eRtFs0xGN4AV8cf6+0/ma9IcnaG5Oka++VDGq4E9nsCmab2bWVtQnR8q6I?=
 =?us-ascii?Q?nM5I5l1xMlMReEpBDyViR/D8Gvf0YG3uSbQPrO5lGWBt1JZpgGv1SWBKUF8z?=
 =?us-ascii?Q?otTtkJoxcsl4+iy8NO5EwP4Gz8WfOiMZo2p84TSgk3kcS7iMYa/HDm/39SVW?=
 =?us-ascii?Q?A5OJ+IIuZk5s4I9rkSaZnwPI2rusYFSw6lyVNqBeBmxud4MrAzQ9E1y2Myyv?=
 =?us-ascii?Q?ltvSwUSIiq/VqtypILTRK9OAM8F5IFcU9H2XRR78hTg2Am6sW6A+25egHb7a?=
 =?us-ascii?Q?ul4hBZMVmcfjUkN8ot9Dc6du9GwW3O4vkDXjJvMLeVbW09NTwgnO7843B4+s?=
 =?us-ascii?Q?4ymj0ZzXO1uKjhgwLK5kG7ct8kp4JetAlK7E6qPv8ZM4DfkxDLnyGj76AAYL?=
 =?us-ascii?Q?daWpG/iPFuFZ1kKFu0QaL+TN+F3jlQ8slqWrkHlegfAzeeCiknDtZCEE4UbJ?=
 =?us-ascii?Q?Q5IyHyO1Yz3DxHrgzF/Cla/gyfOVGRgQeslB0LQvz5wrWO8+5mViOEUkvHA3?=
 =?us-ascii?Q?M5ZF1s8zDwTX5To/oKL8Mv+rjMcIdX7q0MMlpOYV31HmoTfb5MiSf9U9S25y?=
 =?us-ascii?Q?Qc0bwAsxf7g4rJiVocClwzmPWZKn/zLytaAcVrAh59C2/jDCv/3XE8gECASg?=
 =?us-ascii?Q?mFXh6J79DtZ3Nic7mLKANYQFjVBPoAC4Kr8xe8ThVtuRKm1BW2/TH9Y7GRNp?=
 =?us-ascii?Q?WdR2R5ulz+ZJQa5Mrt/OIJLJHReanS+uBTfUf46nDruDnAsCvxeRJ0V39Dq9?=
 =?us-ascii?Q?72bKhK7mUFWv2cddISZYUCOydYMDZ4idqpFJHHduKvDhyLoa6BACjEu9OXY6?=
 =?us-ascii?Q?sMBMc1AnA3NYCK/C2/eTTr2Mxr/hWPW2BcULlBWq0niuGMO7jE2fzjOchinM?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xZKEdu80HcqLkmo6+jT3HXkBkAyn8rlYGV+s8ry3DCZ6QBv4dSpFrR/ejavftMHU3wRnTVVNntg32WxA0bp4S+Vc4tf6smWlZW9F4c8ABgy1bLSNudTpzti6O3YYX4TGD2DxIcoPhyP4HxbIJ1sAtYxFWZlU8XmvjL3YKSpegGjmVox6VivI5v1HJgj+AjtHxBnY14tuxkwLdF4QnXfkA0mewQIl+aRvVauAFAwBBYspEuDBmZ07/kzmAf6l0cuYkIvhehey+iILi7XE1OAzEc/7JRW39mXvjK6rYWKGfhMLec5UoHW34XbMxoED2D04Mrwv5022Sr6FDG01zW6ijLNZvCndLh1qPa38E/KDLEA9hkJItNjelwMsab2uIznkppsmsuL5q4t804CoFYwb8WjsVecPH0mpVcZ+2E2HYuIQ4FQK/S61mslj32zv4imIWO4N9dRP6OMHMRu/lAZbamVow2qTAnDzkbM/akqAsmAfXlZoFdBRdqoDTLLBzImSy7+OTXphYvtfZ9QZaPTFEooQTuag12OWdf2ffBjX4jMH7dJPoixDPF94Tk7tryNT/TbfFBx7DbioiKmihhPEA5hyWGt/kVTMe0dq2u6z9I0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57898ee7-5da0-48ce-33d2-08ddeaee2d0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:31:23.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcpzG7GdiiT+xKNs4cUa84t/kfzqAZO7g4ijrPUrdlrZRtgUNbsR9ief6KmICJ43vLQNW1E9WIQE6fIvHpP3izJaGdSYO2HDPEGCqe3z6OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX7VPB9Zw4paVs
 4x/gWP0g3XQ4OWFvnzBrkSpP3TMoitcOwYqmX4LjdjttOARzaaaYUESBy3fnZ1hJ0Vjg7lN/Q5n
 YdHK+PHbRv0DX09B4jJ3pTbc6fVg6fMUivBvQ2r0Y8hZjsEL6pIYPznbXwjvDzxua5uWkN44sjb
 QM+0s/d/w8f6rs8WA1itRoF8CA+lOgif4Fk4bowIdpMZEyv2GKkbh8e1DSnv1Kdwo0lNkbpOyTQ
 fMHnZVhKpmTXuxp4qIQs3Gjyp8v3uAWFUQvdxMx29uxx/m3UeDHVAdgFcpwf6m84xXtpKib3H0r
 2iqKWANNn/OEq4fSSIQPU8/yRhRuY+IYjYGEosjlJCzM7DVufTK20qs53cDtukh0909otkCf0ZU
 QVgLi8da
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b8432e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=mJ251A8HwLtJxyzuMY8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RCE-4J7x0UA8lmhoTJh1gsbgrFpZ6XHX
X-Proofpoint-GUID: RCE-4J7x0UA8lmhoTJh1gsbgrFpZ6XHX

On Wed, Sep 03, 2025 at 02:47:28PM +0200, Vlastimil Babka wrote:
> On 9/2/25 13:13, Lorenzo Stoakes wrote:
> > On Wed, Aug 27, 2025 at 10:26:40AM +0200, Vlastimil Babka wrote:
> >> Create the vm_area_struct cache with percpu sheaves of size 32 to
> >> improve its performance.
> >>
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/vma_init.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/vma_init.c b/mm/vma_init.c
> >> index 8e53c7943561e7324e7992946b4065dec1149b82..52c6b55fac4519e0da39ca75ad018e14449d1d95 100644
> >> --- a/mm/vma_init.c
> >> +++ b/mm/vma_init.c
> >> @@ -16,6 +16,7 @@ void __init vma_state_init(void)
> >>  	struct kmem_cache_args args = {
> >>  		.use_freeptr_offset = true,
> >>  		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> >> +		.sheaf_capacity = 32,
> >
> > This breaks the VMA tests.
> >
> > Please also update tools/testing/vma/vma_internal.h to add this field
> > (probably actually at the commit that adds the field in mainline :P)
>
> Thanks, one of Liam's patches to support maple tree tests with sheaves does
> that, we somehow missed that the vma test also needs it so will reorder
> accordingly.
> > I do wish we could have these tests be run by a bot :/ seems today I am
> > that bot :)
> Sorry :)

Thanks :) Just happy to find the problem and help it get sorted! :>)
