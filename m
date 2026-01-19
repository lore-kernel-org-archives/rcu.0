Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56920C48A;
	Mon, 19 Jan 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799923; cv=fail; b=Fc3bx7OmdBKyzwXVn8fxuyJWmPJAJv5phu6B3fCykGsYQzyX68zbSeDaIWrSEejGNELGjqd3zasuwQ8maz5CkukaZdoRXyDGkpwGn87HPFJMZ5vhqBvcPpNl/t8/B6ly9MEaBSHFQj7ciYpkTgET48MZmtp+NKDd5KWksPXopxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799923; c=relaxed/simple;
	bh=72SZyDyHAUjd3C40id9FsiLKLjV4LKrR1f8PCJVjgDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ONRg74Ls2F8VS6+56m0Lwiz9Lhn/TZ/8+QeDgWw+jmg+ezpArVPVXX4oaG2Udgg5xb8aege29WXcaS7vwgx3vQXrBeQOozqTZzc/s/l8/SG+ypmbzBQZeQl9gH8l0DRVWKdJRBeMviir8vpOqKb334zGUCUqYVM5ujjbG2yzqOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4kdaRYd; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4kdaRYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnkBuL+QtHk+uvn8wgeaflEo2oWPaWo9nsoWG06UbOlSwWMnkJPG1xzrxszo6h7ZuMRkXUKqzbUbQUj6nQrPaw2YswacavLoQYJX9UG2qLNRDLn3IbOjIcNz3Omfbi47b/maJ+Z21qFte46l/GDau8RsGTYaDzYffpO7wHPfSe5xEzdQcpc5ubrxPAZniIKnpvzwPwvBlq3ZJqmPm6lyI198jnaSgiWnqckS0N+rz0JI1gjLufVt+ivstkDtZvT5YYuX/SUZWYEpEBXvd2tpZF9AtJ1FnWCB5o7aPaVYVPY2Gd3XZwz3Wa3s1PnBnb0dnC+fJ/ADU+07048oDfPJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z83QOGVD14jfAbguePGofZ7uYi45cxjaq61xG52ovs8=;
 b=ti0GVNtiFgZvhkfIYLx8XZcWHj+LVX0Ds+1hYD45ehduoAyGiUulXoGDvbwTIyuw6YyqvJJ60Uk160ehPAk1vPR07L4mArih5EvFuhYCRuPaBUtdD9+2E9Zi8o0w6ojLhY3L4HFRL+whbIgUl+1GQbJ7wRHYVlU5xO0EsWGwiE7azYS/6pliwh23GpUTsGNqy9GackbngN4X4TqJo4CX4CrAza3odks/xpgj0Mp9f7qyDl8zFcKtiTTclOnL1Uy+1ycc/WRQhvLqHejkrTLQK91IOdbmKjhjjmcX8knK1Mxn/z5oeC+wi8cukF9YQgcucFTN+0ohMy1VtJ6w/n+cAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z83QOGVD14jfAbguePGofZ7uYi45cxjaq61xG52ovs8=;
 b=i4kdaRYd1Kvm2LI/4JbfwDA/t1sZ72qI9vo4iHHvf15f03tO2UGorJf94eTXJRipCIgKyqlRVtqJnON+y/sAb9U5TZRfT0Xbd49STFHVINtBrO7oyG6z0TI5rNJz/1IKYvxFQ5CAnESBmr80M20c74sH9az+8gpddLBGWHuiLCeQt/eK1FyZf9unqwiHydGAXOAMk68pQI7W3nFkLVOzLqN/CSZ5dlxKC+OxvG8XM+JyKHpxH5wzf96PoDglbzVHXoqmOX5vOCjLAVJtAmBdRYs8El+6WlncXEyaILa9CfXhNprWrTkBg1NbnvNBmNkTFecsyT79C/DQZ86bQBZ4qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 05:18:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 05:18:36 +0000
Date: Mon, 19 Jan 2026 00:18:35 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Samir M <samir@linux.ibm.com>, Vishal Chourasia <vishalc@linux.ibm.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
	sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <20260119051835.GA696111@joelbox2>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <9e57a091-2f34-402a-972a-31dd9a10664b@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9e57a091-2f34-402a-972a-31dd9a10664b@linux.ibm.com>
User-Agent: Mozilla Thunderbird
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: cf843dab-bea5-4804-2bf2-08de571a32d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PNgxhwLPnoy+JfUms9+lW0eOnTwT3Mvrn5XRv3dk17MkncUViYKaybEUoDF?=
 =?us-ascii?Q?rWHUehCRx1PDNkWlSmTYC9VdtQPMNuScYmHhyR4bNOEPFZmCxxufGy3Q8iSK?=
 =?us-ascii?Q?mVEZsFeBxtjNADwMh8iBLaE/w6plk9rpD9AWbXUN6Nho/iYFL2wR55nkrkTU?=
 =?us-ascii?Q?kgt4hLl+/uuLbAM0Dyp1LKis1OS9nBiQzYPITdaFIMOZJw1Nbi9LydO09CL0?=
 =?us-ascii?Q?XiIdmCizLqF16ByW9bugM+aPQezVQgsG08fKLsqkNmTwaUgG8p7eDPPmqMjv?=
 =?us-ascii?Q?vicjMPdKmM4pLEz7MVX2ubxWss3t/eKL+Y3OzlzMxfDP3VhIclzlp/NbFB3W?=
 =?us-ascii?Q?x4sROOqmBMq6KfYvbSwhgO6J4Af0H/L1Zu+oZgepCyyOotX22doOo4Ez+Npp?=
 =?us-ascii?Q?THLym7gxympujb5iuuYaPWxOLGZDpQQmtb6tnUhHeZ9zbO++qC1866isQ0fE?=
 =?us-ascii?Q?qXVXAVknwgXmEfaIf+3S/qzbFShrq3Lh67x+WtIPeROsTY9vHACrR4hQNO8t?=
 =?us-ascii?Q?elPbmv8yVhLgVuQrs5kqV9WU+Nm1RXTJoYvyQn1Q2tg/4egOVvv5tmycT6LJ?=
 =?us-ascii?Q?EOGl6G0VCW/81G4X36hXqCG3fMEsvx/r5fIhXymR2DKTwEBzIQMch+Wjtrl5?=
 =?us-ascii?Q?H/sMfQ45YplNcNzfa+d01CPjuOAKV10g0gI4GIcfKi+l/BUfR93w2tCctNEO?=
 =?us-ascii?Q?ONWOu8cg7f0puHiqP9X0RbxjI4vCmN7dExGQxgv7n6LW0728oWrkwpEtyuN0?=
 =?us-ascii?Q?vYPAKTfKzEprnO0qW6DgDEJutdltLPixyXh/RE/4nk8vsUC+y2KPYjy2kyLv?=
 =?us-ascii?Q?md9zVldLSiinDXuJvulD+nwp85zOAth4uNYqobtTbmoOImrYXVvZ35YdWI3u?=
 =?us-ascii?Q?XtxDiT/4SJksBp+je9h7WkKC+ZznOgH4NZTmK8gc2SwvJqnspPIT/NTUNrsB?=
 =?us-ascii?Q?ZZDUekpadnEg8rlL1zNyqR11atnC9lDD5IOm8tbwhzPZQ2CVyLZLdwZZQswI?=
 =?us-ascii?Q?nx/LHpI7OHoCIGDniDRMFAYdbr9dtLp5VG3TVKuKm+hyjFzTNWzZMMN9fXro?=
 =?us-ascii?Q?/xp03p+Y45Bk1p7aAIqcm/iU3MURHhWu0ZweZr6Z+HVdL4fbL/5+HUda/igS?=
 =?us-ascii?Q?dcflRRW8dq80qa/+I9d54m7rpX2xP7enYQCwLHDY6Qy5+VgaQcnhhDK7LI65?=
 =?us-ascii?Q?e/haFmGqzPkCE1WwZLSJroXR6UXmYovSq04ub+W96v/bmNaa9Qz82A+DurSb?=
 =?us-ascii?Q?dZ6xYHZVkcs4syuEv+RXTUtcdf73CdQ8VOV5PzLe1BiiVKJaWx4AX5rD9xe3?=
 =?us-ascii?Q?uQFYcZVt63N64AaF7aqwnWDw7EF+h1ZCDhY5QYQJGtw7mUH6phVrBmUIXbVl?=
 =?us-ascii?Q?bXhP5AZHjyHz9rdDnuBA/kV6qzamQRmipY7kq2ojyKqVgZgM7DvY+kjsdSnN?=
 =?us-ascii?Q?Iugw/hzoPwk9YCYQiJXN+2CugeeFrKuqWrwHggTIXLyneA7cag1Gd+BWe3Af?=
 =?us-ascii?Q?VqxKPANaR0hwOcrRywNETJ+fR14cyRWMkomkJrOZaLQEONImmHHcOimagQBs?=
 =?us-ascii?Q?sK3IV4P1vGApu5kCjzI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6B81Iy1wrjZvERyTcrdaCYqqF1GaO5zlQVe9kf/Q02ooR/eWfUmUm9sXEcc+?=
 =?us-ascii?Q?UgPbpmKOpAQBt4IE/jiqlbppFrmxVbk8d1mFYUQPNz7RlQgzvlKOqay0pbHi?=
 =?us-ascii?Q?ft78jSlorCn2u/NWEtEvnxn3nR3Say1BUubCThQ4KQYpFUaHV3Gz6yJIOXA/?=
 =?us-ascii?Q?3I0gJkvXOCCl0eFJABKr5+DfzQQSTiFaFLElgrjs0q3XTwmdrOaBeIkKbmGX?=
 =?us-ascii?Q?BJjxH5wJvXA05//D1fzVRendeCMQd/zP84xQFUO0w7tczkta9HXziz9OGtN6?=
 =?us-ascii?Q?jzqzhvhl9JVtB8ovuaXnn398+MIJb8LuePDqRF507JG8gW50jXr0ufLINCqo?=
 =?us-ascii?Q?RP54YqbntqMGhnQopm0qxfGrv4UzuOnMucsSFSdJfN6JK5G/Dwiq+WCaw/Pq?=
 =?us-ascii?Q?c2snBzhRN3NSAWBLjiqyqixLNGhcO+LiDiEQv/Auhb2uAXB+xUTj44VT0sj1?=
 =?us-ascii?Q?al33RazjD/aVYlkiAIQsEUy80FkcqeNil8DFGkMuI8TFOHmodFl41Dyh4ASM?=
 =?us-ascii?Q?DwyBtdFyZQR+e369rPDXzF12jjt0MByCmWIQaT7wcnCwA+NFPGC0CnfHS0Ae?=
 =?us-ascii?Q?rf1ZUnHT4tgUBzZXIj95niFZ94ZJflAkoCsOUgZBrOlEFOvoMuD80VUHkR/L?=
 =?us-ascii?Q?5xR7beM7jna7x1lCgPgNO61QfD+ziEN2XysmlvjSNxExw13dLWq8GVc4RPBO?=
 =?us-ascii?Q?tM5RLz+WvhOaiK7kOS84720VJmsUVxsr87agBjXhEKnnbD9hAD1QjLONylRH?=
 =?us-ascii?Q?8Jkc3QbPbT+iPjSE+kp8IOghLePqRaWKgUi6GSbvuyop6NLNwjxJuaBcnzW2?=
 =?us-ascii?Q?j08AKDPANmBPsd6MDIZ5ea7K0Z0Rlg+j/4aDOprNpLPRCJo9680FieZHcRAX?=
 =?us-ascii?Q?Smjl+P6Lc5+IDM0Y05htJGAvIpaGADJfKmR2M1HKye36Op3fgUxnaQl/H6Wv?=
 =?us-ascii?Q?4mtifajeF2Cod7QEqFy0XGbwQTsLdXp1tnSw3kekKNK+Ad4LEj2CsqU8A7HT?=
 =?us-ascii?Q?OY+e3IBY44cdWE3uGJMMba+rYl9URL/pmQguI4iNWsAtwfaywItWYFnJNTRB?=
 =?us-ascii?Q?+a8vmEPljCtu46iszGWNRewM2aVRnVrwALMUKw5lHEGs6K0T3bCd8uS66qF+?=
 =?us-ascii?Q?hBmnxyBPsdYlGmQgMHzopGfOeQX0wvaBWLrjD0tGHdWm8yQpSNuTV1EqIPfJ?=
 =?us-ascii?Q?JpPldyl3pwImOXg/c9tARp1u5/Kbl9FgnZpTh16I9yV9nUK3o5MBGTowQedN?=
 =?us-ascii?Q?g50Rn3hKYKReu8CASAgb+lCUbeudhxhEUpElllEutDo6yir9BDYrwNycXA6A?=
 =?us-ascii?Q?vYoQp8edoeF16aR6XCWEfi4RON1L4LHYjV93euLCEANa1ex+uJyDvldVCqOj?=
 =?us-ascii?Q?mv3n6DxfVIhGpAWS8sGa1PIedjYPuLDZHb/c2FjN2pT3mqWm5YWluxGKl+OJ?=
 =?us-ascii?Q?ZjaA6fpEOFKOApNWpuxJDN10JD+gpisJGNZuQYFDl6/fLc6bkVJ6E5II2NGc?=
 =?us-ascii?Q?GsXCcSf0LSMmpDAi7sirpXR/ppWUuGx8OJSrPP66DzmzIDSOBK3ftVJKR61z?=
 =?us-ascii?Q?b/on9S2Zx2f/EVhwb0vK7GPW4bjGClyxQWAFBTI0b/WQTzxLUIdDHvbr54D3?=
 =?us-ascii?Q?4s/lXKiB/I+/A+AoejGh9g9Z7hrc3YWImJ/Y6nvXeC/yfMyLxFGbdmcqCpGj?=
 =?us-ascii?Q?xLgCj2CJMu1xtMZ3hiVdNvR9N//NzLXhU9w0L/3s129DKIst1nQqioth8+AX?=
 =?us-ascii?Q?zFzB3qOPJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf843dab-bea5-4804-2bf2-08de571a32d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:18:36.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmgixy+LHIUMpItMjWuiZvQQSVozfrq+um/e9jmehnRe/gpfowzCzWJ1F2Xaxn4EkjcyqJsFUBMwb+oAVkow8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

On Sun, Jan 18, 2026 at 05:08:44PM +0530, Samir M wrote:
> On 12/01/26 3:13 pm, Vishal Chourasia wrote:
> > Bulk CPU hotplug operations--such as switching SMT modes across all
> > cores--require hotplugging multiple CPUs in rapid succession. On large
> > systems, this process takes significant time, increasing as the number
> > of CPUs grows, leading to substantial delays on high-core-count
> > machines. Analysis [1] reveals that the majority of this time is spent
> > waiting for synchronize_rcu().
> >
> > Expedite synchronize_rcu() during the hotplug path to accelerate the
> > operation. Since CPU hotplug is a user-initiated administrative task,
> > it should complete as quickly as possible.
>
> Hi Vishal,
>
> I verified this patch using the configuration described below.
> Configuration:
>      *    Kernel version: 6.19.0-rc5
>      *    Number of CPUs: 2048
>
> SMT Mode    | Without Patch    | With Patch | % Improvement    |
> ------------------------------------------------------------------
> SMT=off     | 30m 53.194s      |  6m 4.250s  | +80.40%          |
> SMT=on      | 49m 5.920s       | 36m 50.386s | +25.01%          |

Hi Vishal, Samir,

Thanks for the testing on your large CPU count system.

Considering the SMT=on performance is still terrible, before we expedite 
RCU, could we try the approach Peter suggested (avoiding repeated
lock/unlock)? I wrote a patch below.

   git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
   tag: cpuhp-bulk-optimize-rfc-v1

I tested it lightly on rcutorture hotplug test and it passes. Please share
any performance results, thanks.

Also I'd like to use expediting of RCU as a last resort TBH, we should
optimize the outer operations that require RCU in the first place such as
Peter's suggestion since that will improve the overall efficiency of the
code. And if/when expediting RCU, Peter's other suggestion to not do it in
cpus_write_lock() and instead do it from cpuhp_smt_enable() also makes sense
to me.

---8<-----------------------

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] cpuhp: Optimize batch SMT enable by reducing lock acquiring

Bulk CPU hotplug operations such as enabling SMT across all cores
require hotplugging multiple CPUs. The current implementation takes
cpus_write_lock() for each individual CPU causing multiple slow grace
period requests.

Therefore introduce cpu_up_locked() that assumes the caller already
holds cpus_write_lock(). The cpuhp_smt_enable() function is updated to
hold the lock once around the entire loop rather than for each CPU.

Link: https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
  kernel/cpu.c | 40 +++++++++++++++++++++++++---------------
  1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8df2d773fe3b..4ce7deb236d7 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1623,34 +1623,31 @@ void cpuhp_online_idle(enum cpuhp_state state)
  	complete_ap_thread(st, true);
  }
  
-/* Requires cpu_add_remove_lock to be held */
-static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
+/* Requires cpu_add_remove_lock and cpus_write_lock to be held. */
+static int cpu_up_locked(unsigned int cpu, int tasks_frozen,
+			 enum cpuhp_state target)
  {
  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
  	struct task_struct *idle;
  	int ret = 0;
  
-	cpus_write_lock();
+	lockdep_assert_cpus_held();
  
-	if (!cpu_present(cpu)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!cpu_present(cpu))
+		return -EINVAL;
  
  	/*
  	 * The caller of cpu_up() might have raced with another
  	 * caller. Nothing to do.
  	 */
  	if (st->state >= target)
-		goto out;
+		return 0;
  
  	if (st->state == CPUHP_OFFLINE) {
  		/* Let it fail before we try to bring the cpu up */
  		idle = idle_thread_get(cpu);
-		if (IS_ERR(idle)) {
-			ret = PTR_ERR(idle);
-			goto out;
-		}
+		if (IS_ERR(idle))
+			return PTR_ERR(idle);
  
  		/*
  		 * Reset stale stack state from the last time this CPU was online.
@@ -1673,7 +1670,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
  		 * return the error code..
  		 */
  		if (ret)
-			goto out;
+			return ret;
  	}
  
  	/*
@@ -1683,7 +1680,16 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
  	 */
  	target = min((int)target, CPUHP_BRINGUP_CPU);
  	ret = cpuhp_up_callbacks(cpu, st, target);
-out:
+	return ret;
+}
+
+/* Requires cpu_add_remove_lock to be held */
+static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
+{
+	int ret;
+
+	cpus_write_lock();
+	ret = cpu_up_locked(cpu, tasks_frozen, target);
  	cpus_write_unlock();
  	arch_smt_update();
  	return ret;
@@ -2715,6 +2721,8 @@ int cpuhp_smt_enable(void)
  	int cpu, ret = 0;
  
  	cpu_maps_update_begin();
+	/* Hold cpus_write_lock() for entire batch operation. */
+	cpus_write_lock();
  	cpu_smt_control = CPU_SMT_ENABLED;
  	for_each_present_cpu(cpu) {
  		/* Skip online CPUs and CPUs on offline nodes */
@@ -2722,12 +2730,14 @@ int cpuhp_smt_enable(void)
  			continue;
  		if (!cpu_smt_thread_allowed(cpu) || !topology_is_core_online(cpu))
  			continue;
-		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		ret = cpu_up_locked(cpu, 0, CPUHP_ONLINE);
  		if (ret)
  			break;
  		/* See comment in cpuhp_smt_disable() */
  		cpuhp_online_cpu_device(cpu);
  	}
+	cpus_write_unlock();
+	arch_smt_update();
  	cpu_maps_update_done();
  	return ret;
  }
-- 
2.34.1

