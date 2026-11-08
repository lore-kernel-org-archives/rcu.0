Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794179195;
	b=lrK4iqqQ8ZeyEb9bZldkRnB3vEFTiy7n6+b0i6KHbXfK8MydQQlSfMathCdOWg5uDpRj
	 O6g7Npktc/ZQwmvto+a2ebh/+ucrjSBpbXOjZD1XHGXFm3vx/vHy5Wl2BbQHfbyiAgQl+
	 iUp0A+mO3L86Ku0ziMA68PezqlNdpSBeaSqPLkD4GfjwXeFKShD2w9//73ujvISLNAkEc
	 mHOUnO0QKAFRVL1gK+uPX77egstgEYemNVsXG2aCj8rNHl4QMI36I0HU+ZiRGsZjXmx9k
	 1q9wefO+ONhMTd1JY5WKvHRzefHxY8WXYjb/xofZpZFx8Ss9lZ0CEvJJ3TW6iP8GmRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179195;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bPrPSoc7JIVNVQH5rgQ83bCkaMVJdtqESur8kMvwwCQ=;
	b=X3OgWUOnYWz/DBQM1tvp/0r/4vbp5EGhHAyICMdq4hg7LXj5zuTrYaOI0BJ6d+UrgZ+v
	 MQRkI9bYbDF+vFwUiXHoOr5Z9YX8Xt2SA3rj5K66+5ui2yV6uJvCMppyzEq1ErSz69dw3
	 dXv+xC0F6GGkgwGJ+iZrBYPOy9JS2ZPyOOW6V/PqZ0Xej+3CUO8naNseeD/91pbTYgOY3
	 7/+U5MHqP7ZOchXiDKnqPmILZDd61S2AcGRjVV5SAkf9l9p0U17HVqvi046ig9dYVSIkw
	 dbF1cmiPXPBjZ3BW5H9UJ5BDhKhYUkz9gAVYLYBMBO3IHI9xCCOkj1INwOJiFDfJZwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MLBzUb4x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.52
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1B606A31C;
	Sun,  8 Nov 2026 23:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MLBzUb4x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6MR3jg0K46STaoGuC+4a+3D1iPej2Ff86MxVRBpthKdmCR9HXl4LP9rPrXBkqrid0Yg1IdqC8ffMl9++0UckiH3xj7mJvvalBS7b6ZrpYOZjM0by68gs4ec7UMENnpVCVzPddWXvdg2xHFEueiaBNUhsT5TgLMj48REd4gMR0rwdBPwbLJ0vNEZK1r3LhHQbZKpnDq/2fO/3H2wB6aIjGu1Vs6t8IfmeSghdk/Z+TZd9VIgqpZq1xoX8ulUpqA7GfCUUnWK5UejoUSBbt8AKzWlFsy6nXHkJt0YXXlhCefuwDjh+3ecH/g+DweO57CRYfQXwaPLCsIFSEEM61bKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPrPSoc7JIVNVQH5rgQ83bCkaMVJdtqESur8kMvwwCQ=;
 b=qJYr8ft0Lhvm1sBHabBWC2lcZM6WokZiFNCkoYFFaEqWLWctpRHVOa5D5HUm7q1lvMeTfK/kRN8kBMnp+S848pqdNSdUkQeAeLKhV/cDIFcNxgXibRaVHHAgOWtsVrusdgUnMRMezoiPRD3dBEFSWaNZhcIXsfnhzTM17k+4o4bhw7Ou9C9DSFiuBk78h5o8BWbyppYaRkanY/ueSD3YbwMp8bzME6XlI2Ctgpq9ZgzLkY1QwBvfwBu1IzNaNAG7OlOMexEAcVipHgsO/VzH0chqsfyBCq9rV62qg8H8DxFB+W+Fu7VKeSoHFfuqNLOCGCn2PlogqqoBGtc3Qq6fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPrPSoc7JIVNVQH5rgQ83bCkaMVJdtqESur8kMvwwCQ=;
 b=MLBzUb4xjowVKN1czsuZOe/QcL+I7Jn9uUE7pnAQiCKX3hSI1z56CegnHQbyPBNEhr0Qe1XC+HYDpWV0nAgE/3IVJR9V81cMDlkFm3fs7ktpMS3eDUHWVpQES1+EabJiNglJ4O2iazZHzYLEm2bZ78XEwWuU90sAYbcj8I40E8i1RmMd2tMgbI0wbJxC6uPBGR9M1oa5gau0yUEDGnPlwco7qarl39sMQHeQQxz5QO5Yko2BB14uHmtDeDVaY0R9nXQIAOlcCRBOpq/S71jkVbWuN/8G3k+HJuThKr2IrIu9HT4CmGCH+GwSw6n2oED4v6KjkSfrLJ1snUIEV5LMtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 23:06:26 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 23:06:26 +0000
Date: Sun, 8 Nov 2026 18:06:23 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
Message-ID: <20261108230623.GA3148953@joelbox>
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 506e0a67-460f-44b6-72c5-08df3decea41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BvnUGXkwS5GxBZN9lzEnuShs9t+JUPLQdFrQew6/G0Gctxj9TLYM5Ah/nK2MGIrtCZ6nCa8Blrb9EscqlHlCwpJ96ATT+DXZCL03SJAu5KvrURKuDKKtWJQlVZ/0zFL0thmaobG9PaMv4F2+3hHPMo9boFSt25VBrk3EAhHu/G+voWwc2BGx/heIl4eWyJ2Z9WSewrEpcyodF1dD9AoVFuptefa71Cl9lGJ0eg9pN1jOKTJ+bQsdnv47D21zHX26Qr45vO7gGYKgo9NxoiFx7nZGPBoBJBe0EHqUu16r60+OiWHZcy++9RaWX+i2Ex8yBs9WaEJwjCU+dYB6WfBXaQDh7YXLcFL0MZvZNRXobgW4LLoyoeICqmGqe3Txg6DFHHVWx72GGN2zvz0vvXteKio5UyCf5/1qKwPwylvqw9nWjH39/DfN3jfpZyqzSVcx/LQ/kBSnRrkTXrh5OV26JJVtf45o20GD0y0ofph55VH4QMzY3dkgteUlMLYRy//2sc5234UQPGv2+UZcW1nwRwg8n9Kl05fwA5oAHA7m4tB/+9Go2zhewo84eetSNEJxvPMGj5h0mUccqD1J+Sfs7gqHWg9xxSCSi8bFxqT3TAnqiQKPEiL5ZD7XTLmNm9Uj+eU6MiTsz+z8Ag0dd3M2zNH/E/+1cGzZ3HZ4MZhahhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCJjkbrNOtd0y/ifohmL/mfsVkDjpCRy4M093VpIKApCQ3tFegYln9T3JA/l?=
 =?us-ascii?Q?R3SKhTCS2X4TI2VHLe72MqBwq/UH98nFpdGfS0lKii8emtXS1EK4tUmFjyw0?=
 =?us-ascii?Q?h/cz5/Q0UEoB6EgGuUAe5xSqaQnklO9hT0IvoWg7fwH/m5cMHndbjLVcSCCF?=
 =?us-ascii?Q?QZc5ktUPMm+Kj9tMmTVp1pW3kxQq/vyVggv5N/Wq1msVq/EwG2GodyuC+FJ4?=
 =?us-ascii?Q?SzuaaQfgW7wo1Xx70JT0B8bh6b0Ivs8mV7UQteTCc8ZtFyWTbbVhGxEdd/D5?=
 =?us-ascii?Q?u8j441GRQZu7aiu+M36MGnG2bShSvGD929QTfltuhOHFgNjckrz/kD8p5Hg0?=
 =?us-ascii?Q?ZSm2BQrzH0Cu47d/L0VpiCt0blq96qaqwuUqeKAcl+OIkS6BE1qnc6kJ4Rm/?=
 =?us-ascii?Q?8qfB36KX0oMcR1nlGOOydA77VcWJ8SvBF1PqAW5aBywKvNCccqD03Bfqe4Kz?=
 =?us-ascii?Q?bXTU+fr6YYhE3C2NOxcV2tt1wuIsVItzZlGqMi5nYP77qROcsyvTHGvM5num?=
 =?us-ascii?Q?gHflryytaz2pS/Z8W3K1H69s8wyo3fgKrzND7/ltkUGyqH6HbowiBrNtRaf1?=
 =?us-ascii?Q?ko9lVkItCq+E4jZR8alN//Z+lG5lffP19AnP0O5MZIahMd4f3g9Pi4Nqd7SM?=
 =?us-ascii?Q?/XzmIeWASK3LhvAAta6Rcn3+hqLS/r2AKxYCOZPGDFkRxDqG0rZnDr8xEW0m?=
 =?us-ascii?Q?xEW8FwN9/ymzkAqHeBQHc2lyakG/OcD7rUCnUEI5pPbR7UDw7wokKUaI6yT3?=
 =?us-ascii?Q?+RKC9rF6c6zacBBoNkTVJDKs9yIN9C+zapNnTROrEalSyQNUFIKGKP1BG1Gb?=
 =?us-ascii?Q?QxrFjIpHmNP8YZkLT6/vDc8zbq2SsusFw+2uzA+adjndQBt3bpohr4u1j1HJ?=
 =?us-ascii?Q?l/ZtDE95eCtPhdejyy3+b7Vh7DVp1aPjeyEnQ8z3hCXGCuC+4ewLWMB2pncm?=
 =?us-ascii?Q?I1dLBfaYOIVNPOmrh5Bmh0Ep6My+xH8XXmEpmD4UYVDCmnzpHXondiuvrWzZ?=
 =?us-ascii?Q?q1muZbw3nCa41sF0T8D+vKvkFA6DwjigTbZA9BKK1GHx/jg1UD3oG+BKaNai?=
 =?us-ascii?Q?BSwlrEsMzpwLkBA/AMZAEqPt+CBs9/kJGURgErFhIaaoCkgCHsXFqkjHmAYr?=
 =?us-ascii?Q?J+eJlUhsh46EPwFtf9/8Xa4qegbuznoTxfcykvd+K/qQOz+m2U1hAjNf6uuR?=
 =?us-ascii?Q?5UFnPGrPsbkUdGnKeF0PLkEpbGSjSqnxSQNMcpShtKEHeWRu7QN3CZ7g/BmO?=
 =?us-ascii?Q?LbQoKa/d8SfwZoxt7+mq4cs+10/TJzs5uZnRdb3NPl5HUXiqU5KFiMnqgv18?=
 =?us-ascii?Q?ToSXr3aFILvrqMDd3QkyV2P4sQJqx+BE8wRuJHEUMfL0ExsuRqmvVl9uMu0I?=
 =?us-ascii?Q?Sg5fGjwoVwhJNVZB9QmTNDKOtGCtAWRAkItTZtyDhNxAqkikJ897BALya0A2?=
 =?us-ascii?Q?pYhc63GdHgX92TBUQ/IDoXdGQ+5arKPWk66Ux2bReSp8tYODwW3VsF67LTsT?=
 =?us-ascii?Q?JQZJRvZPy5rAeMxDlpvgPjb9ly0hoZJQtLlE0ApsNG1ZZXI0jxfdAlbVgZRt?=
 =?us-ascii?Q?xUY9wAsUuiRA/r5Hq6vixDq2SLykOCHdej2YeimzBfCNty6xwxy3TqkgQ0gg?=
 =?us-ascii?Q?5U+JI6ybwfX1o0GdMonMb9AWCHqsWZjadrpWMln1/JGnzT7r9wxjq37ve+yA?=
 =?us-ascii?Q?T298flgXS/6IqOOsl5D6YLIGXjcvArmChZAWoE9H15Q+WB/5Df32N0n3uLNd?=
 =?us-ascii?Q?ub6XQNDSng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506e0a67-460f-44b6-72c5-08df3decea41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 23:06:26.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwJkl1iM3GeDJlm8fyE9vVxg6sKhBWXpvMy1IpLF/eSB3EOGWjuPCRjXD9hPUIixBMmAUnqvb828QwJxigl9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761

On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET wrote:
> 'struct rcu_scale_ops' is not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.

rcuscale is a test kernel module, is it worth adding boilerplate for
non-production code sighting security reasons?

Do you mind runtime testing it too if you still feel we should do it (and
provide reasons why)?

thanks,

Joel Fernandes


> ---
>  kernel/rcu/rcuscale.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 1097ec15879c..522f7bc2e693 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -159,7 +159,7 @@ struct rcu_scale_ops {
>  	const char *name;
>  };
>  
> -static struct rcu_scale_ops *cur_ops;
> +static const struct rcu_scale_ops *cur_ops;
>  
>  /*
>   * Definitions for rcu scalability testing.
> @@ -185,7 +185,7 @@ static void rcu_sync_scale_init(void)
>  {
>  }
>  
> -static struct rcu_scale_ops rcu_ops = {
> +static const struct rcu_scale_ops rcu_ops = {
>  	.ptype		= RCU_FLAVOR,
>  	.init		= rcu_sync_scale_init,
>  	.readlock	= rcu_scale_read_lock,
> @@ -247,7 +247,7 @@ static void srcu_scale_synchronize_expedited(void)
>  	synchronize_srcu_expedited(srcu_ctlp);
>  }
>  
> -static struct rcu_scale_ops srcu_ops = {
> +static const struct rcu_scale_ops srcu_ops = {
>  	.ptype		= SRCU_FLAVOR,
>  	.init		= rcu_sync_scale_init,
>  	.readlock	= srcu_scale_read_lock,
> @@ -276,7 +276,7 @@ static void srcu_sync_scale_cleanup(void)
>  	cleanup_srcu_struct(srcu_ctlp);
>  }
>  
> -static struct rcu_scale_ops srcud_ops = {
> +static const struct rcu_scale_ops srcud_ops = {
>  	.ptype		= SRCU_FLAVOR,
>  	.init		= srcu_sync_scale_init,
>  	.cleanup	= srcu_sync_scale_cleanup,
> @@ -313,7 +313,7 @@ static void rcu_tasks_scale_stats(void)
>  	rcu_tasks_torture_stats_print(scale_type, SCALE_FLAG);
>  }
>  
> -static struct rcu_scale_ops tasks_ops = {
> +static const struct rcu_scale_ops tasks_ops = {
>  	.ptype		= RCU_TASKS_FLAVOR,
>  	.init		= rcu_sync_scale_init,
>  	.readlock	= tasks_scale_read_lock,
> @@ -357,7 +357,7 @@ static void rcu_tasks_rude_scale_stats(void)
>  	rcu_tasks_rude_torture_stats_print(scale_type, SCALE_FLAG);
>  }
>  
> -static struct rcu_scale_ops tasks_rude_ops = {
> +static const struct rcu_scale_ops tasks_rude_ops = {
>  	.ptype		= RCU_TASKS_RUDE_FLAVOR,
>  	.init		= rcu_sync_scale_init,
>  	.readlock	= tasks_rude_scale_read_lock,
> @@ -396,7 +396,7 @@ static void tasks_trace_scale_read_unlock(int idx)
>  	rcu_read_unlock_trace();
>  }
>  
> -static struct rcu_scale_ops tasks_tracing_ops = {
> +static const struct rcu_scale_ops tasks_tracing_ops = {
>  	.ptype		= RCU_TASKS_FLAVOR,
>  	.init		= rcu_sync_scale_init,
>  	.readlock	= tasks_trace_scale_read_lock,
> @@ -693,7 +693,7 @@ rcu_scale_writer(void *arg)
>  }
>  
>  static void
> -rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
> +rcu_scale_print_module_parms(const struct rcu_scale_ops *cur_ops, const char *tag)
>  {
>  	pr_alert("%s" SCALE_FLAG
>  		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d nexp=%d exp_interval=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
> @@ -1109,7 +1109,7 @@ rcu_scale_init(void)
>  	int firsterr = 0;
>  	long i;
>  	long j;
> -	static struct rcu_scale_ops *scale_ops[] = {
> +	static const struct rcu_scale_ops *scale_ops[] = {
>  		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>  	};
>  
> -- 
> 2.56.0
> 
