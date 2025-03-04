Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AE20468F;
	Tue,  4 Mar 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115364; cv=fail; b=CM0AbQ3edUY3RitgozPWyHJXyMo2Y/9RzfMDJG0gSU8AH2YhFFABmwQioBejvSlIyg5q4SZmvOSknuTsBi+OHWy0Z/bzYHEXmb7xDP5dvaijseu79sBhIVzsbwRGHBlS/WjqQJttX58EOytO/Le3DgPBD4uP1EaUF7I/HpPOTEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115364; c=relaxed/simple;
	bh=R1wELsT9xR2fXjebiA3nvbV9xTCTI9gvA5IXrAtBHkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UyzPHQQimODTL1xpMlvL277fEkK9n5f9A6g1v4gseoQ4UlBfnPbAuaqKaiEEkE1/L5GgSiaLQLSP1tyFkREg1ouryj+woFIwDkztcQHvr4BAx8fI9m9fb6uNlycfy9ESWHAXEpCJMkkfCewNKJ++MG+jmMxXQoIc2rkHt8xuYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tv5Cpl6C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dqhdWKd0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tv5Cpl6C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dqhdWKd0"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HMhAX013766;
	Tue, 4 Mar 2025 19:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ViYbWRgG53b7rEVvSsc6BiN2q8jSdqneOS+AE8d2f/w=; b=
	Tv5Cpl6ChsD48SY++fL0fndM8q2u7lpBhn9YItPNdIWO11BcGb0/LW1HJIz0mFGk
	U9Yn929KgpZTwUVtFtJ4HMYowBgdSEPj51T43imUAuMB8qd02Fgnm4ChtxBUO5WX
	WzYIs6aGXmTXW6aBmnzd+VvKDEELpGOVMmkEDfAFO+8Ow5jk268VUdnfsiWyJJHI
	k/CTAIeyVpsEvK/M3HkPiQiX9tqm4v7W3Wq5F0Ue3C8R72mniVU3ixVhhjpzSDuG
	CR1+kjLLTYQi6Cu0XGVlf6nNj8lQJrkCYXFFaQc625U1/RZ5sX57FMbniNDipBwd
	hkQyPR51LMjozT27kxoVNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qdysd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 19:08:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524J4P6x021934;
	Tue, 4 Mar 2025 19:08:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwvb2k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 19:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbs4ftjw+W8X8KPmGGTjcd4FNlB1U91wgLouN2GNJOqUq5NNBhsopzzM6OOgwt4ePVNOxBaWJw5DA0FhF319sOjmoEQ/6DZ8RGZ8OvLSIFowgjk+AFLyz7xZqkT3cdX6n6CpuslIuOo5igcUDqKcwvd02nDNVwYVS5oN4i2O/uz+LTY+XesAnUWa0VzNeBYSB8edfypv5klZwmiulPTMeGFEn4hXIY7NbFPMg1rGEhaXXsa2jZVCu5uuvCWEJeY8j6Je2/BP4xJCCkzUxSN9E56NoiY15B0zFuUjmMe6cswJdkf1tR6yu3iF6y/zARJUAirvezanlXpOSLDHJdzvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViYbWRgG53b7rEVvSsc6BiN2q8jSdqneOS+AE8d2f/w=;
 b=mpSZFisTvHgzpYciYeRw6ovDrOI8KjP5YaRakuSqd4JxlV/TIbdQjJNnpXx5h44HnP8Kf+mw1B6VQwqpadKieeQRHqlIag2EBwfqBBd+GwxIWXC6mGgOpKTC26ZxdD5eMQ7KDKJuqBBK4D7cZQaOzkjzzh6sp8Y0KaGAUM9EmnE9/g1ufACYJ44doSjU+kHSSrfffBa694CXpbDaW4WQiUDGtlpcZ9YCHyjM+Ek7G7FZuYxMzhWljWOf9zq0LEqTpeJN4HdmYXWpAq9NsWgtbTeC2y5hx4qxlpX3iaLY8UJX76fusj2n4NuL1yJC8pOMNYUM6+6SDudY+ql8ydYlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViYbWRgG53b7rEVvSsc6BiN2q8jSdqneOS+AE8d2f/w=;
 b=dqhdWKd0lzo6iOI1F5wp69n98F8UVYlj+qi5mEYNKZerfgQ9rSdDLgmtcI55PAoLDNqqvrkzWEqD47hU7+dbbreqGs3dJbraAMktMh7VH4q/khnylXWwwfVJIg6dEzDbH7APy5s4ftnBhXA9DmemmmICg+KLXF0DtSq1eMeszeI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 19:08:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 19:08:41 +0000
Date: Tue, 4 Mar 2025 14:08:38 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
Message-ID: <ape445nrqgod4ivtzcwacmfdshi3fgcqmmu54iascbjsk3sluo@w4jjihiz5jzr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
 <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
 <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0070.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 962619db-898a-4246-c175-08dd5b4ffa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1J1clRSelJLUmw1VzJXUFo1MXdJdzRBdFV2MzNOdmViN1BqTFdKNHdleE0v?=
 =?utf-8?B?eXJ3a25NVUxSdkJuSjQ5dERRbGdpNkxlcVZxMG9sZzc1cHB6VGJmcFErWUlM?=
 =?utf-8?B?TWo4Q0xBTXFDQXdaamFHYkZSaFNrNys4WFI3WExGeXIvVUNUR3NZTGNoejRO?=
 =?utf-8?B?R25NQVlVWTlmb2VLUEdCUFhuSENvMU5ZVVNpeEY1cm0zQUVLbFdiZ1pnNmhH?=
 =?utf-8?B?R0Yxd2hZNW12ZTR4dURoNEVMOCtvaVZPTHoxTFVKWWs0TGpSN3hnTjhHQnk5?=
 =?utf-8?B?MkRtdERyNm1KN3hDaGdVY2V6Znl6NTVacWtWNGxzWVhTTHBrY2k1VUg0c3dj?=
 =?utf-8?B?RnBqSm1CcW1weVBOVmNEU3hiR2FRR0p6N3k3TElDUDZIWFpZRGFFWUJuWHhp?=
 =?utf-8?B?dmNuOWJ0czFqcHUvcnhGNWxwOXYxV3hZdFNWMWlpaGpERVlqVEpIdnh6aVZY?=
 =?utf-8?B?QmwyOThEMjZhMXc1UEkvbEswUEFudVlXUEk1b1lYWE5xSmU0UTJrMkRqai9L?=
 =?utf-8?B?cUEyUnp5VGNYQzMwdTZYS1hTUDdESnk0dm1uSUtHQTRueXk5WEExSHR4blpF?=
 =?utf-8?B?U0w3Z2d6MkFOYU90RE9Ydjk4bUpVbU5COXJRSU1kQXdEbWRoM1NTODc2RzVh?=
 =?utf-8?B?SytZc0cvRjg5UGlsaU5kOWJ2dWFLZkI5Y2JUSC8wdURFajVHdmdEeVE4Vjll?=
 =?utf-8?B?OWVDZkNNeGswNTcvb2h1K2NuL1h2WGxaQUhJaWgycWxoa2xlMk80bTFYK2ps?=
 =?utf-8?B?WUFMODBFOUY2dHVsYmJqN1dpMlVrNkJBNXhpMXBwR3VJOHRFT01sa2dIODFU?=
 =?utf-8?B?MWVLZ01ZcE15WHJ1Yld4RUkvR3pvU2ZiKzRNd051ZEdpd0svSzJrK2NHdUFM?=
 =?utf-8?B?OVNTdE1VaFpybEo4UkhGT3kzZU5RbUR3Qjcxb3llM0dONzVCWEVON3pZbGx5?=
 =?utf-8?B?ZGptTnA1V0swQmhTRTNGRWtxd0xCTnlSMFl3b3djeXZNeWd0aW1XUWppc3Yv?=
 =?utf-8?B?UTVjVlVQVTh2SGNMSHdyclBNV2ZJcm1lUG0yOGtKVGs1SDhOdGdYNHFEWGtU?=
 =?utf-8?B?V1VuQUVyVStHRlFvUlBLbTZCZHVCcnlLd055V1RuMEw5SFkrTWkvMERPWHly?=
 =?utf-8?B?V1dTbWF4NHFldDhJWVhxRys5aGMzdWljTGwzdHRnRENkalV6ZWxsM1ZBanhL?=
 =?utf-8?B?QTFjME5mM0RKeHVzc0htaFFqNTdMWTREVG9pUnhnNDJFUm1uZkNneFEzVWk2?=
 =?utf-8?B?QWJvczNaZFRDdG1PSmQ4dDRzNU5hbkw4K0tvanVDcmUyNjl2MDdZVkNpWThq?=
 =?utf-8?B?RXRLSFA5dVUzRWVyNng1dm5VVUtDcnhkVnE0cWFrZ2tsVTAwL0V3Wm1Ia2tH?=
 =?utf-8?B?aVd4UDRBbFc4T29JTm1pUGVGUjJ3WHE3MzFsNFlNb1FGS2ZsRnk3ZXdNZFpP?=
 =?utf-8?B?SGhCSFRhWDNGbmdPMzV6RVdVMEVUc3RhUE11SmpLZHB6SDNUQUNZUjJEUXFM?=
 =?utf-8?B?OVJ0eWw5bUZ5eGNHZU5mbFZQUGpOeW9ya0xPUzBqdTNnQ3ErUDhlT0w5cEU5?=
 =?utf-8?B?RG9wUWVHV1ZnMkhtQ2crZGtPdmtTZTJ0L2VEZzZqZlpTNUI4alEwYTc5S1pi?=
 =?utf-8?B?R21HSzZKQmR4VXZicS9BUkJ2emE1eVhxOTU3VmtCVXVJVTE5S08wT2xqTTNL?=
 =?utf-8?B?M1VsK3FIczNSUkw2aW1CTWtVU1kzdWlVS1ZDYUNobTY3S1A5eUE4MzdoVm5O?=
 =?utf-8?B?QlhkMU5Iemk2TUxXSVNhOFBuOWZUdmlyTlQ3aTdSQWNtR3hEOUJkOUd6VXFs?=
 =?utf-8?B?SW9TclhlMTY5WURVbC9iUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5FRUM1a0NMaW50ZmZTVVBmU1pXNzFIcmp1Mi9uUnpRVXMzbUNmWUxjSFBM?=
 =?utf-8?B?LzQxa2lxK3h6WjVZT2tDS1RtV2x2N0xvTG1xTXU1ZjEzUUNuRHpMNGNHWFJx?=
 =?utf-8?B?Zk9ENFdCSFgwNDd6NTJhTStQbVJORThrZFF0akNiaVhPRGNpQzNKcUE1TW5m?=
 =?utf-8?B?S1FoZGE2V29WSHYyQlhtWFpUcTAxZ0FkOGVEUnNqM1VKS0t0YTFkSFpDUmhJ?=
 =?utf-8?B?YWQ1YXBtV3JpRkJpVE9OL2pwNkNlV0lzY3FUMWkxdU5kWlBDTzNIR1J2UkdP?=
 =?utf-8?B?Rm5GVVYxRjhLY25VaEpoNC91ZXZKeDM0RzN2LzdPZ0Z6N0FFNWo3cVNTSXd2?=
 =?utf-8?B?M1ZDdnJwL05CakN4UVU0all1eWR3Zk1XbUZ1WlZHMW5NY3hQSGVXYUQ4anlU?=
 =?utf-8?B?amFQcloxQ2oxUExlN0d0UHgrNmlXSEtFY2ZpMUN5MGMrTkphMUh4TjZ1UzhM?=
 =?utf-8?B?QWdOa1pQaVJyZUpCbmtJSmR6VnhvZ0d6Ukh2WjVISXNmcGVyaVVpVzNYZUx4?=
 =?utf-8?B?N3VLUXlXZEFyNjhRN29hVEFycFlCaGptcEdsUEdwMGZnZ1dwa0VVbThpTHVp?=
 =?utf-8?B?eWgzR3dTcjlXUWRhVXptWnE4TTVadjBMOUI3M2hUc0NhNFliaU43QVk4UUVz?=
 =?utf-8?B?ZkZramNxbjE4a21FeU9JYm5QVFhQWkE5dU1DN05HN3RqUkIvNDBMNjJSazVL?=
 =?utf-8?B?Z1laNGJTRmZnZXZmcDE1TWFBaUhNdGw0c1pNZEdrUjBRcGozRU9neVJhek02?=
 =?utf-8?B?VnUwcUdmM0h5elM2bFhNWEVDbVVQT0tQVFMyTjNNQkdXczBtRjJlRGJ4eHU5?=
 =?utf-8?B?ZW43a2hUdGVDUVdnOXpnUVBFc1k2MlZMMXlHa3NMNzdONDBNV1FkaXErZFRh?=
 =?utf-8?B?MGNrWG5rSllwZVFWY0dHT09mYmF0VzhXVGR3ZFhDdzhiYklXTzhlRkI5YzQw?=
 =?utf-8?B?ZG5WS1NZNkhPNHlsTWJoR0o2M3lZZUFYa0NSK3c2SlhQaS90WDFEMmZWSC92?=
 =?utf-8?B?WGtzYXkwZTFvaVlCa0M0MWF1UENLRVRKUHVkT3BaWHVSd2FvRFU3OGR2OVFh?=
 =?utf-8?B?eW55a043RTZEZ3czWjYrUVVXNmNxR05Ra0VHTWZic3dTeE1RYXlzUnlYOUVm?=
 =?utf-8?B?MndjbjdPY1FCUTFnR054WXo2WFBqY2IxWFBjdWpCR29uenlBbE0zQ3crUjQ4?=
 =?utf-8?B?V2xNM1c1U0hpQ1J0VHA4YzUyR0JMN2JjbW9TUnlpQ2hNTmpGZkZEYW9FdVdP?=
 =?utf-8?B?ZEpHTDFoeldLd1ZKTDhwdjRFVGlaRTVva2l1d0JGOUdmdVBHOWtYVDNxK2tq?=
 =?utf-8?B?ZzhNQUhONFhsQXVJTlBrNWZJOVVvL2VlMENVOGF1WG4yZE1NZitLbDlBV0xG?=
 =?utf-8?B?dlpqa1l6N09VY3R6cnN3UHcwZXo2VmtTaDREZGZCTGxvSXRIY3UybXZLMmRt?=
 =?utf-8?B?WlhOOUpiYzFiSytGb25uZDdpVkU1NURxcUthMnM5K21hV2dEZTczeXFmL1Va?=
 =?utf-8?B?MkdKSHRmV2tjd2crM3BMSGlYRktud3lnQXVpQld6UGV4VUd2VkhUbkQ1M2Jw?=
 =?utf-8?B?Z1FPQ1NNaEdoclVVZWtCMEpZN2Zzc1NrcXp5dTJ1WmdSNFhkKy9mK0JOVVZG?=
 =?utf-8?B?NDh4SThBcVhUTUllcVJ4eHNjTVd6NWx5dzQ4NzZRaWo1SmhUbW1tdXAyZmVv?=
 =?utf-8?B?M1lIWHFvMm40ZjVxc09pR0lCWWRXQ2lzalJOMmpScStuNEZ3Y3BMU1cvWXpj?=
 =?utf-8?B?SC9ZQSt0Zk5HOCtpR2dYSGg4c0R1MWp5a1dqcFJWZExIbVo3cnBqd0NJQmRH?=
 =?utf-8?B?RTVSSVlPeHU4dFQ0SERocndkVzc4MW5VMG1lWGNvdkdpVU5xWmI4VnpqUUk3?=
 =?utf-8?B?bmtzMnlURS9ONG5GaVlmRmhDOTc0bmFTUitxRHZ4SnNHNlo1SjZLS2ZaZ05m?=
 =?utf-8?B?M1pGcncwcHoxY1FaN1ZzbzFxQjB4akViTTZSd0tDQzVkZ0RxUk9Ec1llcTVR?=
 =?utf-8?B?bUFaT3FqbmxlMDBmZEE1SlFmT0lUYXNlZktKMWRYZUQ5MjdHK3ZmQWF0UW4r?=
 =?utf-8?B?azBuejVNLzFDeHhKMVE5OWRMQTVnZDBIVEx0aUQwUkU4RGsva1kzaEN5c3Z2?=
 =?utf-8?Q?zGWKJNRupc88yCzw83N8YSrXJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HMA3DXn9RqMeCD2XUUqy4uLcKP0WnhYQWGhyxlBjjMHK4fwT3Vi0yHb5zLRGP76WXkqcYjtI492dbcD+5LSRXeutHzEnD+5yMR6prTs4UTRbP5ynQ3bd0hKjcYKasFGNggF6888h8+eg3UZPAP/Y5BJaq4+zkEpxe6qf0WEqLUlic11T1gk/bsQhYaF2vAnIRkStfIe4Q3pvtgaITjO7HCr2JPwSnYBbMlqTgOt+xipqMVIL2f4EfezC0XtKXWHTiGkgPWyLUuQ7gRGVJGOvV6mApRPhlsiGZIkTsK9dKyFhx2O3FiZWuFAP1lUbHtw1GiqjGT6MSfJZJcrq+4xEnr2GSRXFRcMsafzZOKP7V/7J5Yhu0mUv4Svr5LW52LACwCYvonAfceaa+hNeaZE+zGiKdg1eqs9HrjWLMXREpxXIufFf0+cARjnx4WMCn3nrtERw1zyKOaoxnIMIbN1wzFhfY0UoiBcJUwHzqCQEF5RA+uXQQueuLJiFlbrbc7+B6UA18xVbnAqmDxlH3rmFqvjxInoX0XfewQTeKdMRVYRoDH9Z4kbaYVrVNamT08fv4UsNsSgSzKlCmKKB01u1DnEghCxAqYoN4kWCoaRLB0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962619db-898a-4246-c175-08dd5b4ffa02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:08:41.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+ssNaaR8nMRQT50DXjmLvi93wrcetzyoEI3sN+W4+CR5JG+fjo3e3GZFmudx5D0/7+yVyM7pLazP4SwowUfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040153
X-Proofpoint-ORIG-GUID: RRrnlzCG9vZYKkttHFT3FZ8CmXVANTuP
X-Proofpoint-GUID: RRrnlzCG9vZYKkttHFT3FZ8CmXVANTuP

* Vlastimil Babka <vbabka@suse.cz> [250304 05:55]:
> On 2/25/25 21:26, Suren Baghdasaryan wrote:
> > On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> >
> >> > > The values represent the total time it took to perform mmap syscal=
ls, less is
> >> > > better.
> >> > >
> >> > > (1)                  baseline       control
> >> > > Little core       7.58327       6.614939 (-12.77%)
> >> > > Medium core  2.125315     1.428702 (-32.78%)
> >> > > Big core          0.514673     0.422948 (-17.82%)
> >> > >
> >> > > (2)                  baseline      control
> >> > > Little core       7.58327       5.141478 (-32.20%)
> >> > > Medium core  2.125315     0.427692 (-79.88%)
> >> > > Big core          0.514673    0.046642 (-90.94%)
> >> > >
> >> > > (3)                   baseline      control
> >> > > Little core        7.58327      4.779624 (-36.97%)
> >> > > Medium core   2.125315    0.450368 (-78.81%)
> >> > > Big core           0.514673    0.037776 (-92.66%)
> >=20
> > (4)                   baseline      control
> > Little core        7.58327      4.642977 (-38.77%)
> > Medium core   2.125315    0.373692 (-82.42%)
> > Big core           0.514673    0.043613 (-91.53%)
> >=20
> > I think the difference between (3) and (4) is noise.
> > Thanks,
> > Suren.
>=20
> Hi, as we discussed yesterday, it would be useful to set the baseline to
> include everything before sheaves as that's already on the way to 6.15, s=
o
> we can see more clearly what sheaves do relative to that. So at this poin=
t
> it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undone=
,
> thus like in scenario (4)), and benchmark the following:
>=20
> - baseline - vma locking conversion with TYPESAFE_BY_RCU
> - baseline+maple tree node reduction from mm-unstable (Liam might point o=
ut
> which patches?)

Sid's patches [1] are already in mm-unstable.


> - the above + this series + sheaves enabled for vm_area_struct cache
> - the above + full maple node sheaves conversion [1]
> - the above + the top-most patches from [1] that are optimizations with a
> tradeoff (not clear win-win) so it would be good to know if they are usef=
ul
>=20
> [1] currently the 4 commits here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/=
?h=3Dslub-percpu-sheaves-v2-maple
> from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
> but as Liam noted, they won't cherry pick without conflict once maple tre=
e
> node reduction is backported, but he's working on a rebase

Rebased maple tree sheaves, patches are here [2].

>=20
>=20
...

Thanks,
Liam

[1]. https://lore.kernel.org/linux-mm/20250227204823.758784-1-sidhartha.kum=
ar@oracle.com/
[2]. https://www.infradead.org/git/?p=3Dusers/jedix/linux-maple.git;a=3Dsho=
rtlog;h=3Drefs/heads/sheaves_rebase_20250304
