Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45476EEC0;
	Tue, 17 Feb 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771291275; cv=fail; b=p0PU8tYt5jRuac2p0yi94ZWxetYhoogx5O5Ubk985ItmzuR2Y6jzLQSTaWgRa2Pe2pKDdE1KyPFcRUgqMEcyq5XE/gz2rgZKCJJDf6iKbO6x7Js8PKr2GfMumXpnHbt+8gdcpvbgKadUw4lSAMkOIqRnvSa5RwqtBMSyqGKW/is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771291275; c=relaxed/simple;
	bh=F1TtQlQa2ozNzIGopJ/SQbSg3IzP75qfIjxPY64EDLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jxr+3oWD8W8GR3AgTt5QGflOoGR9xKWv4cm0Z458+VtdwdcWDczMqw2MgfILDW1QthCSHvw+cOIsyZj2LEQYcWn1+hw0L5k3H/OPlL8qsi2+p4KiDUojdJLI4lYbG6j28ZAs5DPvbS9C213kJ9QyozaZaWTtVmayFzAPF1xwhBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckTvuxwR; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckTvuxwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2VjCXyLIyqLlmfEzTAvFLzz3fLRsmeOHjgril1VcPU30IW9HZSqq0ZxVOnzYCDITZGew2T+wLDcsREZGiyCPN330mY7yU6SZst0eyj1ClklN8S67THqwC9HVbnAzkl8+Iz7wkZO/LpRkwaQLa1nd29ia+kvoXqLeCLXCqVyaZ67RR0KfSovxaz42u71VEqv6FGwy+mY0qRqdFhy1McDM9YVuCEMderZ1oNew8duPbRk1fNNAqkhLjrgGvQtzsyBs9hZKTzsgYF/3gSTtYHv/xBYn9Z7ugJsbBlbqMUAoqrrKiuk65Eool1PmsGQ4oT++jUxH1ypov8AqTUg5FCBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4SL+4w11ib8T2NH+ci73iDQvaM5GTyekIaHgb+6V3c=;
 b=H9/f1kYDn4hd2laE+/0SNm+TEg8ySLo/e3I+FYfOlm1WLqtQECQV9Hao2HM7mJSOf4/c1RaDF6XYY91SsEjNk/Kvfs7EqVv3J6aOvQhQLyLn8PsBxhtPR8zLUFBS60dg3otqZkrKr+QDFGLphBEybDRuES1Ap+Nu7PS2k98j1s/sUvyIJeJX/6C8OAaxf3oghswQgaMp/iLryiGt7ST+GfEqnjx7+GQaTIUw3oKVhtyETyz+WKs3/F+uwh/X7Mu1n/XcjwNRiMKDR6afpNNCFVkA2BtrBP2XccXXPIqMexoLaDH4bQU7mrPS4zfTMqmLuu7jKyL8Lwi//aYMvGpsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4SL+4w11ib8T2NH+ci73iDQvaM5GTyekIaHgb+6V3c=;
 b=ckTvuxwRBzAkHEs97SIQwRFCBc3USPnZcLAg3bpSVpmrYtRhwAkvnfrvDL6R65oAl+kvT2o25rVfXjqIgzxiw9bpu3BQ05RLi9Aih9DyEPODzoyuJzi/2MY/T0qU6Yj0ESgG9MbKn+FS4Wn44/++khgV+CZmd+jCIUOlFZ/NmuYAlldZ/nDZ315/fnrymBb5aSPUd4oA+9lWbNLy1ll0raKBnuWkwUoGX2uNTVYa7OZnIpDXC4XhpnCvDQBGgMSMg7w9ZI65NtyBTtTy6cEoUpg9edkJCL1YLOYgAeE+LjpZynp6FQl1KlmSCUgAk9TE29C4AgQ7BqiA+JqYLWu+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 01:21:07 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 01:21:06 +0000
Date: Mon, 16 Feb 2026 20:21:05 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tamir Duberstein <tamird@kernel.org>
Subject: Re: [RFC PATCH 0/7] Introduce HasField infrastructure
Message-ID: <7400643A-02A9-4FF4-92D4-3F94F868B789@nvidia.com>
References: <20260128215330.58410-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128215330.58410-1-boqun.feng@gmail.com>
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea7e399-b716-4323-4fd1-08de6dc2d310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sqQffU5O6jGROYvDt5uzvKmXexvMlE7KYppOn0CDUGMYfYEhvDWEO2pD+6Yo?=
 =?us-ascii?Q?HuFdVwXH2ygOIYQxK5q1DfGRSV/c3X5PS5syRCfQ/swXF70wEYKkekfmJRXQ?=
 =?us-ascii?Q?iDF9uByDZ8CzbrqMpNoNfSAZvTt++EKu7lCd6kq++HHvpSDPz97N0SQ9WOXs?=
 =?us-ascii?Q?XUnVUs0cJmwQxlcbOqAg5SbBlTbR3ghtOK8ikAa64OrF7NNmB+NflCxo3JuC?=
 =?us-ascii?Q?TQeUlAYoY9W49uL92yR8Bvc/5q2pt53c9x3OV2TZ/IWL0aItOtxcSzu103Ey?=
 =?us-ascii?Q?UkW8jD2GN0t2648MytZv/XHlHUAIOoBU5SmpRG1KMjDoP8LU9lIeQm86uP9P?=
 =?us-ascii?Q?zOpAUwHJNFLqxBl+s+R/vzBm/rVnmt9rMMtkfeylQWqPz4vXpfNkCLDFmZdx?=
 =?us-ascii?Q?wQE6igY9hrXrw/BOSeI7+PwfZ6RSZVq+nyS0FCYXsGtPdDp0eWpLpdGmasIF?=
 =?us-ascii?Q?iPdcwyLVfC/fjdjDDPSqSGrEHsWDEp8yfdOPcVo+uaz4gRHJAQAk+wxrF7gY?=
 =?us-ascii?Q?HBy0pLlGZAZ5QwUo4cziTbOVMJzSRd6SwMf9X4Scar3Lg1XS/u43FKq24tqd?=
 =?us-ascii?Q?rb5dvmIm3NGw1OKel+NCffHGTBmoD7B4JTy3IqnnmaSlI5+db5Un5XpKPZxO?=
 =?us-ascii?Q?y8m1+GE4Gtzk6K6f9pETA/BqWJxy0LKF5PrUnwxPV7AbfTieiJCn/ECsgIZ2?=
 =?us-ascii?Q?/n7vkPKq1G3QIcD0RVVVxdeTEQYUBhyTpG0RTOMyDBLJQONO54IjT69zt8Bx?=
 =?us-ascii?Q?LGcBly0vasGejyCSElKj6ZGCI9OcNfbaMcAhLtaQJ2v/oeSoTJug8rKNSOoW?=
 =?us-ascii?Q?iVanfed9AyABlQIdEWFMSEjf3O1JNkpu0gWb+S8uHZcoe9qhaQWdzcOx/1qh?=
 =?us-ascii?Q?6Hy5WCvj1WPSEx7fL/2Ba3gDjGAU63ZtucntbNTpLr9lqD0bPqwNjXfqQkHS?=
 =?us-ascii?Q?amPZhlQvwgK/iXsSWoc1HuxNKtCkHrOaiMdUzAsWKexaLC7WCVQd1yrduvel?=
 =?us-ascii?Q?MLSl+f4hr8i3yaaIb1YZQoYKy6T6enEP0eWJsjC+3fz5U0JAy8OSMoy4n82D?=
 =?us-ascii?Q?KFX2czWeggLLWUT0y2QDz62AXTctIE8CHVsrD0RHVZd9bglhOreXhrdvCfAs?=
 =?us-ascii?Q?vKRR5blX15fB5k/anSerFqLByX9Rok+btDyW92eYPxsnu9WfKuiQRfxw9zEk?=
 =?us-ascii?Q?hP4m2wQZ4yUhi02VZihbIxm/6lYA04/+7mY+ZjKRRXqjbxcvtFVaqLrLOwN3?=
 =?us-ascii?Q?Q2b/w6N6GXB7wH3mpmWBIpF+qxHJvD8ip9TvHYab83rcF5KPzvGbxtag/jqF?=
 =?us-ascii?Q?VPxWnwAulgFMzyMz9CHRRfLIyIzf20yxfdmmzcpQH8kedRnAKy22qq3I0jfa?=
 =?us-ascii?Q?edI3LhK/EqRHnP1y4teWbdi56QkyuKoIFbix1YyMcWPguHo52HJ5m7o6Oa1w?=
 =?us-ascii?Q?mKKw+6C0jQZ8yG6NzBUOV+U2ffxfhQ2aveC9d1Wfga9g+9fmzlZ2Jzk9Uzag?=
 =?us-ascii?Q?GVJwngTu2qRNr+984LJgZBFdH5VZQJkpPCSodGvPp0uXuj/saudPZkKb1CxZ?=
 =?us-ascii?Q?ZbQy0Qq7QsQ/k9tu6Ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdfwJlqxfd06buHpTZUFo/wTrqoSE4JwcpA6oHR4O48K0n4R9gKgPYWqk+TS?=
 =?us-ascii?Q?YOgT5/s+bMfu8FAFd0XE292mc9ZQTuYLHUYVK2XUVqQ9SbF7+syJPBvz8iBV?=
 =?us-ascii?Q?YSpFy0YxITHaZjpa9dr1EXEcELxWxPl3DdllPSwWLCewQMeHy+YMi/4uscS1?=
 =?us-ascii?Q?wLbUxIeAxRs397ShBgdQFVnd+cwmouqqH6c2cfdqOy5FxeC2WSKG1OkbAHC2?=
 =?us-ascii?Q?pmnMK5J0oXpIqR1Qbv+srhWIo9kZqMTdSWxuZrqFbG5WtSmrAd0rHS1LTqY/?=
 =?us-ascii?Q?rGjjyTnXFCVlaEsqxdnJRxa+7egBNYUNpTXVC1Mg5pyQsRhTnkkxNq3zCg5m?=
 =?us-ascii?Q?sEdbXbSzHog8H0+6IzLhrh7Os3yCbtOUBw8QXP5YOmv6HvYaYBaoo1mG+p84?=
 =?us-ascii?Q?2MYo4iyF7mRnNYKVFCegzSg5IKE2A2n//fBuCNj8mFmih1yGubokwz10fuBi?=
 =?us-ascii?Q?j0256EK9NBQ6Hpl0QcijOvd15faDJcme2ZAbRl/0ah3qNEKUX9gXKAM9BEME?=
 =?us-ascii?Q?EpHLWf8luFzb68opwtkK/VUG5NzGhRY0tEtHhyNrp/Vw+Tt/sKZCX4Rkq6eD?=
 =?us-ascii?Q?6GyJCuv4sUpnAg6Lw7FgyuElZILuPb8g8AhxgelDkYvzJ2xLecImbJO388yB?=
 =?us-ascii?Q?6/s89byYniHXH5wttz5nOboyO/zIzyxs/MP9LmCOyZO32CsdMdhTrKSEYs8s?=
 =?us-ascii?Q?Iurlst+hLlQabODYuCKhqsz1Z+LHYPUO254eN9zEhlVgsKQGEKn8w2EqIiHT?=
 =?us-ascii?Q?RUTktk9xm9Y2OHZ09LcYdQXFcVAF3DYt3LBsJEA02DyE27dcA33ZQKTm88GV?=
 =?us-ascii?Q?E5sSSu2WZxoPqSY8WhtetaBUgKEdIzSX1Qps+zUXVlCPI2AY7s8oQdBybVSj?=
 =?us-ascii?Q?iz7+0sAR9K9k9KFdn6N9Z3fp61PpS4JLmd9WUWeLYSfO7ACTA3w5P0g68yTT?=
 =?us-ascii?Q?/rsNuSTx+6Ndr8XLwdebpx3+StRFLiliTsJIHZ9zvOqOfr966yIczdcNrBgY?=
 =?us-ascii?Q?5mMlilnC9PX95TJyBQkD8QJe3U2ut4okZLUjxwOvykyh7UfZl2a9KyzbYz/F?=
 =?us-ascii?Q?gTlI7pyCTA93I6NwaBUV3Omo+OCsPfaGAMkZ/yokO6rxs6L7m1OcGrdBXJPp?=
 =?us-ascii?Q?mrbVcjFtPjZ141FTfPqUW+M05noN9itszm8hE3VSD0feQGysC/7fdt1B7dTy?=
 =?us-ascii?Q?gbwfBfiwTlpnNRRM4iYZcD+2depuRo7IGncHQdXhDaokPeU14paIh4fzO2df?=
 =?us-ascii?Q?cwFvZfkPQb7cJdKafsv8NyhXaGh9Z9SxY7HfPWumi153uDxo1OfwkhM/FoVs?=
 =?us-ascii?Q?VsWA2BrYV9uWnmml75v5UhGU4P7APWLtupbTuxQY2tEFYIp35fBA+x8ReYFi?=
 =?us-ascii?Q?wzlyart6NUzvqw6S7ykrejO0f5aMvD0kp3DIi5r7MoWsA71pAjjkVYh8TF9L?=
 =?us-ascii?Q?gVETLvC8iBjdGol9WayWJk4hL3qt7wMGFYmq8xcanSRKQdJz68E5TMjx/Zb/?=
 =?us-ascii?Q?UvR5LC7RuzNr3b2l9b3yub//vyOgv6VVZk++HKePKypiIbcuFn4FFI5wn9MY?=
 =?us-ascii?Q?Yda+XIprULX7EN7fECKccHUjmP08stA8ppLSrUSlEXvr+Ye1+CpSAO5aAxr6?=
 =?us-ascii?Q?3fjTyoEpb6S7+2g5rq38SziuCwXipgokqwl5W7tg+w8s0UPlg0LkcLVjuatL?=
 =?us-ascii?Q?shzQwUXn2dTVelH7JxRbM6NunhBmleq6HeCQaFYYaaWgJ11DhYcmG9AKxm4Q?=
 =?us-ascii?Q?VKhhHkTJiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea7e399-b716-4323-4fd1-08de6dc2d310
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:21:06.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+3U7P/+pXHJQ9o2XjJ60p/MwjcfU6plKNRgsw8UHA93ngw7lIaFZT8Yo4HlYEX9qB2Z9mwj0dCRJdlTI96jZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Wed, 28 Jan 2026 13:53:23 -0800, Boqun Feng wrote:
> Therefore here is the effort to unify them into a proc-macro based
> solution. Field and HasField traits are introduced to generify the
> "Has A" relationship, and a derive macro #[derive(HasField)] is also
> added to support automatically implementing HasField trait.

Hi Boqun,

One naming concern: the #[field] attribute feels ambiguous since in
Rust every struct member is already called a "field." When reading:

   #[derive(HasField)]
   struct MyStruct {
       value: i32,
       #[field]
       work: Work<MyStruct>,
   }

it's not immediately obvious why "work" gets #[field] but "value"
does not, as both are struct fields.

Would something like #[project] be clearer?

Similarly, HasField could become HasProjection or ProjectField to
better distinguish the trait's purpose from the general concept of fields.

-- 
Joel Fernandes
