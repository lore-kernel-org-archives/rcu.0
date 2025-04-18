Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8721CFEC;
	Fri, 18 Apr 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992968; cv=fail; b=MGWPRQeA4kmbr6IK5q5ttX8dVIu/K/nrzkYrQTaFtcXz9R+DzXiOH0jrzYmnWMZsGwEcI9NoYtw7C8pwPJj3J7dYL9Wfs4ptFz7811U1kR6yfva5aJlEsp0V90IKVxL9hriZrUZdn7xk4R5wz58utb6XUYD0AeGn1ANAKz6Nr9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992968; c=relaxed/simple;
	bh=5TA0eeN8t7tsoetW3L0NsW24GvHrKL6N1EfCj0vTy7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdER0judvaV5n5YfZbZxQE4bP8bpKqbytmOJASn2ljWEbbhdSgmuPubMplnn5YM+OgjNBMqWDfdLZCqFIuLbZXShFqYnmjN1c20bZmGsg9SuLBaLEMAU1R4OAcYUpUS/abzoW1thRP6QVz4/L3YLBMtEoCrmsHwto1LBJ+RNptI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NR1Btl+2; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NR1Btl+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEiZCLRz4N2/BQ4B/6CBcEjZw7OfCKbh7wdMedKN96cazc0oyofOL6CgLOwlHvhmOpOKMCA66j+n8DuLxKQMcWlhqGwXY1ZkMr2Nuj64b5WlHdGoR4PaK5RfhKMPtH24Ryl0G2u48k8VzljthIP7ayq2fQnoJqdilXzGd7oASBGxZ9OH2LHv+lH+d+u1rBqelEgQjCREQK0fapgqoYL9XE2NEyPKh08yf6cH42ILciOvWfXm+jLjg1oOiWz0+6IiKTfZ2SKamDse0Mx5+0hty2EryeA536b54wlpbUXl3QyE8amiS+NG5ibAO+6z7i1vtjDyp6/c5ZT3p3BUT5tWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOOxVf5xKWS5dV4SVgj/WpWEup42rgCnWclT42L+42A=;
 b=MvVCm50SV4ZSk24UBSZKRZW6d3bGXOlEnGRPx70G0RlYXbHhrRhrDm5m+gZYu5q6gJWHdKOLHR80D0a+e6w1ckJ7pJphfapYZ5jeYN0sS+NpER28iKOgNsOyv99dI+TmP83VoajL/HYVLZOQsBbLNqFLdXrvSxB/DeOV7FLERlNO3tG/4E+a02MW+EXHobKmkZmWrQ5quxvJdVWwip2E6vQHQnFpGZn5Yo0MYXqA6d4se7Um4jjzhbM0j8gTKXoj18xxtfySJuZyO9yFZeKtKeT/wp5pg+vMKGvxU2tLm4ZGEdoc9McAEgYJyGzcTz3lZoFitDJB7inPv5RM1kvYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOOxVf5xKWS5dV4SVgj/WpWEup42rgCnWclT42L+42A=;
 b=NR1Btl+2To48p4Y25A7F1fMsXm+EwlokBFoubMFYKNSEIuKp5FfIGgKS7O68t9t/S3Bo8+gcZv3VfwhxMw+SjJAreSp6xh1vuXH/mv1ZSqxTBKwBCr0tzP8RjWVsygaz71GzZRe3haRjs3rCymNOtXHgj25QnivspTPqY5BK4FS4AA54wnOmcSR+REW6D8ROnq67zGbwk1eb7dxegX1aTPNnORdUWLFXV6ipT3XU2wpw9PSFcB5cPT81G1Lh4wOwovDwW+NXWsUl7wPimGiV/F284EC456IjncF85ocmMAhmdwD4VASr/YXzhT3V/7KvztXZ5Gfr6ewpEY9VXIf5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:16:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:16:03 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 6/7] doc: Update LWN RCU API links in whatisRCU.rst
Date: Fri, 18 Apr 2025 12:15:39 -0400
Message-ID: <20250418161542.2429420-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:408:ff::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf9f1a7-6916-42ff-7bda-08dd7e9450b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Hq9M87XcR3qKLEM5fODpQX8tZQ64j8jMhbN4/fcXQMQV9QofIh13LulmOf7?=
 =?us-ascii?Q?3saTz+MdXuVPJtRbunA/oCYmdPPDA3zPLD6xyEpm1awC8c8SnktrzR1SEPVq?=
 =?us-ascii?Q?eegCaaNvoczAe2Md4NhhLkeb3hbLooiVMmJgnS8KhEVU/klCqeIYczP9GgGY?=
 =?us-ascii?Q?SLC344zl/i4KpSyrmPoTM7BdZDxrHRPG6YQQiH2zrfv3yXq3DCkHay2RSgm9?=
 =?us-ascii?Q?E7yJMaUHaSRs8+91UlhT7G6ivYnnOPAssx9Oe7CmMmM9V/BCwIjEwTGCzg+P?=
 =?us-ascii?Q?RiOKdZub1MoBHg1mmnxDdexyBK14lu8uafyO132fFplYXYMevEOInsoKtgF9?=
 =?us-ascii?Q?20fZAS1yPxsFY1DDXg0eq9ER+FPx+eY6Tlwv8mo0HXp2c3/hZc0hESjmzQ+2?=
 =?us-ascii?Q?KH+unsHOciHWH0L43UYczMFdbV2mj+P/Ygb9/hjviOBBUtSqVZut+j0LiiOr?=
 =?us-ascii?Q?YQMPXFlRGlApThbaw7ikqxwfsGuxzjOYOkWmUrbt3ZD7ESGvbD6dQrNTaM2A?=
 =?us-ascii?Q?//Yb3+QRoLANbNfL4yrfMiSJqgt/ok5SfG86RXnuaJpUs9fFmf2PozZaep1o?=
 =?us-ascii?Q?FI7E9DBWUg1qYEphfb5cBDjNcWhwwmUtypav2L2FNRj6m1Ak46NYZvkbe2QI?=
 =?us-ascii?Q?Gel+AwdqGYZqU78fqhXe3izO9TCUDLvQm82BLvTxmCASQvsmnTFr1OFfh6Z5?=
 =?us-ascii?Q?nbdNTfPDNp/o+i0/p5mUI7oxU1FhkGjif7pM70rIAeGeJo+cUwWgVI/2oskn?=
 =?us-ascii?Q?Jjyft5oOZapfV4qcM+2XxPLD/cCoE674J6+8/Ixa+ouVowyO/cp2lII9LFE0?=
 =?us-ascii?Q?Lp5ppHyif9YyzEhlnGyGTg6gyOvC1D6c/ewcrJ4+d01w2cJixO9akFtVAiFH?=
 =?us-ascii?Q?cSjU0At32con9Y3yW9S1d+HyKOWN7wSewF4xjd1I99maxX1kX3mBcj8TX8hV?=
 =?us-ascii?Q?uByoSBc84gvf/REBfLw26ZkVSsoDkCGM1MX4Z9x+mY5fB0IftC0vAFjq9uEa?=
 =?us-ascii?Q?6NQ8cXuMvg+OVCQr2EoaUpn7knqBzpl0XKMbS1ijjjLwmdTLwvGdG8g17FMB?=
 =?us-ascii?Q?EwLnDW6tOlcFwtV3E667/6WwdqRWBfArcrdA9HYrEkzP9fnImVIJuc106CME?=
 =?us-ascii?Q?w57CArtxGPeki2vQZADucb3VM8PVFFkMzxuMnrIoVO/zSh5+6XGJVIfsrz01?=
 =?us-ascii?Q?ZrXBLLED5UqrPPL5J6QW2evKXEjoFfL5iloFnRANut9UUvfDyhYwxslswAio?=
 =?us-ascii?Q?/9rbmcKOI5gcn1Hsck6YrihThPh4oWTJzEAjTh0RDPxJ8+3B4JiHH2VRA9av?=
 =?us-ascii?Q?LLv2DLZrrtSFocONuLbv9SAxNshuUomANyoN04vnJnsTQy5Uul/IviCIIsqn?=
 =?us-ascii?Q?djX7e/8C2FI1K0TocIUJU6H1Rxb0i28HFqQvI5RWXW2RwGoKPNqAiEmNgq9b?=
 =?us-ascii?Q?zklkWZukpCsi0/wtMCJykaPmyjaytP3gWA+VO6FLNxcg321RcxW1DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/IfYItJz6zVVb4SgYh6x+q63NbMio5Z3aLlqdcYh5bP3aikYQIShdFx3z9PS?=
 =?us-ascii?Q?x/fj0IVCUsLPVzf/bpRNB73IKNjRKuarjqW1fgAHdB0QIAWiyFQ0sA5SkJ8N?=
 =?us-ascii?Q?q2Q8zwmSaK7stI7Grh9g8v045fiXf1i2LwrR7DIsHwTU3wqbXx/QeJ0qIoQ1?=
 =?us-ascii?Q?8RLqDOo5vJ4WUevMDXoABxClcUHngcRVzaC923ErMTFdE+KC6VeolmIOaOGk?=
 =?us-ascii?Q?xIgKWQHlGgSkjDIPFt8ZBeIPoQXQouhgTeYbwIQbnbUzHOTjtN906gr59S+2?=
 =?us-ascii?Q?ftM93mZS6tZ1pGs5hSywwA0q9p+cJNBEyIvqIhGMGZMk/0UxQKxCQfrP02Cx?=
 =?us-ascii?Q?+8ZJFypfj65F5x8oIP2n1szJfNdAPC6NUQbj/Nlwv6kJQvizCwLye6dCRnx3?=
 =?us-ascii?Q?5ZSrV78P2TOmNGFENUtTzWOWenRiIPBm54Qz4XdUqS7ppqLUhfSYTnCJWF0+?=
 =?us-ascii?Q?LYjKfE0KxIHuh+2LrkucZ07lFVakFaQBtCV/njbhUne+0rQmDA3fpUH8wWut?=
 =?us-ascii?Q?MNlaOjKlP7AgsT75YQzbt3qLsIkyFlz8HqTTN5vVKS/db9DUuxGLo+ls6Vfm?=
 =?us-ascii?Q?T52imzIo/D2IpxEJ1TayeyYY+FkfmmqDuMNZibaOanrxh35eMSxxIEWj9Axm?=
 =?us-ascii?Q?KQ/GXnBaF6x1BSdP554I4pMWsZ+6lTpvwZeIl1MI/i3SkXu4p6UHVsRlDNGs?=
 =?us-ascii?Q?NWwTeF9+gOzO8c7KeG8IHtRZ8fyeToDhybaKxRP89yhsweB+CEnObUx8MQHG?=
 =?us-ascii?Q?NKJega1Z9bRwxHu6a3dC95wjoBGLl50aBcL+c3ePC0gDXgxTzMkbKLxuCP1o?=
 =?us-ascii?Q?MMcnTgRnyhshhi7vxIqdcnPqd1UwkkuFPq7f4YA0lX9BkYALJRlkI9dIvdjC?=
 =?us-ascii?Q?jCb1JEYR+EweJyExJCjrvukHsi7z+mVsACyQShKkXZTEGPEVwzCPG3DXVZSE?=
 =?us-ascii?Q?hBCTbolCV+00PrQL7ywn6bv6cQ1p8RWlpMfvCTfxUwToXnNCpmpt9rvZs4D/?=
 =?us-ascii?Q?hIpe73+gfxHW3zCP05ALM2p9zJ7ig9XVsc95bPbYekjJBdQcyu/CmM9nVupd?=
 =?us-ascii?Q?mx/pBUENwPm7s4/igMbhv+80rFmtMDAjwCJt5RhPUAoCx3Om3SHfbgaipQ/9?=
 =?us-ascii?Q?xkDeMG0OCYQwr3S5FBJe/qt6YRe6u0PIqABgD+A5X5lFMk/jdOkB0PBd1JV2?=
 =?us-ascii?Q?pXPuKnX3kSQIIok4u8Db51ZwozZQTZ0DpDYaU+JOv5x7bYx+t3aAbS9C5fCQ?=
 =?us-ascii?Q?sVKxgQRHN1kLxLk/h+WdNFd7DBqaD1yqmItf2EY6/s26bevZZFomFc9/jogd?=
 =?us-ascii?Q?1s3sCYHHcpTjfrietcZ3oWMqBzvNQLiNhSB6boqbaMuuyAYfg+Ur+jt/364b?=
 =?us-ascii?Q?OhMWbD6KToh5oNUhgB+LR246mR5ZBZGAV5D5VzjDX21ImoYkK4UavTaTOKvl?=
 =?us-ascii?Q?eh6LqWgZ2M//nKgAIyLl0fIhLFvRUCQqjxp4HsS3GnaiBB+UyYYJp7xJ951G?=
 =?us-ascii?Q?ouo9CbaR9t1DLsMAE4Guena8ZMzG9Tq+XxSEohViLW3n+Bv6pJe8m7xIfj0T?=
 =?us-ascii?Q?hwm3XANnXjl1c5LAwdUpXTpAXvBBTVQtAL4jQmF5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf9f1a7-6916-42ff-7bda-08dd7e9450b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:16:03.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpX3n8Bc4RIuHomSH9f4N4AVNqzwXRKAHTh/+BTbVXFztE0HWlSaRRxOFdMZAfsJpbFsRfrVhBdwS6WR2yWeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the 2024 LWN RCU API article set.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/RCU/whatisRCU.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 53faeed7c190..be2eb6be16ec 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -15,6 +15,9 @@ to start learning about RCU:
 |	2014 Big API Table           https://lwn.net/Articles/609973/
 | 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
 |	2019 Big API Table           https://lwn.net/Articles/777165/
+| 7.	The RCU API, 2024 Edition    https://lwn.net/Articles/988638/
+|       2024 Background Information  https://lwn.net/Articles/988641/
+|	2024 Big API Table           https://lwn.net/Articles/988666/
 
 For those preferring video:
 
-- 
2.43.0

