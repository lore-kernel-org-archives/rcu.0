Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7E3AC17;
	Mon, 19 Oct 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368228; cv=fail; b=P6PTvM4Y0xK9dnurp84y02Zv4+Phs+WmUH8k7CnV84/8IKGz9SuF1YW0iS7UHuy5juryrVVqJhW2ZdQhpEOKhEQpFrGqSCjuwneQ2ldgji1VjLHm19opmtXeihxiQrsp4bm8/FYl4EELZulFB8Cd1YCyrVKiuWmNNX52KelVko0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368228; c=relaxed/simple;
	bh=U3UEvUlG5YeSrrOatKZ2jxI3VpGfnKVd9u1bgzAzpR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mr9STSVWLSpAYxhDJjh6boRjdOg4lVrnEp8mnvu4wWv8h7ysJh/gU9cvszCjvUCmW9CkEW37rsLfK3HQjin9NGtGm/E815qrEkBEYe4NdQ66j2iAymlnWx7TvaBt7/IMJiHC2ULa3uZq8Nw4NqFc7SLkb2ODhvRbvvXDRBqzlBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkFT4+qk; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkFT4+qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWkrDEyx6V0NJ17TKyJ7RWrdZgwLtxn6poLue0YE+rdxd4AgfmEQgw+Du19AORzv7l6YHRp9g2jWOKiJJp+6NquBLq06qmXjlhEfd200lmERHdl36JLOtp3FofNMomnUyfE0uHpJpjUkwjPD6YvgZe6TRzMT9AnfbG97tK7zp4LchxL1lnoqgTb4cihXbS9RzEmKWf+SG1+3wi/ZQ4IzXmPKK+/bOyAItCr4Ej+xMR4NU56l3HTDbh6WFeEdabZuKzgBn8hZzSqqByniWbmcJwTJigIye6S7UxQnQ96Pu4CfARzcloo6FB7jJizY1Ou1YDmyoouSz2b2+5fOoxC+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2JjDllqHhuBL1fXlfooWHLvZiFd+yoiB2bLd05ZVZI=;
 b=Ul0cWCBIi49jYRalHb5LXWt4NKvGoL++ItpdEHvMkjilImGmhw9m6tqvszLshYIsRHMRhzRh9GFKSHCQxB8cf0azlRHkDUqcA9XZ//43nwDTTQBuWwlKj7mn3cZ7of5vA2ZevXkkUa1esWebjbS8tHY+RJBGtXfc8pnJ9oHhDFZK7peKpmC0wMzPe/Fk8lPxQN7o9LXdecUy486uSsxx1Xv+RzR3/HIBWDi1G8DDz+Z6KjJkP5SzmUhMsNrZS2Qi14hyw3Q/k4BDhOYXxXEXUjI3ACOZOZz73IoZ2h6st+XLNbkpR+L2ndcDBmv7gZ/5L6QYqCQWu+UOVBcNofbOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2JjDllqHhuBL1fXlfooWHLvZiFd+yoiB2bLd05ZVZI=;
 b=bkFT4+qko/k04C/HCeuv0Dsz3mNxZoCmOQHQIoV+5Y5XZDjJ51HFPAKbvtFTqhPyne+Fkt8B3z42js4mAarUia+R8s3HweREjtNaHqE6itfPvvmsGWU1Srf/9UI8Q2ftpcdmyyA7WgYpesvILumhS1oqHbYaa23vWFlgxPVgPNae0mVyvcSeDqoarg8IbxlVxnlHIsRY9/7wa0806vtHHD0Y/CEv0+5eerY8O+I/jRRYIR4gSjPV4kfJELv8RazAWX9ctscMh2W1V9zYVptX53KDj/FgeGXteHPWk/Ge/0nCI7pXF3r5ccnJsmmbt1hfhZkyClYZW62SKUpbj6ccvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 00:03:44 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 00:03:44 +0000
Date: Sun, 18 Oct 2026 20:03:41 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, Yonghao Zhang <hyz3367@gmail.com>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Fix stale RCU_GP_WAIT_FQS value in stallwarn.rst
Message-ID: <20261019000341.GB123764@joelbox>
References: <20261014063130.3691735-1-hyz3367@gmail.com>
 <363ea835-81bd-4045-bf1e-f5a460fd698b@infradead.org>
 <f6509555c4e1abfc3bf67643d568887a7f9b7215@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6509555c4e1abfc3bf67643d568887a7f9b7215@linux.dev>
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea518c7-1e45-4334-cad5-08df2d7470ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	asNejJTVlybY9UmgbCANPEy1NPdl2dLcXpdlvEE9U4cEh58KvLeW/QvHcBVW9EtGiEo+kygvnSV1iEUm7USyqMnfwUsk7eSWwzx0DJaQ0WQr1MyBQYOie72drFOert/4vYq1FSzrFDdHjAXx6kJGS7cj6yMfBb9HnhzrHtr0tDNF9KYOL4V2R5Q1AM6zfOPod8Ed0DFyGaY1Mwb5WQnUM0efrltSH5jacDX5x37BtHvUKES3XQ9DH0Y6HEEuqEpvNTuNuZBE8I067gG2ze/iIxbsVTZqTJ5Peo7if9RPq8L3sSx8mjCYNpo3BFYIs1q34aWCwOCW7jmgS42oQ2TyXjhMp80yTbeU/MF94vYlkU6tYxN7oFx8E9FDbSAkytEALQTsKHzSNksxhz0zpcFzvuG/yEtWZ3VSyysx2n5AcDyHIYs6RuQp3CUgPWOdbq7+8eX4w2lkoyZ8cpOsp3ntUifza5FHs4p8/RBbLTKZ/lFpmRWj2yA7Vf0BvWkQnSQbcjhPe1W+PZHAp2Nad0hcAGIjnPCtoAyVTTdaglpqJG+KI9slSferS8XMAgpydDVWwxrOIoOSc4iMLC8QrrfEGbabDHZ9hsOBbmNMiH1oS0IivwzZ8DcAvkTqxRq63bZGL9hnEHn0O2pj3wX0YRFSx2coOg4LLY67l7L8kdyXv9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7iYDcAbxKmvDhAbpUaSSU+gSxpOMGkG4UWhrzLIW1Po0w2nsQP/FopzILuB5?=
 =?us-ascii?Q?Gw5Ua9SQ13WuBXfKlKTTY9HMsL6gfDR/9kF+2dJn+SSgVeAkUATZ10IzKDwM?=
 =?us-ascii?Q?ohf+0LMaV2i9zPnF7dfl6LJvFuRkfOoE5Vfi+rqqiLVEePekKjOIhrT/cX8P?=
 =?us-ascii?Q?7f9+109zjxXokVsxQ7cI3RWSV7AiBgDmXmZs1AxM4BRGxj0sWxtj/aTccQUa?=
 =?us-ascii?Q?fVSOb+HvNTPPwJNFbFlnTTnYYvbaJolKuaXCK6EvU+Qt3fVE2ntG91yOXidT?=
 =?us-ascii?Q?zEWNg7X7d7ZrJPfVixNRpoHR72XttGlTjQRAtssWR6QY2o0B9UcdOe45Y/jr?=
 =?us-ascii?Q?FY0MvjfqlqU+YVd5quKGyYAgYVfEitAlFUZNbkTVO55L8dZD2YdNmI5rfz91?=
 =?us-ascii?Q?llqvFOBeJWjtahBVD16gk0GCnR88NpdN4lbZmPZAa2/2uGSB5qW5gllYn+JE?=
 =?us-ascii?Q?eQRkCtiFBQpyHkDmvOEH5XF8iDB3RpGYh6cGOlROrN7Ng/ZejOGUVbDGszzS?=
 =?us-ascii?Q?KNF9U9AjCOjZLxAZRSyg8u9Myu1VALjA8HmDQiRloT2t4JMHtm3uDtnwf4r7?=
 =?us-ascii?Q?I+QNabI1LDA4XB2lD8Ic0E+OftrFIvHLUumIo40Ed78/E621oJslDH+O+4J6?=
 =?us-ascii?Q?5sMgGOO3FYp8uTo/vJuMvm9s7Mx1mRrMq5gJJU3CokkjN4ru+mbshHGKb6e9?=
 =?us-ascii?Q?ltnRw/sBtjhR7cue4gQvP7KRbYkCREk8vLDt90KLBLtSbriW/xM7VEDehrZe?=
 =?us-ascii?Q?RUdoQR4vAf6nNu1OEE3tv7RalF+QjjQt30K9a69NZirY3Vhym4jcNP9xcK4V?=
 =?us-ascii?Q?BWDuluEwTcDI10KoTelhtuWdlBCYSFqtEDLJBjDGbzMlyIHdkt3YoYLxa0dD?=
 =?us-ascii?Q?EBouNn8+m99n3SAccFGlgmXxP++dPE4arieKabrqr5XrLJ7RKxZyrEn5c69x?=
 =?us-ascii?Q?PfQG8rJKY4ovy4zPEJWmE6Lvx5wggW5U/WTkmoQ8KakWSKsAqa8+ct7gtGvA?=
 =?us-ascii?Q?IYfToi1l3R+28zahjJryp7fkrXMM5HC7ZA3YDsTM6h4xBm4CbhD9HtM/u75X?=
 =?us-ascii?Q?b7AQRSspw1xXttypPqvZ/I742e8ZgUjNkIggNydHdc3xYJEHHU7prisvbDCx?=
 =?us-ascii?Q?XbXSuipvY6NAQwopplqSxHbeCo2Wj3LoX5CEgOAMyPmiMKS3Ae2ZmfR25Mzf?=
 =?us-ascii?Q?uSAVd1JAE9koSKDlc4Fvif9VrK9EEhwspo76/cAe0W23kNm2vRQ+gE6Mj4gh?=
 =?us-ascii?Q?jmOC3j7Z5lTsgU+OGbMq6NdUE8zq+QS+qpuP1lp+sQqoBXs2IMwxoa9XV0pZ?=
 =?us-ascii?Q?/ATVfsp+nGZaYQU0Linddv2mDnZFOsb56/UAQVcMpJ6icy6ZsndNJg2Ija+Z?=
 =?us-ascii?Q?gg0obCoquDKCLV+JTDeXKI3oxxJsakh3G9yS4nT28MBl3LLv/gE2y4CBeswr?=
 =?us-ascii?Q?VBImmQvq1jz2HdkJWiGSC7QAqb2SGHrnqeMQ17JuVjVjhoCOYBXisRu6Tl4+?=
 =?us-ascii?Q?GlTL4jz1VkfRiqZNwGxBRSunR/aOEsU1N6j7Kr7Kdc3imio6F9O0A9KDRUKw?=
 =?us-ascii?Q?7UEm1Y0JLc/nx88rDkQb/OkwI9AoVvRiqwxkpCBxHGtxQkBwPaOYf1hLejjC?=
 =?us-ascii?Q?jOPsvLowpoMVEmtkDavWtZuNzTgZweVzPX2liEyWkvHX5ngMxJUzNA4bvbrY?=
 =?us-ascii?Q?U7MBYL+wzqPSNQ5SBTG0ILMS/hZXMuhQuitpI9dFYR5HTXVGQ7ya/U0Q4W1e?=
 =?us-ascii?Q?xwcswkESvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea518c7-1e45-4334-cad5-08df2d7470ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 00:03:44.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQUWpqfdJgUdjLBLuoF3SechQj8FSldyubCqPjOEVn91vmfN5ZEZcXoJUmFtGhd+gaTAr2IZtx28iu6T6ZrfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

On Fri, Oct 16, 2026 at 11:54:39PM +0000, Zqiang wrote:
> > 
> > On 10/13/26 11:31 PM, Yonghao Zhang wrote:
> > 
> > > 
> > > The sample "kthread starved" splat in stallwarn.rst shows
> > >  RCU_GP_WAIT_FQS(3), which was correct when the example was captured,
> > >  but has been stale since commit fea3f222d352 ("rcu: Record ->gp_state
> > >  for both phases of grace-period initialization") inserted
> > >  RCU_GP_ONOFF (3) and RCU_GP_INIT (4) ahead of it, shifting
> > >  RCU_GP_WAIT_FQS from 3 to 5.
> > >  
> > >  Update the sample output to show (5), matching the current tree.h
> > >  values and the later "kthread timer wakeup" example in the same file.
> > >  
> > >  Fixes: fea3f222d352 ("rcu: Record ->gp_state for both phases of grace-period initialization")
> > >  Signed-off-by: Yonghao Zhang <hyz3367@gmail.com>
> > > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Reviewed-by: Zqiang <qiang.zhang@linux.dev>

Applying for 7.5 with the tags, thank you!

Joel Fernandes

> 
> Thanks
> Zqiang
> 
> > Thanks.
> > 
> > > 
> > > ---
> > >  Documentation/RCU/stallwarn.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >  
> > >  diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> > >  index b888e13c02a4..049694b9c681 100644
> > >  --- a/Documentation/RCU/stallwarn.rst
> > >  +++ b/Documentation/RCU/stallwarn.rst
> > >  @@ -379,7 +379,7 @@ If the relevant grace-period kthread has been unable to run prior to
> > >  the stall warning, as was the case in the "All QSes seen" line above,
> > >  the following additional line is printed::
> > >  
> > >  - rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1 ->cpu=5
> > >  + rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1 ->cpu=5
> > >  Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> > >  
> > >  Starving the grace-period kthreads of CPU time can of course result
> > > 
> > -- 
> > ~Randy
> >
