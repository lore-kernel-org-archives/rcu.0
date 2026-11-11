Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370431;
	b=OiRY5xdDH819aPomTkCbcEohjvfK7NJ5Jh/e5nBl2YMGDrWVWLDbwZnz/UjYvKjQAuPU
	 LkvWqK8CKSrqxi36IlS1kQu8VRql8KRqvZAgnT69oKu4zIrfSwtsgN+zNPNLfOuI5VEq+
	 nqy47SfZs9e8bVohB+PwewLe6qvg58Kxe3hl8B9DF8MhoUWEBw+zBvMYCieg0Asfr7wCt
	 HMCJ5ZljWR5mHB0avFV9SEY5o0+JlO0KYnLildTp6hjvPWICAiHzB/VFV37SF0B6IGSKb
	 R5FkS/sfkDMVU5gcLHogdPB+dwaJgKeXWaAfJAKqCsnuULmlPtwvaMxwnb2vUpAP92Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370431;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fmNXGLeNqbHdDq/bGGQ0S3dc3j0jnSEv6IEABbzFKaY=;
	b=pnk5uJP2IDpJPf8lKVQhCKFIIoXf/g3hzyyHMWy+s4cPj/FTtB2zcLdyPtgyX6H/3Oqb
	 LNbpCv8q4+3ry8NQ3vH4Mo/gKcqAlM2qPNplsaETGsT+B406CL0BEl9cgHujhNICtXY5M
	 tsuukkqelgdPYOj9pSslq5enaGRVom41NAqryUJzXyXujluDv4VtxzhCsCxKAR49Rgktu
	 TYQioEJv4FLfS/Kni83rjccsDUB64sc3jEPdK5ulWZ+SEj/MABsLcwAk4Y/hsqwLrjGi5
	 wmyK1Vr/R0I17ujQPoW/c+G/hvytW0fHnefAoL1Am9zwuniNBbka3tCyY7KU7naVIsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Ey1TjnFJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.77
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021077.outbound.protection.outlook.com [40.107.192.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AC606A324;
	Wed, 11 Nov 2026 04:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C9AC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Ey1TjnFJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC+MGhD1cd2WWts/hbKVs0vyZan68f30VXcm09wiX/MPXw6wdJj6i2bBVDpnGHvIrJxOq/jUz+PGNjnGmK7S3WLeNusXw118ELPR2S33t4uIQ42RrRPMbN+/ilHRomnZiC9nzFB8CsVCA/deCKWB4gM6u5MSLrmCfgHDRtPveQJJRUsms1Gwte/PT/omHbqhtd8q7S8q27h9TbotVa2AbNyYapoBz8ayMz5YVOiTobLhYQuYQ/PdD/rERU8MgsxzyQQhVKwhRdDSNAXcykDwE59scAO3VzDm58uI/gXpCoXIObbqv14NFNk+oowUhJu5LWH0rKk59myMWyqxdaPUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmNXGLeNqbHdDq/bGGQ0S3dc3j0jnSEv6IEABbzFKaY=;
 b=UpgtdBvb0iuYma0HB6B5fIhYXOfYvn+MqgI429GzEh5LvZLKRvIaFPqNmdFoyoNBPsoqsf2/gdRCa5OFM5zWzm5ynLHo/KxIDJKNLkee18Q3SRnKeWKub6B4RdopVHr4Ky0/Kqkl+85Jvvfq64XQy2p95ruOdQnjb+QixQOhnOcvbkA+WBHK76bEivC12OmJxJ02yzsNRbik9ql2RPNaShOkfWSr8I63w6r1puCipia/pzb3EdBg1X3Eo+zUVDt9/rN4yI5qLwXxMeOoE0Zi2aT/NPtoqZOpoB3XgUClIf4JRRdHB43OVpdm3HXFvdC0vELzK5fnOXrWrcqojA9cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmNXGLeNqbHdDq/bGGQ0S3dc3j0jnSEv6IEABbzFKaY=;
 b=Ey1TjnFJjCDol605BoyUklRyLTpx00fdsurbLTb/jCC1NHXTY78pWCBLfLYdUg0a1Lp+ZBICrs0yZnHagJchg7w6T8FdtVa3sYTce7yUnRmq0ZGv9WeiW1LP5o5CdSP3JnShmtJpYSrWiHQPvq9GYT9RmjnggBdtbOU8jj0pT1aqZUTAIDYAMPVQe0YrkOhyLAMN2Yzd25AsHRlY61DTzGyGUUu+jSRAw33+k4GHmyOiQ0F023X944XyRtH6fdp8i9rRBwLu8fao1qrlTMJ5GpOoGi+2SOeR7j1Qf2uPwp+Gh56U0AYvJmM8wohial8mjAa1Vj3r84VjU3a/Chof7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB353182.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 04:13:47 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 04:13:46 +0000
Message-ID: <6ec91a3d-dc7e-46a9-b937-878c8bab3509@efficios.com>
Date: Tue, 10 Nov 2026 23:13:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rcutorture: Test the irqsave forms of atomic SRCU
 readers
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Davidlohr Bueso <dave@stgolabs.net>, Kunwu Chan <kunwu.chan@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
 <20261110192844.44713-5-mathieu.desnoyers@efficios.com>
 <42972bc1-721c-4bdb-8599-10f6f30cd89d@paulmck-laptop>
 <7551edf4-935e-42e1-84e0-290b9af4aaf3@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <7551edf4-935e-42e1-84e0-290b9af4aaf3@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::12) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB353182:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bed28d-ba8c-46f7-e314-08df3faa2e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|4143699003|56012099006|261022105027099003|261026140227099003|10067099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2r87KMLd2oGn6x6lDclNkrQUwCeByFs0YTkj9xUhEqbDzAvjmlAj4Q8x5Jka8xkz3VvCRQ/BL8jXdbYWpYSDi5yzJ/tGADzD8W/l6V2pDGbuAwX9s6cVaXJKOR+2ePcAHZC2axWKJV4Ogx7QL2fHeVbi3Nn/Lj6xK5CTn+15rdd/03aCA0A3WmV97Nys34B5JaT4aDFekzi+9W/N5oCEmqfZpGY4TmmsNwFO8Twh864ufwIviHyKcblzppUPXOMEndMCfKufUy0EySEagft8MLSfxP1DgNXnzH5EOLa+h54S9Kw9U3aAtNb+R+WyNxrTgH+2w5LTRVj1O6VGABOdjPOE4Tv08ECdCOeuFd0cv4htlhY6W/T9wYFUfjzzOZjcq6O7NhLuKccgYJGEKjRSk6zZ/abjjQZnXr/H4gZhkkn8fBBi68nXHUlBsKPNILcsbStgJkoCYFy4NftmIEByFsi5HeAgH6XWHO7qRjBmSWirS3GX411w5noy3BGo2WjKzVn88d+6vYFq5aPF92Ch8A8r8I6CwrdakZG1W+5pBDV50CvqySgGJmPTdm7OswlxVQwWfV2gnIrkTCZl0RknFbGldjsckvcl7q0oAiTb1cQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(10067099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTNFN2dtWjNtaEhwSzBENWpkNHRhOW0veXhyZ25tWlBNTndQbzFZNjI4OGxL?=
 =?utf-8?B?bTlqWmw1NlhXY0x6aVU2UUIxdVUvYWNvM0N0WXNUU09TUVVYdVV4Q05RVjc3?=
 =?utf-8?B?Y1FRWExkTmlrUENiYjE2Mm45VW5UM21VREpxRitoV0ljWnhZOE04THdMQkVi?=
 =?utf-8?B?TElsSHF0UW15VXl6L3IyZmZQSm9FcWhxYUJXOEZPdlN3UUlaTEc3ZG04cFZW?=
 =?utf-8?B?bzZUS1RKU3czck5qcmxLK25McTg5UDlkL2tFR1duMFd4QVRPMmlHZTA5UURO?=
 =?utf-8?B?RzJqbEZNclR0eDNKaldMOW5KbHE1ZEdYb0dwc0I0bk1sTVI0ZGNETkg3dkJv?=
 =?utf-8?B?RzkyTWZCaGtrRWI1ZDZyeVN6V1dndGFBSTJZYzBoV21QWGNNekdDVzJhck0y?=
 =?utf-8?B?SEpxaGhqdjQ5NmEyQWxjVDVXZjdBUkVwb3hhQTl0UTRudlA4czMrc08wVlNa?=
 =?utf-8?B?R21QYk1LeExWZjNvbWsyNHdGb0xLTUNVSTJtbEwzcE5ycHlmcld0c1BLZmN0?=
 =?utf-8?B?UmVtNlNWN081RnZkenRaaERBNUxDUUNjcGdtVUxjblNJNFdEVjA4YSszcEZR?=
 =?utf-8?B?R3MwdVpWMk9aVjFpTEtRbjBRTlRVeG52eTBLbmN4bTZRVUdPTHRXK0Q3UXc5?=
 =?utf-8?B?dVlYRGZwUUc4QStCWDl5bE1oQ0hqb2xwcldwRDllNGtLcDVZUnMzWXhRZDVp?=
 =?utf-8?B?RVNCK1dZWHFNOWhZd2VON3c3Qi9qM3hmRHR4cXpMTCs1TWhwdVNTRytFUXZH?=
 =?utf-8?B?YjllQzdzenVZVlF3UHIyUzVGbllCcDZXR2RnZE1WU3E2eU9mWlpFcGlMZC9V?=
 =?utf-8?B?VUZwMGFkak5LVHVNVnRlTkluSG12WDlxb0hGbEYzQllocmxlMVBHSnA3SDBP?=
 =?utf-8?B?dWFVUnhVbXV5NXZnc0dOYzJ0enRRY1RJODVhZzNHeUdMSUtHOCtOKy8rQlNp?=
 =?utf-8?B?U1JFMHRkbk91eDBTdWtWSzRMOTVKV2JpckIxWXAyQXM2VjNKcEI2ai9GTDVx?=
 =?utf-8?B?M1lubnJhVUYrQWhYd2hCbVo5TUovU1MrRjNnQW9qMjJHa2ZnSkxTWElLRHV0?=
 =?utf-8?B?QUVIaG9yYzd2NVZ3VmZUNkt3NW5Nb0dmUTJRQWFyY1NDL0dBSHJFNGtFSHZY?=
 =?utf-8?B?MXQrSHJNd3Y5cEt5UVRtVXJHbDZoMnRVcGRWY253MmM1aHR5Mnd2b1JWb3lh?=
 =?utf-8?B?QUVwY2MxN0ZqdUVrQlpNYm9wMWFWdC8vRFZvRVAyOXdhRm1GN2FaS1c5Tkk5?=
 =?utf-8?B?T0VBQWRZL2RPam8xYXljbkNVYzIwdFcrZHhzaFhqMWVUVGt5VCtqNUVUcHBl?=
 =?utf-8?B?ay81bzRsWit6OHpBVzZKOEF4YjBScXlZbldYYThudHg3bk00cWFDOHlIZldU?=
 =?utf-8?B?NnYwaGVvUmpTZUN5SFFodnF2WDBNNXgxaWJJQmJiM2xVbWdDSEtTM2lRQ0Fw?=
 =?utf-8?B?OXl3d2VGR3ZwbmVHRkJtblRmQVhpTk5UeUF6aXY5ejZ6bmRFVTErdTVVV2lp?=
 =?utf-8?B?ZW5SdDZ2T2ZXYVVrL3lwSDdXWldLbnZsQVQyaENQeTg5MTFTTHF4VXFjWVBt?=
 =?utf-8?B?YXZCeEZkM3FuaWhvUGdhRzB5OWdFVlVGNXZuREVGZHdLcEJLQytpWW12dHZB?=
 =?utf-8?B?WXRzR2pkR3JxUFZkL1RpSDlBZXkvZ0NPakxpRFd2V0FXM09nM09RUVJaTkdy?=
 =?utf-8?B?TWhBTmh3dll5L3BueEpzNTZNQWFieko1dGtRbkZITXcvSkxxR2F5OExXc3M2?=
 =?utf-8?B?cTV4dXRHem5LOGhhUmFhRWZzbjg1bjV1eTJKa3pjUzhiN1NxMjlhUGYzZTUv?=
 =?utf-8?B?ZUpTdzE1Q055enlpbzQ4cjkxMW1neTZ0WGZpQWw5ZGxCMWRpY3pOZjVvUkVR?=
 =?utf-8?B?b2QwSzE5ZmtnTzFBb0NtanNqTUR1MkVWbTQydDhySXp2MEYyZm5PcmpDbE9B?=
 =?utf-8?B?YUlNdHc3OHZabDNUS0RDSUI0WklzeEZYbnZocFlOQmJmNnVSY1IrT0Z1UWZO?=
 =?utf-8?B?dExBc2FYc29rdFFqYkVGRE1qVXd2OUk3dktENnFLemZ1eW85YWlkNElkK2Iy?=
 =?utf-8?B?eVhIWkJCaGQ4emxtVFZjd2preFpCemVDMWhUTU9Fd2VtZlN6MUxFUnNOK3di?=
 =?utf-8?B?S3Q3NHB0eVlnM1REZmE0MmhxaVQ5ZnE0Q3Zxa1piS0htcTJ6SmV3QVE0VTZj?=
 =?utf-8?B?OEpFMWFSUG00dklBTFlVaXdrZnVMcGI1Nmc2ZnBiOUZxMlNnYmpkanFZTkFn?=
 =?utf-8?B?amwyR3doOU00UlpsbHdYb0JjWFdhRk9HeTRjb1BSMXNwWVVOMzBvTDdUUnk0?=
 =?utf-8?B?dzVZZ1p2d29aZ2p3UE51SEFEaVU4Zk5VTEFrakxOQzFOSlQ0WXlvVWZIaURE?=
 =?utf-8?Q?WPvBKCPNP4+SFmQh6NeNdDZqipTOu5ZK9LeBEF2Z+bidU?=
X-MS-Exchange-AntiSpam-MessageData-1: +u8oHxTFr/u0MXZQ/mYl+XIKgVC69rUtnz0=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bed28d-ba8c-46f7-e314-08df3faa2e8b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:13:46.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pq/mBvxYWZIDISZoCx6WpYMu978LmFL2ee+XAmJ2n/t+KDVUTrVkCHm9axWjxlOGz+B+/REDj/4o1of3e1gI9SEfDkzE7IpNl1baHV3hfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB353182

On 2026-11-10 17:33, Paul E. McKenney wrote:
> On Tue, Nov 10, 2026 at 02:28:44PM -0500, Mathieu Desnoyers wrote:
[...]
> Cute trick with the per-CPU variable for the flags value!  ;-)
>
> A few questions and comments below.
>
> I am pulling this series in for testing and further review, but I do
> understand that it might need to be replaced by a later version.

Thanks!  A v2 will follow, rebased on v7.4-rc2: patch 3 no longer
applies there, because of the kzalloc_objs() conversion in rcutorture.

[...]
>> +torture_param(bool, atomic_irqsave, false, "Half the atomic SRCU readers disable irqs");
>
> What happens if there is only one reader?  Hey, you knew that this
> question was coming!  ;-)

The choice alternates per CPU, from one reader to the next.  So even a
single reader thread alternates between the two forms.  The description
says "half", which suggests a split between threads.  v2 says
"Atomic SRCU readers alternate per CPU with irqsave readers".

[...]
>> +#define SRCU_TORTURE_IRQSAVE	0x20	// The reader disabled interrupts.
>
> Is this supposed to slot into the RCUTORTURE_RDR_* bit positions?
[...]
> If this is independent of the RCUTORTURE_RDR_* bit positions, why
> the 0x20?

It is independent of them.  It is a bit of the index that
srcu_torture_read_lock() returns, so it lands in RCUTORTURE_RDR_MASK_1
or _2.  0x20 was the first bit above the five reader flavors.

[...]
> If so, it would be good to define SRCU_TORTURE_IRQSAVE somewhere near
> the definitions of RCUTORTURE_RDR_MASK_1 and RCUTORTURE_RDR_MASK_2.
[...]
> Might you therefore be willing to instead consider the value 0x80?

Yes to both.  v2 defines it as 0x80, next to the masks, with a comment
that it is a bit of the SRCU reader index.

[...]
>> +	cur_ops->extendables &= ~(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH |
>> +				  RCUTORTURE_RDR_IRQ);
>
> All the "srcu*" torture types implicitly set ->extendables to zero, so
> you shouldn't need this.  The exception is the "busted_srcud" torture
> type, which is supposed to fail anyway.  Or is "busted_srcud" the case
> that this code is trying to handle?
>
> If so, an alternative approach would be to only do the _irqsave()
> readers when ->extendables is equal to zero.  Which is admittedly still
> a bit hacky.

It was only defensive.  I had not checked that every srcu type but
busted_srcud has no extendables.  v2 takes your approach: the irqsave
readers run only when ->extendables is zero.  It checks this once, at
init, and keeps the result in a bool that the reader tests.

[...]
>> +		ret += ((idx & 0x1) << 4) | (idx & SRCU_TORTURE_IRQSAVE);
>
> This bit manipulation is getting a bit ornate, but that is a separate
> issue and can be dealt with later.  And who knows?  This might be optimal.

Agreed, I left it as is.

> And it passes initial "smoke" tests.  ;-)

Good to hear!  Two more points for v2, both about synchronize_srcu_atomic()
rather than this patch.  I will raise them in its cover letter.

Thanks,

Mathieu

--
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
