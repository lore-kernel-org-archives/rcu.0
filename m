Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F0AD2F;
	Mon, 10 Mar 2025 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571714; cv=fail; b=bouILw0iaTGNkJhNrhMiDbxhVE8Cdo9tdjSxMywKF6Ta6SBCv0U9JMJjMIfhHxDka6vaxX5f3LCKrmUrF2JE5bHY8hmwO0PMiBuagBFOby1b8Kp8dtt17lC33kMcUn0AyKjddWIeW/C4AYG4hK6z43KoaxYc0jaaz9F3Bc/2/oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571714; c=relaxed/simple;
	bh=zR76B7PS0L/CzfJ6BU1WQpc06kK6GUOOo1oY3l7yi68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cWLnCkzogTeDh+LD4PDq4GSzder35zdqDIe9f64oq4zLwZ+MYoh4yvjiZUlmxynwRJiWsLEVp8vrIdnVkd6cdXCsPUcSpKxsihYFuirKEEpOE8MhsxxZelAM58oaOHIoovOz5ip4nucHY8/gdUcwY92tVf0DCsUWhwVknW1NNy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8fswk2i; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8fswk2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iToHNFP38S4BF0dINJnM4Q14vp5Ir/8YQSVG8ST/cXosMZ57PBSIS4BcjmaltzjRxFsfUqiQ0Nd5hqSGoCsWuNF81+oGnbogbUYxeY6CUA56OW/z3MGI27PdaBitov1Kg4hA0IByF/ZSubxxxit3+P1QbBBeSXxbgqSQFIHshzSP1fKgjCnly1xg6vcug2rCL07hQu+8Tn6MYzqgSEPaNRv42g4e92lmQX0mckTyImud3POyoD/A1r9cwqot+eMNp2vTjjTIyvbOJy4jYdx6junr1p4j2ECVyHsBz04yzjbEesdaJWA2D5wKvR3qBDDZz01p1POQwyR/0S3k7lzznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYFUqVfOWcUGJBN8EXUKVjz7fJBAPJKYeTPDGmXvtts=;
 b=lov+TVHTISdGEokK7L82MmT0jG5KoflmPZAIILtwWLQfRQbAQhPFahGgjh35+KJYVI30uPvHpdv/z6lkXd/1wInD80NTlL5U8s3Eer0am39wu1aoAbtiPL9cdnOSV7upWSZwqq94Ai28aEUeO74jGpB5NCnJLFcFyO9ciqgBqeE9wTD99sXxI2AGk9X/hPyAC9S7HpvKSpcII6BU6PeIkJTqdGMWVy8iwNpiwppDUryFgKxU39j8ESrgnsPnnuODOwDe4aIGcrs6dsCaASkRHHPvR+5NHuJQksJAoTm0uZN79/pBP+tz/8MNxk9h06iz8IDf1W/ZItBUh/AMAmPviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFUqVfOWcUGJBN8EXUKVjz7fJBAPJKYeTPDGmXvtts=;
 b=T8fswk2imPndhASBUaaUg1efTIn+A4vDQ9ZUO88NhcX/RHwiRCarQ1OET1DYC8ZCTfhpgpqCqILelqn3QIz/KptNE67FLxSNE/nWmqtsaArZ3PRW8zi8iNiZ+yecN7qr+qBBM/ETcHa5dowiiXjJFrU8fNj9FxGbHrO8/lHHukfsZoD9wImt7KccVxy1UQmsloy2E2ZgVRk3t6kdhSujgFXWl3B7zgmlPzXddrBvS0TsFLzNshnBodEYqJqFlOz6lmElL5alWh6gLRIl27t41w/VXHXa/g4Muul5ICQmthm5IRVPB2iFMsBxuahG9UyLnnTNVITrm/Zn6FAKiWLPXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 01:55:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 01:55:09 +0000
Date: Sun, 9 Mar 2025 21:55:07 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <20250310015507.GA3993297@joelnvbox>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227131613.52683-3-urezki@gmail.com>
X-ClientProxiedBy: BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: c41c1777-2a25-461a-451c-08dd5f7696a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B4DeMXWmj+iP7BSAKXSaDB8IYxXdmtTahlwhKBqH1ixhK2fGQajL+ZgtqUvW?=
 =?us-ascii?Q?i1SO+AGdVHrVm/8tewiUEDqlsuo9IpCqfBQTcVCTJzWuVFBsbOT+es7QHhZ4?=
 =?us-ascii?Q?GWPxxRqfHmP2IUTq+8fvUW+jxIq2vAUYgkNNe1HeP4byGWa3X3/tjmypvNSv?=
 =?us-ascii?Q?n4QecknF8lakmTkAdu4V/hUgpDwii6V8G+D3Qs+Gl/nCSHUyQLfBvKnGJA1M?=
 =?us-ascii?Q?o1stY80ZMVtvyITj/ZaJTC8NWicFKrylZrVNyU4wN+0QO/3+ytTNKXMLxTqY?=
 =?us-ascii?Q?t6WCdv81xLBNr5TDPRv0qfUd6LQ89eKW9TCpZ4MFVPhNc3cLNg5ZJ2uYCMQL?=
 =?us-ascii?Q?IigYbsuiUy7/Ja8+k0fidCFUHmSTXTM4LKvYy6xNqBfeP5SM5l0i4J9mipJt?=
 =?us-ascii?Q?9Piz/xy4buXOHpKddmHotOUY5qp5d2GmuFSnHv/Fk+vwuX7jpMcazUGJT98W?=
 =?us-ascii?Q?tFIHHM/iKVwkdoFzMwi0oVXSo1D5h0dHfJN93wBF7Tikp9LXSXnBGPu9NwEQ?=
 =?us-ascii?Q?pSftNoy4FLUr8Yju4ZYefoFq/RDb4y9TXXiINeLdIzrquukywXoiW4MzMGGT?=
 =?us-ascii?Q?gCkzghQnwzT1PT57iZc0ePDhen5Kfu/tNB/40boqKSJz37sDAmcfieKZgOBE?=
 =?us-ascii?Q?je9yw97GidEo3N2eV/tHkQ0YBFwevf+fLMUdgrx1auaN0XmNqZLd7R9dPd/o?=
 =?us-ascii?Q?Mz4X127ge86D14LiPlzuZMY1BndBlqH2f8kiaCHJls7ToXjZvCeGBD3RA+9T?=
 =?us-ascii?Q?Wb3S7mejFm4gDMHsL7JlDBI4VbWX80Oq+5Gpqwq0wgAwxJUAFcBhrMW7QpY5?=
 =?us-ascii?Q?n/XrsPn62Huoh1Z6DDGynPYA8wQdjugg9OmyWIbyKoKYGDquBBxB18loMtZF?=
 =?us-ascii?Q?9F53yzJcgxeuARRl5qdX6jYSzaD8dondPqG3dQJWzAruIKYHQskq+nL/mJ8f?=
 =?us-ascii?Q?nybScnxQsrcGEuG1pGDBJWnpGHmcEgNh9SQc+BG3G/uMRgGrvNQ67XYmvpN8?=
 =?us-ascii?Q?yAlFqY4FTJGh8DfrCZFu6UZhvhE7bkAYhHbwp4FZTH+xU13ol62yzVb19Emc?=
 =?us-ascii?Q?Tw4NG7Bbh4vI+FavAvVP4y0pPS6T/sPIyRT40YN3FEE38G5KNpGBSUpnmie7?=
 =?us-ascii?Q?vHFZSoWLiUAM05I/1f0epAsRUQDgABP+jHWL6gbymaCwIWxjZTW/cI2+7Gjb?=
 =?us-ascii?Q?bqqnyxutyh6RPSX5VXUy8C1lvQE0YdiuWK+utgS988KP615HxIGrgowqvb/R?=
 =?us-ascii?Q?ZPfbpIRGv5oRt07yQAQ5fOPXIpAJSR7sMXfVOmo7IZ2bMREzx7vvlQ8SW01S?=
 =?us-ascii?Q?IrY+9tehuLWMRFXXRHVzaaT+LSg6XjUPabAq1XG7yXRAyOH/Pqng4a2Ur/Ja?=
 =?us-ascii?Q?lMjzW79Jo7+NvFDOTR1t7jqbGlc0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NdivAkAwIjx9R5K4TO4tbERBve68l1fwVzrd2MpzPR2t/1Uyd7b/SzT/pM+?=
 =?us-ascii?Q?YRijzLz1pIYXVBTp7KFwZv4bdXdh+Ue1JuDZPi5QNRw6Os5yLYrfCvgvmnvX?=
 =?us-ascii?Q?EUHDLfkePaC9uoRnReJ/QpK6TIfQDAoPqS+MHpRF4Tt/ZKt75w3Q+bNJeuTx?=
 =?us-ascii?Q?x8ip43OyCJZ/frMoyZiN3WVH2Nr3xxyqC2pmGnmZQ7N32o2Cb9bfHNtKnlqU?=
 =?us-ascii?Q?9VJtEY5FsUZb3nzo1kDN+s3OC0h3R0fAPlyoze+35aGLrYG5Enu14t/U7aQO?=
 =?us-ascii?Q?resbmM1dmkujLAL/VACPHh+qT72NIpQYzjrc6mx2BouvX+qy1rsl5CIjL1Xg?=
 =?us-ascii?Q?7Rwi0DBZiQqPc+IOMZLsk+OnWh96oViYTFi4djcdIuqH7cddm6ngUIbVywo+?=
 =?us-ascii?Q?P+NuTiVQkNumXwVcVn6fL2KdnwG0KZQg0DTz+JY+Oqqjqb1Y6gu44BvcsrTX?=
 =?us-ascii?Q?Yv1FBfoPzwJYgDrY5fMUvV/aKF94HzXnjbjnnaf3+cN2XavuIhRDurNMdIdS?=
 =?us-ascii?Q?wY1W2X3vKScAZQb1vVQA7y2G68Pq8ZN7lO88MJ2ILh7SjZEPQC+HCBvs3pJm?=
 =?us-ascii?Q?dOVn7gP1muE5YToUgMRG1PLxG9ecLcagqhhd7oc3SYsGy55uLB2I5JIz7Eak?=
 =?us-ascii?Q?78l02NY9Yx1GMIWak6SLxDowvFGCJRLI1iO2lUFTjSJ+d7qFLmXwNW6ucTLC?=
 =?us-ascii?Q?a6yJt95CHY2MTctYLm5zls+r4mwugOO8JI+SPzUFMYJYS/W0QcFBt2JIs1JZ?=
 =?us-ascii?Q?Kq6MV4nE5PeVvmAa1gbdhi5pXwSSH+juEpvABsFglzCxWLqqe+HkqckHh18E?=
 =?us-ascii?Q?36rxdJMsELLL/tlYzUovLslDvWiJclucsK3dP2Yb5hZglfyQA4q/Hm7og33x?=
 =?us-ascii?Q?HoQgU80B2ml4pSmgr156VubHhbzIxbLYPW5ZIBaeTX5RIcET7lTn8bwSPz7z?=
 =?us-ascii?Q?Dmxy42m3RtaarZ5a4WDVF5ae4pljzvzy+irplOyuI3LMfYBLx3Iu4a9hgMT6?=
 =?us-ascii?Q?3MvQ69Lfa47Uwu3GnKHnAYIdexfwy7f7Df6Llia93+ni2QzV8/NYO9Z3cc9X?=
 =?us-ascii?Q?6byoV1Rs7SbLzCxXqNyiVMmAb1sv0tJQViInQSVaCzo82CZ8cNkrd88NbNRB?=
 =?us-ascii?Q?MFT6+yvLyUBYcEg1i+JqrPDHdgL/Bf5POkM9dj69B8eYdO/Q8i9FZNgdnQuQ?=
 =?us-ascii?Q?EaTmv73Ce4gKFBMwIXk/JiolWr6jN7aC9Afwmd5P6yreGE/J7VrqULn+glpP?=
 =?us-ascii?Q?tyhWMtLuwlL0IqrC20cLzAJ9KJJXy1uJ2t5UPtJ3Ci61UL4F4ndK9Bzda3Lp?=
 =?us-ascii?Q?yzJaZj5UJHCVUjob/XWMKPxPWpRVs8990Q/F5QZ/RdW02Iw1bjmp+RkCiaWu?=
 =?us-ascii?Q?h87B/+MAvCusvSUG9plyq/1sVUYi6OUrSmAGdFAKoA7w67xSntg3NGPV/BDb?=
 =?us-ascii?Q?0KUZ+UWI769XHpOwgSkldkZ+fG+aIgj1ssVMI32EZOBCRn3azhiIZxz0Aj8a?=
 =?us-ascii?Q?9B4Z17aTBqmh5hnfdIDK9fQcdi5CIXHDChqKa0HHqV0UtgQX6eLVZmxPcIMW?=
 =?us-ascii?Q?IeSp1LLAIjCQJJbQCEJc5iH39nE4oOe2tGRYW9KX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41c1777-2a25-461a-451c-08dd5f7696a6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 01:55:09.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT/TyM3r+cHp0oEwK+YYNS5twRx8VuK31B50kVA7k1JMzr4sZ7vRY0KtAY/Pc9skrvXQGK5j4xsz1favUL22Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593

Hi Uladzislau,

On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair to debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period is
> passed or not might lead to a false-positive kernel splat.
> 
> It can happen, because get_state_synchronize_rcu() compresses
> both normal and expedited states into one single unsigned long
> value, so a poll_state_synchronize_rcu() can miss GP-completion
> when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> run.

Agreed, I provided a scenario below but let me know if I missed anything.

> To address this, switch to poll_state_synchronize_rcu_full() and
> get_state_synchronize_rcu_full() APIs, which use separate variables
> for expedited and normal states.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

For completeness and just to clarify how this may happen, firstly as noted:
rcu_poll_gp_seq_start/end() is called for both begin/end of normal and exp
GPs thus compressing the use of the rcu_state.gp_seq_polled counter for
both normal and exp GPs.

Then if we intersperse synchronize_rcu() with synchronize_rcu_expedited(),
something like the following may happen.

CPU 0					CPU 1

					synchronize_rcu_expedited()
					// -> rcu_poll_gp_seq_start()
					// This does rcu_seq_start on the
					// gp_seq_polled and
					// notes the started gp_seq_polled
					// (say its 5)
synchronize_rcu()
 -> synchronize_rcu_normal()
  -> rs.head.func =
     get_state_synchronize_rcu();
     // saves the value 12
 

 -> rcu_gp_init()
  -> rcu_poll_gp_seq_start()
  // rcu_seq_start does nothing
  // but notes the pre-started
  // gp_seq_polled (value 5)

-> rcu_gp_cleanup()
  // -> rcu_poll_gp_seq_end()
  // ends the gp_seq_polled since it
  // matches prior saved gp_seq_polled (5)
  // new gp_seq_polled is 8.

                        /*  NORMAL GP COMPLETES  */

rcu_gp_cleanup()
 -> rcu_sr_normal_gp_cleanup()
   -> rcu_sr_normal_complete()
     -> poll_state_synchronize_rcu()
       -> returns FALSE because gp_seq_polled is still 8.
       -> Warning (false positive)



thanks,

  - Joel

