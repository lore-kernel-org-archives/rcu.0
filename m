Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDC43169;
	Fri,  2 May 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198789; cv=fail; b=it8vEYJCR8VJsT/Jgu9o0zhFn4r60h4FpaaeAUQfERvnijTA0pac4aJC9q75MeWuTtyWcBwNCiopTmGMGwHVvvGUnLfEsuBvzQvRcA5GFc5OwHsuTr+INvAVNHdoQKXj4yxOgjU8jH42g0esODY2Lxp8IoBHnW5OtFkMbSb5SoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198789; c=relaxed/simple;
	bh=d5l4XA8KbqMIzORI2JHNOIcsCFNdvXJ8O8+hloBrYt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IG/RBX/IiigRbelEb6SyBx0AA9DJIKm3ofpXLalHB4Qf/DdIie4/QAiDuW/t0begxYV1LvO8DSlOaSM2RKBREMgPa+202zPH8b5vm8fjY5NuUZK8q6g8Oiu/aL8uZvFsHDtK9aZahjgOZ+S8XYlh/i4FKNZGVMCgLOCI+e2NQ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBwRQH8I; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBwRQH8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNPL2I9zzi2CHVrCHYWFUCymBRwyb9l4MqqEh2L1TWlrXG9y+4hBu8k04nuQ2GBRDPLkA27Ka4jLuYbw9lGyrmgGg3qOxxaTxaAlSkv02Zb7MFPO1768WeXTu0nZe+KsQyu1BuzZSV4RgrhEe7BuIHMwqk2UKQ67rA1F0ZQ7NM4kEtrLc3fFszfoQtQ5hANhyzXZYdN4VgPEI71zEYRUWMflpODNbz/Rq+C6u/MpuxFUl/xZoqcnRn6Ld8o9MKRbYpb99fYoOzs/PKCYUbFFlCb2QAk3pC0m8PcxodqhAz84AoOUngBtaSfRzlCJS0GVrVkv2aHVGN00ZSDZMCmd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2q91cxWs0l2MGCmqD/M+iCNqwl+dKjDz059SnmR2Rw=;
 b=YSKjAu87rEsr0esUWRsKQVDJ05H5XpLGUT6PMIDgJC5zhIAJ5nosL/ZTz44mgOItsjof3TF8cHtU+BfpVVQM35wq0IBlm7oaBSkZ0emivaLkIdDc/IEY6Lscb8UffMzWiq86JExpP0flyFOLrLrGRGY5gwRFBNQ3hVDiWxNxUhhqN9xy4eP8A1rV7ypU2VFlmjqUUq42hBZh+MOCBtx+hGl/nFX06THOQ36RnVoeoidkB2h1hQCDs0QkbX+9kofNz/mb1q1xQf//IjY6yVGjTbSoKXdqu/ea4GsTvjWNqmZmuRFCur0OX64u7sGnS73jXZnXiZxW9hoFskqz6M0jfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2q91cxWs0l2MGCmqD/M+iCNqwl+dKjDz059SnmR2Rw=;
 b=mBwRQH8IvklWN1ywfYRY3z9ov0kG4VvsYGy5eUxhGPpqtCE2AwkrQnAADfjimabuoD7+ZyBnJ3j9EuwqJ0tnIaOM5PKf40rLtiR+wA3yvHg5RpnbFfZRl8A5BDhChP28rIc0LkgpbWQecSwn9vImcChl9k1DnURTVbY9qsakf2b90H6WTj7OcYc2h7gQJQtLmhtPIGeAQ//m3J+TxiZiK/ItdsrakVcEdhnGXpcOfJbSArbJIEeO7rP+8Q31l2wuVdsSP/qkvF45HRcl7+3Vesx99NjQpeIJNvZJHFElL/TQpvXFodhJi6Kyh1JNg0jvygY3spaDrNWBrN64pmSPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 15:13:04 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 15:13:03 +0000
Message-ID: <e05f04a5-9792-445f-9c53-3c3a1edfd370@nvidia.com>
Date: Fri, 2 May 2025 11:13:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250429100840.13917-1-frederic@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250429100840.13917-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0670.namprd03.prod.outlook.com
 (2603:10b6:408:10e::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: fe09f42e-1312-466a-f9b0-08dd898bd5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEs3czV4OTYwQk1Ra2doajI4aml5ZVA4U2d6a0EyQ3FCeWlOOGtHaVY2eXVw?=
 =?utf-8?B?R1p3U1VVYkYydlRsU0pGaGdKejBuKzlqVStIb0x1RzlQZ24vbWFiQzBSUm4y?=
 =?utf-8?B?VjJIb05GTTZkVzcwZHAvb2VsSW92QzhTV3FjZnJQakhKeTd4UGdQTHB2Yk1O?=
 =?utf-8?B?V0V3YytmcE5MV2RyYy9MelRXbDNWaTVRKy9BZjNSU0NkNVhFZHZxWUFRK3hW?=
 =?utf-8?B?SzNadS9kaVVQRko5dWloZWpBNEs1a0thU1VEMk00cy9tVEFOWUVEdU44VnU5?=
 =?utf-8?B?MWZnejlnN0J2cFJrR0tRNHFJN2U1M0FSQStqekpvZzFCWFNsaVJNNkV5YjN0?=
 =?utf-8?B?cHNXSTRQSWFPZ2tVdGp5UzNUODh4cUI1Qy9WaWpDbU9teFhCOHFxQVNoZita?=
 =?utf-8?B?bGYyUGN0OE9pRlJ1dm9yQk0zSkVnNDlJVENESUZ1K2tKK2Q0N3pDRDRoQVk2?=
 =?utf-8?B?eEZaaGdDUWZmbmxzczAzWkdLM0k3dVBlOFBiKzNlenFXaC82Y1NzZm8xU04x?=
 =?utf-8?B?QWMySytTRzFxd2hMZkRUVnZqRW9FMXBQbWRpV1lRdi9FTGV6SEF0cE8rZXVK?=
 =?utf-8?B?Wk5ubkFvVlQwQ1I5ak1JQ0NsVHU5VndjN3NaN2N1TnNsWUFZaXFLRnpOdUFZ?=
 =?utf-8?B?SjJGN1JFOGo4SGJPNFZwWEg0cU9IU3dGb1FFN0wvVFpVcjdmcGw0RnZJUE1r?=
 =?utf-8?B?dFlIdFRvbzVYWjdzdDRwYmp4bTZhaGtMYTB5dVo0TzNjdUlxdHQwV0I1Y0I3?=
 =?utf-8?B?UHoxQURRZG1IUkhyNjRDMEJSZ2xIV1BpSWpaVy9aOXZsUFF0OHNGSCtrZXZC?=
 =?utf-8?B?U0dxNFdrV2owYVZ3SWFlTEZvSUQzNWcyUHdzb21xUXZudFZHTlltVDVRcjJu?=
 =?utf-8?B?Z1FRV1IySG9PdlVpSjB4N21UdnBmZzB0aHBLNXBxeHB1UTUzN3IraGR2REtJ?=
 =?utf-8?B?a1JGNnA4eUpIaEVVNE9XM1VLTUFjTnlxdFRxUzFWbmRQVkdDbUwyS09uSlNt?=
 =?utf-8?B?NGlkM3U4YkxvTVNCS2pGcXF0YlBITDBKZ0xFTVlPNUdxWm4xb3lHckd5U20v?=
 =?utf-8?B?NkVNcVE3NmtXeFN4aVoxVHV2cHV0emQ2SFhVZXdmYVhKZ2pxT3pGbmg5dGMv?=
 =?utf-8?B?TTdwY2xFaXNIdm5QNUIrTEtCdzA5cVhudm9UUVlnUUVxQU9oSzVIeHI3aStT?=
 =?utf-8?B?d0h6Zmk1dG1GSGREOWo0SCt6VjdQdzIvRVFsbm5teXlZVjhYdVh5bkxjN09K?=
 =?utf-8?B?bHpJZUdHbFppN3gwbWx0RUhYS3B3TXNNclJ4dU9RRDZuQ0hIL0dBQktYNXpZ?=
 =?utf-8?B?TSthUUFyeG5HbjQyVkNnOGprMVU5NFpydU9OSGxBRXdORlFlU2JydkNNV2Qw?=
 =?utf-8?B?djlPME0vSmhvNnJTUmNXQTVyZGg0VVoyWlZOVmdNZmNRVnBIMVBjRElJb3J6?=
 =?utf-8?B?aWoxZmNGa1RSYlVkd2VDQTd0ODRYUWpNQW5XVEZXMFlRczUxOEpqZVRNaE1a?=
 =?utf-8?B?c3dBdUoxY0UwTnpkNHVKRGt0ZG8rZ1FwZTlEL2d0VnhkMlhlNDU4Y0wxZlhI?=
 =?utf-8?B?cDB6eHowSGJnREpaamhBTnJZeFd4TXAzUnN5dHVENGF6R0ZpTXZJQTUwZUQv?=
 =?utf-8?B?VFR0a3ovSGhsaWhiZXBLOWNSSmVINW82cU5uYmZZYjBhTTRhOExhVWNtU2xE?=
 =?utf-8?B?TUxCckd5MVpTNEdwQ3VQQ25QNUdldFlCbFV6Z0FpRk5OUkVYWmRDMzNtR3A3?=
 =?utf-8?B?VlBtNE5mUUs0eEIyMTl6ZndWc002dXZZZVRYTHNsWTBQQWdRbjZlZWFJcG8x?=
 =?utf-8?B?ZHBvRzh6UEdzTHEwV0p0SUtGajY5eWdMczFTMGtsTy9lLzJabS9Kd1Yyc0t3?=
 =?utf-8?B?OGZpblYxelJUN0hEOUFGNlV6M0VBNXQzYUJxNWlINlN4R1l1U1VNMUY4bXdy?=
 =?utf-8?Q?Z1YRx2sbECo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RwWWgrN3VDd3cxWTZIaG9mSXVUbWtWWTVrZWFqMnZpSnV5dDZweGVVcnNH?=
 =?utf-8?B?N09kaGx5V1hYN2I5YlhuWWt4TDNqV2VIRUU3RFU5S0lwOEpIWEx2bmt2azZ1?=
 =?utf-8?B?TzE1R2FVS2d3MDBsOXdnaTRGUWpxNDJjYU51dUVhaFVTY2xHS1pTdXNGOC9J?=
 =?utf-8?B?V1BBT0J0RW12NWVFZ2t6c2NySXloMDN1K2g2dU96ZUtNbG9sNlZRc1VjYWJt?=
 =?utf-8?B?YWlBR1JUWkNoZXZFMnNCdy9Oc3pORFc4MkliR0U1RmREckNNNUhpV3hlckhS?=
 =?utf-8?B?OGRRdEtQUWplalNUU1NjZHltVCt4VUxTRzhBdW9ZMW1STTAzVkFGVkRueG10?=
 =?utf-8?B?ZWhVaHZoRHNUU1U3ZktDR2dPSENGcWpiWlpWV1hwZUhVWUYvUHZVamZ2UVJm?=
 =?utf-8?B?S3RIYUhFY2ZYQXBtSnFldGtOZFRhTktUWGRHNTcvempLVEpxUGh2UDZObGxH?=
 =?utf-8?B?TitnWThzSkZqU1VvTE5PS1FUZklnVlZmemJ2L205UEFDQTF4aHRlU1crTFdq?=
 =?utf-8?B?b2d2VzNodkdJM3hyYVArRURuWFphY3MvMThHdTU1ZXdUbVhFWXhGaVB4TzBw?=
 =?utf-8?B?WncxcWxDTFQ3eDZMTGk4clIweHp0ZGpKQ1F4SE1NdW9aZ3VtNnUwOTdjdkVO?=
 =?utf-8?B?R2lWYzNoTm4yZWVHaFNud2ZmTE5iV2pmWTVlQ0hwZ01BR0o5Zkd2WXQ2cXNM?=
 =?utf-8?B?dU51Y1VJNHNPS2p2dWxYYVBPd3NtMmZIM2pOamRFV0Rhd1ZHb1BoSFpwK3c5?=
 =?utf-8?B?NHR0UmZ4OE00enNTcDdOY25NbThuRlBqdU5NOXV5eVFRL04yck9mMkFNcFVD?=
 =?utf-8?B?TDB3NW1uMVlZVmdrdjFDVTRSdG1MdllFS25vYXZ2d2FJNVRlb2EwWWVIVHhz?=
 =?utf-8?B?QndKRDVOblFXa3JtTEt4amhxK2pDVEozSGFrZStRcTNqQmgxLzN4aWtzYnd4?=
 =?utf-8?B?czE4dllFZ2M1WjZLeVpQY21qTmI1d2laSXZhb2xGNkJaR2xWWWVZNEk0OWNN?=
 =?utf-8?B?N05tSlh6WXpmeGpnL1pQcWt4WmYrSWRRdEJuaU5SRGt2SGZjWm9vWC9DWWRx?=
 =?utf-8?B?UW5KSXU1L0ZtYkRkelgwZjZKc2lSZlhsbTJiQ2pzR3dkSHlPRW1XdTdTZmZj?=
 =?utf-8?B?d1dTTGVoM0FBU2E3QjVNNURDcDJJdWNScHIxNERoVGtaVDlXUE5QNTdhY1Vz?=
 =?utf-8?B?VldYQ3pqUFJXU3FQMGVNK0RCV3BUNEdyaXZHY3JyVjcvall6MnlBK21kRFlJ?=
 =?utf-8?B?L0d1QVZPamR1bGI1YkVCbW1HMFdtYnJFd0MzV1BPc2lRK1I4U29tdmQrVVJK?=
 =?utf-8?B?ZWk1MVBaZGJJemllUWJSWi9jT2RMbE9BZENrcGx3S1YzaXpwQk1ZbFhnT01Y?=
 =?utf-8?B?YVNleVcvT1BmcWNIZTlCV0piR2Z4VVRhWFlDZzMxaGh4OC80bWxvKzZyY3VB?=
 =?utf-8?B?WkRMUVBUK1JRTUhoYWFpVkFXczIxMWpjcmtVSEpnN1U0MytaYm9MSSswQW1z?=
 =?utf-8?B?UmlYTnMzSHRtM0MwVjU1MVBjVk1EbHRINkhRNkFJQVdKUGxNNFBnQmFlM2lv?=
 =?utf-8?B?VEsxQTNlbkg4RW1QZmZtVW90a3luK095cm1PQmRIU2VEQWdrcDdzakF4Rmxl?=
 =?utf-8?B?N1ZtNE9xcFBxQ1BDbE1KdStkRmRzZitJREV5eTkvVFptUFRnUUJRa0Y5bC81?=
 =?utf-8?B?Wm5JZ3U2Q1V5RUEvZlh0cmxwQzd2RFdSYm14Ymd0VFpkRVZSbzdzWkhTNmV3?=
 =?utf-8?B?TmhTamVsY0prMzF4RFhCc1g4eTQ5MXVEMHkwYXc5SDYyZ2NINmIzdDE3VlVk?=
 =?utf-8?B?VXArMU9FakZLUEh3U3gvZW1ic1dRTmw5SWtGRE51a25QK2IwTk4vMUxpUit4?=
 =?utf-8?B?ZzJuRXpDNExGSXV5RCt0VkRmdXd5eUNUM2FKSWdBNkVVcGYxc2lHZVFqV3gv?=
 =?utf-8?B?VHREVmlWVzczcmpEemZ5QjVJQjFrQlVDTDdDcXNCa05zUDhTbVJ3T3pXdDRt?=
 =?utf-8?B?ZnBMSExGc0F2TURpWmxRa1FwQWlRUEhuWm9PVXZJMy9GQXNFdXNXczQvelZo?=
 =?utf-8?B?NlpRTG50aGVBdmMxTDFvNFVqYXhHQTI4Y29nd2xEZHhvcHpGVFhkYWtTa1Vz?=
 =?utf-8?Q?QwCdBlBuVy4SudsL0J7+/R6Gw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe09f42e-1312-466a-f9b0-08dd898bd5d2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:13:03.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnlI/L5O7mGKEZgRySLLsT57CEtL1FcjJp6LY7gsoFcp3CZ4nCxdLcAEmj0OdVxTisri3RfvQNphR8ZkkG09sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199



On 4/29/2025 6:08 AM, Frederic Weisbecker wrote:
> RCU relies on the context tracking nesting counter in order to determine
> if it is running in extended quiescent state.
> 
> However the context tracking nesting counter is not completely
> synchronized with the actual context tracking state:
> 
> * The nesting counter is set to 1 or incremented further _after_ the
>   actual state is set to RCU watching.
> 
> * The nesting counter is set to 0 or decremented further _before_ the
>   actual state is set to RCU not watching.
> 
> Therefore it is safe to assume that if ct_nesting() > 0, RCU is
> watching. But if ct_nesting() <= 0, RCU is not watching except for tiny
> windows.
> 
> This hasn't been a problem so far because rcu_is_cpu_rrupt_from_idle()
> has only been called from interrupts. However the code is confusing
> and abuses the role of the context tracking nesting counter while there
> are more accurate indicators available.
> 
> Clarify and robustify accordingly.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---

This seems like an important change but not urgent or fixing a bug, so I will
put it in my rcu/dev branch as well so it is easy for Neeraj to take.

thanks,

 - Joel

