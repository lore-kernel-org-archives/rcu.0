Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793750210;
	b=YuPWTw7Dbnz2UCYD5USTyd9q8eCYLBtnvdNVXtpAEM4Gp1NlkTh9ca8uAGW9J09liQB5
	 9OybXkV4yxqp7nQPMWnm6/XAI3EYU3sSRyVd9hkR6f3+87IPduQnQUn9dVvMiJLtGCSo3
	 +KT6XGCw6AHxH+bFbJFBJwYblW4CTFFxfA2atyWuAgZ76Ukz8SZZGKsPWa+pgtQqmTeXQ
	 hcI7n7PmEbOjCxSXwfG1Wm8qI74yvW23baR7IkDfOpk2MvY/0pGg5j1KyyqMC4wZcIpVc
	 5DZpm+S0dVjPMjexhGj3vDBdo7q9cPcJUBYw3hH68FvkPliOuelN3H3+CsFUrkjDIYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750210;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pLSkilSijO8oOiwtwz1A+I2vkpv3gMltp0f/h38zo+g=;
	b=UxgNTr9FpPOAvg/Gd3FsfzmruIbZ1BWmmVh9cR9dx/lp4JkRSY9skTP0DGjFxu8Czi/J
	 7zMN70uymUw7C2Wi/07EUQtRd6RfiD3HS9ZFhECfvZzbynK5GbMnxHy9ck77NHKVbJXgw
	 eYB9JEHkwfJkEECRZfSwoN9vuBQ5/mTlU1NzTqJefSEfS99EY0DHlzQgf8M/7Ht0jSvhW
	 gFP1BdNqCCAv5VQhTZSpsz1xALl7gkZKS8fNOVYRsdzrUP0x+J+GL50SL1GstdoDmvUbT
	 UQahQ6JOOciC4Fc5QMJ6mJuN5q/FxsWBRFBvecns/80QdgkY8hWvdkxu5fwNwfV5PJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aSeEtr7A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86799606A324;
	Tue,  3 Nov 2026 23:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86799606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aSeEtr7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teEqz2epRc507sI/EVU83Y7EK3DUCd2SQmbIKNbyQ+34Vzuo82bQj84KMqVMUcXSXnS42VXQxPrHE89KG1SluEOGDJTINGo7iHq+rst5FKc6AFI5AaMLa47xMPY1F3/nJ/8FG+oOV8bH/0JWiW8YsjSSqPqpyZnw26KTqGHlaaowPAivm7Ug4XC6TfU4xBan6gXxYHCxTB76frTPET6xuFjXCZmo7M5kJmfYRL3jU+7VdywyvO0JDEiKurymWwsSZOPCOjf7dbvvd3Vz+HecKFOxCl/vbWbxyqWwoQkB8U3TO9a2z21ePtMcyYIKb2GRZQp0hO26jzOG2rB35m6Uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLSkilSijO8oOiwtwz1A+I2vkpv3gMltp0f/h38zo+g=;
 b=tgdqJHQyjtJJ0t1k8ji0L/nVEeEuqmuw/r8+kFJJFFEZHe/81cA338kOuDegl2Fv8v1GolPX3QYmqCjJ6p5vURjmCPUWcVTI1suUEcnN2+obgdd32LCUUOEVgQBJ+D5iVU/76uvQ2FCp+F628zC3/DEYAcwxwI0air9LQfIruQC+AgCPS3FQ1r2uCKlO6zgXlB686amO8XDa2jx4N/AOD/FN5CCGUzf//J0x2N5jxd/zbG6cRWeeJW18e3WuQsbSvU8nSh/FQxQxonIeZpMVstdXlkEm6YnWI0b7/NEElm3x1rVOMF7yEpTF08I4EQax0Agb3qvoL+71bpsD7xEjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLSkilSijO8oOiwtwz1A+I2vkpv3gMltp0f/h38zo+g=;
 b=aSeEtr7A8mfesJHVgaMQGBVtcO9P1L2WK8naZl8lxxV6ZjXsz+xUzMgKvPYBIhLfDMx4JjEwQc6niPcSsFoPRxq2W4Vk2tVAG+X6VRx1CME87OCPt4YXXZByOcl7i9j9Vfb+UwL60TDh6ieLJBnVFwD355JTXPruzGulwp3b2vG94OlmY5K7mWOi1zVaIKxkgB2+Nxg/60aYgOlgeKZDhocBpBUK3xJY0hx9qNZUsrT+F+2hu/6G52gLPGKrE7Lu+9XzGLLIUP3PjZ5W/B4KhhQTrOBqIFWIbAo8ynXfLuB5G2yWKjZzxlgaugtqCkITrSCyBMqINNUEIIJzmLua0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:56:45 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 23:56:45 +0000
Date: Tue, 3 Nov 2026 18:56:43 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	work@onurozkan.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] rcu: Improve callback diagnostics and validation
Message-ID: <20261103235643.GA4146834@joelbox>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
 <20261027231315.GA3580680@joelbox>
 <CAN_Opa9n-iqRgQczQ5_ZpTMHFbjmW-6+ZYsCgCYdNfuprXLyFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa9n-iqRgQczQ5_ZpTMHFbjmW-6+ZYsCgCYdNfuprXLyFw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9015721e-b1c9-44dd-8be9-08df3a061dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|261022075727099003|56012099006|11063799006|261021135927099003|261009223027099003|261026121527099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|10067099003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	umyfXfHvOebGb2cMW1/lW2QF8F+UmBC6PCR/25+dSpGtK/gvsFBNelS9j+nS95DotXC5lrsQp54Vgi5TkKbMZH3zge9iU6PsBlh7qIJ4OgkQkhg4jvFWkRcq4VBotSae/WIeIrd8+zCZ/qrg3sx/a9jWLZ2RVuDBckPD4AT0HaUoY7Z8SjJHncU0+PhK9o4rtGk8qFzBgEh7B72GSmkguo4eysehnQMRPpXVQf5fab/KN+UnoDnVBmGy/q4PfClGeYG68HHNszIIU4dTw1my9RbneTs2JRW8p1T1tpKU81EGDuXqHpRpDvPZRGrNjlmjJGZhFpp68O1RDfCII52Lz7EQtE2ct3CdZhOi4iQUDBOnr5kQJDhiQAum3vCcQGCkJ+3pbzBougLyfVZt27nNVzhPVKPAd6TgXUMzLrWcbeRofSgKKVoRhRSbRn2eZDuO5+1QCHNN48i9LSY3leOx4NpWQ8zG+80PZyx+yyILkRnt2ZH9D+wZz2c9+j4nuTOtOpZ4wFAUgzPTSn2RvspzGgyYulcYE7ZXdagTsaH4yjUySeUv3eS8SoElkKZMYVcLKwUtlTvmPHbo5g8N2UlH6gfALVF8wWpi1GESpa63YJMgWaGGZhpvPo8YcQQVLY0g4z6cQ1KkrvgPqn+N3BA6Kcy1w9/w4k6cLy+87rBD2p8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(261022075727099003)(56012099006)(11063799006)(261021135927099003)(261009223027099003)(261026121527099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(10067099003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFV4ZFBCa2R3eWdseDlMb3BpbzArVW9ra3dwaW9udjNaaERvemx1YjU0RkRa?=
 =?utf-8?B?OWZHbk80Ny9HdS9DdC9QRUpsQ3ljNHQxbGRTbm5IL1pGZUY0ang5aEpoN28r?=
 =?utf-8?B?YTJYM2FUajJ0emdaT1FOMGdFMjQrYmdIZ2J6MStCeFk2WjlqVUFMbHBHUXJY?=
 =?utf-8?B?Z3h1Z3lmVzVmZ3EwNi9lSURQMEFpZm83Y1pHczU0TzFoaFgvQ2ErMnBSV1Bs?=
 =?utf-8?B?b3BGczB5MzhFVVBKM0dSaXFodFFvWU5iUWg1OWx3WU1UR3hUN2g3Z2t6eEF6?=
 =?utf-8?B?cnRKREFkZGpKcU5pQkdsMTVtMElkOEJHTzBPTEdHTUZOenh1a3lzbHNXa3dv?=
 =?utf-8?B?UVZaeFJyWXQxWU9zczA0M2JFZEZmUnhCK2lsaUg5emZ3bW1ScFZabkwvSy9y?=
 =?utf-8?B?bmJhcm05bG1zRFFWQ2FkV3BGV1Y1UFNiYXhQV2ZTaTQvYXVTUTlmcXZvL2c3?=
 =?utf-8?B?UFI3MEw4RndrZVovSGdqeE1KUzBVZDZENlpzd0RMWGdQaytqNzdob2k4RzFJ?=
 =?utf-8?B?UzBFVU9qeGNITTdsQ3RTSGYrRC9xSmh5Z0R5N1FWT1VrOGpKV3dHalIwY1M4?=
 =?utf-8?B?OXVEdU1UaDNzR25jSEJFa01PZDkzWGZJdWdkdGZjSTNaZ1NCdnhkSkoxL1hL?=
 =?utf-8?B?bXBkcDIxempjem9VMVBwNDZwM0orUllUNWlJTTdRM0hUN1V1TzNIcm1saytq?=
 =?utf-8?B?a0RwZzFFNEVVWnR6OXIzOXhvSERITU02V05VZGswWTVsV0l4UzdQUWIwb1h4?=
 =?utf-8?B?VjVXeXNLZXFpbjBHbndGNE9nZVpzY0g5bEMrazkxcm4wdmNIYUxVOFVYaDlq?=
 =?utf-8?B?RjVkK3VLVi9LeEJwK2ZyMmtpMnFmTFRrbEVLQWtwZjZRTytzRmVYZTFrdTVE?=
 =?utf-8?B?U2lTMmJ5cGVITy93LzA3alRjZjF6dGlYMzVrbjVvTlNEN3NnZ25DZWxFMTB3?=
 =?utf-8?B?TG1FSkdPakk3V0lFSjFHMEdjZlBRWko4RGtvZnlET25zNnM1UzI0Vm5NeWJZ?=
 =?utf-8?B?d3FmWVEyZ0ZpQjNDOHpqQlNiUmZZamQ0OWpLUkt3OEt1M3NmUTM0MWpqNjdD?=
 =?utf-8?B?S1p2L3ZWMSt6OE9tbk1iVlNiaEpzdjl4VXFlRi9oaDlFYTF2OFRDZnAvd3Ra?=
 =?utf-8?B?VFA2dmk0T01GR0JpeGc3ZkxUZi9xcGRzUWowWHA1Z2dGZk5ObDdzdmIrc0lP?=
 =?utf-8?B?RnBYelNVcnRkT245bDlzM2dFdlJKeE82Y3R4RllkUlgyK2JzaE9QZllDdUtC?=
 =?utf-8?B?dXRCbU9yUlR6c0hNQVAzZ0ROZTNJWnQzcHBjcUJESldoY29WZ211NWRjcjVN?=
 =?utf-8?B?Q2lQZ2tZZGx6NXFRalRud1lBVStWWTB4eVlPdjlTdFdkS2VwOFJFMG1NSWlL?=
 =?utf-8?B?YWg1QW5vWDFrTUp0N2tLUTJuSTUrN3lWVUlCdUN2Yzd3UVNrY0RiQVVwNzkv?=
 =?utf-8?B?L2JxUDExdFpRZS9FaVRDTkVoYThlT1k1TjRiN1o4bVRGb0Z2OVJER1NCNmpp?=
 =?utf-8?B?a3N4OERuRmVSSWhMRysySGlkL05mdVNDZmJNSEljSmlBQ2lxdUxmSzJCdlZE?=
 =?utf-8?B?bTN4eWpqT01ucU4ydmFhMExzbjVrRlBQVi9yRjNZR2owb1RuSkN2VWxjQzFC?=
 =?utf-8?B?TENGbHlMVGNzSERJZ3NXZEMwVmM0Z1BTRThRVHNrK21HSDhGdUZaL2RaT29p?=
 =?utf-8?B?dEZLekMvb0tIalhkejZrR0tPSDdZekgySkR4QjZIWm9aY25FWFpGbGlGWm9R?=
 =?utf-8?B?ajBvUTk2OGZUaHgxKzd5SXBWQ01JSnhXcXBHdUt3bmVoZkZSNkFPZGpRSVN6?=
 =?utf-8?B?a0dMcDNtZEc3eDhxdk4zajVEbTZrYnEyZnRRR2Z0bWo5d2JtTUdIZEZNSDVv?=
 =?utf-8?B?Z1IzcGpMWHdlTTIybU00YnlDVzAzVUp4Z2YwR1VGVVFneFY1eG9RdTkvTGMr?=
 =?utf-8?B?aW1oUXcvVXVBZEVrd3ZuNWNDc3VYdmo4eWFOYkwzVzhuWG9KcEpnNnpEa0ZO?=
 =?utf-8?B?cUF2MEp4cXhxSWsxUHFoWUp0VTJEYU1TZ0EwcGVvTDlNNlV1czhOSmd2Y3l5?=
 =?utf-8?B?V2tTNWswWWNRVWJLNjVoNVRsWVdLVGg2MmJkcWhkWGFwMFc3TURpSFFiUThB?=
 =?utf-8?B?anRhTjR0N3pJbGpvMEhZcE5WYWNSa0YySnhieGZadHVqeUpNaEFGbDNsM2hJ?=
 =?utf-8?B?d2ZZK3BJRUJYdllzbEFiaUVCRU1aM1AzdnBsMVMwdVI1cjQxWUxVQ2hiLzh5?=
 =?utf-8?B?VnVrWVFiTEVWeU9BZWF0dkJ1VzVNY0dtTGltWmdPZDBMNEZCV2VxVHFGRmlF?=
 =?utf-8?B?M3NzM1Z2aUgwSFpIbnY1eEViNG5QQTh3aUxtN1RNNnVjbFpTWm9vdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9015721e-b1c9-44dd-8be9-08df3a061dcc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:56:45.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJwDzIUBqCswzZ2HT+tOJdCTrCSxCUaaVZto9fW3fq47PXvJUMADEpLbrvLLQTl+lM5Wy4rpWC4YgL0kcGme7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124

On Wed, Oct 28, 2026 at 10:17:25AM +0800, KunWu Chan wrote:
> On Wed, Oct 28, 2026 at 7:13 AM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 03:09:13PM +0800, Kunwu Chan wrote:
> > > Hi,
> > >
> > > This series improves callback diagnostics and validation across RCU,
> > > SRCU, and RCU Tasks.
> > >
> > > Patches 1-3 record callback registration stacks for KASAN in Tree
> > > SRCU, Tiny SRCU, and Tiny RCU.  KASAN prints the recorded auxiliary
> > > stack when reporting a use-after-free.
> > >
> > > Patches 4-6 add rcu_head alignment and NULL callback-function checks.
> > >
> > > Patches 7-10 detect duplicate callback enqueue attempts before
> > > queueing, using the RCU head debug-object mechanism.  A duplicate
> > > registration is rejected at entry and __ratelimit() controls the
> > > diagnostic output group (pr_err, mem_dump_obj, dump_stack).
> > > Detection requires CONFIG_DEBUG_OBJECTS_RCU_HEAD.
> > >
> > > Changes since v1:
> > > - Patches 7-9: __ratelimit() + dump_stack() instead of hard-coded limit
> > > - Patch 10 (new): same change for Tree RCU's rcu_do_enqueue()
> > > - Patch 9: fixed log format to avoid pseudo-function names
> > > - Tags: Reviewed-by (4-6), Suggested-by (7-10)
> > > - v1: https://lore.kernel.org/all/20261023101841.2910719-1-kunwu.chan@gmail.com/
> > >
> > >
> > > Testing:
> > >   rcutorture with KASAN (SRCU-N, SRCU-P, SRCU-T, SRCU-U, TINY01,
> > >   TINY02, TREE03, 3min each): all exitcode 0.
> > >
> > >   KASAN aux stack (QEMU, CONFIG_KASAN_GENERIC=y):
> > >     Last potentially related work creation:
> > >      kasan_save_stack+0x33/0x60
> > >      kasan_record_aux_stack+0x8c/0xa0
> > >      call_srcu+0xb2/0x390
> > >
> > >   Duplicate enqueue (QEMU, CONFIG_DEBUG_OBJECTS_RCU_HEAD=y):
> > >     call_srcu(): Duplicate call_srcu() CB ... ->cb
> > >     dump_stack_lvl+0x47/0x60
> > >     call_rcu_tasks_generic(): Duplicate CB for RCU Tasks, ... ->cb
> > >     dump_stack_lvl+0x47/0x60
> > >     rcu_do_enqueue(): Double-freed CB ... ->cb  slab kmalloc-16 ...
> > >
> > >
> > > Kunwu Chan (10):
> > >   srcu: Record callback registration stack for KASAN
> > >   srcutiny: Record callback registration stack for KASAN
> > >   rcu: Record callback registration stack for Tiny RCU
> > >   srcu: Validate callback arguments
> > >   rcu: Validate callback arguments in Tiny RCU
> > >   rcu-tasks: Validate callback arguments
> > >   srcu: Detect duplicate callback enqueue at registration
> > >   srcutiny: Detect duplicate callback enqueue
> > >   rcu-tasks: Detect duplicate callback enqueue
> > >   rcu: Improve duplicate callback diagnostics
> >
> >
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Thanks, Joel.
> 
> >
> > All look good to me, applying for further testing and review for 7.5. Did you
> > also test double-call-srcu and confirm intended behavior? Thanks!
> >
> 
> Yes, I tested double call_srcu() under QEMU with
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
> Both Tree SRCU (direct and deferred paths) and Tiny SRCU triggered the expected
> duplicate-enqueue diagnostic with the callback symbol and dump_stack() output.

Great!

> 
> BTW, I'm working on follow-up rcutorture support for
> duplicate-callback testing and
> KASAN aux-stack verification.

Nice! How is that coming along?

thanks,

Joel Fernandes


> 
> Thanks for review.
> Kunwu
> 
> > thanks,
> >
> > Joel Fernandes
> >
> >
> > >
> > >  kernel/rcu/srcutiny.c | 34 ++++++++++++++++++++++++++++++++++
> > >  kernel/rcu/srcutree.c | 36 ++++++++++++++++++++++++++++++------
> > >  kernel/rcu/tasks.h    | 27 +++++++++++++++++++++++++++
> > >  kernel/rcu/tiny.c     | 11 +++++++++++
> > >  kernel/rcu/tree.c     |  9 +++++++--
> > >  5 files changed, 109 insertions(+), 8 deletions(-)
> > >
> > >
> > > base-commit: 940793b926aa94bf65ec404043050888e3053188
> > > --
> > > 2.43.0
> > >
