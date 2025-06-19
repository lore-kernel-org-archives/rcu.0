Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DB19D8BE;
	Thu, 19 Jun 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355629; cv=fail; b=rx6vApZAd4hhzoRAv2Vw9c3U+dLUpmE1X376aAhiX/xwbUEPKuWRbJ1z7wESC4tmzvF456A7eHYDq7GlkWTI3ln1Xi93YVJ84rfmjxezOZBo1Yg1zExeF6742Z9sH8BIn03lTptGokiu7KlLpL8t5wksHOx2SXgj0QflQUNLoJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355629; c=relaxed/simple;
	bh=Q7G/MvkQFl5mg/cCBVNJ8KhOqKrOJauz9SL7TXe2atI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O2SLx816vAFrnK4aFPkPtUO71VBUF/B2QRLOZL/CGlfEvW55o1ZtAb5ni493XovGLRiYjBpRxB9Bm/Z/QpeOxBuQa5yj6PS6AH99zRkKopmXXfH1p+LvQYiJqdA56t2ftbo7dkxKkG2tYHLpKYzpZJJi1HCdnHmmIXE1Lc0PEHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSIGVybb; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSIGVybb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0CsqfNLWZgQWEoE7ZIAt6piOsTi6XneDtM3TL4zlNGMnXwjrP1Tpv59FiblQnjETjvxp2vVjTpp9rAjTQMsuJLYpa/0iYVVXj+PGz6S0UDyckQjYcTRtWqcUfZfa84n0sZZhHub73d0EcGvZgAj9WpMOYCwOXae/55ho3xXAjFycqpLEbgtY2U1e8ibmQkjFCtgB2h82o8ZuwyxMFwbMdfaRsUPHF/h7fXRN5jzSMkmh84zNrMTEYfTKbkfOeLOwv64ChdMTJ5L8jsoCANL7YY4SxWncvNE4s6Z38bUGEQEv8YHHbXZn3iVLNfOQ1ZRXjYVU8iB3gtPa5xqthf6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybgE/5FiQpCIpZ2+05aHvZRsxblKZMbCX/dhciZz3yk=;
 b=zU9qJ7gFxZdRLyBLCgQisEegk2gwPtAQQWmWMsJMlfYrYlaKaZQazhvJEIhvUdX26XOkhneWSE1RBo76OirV3gyf3dHHDyVp71/Hh+KKuNTleiuhYgGrYGR247rejQSPotZ1qaxjXmt4pE71Yhe4z4NEPUWJ6J6hn+AlURqELKKrhmBOjTJGrlOEdQAt/+aNKzDIwGB9pTobfjU/y3fIOWmO5C0iuFKhBz9dXeiDSL3QimgxFRdIbYeVYHmhUrwUtStU8HDbEhq2yd/7YI77UbT/ELCxbWZ6PB1m3bONqrJW2FCYpXCWD9/DIkNyx5jCZU0Pg46H1QqER8CrdmJAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybgE/5FiQpCIpZ2+05aHvZRsxblKZMbCX/dhciZz3yk=;
 b=pSIGVybbBlwUTsBOF0QnfAUFuErpuTuEJDpI2uKrHs2kHQTZDnQjiwXBo8zG7OGY4q07vJ69SrILUhjJSKHTHP1nVXqfdYwhI/5W8QY8QZaC/8N+GSi3uWiI29hmT3lkwoB/ozfU/f6oJj+BCTFVOl4Mf22h5GJVU6kb9vHTWRmqTdqQ6D1I+GeVjKMUU/sviixD1kLwQaLcWkOpO9+uErOhrfWWYHaQoukLBCJR0lsjen2UmFin3UJwztZLhf7qPlFUVWm/Tvf/O4VoctKvfrlfr9LQOjjGd6LQPqIbywadYAzxieuXMX7hjIajFgAkf9aFhWni/yXUFioXv1iOQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 17:53:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 17:53:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>,
	rcu@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2] refscale: Add tests for local_irq_disable() vs local_interrupt_disable()
Date: Thu, 19 Jun 2025 13:53:35 -0400
Message-ID: <20250619175335.2905836-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 7369ac23-7cb4-47b6-1239-08ddaf5a3ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBkmID2QNsh7qqEK2a8So9Rfpo7RMHMS6vrnz/Ot1wNR/lOVlPGXTTABgJD5?=
 =?us-ascii?Q?UnEZxG2BL+Xq4uDQfmf7Fq2KmWnWmfCqjmo711PP+bS4ORL8lkULRBCYiNma?=
 =?us-ascii?Q?Or78mkV+eNNdkYfnzcbEnkJdUe6+CPQYbufVGMlpxmala673wuVgRCucmB63?=
 =?us-ascii?Q?RUV5EK5N58xkwj2JLnTU7BEpAY8GFFGXhD7A75TJviWVn0cAhWgYjooiGEro?=
 =?us-ascii?Q?DUfUH6TEU3iK8iluvjjUdOuEGaLYxPySRisFnG2EQyCBcbdzIkn49/ehaYxs?=
 =?us-ascii?Q?YGE7hUH7+xjYp8lMsmHkaZHCtpEK7tX+mRCzciKFqu9NPwaumrZIbIDqxZY4?=
 =?us-ascii?Q?Ayl0zl10jeHL8PEJwz+lSc6Ra+FHGj37jcHk5Nxhm3YWgRiHbNLxVXpz/5o1?=
 =?us-ascii?Q?vN28qsan+ck6GLDH0lFtowKA4UkpOVmrEV1BVbCtkHXd2NcbC+zjo+WzlfiX?=
 =?us-ascii?Q?SFCB7p3VneqGPT/Da0M6Hq7nsc+BmA9ngOqmBWf3iwW0grbZhX/Msq9VuiYz?=
 =?us-ascii?Q?iA9DiTY/cWvF51uiqaDVDN5LtiLnSRX6Jeji1mbKpeV9aUftKjpE4KRCj+Ic?=
 =?us-ascii?Q?2yfFRXZtCFRZ9OPapHpobgO8zIuCTSbTk98Yt40m59ShF+ZRi+yZlGlnHV65?=
 =?us-ascii?Q?c0AmPs32narN9gFh4VynYyxZVszWIsYHn9TyZM5O5BelHqC/yZMiAHCuctGV?=
 =?us-ascii?Q?2ncjVBjSKCzP/HbrW4APj4PAhdOzsX+V7dYrlNg4Iz8WqS4UO0cJ7UIRvMGY?=
 =?us-ascii?Q?OBUsl6MB7bTpudyd1IR2P28uynQuwcFh8Njw37ueqUgv4bbXyOsx9MTs5GbH?=
 =?us-ascii?Q?hVIeeszw+TOQ8aaJX9CsAPKUPoQcfW8fw1n6FfJXk1L25V2ER1HCdtcNqVkI?=
 =?us-ascii?Q?gD9SrTvNqxRpZYQo6HFCZ1J7B1nuG9ICwrlrPWzZBv2A9F02b/ablVygdGnb?=
 =?us-ascii?Q?NHlQAfLfzuBbp6AHCN5SJGHNTB5Ouhd4lMZoEaHQesGKvSusKpdC+jCIZQKz?=
 =?us-ascii?Q?AliwqYBhPT5UqCSNWccph7NX4BLxVEUYWEv1RBQt1cSl/4rDADll2XOyvht+?=
 =?us-ascii?Q?H/p2vsNv03k2Ah7mZMJBcMxt0qmWgESROEC7BISaSVyPuOJmUuRP4/JhvQNT?=
 =?us-ascii?Q?06tTBy+MJqirq2tjFHVsY2jQWacwJQFZPr572svmwCOcfvYMCm+5MIU+UdRp?=
 =?us-ascii?Q?giuk7ptYiqb7xcNOvqnr8rJ9owk3AyRKbwaCQLx4TY97G+10tGiMFEPYhCUN?=
 =?us-ascii?Q?9nQacNLcQIo0vw9J568zaOFXmR88tPSxaRlhqjlvNr80ORt1jAKenkdXIeNX?=
 =?us-ascii?Q?6nv1b/kpVZ3MH5GnZ3Js+9P9sNtOsCZEDv0J1VY/pWeTDq6yi5eSUW5g5oh5?=
 =?us-ascii?Q?2DCdBUm7SUVtqU5fOF/wWYma3fyicHggBiwfZgYpI/nFcdKUb+ugKcOFcmBb?=
 =?us-ascii?Q?ggHQl7G48NNw8bpc5r4W8pqQrvDkx/KpBOpcc84APpjonF0Qp6jcfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vt6jb9uEDkfPGQjfeztw3ixIUauFVr6v0kKQEfsjCTJ5FWRLQJssU9ZufZsr?=
 =?us-ascii?Q?+8Ifna2wm/4wVaUqXUqu6B3EOjOkvjOezFjtkp2Wf7JYgBTqoL36U+ehEatc?=
 =?us-ascii?Q?GqVwg30YcY51fY3wUXOOqm/m2K7l8Vw5ABrU63pDX5i5z7IErfVLl/1u2AQ7?=
 =?us-ascii?Q?9GAUHW21nTCTlqsUyh5ARk5aoRMVexmQK2BBNni9ehcArKaWsu2QBOxLon3c?=
 =?us-ascii?Q?sk0FEw2l26TVNvCxMS7q5HW5V/z6e9GubqLOVyUm85tWZUpCguymsDuhOm6n?=
 =?us-ascii?Q?BuzrcsVuMZhkjVh0XpHbrce6/IIgf65cU+kBVVfwX211ySNSplUYa49Qo9nO?=
 =?us-ascii?Q?vdCqNFVjLn/BQ0hxkMe31QObsoEyB9yASBRZnL7a6OKgLshBJMzeSHc98/bI?=
 =?us-ascii?Q?l6MGDvv9jaWiRibrrrLKmsqSxhasF9qLkfKmAmO0WAXw6n91Vr0IGfxnVToX?=
 =?us-ascii?Q?5XrloyVQ43wBTWRdx66WybQQdWH/TEpKE0HJ5TTMo5clwvJ08wqrm0o135bm?=
 =?us-ascii?Q?M2d12wpEirUqayGQEMYxLVcHRvL0qIy/MhArIoH9MmjkubERQ54v0SPGs2v3?=
 =?us-ascii?Q?2iKvQcJ+VlvLjMfQConXXn/Y4yb0L0JR0iZWuYh1X491zfiFa5BiN59dsoVQ?=
 =?us-ascii?Q?qo43lRs8uEEglWcbLxsXzxSM82oFKx/Q0bmAgbX/djKMoo/w1PbYFNbDpULh?=
 =?us-ascii?Q?GjyG2GTYWDFikyrNkHJJiNkQeCKBeoa+rdkwBkwsztHAucir3R/D9m3Lvuxv?=
 =?us-ascii?Q?z2eBzry7n/NhUYAeUZAY4yegI54+fPYuezUuIMldhyfo9jpwUozITvvLRvAQ?=
 =?us-ascii?Q?GdpnSyHqN9iHXaPTMabZ7eYiz1hIDjhr9sFBRWu+sy2iz8ACFJ1EW5YyWncX?=
 =?us-ascii?Q?ZFtEpsvm0K/4z+eZTtDvrEGFoE28Y3aii++Qct48v7DLkH4nZ0dxXEMbdM3y?=
 =?us-ascii?Q?yEUDFKMlQSqFPxZY8a4UEay0hF6QwtlgvNaYNYQ5r9094IJziSFs6wrNHmcO?=
 =?us-ascii?Q?MqPYIakN7q5Miy2qktxOh1m8g/dIUkmcyCfwX9RKsVA21M/pO9ZJy2S6bSA8?=
 =?us-ascii?Q?VCsb+bpXxrg6r1sK7i4fRhvI3JRZLH54rRIZ5O0WVqKa+Jyjn1Ji81ocOJQI?=
 =?us-ascii?Q?DubdbFlizpRd+XQeXh3Cg47TJWTC7qgHqvktLAtNZgsKjPBUZE2yHl6wNWyW?=
 =?us-ascii?Q?EqNTiGIaPQM6niUPhGm0XQZIVKw7tC8nM/l1we2K9pVT88wDpzl/LJX1GF1N?=
 =?us-ascii?Q?870bnrs3nIjJme7ZBGgm7l8g5e3+gcJgRX6SgwM7f1Y+oyf6gPGxdGs/KOMq?=
 =?us-ascii?Q?u2BM+TOtrXz/X6xU97Gcz40VshSBCsvGBtuGJcCVCyreDVk3hB/u3w2kr83F?=
 =?us-ascii?Q?cQc2dpHfSjkFfHOhUW6qgIcx0pQTAgNNMzo4O7wBvNL4OOeovPoEVKGmV1NT?=
 =?us-ascii?Q?JUpHk1uQvMNAQmvzhQxiFLPuyNlvWnWV1Mil9iMyUDJT+MC+14mGHQMwAaiC?=
 =?us-ascii?Q?n8ochweJ78nyRYCdq8YmvcBAeZuK5kryxmv7WaqD8ZG4F4UtpTsqdzp+bvVu?=
 =?us-ascii?Q?lzYyldNuTucmM2fIxUM6o0pqsJz1B2BqDfOlqPR4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7369ac23-7cb4-47b6-1239-08ddaf5a3ae5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 17:53:42.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z39TpKYJDZ5JxIE5g2x3sA9ZuubwM/9H2KzN6Rvh0zN0Ddv1r6409lzvAA9V0n7LuLqJIEMFdhCO2pe1BVSR1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

Add two new refscale test cases to compare the performance of
traditional local_irq_disable()/local_irq_enable() with the newer
local_interrupt_disable()/local_interrupt_enable() APIs.

The local_interrupt_disable()/local_interrupt_enable() APIs are
introduced to provide a Rust-compatible interface for interrupt
control, as mentioned in:
https://lore.kernel.org/all/20240527222254.565881-1-lyude@redhat.com/

The 2 new tests are "local_interrupt" for the new API and "local_irq" test
for the traditional one. This allows direct performance comparison
between the two approaches.

Test results on x86 with 4 readers, 5 runs, 10000 loops:

local_irq (traditional API):
  Run 1: 1.306 ns
  Run 2: 1.306 ns
  Run 3: 1.305 ns
  Run 4: 1.307 ns
  Run 5: 1.085 ns
  Average: ~1.26 ns per operation

local_interrupt (new API):
  Run 1: 4.594 ns
  Run 2: 4.201 ns
  Run 3: 4.428 ns
  Run 4: 4.905 ns
  Run 5: 4.566 ns
  Average: ~4.54 ns per operation

The results show higher overhead with local_interrupt_disable()/enable()
possibly coming from the additional state tracking.

To run the module, modprobe refscale scale_type=local_irq (or local_interrupt).

Cc: Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/refscale.c | 73 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778..ac6e2391d672 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -71,7 +71,7 @@ MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
-MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
+MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock, local_interrupt, local_irq.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
@@ -524,6 +524,62 @@ static const struct ref_scale_ops lock_irq_ops = {
 	.name		= "lock-irq"
 };
 
+// IRQ disable/enable tests using interrupt_disable/enable.
+static void ref_local_interrupt_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_interrupt_disable();
+		local_interrupt_enable();
+	}
+}
+
+static void ref_local_interrupt_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_interrupt_disable();
+		un_delay(udl, ndl);
+		local_interrupt_enable();
+	}
+}
+
+static const struct ref_scale_ops local_interrupt_ops = {
+	.readsection	= ref_local_interrupt_section,
+	.delaysection	= ref_local_interrupt_delay_section,
+	.name		= "local_interrupt"
+};
+
+// IRQ disable/enable tests using local_irq_disable/enable.
+static void ref_local_irq_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_irq_disable();
+		local_irq_enable();
+	}
+}
+
+static void ref_local_irq_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		local_irq_disable();
+		un_delay(udl, ndl);
+		local_irq_enable();
+	}
+}
+
+static const struct ref_scale_ops local_irq_ops = {
+	.readsection	= ref_local_irq_section,
+	.delaysection	= ref_local_irq_delay_section,
+	.name		= "local_irq"
+};
+
 // Definitions acquire-release.
 static DEFINE_PER_CPU(unsigned long, test_acqrel);
 
@@ -956,13 +1012,22 @@ ref_scale_reader(void *arg)
 			rcu_scale_one_reader();
 	// Also keep interrupts disabled.  This also has the effect
 	// of preventing entries into slow path for rcu_read_unlock().
-	local_irq_save(flags);
+	// Exception: for IRQ ops, use preempt_disable instead since we need
+	// to test actual IRQ disable/enable performance.
+	if (cur_ops == &local_interrupt_ops || cur_ops == &local_irq_ops)
+		preempt_disable();
+	else
+		local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
 	rcu_scale_one_reader();
 
 	duration = ktime_get_mono_fast_ns() - start;
-	local_irq_restore(flags);
+
+	if (cur_ops == &local_interrupt_ops || cur_ops == &local_irq_ops)
+		preempt_enable();
+	else
+		local_irq_restore(flags);
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
 	// To reduce runtime-skew noise, do maintain-load invocations until
@@ -1194,7 +1259,7 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
-		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &local_interrupt_ops, &local_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
-- 
2.43.0

