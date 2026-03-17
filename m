Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1839151C;
	Tue, 17 Mar 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782596; cv=fail; b=L0wEjMZNbCbHcUuzKIBfrLsNzV2ikRZcwUWBOe13vAq7flJ7Yxr3WXCJpk36rKU2qN61KVgFim3PILCCJ7Lj/mcf/rJtXCwhb3ABnSWO3UTrHvrakyV9Y+2azY4vqSxTp7Fu39QIJe4Zhdb6kyaonys1ESrtFInBZCg8U3WZ+y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782596; c=relaxed/simple;
	bh=gJyvWOPLUYTJ3AGsSGHhSKCNbcSLy8S+xuWwMiRa8wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxojrRl/oCpIbzijZyEDMrUJhQ+ZEvhGqo9jTL0ZMtVr2RmM+KBLn3bOTOx7N9e2g1q0BvFGHAMd5/gg6/OXriX2ot/65saSBLrhdh93qP8VT+hxv1eT+bbwSi+kjPF2WtTC+si87V18j2lnnOyEW5OxAI1/tEqsBkvhgz8anek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a57ZrGmC; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a57ZrGmC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3Hp/hDCQtSB68AXIGJdJAnAhtYqBY5v/P1zLUb3qAhJ1ZO+rD5WvcAo7XsU/BfhrGVKq0Fn4OWORQslVFtlIIyFw3SVebGdrxcvXoXde3iRgtfwEITdkSktO6AFVXeRBz3al4EfOtkLMveqC+7OdqXkz0gEZSdz2gwKR5GugC5FE1s40r6zUJnLDSs6Qciy8TBT96ZHOrqG8fe38Q+S20nEOxE8KUs+psTUL5aZutjrkwk6+/UvAfTFB1JurDJXudCdG4cOHm0C6W/D4pvHmC8ZPIpxWtRGVgomWF5XoMaasEvjbpeGKXi/jg9Jypl5snRFJ4nIJus1F+KDKQhPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMT5JvlHmerk5ioAGzF8+YA0vpu8LiHuwkxSeeMQKPY=;
 b=HvN0SGAlTVePyPJOB1cGvWuVXxiEQqnm8z9K5V5Z4Y11aX/3BVgKJUfilEqJUeE6bdhhvtVak+zjtL7nnwRyXYp/Zan2Ti7C8rUZSacIuGXSdP/kXA6uNtB3vkT8WGx7cM+4pX9zDATHQv6bnx+b7gxKbcHxN0wJy32vIsw2+6SihlRS70wP1Bwkl+gEL2j02NIW4FX/aAm7VpxYPhf2HtAMOIf3NZb+ChuDCVVAVfKGD0VEDdrjEPD/zy4GR/JpBhw48FjC4R0Cxn4goupZ595XNrId2C6F6G1B+6jdjT9pW7uDbSUw+J6bXECz6UGEJfWNRbx+bwEegZVOMI+cOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMT5JvlHmerk5ioAGzF8+YA0vpu8LiHuwkxSeeMQKPY=;
 b=a57ZrGmC7oz/QfSv/ALXBzuIsWck2STTaPoN2Mht1lGvO4iae5K7a/g1SQq5u5R8qq/yss5AfMsaVVRVVraGrbsQLy0xNJRLF4CFYvljqtoXVkzrL/UdtAttdkg39xYXH3oKPi0UUk66KxIbVjFErA9nsT4E+6mQkWjYUtAUbeO73XKr2b92l0FW4QaQQTwK0b3Kjupy6vsJUIqXre4iDk++JHvxWUcUt5cmjlOksFJIWRzys8dNLj78eQ7oKqjLz5rKQK49V5mQAt5tdxIGh1JOwb0B8mP0rT43mXAudqBz++jCvue0X0RWrBcndjYnjGBCV+HLoJEJhoLnbM0Hxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:10 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:10 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v1 09/16] srcu: Fix s/they disables/they disable/ typo in srcu_read_unlock_fast()
Date: Tue, 17 Mar 2026 17:22:10 -0400
Message-Id: <20260317212217.1527644-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:930:14::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: b2049379-75ce-448a-0770-08de846b627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FwILnyGwIoIWcM75sVVQ4YGO2q19cdXT+H7eVsXXkc+M1VoiZAHPiTbHe8C58MPAaVtuvAAdUO1LZI3e+D/V9Be3QM7XCHC6dN2sW3MHyGh4VptSyx2fVE96rlEj18PgF4ypDLzcTivSgXgsTp6YceMoXcoGf42Rye1oHfE6mmvCqd16e5hE0wiaochHmh6fHJSbOqwD16nUBxixoBWgBsGGCVVhg0QlVI8ugZ8vSreKpEq+Xbg0XwNEpfCFOpuK0EnlYgkRh1X346SMvB2nqJwb+15qBZM8kG5ZM9Vb0WoD5t4F/UVvXSrER2pCx3LQJM7FVbBGyiaxwQ4JuD64PXzMC3jp6/mKCSof3YlnWQsC0ghNntqorpBr7qhzpOBcaAMAvOqsWygEUnd1zIvf8YbTXyoI1SMFXaH3O0V4javbSfiiqiF46h2gU0pPufVpVYI1FGsapxq8ZuS/fjcMi7ZeH3wtbDD7L3+0SF5eY9gLscTTAWrnb5W8nG2plBoXClTX49Tv1a0eNK12JQJj5bnyIapUMsL36oiFUWFSCYdfda0QnWobCxoZ0+pXsw81zB1yVdyU+4/qW26iRlaLapLpczb1cxDDDEdl2EXnS25NzEEt51IlDWz5I+2efaiY4o1P4fU0ukWBEX0qghC96H5U9VuNvJ9rlp8pBaVlL5VXvbk9MetH0PQYXXCgOKoKGDo/PLn1gX67VVq7H6LDnPCJ1dfjKJzGaVJM54GnRNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QX5ogBAmB7rBvvA5aHWeh249LGzMYWjCSq1NERhBENvJ/nT9UETO9y2MpQty?=
 =?us-ascii?Q?16/0jBGvv7HixuBpDvAi5jeGcP4TWw6XUqXtLtVsDyn/qJqBs31Z+IJMn8ws?=
 =?us-ascii?Q?uBTdXgxB/OoZdVVOcrq8kfLdXgueUBpPQqANGFr8o1+VRvJh/oF8B5SpLo/h?=
 =?us-ascii?Q?bTR+fmcdPtP1teIkV2fw1zSLkjFzbERXPVhBk8V34ln/Ge5dnbaWlLobCK1H?=
 =?us-ascii?Q?E9Sv3MMEqCjHgsP/9j+rHXF2E9k2tzD+kpLlFMfwAG4j6stMHDs0s8iozcL2?=
 =?us-ascii?Q?fRPfJEyNVUBAYvxKRXfz7vb54Pww0ehM2gmO5QNK8TOmriFKYloTw+aYbHjG?=
 =?us-ascii?Q?vxuh+fpVuElilWZn7JJUXn+83InFauOD80Zl9A0xcLNCTLDRV5xaVVNjU00L?=
 =?us-ascii?Q?uhdJXmMizZN5ZXzSRU8L+Fs+uAYEPj8Y+dqjJOdAf8ID6lRvVj4Li81KSXnI?=
 =?us-ascii?Q?j74vsUdtIegjO58RJsAQOnLe95euoaH0nNnhWNGVnnSrkbJhAuwzsbNWA21R?=
 =?us-ascii?Q?i+sJ2m9BFDTQ9UuZjIAVtgoxIMpG5DiCAxuyqrzqlpHkju1wSliHcv4gUMSJ?=
 =?us-ascii?Q?B5/m5RT0OObklYcDAvu2mNaEX2VEMlm26CDTOpapSe4GNWBhfbldFi84r1Jc?=
 =?us-ascii?Q?BD3a9zuio5AMN86eAgd2K2OMK6/ADU7ewgPI/E7J8flKjNuWkcBANM9Y/5cQ?=
 =?us-ascii?Q?jbGYXCKH6jGBsIsxE+3l77IjugbruOVCE8aBSFE2JA+RCbnbhsuq7bwvzT5F?=
 =?us-ascii?Q?8JK4ixT/1THuJjdT76dXxrGyWVBYJgxHshQNN7BTZwM6pUgXMVDQ9rVYGMMk?=
 =?us-ascii?Q?ppKUcP76Ev0/m5l/zpsC/kb1UKDwjH/F+CYLjeZ6b5Nkey+HA7YbvAOhwG0Q?=
 =?us-ascii?Q?95r6wVV/7uzi+AxnkHbnhvRWtdQRvVmorCfu+b3Kvt5Uyd7bOhXr0xKfelXe?=
 =?us-ascii?Q?i14Vf82DD1l9IoftKdf2e+Ky6hIN2z3vfJyLd9fdoVzwdpUex2GKzAngwaDA?=
 =?us-ascii?Q?/EOOYuF4T0s6uwQPKqFNqPNes2SMseLqUZ7GqyTUMnEhQy3XwGuuXfE+LE3w?=
 =?us-ascii?Q?6DOArXKkASXOWareIPKjME9teP9oiJ0rfd3B4dANHXgGHf8mWGc6WAi4ATBH?=
 =?us-ascii?Q?ppk4hH0o5xYM1xhUYWjPRALyebly89pH+MniI3Is7X5ywhhMa30ywOmr05+Q?=
 =?us-ascii?Q?fxB/3Rahv3s3+EU89bk+uT9Wr1nPTiuUzbqnqDknKU8P5RGXaVSjyUQd5YPB?=
 =?us-ascii?Q?ZFa+sw05HGRo4osKIVNK0iiAxGprDuVjyBDBiUTmWbnZoM3G+2Dc3zvU5g9p?=
 =?us-ascii?Q?iyk/nVqCytuwHtWAUCGw82FZqgnkXMlejb+AMAvWB+PWADcZm1iJpuosFV0H?=
 =?us-ascii?Q?+OwZW1qEYIjJ6uyR0udB6/AxcJ1tIoBNnoX+Zl320q8p3HbSdu1TsrTKQddH?=
 =?us-ascii?Q?faxxpsfahYuHM8f0+WfZXGmfQ1fcx2/GCrDPaDA8dQ6AptYaNxgUhUVQ/SjO?=
 =?us-ascii?Q?z6cE0FuXpUo6pBALpGiO3rmrBUk8Nrbli3TPO+1xfRjXmCDEOVPT4rblW+1N?=
 =?us-ascii?Q?55+ttf/XK4h4yGZljg8sqMJTmmYSScAoIslTTGC+otIGTYO/JA+Lnny3D/mn?=
 =?us-ascii?Q?PFU0hUmkL6n2Xge6+2FlgjhXZ6qLjQWiGumsHCmjQYLOwsQDibJm6n/pRoco?=
 =?us-ascii?Q?+IrCpbZUHtFiJAkSZuAdCqCpOMOhAbhKHAruIS8HOTCJvza4EOeztfbiC80q?=
 =?us-ascii?Q?KMoquEIEHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2049379-75ce-448a-0770-08de846b627f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:08.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmzPEyzvfcL16thNyvenRIBkqZTMiET60nYtFJ1rSE19oJzeMFXUwWxkINUXe86+Tq8GGMKSp5kdqlFdbE3G8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

Typo fix in srcu_read_unlock_fast() header comment.

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 958cb7ef41cb..ad783d4dd367 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -259,7 +259,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_read_unlock_fast().
  *
  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because
+ * critical sections either because they disable interrupts, because
  * they are a single instruction, or because they are read-modify-write
  * atomic operations, depending on the whims of the architecture.
  * This matters because the SRCU-fast grace-period mechanism uses either
-- 
2.34.1

