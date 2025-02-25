Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE51A5BA1;
	Tue, 25 Feb 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473705; cv=fail; b=fcnei1u6nvTbAGkncmcTMX6wccdOLsFXtjbOcFoUBXCESm08vOj6WMnxPE5pN/KQBx/SPlyjxMB2hWZMd9G+gIsCF3D8VTAh/tiNOfe062mgfz6+WhWxs5fenyAhBsD6iSKZ7htx+UPubs3V8xtiHt16JF8W4u+IWM7DfW0Yll8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473705; c=relaxed/simple;
	bh=Ca2lZPuAHG4MpPuPun79C5Wm2p4s6cE6NqQw49toIaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nDqFGANtUJOXGF34aw9zH9rHNKfFIUY7lxh+3P/7NU7jyrTnG4e3/9Ylu9n67Gjf/W0h8mZaiKSAKyVGbQhhfwdTphA0E3hMCnLnv8+767IpITR3TFUDQ2XtpbNftKX5gy3habko43ViOnEwsmaQyblqiVww75P1rFMZeXjcJqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ae4qa0CC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZyfgDpue; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ae4qa0CC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZyfgDpue"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BwS2001784;
	Tue, 25 Feb 2025 08:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=D5ei5biUG7KPPOdwMQ
	imc7rlbdG7qEVKwKcR351eWKg=; b=Ae4qa0CCkUaAgMzxUQuclkp+H4IXJlf6lD
	Z8D1+j3zQYybh+PGPY5pCNWVRkSz0/fItttR4RDPBS7GCWvmZLitDP3TOUZ5XpTJ
	DVE4EFN+sov22a9XJI60wUnspPumjoJeN72kzMp95+Kw2CtQyaQK9OVmpeWObOGO
	s3z84BAhyGUfGkPskBUfBFncYpCNfdPOCxE1a8Mp65HZ5JrSuRpkSJjV5oVpvQdk
	ARZL9vEGWE32fBoF4u1oQpwva0Nu4osIlApPD1+Ct+yN+QQY2m54M6frhbR9nlOM
	557oAn6xgMBEKzSFmdDLEhjLELRTMMGYIr7gm8H3dwYcswpEZeQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604hw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:54:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8QDiW002704;
	Tue, 25 Feb 2025 08:54:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5193qc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 08:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT0g19Lb1HuI7gV86PYgCnDgAv6woNCLXga0DOVPRh9yJK9TA9xkdsDnukkci5TDIaJng/OdoAZS2cjl53qG66geA3Rwk9b0AcioeMD+UP9yoljdp3gTFTNgrimaM8RkKBFf2nyKEFTWPqO0E40SBdqJJPqgB5l+aXpf9A6zWQeT3eNqAOyTmjcq65PNK91uGgu/R9muLCZwopqyILlKuyWcL2jFbKYH83rsY/I8nL3Zh78thGSmw88sZ41PDniNq3DUW6D4G7SbYarwjJS4oUUzCXbUSIkklgJ4TXNXUEGcRUX4P9w8hYR1qMiADuU47/Tn/FQ6Cc80PKjKXVSZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5ei5biUG7KPPOdwMQimc7rlbdG7qEVKwKcR351eWKg=;
 b=ArikhkUQq7qwdwD3nkHz/DYEnJDiW9JNvOgg8rWIAUVUyqdQASpBQOUcFAA8Q6bqWZO7FxPdxre13X/653Gq648NqOLxwC0cm6afhOXk60T0ilP65l26ao6T6Kz0EAImGBVNAOiYEiyVPL9Rl838qFi6gSc42GNZUqV9sl46O8E5OrgBH+lXmJQPnKdeuuX+W9e4n9KjchT/ilfbP+Df4ckERF45EG2ShY2NeZUrPex8nxUcFkMrvLD+kHUCkAF7Zlr2N24UUgss/JlufvqdnO8e5A3CYdtthAEsbpCIWl77MzlKS5SchLg/ddjxAILDzm5GT5WWIA8AF05bU7OfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5ei5biUG7KPPOdwMQimc7rlbdG7qEVKwKcR351eWKg=;
 b=ZyfgDpuedNTCxZvFNukdo96k7XNeYqfRmqosXdgF8h4kL2n2NA93sG4w1oGCHUga3UQ0K6JNmil50lB8PenoI+Pu0LAGGg/0puuS7bVpGJ+UuntYesch34t2zuxjEnXujCAt8rD5R+bL5JVdLTXwsSTpWfRRmxGKxS+qrwO9lug=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4184.namprd10.prod.outlook.com (2603:10b6:610:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 08:54:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 08:54:36 +0000
Date: Tue, 25 Feb 2025 17:54:22 +0900
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
Subject: Re: [PATCH RFC v2 07/10] slab: determine barn status racily outside
 of lock
Message-ID: <Z72FPj_FzhCZpRsk@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
X-ClientProxiedBy: SL2P216CA0190.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cc9444-8f7a-46b0-a6fb-08dd557a07b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkOZMPredakFcVZy1qy5SfBiSQy8moAkCGLFbgsFAX3+NeZqph/fz0ySEPOy?=
 =?us-ascii?Q?do5bFWsLX9HemL4zBn4px+RB7MPojeYXVgsdrYrYzvWtfV/Fd+U+Nfz763Zf?=
 =?us-ascii?Q?xtQ3q7sdX/c1YfEaP+rEwcJxNQFPo0pr4visAWSootlwRC6mB8opgxPTOeWa?=
 =?us-ascii?Q?oyFOHIF1p41Q8Jsi9iLK1S2kgK26ofzd/MKR4L7Q5RmYwAcXb2kCI063/Jmw?=
 =?us-ascii?Q?1ptUf7TxG1CUiE98uLRY6nvT/fTB4wdb8xer1Z6u0Le1gVhKxLZbc4jspiUw?=
 =?us-ascii?Q?awVFlFczJrq3IspBa+06HJt7aPmOSoPwim114ZXvjnBZ0gcUrz/B8Xa93Exg?=
 =?us-ascii?Q?NQscnonZTW3m4CDrhZjEJ03fVlYrPoAHpM8/7uj0tYP66sikaPH2+Ov8lc0S?=
 =?us-ascii?Q?epmcsyHx6DJcRV/tj0pV+uz5G7/wuKL0kaLtPahYF3P4qMyRDaG2xasM5cMI?=
 =?us-ascii?Q?9SVHpbPUfAWnYQ8VY/oCltM3+vZz11eKv2oWFwOO2Qs42kUsuaYFy3GaZiBg?=
 =?us-ascii?Q?QabvARMvvB9VZofXgJJUKOLGLAedXZgUQosG84vUtr3IVIXMAp97qAOxj3Fg?=
 =?us-ascii?Q?Gr82/qYOf+22YIa7Mz+VqmVCKYEP4l2asSdy3AD22DiAaSMZxngLzNjoFPLp?=
 =?us-ascii?Q?TEx5UFXh8rEQTRMA9QW6YC3Giz0jC3MZPv0HIjwhAgdzLvx3lhIxk84OKsMP?=
 =?us-ascii?Q?QBqeXGky9t8vHT7b3G8Rin/6CkWcHVMWy9FjMJQPNn1mX51w3Pqfgv3T36aq?=
 =?us-ascii?Q?rNjpFHZXCylqUlGouokCJY2qv89DcdOd+Ih1BzWCU9m/Trf6WfFgBTdlA2m0?=
 =?us-ascii?Q?2qoIusG2t193KChkzfgzjte9fIBhiN17cJlYtm7HkxKHP2//1WpFb/89LmfQ?=
 =?us-ascii?Q?qiUuqrfrQ61PqMIeVtMw/Q4C+QD6qlr00+Vm0MoPPXjG16jUqMV9jcR2ChmT?=
 =?us-ascii?Q?/Mn5pvIoD9OYjvog2QL8OGTcpEs9yKJzsUtFjw7Bemc7vHlC7Oitpg/dNrm+?=
 =?us-ascii?Q?YCCIS2hl6cigFhdXyKU8XHKCJNSu7Mh4vf3ws+yjZCSS3eycz0Cka4vAPQIR?=
 =?us-ascii?Q?kZdCPOf/KZF1RahuQHzMHFHw7W63anBJDwty/pY7UaN/iR1f3SLnn9F8wMTc?=
 =?us-ascii?Q?wyqO5SHh8QOZ2lqRXFJRyDrnWvmlzSgpqYEEbxMb8ithYSx+BNcSZ8B8U+Sn?=
 =?us-ascii?Q?ShKSY5mMYGnLlHrgZAe5ZSsw/t5xY4MrmEb/exfPudEx9DSFJdGuBJhW/YBZ?=
 =?us-ascii?Q?Fs2mmGoUzRsqfXlkyWiyrOG+/atO7BkCWj57kneCNZTgVnT9qocfrfnGHCnQ?=
 =?us-ascii?Q?cHHq4RWjxfDEZXbgilwgEJhswlic8i+K1bIIqAN6JfKBcqeGt6+8G31ispLt?=
 =?us-ascii?Q?T4pTSnbKiamk8Rv3R/qXkuRIgpZR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OjLrQbGne2KlNhpkp0mhY7pDhh3T+pzC1JeT/pz1Tw6euyrIvJt2KzegGLGG?=
 =?us-ascii?Q?uINiMfxiZAlE+2GYKxaL9aZFZhyfDe9hlZI+dtTXK7uFSf9FX01Om/dbq/MR?=
 =?us-ascii?Q?78WwhR6bR3dFIrq+c+ntG68FBNE36DcarEX+Ubz3pO+6ohimclv+MK22jvC0?=
 =?us-ascii?Q?U3BjdnYEC7E1ClrbujV7XTieTwMGQneLjHDA4jS7iid2aKp1d+m4G2dN4313?=
 =?us-ascii?Q?nLx9VpHdsY7JjCR6ntTWznYZoGyOCAhkM3Xuzp5b1F3QHEPXLaM97Z6QRW8r?=
 =?us-ascii?Q?kfDcaNrkcUo8xO/lWR8kZb5GdcTyveuh/YJ0vS5rUCoISYiOSajCxcHThB3s?=
 =?us-ascii?Q?hZfCcTqJysi2F5r3N7fzld0e9pAESj6peKjbbPK1HsmBWBGiXp15eTmxprL0?=
 =?us-ascii?Q?SY+QKs0cPW2wJT1LYgYhNj1r21aSxFWKnw4m1PP+d5k7eND6mxbRX1+KUTjr?=
 =?us-ascii?Q?4/WCNyiNYFo9RZJshzvCCYMDCZzvYLZwCNFFY1U/ckwbTQFZHQ7KAfUSDqd7?=
 =?us-ascii?Q?WOPVioD2gyLgXvgxb4gzJA6C2jWSOSMXbxviuwRy+/l2OA8i+GM7tmPjW9mA?=
 =?us-ascii?Q?5Ulwzyht4ULU5nc2EWWwERWy1fS7zQIfWDiD5OT9Z5xbEVIFDY4Edxkl9yCB?=
 =?us-ascii?Q?Asu5yul4hqZIoWpwYIOkIwPMiofqIY8inzBF0VeaxNX14VRwIOw/EmhWW2mP?=
 =?us-ascii?Q?Y/WJLh6e4GWDOBQtiexppZaqAGnGwYdjs4qv7QlTdSo0m5bYknHAe0BHP3tw?=
 =?us-ascii?Q?hunOpwpS2lqJa84XXH2HjBmhSeszRzlG6FMpN2HKJW+Pp3abdWOyZ10SIhQO?=
 =?us-ascii?Q?6yhCUmx/gGITivNcwXfoEt5xz1G+PwcWKcz5HS4c7xHDHIXMqpWOZTJcSlDf?=
 =?us-ascii?Q?rQt1xF5vQIiY1gw4Tm0Wpa4H8J58pK4gcIEZa8I1ygORRlgttG+38xe0T5ox?=
 =?us-ascii?Q?rVpPBsRFWbxbjM+Zth1/v0MVJznUk+kqCEWXyv4zchYgEQImy/2iDhsXEYIW?=
 =?us-ascii?Q?XI9tE264hfhuAGhlhZK4VAYdM257/uPVHwz12yCQDpz2Jaca1pW9Dv+HJmVZ?=
 =?us-ascii?Q?oSHJX21PLYBOVhSCUl75SlZoIFUZi1mGuq8tszbF4dlgumgiSfrxi+3gFUVo?=
 =?us-ascii?Q?S3hzJ3ogWU/UZRt30nf0NpXnZcz81eUfD19W5+2ri7pfvYkFRIo6P1uEGPxp?=
 =?us-ascii?Q?51KGkz+Kn938qG6loSdRgHnD0kTOSlkMha4QTAT9pU0XeNjS54U6F7sAezEL?=
 =?us-ascii?Q?BQu8Zbo1hKnLgeWzf05r5sqqqx7rKEj94ozhyc5RO03vX+8y/qMPlz3bcoEb?=
 =?us-ascii?Q?xtdt79hAmZKJvpYignW3juxrpEcofhmqwbNFIzR2fZCbpjEkOHjuPm0sgxBR?=
 =?us-ascii?Q?bxqNgWjvAYo3P2ZwiEU4+90hWU7cruhjmTY8qg0U3ERU2eULapHjQ6EloLH0?=
 =?us-ascii?Q?Ov5ucEcj6tgw2ayd9+M8WaiO6Oh4juSTf44g/RLIIVCxzz5HccgAuGKrUZGb?=
 =?us-ascii?Q?6N91PhVrGuzQQQHqJtysrFIjj2bsCxOjjh+bHuKKtakVQvfI9QMlOetCQ0GX?=
 =?us-ascii?Q?Q9o5dEy8ww6ssLDHazTlyJ7mx4UqJ5KzrFfaVK6M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	znI2wGh/gC0tAPRm559ceFMRo4jq1H9pGFQSmzpKol3jT3hU383z/GITuDyI0lpSz58X+aX0SBxtbr+fkjJMOX3J09ZaNAL3rINaMfQ8XxnGvlAGyaBf/9/+CZJFv4UP7ToaGGhu8T6zNpDxm2t+n53U2TXBupi09NwRT1bVB05fTVhmpwFandF4t+lLO5f4COh2AqspQ9CA6OJXGuh45h26mxZ/AZpjRx6K4SXHywB5mFfslDG5tl860fEFUywr3v0/E45wPLfA+w83h7WLS192dsc46xrki+o4Hwzp7PptTbX0p50OL01k7vd16W9RSPK6N1TUqILaFDBu1W113k1Vi3EsxyrHEFqbZb0zgma7epAJWAZbLgUrQzIcg4/T+a9trt6jYtS9aoHGE2CpJsEWDDKDE+iIvC0ZX0BT1NldUSWIFUtppkdPKqxJCcsFaRcZawWGJFeyAGjgfoZfT/yxpa5BixDSd0Ng08WJxDrfJtqCWVKcT0UdokRFe8KwFhJ/Wr6DGi5qMpFk9Edl7nvnlvtAK3FrOLaALT+NWFeurYyy4DBHy0RFRJwvG9L4+JkFcqQ5kpuHGOuMQ1dXjE6/oTl/P7TPo6Ixjl6bS9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cc9444-8f7a-46b0-a6fb-08dd557a07b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:54:36.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgBtnklNZ7s4bKAFitl3JliLVuADdnb6+WGxfYvsb85WR/6nVrbh3IhaEO/qqzw+y7LnCiupALvx7Nmk6rTn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250060
X-Proofpoint-GUID: HBvRRtvVchVq2SlcSOIehIA5m0NSicuZ
X-Proofpoint-ORIG-GUID: HBvRRtvVchVq2SlcSOIehIA5m0NSicuZ

On Fri, Feb 14, 2025 at 05:27:43PM +0100, Vlastimil Babka wrote:
> The possibility of many barn operations is determined by the current
> number of full or empty sheaves. Taking the barn->lock just to find out
> that e.g. there are no empty sheaves results in unnecessary overhead and
> lock contention. Thus perform these checks outside of the lock with a
> data_race() annotated variable read and fail quickly without taking the
> lock.
> 
> Checks for sheaf availability that racily succeed have to be obviously
> repeated under the lock for correctness, but we can skip repeating
> checks if there are too many sheaves on the given list as the limits
> don't need to be strict.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

in kmem_cache_return_sheaf:
> if (!pcs->spare) {                                                      
> 	pcs->spare = sheaf;                                             
>	sheaf = NULL;                                                   
> } else if (pcs->barn->nr_full >= MAX_FULL_SHEAVES) {                    
>	/* racy check */                                                
>	barn = pcs->barn;                                               
>	keep = true;                                                    
> }  

By the way this code also needs data_race()?

-- 
Cheers,
Harry

> ---
>  mm/slub.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c1df7cf22267f28f743404531bef921e25fac086..72e6437f1d74bfacbb1cd7642af42929c48cc66a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2685,9 +2685,12 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
>  	struct slab_sheaf *empty = NULL;
>  	unsigned long flags;
>  
> +	if (!data_race(barn->nr_empty))
> +		return NULL;
> +
>  	spin_lock_irqsave(&barn->lock, flags);
>  
> -	if (barn->nr_empty) {
> +	if (likely(barn->nr_empty)) {
>  		empty = list_first_entry(&barn->sheaves_empty,
>  					 struct slab_sheaf, barn_list);
>  		list_del(&empty->barn_list);
> @@ -2703,38 +2706,36 @@ static int barn_put_empty_sheaf(struct node_barn *barn,
>  				struct slab_sheaf *sheaf, bool ignore_limit)
>  {
>  	unsigned long flags;
> -	int ret = 0;
> +
> +	/* we don't repeat the check under barn->lock as it's not critical */
> +	if (!ignore_limit && data_race(barn->nr_empty) >= MAX_EMPTY_SHEAVES)
> +		return -E2BIG;
>  
>  	spin_lock_irqsave(&barn->lock, flags);
>  
> -	if (!ignore_limit && barn->nr_empty >= MAX_EMPTY_SHEAVES) {
> -		ret = -E2BIG;
> -	} else {
> -		list_add(&sheaf->barn_list, &barn->sheaves_empty);
> -		barn->nr_empty++;
> -	}
> +	list_add(&sheaf->barn_list, &barn->sheaves_empty);
> +	barn->nr_empty++;
>  
>  	spin_unlock_irqrestore(&barn->lock, flags);
> -	return ret;
> +	return 0;
>  }
>  
>  static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
>  			       bool ignore_limit)
>  {
>  	unsigned long flags;
> -	int ret = 0;
> +
> +	/* we don't repeat the check under barn->lock as it's not critical */
> +	if (!ignore_limit && data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
> +		return -E2BIG;
>  
>  	spin_lock_irqsave(&barn->lock, flags);
>  
> -	if (!ignore_limit && barn->nr_full >= MAX_FULL_SHEAVES) {
> -		ret = -E2BIG;
> -	} else {
> -		list_add(&sheaf->barn_list, &barn->sheaves_full);
> -		barn->nr_full++;
> -	}
> +	list_add(&sheaf->barn_list, &barn->sheaves_full);
> +	barn->nr_full++;
>  
>  	spin_unlock_irqrestore(&barn->lock, flags);
> -	return ret;
> +	return 0;
>  }
>  
>  static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
> @@ -2742,6 +2743,9 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
>  	struct slab_sheaf *sheaf = NULL;
>  	unsigned long flags;
>  
> +	if (!data_race(barn->nr_full) && !data_race(barn->nr_empty))
> +		return NULL;
> +
>  	spin_lock_irqsave(&barn->lock, flags);
>  
>  	if (barn->nr_full) {
> @@ -2772,9 +2776,12 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>  	struct slab_sheaf *full = NULL;
>  	unsigned long flags;
>  
> +	if (!data_race(barn->nr_full))
> +		return NULL;
> +
>  	spin_lock_irqsave(&barn->lock, flags);
>  
> -	if (barn->nr_full) {
> +	if (likely(barn->nr_full)) {
>  		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
>  					barn_list);
>  		list_del(&full->barn_list);
> @@ -2797,19 +2804,23 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
>  	struct slab_sheaf *empty;
>  	unsigned long flags;
>  
> +	/* we don't repeat this check under barn->lock as it's not critical */
> +	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
> +		return ERR_PTR(-E2BIG);
> +	if (!data_race(barn->nr_empty))
> +		return ERR_PTR(-ENOMEM);
> +
>  	spin_lock_irqsave(&barn->lock, flags);
>  
> -	if (barn->nr_full >= MAX_FULL_SHEAVES) {
> -		empty = ERR_PTR(-E2BIG);
> -	} else if (!barn->nr_empty) {
> -		empty = ERR_PTR(-ENOMEM);
> -	} else {
> +	if (likely(barn->nr_empty)) {
>  		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
>  					 barn_list);
>  		list_del(&empty->barn_list);
>  		list_add(&full->barn_list, &barn->sheaves_full);
>  		barn->nr_empty--;
>  		barn->nr_full++;
> +	} else {
> +		empty = ERR_PTR(-ENOMEM);
>  	}
>  
>  	spin_unlock_irqrestore(&barn->lock, flags);
> 
> -- 
> 2.48.1
> 
