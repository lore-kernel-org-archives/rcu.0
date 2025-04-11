Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09F1E835B;
	Fri, 11 Apr 2025 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349799; cv=fail; b=f7iRYlyJZpEesD6zqVHAsgeVndXIyVVd0/n5erTbvhddVjT85pBalp/4j0EW9+23cvcf26M9jctakpyFrCqOHnWlszt6kg6wS4VScoHUO+wIFasTvvrU7KE/3lpV3gFKwL+d3qZZd0ttTwA6kdJic4uqGwfGNE5brXCAFoG8+FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349799; c=relaxed/simple;
	bh=4B5pdIGGFjd60eshrym5EaPW5I9keHSAL7vraZUGq8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRiOR1Dm0Pu8n0b5oe0mjxZdnAjjkZ/MfSsf5c6uQ21Rntj8yCnYRG1IUoVdVTJF/ApAp6nfgAg5J2WTUwYB2MRYKULTbN/1/05NjS6Y7mLmRW7GiX+zkEf9ZLycMV/zatNcqaOLwYxx/qWFxw+xj9txUt1c1FmeUEWHZo53LzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hK8X9Fqt; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hK8X9Fqt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJdvbKcW/jZIAws4U/QiO4eDLVbWvcRqS4NZOknC6aKu4sFh0lJ0of+h1g0xkRTDczw79COikQACpLmJvM3kWICAnSoLRlKvhYi8VEWx1PLkZSoUMC6X8bfxIGjXjTqmbEZNHm5x/tYi+UtOjj4kG2MD77xcDOW/SaUKnotOw6UhnN4HXunfwuo6fENKKd2OV1PpM3DPNLtVDTTHVAgZGWCQxwfWPBnWjzhEW8z2H9olF+CXAyHGybPAqrIaXcB6rTRPrvA0BfzEyjCJ+ixI/B+Z6t2F8hYSg1hNYIZ4iyuX2uf/j5vIgSuPFzvnTFG0WYQrKcNSvTfLU+HaD6dLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVYx11IraA3sujim3LqzCmZRH04Njw6dxm4zd70kAyw=;
 b=aW3rcrLrAjZnUiFU9cPjTqR1bnO7mC75LwCSNALCrdDyfr6yU4yUsk/it91yeJO4DD/CL0G59vogWZnOXKwYEQ6u2a2/N3JWnmoWg5KwUk32URENAuu2S3dfjqME9cDpfeKh0vmR2PqJhML+jF/IBNp2/+HlvnMUU9z8h+qRONRLG3RPiCGWmDv1fA/xUevn7SbXaB+Arp1OfwUrf+ffWhRqs3MxzraHRC+3vYtvYrfjT7W3Jq9lKwJjdJcepRNOW3M14Uebk/QoMQjAAnZmxUllT3tOiUt7efnlguDr0KWuqM8XVy19RecIgv0xtVndc8bobp8A/aPhcLAzVIQrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVYx11IraA3sujim3LqzCmZRH04Njw6dxm4zd70kAyw=;
 b=hK8X9FqtbN8VQNLRojN0QR5Dv4nwQw6DI18jp46U+nejehmKJIwk1OHvyQNdDuMKIbd0WmYJNqUb/m3AY9w7OF5CX1OULljnu+rigQZmpI+zr+Ld0l79DckC8HQxQXpuJ+HJufv2ty1cmUavSn948KUjCmShTNDpxCGgF90zM+jNyAgN5FDXr+0ntvPR/c0YN50nchZUhN8qmb0xHpw1lJm7b3prDGuFv3VgwnyRRTOFA2HXtzwJSGlEFpUfriM0yYj+0GPocXXqb87iOZmTTDWsT0WAuGxNk40CZ+8EFwgQRFZy5+xoxkGmkNhCCHR2pPobEywyXTklzDhnkav+wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 05:36:35 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 05:36:34 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Fri, 11 Apr 2025 05:36:32 -0000
Message-ID: <174434979260.108.12165413620035643068@patchwork.local>
In-Reply-To: <78c902f2-3b01-49ce-85c0-3c748fa43224@paulmck-laptop>
References: <78c902f2-3b01-49ce-85c0-3c748fa43224@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0670.namprd03.prod.outlook.com
 (2603:10b6:408:10e::15) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1c69d7-8c65-4aef-517d-08dd78bad279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BBcGlleXUrbjdqcW9VRmNvaXRGYVpvZFMrWER3a2ZaNm8ydnBYeFd2K1Zy?=
 =?utf-8?B?OWhtVnUvZVZwamQ1NUpHMGwzZ21WTk9EZjVza2MvQ2NSd0JLMlNUWnZQVEp1?=
 =?utf-8?B?NVJlamRqUG1nZTJVNWNlOTlBWStmUFRQMUphQyszSmVRYXoxMUswUTlWNUh1?=
 =?utf-8?B?NDBYWUpKcFNXV0dkcHh2aXAxdCtibWdaenlIUUJtMW5JZUVMaWw5K1dpTEpX?=
 =?utf-8?B?Z0FXVFZoVlpCdnZlcXI3dmhoZHVNNUNlWDBTS1BPUmxnL0xWUG1ZcUFMR1dW?=
 =?utf-8?B?RFdibVVJTktEc3RaZ0hsdjhNbWV4emYyVTQzY3BmN3JLUnNPbUlqL28wTHZE?=
 =?utf-8?B?QWdpV0J1VFVCZlpDZ3ZIT2JRM1ZaZEIvQy9vZ21PaFVOcHU5OFEzVUhQU0ow?=
 =?utf-8?B?bVFOTmRZKzJRblI5T2p3Z1l5TG9ndjhYV3B4RWwrQzlkK3lYYWdrQW5KQUJa?=
 =?utf-8?B?VlFGYnI4dkpDZUZpaW1SUUZiK2NWSzhQQnBvNVpwYWZseHFPdFFmQWg3blAw?=
 =?utf-8?B?QmlCSlBQYUlmK2JZUnFMQ2pCbHFyQlBDdHpYWXRkeGZzdXV1anQxTnhmblJD?=
 =?utf-8?B?bXhQc1RmOXM4am1JOVJMeWhGTXRxTEVqdURoS1NCc2hnTU9FTEEwYTVJSE1z?=
 =?utf-8?B?eDJPTVk3S1FaS1g5VWFNdGwwaCtpZXpOc1pNdjZtZnBxdndTOUtmN3RNZFNX?=
 =?utf-8?B?UUFvQ1JqZTY1NXFJR1VPanFKeDhRRTNjNXpXcXZZWWNaWGlUamNmcjlqSU1Y?=
 =?utf-8?B?M0F6UGlVb1RBaGRIL0VYSHAxY0JOQjlUSFdGajFXdWxOVGF2OXJSZWNSc2FW?=
 =?utf-8?B?aGszSFJHVkRqa1hmamlrWkNxS3Z1ZjhFOENyT2JrNlJHQjEwQTF2bVZyQUVL?=
 =?utf-8?B?TVlyb1pObU53UEZPU0ZSMGI1cjFGczQ3L1QwU3JCemJlczFwZE96T3RweUt2?=
 =?utf-8?B?MDR0WVlIZUFQcXhRMmNkakluQkdyeWVzM3Btd1BmQXBqNDdCNzRjZnFWZ3Jt?=
 =?utf-8?B?QzdZOStOZzdzSlV6bWpnc0JCUWhjQVpQZXYxYkhsM1hrNWxLTTFLclNSMUlr?=
 =?utf-8?B?TWY4RWN3TTh2MUZVaGt6R1YrMk1YZmNRaWphL3pRMTMyVThJcXpSUWtBdndx?=
 =?utf-8?B?Yk5jMDR4ZVZqays0YnBEdXNLSTYxK2ZHWXRIbTNNOUlYcFBJV2UwcXNQbjlL?=
 =?utf-8?B?Zm1lQ1lBTHlMQlhkejFmTTZxYjVOdFdvYlM3MjlRaGhYNlR2RkkweVVuOVVQ?=
 =?utf-8?B?d0hoSzNYWDliMWFaeXlLRFozUVRhRnVlc1FuTlBYNElFMktmK2d1YVk1V1VS?=
 =?utf-8?B?dDFrNnlHZExPY21WVW9wd1pzWHpSSU56MDM5YkxOKzFZbUVtYmNvYXBTd2tG?=
 =?utf-8?B?WWRQQUg5eTEvMks5RHN3TjlwOFFPQ0VQTkcwa2N6bCsxSEZWbTN1TkRqa24r?=
 =?utf-8?B?bThPWms5cHdwMUtJVGpHQ0Z6LzY2MzlIU25teWFKRFlybHB3WFdqQ3NZZWtI?=
 =?utf-8?B?SVNTd1FOZ3NvK0F1dnpJamhUZEEwc2xpMldaVCt1NjZWK1NhTjU1bW0xOWI0?=
 =?utf-8?B?YzJhbXB1OE5MdTdEY2cxejVEMXRaZm1BZkdNVnhDR2J3dzl2MmpRZWczR2lm?=
 =?utf-8?B?ZnF1T2x0aWhoVFkxVC9XRmEvUGw2b3JWTWRnUVlVZDJDN0JvQVB3OENuSTFj?=
 =?utf-8?B?dUNxcnQrRVN3NlU3aTZpWHRwUmdYenV1cHczdGVmYXlvczRCQzJQWmc2U0w3?=
 =?utf-8?B?UDYyT0dTNm05MUVUSHhkZGdCSlk5MUxtMzVSVEFubFE3WnBMZjJNbkUyT0ov?=
 =?utf-8?B?em9hR3lhZ0l4d1RnRnpSdDFvRzNpTVNvdkNWc01Fa1RvWjRoWkd3bTlyWmd0?=
 =?utf-8?B?MnFqQlVGOFluOEk5QXdlRXI3cXNWQkJKaWlVMVYzQzEyS1A5dVlqcWN3RE01?=
 =?utf-8?Q?RMSRNbY2r/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZStnU3hqWkZNeGdYVUJORVBQSUNZVldDamZjSHNsWVJGNFFpRmRHT1N2eTlO?=
 =?utf-8?B?aFpUNmFyWmNTSUFVTDIzOUhvRWFxdEZaQlRiZ0o3VHg5WnFjQWs1a2lrU25m?=
 =?utf-8?B?VTNFdlB0SmpXRmhKU3RUampNNzczZXJNSnBiUW5uNlVMNCtFN1dwSVIzczVM?=
 =?utf-8?B?SG01anF3SWRqVHo3MkxLeWpveWNkVnZDeUplUXE2T3FtQ0NDSkVuWkRWMXRE?=
 =?utf-8?B?SFIzcktFSkkvRkNVd3U2dXBmWE02dDBFUWdzSXFBTjZteGJydndiMy9rMGpP?=
 =?utf-8?B?NE5hSTY1VTRyUnExTzNSQVhKb1cwekE0ZzRjdUswTitpT1lRZGQ4VTkxT1A4?=
 =?utf-8?B?a0E3aEFOd1Zic09wczNUcWVjSWhLMXdxWEtwSU5CUjdqQ2hFSGRyczBXN285?=
 =?utf-8?B?U3gvaDRaZTVSbDhvRkdiSUgwMW5xUVo4QjFpOHRNYU5qZklTZnhZUGV0emJE?=
 =?utf-8?B?UCtVZVBSbVhaK29jZUE5TEZNQ0x1eU1hQVcxYnJ5dFJRV2tkc2VZS0tNeDE1?=
 =?utf-8?B?MVNKc2tiRXpkKzF5b3hSM091ZEIwdDVlRHQwYldJSjVxUVNzdy9RV1pKdjNX?=
 =?utf-8?B?ZVowaER6Kzc4eUZFR2RON0gyWmxJUkhHVktkaXczTSs3cVBybDg1SDdFQi82?=
 =?utf-8?B?eERER2pEdVRZRmZQOVVWMHliQ3RtTVIrd2s1cWNxQXE4NytqRG51NGZ4SHpp?=
 =?utf-8?B?YlM4WFhlaXk1VDZ0RFZ4VklpY0cyL0ttd1hrMlBGazF4NEt1WEFUOVFMdnRU?=
 =?utf-8?B?Z1RjblI4MEFML3V0NkNnR1V1WVJsUU1INUYwUy9IUFB1RzFYTzJRbkkwd0tq?=
 =?utf-8?B?NnBMYkFwRmR6SnVrZDM5NUxPRHYyRzVERXpJRTdCbUdudC81Tlo0M0FTTFFC?=
 =?utf-8?B?MFZnR0s0enprc29qckNxQzZzMXFPU3doWktwWlBkYlRBRVdob0hLc0M5SS9z?=
 =?utf-8?B?dkIwNzNXbi9hcWljaDVUdWNnR0hWTDFNcUpQVGpFQjdkQWswWGtiLzJTdWIz?=
 =?utf-8?B?emY3SFFtb3o4ZGRzRHV4dGNlSlBlb3NXbVpCeVE2czBhcWJIcEhPNWlBeTFG?=
 =?utf-8?B?QjVhb2hST0xhUXpnaytJaWJiVGV6dE8wVkRrMDg2VnZOVnhBN0RvbkNtczNi?=
 =?utf-8?B?RHVHNmdlY3RBOHRVd2VNUlQrK0hLc2wzbnRxSkdEUkNtNHQ1WWtEUUx2eFNu?=
 =?utf-8?B?eWpiL2tMTVI0UkF3T1JEdzlLWXRoTWJTeUZjUjZBYkhKM21BMUVnRGNjVmFP?=
 =?utf-8?B?T1VQRm5DSzZkRVFubjZJRVNTQkd4dlpZN1RMcTBPelBVK2piRTA5VDk0KzA0?=
 =?utf-8?B?c0YxUkZBT0hQdFp4dldneDBhektzbDdjMXpkZDVyL2QwS2FGWmd0VXhsNjRY?=
 =?utf-8?B?Tm1qclhGYWI0RTQ1ZTJTMk5uWnFBbm9ZZFc0NDNJRE9oT0hxMHBVUFp2aGJT?=
 =?utf-8?B?d25GNEhjQmI3eG15ZU54WUxmVGYrbnlGTjRaZURXR3FLQTRhcE1CMnZuT1lJ?=
 =?utf-8?B?am1XN3YwYitYKzBMcWlaQUV3WmR5MDB1cFNjdmJQeHRPN2doOFFxSld2Wnk4?=
 =?utf-8?B?VHJiVkh2dS8vZ3pkbXJYc1ZtMnVhU05TMkFRaTlnbzhlNkNPb1VBRXpaZldv?=
 =?utf-8?B?R1VhdWcrT1lsUlNFakNVWG10UEdlaUZ0Y0hhQ1JDYXVjYno5VTN1M1lCeEM2?=
 =?utf-8?B?dTJwcjdqY3ZUSng2N0c4UmVGbkhWdWxBN2lPaGFvSzZsVlBsVmt5MklwWUNX?=
 =?utf-8?B?dWRnUGJTR3ZFSUViS3Q1cU1OL2dCWGRNMENJU3lKN3ZQbDloV0VyMmM5OTZS?=
 =?utf-8?B?TnhUWHJPRmxhYjcxQzB1dSs5cTVRTyt1dE1tTys2QzU5Z2J3eXRWYWhzZFky?=
 =?utf-8?B?aVBsRW9ybHRkd1BzZmE3OGY4aXRpazJCZnE4RXdJU1JIcSsyU25kdSs4OWdJ?=
 =?utf-8?B?Y3J5RDliaVVWQzJ4V0YxeXV1QTlXc0hoSllZOXVYOG02STJZbXR3Vms1bXZ0?=
 =?utf-8?B?TWpHQzZrZnI4WjE2WkJFM3lKckVObmhtYyswdDNMT2VyajZ5ZVpMMjF5MkJB?=
 =?utf-8?B?cnRYME5TTkw2TUhWcHVBZTBQcDcxUW9uZzhwNVVybGJPNWRiZ0JFcDZHaXFI?=
 =?utf-8?Q?iICKgF6TLcvo06XNyLv1qRcju?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1c69d7-8c65-4aef-517d-08dd78bad279
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:36:34.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xecr5pHGUlTfhhyyskuXKUr+JxqLr4PF/4VRZjaV2pmSYxCyuuFOUn6V9l62uLojswBIN0CbLTC/kdaAyK0LfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

Hello, Paul,

On Fri, 11 Apr 2025 05:33:16 GMT, "Paul E. McKenney" wrote:
> On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
> > > Currently, the ->gpwrap is not tested (at all per my testing) due to
> > > the > requirement of a large delta between a CPU's rdp->gp_seq and its
> > > node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
> > > set. This patch by default > adds 5 minutes of testing with ->gpwrap
> > > forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
> > > just 8 GPs. All of this is > configurable, including the active time for
> > > the setting and a full > testing cycle.  > > By default, the first 25
> > > minutes of a test will have the _default_ > behavior there is right now
> > > (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delt
> a
> > > causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
> > > at least add a little bit of testing for > usecases where ->gpwrap is se
> t.
> > > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Much better, thank you!
> > > 
> > > One potential nit below.  I will run some tests on this version.
> > 
> > And please feel free to apply the following to both:
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And this happy situation lasted only until I rebased onto v6.15-rc1 and
> on top of this commit:
> 
> 1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.1
> 6' and 'rcu/torture-for-6.16' into rcu/for-next")
> 
> This got me the splat shown below when running rcutorture scenario SRCU-N.
> I reverted this commit and tests pass normally.
> 
> Your other commit (ARM64 images) continues working fine.

Interesting.. it seems to be crashing during statistics printing.

I am wondering if the test itself uncovered a bug or the bug is in the test
itself.

Looking forward to your test with the other patch and we could hold off on this
one till we have more data about what is going on.

thanks,

 - Joel




> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> [   15.911885] BUG: kernel NULL pointer dereference, address: 00000000000000
> 00
> [   15.912413] #PF: supervisor instruction fetch in kernel mode
> [   15.912826] #PF: error_code(0x0010) - not-present page
> [   15.913218] PGD 0 P4D 0 
> [   15.913420] Oops: Oops: 0010 [#1] SMP PTI
> [   15.913715] CPU: 3 UID: 0 PID: 62 Comm: rcu_torture_sta Not tainted 6.15.
> 0-rc1-00047-g6e14cad86633 #19 PREEMPT(undef) 
> [   15.914535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15
> .0-1 04/01/2014
> [   15.915147] RIP: 0010:0x0
> [   15.915348] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   15.915856] RSP: 0000:ffffa0380021fdc8 EFLAGS: 00010246
> [   15.916256] RAX: 0000000000000000 RBX: ffffffffb6b02cc0 RCX: 000000000000
> 000a
> [   15.916802] RDX: 0000000000000000 RSI: ffff9f121f418cc0 RDI: 000000000000
> 0000
> [   15.917305] RBP: 0000000000000000 R08: ffff9f121f418d20 R09: 000000000000
> 0000
> [   15.917789] R10: 0000000000000000 R11: 0000000000000005 R12: ffffffffb6b0
> 2d20
> [   15.918293] R13: 0000000000000000 R14: ffffa0380021fe50 R15: ffffa0380021
> fdf8
> [   15.918801] FS:  0000000000000000(0000) GS:ffff9f1268a96000(0000) knlGS:0
> 000000000000000
> [   15.919313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.919628] CR2: ffffffffffffffd6 CR3: 0000000017c32000 CR4: 000000000000
> 06f0
> [   15.920004] Call Trace:
> [   15.920139]  <TASK>
> [   15.920256]  rcu_torture_stats_print+0x16b/0x670
> [   15.920514]  ? __switch_to_asm+0x39/0x70
> [   15.920719]  ? finish_task_switch.isra.0+0x76/0x250
> [   15.920982]  ? __pfx_rcu_torture_stats+0x10/0x10
> [   15.921222]  rcu_torture_stats+0x25/0x70
> [   15.921435]  kthread+0xf1/0x1e0
> [   15.921602]  ? __pfx_kthread+0x10/0x10
> [   15.921797]  ? __pfx_kthread+0x10/0x10
> [   15.922000]  ret_from_fork+0x2f/0x50
> [   15.922193]  ? __pfx_kthread+0x10/0x10
> [   15.922395]  ret_from_fork_asm+0x1a/0x30
> [   15.922605]  </TASK>
> [   15.922723] Modules linked in:
> [   15.922890] CR2: 0000000000000000
> [   15.923072] ---[ end trace 0000000000000000 ]---
