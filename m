Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060253A1E96;
	Fri, 26 Dec 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715366; cv=fail; b=Yu6LlyHT1XmSvPxUW0+8EO2DzWNE62Sw6lCzr+qL6xD19YKEjvuZEYXl17i5JkaOihZQt4lDYWy582CO+YJ+nzyqL0SoSTeWyyGoxWfVW8jM38Jjsqzp5rR8/xmuzbwnR6u7Bq8Ml9MAgLZXiMkqrYgoaQASDWMULjLTXRkzd6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715366; c=relaxed/simple;
	bh=sL376l6KmWHIMQwmIkk7GIvCCmQ6/0tIomXPu+RTfH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uly+l62qqiHpzvyW67DDLeiHb/yvzfIR0/XSXhA6GrPvV/obD79rFK9vH+3OL1nYt3LIi1F5b/NKEBcnn6vqjEP2MWaqmnZoznhHuX+lNnVH5RMPyFoGxw2KWJ/N8+TfMZFaco5L740yoCAp1FSod5Dzex19HILpfJnc9yRST84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QejCYkix; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QejCYkix"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOvowQ8XNwMGICINYbS0Vlrs+RvhBJTxC3nl4HLQoayhXLCO19iCvSsSrd7h2EiOn1v7KjMzfeZ7Dtf9v3KQh162O2U6ZsXVXJhr8g1ZyGWaAPj1z7ifnWnn9ER71E6AzeeHWJbdRR6rJFDZVPRMgncleotfXMDceVE4ZIIzB3nplAxeKkeAlVgMtEtBayl7m5/alHoTrp0WubxwW64NUgXaX8j98VosqTvm3+wMdk90w/anN1ZHMKZYJ8P25JX5CRpuS50QXC8AMVkRlo6V0ZPHcN7sazXYZf4Ionxh3vE5XI8s6GJEI7UxvJxQHKjKN980osevEJA2x5pyDTksiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcq+B3LYKN+V3Ikd1FuLrRlSs0cOQikZYRWzA7CgjZw=;
 b=MGmPLa0RZOp2WYrsc3JKAGg9kkjVaeBTSXnkbjuDr1ZMTa7R9G8WDGzS/1cHU2gahMLY6nUe24FKlx9apeYhZPNfLvtDr+Jy1UjLGnpVXaFHdh+JGKe4pl/7pFcPZ4RAqX3YBwwyQpXJD6/LrP3h2461rFvW620qY32NX6P2AfKiCdoE3PYO1h2AEXaBqYVyjKyHWtrSuj/SlxfQeT/dGMWYhIdCFRD5V0jC8TDEVyIgPvPZEK9uZ/TNzEwosSdj+ptr83X5SVMyjwepEiwYOxlPjfEU9BNBT9tv4CTodCMjyPkFmUsMMl7GC1xEGgNGMrj2Jiew5gmnCPN/GwprnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcq+B3LYKN+V3Ikd1FuLrRlSs0cOQikZYRWzA7CgjZw=;
 b=QejCYkixxoedLg2zsOdsyFutYL6T7aJ6BmlpDI01nm6QBGc9DW8O710T7nuf8UIL39TC8cOcVQfAZ54I+YKTQA7mDe6KjjLjFOGdKfAnyALdOlivQvkumPAgbY7cOjiNHcTfbZHCX7anBPEIyea5RO9XxrPqo/kXCIgHMCYnM+8krphWwqxY5DFrjLscPqS2jeQWzXHgOznoS4bbG1Dy0atuNoGF6CCp+w+IImh5G9jZpwjJAM6SlrDPODqqUfVOUx5+lPTEnNlWdVjQly0C0dzhsR3shcUPmeFQLAaeFGOuXeI4ICm3n2XVyN7z62ZPwR5Xb50v2CIt+u0bMESddQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Fri, 26 Dec
 2025 02:16:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 02:16:01 +0000
Date: Thu, 25 Dec 2025 21:15:59 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <20251226021559.GA949635@joelbox2>
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
 <20251224020619.GA1297269@joelbox2>
 <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
X-ClientProxiedBy: BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b662978-83b1-41d8-be10-08de4424b6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkgjI6TfS92sWSijudzYuYgouso/wsFnk19+wp8Z1fyfQu+nUOF+GAVRVEMe?=
 =?us-ascii?Q?BxwtaXLtjn/WSOQ8PfEsLyMxXlSEUalrOZNJGL5lvnlA4H969xh68I0QMOQO?=
 =?us-ascii?Q?Xo3l3kzVfcNrgaUyHLO2lsZpfB7D6c1PjmfnOMAxxfMmPyiOzaWNEgutyuwa?=
 =?us-ascii?Q?K3oLm9/oWxzxigCzSNQQ2r6SiZEJx+liQAFaVs4R8LPzT2Ycp5EH8xe94csh?=
 =?us-ascii?Q?lI+N+gAx0IulD6mptNvVexseeb4DU/H3dGTq6UCk34WZ4+P1ZyyZdR3ILH5N?=
 =?us-ascii?Q?kSvfWy23tjHbjksFU//S8dRJWKJAFRR7S4BiSu4PuEc6SAwDGBm2405QiYw3?=
 =?us-ascii?Q?4bi0AFAFPkRzlMe6x297OISA3b0A65BkK3l/LjZWV0/IgisD7H5mJ51H8Hd7?=
 =?us-ascii?Q?QCyRb0QWAjaO2FXYc5gfxZU9vN5C9TE+Hdp82CEJu2XpiCshuwbiPOycx3nn?=
 =?us-ascii?Q?8iVG4AL/ceMebfIyYoNKu8Ad1aarm9EIaMew4uXv8tIG3cxKmFe5SzKyjuUB?=
 =?us-ascii?Q?qw8Cg2jifCDdkkdlQBJKf4M2Rrjk26WQ3MuRXy35InueQwOe2zCR0L6M97Lq?=
 =?us-ascii?Q?JRCHCkhIzQRuVZikLK8c0ytC7dKVdkIpmS1fMkDY6PNIL7b58ODXDfFCw6n1?=
 =?us-ascii?Q?aISgag184EVSTUIsQdxY5Mm+mLBoM8/yU8k7Hnx1Ui0+octooj9makf0DTlh?=
 =?us-ascii?Q?xvcQU8d21I4HfyLKZ7XrAl6N5DsTpOYRjxhsvbhJAI5EK4yZqhFnMUsUuV92?=
 =?us-ascii?Q?WNLmFbbIg4wsAF73nIV0JyR+YitV/jsTKu+VZ7I82LJ4d3+jyGRObyc1YJGA?=
 =?us-ascii?Q?o8J1FK5Q9uDVRI71vLA45Fh6jPCQAunN9KDdScA2MMZx6YVOqm4BrOZigMm5?=
 =?us-ascii?Q?3aXEP+6ehWtrhkcPPJ4N7/CBmNYB9H5e0KRYDaiTpov3z6UzToJzhd91nHG8?=
 =?us-ascii?Q?owRn2dD724YGZxY5tQvtMS8S24fW1jzmEGP3mfRM4Uu4mdwXwgaGsV5XP2Xz?=
 =?us-ascii?Q?RQECAL+l+wFSMun9hMO7qL2YbF5jh4mehaFtbB9Tkw2zFK+/0Ry2G/sJlygq?=
 =?us-ascii?Q?3CCAm+ACm2ex1dvMhkE4hCmFuUOkxwCgeHhyFEPPIaTUluON38l1rgT1pjea?=
 =?us-ascii?Q?zqdB75FTdG4U6Rmc3640yegu8Kjt4YNLO1Fb7/E5ghiYHa22pOK43lQ3lMea?=
 =?us-ascii?Q?GsDmQVhOe5dFJkgmm3TNdgRfH4D6cxC2gnsoVdfjQzOICuC/H2VbwpX2RT6a?=
 =?us-ascii?Q?gm/e6Co3vyoyjJd3YXMNfCvW7Nf0yVFM9ySg9LzfaLKM24kdQNOX4P7RvQn4?=
 =?us-ascii?Q?Ir5D7lBcxyYBF6b7TJJmi7h8ELYUONZm3OiawbRYtuf/w3qvgjcMp+bYmSuX?=
 =?us-ascii?Q?WZ4iPMlWv7w6Ulcp3USGnK7d4t+uyvEuZGDWvg4UDGFIdtlUiAp2XCt32x87?=
 =?us-ascii?Q?j51tKbCUxJ2MmwboPlY2peqSw8R/8yp7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXUUVCpu8MS5DziZyfYKRYA/korJhfs57N0hFjd2KUzzbhJdtZ9yJ0XVPDgv?=
 =?us-ascii?Q?mcLRAyZvr8NYSsiOdZh9WpnqHrtFByHU6+jsi8hY9DYIxfEyYsjfgVulvUvU?=
 =?us-ascii?Q?6UjoJp6lY/NDbK4Y5Xh4CRSztYe/B8rWNXalV02W4xEHXAQVoDNM1hMxkqkx?=
 =?us-ascii?Q?+2RGEnOIzuMwMARxe1qYQjIvwCTj1JMqsrbmt2ATP4XyqzR+hjc+QM9fifIu?=
 =?us-ascii?Q?wF18uM05ebB/8WTpo6v8btXxA+YYBuuOVNPvKiF33jugyUPFzx9G89NfkoSt?=
 =?us-ascii?Q?vaWKF7Z0m4ivoIyoMV82/598G+hkyVx0UD2OoNeYC+CbpOiHnxmXKK7QrWSO?=
 =?us-ascii?Q?zLpCa7md5jiJVujdlNKrnRiY3OjnDMpd5E8j4VyVSkVImQXJD0FhqKij/1kw?=
 =?us-ascii?Q?5+hXZTNlDY3IcqyVAPTO1/Rjf3OEFIjH/ZmplYG0m34JdGVUSv2DVuDDgiOy?=
 =?us-ascii?Q?eIuGZ6hUN2A2hzsebrIRCKur88xKurXvGbwQiUZNHZZ9fThVUSg6tQ5cwuhM?=
 =?us-ascii?Q?7RbavwGRd4AmKaKi5Vrw6JCPYcQTSOMQBPyNiqws7KJXQjkSt47UYNj4mRCn?=
 =?us-ascii?Q?NfNfzWzDIs/Azu1r3DsVUX4gqtSLVh94P3Pe9mJutUEvMhPzvdBBaqpGHnjK?=
 =?us-ascii?Q?G+c5VVTRq6i6/1uGGF5IFznjFYWw/2MsJiQ71fD8Jmk4e2FZAqklCtH0nCkM?=
 =?us-ascii?Q?27RKhMTRlhOExXNBQ7t1HOtIDUTV3dzuRnvdC5/56zgIqH39qCrVLHGf7deN?=
 =?us-ascii?Q?E73JWILgjKN44ZprIVzLqdlRjeMZB+9jxGIokWZdzc54NJ4WOb4hLKGpkS93?=
 =?us-ascii?Q?7GWngQbnp2Z+groKzTFsPsFxDs6laNc830KsemaHTrGSUHimf3f0XOBemyg2?=
 =?us-ascii?Q?rqBGdgjEDxz/VSxg3rEW3OpkRJERCNdUY6aOv84b3z7CsMdr7C1Z4o1/6vcD?=
 =?us-ascii?Q?4njVFjjMqip0/JVQTN4IBuoXPjNQSVXUu+FEuqh14fv6x3pUDYOWu0QPf3t+?=
 =?us-ascii?Q?bvm4dqFdMLhAauh/mDSHNXfqMGenm0SeFeFiHWNqxNoTDHYwIObpAkEl2il7?=
 =?us-ascii?Q?NSiaLlUZAezmt2NveNJU3mofH1rT+UmjdTDNcLXmuJNq7i4pyr2rE8tVuWVC?=
 =?us-ascii?Q?+q5vjWzhbI4Y3erKQFN8HfpfWIl7RftCmRK+TqJIbjF1Jd7eTmr/J274GSlG?=
 =?us-ascii?Q?mmJQSeLfgL6iTpZZdws7j7/CF5GX8a9cc1UTgu70j4Zbl6Jq2i+/iWTgF7i5?=
 =?us-ascii?Q?eB9PX7fwaDwix6T0DeXrE798iXLLeHwMlGOyFCYRxyPqxRgTxe+Xig25uOIm?=
 =?us-ascii?Q?qoKzKlN0goFZ+vfahe65TxETWTL9I8x48Def+DIBDMQs+7wee5Rs/g2HDjQa?=
 =?us-ascii?Q?CuIaLTUwH3+Bf/W89pNhu3lNjhixUnxeUbDjBaJ7BMjpWsB9VmH4dLSsPJZW?=
 =?us-ascii?Q?8g1AUFNOQqiTcgUObSyjJ6zUssbURS+jiEHkgKsA78YuDYmmPf9XKqA4cs4C?=
 =?us-ascii?Q?hwBtXTs7pcv0sBvzsPTtsFZVK4By5/IlzmVA7y7OgW7o0B5jLPtY/tuGk+kf?=
 =?us-ascii?Q?tfAfatcFrEoDdRptwEuKL4eWBTixIOUYuSGAbGzNj9X27Z91HSSLRwnC0Piu?=
 =?us-ascii?Q?9wS+DqirtTYAXDJ9OBHxGJpKGW6witToqL6oxk6jtOQpoJaIuGvStVaLxp9z?=
 =?us-ascii?Q?mVQ4SMk2XxwpESrNKW/h4f5/4nrKIgq5Ism985ev06cWTfeKVpsoJw0TdP0+?=
 =?us-ascii?Q?ucJD4J0QRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b662978-83b1-41d8-be10-08de4424b6d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 02:16:01.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFCmx9mUVruPcgdOG77nTGEokJCA0v63vs+4K9960yL/7W4/qePFHR4vqEBmLOw2d4wAnWbr/x9E05VCs15X6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
> On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> > > > During studying some synchronize_rcu() latencies, I found that the
> > > > jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> > > > off by one. This is natural due to calc_index() rounding up.
> > > > 
> > > > For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> > > > is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> > > > never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> > > > to interrupts.
> > > > 
> > > > Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> > > > before passing it to the wait APIs.
> > > > 
> > > > But before I wanted to send a patch, I wanted to get everyone's thoughts.
> > > > Considering this the RFC.
> > > 
> > > Inadvertent passing of the value zero?
> > 
> > This should not be an issue because at the moment, even a value of
> > jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
> > 
> > But you raise a good point, we should cap the minimum allowed jiffie value
> > for the fqs parameters to 1 so that we don't pass schedule_timeout() with
> > negative values when/if we do the reduce-by-one approach.
> 
> There is a potential use case for jiffies_till_first_fqs=0 and no wait,
> which would be systems that want to scan for idle CPUs immediately after
> the grace period has been initialized.  Note the word "potential".  ;-)

Sure, we could add support for that but that would be new behavior that is
not in the existing code.

So jiffies_till_first_fqs=0 today, I think it is not 'working as intended'
because it will never not wait I think.

So we should fix that too? Or maybe it can be a patch separate from this
(that I can work on). I think no harming in allowing that mode, at least it
will be more in line with the expected outcome.

> 
> If we want to support this, then perhaps we would need to avoid that
> schedule_timeout(0).  Or rcu_gp_fqs_check_wake(), as the case may be.

True.

thanks,

 - Joel

