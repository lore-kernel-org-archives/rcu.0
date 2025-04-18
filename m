Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA521A449;
	Fri, 18 Apr 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992642; cv=fail; b=enk/s7SXXszJmb8amAcNWjNxAliX8vedYynCWLegpAoQuSfD/PnhygKmjkFIfmNUrrKf/p3kKTCA3JQrKGitdmjwMTVFU3hK8JGDrn1sWGq1AMPvqf9o9LgQjs2+udpF6LwcLQt3X0vVRW7S04SonzdhGPpyCJ352VrpPFnhh+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992642; c=relaxed/simple;
	bh=K1CsRacJK1OIGiFpTM0QzkCewRhArnv5Ob8iRyxh5pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kthWBR2fQQ/fumNDMgHmxxJhML7Gb4Lz1VOSA7exXl7PvdsHlpSOf4wOuhUC1GPFn98e5zvigt3nMosCnDUi0NFZ6cQEKSTU8rUSts2uXMu3dZcqPaXVKLn38GKjpWCyR/kxPFePY08sypjPRvISWdLE+Vg1xPbxyhb+qsUNhlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOPJRpSI; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOPJRpSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS22fKPQMzLG3i3AwM4pj8nHmWPifTvIUSIuu4JOIm/CAwDy+NWn1dl2w/S19VHi9nuFTmLEA94NpDHGwZkIin0i0rGrdh5x0Eblf4Sp1YpgyYMr8dQRZPezy8WpwBdX5Q1ZRzRRurdM711t3Fx3rXaxc+a9C0kluUkljH8d7ntokOjjhabm1/bYxqbGg8X2F0e4Y/zpASC5JXKWvfLjLowIGXX2YSpOzVpjJMlco+pjPbIiRfoTgFioaH/deJpfgy7eLEA5S/hGi8f814nEwmiMk1pftHaGAIvZOCEorozYpWIrgyN6nif3CQ4lmKW+Fni/6jVtBCDBJMWqPu/ZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9OeZ9liPybjRvM/oeboZzhFsRS8UCmr0z8Ib3RVGso=;
 b=K+eAs3+2Q8RZbO5MWN5NJV4Exh593/DntBstmUUuLIyicaL18K4W4W0GtDTbu6OEVz/K+SoNxZaDKIgvj1PJ+kjeosCXmRqbOEL3LEwHhAqIHFp4UzJLVANxv2rB8Bf80Et8Ued5KB87PaG806GUaqJDQbX+DAo7eq1HO2ELI3YxtCTpMr8HPMu0pUgG6snfFe3tvS8GpyJrRfwC6LBESOMFs6iJrNjocbBxtcJFuUEelqcKxlL7Kxijnrqs5VtEPlERIyvBj1Mww/PK6bF9WOSF8hrc2d5fpWSr6cJe25+Eszt4UBH8UApV9Fs36NbXVMghnzoAG0nTte55+e485Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9OeZ9liPybjRvM/oeboZzhFsRS8UCmr0z8Ib3RVGso=;
 b=UOPJRpSIqnlBDslddYr07/mJm8banYVaE2bN0SIgt9qXu3rBFpkn+9xTQdCjpp6sAiYHKdDkgzAov1AoVu2G3t8vq8QhyFnSxFClQi53vIHlbbfBLGl8DDKgu1ijpa8pDGG1lM+ZPrNyne0quyj6ErmOGdkb23n0dNNh1udUSdChxBFEXmOYP3l65diPEAURKYgznPxnazZkelwF/LYlMQjV63hs+v5nF/NUcnpce1OigLE+TV0DFfzT3sTYYI9gGe26Ka3AISr4nYRdK+I9OmMK7qO2uav11snAm6/zuVZhG4g8bUgMsKRHpGXmcMip/6csrwfLjutmFd2YG4TvxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 08/14] rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
Date: Fri, 18 Apr 2025 12:09:40 -0400
Message-ID: <20250418161005.2425391-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:408:fe::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ab6d8a-0579-4f1e-ab90-08dd7e938e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wt1jq7QguCcBy4sTCJ8ZLvsVvn4BR3jOiM/q/17P9Nm2JRhykIBA1ZahHdsJ?=
 =?us-ascii?Q?hyjDTkuqIXVVOqW12zaybFP4Nvvyga3OhpVkAWN2OrzK3qCEyf5F5CGv+bRd?=
 =?us-ascii?Q?hez5C0/egydvVTLmwlxmdRo9xxl9ZEMPrxe008vmaPTWVmb89SyBl4Yl2Nj/?=
 =?us-ascii?Q?4Ktk5DFMk6CFskw1mOaDgOWfRnaS3Ri5gawdVWNi1+B5vIV84dGgpII2/jOy?=
 =?us-ascii?Q?KfmCEFhizMzAcMni7hqLMe02OQyZUhck/JA7U2FKqzPcHCNMY/DIdu0W6wxe?=
 =?us-ascii?Q?+20nNIrqmhFn16vHjFX3EEADcyqyfjLNf2UmPmZO3vJ7SY4gg0ZUas23h153?=
 =?us-ascii?Q?/9/+ecsy8MhKC80KMzzieS0W415hsyiL+nENblOFNMFofQRp3GoK27VyarDe?=
 =?us-ascii?Q?2B3aOsCsfgFOLXT35eU529TfZDWxJJDofHR34bQyEz1RoALZ89Lv1OFNZrJR?=
 =?us-ascii?Q?ygPbv2AfvrVOCASGtQ49YTLug8gNMsHDvwXpj/3l25NFT1TgAbdS9QLpTSrQ?=
 =?us-ascii?Q?MVlt3XKwb0bKbZrQmWoD0kR7gh9zhk2qQ5lAfxcPs9zfSCicFtMN1jjm8Vz6?=
 =?us-ascii?Q?aq90nVbPHikenO3F2meVO4v5s7hGzhRuTm2TXQf/ITH9dz9bbMbQNtlkC6eg?=
 =?us-ascii?Q?6M4BJPupO1Dwbt+nI8YAP2vE2xFNqMKAyX9R8+fzjoqJkRXiRHI5Re5p8sV1?=
 =?us-ascii?Q?/U+adOQHZ08rn5m5QdLSeqZLSNrh0dntmVQjujiiOKq5G/aQlb4foEiBF6vb?=
 =?us-ascii?Q?KFCJL1Oh7ZftAeCSe85nwDThU/ShGQwdfA+5X3zX+ELDh8N5H4KtayHi5vUk?=
 =?us-ascii?Q?62BW//gRCVkLrP/DM4Qrn/grQpl2lpQedl4LnI/Sp5P4irG0OSV5RYBQ1Tdz?=
 =?us-ascii?Q?1OIH0xn0iXyftaS7M8WkJf15Ac1OP6nBln9p1/BcHaUUcZC5IXK75+rSid4g?=
 =?us-ascii?Q?0ZiF8TyoJXPnhNuCG0NpugmGJg4F/bSGQlh7EZ4BrrOfPwH3pB3tOtlvpxVz?=
 =?us-ascii?Q?pBDAkuPrL+mKL+TylEy3VInI4Cxber2//tLei8lIN+e6zHhuSx6TJ8B6QRBR?=
 =?us-ascii?Q?2RqA89tYthCrkD5RelNGXIBMglNIHufl0AWDhHuYzEur0iMsUMx2YeMxzdv1?=
 =?us-ascii?Q?xpd5UZ83loa4abQmUM+Owzv7MF9m+CRkqks6qcGBcXhhKZ4JupJ79+GhZ4m8?=
 =?us-ascii?Q?aFMmUNjLOtt0YA9YQPGUJ+3IugvXvl1MDJEMRAO6FytjemFGPqz+MOFXexkk?=
 =?us-ascii?Q?h8GSo5YWMDXOTpZhzpOHdRRKqK4L7TiYTB5QLOcQxzK3yKbPFGkEcTjdpzKn?=
 =?us-ascii?Q?eHvu5t+WjESr81lvCCYDKOKTmmTuBxtxjpjNlJjGEbjO+Y0J+U+pwlWRclXH?=
 =?us-ascii?Q?MT8marSJdEf/wUreG561IddWs8Dr47xmtxXuyr5x8wMqPvsSNjDun4wSvEIr?=
 =?us-ascii?Q?7vXMK+NFJRclLx+oz2KltIicNpSvJQaK6N+Qi7ez0CVeR1qry7LqEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOZ95JxaeqYCVGLy4Z1dKjqS1HfEpJ+YILnmke3x3q7/HowKGROKZf6PG3UM?=
 =?us-ascii?Q?aE7xUTINjM1bxhdXgvK3GRUC7jASVmYrSPAoGfrMt4a2Oc2ptUsLWtieldfs?=
 =?us-ascii?Q?R/Ag/YceZ6R9zzxK3m7uktHjAOzVsXaKV0JmAtiODdBehhMOJAKrIKFZnZDr?=
 =?us-ascii?Q?gxGfroMgjtMuR97T7RBMMZCCZ1VHBsjEbPPDZJFv8TB+PpEVGU8vXp4cgiHx?=
 =?us-ascii?Q?8jXvccSDyIktDIUfIAnWWUSvP5e+kFFggCCtffWtJKg63oximjCBS6tf1pMC?=
 =?us-ascii?Q?yuWvwLOqLJNfEmNZFU7enB/cae/q9dkwADrHBtCUw+AvfyILIhVEvdGU29cq?=
 =?us-ascii?Q?aS5wadmOCGtchuP/DsNwjWlyeQxodCCPapYyh22adTfXW3poA2C+6KnZjQRJ?=
 =?us-ascii?Q?EBVt8tEzkO64pctZ9HMFHaAWRer6MgEN3prHXah2vr/qxQ9NnfCfkycOLN9V?=
 =?us-ascii?Q?IDRqr+W9ohQPO8aQH7q+ZKvDANnUl2hN75xtZs+Wqwl8yBKnTC41ZWfMiiYj?=
 =?us-ascii?Q?PkBN700t2z22Pdb3xAjvdpPdmGvx1opRszQ7qQj4N+DzfSgJnf5rwh2/sfGP?=
 =?us-ascii?Q?L+54COLueaCABsN0RxHKfV3AKqKpqfTGzmlYEFe5FYtEFkSPmF8+dX40X1rH?=
 =?us-ascii?Q?gqlpRNNtXpOjSMWVPZXvES2ma+bxOAiCQWRRd8glFSpLcr5olUgQqlGfVAGC?=
 =?us-ascii?Q?07Wc6OYxQjtJfwrmWrKa1018GQ/drluyQ6gn+xBqzgWOdkh+/l3GAvr58yqj?=
 =?us-ascii?Q?tUrhD4nGvGqV5RMKPS3YbA6tOzPwu5aa+g37kAS7K6XpcaLvpeTkS+I+CbnE?=
 =?us-ascii?Q?ctga7Qz8c7V5XqUDdrKfOPB9s9hd8q538/dK4bUh/YXy3qHB+txpivxSHpTZ?=
 =?us-ascii?Q?bQmpE/3ywn6nq4wFRgPZFAwTob7Pzt9Q9DXOIz2MJHuKqTLP/jUgyP1DsnGJ?=
 =?us-ascii?Q?KRuktx5PVqDplwZNfVm51xGyvxmlhPvVppyvRmNZ9OiWebZoFUstHm2OhFbP?=
 =?us-ascii?Q?nRfVa9cCy5HLse+Tz3LKUJm1rGcqCGkSzKRHtqfLUWXUUk0qOOnaVlMs7oYa?=
 =?us-ascii?Q?2YiYF6u/ItxomEqPLmpuGzUIQMU8AJrOc/X2XqdnREOiukiTIlPPS3S8jp5M?=
 =?us-ascii?Q?aS7bfvzVn2Ow2jC/kZeceFfzHe+gjivI8Uw41jw09Y8TbD3/DmbdpnyRqoD9?=
 =?us-ascii?Q?vVUIAX1DZdnn0+/dNJN58Q8B5oHl3Eiq+EDoVkGdhLUtyT0HC9UkLGV7s/Sk?=
 =?us-ascii?Q?3xW5QANpifBhPpKYW6A6IgaFd8efUbaTPEVLYDM/Nf/xvMVhsuTo42ggzi4+?=
 =?us-ascii?Q?rmK4N3MXk03eI7u9GKbb11TN3bzqyXKK9EOXPTGXSv/+6vYGbtRlJJ2C6wN6?=
 =?us-ascii?Q?nJr2B5SX92wwa2ybkG7NcKCpnl+pQ7gH78LXYrJ5ldc9PChxaTo/Pc/9Eire?=
 =?us-ascii?Q?wsj+eya/PGXrjWcTt9MpJM89ptvrXGd2t3vdO70TjVlf0Y64udMsLl57nEe2?=
 =?us-ascii?Q?Bgbrmvxfm47ypbloVLBacS6Hx8tvDQurPGFQN8e2AlbMEg9nGmelAW1nsdk7?=
 =?us-ascii?Q?8xh2KgElGAEHZSGLuY51Lrn/G17PyBwjgkGK7Z1N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ab6d8a-0579-4f1e-ab90-08dd7e938e4b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:37.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yl7IYu1e+i19vb/+8jVMFLAD/uorA/B2sgzYPvcd7JvWTS6mobSnlhYtq3bln/Yvx0EZnKaIMQd2JXa9IIxZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

The down/up SRCU reader testing uses an hrtimer handler to exit the SRCU
read-side critical section.  This might be delayed, and if delayed for
too long, it can prevent the rcutorture run from completing.  This commit
therefore complains if the hrtimer handler is delayed for more than
ten seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 25010666576b..0b998609c7dc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2438,6 +2438,7 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	unsigned long rtorsu_j;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2520,6 +2521,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 		schedule_timeout_idle(HZ);
 		return;
 	}
+	rtorsup->rtorsu_j = jiffies;
 	smp_store_release(&rtorsup->rtorsu_inuse, true);
 	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
 	if (t < 10 * 1000)
@@ -2542,8 +2544,10 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
-			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
+				WARN_ON_ONCE(time_after(jiffies, rtorsup->rtorsu_j + 10 * HZ));
 				continue;
+			}
 			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
-- 
2.43.0

