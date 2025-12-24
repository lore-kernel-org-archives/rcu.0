Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094E29D27A;
	Wed, 24 Dec 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541985; cv=fail; b=peBZZAxHvWx9Ddbj0qUCdKAusmWGe/DJUerzG6FELz2yuYwGNJ7CzphIIo4yAWEUqaiwFbaxdWKEEimQjmL1Mup1+OW81c2s2+AZ5V/hJ+lEuWeBp7OCqBq7CvytQFQymSE6rDGK2PZBMyHRgczha6ne5xX18LX9YkLMq0YMRC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541985; c=relaxed/simple;
	bh=BHUh91YhZky9F/DjVD1PVMq1CzZN2PM9vFmpKKkfqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iwn7vcc8fZFzCrYGo1UdisYsVSNLTucssUJrZLm+sm4LL622ae+AEVcdGtrirzMEm9DqvZW6oWioMyYH4X4wWwK6Dlp8LC5EOfrn3qmEy5ZT+5MlcwzWVQ7aV+5aD1SiuszJrXekg07xCM7qU55KicOCwHYEeTD7q4PTm0eKFwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCRMWasY; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCRMWasY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqqlDkOUsY27WSHqcdX88MrvhUGrmgm+Ki2tWYbptXm9ObVcD/+dSOnOEYpuwEUGh1MV1RZQ926eD5LKNO/VYbvqX6dA4BoXBC58dEGS1DdkWHDOB9cO9W1VHIveU6L8zS0n6ylSC0RnLjCatg2YSnteShc3mXTVPfBPscSBaNsbhTlFyakLph7Gp/KpUDdfw4b0Glcql+PhdXusrriGhjkEo20vIqQijcf94o5MxKjUcl+fpmFpJ7rPZIh+Tp6uRRx+iCa6eLmbo36ZTNlSWSukKGhzTcUYK1tfTdXM/JHWQY6tuvKJILlDEODhmw2gRqjPBDzuxmckyXt027wnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPFvH/5Ou0acJ83F1vFWP6Bej2rayY4KY0mIJoMAGgA=;
 b=vbexjW00CdurrpQGRiKJ2YTqbqfb9JKkILLaKNLiiImPqn/tMX7xb/3X+9RX1INIQbp48H3FlAMEh1DoNryFq8jm4OoDqWmocQW8XH4kMDRawW8LhUNi8u6s3h+aJMGTsPkTmBJOrUPfpKqSpEnlOrQEwarc6Qm+2F7jFeZnFy5juR1GuWBmme+fSZDtzMNdW9IvJXVVP4BUxuUE6uxS0tEEoV+KEjg6yoWhMqKvhmf9iWTLEWOXGFN7vD7dE6vkUenrwf10ziFPUpyrwQkVSCFcXLmvFAwf6f4x/ym6koWAqj2vmYFOnETchX4iaBCPVc5hJ3IAxl2hlbHCaTo05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPFvH/5Ou0acJ83F1vFWP6Bej2rayY4KY0mIJoMAGgA=;
 b=YCRMWasYK9G6+1e1uePUV664vcVS3EFJEWAx5QRu+2X/O6zIAIE5JkGhYgxaJWoToBSKLSdLIRCJYN29OeKk+qqHhvvSXzJKagkGYusTZwk5SvzfvnTk8FJujOq6w5O1xxWpSjGzpHM00z4d+oJWe4K2qLz6ntXwAazFaLchVjsIknrQ+fCj36M/cy4PeeG/UPnCFRDfwMaibpHlTzN0QL6MCCagQrOvQQJ3PrODMJBiB/VBmCTfOj3QXJhLP7FedPy0J89HxpRH8fwQ7W1TbYnzw1UMT09TVkXRGCiBnoI8Gxz2UmDRGYJ5WeAxnRLr7WfL+JTCiZoSPEXnLCnfpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 02:06:21 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 02:06:21 +0000
Date: Tue, 23 Dec 2025 21:06:19 -0500
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
Message-ID: <20251224020619.GA1297269@joelbox2>
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d36ddf-b228-4949-81ba-08de42910843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BYcN23gErQEBrDxeoRKawLqHveFOxW7TrIVx88ryegvbp3wmNQH4sCUcij7K?=
 =?us-ascii?Q?E+o1cfrVaN8zCWvkJfBzq1yAunJ+k8KNsFZJRMSrX0wKRjGTNkAD80mewbI8?=
 =?us-ascii?Q?cBffM90DFWT/X34HGkZwu8Q1gSFXKRaM3WRzuLqrxfwbC6Z7YpDm6g6nQfQg?=
 =?us-ascii?Q?t9SSON/8KBCUYUuJ6gEDB88aLnh8OHYGMjmORnGDka+i5HRcxo2P4GnbsGKJ?=
 =?us-ascii?Q?ktjC9WfsDxY/toN+gTRXFLC5X8y5Zk5WKrIBU/r/lZcktbpuBzZvkp+KmsQv?=
 =?us-ascii?Q?btxVVInMVK7stEJgZ8PcbvUrat48VaYesgHr6iAxIc8kxodAML0qyVDJMRFr?=
 =?us-ascii?Q?eSz53oAOUdyWOPkyxCiIxJwWQGjTGmE7aZTNpKu8jrZqMgtzwsUhy5hP5vnx?=
 =?us-ascii?Q?DC4klSY1nJ7Nk3Todx5eiLMAOmWaTo88rleW7iP7o6Y9iW3DFy8ghB2sRukQ?=
 =?us-ascii?Q?Dbo9HJf/e0tnrq891j+WpOvi0v/IkMJsxGWpJH7RxXJDqN6d+wbGcATfMBj+?=
 =?us-ascii?Q?xtpHkouhLj1zsv6G4RDpZJyGvMHX+XGkVJTBb0JMkHgqHiOX+1//c9Iz/CDE?=
 =?us-ascii?Q?rf1HH4fJdxN5xNTvD/TJBG3mKcyY22hAceBA4lGc57YTo36EqRc73W33v233?=
 =?us-ascii?Q?sEAVWhmUCJycu9/E4aroli6tE/ErPAJcOUbIEdSBlLKO2abX2IV+25j2WBZQ?=
 =?us-ascii?Q?h2/Sa9L6yRqooSnpwQpsw1GMFiCXfFF1/O/uAas0hbjTLzIyZPf3ib5eG782?=
 =?us-ascii?Q?fMiEDVJrvvPlkJWUV4MFNy/AF5FkDbPawT8isjb9LIRVKNnjy75vcYWz0mvX?=
 =?us-ascii?Q?dXjUJNFmx9/QTCTp+Arwuhk+gK7s5t1mMWodyeBiNI30W42BOrepf5eFfeta?=
 =?us-ascii?Q?ZaqBBGVJ2MU/P+FfVsxDeWuWMwa6IRt0cG/iFzyMfjQ+06jG7+tllM8l0ad8?=
 =?us-ascii?Q?SMA1J2OLSGRQU/5ULNtj1Esu/cUlXZlNZBeOtAf4q5mHILg9ZfMWcsUJ+Mqx?=
 =?us-ascii?Q?TJjyHfvvGABTt1TiZAwP7llSyIhho6BKf/RWCaugFOBWDZTY4CCEe+WCXvdA?=
 =?us-ascii?Q?l0wXE3CjTmOyZx2/1jPOT/zbn43RNdVonLYGfVrdS6WOvENqRYqKzLc62v22?=
 =?us-ascii?Q?Gwxtbvw4Orqc2wJrpauWTC99ezdBcZBQ+RoTYW4sNTbfu2quC77OPBMfyQTh?=
 =?us-ascii?Q?1G5c5Sc3Y4FDZG4QaM4CtlUnZF5BCN5Yu8+CqQkPmnY1mz0tp+vpEsUNYI/q?=
 =?us-ascii?Q?Qtbg6kFB1kUjgQet4oWGR35XNCcFx6D3ZZAGu4krrM0nnxLwFHcnudcZz5xJ?=
 =?us-ascii?Q?xPEiteYBtnrveoQQpWbC1iuZpCXcOnuMJq7f1KliOPNI5Dra0MaSoF6Qzv49?=
 =?us-ascii?Q?tK8+ItJw+85PvHoJGnNOsMp4InF/5LQZgT9F5JBHgijK0ncxT5kNfqRNo41p?=
 =?us-ascii?Q?0NG7uW8pbp2gYNZr+/CNgxgAAEJv6CAA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzzsE6993ki782mngOMiEgdArda7TTCE7s9aZzDvg2Nhz8yuuQCZuq4++03I?=
 =?us-ascii?Q?BuAWxKTpjuXunoknW5+EAMNk7npJHjTJTApAtZrg63OpAMEu8k36VCry+4dA?=
 =?us-ascii?Q?H0/Fky35sRWaeiH3QkKP29vp3nd/7eclNliLn1TCOFaErdm+ghu0w5H396P6?=
 =?us-ascii?Q?woiYNGjMNCQrEak2muGq+hszJbVcPMVaQSCqSQeoAZp5iW6jzgFM0uG3vC1C?=
 =?us-ascii?Q?882MV3nSrmc84OdW9o/5NoleZkbtAs7hsZnBpHBR7xbGBKjCTPfti4nKszhc?=
 =?us-ascii?Q?RA6ldKjeFTFddRGLwqZGp1L+UR05KiJBlKoq2R2YhelYqdHC9LoA8CtEzcvd?=
 =?us-ascii?Q?muN0MyZITk3vxDGF/5bCgwiOtmw9BEfCjZgjL9TUBlr0OkKSffG4MFXz9XwH?=
 =?us-ascii?Q?DHQfY2n7nnQ+GaJTvW0lGN2R0GmtKhqxWahXW/ZX6mRrLLQSwHiQgZmmMCGZ?=
 =?us-ascii?Q?hGVEKWMRXbrYxJ2OPnYnoEXWzzIDEdBXTyd4dMExpCW3adBNJgYv//hVgCiY?=
 =?us-ascii?Q?YepisGnJp9zLYv89F0O4FA7+9FlaLuW+p78SCyVQn4sFV+13YUrAjcGrp/ss?=
 =?us-ascii?Q?/d8MFpKcIsZ5cj05jAdCymGMPx6ZLkIHrmEyD0JPRzxYO9qCOJK85GS1Do3d?=
 =?us-ascii?Q?vriFVWcxk0k6Ugrl5WxI6lMJjNTzkry9Ui3otip/Vp5aUtvl1MbFn1qoE3uT?=
 =?us-ascii?Q?3/7XnEgUB4fWpaM3O1/P4D12qGQSb9c4KIlIDR7ABdLyN1F7jWYqMzTH8hUy?=
 =?us-ascii?Q?IMlYIVKI6ZMkJpdlS/uTwvXnfhTzHo2unaYag9oJzMF+zzk1YzuDSXSqL3ts?=
 =?us-ascii?Q?5z0ot0xg65SR+YjiNlHARTmpgojwIJaRAXcsV3wFxQSBlgDQ4VlfgEyuHccN?=
 =?us-ascii?Q?ojfECrsjjAnpTgORe437tpQtRJ3Ul9wjFdvUcil765RZW4x3laBIpXiVgMUr?=
 =?us-ascii?Q?r5R8Mapo7HuSfrhqrP47p51bGvQ8Ba5sncMsSR0O24rz/fBEwiOedeRVt0OM?=
 =?us-ascii?Q?lXURFgTW2Idz61TDAdaTpHRrXao+C0LudhGWC49IiiO5WnkIzX7h9TejmtIQ?=
 =?us-ascii?Q?apV2ue6d91IjGOLeodhf8n/Z6rxwlGhe80jTXPaT9NUFEJiRuIpnmJonzW/F?=
 =?us-ascii?Q?mq6yhvR3UV84RvaPdGKxNtLnsmo4GY4ryDwUvYwtwq4cT9hDjx2jOrufPoBP?=
 =?us-ascii?Q?BXenG1vJZpSStlAmkcS4ShFyI9La3mu9w/xCdHsKuUMzYV42tJXysupQLMMX?=
 =?us-ascii?Q?gzBvfm6Q4QipUbnS+poAN5f5BR7uiezc/Eb35J7332vjIKm0HU7W395OmUeg?=
 =?us-ascii?Q?MHpOeUi6BqQYMAYSWeO64zj6rkkpk2LppZEYAl0ewl0Zx1tzFfgibUlQI7Cc?=
 =?us-ascii?Q?Xwd6WpcmEzwDlfdLq0DSLDqKEp5AN4JmR/8GsLml7wZYvyI3PIO8nLUxLxH5?=
 =?us-ascii?Q?vsezAPSaOgLIxmYktAWMtc4w5UoqnKBYoWHHtjOqba/HR9sMuenebsFVCRdY?=
 =?us-ascii?Q?yBAI87RosjF7zNTjTvHR+VS1epkbTlhPYgTJ49+FRh22etGoiD1k0w2te5Wy?=
 =?us-ascii?Q?awmAOnLuzn0OD/TN4bjHitXyJr1ufS2udQQ9SJZsgGCzLp2vauiYv+STfY6D?=
 =?us-ascii?Q?FdZaFTU5QASaSZ6QyAm06ihtZg8NixjPljcsQGHUYdvi1f9Q1JEJruve4tJu?=
 =?us-ascii?Q?+vGkSt1sdlv3f5BFyynwcgDNNb4DDj9QcRIy+0I9z09UiuY/ctQAg3xUpDvU?=
 =?us-ascii?Q?PR7yJyc4qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d36ddf-b228-4949-81ba-08de42910843
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 02:06:21.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9SB5ULtjK7a9etqkuFw2bXkS8KZAGDePRpW3oAk6laCfPlx+OzP7aUX25KwjW2m/KNkmAhqFacdyCAe1fLCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

Hi Paul,

On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> > During studying some synchronize_rcu() latencies, I found that the
> > jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> > off by one. This is natural due to calc_index() rounding up.
> > 
> > For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> > is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> > never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> > to interrupts.
> > 
> > Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> > before passing it to the wait APIs.
> > 
> > But before I wanted to send a patch, I wanted to get everyone's thoughts.
> > Considering this the RFC.
> 
> Inadvertent passing of the value zero?

This should not be an issue because at the moment, even a value of
jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).

But you raise a good point, we should cap the minimum allowed jiffie value
for the fqs parameters to 1 so that we don't pass schedule_timeout() with
negative values when/if we do the reduce-by-one approach.

thanks,

 - Joel

