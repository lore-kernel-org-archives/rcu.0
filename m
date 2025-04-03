Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD12F4A;
	Thu,  3 Apr 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669110; cv=fail; b=ARe4xGb93aWGclUXUnuY2M8moi6WdI5DO/9z91TgcQ21KJx6xHpkGVkp/ui8IjlurQOyt7lxLlq02J94NazwJO668vv2M5NV9Ur5FeF2SPFEDvzabrvnjXkxQ85GMiot9sbmd6bqWow9/ppu2OznmFPRvEdlUdLMLg9VQLHEaYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669110; c=relaxed/simple;
	bh=09mwoxaBWARQjbytzW47uKjLRhzfArBR8it0cqS8sHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NnYhjVAqKt0RfFsB+D8vjm7G9nTZEefcKbBh+awd7ByP9dZjvKN10zXt0jW79PAELw2eWwnKAled0JDHLGMFfgyp+x2cu7HdYNeVknsXiFcMi0KFtT9dpF/qeTLAKA6i8XguyEB6IqeXgVc19pPOKv6BibxZpByYq4/PWJiv6Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gu8Dtwsf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yyzHGcNx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gu8Dtwsf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yyzHGcNx"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5337tt5X008180;
	Thu, 3 Apr 2025 08:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ect0dlA6x+lk9HdCOo
	3Kx9lbIAHqURWouDJVFxwh6jU=; b=Gu8DtwsflMiS7TNdTePQVtzFDmzRWnbphD
	27K8wiQ+ZRKdIlpuQ4IrkpJVNwEdQyDlcn8X+oifEIpzHI0fXSXmqZJYzfwv/yYn
	ACpUK94VXcK83nAfTX9mmNlIl4iiyGELjVbxi6aPJuEdZuGmr8TqQB2bz/BdlJ96
	9lgJKpBbG3uVloWTMXj+yVUbmyX5oZU0vUz962ekjDazuS/kcfGln6N5+UfSyJn9
	kaXEGT72eNf+l+rj50NLBgpClTKE/fmeuy5oHN+adAf/dNo73dKi5ezsmR0mhPTF
	sCaul2YfnOo1ZU0QkqK1MV36RZPVYYMHCTXo9u4mz746WTFwQfzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2cmpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 08:31:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5337UWGA003407;
	Thu, 3 Apr 2025 08:31:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7abr6qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 08:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoHBpT6baVqwfxqL96fD7QX3wqxq+50/dCZsQDvtw1wtMGFvTy1cS6paIs9EGUpICduCfUIvAF605fPMXq6DBWNvsutmcSYwOK/wq0ph9Hj8UCZqPHZ2YxjymHJGGU7vvvG8K7wlAfbAQ85mS5PGzQIG0RGjaU1ZUwsD9SRnZwQt1lhN2WpP47zTL/aqHJw4QfOflaTaLEhuCutSQq1WwsUWPw0r3Fd46jwegfRF/77c1t4LL/tglBgpMFJdvebBwmrADD5kDNC9vaPUjULzCB9ghbtqONBzZNQvUUq0Xloh5xKxQmrYhJs7a8C6E1pKQLWmYPNkfId1K/3ZOz8oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ect0dlA6x+lk9HdCOo3Kx9lbIAHqURWouDJVFxwh6jU=;
 b=KQUEPlp4sLPM0q5ZKTDbwIkS5Mw5hbJInffS06yi+cQGuDUvE+4dfOHvE+7y9Y26zKBf7xSlvUZyrQqFTHUfqaVmJIqwA5wBj4RetFQEBLXiGcXrRoRS8DoPeFpdxZfNmoX2s9sKwi5qR7qqyT1JmVDRtZreOpOkyxOVpfHnJGe4Ou8TGpecyyaBVs5h41MFcdufllrthNjfjYYMQql63EEftMzAOSFjSnYDSuRSGP2pQx2v7JdT44k0CpjPTcIHDfEx84I6AODlHSqLjQFP/CuZIVcsMSkiMf6payJa1HkOODfEOAsHmExEUe1EnfaNzKSGVv94cYTERJCntKokGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ect0dlA6x+lk9HdCOo3Kx9lbIAHqURWouDJVFxwh6jU=;
 b=yyzHGcNx2u7DMo0JBIe14V0PcTYpp8KWW9/bfNZr/YqRncIN3MvZgqzrA1Sm2CeK99e8fknmBuBE0ZGFHcAps3K4U3lnsnbIpekAUqYhXGxYRmm80490phQvgrGasDvNoLskf3LWQO6WHcCW9wgURzhRTb5odchnRB54FxtovCg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7310.namprd10.prod.outlook.com (2603:10b6:208:3ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 08:31:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 08:31:27 +0000
Date: Thu, 3 Apr 2025 17:31:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v3 2/8] slab: add opt-in caching layer of percpu
 sheaves
Message-ID: <Z-5HWApFjrOr7Q8_@harry>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
X-ClientProxiedBy: SL2P216CA0129.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfa3259-0d9d-4b3d-7c37-08dd7289ed72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2jJAkGT9tNYcv1MeqQiUAW1lHF35dgp1rvm2HreRSgi6C3ilT4fC2ZGE3mB?=
 =?us-ascii?Q?WGzf6tmbD/BJ1CQGp+T9lj+hhrQRGE48HRzrP2AvE+6c+osC39tahKBhbstt?=
 =?us-ascii?Q?Q4Yjxg9Lf5Ix5UOYMMROrnnpq8IJvCWwuKcMsCuzbotYHJJE9pqPqQnHDbzO?=
 =?us-ascii?Q?d6dHtsUStNl2gdaQZHVi9CBNuYIl7Y90t0gaSaFLF1HFjHCvxY1rUiRGfkB+?=
 =?us-ascii?Q?IZwNK6ttE84p/KekZ5gd56IDpXP3sYfAw93wnw4s2uAX3cCfcjQEKTzhetun?=
 =?us-ascii?Q?puaSvSvQ5MxRNFJts1WOAPTbL4lQo0fdGu2U2lriB5WsrCfQXLUrEeCdox9H?=
 =?us-ascii?Q?CVfePs82nfW6BYfYqwxqb0+5VzHjmK1seL3EP70UzYGlU12oMZ/XW2dC672E?=
 =?us-ascii?Q?HNr81VqY3b1saJFuY+ruRFrFPXQGBhrP8+YYEuypOGaHwvfY2xf0Pqx4NAn/?=
 =?us-ascii?Q?oGbmnFIQe+Dy8oc4xkV9ntHtTKompigPK+Ov8RVJvbLA5bs11xUg5dTmpPCs?=
 =?us-ascii?Q?7hrdzgBA8yJytkpF5v1e/7MOmt5BwDJofXyxLfETrwuY5B/B/dXJbJITW86K?=
 =?us-ascii?Q?C8HrUGIztS2LBtYG3FIxtZui8QvA+/x4WCE5/6yRBJwELDwn0VPMnhJAXQCQ?=
 =?us-ascii?Q?kgzDOIJy/YT6qxAwT3SKCKpMjbw9JJgSurCmLFEdO3US4UjimqtEeS+nYl3w?=
 =?us-ascii?Q?dJKpeX/vGeK9UcXXh7qmg838f4b8i92v055EZHM9M2tL5n2+J9msIwA8IPd7?=
 =?us-ascii?Q?1cFeSwFnKjvCTrQ40D9qWuZ8x0hMzLqGioFcubvpjo3DaDj7X5gNE+sqOhCv?=
 =?us-ascii?Q?XvFilO9LvxRQ463nvB1KgE/rI5vqjRyqdyYrjntPTSBrhun6BDscjKpr6/5z?=
 =?us-ascii?Q?KP+Q6ETrV/YaXk1Zd0+Dr+yzWNmU9+Xv7l5kPPE6VG44sGMBz5a//2y+DQZs?=
 =?us-ascii?Q?hzH+ENmt6PWYhiQebW04j6VY24Gv1Q3pA9KSR/+sEbFzDjo5ORMUP/O54RKY?=
 =?us-ascii?Q?QzCZYlGIvxStn5VFFWPQruPzCExbesfph09Dp5/et/LIO1GoKvEFFLz9RlM/?=
 =?us-ascii?Q?nwS4HDHlRZPgrcZ5ey1bKdOe6gXq3O14kSRDtVv0d77Kj1heHC4RioKxU+cE?=
 =?us-ascii?Q?wVNnsvjcv1AYnvQlnxUr3GFlwahDFoTdgsDzUdV3s8LFsjdpWlV1+oj5r2av?=
 =?us-ascii?Q?PUqbx72CHPbfQC89+DudpSNBHxLds6AsIJ4Sw2ZMSKfbm6i722FJCUMDMNB4?=
 =?us-ascii?Q?0IREcxJV8LfieG61sJAfP3DWBax/3gmt6DsWoy2z4XLkUA7kTgjQHxfKqEKN?=
 =?us-ascii?Q?Vb9cSZsfEFVvXEzJxgEdVTt2hjwTM6twRjaQBH/6JKZ7hWobywd0BEWGpUB5?=
 =?us-ascii?Q?xTFWuocbq/wAqipMEC+V1CyzMQJB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bKZeO66mIIxDPKFua1A1k9vBhzjbEXAh+lH5fwFJUEIJADbdZMTYNi9Fi6BA?=
 =?us-ascii?Q?hVXRaReFQgB8oxN1Ubpaz/j7AciA1p+LsPHWH0TnMzyyM+NcqYob3JDCbVmU?=
 =?us-ascii?Q?J5PLppG54lGMe/6Vp8yok444TTfrQMkigVnFnaI0iNUBwrshzsSbtUd0IvS9?=
 =?us-ascii?Q?Az7toCB95jCzZbtJSu2tJveHobPHdzbAqxXK+hyzaISq5NjBxZUk/F99Qv33?=
 =?us-ascii?Q?YVc/W1b7FI3ucu4vmz3O5lngBF8LQzZcfIk9D1vp9BAwRF32XZ7mN+U9Y2+l?=
 =?us-ascii?Q?FKqjvC6S9pvz7Nk+280A3a6leYDf6jcoaPSaReQsOb4e1j46PocKo1wYp6LH?=
 =?us-ascii?Q?jVsLizyanWMqGQPTmCSbhB6Vybg7tqu6WNqm6uUnwJIJ3cxC27iCYodLb5v7?=
 =?us-ascii?Q?n9Osi9/7qTuRZdoPdtrTnNdnEcWnlAmzJxPJZAcG4J5NnZT8FhiDPEV1eyNv?=
 =?us-ascii?Q?M+YI80s5hUyeCBh/6OHhdj41Ou9OLj7XJc6mRYCU05r4/i5RnltV0dTPD0Zb?=
 =?us-ascii?Q?JCHGyoecGh/ue3Z/8pQYmH5KITc9RNdzmOen7RjGAfAcdth+phxFvSocAqSE?=
 =?us-ascii?Q?wnaBOcs6aDPMlcx6p9s+zpZghug5dHDu+JrpWtMlCH7Uj4whdhkOv0tmkQ0u?=
 =?us-ascii?Q?kjwjcSXLEw9pi7RL9GCL/xH857GUBkkHdfS8N9PbxChkZorckHRnDSclHiNq?=
 =?us-ascii?Q?1WsvsAMd3/Oo2yYUNmU5dN1IgW+fYPorgZeNrc0+fvKGxzWaS7YD0WUtT72H?=
 =?us-ascii?Q?mzuWN0RO8rj7Sx2YfC1MdHSekrruyL8M+PnwxenUpmmdx5DFamDTnGlXUblU?=
 =?us-ascii?Q?1oMJErOdTulRJ+igSupMyVApkXsstXkEGm08UxvYLdn2r/kmXhGV1v8h0nhv?=
 =?us-ascii?Q?3ZkuMtJT3m4B2rN8iOkpyIHVJoZYgjWGOLlvbxJ4rhXVeRmi06eSVH6xO75S?=
 =?us-ascii?Q?IkAOR7j9ZYfA9BtDYkH93HPfgF0NRPDG5OYfjCweMqNLN7+d71GuGcSRynAe?=
 =?us-ascii?Q?ZRMjZsurZrEyW9lt7do4z/cA8VfS1Um/C+Ers40cIQuAdH0utpctcFUoDJd8?=
 =?us-ascii?Q?bC6XNXCs0EXnxK9jsNymsfGdAtGIMQc4b50ecxfq4foExy46tDXk26Mv4ZN4?=
 =?us-ascii?Q?Fga4eadooAcZl9aesj8WSVBjOm7j8SIgcAinlVNZQRj/oNJgVugwmhwDS7KR?=
 =?us-ascii?Q?AGySntg1d5hlnYJM4JKzlDfOZXom3+3uKSfdRHsfPQ6Jvpf0eZ/39KBLUify?=
 =?us-ascii?Q?q5aALi8G/FNBOh5X5kZCOJCoaDcUVCF0FGgv6BO2DT5x2ARdJBhdqVPCPMxr?=
 =?us-ascii?Q?y7M3cvbotkKQmn6SInkhcpjfi+G/2md+TdLtQGgZsU5OdVeRpphiO5OTxRtJ?=
 =?us-ascii?Q?OxxyE+/M4b2HLsnlURxreCHmy3W28kb9B192AFdLKUMrnVGoV0xU22LIAaqM?=
 =?us-ascii?Q?gpWZ5GrjHpQ1z2QPLWCp+YsJlT/nWJsCVErDckzjlq30ULyhwOvB6aWQC99l?=
 =?us-ascii?Q?FgNUsYtMdpDdMW8KLBLw8elht8hsE7cBFBHe1iiwq0xPUGvPYJt0hQS2bmLV?=
 =?us-ascii?Q?LOxM1alBakTa0GxWuclh80aaR7ICQescOJAy7ADv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hgb3h9zzx0WHhrtyGLv5E/IH2riDDPs9xjzIPTg6PfNT64LcMXPxxOX61Ar2RtbCDVnaUJn8A5BO7BdmfQbFtUD8X8FWOk9u9t6aPa3MjWTh1+cbXQTz6xpZXBq1TaU5pK/IUAkVTB5EgBbH1fEbDl7GheOANu8V2z+fv0LEw5Y3YgbdMxEkSr9o5dE7X7A8VkFY1XnIU8AjYt6QvmJSB8NlA6r5fRQSrjE0lnSLVJBCfObL/HlZJE8P0PAhh8XLYwbV5MIXKJMmRQYH9DSQf/rNlVjiKErSdNLfyop+BUrNhVRqbZcVF9i1p7ZRE8gb5qX21IwpNbYV0cIjbq6baMPYCnYOhjHmQGvOj9qmrV4DXYzjUNl4M85ZtdifoDzEMVJVG+4N4WZ93ALqVS7RJxWrDLyorj2lyF5fQFxcor6f96gZVTH960QTPR//576+J6ikXFxf2J+MWRSDLiulp24kT1iRj5ZENIqAXB7AEiFBX6jdaiO5VbFGajilkH+fas6V2xXgGiAI3xR2Ct7OABbVKxKKN1/NJA0cqnY8mP6IobHpvWixS3DVOKvfzZlb3kv3LTe52oH0GWb9XgL/qDwWgGSQKafID0DiOEm6Y8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfa3259-0d9d-4b3d-7c37-08dd7289ed72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 08:31:27.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex0h9PJfMmGTDx+Eo59qNZffaGiTtEu7/mE+bnkX9s4EfYB9vGre27Dl4PG/J5WXeyH8OIoHSQfClQ8QyZ3WSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504030033
X-Proofpoint-ORIG-GUID: zDoHxdrp00S7DrkSlr0gbkEMeWzrzZ3W
X-Proofpoint-GUID: zDoHxdrp00S7DrkSlr0gbkEMeWzrzZ3W

On Mon, Mar 17, 2025 at 03:33:03PM +0100, Vlastimil Babka wrote:
> Specifying a non-zero value for a new struct kmem_cache_args field
> sheaf_capacity will setup a caching layer of percpu arrays called
> sheaves of given capacity for the created cache.
> 
> Allocations from the cache will allocate via the percpu sheaves (main or
> spare) as long as they have no NUMA node preference. Frees will also
> refill one of the sheaves.
> 
> When both percpu sheaves are found empty during an allocation, an empty
> sheaf may be replaced with a full one from the per-node barn. If none
> are available and the allocation is allowed to block, an empty sheaf is
> refilled from slab(s) by an internal bulk alloc operation. When both
> percpu sheaves are full during freeing, the barn can replace a full one
> with an empty one, unless over a full sheaves limit. In that case a
> sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
> sheaves and barns is also wired to the existing cpu flushing and cache
> shrinking operations.
> 
> The sheaves do not distinguish NUMA locality of the cached objects. If
> an allocation is requested with kmem_cache_alloc_node() with a specific
> node (not NUMA_NO_NODE), sheaves are bypassed.
> 
> The bulk operations exposed to slab users also try to utilize the
> sheaves as long as the necessary (full or empty) sheaves are available
> on the cpu or in the barn. Once depleted, they will fallback to bulk
> alloc/free to slabs directly to avoid double copying.
> 
> Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
> allocated or freed using the sheaves. Counters sheaf_refill,
> sheaf_flush_main and sheaf_flush_other count objects filled or flushed
> from or to slab pages, and can be used to assess how effective the
> caching is. The refill and flush operations will also count towards the
> usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
> counters.
> 
> Access to the percpu sheaves is protected by localtry_trylock() when
> potential callers include irq context, and localtry_lock() otherwise
> (such as when we already know the gfp flags allow blocking). The trylock
> failures should be rare and we can easily fallback. Each per-NUMA-node
> barn has a spin_lock.
> 
> A current limitation is that when slub_debug is enabled for a cache with
> percpu sheaves, the objects in the array are considered as allocated from
> the slub_debug perspective, and the alloc/free debugging hooks occur
> when moving the objects between the array and slab pages. This means
> that e.g. an use-after-free that occurs for an object cached in the
> array is undetected. Collected alloc/free stacktraces might also be less
> useful. This limitation could be changed in the future.
> 
> On the other hand, KASAN, kmemcg and other hooks are executed on actual
> allocations and frees by kmem_cache users even if those use the array,
> so their debugging or accounting accuracy should be unaffected.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |   34 ++
>  mm/slab.h            |    2 +
>  mm/slab_common.c     |    5 +-
>  mm/slub.c            | 1029 +++++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 1020 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7686054dd494cc65def7f58748718e03eb78e481..0e1b25228c77140d05b5b4433c9d7923de36ec05 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -453,12 +489,19 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>   */
>  static nodemask_t slab_nodes;
>  
> -#ifndef CONFIG_SLUB_TINY
>  /*
>   * Workqueue used for flush_cpu_slab().
>   */
>  static struct workqueue_struct *flushwq;
> -#endif
> +
> +struct slub_flush_work {
> +	struct work_struct work;
> +	struct kmem_cache *s;
> +	bool skip;
> +};
> +
> +static DEFINE_MUTEX(flush_lock);
> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>  
>  /********************************************************************
>   * 			Core slab cache functions
> @@ -2410,6 +2453,358 @@ static void *setup_object(struct kmem_cache *s, void *object)
>  	return object;
>  }

> +/*
> + * Bulk free objects to the percpu sheaves.
> + * Unlike free_to_pcs() this includes the calls to all necessary hooks
> + * and the fallback to freeing to slab pages.
> + */
> +static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
> +{

[...snip...]

> +next_batch:
> +	if (!localtry_trylock(&s->cpu_sheaves->lock))
> +		goto fallback;
> +
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
> +
> +		struct slab_sheaf *empty;
> +
> +		if (!pcs->spare) {
> +			empty = barn_get_empty_sheaf(pcs->barn);
> +			if (empty) {
> +				pcs->spare = pcs->main;
> +				pcs->main = empty;
> +				goto do_free;
> +			}
> +			goto no_empty;

Maybe a silly question, but if neither of alloc_from_pcs_bulk() or
free_to_pcs_bulk() allocates empty sheaves (and sometimes put empty or full
sheaves in the barn), you should expect usually sheaves not to be in the barn
when using bulk interfces?

> +		}
> +
> +		if (pcs->spare->size < s->sheaf_capacity) {
> +			stat(s, SHEAF_SWAP);
> +			swap(pcs->main, pcs->spare);
> +			goto do_free;
> +		}
> +
> +		empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
> +
> +		if (!IS_ERR(empty)) {
> +			pcs->main = empty;
> +			goto do_free;
> +		}
> +
> +no_empty:
> +		localtry_unlock(&s->cpu_sheaves->lock);
> +
> +		/*
> +		 * if we depleted all empty sheaves in the barn or there are too
> +		 * many full sheaves, free the rest to slab pages
> +		 */
> +fallback:
> +		__kmem_cache_free_bulk(s, size, p);
> +		return;
> +	}
> +
> +do_free:
> +	main = pcs->main;
> +	batch = min(size, s->sheaf_capacity - main->size);
> +
> +	memcpy(main->objects + main->size, p, batch * sizeof(void *));
> +	main->size += batch;
> +
> +	localtry_unlock(&s->cpu_sheaves->lock);
> +
> +	stat_add(s, FREE_PCS, batch);
> +
> +	if (batch < size) {
> +		p += batch;
> +		size -= batch;
> +		goto next_batch;
> +	}
> +}
> +
>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
> @@ -5309,8 +6145,8 @@ static inline int calculate_order(unsigned int size)
>  	return -ENOSYS;
>  }
>  
> -static void
> -init_kmem_cache_node(struct kmem_cache_node *n)
> +static bool
> +init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
>  {

Why is the return type bool, when it always succeeds?

>  	n->nr_partial = 0;
>  	spin_lock_init(&n->list_lock);
> @@ -5320,6 +6156,11 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  	atomic_long_set(&n->total_objects, 0);
>  	INIT_LIST_HEAD(&n->full);
>  #endif
> +	n->barn = barn;
> +	if (barn)
> +		barn_init(barn);
> +
> +	return true;
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> @@ -5385,7 +6250,7 @@ static void early_kmem_cache_node_alloc(int node)
>  	slab->freelist = get_freepointer(kmem_cache_node, n);
>  	slab->inuse = 1;
>  	kmem_cache_node->node[node] = n;
> -	init_kmem_cache_node(n);
> +	init_kmem_cache_node(n, NULL);
>  	inc_slabs_node(kmem_cache_node, node, slab->objects);
>  
>  	/*
> @@ -5421,20 +6295,27 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>  
>  	for_each_node_mask(node, slab_nodes) {
>  		struct kmem_cache_node *n;
> +		struct node_barn *barn = NULL;
>  
>  		if (slab_state == DOWN) {
>  			early_kmem_cache_node_alloc(node);
>  			continue;
>  		}
> +
> +		if (s->cpu_sheaves) {
> +			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
> +
> +			if (!barn)
> +				return 0;
> +		}
> +
>  		n = kmem_cache_alloc_node(kmem_cache_node,
>  						GFP_KERNEL, node);
> -
> -		if (!n) {
> -			free_kmem_cache_nodes(s);
> +		if (!n)
>  			return 0;
> -		}

Looks like it's leaking the barn
if the allocation of kmem_cache_node fails?

> -		init_kmem_cache_node(n);
> +		init_kmem_cache_node(n, barn);
> +
>  		s->node[node] = n;
>  	}
>  	return 1;
> @@ -6005,12 +6891,24 @@ static int slab_mem_going_online_callback(void *arg)
>  	 */
>  	mutex_lock(&slab_mutex);
>  	list_for_each_entry(s, &slab_caches, list) {
> +		struct node_barn *barn = NULL;
> +
>  		/*
>  		 * The structure may already exist if the node was previously
>  		 * onlined and offlined.
>  		 */
>  		if (get_node(s, nid))
>  			continue;
> +
> +		if (s->cpu_sheaves) {
> +			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
> +
> +			if (!barn) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +		}
> +

Ditto.

Otherwise looks good to me :)

>  		/*
>  		 * XXX: kmem_cache_alloc_node will fallback to other nodes
>  		 *      since memory is not yet available from the node that
> @@ -6021,7 +6919,9 @@ static int slab_mem_going_online_callback(void *arg)
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -		init_kmem_cache_node(n);
> +
> +		init_kmem_cache_node(n, barn);
> +
>  		s->node[nid] = n;
>  	}
>  	/*

-- 
Cheers,
Harry (formerly known as Hyeonggon)
