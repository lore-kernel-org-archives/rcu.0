Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0B48CFC;
	Sun, 20 Apr 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745116827; cv=fail; b=qCOdFz6hAwo0h17XKBJkKcOnrVFPcJ6IMoqaDgDo15n0dGn7QjRNrPvpe0UuYlHkTTgaUpXbBXi/Ul3DmQL7QGLTsIp+GUT9HHn755w9wdtOQnDp6kj5CkInUlnyMHuDjisUwU2prBuEveL7CyAAKIqkSNsLKYTHCp/BFzzlEIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745116827; c=relaxed/simple;
	bh=+wSkTeW/DMsc/9QnqSJ0X+21JtCg+ujDUfSsI2fWYrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XF61uH6olPlAa3wK5AIPuYi03zTYNq5P3U5ucCiloUeoaaTyMZ9P4o4+VrECCRpvDWCMYsYqn1V1LUQg71OBc2tsjAGokswO/kNaogKKVvib6GM5lj7hX8txOAKymg142mmfuv4bbEW9bzoPeAeB4bpIj5QZiHKCM4oA7HCqS30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1Cq7RXv; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1Cq7RXv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQaP0Ua2J27qhvDdCkWAB6ocyD//EX5rX8BhItXMevsRY8xBcpIETTeAOL+2OY2ao5hz4sBBmXgkrrvkW/TaRw08skbDAzvzf0LaSUDi97XZN7jWzDKh8zxH29HgVNTvA/mAsnTty3NSar18jt3dT3hCd1abUV2ZtylzQt1KDMSVl62WyRtDKK/KgSmuADKyRI4SC9UM6Saanp1kKgi2lQNqJjBXPBXq66D6BCCdvSkyxN9Wk7hgUzU+dt2DMdLuc6HaPPFi7EaYm+EwRmlZv2CkyUvIuXi5vZNdTKH6jpwHOeEokEI1E9dgFA4FLJTDdvjBRV2DAfnV7LxUKIwmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFdnJKgHmHw5rbpa4wbAKUNcq1h7cBl6mZNDo5DzgD4=;
 b=opZ+4QjhIFLRxgisUAl6oPnavNuCZpnKmvhgLqENmw4uru8+BOWcOy+YVlmS4mqrrD36re+5qAs/THivtxkGHgeiae9ihuChQbLWd2NTb4xHSZkO8FWa5ZaYsWs7W+H0rWjM4i+ayuCRfpIvXBHlGnaDQfjKj9Epi22pO1jLc7KDtK+uSRdD/bhsIgzfuSYg/h87qeK1RmxutKjTPOpvEZGfCxrxLrYT2qNVvD0tSNp1zxoYLjFOEKbvXRxN7VjV0Fg4E7hjz4+Bw7jpR4b1+dPZvBP/zm0Zjh/v989AR36gGBDnqAI2elZL9pdVIFEBdnJKcPGD3LVSPVGlLVeebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFdnJKgHmHw5rbpa4wbAKUNcq1h7cBl6mZNDo5DzgD4=;
 b=p1Cq7RXvISS+SsYBbnlWUl4n3jqcrwBCL3ZO9Wd78GOD/HBkSMu5OYPYHvmTv380VdS1DdQCzvLoDB0aINsewTdpEX/7mTDtyDDOAQJMcI6HFl4d0f8t+m2O+jP+ZNSwFn44ss6UUrk+0MrnJ1F4ie7Upg30908p5fW9+vMkGQ2oH19LErHifFrnK3frb1t0ocj2goOQR4v8ltvOnPJtfXzhIa0pBTBKdq11A/a7SPltI+yGnrQ1Y62Th7NEJzUdaF1CoOY6/ADIZWCPKnMRYvG8ctArhHsx8WAYcw1UGtlggwoNHah1tk9gE9zU3VNaN0dd9QzdIo+b5Ee2neiBrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sun, 20 Apr
 2025 02:40:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Sun, 20 Apr 2025
 02:40:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of -&gt;gpwrap
Date: Sun, 20 Apr 2025 02:40:20 -0000
Message-ID: <174511682031.107.5797546463429118570@patchwork.local>
In-Reply-To: <9377c713-9a23-4ac3-ac2e-b5af105706a1@paulmck-laptop>
References: <9377c713-9a23-4ac3-ac2e-b5af105706a1@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: MN2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:208:23b::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e73c3ce-07a3-4a08-abce-08dd7fb4b242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RtRWRhSGY4S0ZreS9UamUzbnd0Q3FUVjdtUWF0SGVhbGNpNDNqNzJDQmZj?=
 =?utf-8?B?OHR0d3hXNTdPbk5vZHFRWUF3TjBSbjhGakdxUmJLRVRJSU5aSHNCR0JwRHhL?=
 =?utf-8?B?MDBLTyszVWc5K1NpcU00YVBIQVhOZWZCOHhXWEdFaGlaUUVJWnVjNG9yTFR0?=
 =?utf-8?B?WnN3MG9YN3lKK0Y3bHg2c2N2UmU1eUpvUUlmcHJ3MlE1c1dZS29hOGJYellZ?=
 =?utf-8?B?a2V3RW5oQks2VHVMdnRpZ2lzbWQvV2xwUHQ1c0FPMzJhV29pYThpcEZidWtH?=
 =?utf-8?B?dnNlYmhxWC9adS9oZk5yVWtSRXozOVdsanpYS2NlaGFlaVZjckczaGhmejBq?=
 =?utf-8?B?Mk00aGJXUms3RjZDaDkwd2tEZk5FNitCUWxWeWtGMmtKNmJYeUJMRkhHbWxF?=
 =?utf-8?B?QlIzVDBzbXIzRUlIVGZ2R0EwRFB6cDNBR01EbUtrUmlQMWkxRDVuVDVRL00v?=
 =?utf-8?B?aGRFQklvSHp1bXB4VWlvWEMwOThtVEM0QTlZMzdXNFdPWE16Mjh3SGpFb3BC?=
 =?utf-8?B?Tmx4WC9YbmpYblFNMHl3Qlc2aklSSHhDSmNPV2pLR05YTzZJZWFTTk5YN2JI?=
 =?utf-8?B?bXJwQUNiOXcwVkRvRDJ1TU0za3JCLzB0bzYxRGFWR0ZMVXlnelpEa0JuSCtx?=
 =?utf-8?B?OTFaMEt4cUNyem51ZXFtTDdtZGMrQUZUdVQ5RjZGYnZPalNZTE5TeCtjT2dO?=
 =?utf-8?B?clp3Wk9XbGxTZ3lmd1FjNHRQOXdyUWthSUZReEpxQ2twMDFnU24wZjJZcHov?=
 =?utf-8?B?VGIvb0NzTkw4SUxRUkFIZ2VkMzJsYVhEWGNFZ1pXRFhwWTE0TThCR1VETHJZ?=
 =?utf-8?B?aDlqSllDQ2hOTlVRRjQwb0phYjdvN2VNcDBTeHIwdmhHQ3Vpb3BpUW82a1pW?=
 =?utf-8?B?V0g0MHBtb3dRQWNHZTA3REtlQTdHR0d1dXhidDJkb3BucWNTVTJmVjc3QkZ1?=
 =?utf-8?B?eFM2aVVERldpSU5WZUVCbEpzRUtUcjRBRkdJUGFQUWhya2UyNURNWlE1Ui9P?=
 =?utf-8?B?ZE5DNmxMdFZZRzNiWFgxRjVaTzVLZlBvU3Z0VmtQanhYOFBDditxdDF5US9B?=
 =?utf-8?B?YTNvT25SY2hxdVRwT2lwUjJIR0xreDJza1paRjkxcnJSQ201a1RyUzV2eHgz?=
 =?utf-8?B?RHkzRWhrUWtwSnMxOTcrZDBKQ0JIdHEvaExPREVWNitySWVib2ZncklBK2Nq?=
 =?utf-8?B?djF2RCsvdFNubUs1UnRUSi9ZL00wRE9FdERNazM1SklqbjJpRkpDWERwWkZP?=
 =?utf-8?B?UWlKaXNUV25QRVI2MjF5TE5mb0xKcjFyZ0x6eW53RWZLQk9acE1LOVJNaEtM?=
 =?utf-8?B?bTdkOC9pdUZqVitISHJvckxjMWYxZDlZYXpOWkNVZm8zdXRGS3VObndnbmRm?=
 =?utf-8?B?MFE3cDIzVlhOVWxoTDhablljMHZZbysrcVhHS3dDYjNpMmEyNmMvVUNvNnc0?=
 =?utf-8?B?cGR3RVNmRGxlWHpQLzVPQzZWU3hlYllqSUJzWExaMHdoMUdvZXJKeGVDKzhr?=
 =?utf-8?B?WEFkMGhuTFpJQlR2TUhRemRDeGhTc0NZLzZLQnJWaGhQR2czdEtvOGttVmxV?=
 =?utf-8?B?RmJZdkdtakFHT0tkUU1VOC9sMFlXay9vTFN2a1RlUWNhSHJiWWo2RzlUR28w?=
 =?utf-8?B?WnhoYVl2aDRmYTJCYU5jTU9Mdis2djhnaXVtY09vMlF0MHVTVm84S1JKYy9F?=
 =?utf-8?B?QWRYa3VtazMzd25EMHBJZ3VTOUNVNllJNkFwSUhkcnQ4U2xOYUtTWnR3aG1r?=
 =?utf-8?B?MVVaMzlGSXgzOGtaSXBjVTB4UFlmOGt4eHhmUkhSWUxtSk4xVTg3eEF4SG00?=
 =?utf-8?B?eFgwZXpTTzd1K1NCOHZ0WXdidjRZVnFJUkYwRWI0TWJLVW5MUytTejhDeEZW?=
 =?utf-8?B?TUxrbE5CWU1CTEl6cjBpMndjMStjYlYrbVFmZEhUbHlEdENxc1JIWjdzV2Vz?=
 =?utf-8?Q?caRGga88mV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amp2L2ZVL1lXTTYxTmtTWmxWcHpNS3AzQnZKNlF0SnRPSUpEeU1pbnpSL0Ux?=
 =?utf-8?B?WGY2eHdPejh0UzJoeXJrUGVJRWplaGJDZmFEWDN3NUF2U3kxVmU2ajRiNDkz?=
 =?utf-8?B?b05EdWdub0NiSmdQdWF5WkFKcEx5QldOODc3RjFhaTA3bjA2OVZhT2xobFBG?=
 =?utf-8?B?NFVQMUczdHpESFBUa3NFRGlwc01Zb2FtOHcvRnQwSEREUVdnUHZ2aitqT2dO?=
 =?utf-8?B?U3ZBcnZJTEtzM3Z4ZmpmT0JzREFBemZhL2R2MUh2Zm9TZFZ0d1FlcE9Ed0U3?=
 =?utf-8?B?T1N5OFYrZEVHWXE4MHFqRGpTeFBRUmRRVzhrZHRoUGxCellTUTRySWNPWjV4?=
 =?utf-8?B?b2k5UFdjVVR4ajJkLysxTndZWEVneTJJT3FWYUl2Mzd4M1BySEF2djFiOCtX?=
 =?utf-8?B?YWRlUDhrS2tXZk9IUDZLOVBsazFBUW8rOS9wWU40UDdmSU93ejdnbG1KcVpS?=
 =?utf-8?B?dTNaMkt0MUI4ZkFmZktNUGVBSjlBdkVyTU9xR1JYdm13NVBNT2ZLRGJCTXpI?=
 =?utf-8?B?SkwxcCsvRWRzMnZGSkF0UEZtTG41MjlSWHVJUXYwOTR2R1p4ZDR2dWs5NGdO?=
 =?utf-8?B?VTc2WWZySWg4b0E1OTFaQk5tZDFOeXI2Q3UvUE42dXdtNTZzbk5XUngrMEky?=
 =?utf-8?B?eFAzRGRpZ0RLbUFxMDg2aE5OOVoxQXNEQVVRbVVhMjQvNVg3UWMzUHREeXpN?=
 =?utf-8?B?aGxsUURnbFJIYUR2TXVtL2wvTkpTa2hwdEZ5QjhmcDdDTW5ZN1U0dEplZERV?=
 =?utf-8?B?SmdFQk1xL2QyTTVSbTdidWF2Yk1UeWk1eU5XZjNlTC9rY2I2Rm1iV0RyYVZR?=
 =?utf-8?B?VFdJUGEzTFl2UEpYaWREVFlqYldmWGJNZGtJcnlOWW4wc1ZZYjZMb1pjbVZI?=
 =?utf-8?B?cGxiRFc4MGdzNUFCQkpmM2dHZFhwN0xxVThaZVZqaGlIU1RMOUlqajJMN0Vx?=
 =?utf-8?B?d3pKd1hHbTkxb0drTG1WVmk0enJZZjQvVVY1ZEQxYlVweEdxRDhWQUJEZFdj?=
 =?utf-8?B?L0RkWlFCWldabTJtSnBhM1dyVWxOc0tRSzhrZUNKbE5VNDVoRU9lWFVZZTJ1?=
 =?utf-8?B?Q2JXZkJsNk9RaVEwaEtmYUxET0VYb1NvUGxxdGwvRUdDbmxlYnpZN2xmVlFj?=
 =?utf-8?B?NjR0SzVJcFZ5L3dXZTVaVjBVZ1EwT3BuMnB5MEp3bE5qbW8wYUtJQitkK2Zv?=
 =?utf-8?B?V3VvcUZBVlNoMVJ3NHo2S01Tb1Yrc2RjbWtYWnB1U3dzakcvN3doVXRFODVO?=
 =?utf-8?B?ckhQQ0llRUgxK2JNOFpmekJXQ2hrZjZreklGc2FYcGpUVk10VXY0dVRRVDRy?=
 =?utf-8?B?RHN2d0dsd2h6L1Y0TTJkcnhpdkJuU1ZpKzlSaTB0c1pjY1VEM2d5Sk91aTZX?=
 =?utf-8?B?RWU4OE95RU9KdHI3WHZUY3hWNzNQbTd4QjJqVDFmbHN0WDhSSUtLaTJIQTNt?=
 =?utf-8?B?UnJhNGU0cVlJbHhzb01EdmVMVU9jSlVUVDd2RHdxT0UyU216QjhKMzJBelVS?=
 =?utf-8?B?cE1XejJxRTU5Sjdud2dza0gvOVQvN0xRTnJxRThqZW5maUppKzRsTXFlMVdj?=
 =?utf-8?B?RDZSWGE3aS9qQ21nLzZaaHU4Z2dhdVdDbXRjdGdiaDEySWFwTUZ4dmltbDZW?=
 =?utf-8?B?VkgxZnh4dU1lVmhHN2laVlNPZURsYVh0SGpjc291RXpVUTEwaTFiTld2dGdP?=
 =?utf-8?B?WTlKMk9CWjNVWXJld2RXWUN4UFJjT09Zd2JqWUl3MTJGZ2MzcW1ER21LZENq?=
 =?utf-8?B?UElKWXJQU3ZpUDdEUUlDcHFRRjB3b2xXN0Z2UGFPanlXdGI2YjRoV2FiR3V1?=
 =?utf-8?B?bDUvc3l4NmMyU1hQUW9rbEVCR0F6U1lFdjlYNndhUlIxbzI3NmFPcFdTTVJC?=
 =?utf-8?B?OHNDRThPU25MYVlZdnJLdHFJZ05iTVpoMjN2UVkvdWVFTENwV1ZiemJCTUtR?=
 =?utf-8?B?OFV5bEh3WDlEYXdCU25KczdBR2JuZDlUdnBXcEJJZFFxalZyKzlBTEsxWEZo?=
 =?utf-8?B?T25JejhLSE91Ymt6dlEwZHhUZDVoM2RBL3hVeklralpZYXJBZ01LeGQ3blFI?=
 =?utf-8?B?T25mUDJLdnB4bHQvTDhyVlpCbzJmeE5pL1Z3elBaVVhTaFYzVHI5S3Z2bWc4?=
 =?utf-8?Q?3bduqeoiapcTR0PiZ/lo/qfN7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e73c3ce-07a3-4a08-abce-08dd7fb4b242
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 02:40:21.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBRXL8RA5GqYoJ///2s/mRflIe2iD+eU3Qq/J3vYKMr/cQxsX4c5E/YNfkQrTp7yLZU2CF935YV6sAy8OTgT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

Hello, Paul,

On April 20, 2025, 12:21 a.m. UTC Paul E. McKenney wrote:
> On Wed, Apr 16, 2025 at 11:19:22AM +0000, Joel Fernandes wrote:
> > 
> > 
> > > On Apr 15, 2025, at 8:19 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Apr 14, 2025 at 11:05:45AM -0400, Joel Fernandes wrote:
> > >> On 4/10/2025 2:29 PM, Paul E. McKenney wrote:
> > >>>> +static int rcu_gpwrap_lag_init(void)
> > >>>> +{
> > >>>> +    if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> > >>>> +        pr_alert("rcu-torture: lag timing parameters must be positive\n");
> > >>>> +        return -EINVAL;
> > >>> When rcutorture is initiated by modprobe, this makes perfect sense.
> > >>> 
> > >>> But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> > >>> testing and do other testing but splat so that the bogus scripting can
> > >>> be fixed, (2) Force default values and splat as before, (3) Splat and
> > >>> halt the system.
> > >>> 
> > >>> The usual approach has been #1, but what makes sense in this case?
> > >> 
> > >> If the user deliberately tries to prevent the test, I am Ok with #3 which I
> > >> believe is the current behavior. But otherwise #1 is also Ok with me but I don't
> > >> feel strongly about doing that.
> > >> 
> > >> If we want to do #3, it will just involve changing the "return -EINVAL" to
> > >> "return 0" but also may need to be doing so only if RCU torture is a built-in.
> > >> 
> > >> IMO the current behavior is reasonable than adding more complexity for an
> > >> unusual case for a built-in?
> > > 
> > > The danger is that someone adjusts a scenario, accidentally disables
> > > *all* ->gpwrap testing during built-in tests (kvm.sh, kvm-remote,sh,
> > > and torture.sh), and nobody notices.  This has tripped me up in the
> > > past, hence the existing splats in rcutorture, but only for runs with
> > > built-in rcutorture.
> > 
> > But in the code we are discussing, we will splat with an error if either
> > parameter is set to 0?  Sorry if I missed something.
> 
> The idea would be to instead splat if the user requested a given type of
> testing, but that request conflicted with some other setting so that the
> user's request had to be refused.  If the user did not request a given
> type of testing (so that the corresponding parameter was zero), no splats.
> 
> Also, no splats of this type for modprobe (error return instead), rather,
> modprobe gets an error code in this case.
> 
> Or am I missing the point of your question?

No you are not missing anything. I just felt I already made the change you are
talking about because if user misconfigures the timing params, it will print an
error. But if you feel something is missing, I'd appreciate a prototype patch!

> > >> On the other hand if the issue is with providing the user with a way to disable
> > >> gpwrap testing, that should IMO be another parameter than setting the _mins
> > >> parameters to be 0. But I think we may not want this testing disabled since it
> > >> is already "self-disabled" for the first 25 miutes.
> > > 
> > > We do need a way of disabling the testing on long runs for fault-isolation
> > > purposes.
> > 
> > Thanks, I will add an option for this.

I still have to fix this, and will add it to the other fix we needed to make
because of the issue you found (kthread_should_stop() splat).

thanks,

 - Joel
