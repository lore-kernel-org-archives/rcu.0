Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221F288A5;
	Fri, 28 Mar 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743129111; cv=fail; b=OXeveIVVtZ03+aDf5llUb97TOiVl7/sJuwn5sc/dM3E+2H8dgAsTZMXplrz95c54TRXJRG0RGZzC+GKLsUkJ9LckRAfR+yCvjNPevMGCpD0/IlVqzunXtpVRP78sGTIxwyQpFbH/btrEMxsIWbU6Cfk7IF9zJdPg2KxkrwzYbvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743129111; c=relaxed/simple;
	bh=BgR/S+FH3fG41BHsy9ND2e7TdR+NwurfXXp6vYm7obw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLMULSNeuJuaTevKu9+5FqJiwxQAUEUmEPt3dtpQmAgNkc2FtxiwL0NsIjIh5np6OIINZ7Gt4gdWbGqLPqK9BUIJ/u6vuUnqDqVXyEJiIrXr8I/2RNtpEqOikDiYWbrvU+B9T+W2isOn4HYtsxpmfE7M7f7sTyYcKDOPLOpPh8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNcEwUUq; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNcEwUUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLP45gOywF5jo5CeNZxQUgjn9aZ8nIkhGTLWWMQ6mYc3rsNPidNCr/SYncElRQRR5juonnEntMPpSlj4fuszsMKrxsknOZ5uB3ZldUVFjNQm4xH1SJ5ZwOzDAgbPGXRJngJ5Y6RmYI6dG8XGlo2kTu4TLjXLdK236El3h8aguToryMherf6hNBBL1YHW1JlaWhznGsvHMFdMXQDwLZfYQeTMFqyxzZO6IV5A8sMXncVd2/3iG0X1iu7ft29BDNcH+v2bAIaKWSuSa/LxWXLlmq3jyDUrt48Se73B9N4CWnoVipmHdHn4anbes1jsAhpgNNNKG489KMEeuufo8Bvztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL/8hbg6t0O+rYoMGEVbWUv/oGl5/ZVEsfvbYH6bqHY=;
 b=DJ6Mu+6JmpDcdVox2zSPPM0wQoDrjNcd/+mcwQdwayDvHOPnnL+HMb2b5kIrrjic+WTqRZOuEjF3fvI1Kue5hgPxy1xlEXFtsUSl9aRgbKjPM7cenE8s7tY52RpHlm+u9fRZYN2JxCy+FSf6y/TqnfCc4CkT+JSirddwocunwVDkYyKP8SEfjrb6zgYY+Ksg/kY976tEPc/HpsTAEUKk1G8AaAJAU6vCLAL05UwZNpb6ar6b12zt6rmVJC/CkqWUASO3Ksfp6Phl0NmzBaRvd9cj1hHRVcftokNqAbNAo12sxJcKPLT4k5eHPI/MBfyIRTSsjabjlBO4wuCaHTfCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL/8hbg6t0O+rYoMGEVbWUv/oGl5/ZVEsfvbYH6bqHY=;
 b=iNcEwUUqRH6Uwr3LKq11cbzbA/d7do1eUSyFht3e8a0YlK0F1Xir30Ql1iwiraVSndrnz0Dtcl2RiG4h2gfH3hKOEDqv/2GmO+fKCfK4t7mouGv9Or7MsV7S8O+JhZiGZg4IWsSLJOyMQklLMhDvawOJNQ/7ANHoo6bpRO67FWjSgUGaLSQi03+5zf9VS+cVFM8LAsPfwJpGz+R9HkuVmS+AaytrQp+45SE7J4ioiSWaoaC6cnzpGeGjMVosNbj7e64RmLS6WCfuP793M1/8EHh2mS8NIS0XG5IWhj3phrO/YD1riKLmMi5y8UIoFWZWrYABJHoMy1cDsT7NGbp/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 02:31:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 02:31:45 +0000
Message-ID: <919f17a3-2199-4c97-a1f8-5434098eb509@nvidia.com>
Date: Thu, 27 Mar 2025 22:31:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant in
 rcu_seq_done_exact()
To: paulmck@kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:408:70::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e77ca61-dc66-4baa-1b00-08dd6da0aecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGd3b2lvNll4ZXNGWVV3djVZN0VubDQ1K2xwK3BLa0V5b2FQeEVzeWg0MjI2?=
 =?utf-8?B?QUh6WTQ3MGs5QnJiVE9ZcU9MR0FUVHpzQUM1amVWN05kSldwZk5rQ2cxOHlT?=
 =?utf-8?B?eXNvMTlyc3FuZUlROXNldU9oUWM4eWsyNUFDYlhMNk4wcnd3UmJ2TXdBYlRi?=
 =?utf-8?B?YlNpbGtIWlh4cU9xTjlPaldKQzBSOE11U0JuLzZKZGFhZ3JCdVJUTmhtQ1kz?=
 =?utf-8?B?dUYrSGs2d1BzTTViMStOaXVXM2xOazhlRFRuVVV0ZktlbTZNbVo0c0Z1ay9q?=
 =?utf-8?B?R3pTNkhBY1BJL1BvTWcwb2FZVTd0UzRhanVRS2xHUUtmdUJTSW94V2FtM3F2?=
 =?utf-8?B?Vkk0STZiK3hHcG90RVJrMTRtSk5WVERRUDdLWjRmNFJRTnM3djdya2N2c2Iz?=
 =?utf-8?B?dWdxdkJjWTRkN2tUdzZUM0tQeGl3SEU1bkV4Rmt2SUtTMEpyOW11VXRGa1pl?=
 =?utf-8?B?VnBmblQyMXFjNmZuZndoTW5MU2xPQmFUMzNzenl4dXNxTy9PdlJkRlBKZ1hZ?=
 =?utf-8?B?aVo2aXNzRmU2V2NFOEhDcUpmS3MyMWNCdFpxMElsdUtMOER1aWF5MWk1ajJD?=
 =?utf-8?B?eDA4TWRHZ0M2Z0Y3dWtCdG9Fek5xbUovS3dVT0trV1QrWFRsSjNJWjNJbHMy?=
 =?utf-8?B?eXc1aGtDMkZhdC9vaExTUXh4andIZDR4eVJacVk2cVJ6eklGM0cwY3VGcmh0?=
 =?utf-8?B?S0FuRVV5N0dvWVN2Y0pDY0Y1QTJoMmlrMy8xRTFETHZmbDEweXZEa3BLY0Rh?=
 =?utf-8?B?dmJSTXR5NFdBNTljaGVwMmMvOTg2WlNLa0srSGdTQVBoTUM1Q3oyejlyVVls?=
 =?utf-8?B?QTlJY3llbVRkdGFrZmU5ejcrbkNCUDI2N1ZwUkk3a1grS0RSQlc2cUNCUk5H?=
 =?utf-8?B?ZjlVM0o3Q3hKU1lMOStxNlk1YzV5TEZ5OXA0a2kza0JsaEQxQWJWWStaVEEy?=
 =?utf-8?B?dUVnaTRWUHpTbXRJajM5TEpNNXRFT0psVW1wRHdweUwwNjNoM0ZWV1pGazZK?=
 =?utf-8?B?MHF2TUlCbGdVOXBzMktFNEluODI3ZlNuTXZLdENOZFJkRUFNcWNDSmY2WTQr?=
 =?utf-8?B?dHhYYm5tOVBCTmJDbVowZXBGTEs3anhZNmNWSFIvUzJkc2djZXVCMjBvUmZ5?=
 =?utf-8?B?c0lteXZES1p1SnFEei9zMFV5d01NcGpiUWRHcXc5bVp1T3ZCYlVxQmNrV2pY?=
 =?utf-8?B?eEtmWWJyQ1dlS2Q0UFpPSXVPMlFSbm0waExTQ2lndm5rYXhFRm82dGk1U2sr?=
 =?utf-8?B?bFhPaWQ2NjZYZ2E4a0JaQnFjWXZoWW5ic3ROc24xTzJENDdXWHdYUnJNR01w?=
 =?utf-8?B?K1UzbGM1M09mcGdLUVAvUGxMTk1USk5EeDhRUzV5MU11TXpQR21KSnB2Qm5j?=
 =?utf-8?B?VUx5dEJPRy9ham1aM3RKTkhjdDVEU3FUejRqM1BLcmQwS0RPbXNpRnVqZ0hy?=
 =?utf-8?B?djNETHhkSnFpKzMxYjhDcjV5WVZqbVpQNDc1RVN2OXVGZjlUSUpEY1ExeFk1?=
 =?utf-8?B?Z25TNE8vRG1VOUx6Qzc5WXZaRktJclIzcXE0Um5pZVE0SVFidEFQRzJmWDhW?=
 =?utf-8?B?NkEvQTIyVkFneFJPS25WZXltcTNVVDBRUjJ0bWsxV1ljdkpvQ0MyUlJsRGg0?=
 =?utf-8?B?bVNvVS9raFZEQnZ5blJ6UFBLWEV6MkJMSDRWalRGWHcvdUJmMU1nZWVlRmVt?=
 =?utf-8?B?TklIc0xtY1BVVlZZd2JhTE5jWEI1UUxaVFFBMnZacG9CMEYzajNSTXFvT0Z4?=
 =?utf-8?B?bXRSUDVqQzU2LzlmSkgyRDlIVkFxRGFpMlZkQWVyWlBMN0ZxejE1ZVNvMzhX?=
 =?utf-8?B?RlpSWWx5MDM3WDAyUHVBUHg3OHB5YnZURzdRem9IR3B0WlFiMkJWNlRRekhB?=
 =?utf-8?B?RXV3VUJ4SG1NRzd4VDU4dGlRRzhZTVR5RVk4amZzTG1GTkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dWUG9xWHI4VmFVZ3JWV3ZONkREVDdJNVZpTVZIV1ZrZDFWcktsbUkveGpT?=
 =?utf-8?B?Tkd4VGhKS3NaUGpCNkQ5RTd3dGk4S1EycDJPUmNpaTRTUU5hVEUwWldNOTly?=
 =?utf-8?B?ZzFldk9rNDNYZnQ3QzdtSnVzRnk4WmlnWTVUTWhmYy9qNS9BMndKRTM2UUZF?=
 =?utf-8?B?aldnRm90SHd3amw4U1hyck1ZMEd3MWJ0WW5wL3RSVE5BbXh2NlNZei9OSjNJ?=
 =?utf-8?B?OFdsVmpYZFcxL3lpbzlvcG5handZRGJ5U21VV3ZqQWtMRHlub2lFb0VGSkFW?=
 =?utf-8?B?ZHNZZ09FVXcrMndzY0s0a0NhenJmdndmbXhLMTVveENiOU9EMjNkRkx5bXkr?=
 =?utf-8?B?R2VkY2xGWkRlcnZiRTVLYllrakR2VWFVeEJ4RVltaVRvUm9zZW1BRFUwRmNq?=
 =?utf-8?B?eDdSS28xZU1MZUJqSHlwWXdxY2laRzEwYkRnemtwTVBNUWphQWFRMlFTQkFo?=
 =?utf-8?B?V3k0N0VDVmJqenp0THIxdXBDaEJtT2ZpYjdBRXV1QTZPQ3dBUWwzZXJiQWxo?=
 =?utf-8?B?dVRvVUdtTEEycVNiMmFkRzRjaXBWNE1ZMDVUS091R2NrL3lyeExlMUxnak5E?=
 =?utf-8?B?SEVNRWh6MXhMSk53c2NtWmFNRi9iVUk5ditxNEdCUXFLaVVQR0RqT3V5U2Nj?=
 =?utf-8?B?dS9WTWRhclBVbVp3RWZGOEMxTkhsNnl1VzJJNld0R293Q2NMOWM0eFlhcmp6?=
 =?utf-8?B?aFUyWHgwWWlPTTR5dG92S1U3TGFsNjVWNEhtaEkxK0NKM0IrODd6NEpOK3lI?=
 =?utf-8?B?a1dvSkh5c0JLdEVIUEpxdWJkKzVlenhFWEp5T3V2QzZDOU1ZZ2dHbXpoSTFi?=
 =?utf-8?B?VGVyWWV1T2lwQjQzYnpMT1o2ZDFLaU9uL01WYnJvN0VPakdSZ2pXVFNPcmhw?=
 =?utf-8?B?dU5pUTVtTlJFV08xcFdJN09hZXh4Nm9WRjVzK3R5QXVENHZ2RG41cXhSV2F0?=
 =?utf-8?B?VVB6VDRZSExFT2tnNmUwWVZIeGFuWFNLZWp5MjVJajkrWTk1OW1FN2QvUVVu?=
 =?utf-8?B?dHl5bWs3OVM3TWhXUjhjWWF4ajB2TU45Z1RyWjFaa1V6R202enVPVVZuUGdz?=
 =?utf-8?B?dU01WHR0SU5heU8rV1MrYS90bW0zbWpFRTFjbWoxWjF1K1NGdW1yV2VadmtR?=
 =?utf-8?B?RUl2RVgyY3lCY1ltek5qczBBTTlJUDhCdjJ4OWtEdGxibU84cDJUSmczVnNr?=
 =?utf-8?B?bHQxNVUzY0xiRTNhK2N0QVMzckhRVW5XSTkya05SUU1zTkx4anJIeldPMjVV?=
 =?utf-8?B?RzVTMklNaGVSYnhGMVdxVjB3OXlqNE11Nm9YckFJRlFvZVRCVEhKODZPd1ZN?=
 =?utf-8?B?V090V1JmUFUyUHk3TWJBTElaSXoxVWRBOStqTFRwVnFYWW1VVGt2ZWNGZmpV?=
 =?utf-8?B?bCt6RHVSTHlwNFpjOWptcEFGYWowNkhxUnZLSVhGVGNjQ0lBWFFEU3dzWGt4?=
 =?utf-8?B?SitONkM4bXhnL2syZ002STBlcUFVRVhWZjhYSHEyQmE1OCtmNTl3bkFNT1k1?=
 =?utf-8?B?TGdqalUzVnVscEZHOXZtWmlFQ3BVK0k0RnNiRlN5Qm5jMUNxWkdFWVBwUjBm?=
 =?utf-8?B?TVJtNFNKUC8vbmIwNUtVZURjZy8rTGU1OGVGaExJVUxHL2QvZFlzMGRvOG1o?=
 =?utf-8?B?THJ3S0VpM2Q2TjkrSlVBZFI1b2xXc2x1eEMreUFuYjdoNEVxemx4bVk4TE9X?=
 =?utf-8?B?b2Z6d0xmYjhwVHovbEs5dm0zZkswMzE0K24rVXNVU1lwV0lnU05GSm5rWDls?=
 =?utf-8?B?Y2ZxWmlhemRLZ2dYdjBiNEJnVDlGU216VzhtdkpGWjROYUFteGtvMGtCb3lM?=
 =?utf-8?B?N1laU1FpVi9PZFNrajNiUTRib3BZaFc4NjN5M0FSc1RxWjlELzRaWGVtU2tj?=
 =?utf-8?B?UVZSbHF6MXlNdE1JeXN4djNva0liMGk1cHZHOXdnR1NUTmRhclNzREFVdFRx?=
 =?utf-8?B?cjcycjRYSlUveXVwbUpZKzlNelBwbW5DcUdyOEhOdGdxLzh5d3JtcWRldFE1?=
 =?utf-8?B?Y0hrN0dNdjQzbjh0bjZoNWNOdXhkalZSTUo1MC9sRlordUoxNnpMeWVKa25p?=
 =?utf-8?B?c1RyaGV2QytEWWJLM1ZUV1gyK0dnT09PaU5zUnIwbC9TQ25rTVdqZ2hWTkxO?=
 =?utf-8?Q?Wts/6wWLdNqe+Lj0yFM5sZOjM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e77ca61-dc66-4baa-1b00-08dd6da0aecc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 02:31:45.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GlHdtj9B2+aaJH0QNWroKZ9pRAyjsNpzDCyuQq2dNNg/M+FXwjLqlMbp3lfN2ds7VLJbHmKfqEqWCgVcf03pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524



On 3/27/2025 1:09 PM, Paul E. McKenney wrote:
>>> In contrast, making the guard band a bit longer than it needs to be
>>> has little or no downside.
>> Making it 3 GP instead of 2 should be ok with me as long as we document it but at least it will not be a magic number based on an equation. I feel we should not put random magic numbers which is more dangerous since it is hard to explain (and hence debug — just my 2 cents).
> Apologies, I was getting ahead of us on this one.
> 
> That third (and maybe also a fourth) grace period becomes important if
> we start getting memory contention on rcu_state.gp_seq, in which case
> we would want the polled grace periods to look at the leaf rcu_node
> structure's gp_seq, which would introduce extra slop.

Makes sense.

> For now, for this patch, assuming you guys promise to remember this
> should such memory contention prove problematic:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks! Will add the tag.

 - Joel

