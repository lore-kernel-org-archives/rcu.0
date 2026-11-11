Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433135;
	b=aG/pnKaVgmT76vrJmyaYlkdCRz+S0kBqpdRmh7Td+QTwAETdp32msJ2j/fW1KjPHwuVC
	 uuC0cJIMjwiRDscqLgcLobDqGQssbJo+H0D9P0eSTMjqQlhgXp8DJ8HhXfgGvHcHD8HYV
	 XKCtqO3rpz/1UeqzIvgUBoaR0L8v27W4C7exSnib89O5hhbiBP5YBKKCEXoEl8qcXYxup
	 fN5bJYgSRB8Y0kEMF2ttAySAzTIrLpq27pnMaxQWLHe+DgmorSIac+alOzDgBxViaq1Pc
	 fiXeDTiLU0HffS/f8bd8WlA54jtpuaiwYzn+yXNJf0KcoPphfZOLo+BZJyGzxcFw3mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433135;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=M13/WtKtPt5RCfZHgg1O8q9wfZmGrogxX8274+WoujI=;
	b=yQ+9ybSYyW4umGvcUPJuhZVOtao9iDBbuAQioWLm7i5qWG6Fhk1fqKYtQjlzE/6okkmG
	 k72T8uGLWXXRQt5pyxYCVa5FSq6UwDGeWsKFr9zQ7HmJL+47huJnwy1LeA89QkZV7fAvB
	 6Jx5ZwEmVjHjCRHg99omzxXX8MWfHG4kswEFEGa5i4c44kXDW6z9755HB9UsbW/NBxsKc
	 vxAHdP4DmgtMhCG8IxY/93m7aYz4Ldc9p8EkOnwNPn3ZYiqhvyAn7x/mKpl7XOfy1GADX
	 BaPzd0qDrnZgEuXIIE/xHK2J6hrTrsBCr9u3P7Flp6TOPzN8bHxb8PHETLDDBpknoLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iA6beGwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63402606A334;
	Wed, 11 Nov 2026 21:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63402606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iA6beGwB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX9bxD/+zy3i8dLghOJHtLbBCS8K+gs2L+xF12pqxIh1npz9BMBqY2pN8Ie7TXvlT3Idxnlq8HarqQeDT+RlupBFSkkUgs0YlI96sbeRDXE1uryYXELKRoVkC7ztufRdTePnBV90Y+yb+EX7SFivlxr8J4qx6trowIwrTnLy3dT0cUxCzLzVikyG57IhmBEZkHAPz3Uw6/9G/13gf03meOGJT0PyClRsA778VZpTnzz2sYfnPAl5Dbza+S6Moy9+NZsyVRxEwZChGXiwyQH8Mg/QhoejFVu4N8c1BKX9zs4Okm0G3D1aTQ47krZF87rYmcba/ky4EIOCFiOiHztBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M13/WtKtPt5RCfZHgg1O8q9wfZmGrogxX8274+WoujI=;
 b=bF3UxsLIUJ+ykL7FjvzQF34P++ZjnzmjyzoqiH3yaW8vOBLX3VB1lnJBqxMcaJX2QGdvPMA2fjZSSXXsFLDZqGs+Qywr+4U6qHjacHzvdxT+H5aU+6KY3tdhydyrN5ELUU3jMJvy9wc2gx5OciTtT4IM33E+opsY8a9sN44lFOdFiSWOe7ST2K15wbNlIFsGnXRQjJO0NoRk0TOFTcwQPv+I6NL6uknoUBw5w85vG+H+P8YhLJD7cBtlbrXFBwmEe2ONBXdS6tTrNBOFhYYW7djC/Q27gKG+9U+haTT/RpER5Q0WGasr2U2KpcaxZNQ3QTLONyfvtyNLpIrKoorGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M13/WtKtPt5RCfZHgg1O8q9wfZmGrogxX8274+WoujI=;
 b=iA6beGwB5+A6YHDg9qhqRKEWulWwtL6oQGuxPPSl01Qdb7RphE69kZvYN121kwDL1PHADEbWS/mDwiSMcOPb62g7Ojb9Oq/eqVKBGebx1NKTT0CVlSYXwj+3D79E+ceNfh/PED4QlvRtacJbTy5GKBT0WTh6OkyQR3mTBo2ACQTCZN945R0RV4c2HEbJ3c3Th0eDsJwIK57bxq/1sitqau6hqw9mNbCmzJ+vIxVaT7ZR48VyoUduAeEKYxvZg7L3CzA6seRxtYVlf4F+JgdhXBAXC9Cj9r9Sm34kOLHhZuyjzXFPSWRSYcXCULwBARNtm+RFn9uVtBt0sMthzQeFkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 21:38:42 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 5/7] rcu: Add rcutree.boost_disable to disable priority boosting at runtime
Date: Wed, 11 Nov 2026 16:38:23 -0500
Message-ID: <20261111213826.2035045-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:408:e9::23) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ec4eee-e9ca-458a-468f-08df403c27fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|18002099003|22082099003|10067099003|5023799004|261021123027099003|261022075727099003|11063799006|261021121427099003|261009223027099003|261102123227099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	qtIvOPPe3Aj6q8ZeBc2FuXHGHNnoRRoovWiqPeoZ32eWhx381nYYDAv91zhZ0Z6MRguiMyEJ35A2nqxh6fw98LsYAx/57OIKc8/bPmZXhM6iLOqtj6h1fgw/CyLZ8H22O10RSck0PPodQxodMaWoGItAEibYWbEwq+noBbngQYbO44yj7ALFrg7WaIh0POHxJLHA5r9/0t/Z1Q5pdX8rRQDDzFeoOwCyXfT7m3UxG5wy6TWJbmq9DRBSoNE8eqPZkehVZsU4Q6G7+so7mJlGg4zMsN8wYKgior8xyzmnb++lyRZxo6jIhVK5eTPNrXmubbJ0REAZ07JDcqCXlZ0VEn+os0zHXKfrXqjkx5dks1rrOlWlqOHoetjQ/CM4VYfp2wfvLijViaF1RNwVCzMFg/773m4zyXmc2gxrygNL6osUSHAF4wFpTPyR4c2wVkPQWxcEYDpiH+H4lY/w0BUv0pFT02UMwFVMq7ZXHpry9oSuUmF/RzK/0LsTKK2YlKngYGlL755U9zl1sm0yMQWZfTUxrmq7d6yEEHuJz5LMhLSc8TNaojnJroXdYHMjRTVubpr0HJhqMdNyWvuDRBo9FpxKz4OtOIxqmxMbnmkYF9We5uxMA9qPp/KxsTaua3w0O36C9xgH4wjGMV1yFSILHoRQmhNK//ALcflPg0CAFRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(5023799004)(261021123027099003)(261022075727099003)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgMW6nhbGF2010N3b15EJthT7qtr+HgMNcZE3an3CHQT4KAL12pSIZyIRBwz?=
 =?us-ascii?Q?j12SulyyCh1YD4RzC93FZEXXHR6XpiOZdGP309OfHxqYYwYxzxihCF443jOC?=
 =?us-ascii?Q?F8nxZ1wQlsfvhXcnn1F1YFD7T8d+P6e0HDrz7UJrMopJNJH8foWFqRHoO1Dw?=
 =?us-ascii?Q?NqZmQsta1BT19BWi3DVgzHWJ+g1oY+yO/2yL8+ZKPJejvukf/G/Nly/zmGo+?=
 =?us-ascii?Q?U7R4gZXmbGPXUOKuQB8tG8Hz7EI82rYRevDaPi4/ZLyoK0xGHoCLZav5hvmQ?=
 =?us-ascii?Q?BljFRHom4uFgGW6CLQdB40aJyf2LjTyDKa8KfT67pHOLy2g3BSISaIB7kwx/?=
 =?us-ascii?Q?9cqYHaM+Z1Yfe2Cyl8P2NvD5B6kj2RyEBNkg5s3UKk63C20paA6zxLqXSHIG?=
 =?us-ascii?Q?c9hN5Xqmy+PWYVq+8JdAk37Cff1wXlc7mFlcT43ul0l6xd7y94mNbIWBZIKL?=
 =?us-ascii?Q?4/prrspGjFO/CmvcWTc8xUuQYesCA2Txa0bnkeU50gBUipHZesCjEjNVS4V1?=
 =?us-ascii?Q?N0rF875Kfvnx76KbCApxp6ZUIMCqrnmD17HH38lnjYk9osySlb0AGKHb2pQJ?=
 =?us-ascii?Q?ftpdsUP41Kw05PW/N4nYK+UZS4p/nkSJiSrhVmuy8sWfzxL+6rWmubWzmNFh?=
 =?us-ascii?Q?0KwF4P+kLV/ycvfZ6lUNSIpUzwCc5uwIAXwQZII6fRpwimjG/Ji6yRWz6iFV?=
 =?us-ascii?Q?DCvdYw268WWilKc6hYcaDkjNd7qWOR5daiMpz0p7dPP1IJNxr9G5kgVOoR8u?=
 =?us-ascii?Q?+s1c1tdFeB0wRSrlJBnTPevaU1Q5UnseX5Rm3RYcvSWVI0B1y5jFRT5/2zJM?=
 =?us-ascii?Q?CGKZ1HbbEOfTY/IVTHZ0acFzWjrsHe+mJOSz8I5v5/oSTxQVUC6mIfgbzPW1?=
 =?us-ascii?Q?3i2wjizz/bFbKYuEGDQmNut0k2wNeWga2dT+D98ISYSiASS78F5TIMLIrmAG?=
 =?us-ascii?Q?7LwlBOb/Sr/WAFS5Sg6fWsAhteDyfGYJPYPHt0LbUsc+p8JYMSBpbUf7zF+x?=
 =?us-ascii?Q?0qgDj5TA64Pz6bYZxw6sKt1MlQSQlRg7aTlodrtkR711m2gFRpGrYZu8apXj?=
 =?us-ascii?Q?7tzDZbvJIvTWih8oW3+spYCezCi+kHJGXAJ7oitIZMEwA0RtxjCoMRp1jgV6?=
 =?us-ascii?Q?NZzYTq3IRRwCXVzpmsRNzrA2K4dsFp2dOWUnpF0Tcss0psIXma8cx4A3N646?=
 =?us-ascii?Q?XrmJiCvn0Hw8NU6lIpkuAGRUjShu6KK059+ZLMb6aZc9heEdoEhF6J/PFbtY?=
 =?us-ascii?Q?WAJiiiPzM/FYnKyQmQ8u/ieK304Krvzgg1GczN38IJjNArfaU09ntSeCLVXj?=
 =?us-ascii?Q?9RBB6HlJyVTG6FMbGtbYFyKlmYvQ0iCMLfe2/X/VHc3RzmKc5GzBljXaX+Gv?=
 =?us-ascii?Q?ij680JZeIlhmST2TqDHYnG3EfN6jU6uXmrrq+qUB+9pMDUgm2Q1oOLRSBFGr?=
 =?us-ascii?Q?MRyr+Dti3f8Go/PnHVgWz+fh0mhPs25hSYJyPH8u8MpPDHjoEY7Sn3uh0P/o?=
 =?us-ascii?Q?2UCCnAXZhfI8ke4bEY4CM/paUY/fEpLXDMlkukLNq1xWAdnQiR8jU4ZwF5CK?=
 =?us-ascii?Q?PKxA/v4wksPWhBMugCJ9mJijnw1riFMazSiPBSBmkSqXDrc07ntKV1Dqrs8G?=
 =?us-ascii?Q?q3EfsiF2suhG8m/7OhQ8HnPId2wX9sOB3tN8KIL0ZIWmRACr0117Sj6Speu4?=
 =?us-ascii?Q?hoEwVI0acEq5bK+R7G3BCDSRiLF9o+zZpbTphVwl8Tj322rEhOV5ucML2yGQ?=
 =?us-ascii?Q?LPFXs/BKYg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ec4eee-e9ca-458a-468f-08df403c27fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:42.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7IttmeWABD8XcD6Xm8Ax4vFeSal2Gnu5V7cpjmqO6NO4UqIqrBXTnDhVdESwe541TVvpxNCB0ulyY8mbRf65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

CONFIG_RCU_BOOST is now enabled automatically for preemptible RCU and
cannot be turned off, so rcutorture's BUSTED-BOOST scenario, which is
meant to show that rcutorture detects broken priority boosting, can no
longer break it.  Add a boot parameter that makes rcu_initiate_boost()
do nothing, giving that scenario a way to break boosting.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..04a58dd003f4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1270,6 +1270,9 @@ static int rcu_boost_kthread(void *arg)
 	return 0;
 }
 
+static bool boost_disable;
+module_param(boost_disable, bool, 0444);
+
 /*
  * Check to see if it is time to start boosting RCU readers that are
  * blocking the current grace period, and, if so, tell the per-rcu_node
@@ -1284,7 +1287,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rnp->boost_kthread_task ||
+	if (boost_disable || !rnp->boost_kthread_task ||
 	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
-- 
2.54.0

