Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D461EFF9C;
	Fri, 11 Apr 2025 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349801; cv=fail; b=qg3PMtgDoKx3shUY8NBSx2C2eDb8B0tolbdYTBloaa0StAl6AIjNsL74oUsfqVkMlpAB+qRS5qwXGUopSjPrj0d/drw3RUMEtaDK+THmKJZt9i+fd/oRd4mYoovwi0vg6vhTWHC43L6PPkPbkZ3wlwjK5D8Ak2mYkFdXLse7xvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349801; c=relaxed/simple;
	bh=4B5pdIGGFjd60eshrym5EaPW5I9keHSAL7vraZUGq8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bo0ZWKyhZBuDmlcYNYN+XsakQ8Fj7YFLvWErCkG9UfP2FwLFtXsLVrNe1uPmSsxKYR8izyf/ICUtQsMeEfBD9JkEKk8LKX0SuWC38JReC3J0V47d91X+ieHQQ9w+zTjOX7Zs4TSo3+GbDyyS1C2QXnD6A9TxUhQVVrehNPnUtBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHeXzAXz; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHeXzAXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5+7GzmcBU9WNvw2Pec4trXkkbZTP9ePK93RnZHsK0lQqu05MGLnMbQaQRxo4qiVoucB/pMdp2NlJBnIBthsHlJIaT3huAauKLXMhrXqZQX5VPYHVSrDOFizQU/WQVBRQx8XzYGe/WKP7OWqoBrpNuQIv4NqMVC7jrRxqYr22aubcZkSqzGezilG6E/wtXpU+dlP0oOr5MC/tcL0l7RG6Kltn4KoEwSplPtho5tGgofcN5xh+3PiVXWZUzk3mYu2nmbmaMl5yTL9oFQmv26Cz9KaODeVJ4VMY6oXn+Q4vc7VTXHzbpzyk2qKNQ6RWuRitGABAuGlJ7LC6liQchRHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVYx11IraA3sujim3LqzCmZRH04Njw6dxm4zd70kAyw=;
 b=FOyZLQINun5kQx/5RbKfToau4y68h5xZ5PJw1IJvEIf31aUkb+GHS5/l3O3ysGAcuCLCZ1UMsW1k/2OVw1UgrJ0fBZc7gIeNjJZrMD0+IBJN1B2DCLVXHyourv1mOWtjJyGfqJD+RrdKj92MH39ByERGv33jAvX/TjYWb6w8+wboiy4lnR8SEJcEc1OfdS6yp5lyyjSq7wXoqtBhElNBCfU3BJK9SuvsaBoUklcq9A1bFoU5A7+jXYYJObzbMY58FOFmyOeI2yWwH8hUW013sFoXJnr9UOi0v0kgsOHCqEKYj2V6vu5bvyPWpKDoaNOqA6nGWBsJmdlY9ecGewoCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVYx11IraA3sujim3LqzCmZRH04Njw6dxm4zd70kAyw=;
 b=mHeXzAXzHvRwXU7vuVICSUiwFjhzQx6IjFhVeEOG+bxOMRQJXYF4UXmG+W8meiEmeAJqKs8txQs09FvPJ0m9hZ3pzxzfjJyyumAy0Z2jEcUKBRFaPgIsoZLm6qg1kwji9kavvsmD74tQRRq+2MfPg3lDXgN2e1Qr11x67kh8HuPInFmr2ZHrfPUs6SauOa7cdebB0ZscGlGuIoRjRrL6k5UP6m6igU2yGMFJqcSGsNHWzwAoaVtjq6af5kNfed61eaMRb/Fvp46lG8vzJ+m0y18zTghcaTY0XELLLRLOwKtwRWGg8hWuaZb2hAFxlZ2Aztc6pc7kX/Aa4K7QSgXrkw==
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
 05:36:35 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Fri, 11 Apr 2025 05:36:32 -0000
Message-ID: <174434979260.108.10046690878441100792@patchwork.local>
In-Reply-To: <78c902f2-3b01-49ce-85c0-3c748fa43224@paulmck-laptop>
References: <78c902f2-3b01-49ce-85c0-3c748fa43224@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 24781557-78fe-427a-2de3-08dd78bad2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eExBMW1ZMDlFVGd2REpmdDVjWEpDN29tTHJOeGU2M2sxd0NaUmNPQkpvUFFW?=
 =?utf-8?B?RC8rZ1dwNWhRTmppdWM3WVdrejVlQzZybWs4YklSL0ZjdFpNQ29XTXYyZnFn?=
 =?utf-8?B?MUlPTXRsZGtNUEJ0WlBmUHNveWh0azdYak5PQXl3eTZEaVA1bFkxOUdWSWxw?=
 =?utf-8?B?TkIraGZFYWppaTk5elluZ3pveWcvRzVNbTJxUzdtV1VoY0VOM1lDSkZwRW5B?=
 =?utf-8?B?Nmw0SUVZeC9lU1Z1eUpWQmIva1ptVTlQNnMwcnBCUWpZYmZkR2hDNnkrbzIx?=
 =?utf-8?B?bFpndmJUckFiUTVscnZTWkRVbWFzYTdsb0Q2VTFSRXJmbkZubDRIdjRzbis5?=
 =?utf-8?B?K0tOUTF5YzI1bElKQjR2Wk5UQ2dQSWZ0RkIzTmRnci93d2xySGRlakpQS1k4?=
 =?utf-8?B?ak1LTWUyL0ZaKzVCN3IzMW9YVll6Rythamd4S0w4aU9oenhIRjhROHMvNnJF?=
 =?utf-8?B?ODd4WkIzcDd3b3pRSVRQczNhaENBc0s0eGVwclgyM1hubWEwNGxCY0xRVWZ5?=
 =?utf-8?B?N1BLcFpEazE0Q3ljZEd0M2JNbnQ3MjlsQWNRQ20xOGZsYkltMjdSQ2ZWSVdX?=
 =?utf-8?B?SU1qdTBTcUpHc1Q4cktSblZTRmRvUUtpN0k1TUZqWXJqamtwWWxFOGh5cHpI?=
 =?utf-8?B?NWxmdTRpaFBvVjF1bE1TUmd2S3BuY0JXdEZHVHUrdUZmZnI0SmtSVzdtUVNG?=
 =?utf-8?B?dTBIV3hzMHNxcjd0QmxOS005dEpEdDN1WTQrdWlwc251VWF0VzFMQ2t0ZkMz?=
 =?utf-8?B?cEVqanRDNU1qb044TzkyZjhSakw5c09sRHVsczRBbWRZMG93QVRKWVRuWVh5?=
 =?utf-8?B?aldSV2NQcVU3VDlrTDZBOVYwcFRsMGtYTTlBcUwvTXFhNXQyUjEydTZZU3RW?=
 =?utf-8?B?RFdCc2JYbnZhZUZ4T3RkM1lENC9XWlJHOVZyb0trMS9iaUFpNE56OWo3N2Fn?=
 =?utf-8?B?MVNNdFQ1UVEvVm9ST3BLN0RlK3VEaW9PaW9jUGJhV1JIaUtpRmlnM210a1k0?=
 =?utf-8?B?REtTMXFqZGJINE8yZDUwQ3RGOVJHTEg2Smp2c3NsQU1PNnFITlUrM20rSkV6?=
 =?utf-8?B?Z20rNDlZTUpmcGE1cTJQVEd4eHB2Vno3a2MrMkxzYk5rUUZmZmRsN092dUxE?=
 =?utf-8?B?akE4VnRVY3NZQU9wMDhKTk5ienVWNzNqSm9nSHJ2b0JWUVpsaWMxZnJtemg3?=
 =?utf-8?B?QW9jS0p5bkVLL0txNE5jdDNmRWdGc3l3dXlEZTV5YkhRL2lQek5wYStONVJz?=
 =?utf-8?B?RkUzRkJMdDBtblVYMW13Z3luTTlOMU9pclQ2RFJKcHJUZGlOcW51UXIramQ3?=
 =?utf-8?B?UndlZFd2QTZQT2s2R0dKTjQ1Qk1neStnU3VvR0o5akhPZUViTm5VQTJCdVYy?=
 =?utf-8?B?eEpVaXl2YU51K1IyaVk0ZkxOTnZvUXo4MW1PL3A1S0xydlN2bmdPRXdHVDRG?=
 =?utf-8?B?eDdieWRCTjlHeGNiaVFsZDdGVmk5VGl1QnNydm9aVDBPSnIvam9GczQ2SlJ4?=
 =?utf-8?B?ekRMZDZHTTJnUkRGamJoYjR5T0JBQzRrZXJJZWtaOWxqcHZDbFN6VVR4U01M?=
 =?utf-8?B?K01MQzBYd3RGNVJuMFh4MFZ3NFRhVk1hY3YvWUw4eWhNaWRsYkZaZVlmOHpj?=
 =?utf-8?B?cXRMbXJJdkZqRmdnS1lDWHNBTEhsaVlVamVjNjFNc01QVmdJcWh6TENtbDRI?=
 =?utf-8?B?OGs1bThFb1RVdElTYktQTUM0Z05oV0FZK0lvUWUxamRXMVQ3YVdBWmRqbStD?=
 =?utf-8?B?WTNtRG9RZW5JSEd5R0ZpZFVEaUN3ajJUNkVDbFliQ1ZzMThURlBoMFFibjdh?=
 =?utf-8?B?Q3EwdmU0QUJjMEh3NmV2ZEhQMEJaaWJiWW5FZkZjVi9mMjNTcWpQaFNOZTlO?=
 =?utf-8?B?VGpYaWppY2NIQ1N6Y0pUWmI5SzZDUzV6OCs2RWdNRU1KalZVVWF2QnpWQ05W?=
 =?utf-8?Q?JAkE0F7gCbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2JtL1luL3FjMVBiZUFJTmlhaFY5UGpEbEJmaEVyblN2eS90bWM2MmtpWGoy?=
 =?utf-8?B?ZUpJLzNDYnJUaDFZNjZTN0FteVJiOFZ0RVhMY2pkdVk2VnVrK0lUa0pDczQx?=
 =?utf-8?B?c25wUldGWjRkSEJTWkNNNzNtV3RkMXVCUXdYbkdoWlhBSXo5V3lLL2N6dnJz?=
 =?utf-8?B?cnpsakl1Zi9wK2RTMUxGRGF4cnlwRDVFc3U3aU8rOXZRVkpQOFF6Y2VHRS9o?=
 =?utf-8?B?d2lUc0VxaEF4dTgrRFhHTlJ2QnVJdlVsNWFqdy8ybGw4UW9kR0plZ2gvMVVK?=
 =?utf-8?B?VTEwS0xDQW5VT2l4a0ZtR3hVcmhOK1ljWHhnSWFiVzBvKy93enMxZ3BXclVZ?=
 =?utf-8?B?YlF1OXh4SFFPaG45YnBDdlJOcmErSGhTRk5Uajc1a0tYdU9RRVVzbzFESTJx?=
 =?utf-8?B?MktwbjNyQTB3bUVUUGM1MDBTY2tWRk1iNittSG5CaWlvSkI2TFNzYVpIYVdn?=
 =?utf-8?B?aC9TdThiYzN4a2M0YVhhWUI0bk9JRkUzVVFzSXd4Rk00UGxLWU1XR1A3RU0z?=
 =?utf-8?B?SlZjWmw0b0duYjZjMTFwbHZHbkNnVWFjVnlWWEZoRFlqRW0zejVyNTIzMFNS?=
 =?utf-8?B?Y25UN3BzQ3FFQmtsRzhPVmZsbHUzaTVWKzhyVkh4dlVWWGlCODNodGFkcFhx?=
 =?utf-8?B?ZERUeTFac2gvb29IZjZXUzdSKzNneTd5T3RRby9mUllWYVNCZFM5K0VtVUJB?=
 =?utf-8?B?emhyT2ZLS2dtSDVVUStGZFgwZnVSdDRlSUZWdWtnY29pRmJudjgwb3BEZHZp?=
 =?utf-8?B?SXNVcGVlcFhxdVRYS3RwZGVyNHIwOFVtbkFGS0E5cXpCMWpKekxYdG9MNlcz?=
 =?utf-8?B?a2QxcW1CaDFzZ1FsWWVYTmFIWlA3T3VwemsvLzg2VWJzQXQzMkR5Mk5hMlJD?=
 =?utf-8?B?RVB1L1VBNnpFelR1WGw2UmhBd1A3SXViOHMvbXpyYjB4MEcwckMrcWVXeXJa?=
 =?utf-8?B?bmVNVjBEdzM4cmtTNFJpVGRTQnRjRmFrYlBhVW5Kcko5RWN1YzJZU09KcVRu?=
 =?utf-8?B?ZUNvQmZoVEt3ZU9MS2daZVBRWnRFU0lrSnhJekpTYnBiYVNEai84UjVRbjc1?=
 =?utf-8?B?WXRmVDZvSXJPM0djYW80b2F0eWtBS0NtSFFhV09jcGU0WXBuNjNSRUgrVFhU?=
 =?utf-8?B?Vmt0RnpIeDZLWWRNRmYxZmxTNExYblF4b0N2SXFVQm9taTdINWVNenNHOXBT?=
 =?utf-8?B?N3E5cllEZmJ6aHdWUHdoV0k4R0JIM3F3aVM0WWR1ZU1qbDdLVTBmRUY5cnZm?=
 =?utf-8?B?allYR0s5ME5HWG01aVR1VDBhOHR0bjFWb1QwakVFNnZ0Y3lXR1N3UDNvZzU5?=
 =?utf-8?B?ZUN1RzV3cVA2RVZYRnQvVloxbWlFUFJ0SENSeHc5TUszYU9XdG1Va2srYm5V?=
 =?utf-8?B?TXYxSXhnNXJtRkQwSWpGckNvY2F1WHFPMVc0OFY0ME5Ha1N3MnRNRDl4OVFW?=
 =?utf-8?B?MEdScTBRNzdFZGdxQ1pTSkJSZjc5TTVIUW9YSHFNQjhGWXJwR1lQMlU3MzVh?=
 =?utf-8?B?YnA4c3FCWmRhcWJFVUJrVVQ0MElSRUx1VlQ0ekNjd3ZzZ1AyU2xXWGwyeCtl?=
 =?utf-8?B?ZEY3d0FhS2FidGdVelVNUDQrTEF6SmVmQi9XdXhZWDhqR1V1azljWURSZFY5?=
 =?utf-8?B?SU1jMlB3azU2UGh1RE1meTRLcUJRSFFYb09iVGgvQ3djSVJST1JOamYyVWpD?=
 =?utf-8?B?b2NRNHROa21RalhheWFWSEtxOVZqSWxFZG5Cb0xtUVhhRTZ2WHJ6a1JIYThj?=
 =?utf-8?B?RXE1NmpPRFFVY0ZyMUNhYlJPNnFtdGo1NWQ4QlZ3OXU2NzNWUDJ6Vm5QdE5j?=
 =?utf-8?B?OEs5d2dabldENDZjY1hORTdwZlhMZEQzVzlwdnRTZ3JlSHhEZE5JTGhSWGl3?=
 =?utf-8?B?N2lMcHgvT3VVdFNUZXpBSnBkOGdXcVF0S0xzaDhHUlZoUTF3akhPNjB4eSt5?=
 =?utf-8?B?cVRzWU11ckFvZ3NyUHFSMk5SNzl2VWp6azlCWmoxeDlJZzU2Nk9lbUkvenlD?=
 =?utf-8?B?NGFVWC9lSmRSYXRWM1FCd0JoVlhjUG1JYVFuMnpjQWtkWk8rTU1BSmNSczdq?=
 =?utf-8?B?UTBXdE9DN0pXdWVqcTdTb0hOaFdzaW5sd0VsTmoxZzBQeWR4VTVnRWV2WC9B?=
 =?utf-8?B?a0U0L3NEc0QzNnNzazc5N1hnN1BwOG5NT3Y5YzZ3TVB2NUVlcGFhSkZWQUlG?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24781557-78fe-427a-2de3-08dd78bad2db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:36:35.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSpKvHjJYIdgbCIQAUAFQUAH/2xabakNYYnxEoHswchwzfHOKxz2jbZtUI6H1hxquoH8m9KwB0PAsr/jdEvmqA==
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
