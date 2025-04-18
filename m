Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85947223705;
	Fri, 18 Apr 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992664; cv=fail; b=ahBQxjYFR0JGfphw1npxO/B7pzdGJS332Q8k2JWoYc/8ArZevW1Ov8+VQ7KtfNl8gmLPJJjH+vm30QY8f3UVyd/NSgNxafIqloYOC1N6jEdHcGd3eiALgCY4X8xrsCHOp+PHKwdhJLMhorOFdOHnZwxUfHl+80X2lvuOuNuQPNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992664; c=relaxed/simple;
	bh=vDZHeFv/7V2Ui6IMghiJSFjUDo+2B1F3MwLHL8xGBLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/Jtb8QC7w7wZx1Yg3bj+bjATZHrqvWfarsW4NmNhixts82rTm6N/JLBWOgkeXk0A0ZE+em9DFHVPwOwNgNJMCSjkpZZL4fHdah4yArsu05P+8qNAGIaE+9VW20Cv0wuD1ZgFIhWSA+QuRpmPT7wWvDdokOiD8nNWjECws48/9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+LozP+2; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+LozP+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikG2rgDV60iEJyoIkDMFoewHPol/c54XyjJ2QcK/Au07cBbpRWmd/VLZV2p9fNK+OZ8ERhN5Xk++Ct3bRJU6Z9fffVii9XHq/GKGW7QS/Ho02cWdi/ZEAzqSEnIIyRNId4+UKL+dVNZKLiTNbHVsteo2BQkBTqdN43UqfFeo9w/A6I64wcZvI8J9+EVYc95lkyy7XmUoCg21cRDYilyyKB6rBL1zDAmmxM6oG2QqmueqifcmRXL9M0nVuoIqkYR6c7b8F70lSa/7r1cFoV5AyHfILOP7hcbkfAtuKerc2USNWOWDfmF/DYUUJFt5lHdHqY9LnguyDgpd9fa2425LSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckPPLDIp8R970061sNbVhgUMnKnYoOwbUvDYnA0QvBo=;
 b=cS6mDn3n7RY/CgWgh/sC1rVE1CNiETDMKFnKWTcV4CB2BY/xUx4rbKcLjQ3TV0g9mp7ztPlaUoAeE533p+XkGgYJQPgN654Pw64gmvFQy9sF0NB0AM07orLH5Syq3LWQnYiM9A/LQpfGsv7oREH6k5sJQmIQrq7aH5DnbP0Wc90SVehc0MQY+kbj8fF2vj+kKcLclXaxchQE7qwJNjPpZeoJkqHfe9v4p9OFZSzwC89vt1mGWoLpmfd+MJguh64/kp6IlnMkESvxD3zZSa4n1qxc35UqU+ZxQe5wCgWT4ioTxYNJ8D7xtq48IH1AQx3xPZpY5cZsZqL8PjsMSB2QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckPPLDIp8R970061sNbVhgUMnKnYoOwbUvDYnA0QvBo=;
 b=s+LozP+2tCl8wYDsngbsgW3cRVv8pW+exFT17mMgd36T1n01RW7fXITLDfI7UVyFjt1ZcjQFQdQMqUHzj9CeY5viyPY11ZhIDGzq8zDKoWVL2JiSCYDaUn/IlkYNFXq3Tah+FIWRSDFrz9qFHQ1EK65wFn9eW/DAfK4BduHBO1+NBMiyclS3tvR/neZbmhiblUcCB6O+hdXBq4kgdn+OWJ4olZ705xafQLOdzwjLCLF4fob/mVUB0bIuv6hYD2A32H/4Fh68LY88eB6RejdPN4aGDOynfMO7dBMU9aUY5tBfpRrCWsQJhAU0DpEJLYnSGgAbhaVyRCUHs3Eu2rNhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:57 +0000
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
Subject: [PATCH 03/12] rcutorture: Split out beginning and end from rcu_torture_one_read()
Date: Fri, 18 Apr 2025 12:09:49 -0400
Message-ID: <20250418161005.2425391-18-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:408:fe::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 669792f4-e2ab-416c-145b-08dd7e939aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81sEqpZS39oYK7fMRWYibJVNzoRUFkAzNbR71rmkdVeIbuhdI4SEETVYgjdG?=
 =?us-ascii?Q?ooG9ZgZX5wISD7ZS8lTrmGeN7v3Hdpn7012VsxtYlAjNTaOsf9yEeG/XyC6f?=
 =?us-ascii?Q?StCbNOlKwHxdcKJ9cqnt8/viQIUD9IbFIyqARUVyY+A905z6/LpbJNA00LkI?=
 =?us-ascii?Q?2UpoENf2du8ap2HnUkWJaK16v6EKcM0fDlzr1AZDZt4B0+7goxIvPCja9/9P?=
 =?us-ascii?Q?1LlZS7pNtLDVidkuvLjJldHLa93TULg85k7EASaH963iKHH31BOsquwAraUn?=
 =?us-ascii?Q?xvsLAgwHwdBO8ZC3X8bYIJY6/FdDm1yx4SyAM8WZdJZCsH4x9+hr/jKS39oq?=
 =?us-ascii?Q?PhmdnZHbwvDb9MiRkhqfTDZqbYaY4T0MsEXZmGM5boR58UQlC6OjIlTghwj6?=
 =?us-ascii?Q?a0CiPlDnK9L9FIRC62M5I35V5SKB9uuEyFxQL/TVQxn4WpPqFDmnM9P04rGq?=
 =?us-ascii?Q?pXW6Gks3ASEYXVglZNTCFO+/UYu0Ep3cCrq5w4+PIiJ58yMF3T9pOH8FNa+A?=
 =?us-ascii?Q?HJp32O368bhBP88yqRmYJuegu2QNc9NwXmSodAFXcp2KZDMa7rc3i8MX3u3N?=
 =?us-ascii?Q?lPkFz8IBC544wCFXiYEHfEywEwNLDe7awJY6Eva7e6ObTnH9kpoWW2ZWhSVS?=
 =?us-ascii?Q?MAVDlXTS6w5vY5XcYtqK7FFZq9xGF+u+JneA5/QyidWaFJM4OoWTyiw0Ke8M?=
 =?us-ascii?Q?bGC61kYJ5EEhENls9p9ENLWfspWHRg6yP+QEpdc4V2xOWbjI0dJaMKmjznx0?=
 =?us-ascii?Q?Wcah69/KGg5lbyaBOTTL76Td12jrn+Ph3eKvSJ1aFcehhnaj3x0kLhuynmta?=
 =?us-ascii?Q?5qv4quUvLxmlluk5qlSTmnHHr0b1kt/syB/IBGbIHcXzO3j1DqoaEoCQXZm3?=
 =?us-ascii?Q?7Kcpc/TWM+RfseyFT9nxlmwYwBDJ4I44R+W6ylsbPwnFAoEQh/fYth0Ga7ik?=
 =?us-ascii?Q?U3tW4LNQSu3x3Y1kKk0fZPZhtEIdMATYaE5XzafzfBYZSvwgv5BjM11BF1rW?=
 =?us-ascii?Q?DSQcy5J8C0Ubw1tN0Cebv6xS49vuBeqNLLgycS0xqlCW+L0iOgVO0k+FT56T?=
 =?us-ascii?Q?Bd02UYfJjzmTMbfqLxyo5N+iM7kSG0xo4IlqYcyH5vtAiC0w1CvWn8BdmFxk?=
 =?us-ascii?Q?+oqIIe9MTDm8QKyU5E6kGyk4f72hmnSbOto/sIGiPXMTbCmpilTpJFX/EL0+?=
 =?us-ascii?Q?di8md+HcqCrnpeIcvxsILHBatRvcuCPs47loEQSu1c7RL4BeMT5P9atH1w+d?=
 =?us-ascii?Q?OvVaUqjis1GKM1RQjX2+7S2VrwM3Y3ARkvDc6GOIwvUtlqml30z9sgYjokJN?=
 =?us-ascii?Q?eabs144l0vEk2XR1vgb3lMTVHwhge1zFLgcnxWZmlFPNDPOb/r+YMnLUA1IN?=
 =?us-ascii?Q?su952tf3OuV6JYsvUsmeng0Fb7PW6KfV4+MfeaAbn9O7pPii+DSOEs7kT3DV?=
 =?us-ascii?Q?SlVUczNoWrkufOWs5qpGIwFs5KuB09LBUo8yhcaeua3pME/atkqwPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJ/jNYQvDtnSXz17A0b4hn2bR4K+UNIJFhHNXkg1mUGVcsHjuzBV4rVT2bzu?=
 =?us-ascii?Q?lJLUXdxyHb0efecYLp7UzEnnp6hKO6BXFzJ/J22h8sZpMMCzNLKBf2Myblbo?=
 =?us-ascii?Q?q+tQvi2KqnidYT23Ynn4S1cIqq3LfhnyJlOJ7bvwdiWTk4TSqf0V35j/KFFJ?=
 =?us-ascii?Q?y7QiY25cqSM2kAWP02krWla7GbAEb+1q1XU740SdiIW2TvSHSjLNWWNOchcK?=
 =?us-ascii?Q?mlsvyJSJnyzQTR3v40GCIM4Nx1nrRjnblZCirHsJDr18GsFRpgQeLSbwmts0?=
 =?us-ascii?Q?vAIeIKkIyIG+6i63RsCJQ6RswAsFZBzthAZLG/7Yyz1xgPJwj8VLs1S5/I84?=
 =?us-ascii?Q?I8fVAXJZYEO1Iw5JdzKyFR/QlOd+RzVWbGmZKo4gXWLu1HrmDpEodlfr8yWo?=
 =?us-ascii?Q?EmfaN37xvhgJpPxsxrDdYcT+19c7v/Iu9FuYOguIOx5Ms0WNTP+GvdhHefgz?=
 =?us-ascii?Q?lOE5dFFauCgrAq67UV2Pr4X4dwkfB+gfNU9FyAm5ZIPF81bkxbVuZ6vUIYyB?=
 =?us-ascii?Q?ePnAel5mPMQ3YwMyBKblyUNvccJQPfDnOIVFjff0zAS884UFIw1cQSH4guNp?=
 =?us-ascii?Q?Csbex4gQhLWPUeQlQWsfzVFwnMUO8oFd2NxQHaLo3Qet3osszx55c1NQJHCQ?=
 =?us-ascii?Q?7Yhu2S5vMWDLw6a4T3Gp3b1Px/kCB51H5osSJLPZyuBazs6TiiQ1NDZGLWAC?=
 =?us-ascii?Q?mEDUVKljj+xVcwbo+Frg0XIvnsjpYYYKrr7qg6z97Yw6ZPm96vvbrJ7Vwjer?=
 =?us-ascii?Q?vrgEUQ7U+GnFN8EnqP56yktVFtavzUJtsfCdWCN2StuU4Mp5ZMkbmJNU4aY1?=
 =?us-ascii?Q?0ExVZ2Bb8VgLu9jI/TrcKcL4gRzjU146AyQVSdnlq+nHQIvwrMeRdvSf/gw8?=
 =?us-ascii?Q?SrfpnDtP/Y96+fzGaSGb6cHcP+iHfHOeJ9f0He1FX0756JkDBovU+fSZJm0F?=
 =?us-ascii?Q?vIkvWoM1OKro7D/9pqvCuE547sf26l4BO1JG5HiF9y710KPXfRQzcGaOXCsx?=
 =?us-ascii?Q?RcqsB4cQcIYLcB1ZyvyQDobNGdrRes2S9Efx13kU66Ev7YRZw/NQmXNzHvkJ?=
 =?us-ascii?Q?tHJFgu1Ah6arF0HnAGoDv3yC+ZXzDUwN5+YxzvFebk76zu5AWPqyQ8FBg7U8?=
 =?us-ascii?Q?+Gk3idmklEbx4Xi9poau6S+wCSvHrTmRkU2ml6q9VLQrFXD6dAJbpHq51SHd?=
 =?us-ascii?Q?sUDwaohxo4l8gHOGSXquXtuRCNTPJECRBuEjoR7gq4CK/nWy6xLwfS1jwNCO?=
 =?us-ascii?Q?PPh/Wxn2XxhrQN06NtQpYkd1+pjxyWKttw7oJyCQnTCV4QDb4YelHKqULm+X?=
 =?us-ascii?Q?sATz3Eum/4IyfY7i2Cip2XlQrCjhYQDyuc5GQy33vtleix3OHJnpMTf5CURc?=
 =?us-ascii?Q?4m0Zvx1BohnPDGNZKxSKL3ZJpKSVW83bB6vbgpafuFQ8H0M+ANeswfCHFo4t?=
 =?us-ascii?Q?jdkjgfHhH+3sN7JDUyk4z34AjD+suLs6nSI8B+ElZYu1P9YyGeLS7JzeYokB?=
 =?us-ascii?Q?s+qIB2kjm/qoUpDGL2EQfsfyvjOYqeVA9ujjxHVUTvvWlYOP8HGCIQcFGakX?=
 =?us-ascii?Q?4d9iw9Qf6vMu4djf3d9IiPmT2CEL1NS0GM6QPDeP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669792f4-e2ab-416c-145b-08dd7e939aad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:57.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rX1nk5YLAdM4waYbAOhykJhHcQCrPREGIJ5k56ME01NOGrvGjjyTmOvU6eQqbx6bbHlQvqRiZzDyhufJIw0HBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_torture_one_read() function is designed for RCU readers that are
confined to a task, such that a single thread of control extends from the
beginning of a given RCU read-side critical section to its end.  This does
not suffice for things like srcu_down_read() and srcu_up_read(), where
the critical section might start at task level and end in a timer handler.

This commit therefore creates separate init_rcu_torture_one_read_state(),
rcu_torture_one_read_start(), and rcu_torture_one_read_end() functions,
along with a rcu_torture_one_read_state structure to coordinate their
actions.  These will be used to create tests for srcu_down_read()
and friends.

One caution:  The caller to rcu_torture_one_read_start() must enter the
initial read-side critical section prior to the call.  This enables use
of non-standard primitives such as srcu_down_read() while still using
the same validation code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 124 ++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 65095664f5c5..b0e96df63622 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2164,53 +2164,70 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	return &rtrsp[j];
 }
 
-/*
- * Do one read-side critical section, returning false if there was
- * no data to read.  Can be invoked both from process context and
- * from a timer handler.
- */
-static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
-{
-	bool checkpolling = !(torture_random(trsp) & 0xfff);
+struct rcu_torture_one_read_state {
+	bool checkpolling;
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
-	int i;
 	unsigned long started;
-	unsigned long completed;
-	int newstate;
 	struct rcu_torture *p;
-	int pipe_count;
-	bool preempted = false;
-	int readstate = 0;
-	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS] = { { 0 } };
-	struct rt_read_seg *rtrsp = &rtseg[0];
-	struct rt_read_seg *rtrsp1;
+	int readstate;
+	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS];
+	struct rt_read_seg *rtrsp;
 	unsigned long long ts;
+};
 
-	WARN_ON_ONCE(!rcu_is_watching());
-	newstate = rcutorture_extend_mask(readstate, trsp);
-	rcutorture_one_extend(&readstate, newstate, myid < 0, trsp, rtrsp++);
-	if (checkpolling) {
+static void init_rcu_torture_one_read_state(struct rcu_torture_one_read_state *rtorsp,
+					    struct torture_random_state *trsp)
+{
+	memset(rtorsp, 0, sizeof(*rtorsp));
+	rtorsp->checkpolling = !(torture_random(trsp) & 0xfff);
+	rtorsp->rtrsp = &rtorsp->rtseg[0];
+}
+
+/*
+ * Set up the first segment of a series of overlapping read-side
+ * critical sections.  The caller must have actually initiated the
+ * outermost read-side critical section.
+ */
+static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp,
+				       struct torture_random_state *trsp, long myid)
+{
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			cookie = cur_ops->get_gp_state();
+			rtorsp->cookie = cur_ops->get_gp_state();
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			cur_ops->get_gp_state_full(&cookie_full);
+			cur_ops->get_gp_state_full(&rtorsp->cookie_full);
 	}
-	started = cur_ops->get_gp_seq();
-	ts = rcu_trace_clock_local();
-	p = rcu_dereference_check(rcu_torture_current,
+	rtorsp->started = cur_ops->get_gp_seq();
+	rtorsp->ts = rcu_trace_clock_local();
+	rtorsp->p = rcu_dereference_check(rcu_torture_current,
 				  !cur_ops->readlock_held || cur_ops->readlock_held());
-	if (p == NULL) {
+	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
+		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
 		return false;
 	}
-	if (p->rtort_mbtest == 0)
+	if (rtorsp->p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
-	rcu_torture_reader_do_mbchk(myid, p, trsp);
-	rtrsp = rcutorture_loop_extend(&readstate, myid < 0, trsp, rtrsp);
+	rcu_torture_reader_do_mbchk(myid, rtorsp->p, trsp);
+	return true;
+}
+
+/*
+ * Complete the last segment of a series of overlapping read-side
+ * critical sections and check for errors.
+ */
+static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
+				     struct torture_random_state *trsp, long myid)
+{
+	int i;
+	unsigned long completed;
+	int pipe_count;
+	bool preempted = false;
+	struct rt_read_seg *rtrsp1;
+
 	preempt_disable();
-	pipe_count = READ_ONCE(p->rtort_pipe_count);
+	pipe_count = READ_ONCE(rtorsp->p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
 		// Should not happen in a correct RCU implementation,
 		// happens quite often for torture_type=busted.
@@ -2218,28 +2235,28 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	completed = cur_ops->get_gp_seq();
 	if (pipe_count > 1) {
-		do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu,
-					  ts, started, completed);
+		do_trace_rcu_torture_read(cur_ops->name, &rtorsp->p->rtort_rcu,
+					  rtorsp->ts, rtorsp->started, completed);
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	__this_cpu_inc(rcu_torture_count[pipe_count]);
-	completed = rcutorture_seq_diff(completed, started);
+	completed = rcutorture_seq_diff(completed, rtorsp->started);
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
-	if (checkpolling) {
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			WARN_ONCE(cur_ops->poll_gp_state(cookie),
+			WARN_ONCE(cur_ops->poll_gp_state(rtorsp->cookie),
 				  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
 				  rcu_torture_writer_state,
-				  cookie, cur_ops->get_gp_state());
+				  rtorsp->cookie, cur_ops->get_gp_state());
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+			WARN_ONCE(cur_ops->poll_gp_state_full(&rtorsp->cookie_full),
 				  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
@@ -2248,21 +2265,42 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
-	rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
-	WARN_ON_ONCE(readstate);
+	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
+	WARN_ON_ONCE(rtorsp->readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
-	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
+	WARN_ON_ONCE(leakpointer && READ_ONCE(rtorsp->p->rtort_pipe_count) > 1);
 
 	/* If error or close call, record the sequence of reader protections. */
 	if ((pipe_count > 1 || completed > 1) && !xchg(&err_segs_recorded, 1)) {
 		i = 0;
-		for (rtrsp1 = &rtseg[0]; rtrsp1 < rtrsp; rtrsp1++)
+		for (rtrsp1 = &rtorsp->rtseg[0]; rtrsp1 < rtorsp->rtrsp; rtrsp1++)
 			err_segs[i++] = *rtrsp1;
 		rt_read_nsegs = i;
 		rt_read_preempted = preempted;
 	}
+}
 
+/*
+ * Do one read-side critical section, returning false if there was
+ * no data to read.  Can be invoked both from process context and
+ * from a timer handler.
+ */
+static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
+{
+	int newstate;
+	struct rcu_torture_one_read_state rtors;
+
+	WARN_ON_ONCE(!rcu_is_watching());
+	init_rcu_torture_one_read_state(&rtors, trsp);
+	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
+	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
+	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
+		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
+		return false;
+	}
+	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
+	rcu_torture_one_read_end(&rtors, trsp, myid);
 	return true;
 }
 
-- 
2.43.0

