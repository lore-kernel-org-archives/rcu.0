Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3421DF26B;
	Tue, 11 Mar 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659881; cv=fail; b=PilCwup63NgrlR5rAPCdVneDfyETrDi3dlMtN9yn9FMFnNvWTUOgJMTc/cAcMEIKl7/14ckXsJbrYb0aoittNxNWSVegnB4f0whs8D9Kkq1Nm78C5MJZqd7uZ54GO3ZDEF6zNgVYEBuMi2O3ihtGqFqHjLLYB6UqBN1f0Xt/GvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659881; c=relaxed/simple;
	bh=Gu4evKDdBUumwbuyUPsADyCjug3bZ91Prl1tFp2tDSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SbsLUOOH+TxsNE4t1//XJteJeyAl97kSfkMM7ro5+13++/KWR7EH+xRu1+wG0LKZPuxOrRX866/xRyb/L+8tY4d0SKGuOcTbZNiChT6IwTdr0Vgs4JtEhaM9VG8y2/buM3C0/U0tpdSUrzP9/z8C8XOGvs3Pl8scB9LkyysuAhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJBjXV4e; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJBjXV4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xl5mudrtQbLzElz6zGVctICuZ7CQqf4Hs9630Vh6b5vHZK2ex7as55uk/LN4b6Yq5bNMC9DwXzg/7Z6K1W5hL5T892OdF3h75+6nhrtTyvMhT9zo5tH2AfkA9EDrEOch0gOGe5ofh0JAmzz0MjsRI4XKY0miFuT4e30e7eY4t/S+M/N61jqpOXY3rcqTbx5PIMq+W9EttQjcu7e2AQpEcOr9hX56vD5BzGf1ws1gvYH/fHx/pcIWnx1IewCTAYQ1szgsrpsQ3i/EXvP41tmktoMS2QyAuM6d10NTXhdbPgnd6nk3L2qEXVwmavHB9mbUGmRU+tgNZzHnLwfZeZtTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK2XNjO7wPT9wqj0RvhPjgdQsQHi50TyEzXT1AW+m4M=;
 b=LBoIR54TMwG1GEbDGiKSxssF5jEGZAeZhY0DdlsfdW/htrFJKRx2jGtr66va1JHXTfR5ZWQzSCAoCDdto8//bohQkgyep5tt3r1Uj4lTyAgPCtq8LyjA1B3cspmUgxRfL+l8TJlS0jJt1wEeR6oJKPrODOdFaj/3EJgVlIDRozBlHB1BWo/ZxBxlqYGu4/Uq95ViFDugeyp1SpMe4TQha3w14CnLxhQrn/sCNud8ZSZ0BSQSvBY7SDaavNQamV5u7wyN+UWvoPAseUyTi9PRF5yIvFplRsb2ox5lZeF4W5q2Q0XymGvQkZf2qi2ML1ORx+gNgPMsj3lRNsxMsVonCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK2XNjO7wPT9wqj0RvhPjgdQsQHi50TyEzXT1AW+m4M=;
 b=kJBjXV4eeeMKtBOH+riNytflgjCucNR643WXs+EtxwZGU/ZMMEJv/ffVsGdZ3bEObe0AhP1TR3NoKxSvsX/DARqVmGtkOgXgH6F8tQQcaAMbRuO+DfHB0tEca1w3u0/mDR+vXqOpThdyzPZWj1Vkj2NyrjAChnp4IRdvb4qbOISrVT0c3Hy31nq5zJiQVrq4z8hotHpHyvBbCdYc77Ua50KBSSAYur8Rw0ZHsOM/9c8G9zsRR6tzOE2NFa8+MClvNyJnCyNH4cwnYlHzqVx9FaCn7JDVVyVr/WgjK3qS+VQmOwHGb61FkTzU56zCQ5xCFtLDQPryU4KZkU8KG593jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:24:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 02:24:37 +0000
Date: Mon, 10 Mar 2025 22:24:35 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/9] RCU torture-test changes for v6.16
Message-ID: <20250311022435.GB376174@joelnvbox>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
X-ClientProxiedBy: BN9PR03CA0894.namprd03.prod.outlook.com
 (2603:10b6:408:13c::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: b8338fe6-4454-4bfa-985d-08dd6043de89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNo1sskyTD9S//bHTtT329ozseelE+5hrjW/kfRvmnp7HfLxxmVJRxglAdNE?=
 =?us-ascii?Q?4rVJnvxUWTkJDAb1n5Wd151Q/gf+CU1/zxiPvFhN90VvAqsDYC/hBMVUlmfC?=
 =?us-ascii?Q?yzu1WF4yJqHglc7Pz6OaM0pnDI1DbBGSDfcUQW8PEn+ZJQ3mqXErxg2yRvfI?=
 =?us-ascii?Q?dQag5F1bkWs/km28t1dDPCmYeccWsJIijPhE3s/dEbRY3lTnT0VPFPJ5bFfv?=
 =?us-ascii?Q?MfoRoy1dV4moitCZ9iVT/F/vSEsgbXJqkT/VClJmFq4zdcye3jx6/ixblD0U?=
 =?us-ascii?Q?dcEHkHHDcrQXGAnw+5QD5yhDkPAJEkM44ZjfyuPX8lfmj7yQWVfaG6i/QRCd?=
 =?us-ascii?Q?NV0aTCXdKGoaamfZmGA/27kJwn71BsBk/2WHds+a9iCDsa+kjrlFPbuhk4FB?=
 =?us-ascii?Q?Lea+Xdqnn0Ct5yLKNYx2BQGIMrPzFQnrEf/L4wSKi/5J8/UO57R4+0+5apoP?=
 =?us-ascii?Q?dTtB+3QNocH2turia1p2EDDwKIEB8DNsW+3vJJRDk/uwEz/ebta6pRpuLv30?=
 =?us-ascii?Q?BQmqf5wEOUEqFS2GUu4D0PMAiUEDeHRNyoGzrb95Lvj1RhXVmNdiFyPxtunM?=
 =?us-ascii?Q?qjJH9GQM4AvN6S+MZt2+mWPBKBn3Wd697oF9Yjw2Vfveah+8CN48hnBU1nRM?=
 =?us-ascii?Q?NIi1nR+k1+42GNy7UWW39tQmL9aOtd3LthQefqR/fFn4rnqFLsP+dlDzprNV?=
 =?us-ascii?Q?7rQ40WkcwkmNQW924yBe52QPgYL+OcXPYrUmE1vur727Y2stD6kQLeVrIGoa?=
 =?us-ascii?Q?70biU7UAMi125mP2ixGot98xGqOi4yxnb98BoN2Q/xPqxvHz4IlrGOv0rBEH?=
 =?us-ascii?Q?6l+MtrbVZg5UPqgocZ59ucB41Z+KG8BpDDPCl1q0jD3advLiwijUY2n7Txan?=
 =?us-ascii?Q?gOdb6ng3rQ/eCfHVUDfEyOpcKeE7K3xdfIsapgc6V5h09sW0+ayQYKs067kS?=
 =?us-ascii?Q?wRVakHdp5bZxNrAhCaSrOgWgWTbwDgUPS8jpZLjoQXbwTQPpmtcxWCgTJKWK?=
 =?us-ascii?Q?wp7FAno8Bz5wc2bro1dnZtmQ7ElUuxnlEM0gA5W2bCabYa8iIwR/qa7r6m7a?=
 =?us-ascii?Q?3LADpVGpBBaTLa+Lu2ov1NmJ6+bdRAGGty2cESeAW9ol750XM4PM/fqPl7Vs?=
 =?us-ascii?Q?RZjxji+bG9uP8LzVxTpI95ngZnS1Fx337ovnPJrXqeI+1OYdQYmZNlOMAXx8?=
 =?us-ascii?Q?IMEjdrL6JN8yjykPBUDsyM/GmVhGxcA5N25+xs39QEuKn+4pzr3W4NNkBYwr?=
 =?us-ascii?Q?PE80uOddf+zhd+v66tE3yPKMLxJKieG8COMbG1nEvT0wQiUj0MhfDjvy+Cyf?=
 =?us-ascii?Q?lwZPqKLMbjsMG0wncdPGpWoms3Og8xIbsWk7LuSF7+Fc06cKN7iP22CLvcON?=
 =?us-ascii?Q?kr+kJMzdMu5kWgstWJ3FFON7Rlx/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElUlRDzsxxqERRqNWx0tpMRFuHzY2aMkiwfyOoy5d+IWJf4rYuB70flBwzct?=
 =?us-ascii?Q?mkRlFuH31xE2ZalTtU+q4yUfYzmbFyOsSjoHhlSs/MkOyGpZOaJaXI6iM9S6?=
 =?us-ascii?Q?VJT7hdBBUfkOux9b3YslqwcPR1G05E0TxbkkyJAA948BFl/RGs6/qfyOSD6/?=
 =?us-ascii?Q?ip5eISZACudkGGW923lCn9/6MWq3c2yxjvECNllEsaLBfaw59aNxtLB11Dzw?=
 =?us-ascii?Q?V1l8F1Lod5YIh06BPRRxPQ3oJUgcdR1HhQf+wXuJiJMD2TY1YD2anMIRqyh1?=
 =?us-ascii?Q?IdHomQIQ1RmXxg549Uxxf7JnberyeIPBjZ7hXs/y1ZMm39f6T0wlf7M04EUz?=
 =?us-ascii?Q?9WIuGCkOEnHO6bj3RrNls89ZLTHGqRjpHYAR0XVgDHIJ0utLpqLKJ+ci3XkX?=
 =?us-ascii?Q?TfIchwiE2KFTz4lXIeNu82IuiUFxtQY7m8RKzHjTDk/0XqWsVrgIo9kQ91f1?=
 =?us-ascii?Q?j/K/LXj7ft9q/23Z2NTwucsr87/lAgiGwvUd4ILOQxgvMS1TvdJkpW6zs2wi?=
 =?us-ascii?Q?kzQHlyPU6hC3d9hrGPhoG3nGrXlWJksiUuvNCt7nRzf8CYqNKmxHMWnpLUMd?=
 =?us-ascii?Q?usC2+v4+YCFt0/flRVLFKpVeBcTb4kz/sVnCWYhOe3GNV9/KXnDjis+19xDT?=
 =?us-ascii?Q?rCgauDUMZ6nh1PGtbDlHE8ZaNL4dkWPxGW9BFUDEzng3af8ilsR7ZyN2u608?=
 =?us-ascii?Q?uUCT++djf9+ILAxwJ6DMVSus7/i4MwLZPRDkru1P4KqXXCc6bKeUVnGQv2bY?=
 =?us-ascii?Q?lyjXWoimenEEu8JcuFG5Yh0SDqEF3Z15RswTo4ktjUVloHpKNYtxgWx5+nMG?=
 =?us-ascii?Q?T4x27Vxe3YsC8jbG94aBqFC20Kh8Y3O5bDIP6jvVoHR3ZbFYRjOBRBB3eO6Q?=
 =?us-ascii?Q?jOrKV2yWjQ8pkfm7yD6uqInP6izgcE837PTUQbnS3g/JO0jN513L6+TssI45?=
 =?us-ascii?Q?t+GZ/FYdK9fElCXjLHO/olCGakVBYjv7u6HKVFSuNQ9AValLeijn8zJv2CUH?=
 =?us-ascii?Q?yi1cpq3hNF603ATX4AV1h+VDN3uyJPKnNMdicKcKNtkD+pZkxD2gy3v9IXvh?=
 =?us-ascii?Q?G+MXr2LPFdpMB8wR9282xhpZHUh1I+yhKPzEj1K9tBoKfrUDW/l9J7skA4Dv?=
 =?us-ascii?Q?TtA7wYiuK53OrT7khCXG9uVnetqKRCXLcD+zn4oqUCIW19cYVoB1AgDJLJGF?=
 =?us-ascii?Q?yAkWr0oICf5yZ5Xs3fPlKuwTM9TpxYaMZqBej0RFON/sP5o/79WoTiyQdGE0?=
 =?us-ascii?Q?t4OUmPehX9gRWCL32Y/mLxpIIqBeUMZ75YDjxYScyhu6thPMODdRYPaHFzyU?=
 =?us-ascii?Q?9BI2myaX9v/WdYJsgDTuI4cmNz6fDzJWHT/KPZCBahMN9APPNwlKJJ8rY+tJ?=
 =?us-ascii?Q?Yhau9l5vWGS7U5xyjBmf/xjt8hiAPz3M6DnOQ8IyQdIWgTuyI2TuwgUZCZo7?=
 =?us-ascii?Q?yxRtlv6lt6PiEa1ydmgZVAX7iy/7Zm4TLOpvQ5U3gxwlIGhcKpzjIAjR0kPB?=
 =?us-ascii?Q?ZsgKK9NYPY8GMysHB9bKv8J9W/hJ58lu1nDY84FtTLUENCRHWgLS4nBBpcpb?=
 =?us-ascii?Q?LgaXeB7q9GUpd+ekLoUXUTJHT72/6I8D47cDXMxk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8338fe6-4454-4bfa-985d-08dd6043de89
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 02:24:37.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WOsPAcg6ptt1H8Ydn9kQEVUNox2LSjMFoju23Kj2rEqDuyhasB8+JE1ReeKzPs/+hbVKeE2zI5Yxl85bBk+Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

On Mon, Mar 10, 2025 at 11:38:02AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> The following series improves testing of SRCU-fast and SRCU up/down:
> 
> 1.	Make srcu_lockdep.sh check kernel Kconfig.
> 
> 2.	Make srcu_lockdep.sh check reader-conflict handling.
> 
> 3.	Split out beginning and end from rcu_torture_one_read().
> 
> 4.	Make torture.sh --do-rt use CONFIG_PREEMPT_RT.
> 
> 5.	Add tests for SRCU up/down reader primitives.
> 
> 6.	Pull rcu_torture_updown() loop body into new function.
> 
> 7.	Comment invocations of tick_dep_set_task().
> 
> 8.	Complain if an ->up_read() is delayed more than 10 seconds.
> 
> 9.	Check for ->up_read() without matching ->down_read().

Will queue for 6.16 on my side, for further testing and review.

thanks,

 - Joel

