Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8544611C7;
	Fri, 22 May 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459856; cv=fail; b=WJVKvLKN7zCa4qowBq7z8S8Eac1e6iKwCpf0m/MeuCOffWuZ+x2lvW/MjG50IbaYIy4ubvnoUMN6IPQ3dh2qiIU9SOYBu5CIR3kLmaGl8hJ/7LngUSuQsA0d9j8zj3UTLrduck3uMY+icbqLhkADj/lT3JfBASdC/yigbUZeUiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459856; c=relaxed/simple;
	bh=i5ccyOM6NQzmv+Oq+eBJFpH1UlwsRjLK8QAgVcA9JUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6H8y3jVtmg8aQaORrea2UVFdPdEafCRj6tHqqB4g1OIcgN3Alp9oTd4lGlDkk9brsdCFKkZbNdg7rcY4oB8Krs3qYAwCrxjcvJe8//ZI66m6maDK/mWggN8ErcJpqxufutHzVkx/0QwpfGTRDa3PMTuYNu4FhqKYq7uzsFYHd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ng1p9Mpl; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ng1p9Mpl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1NbjcdZ67sSUkurKaQPxLvikQNNYIFuER0wKd9Py2BvOU1Qx/vlL8Bw9DfD/EEE31c1s2ToEaTrWoFCi8uiSY05FtX/ENZiKG125NGbIodY/nxQYP1ZnuQXdnsn3eoJs5oyGbGd6GBzF30VNF5iqbYJceGj8jqayRmMky/YtX0ml3UozzfDKCnp9MuV0lomHIgE8Z/y+n+SpH9TL0KrcDeKZjv4PKJX0Rgu5Uej60BFTAUE3jlDibj6kxC3xmtSUUJjXeog1o9730p5CXraW771LTjp7FP8yzUvBQjDrtY+q6AnoW5Hy73rbXOFF7wovCz/iTf+LUu6Ej7aWIkh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=Qgr3QQ3R4E0uQqxYukV374lKvbKKCSRDz7/3RNfzN36yEr5cnYe7St7VlhNHZuxWwypOCPPls4vRha2G6QJyTTtpX4JfInRtOKeCON7m4I9mpf58iqPoQuRTywB4+mAaiQWUratsyu/SZu6cwn5hNq4/wv6vAOGVjiPv0TPplVWrRaCX7BQPSpON4W15PFy17/nDaTqlcyf29sLkUfUfkz1X6IhUbDuju5AN1GqOBMFgDFlZB8VkMNGASbK+qAvwu0L9G7OsQegwGk4TJDfWraDook00/W4WM+olwt2iP+YQCD+XGEWirLqii5waZUNKngdemsVpX86rAjW1a4wW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8caone8W+O1koWf1I0fbJ31miabks0BK1rNItW5rdw=;
 b=Ng1p9Mplqx0zlt/+b955yjz+nUOqX5m31NxTKDD6sDsfk42dv85J5oDs89XGvBq9cW0LPRGm8xdHPC5yl8zBcRRocUngCBEi233BSyjMsqa6yHTMpE8vNQS/Kchqw34X3y64OjtoIcTctfi/vxOcUuTmncoDY4+atFg58CLyXE/i8NcHzvN9FxmCC62drHqirSZ2XyXzpsfL1E2wwby2jKhJBzuh5PSukC/4S5yOlM6XNiZyDw4vsBwSLth/C0nAMhzMcICXXtpl7dPc4zxfab5IR1dKjGF0odZA7ZiXeAYfeKwZI3t1mQochikVbPw+36GHyjWNujJQ3egFMKJt5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:24:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:24:09 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH RFC v1 5/6] rcu: clear defer_qs_pending at expedited IPI entry
Date: Fri, 22 May 2026 10:23:39 -0400
Message-Id: <20260522142342.1536533-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522142342.1536533-1-joelagnelf@nvidia.com>
References: <20260522142342.1536533-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 018e214c-a5ff-48f7-52e7-08deb80dc9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NbuLWk54wi1y15jwkOowbh/xsvUoy/2IjzzU/3ye6EgTSTNR9nf4/+J8copW48OavOZ7SJDeDHfnpyZhNPj6WuqEAoIKZBnAl28bMcehRD/pNCX1rFmtKqjCX3R2HAq9rII85DTN5IUBfG3+Pze4mC+HstdGCM60bmurQa/oX/ZDNmw0yqiDX9nPeEmjswvmb7aFHJ+RfQRdUC5As3ArliibJWeZnwbWuwNc4hPmgSD2opKg1srUR22E7wt/U4NiUjFJn/Fvde2A142AJ1xJp2yCWd6Vs1Wn/ud4BkFfnqmRX2ELjFtQL1p1nqV4z5gJlynrILWwhC1Q0eQ1f6h28QELIyNIEYuyRIpYxuDyycuy5Xf1iqXMhb5Xuob8sMYAJYMcJPEogA/h4hBSu0QFsBBh0hrqlhMeV4ry7TNMMdUOULaJs82ZRKdTa5mOh1E5alWEyDt8dBKWGmPKWd4nQYKI1aMqkVe/BXICjJMRauE1hhudfYByXbqPCyIGW3b00xIy9vSqPUTVz6O/cVTJ2E4eUwMJ/kLaDGsbM7SzBWhnE6ADf4d3iCCVTC1EQ7LmnIe7NQGIIpjFYfm8K+OKGNq7IiUPVZpldNgZvIne9/goZoKc4xn9GXUGmpm2KgGk5BnEHgfTID3mAj5lRV1vXDscNPSvDqqj3k63D6+VMwmBXcL32MZK5Tebz5IOjnWXlppjrQGJp7mkiuVQ1fjK2ZuEvTvOvXXWS9vgmyJ2pZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqRRFCHr0NscAv6lmvsBRRLs6J++b7nEfvPIyaiU+bOKvNQLwA5Y9ruz5wEw?=
 =?us-ascii?Q?D+gfnBJPEwWioR8Odv6kS9v05GAgzKxIc/YOl0zstCigaiRxfGjicsQoYIm4?=
 =?us-ascii?Q?SvvryxglU0qmBLCqBOhlkj7pmt/0GSpz0Edenr9uBD8lpVkj1zJas7Hp9+Kt?=
 =?us-ascii?Q?BcH4meG2PAjIA+VdmQFGzDaup/4s4/up3dMO9QNV+39VMoLK29DRnHRf/0hP?=
 =?us-ascii?Q?2usSK8zB2fymnfJO5cZCSMhbgpcsXRmPIO5hkQMsV7CNAKrhUUT/dkGGeb8O?=
 =?us-ascii?Q?mxk+5FoR4EQ9DZLtVunj5Fq+clVqii/ha1aPcdMf8wiquIiIQlAZoYHg2SyI?=
 =?us-ascii?Q?53RIB9q2u9+56jd1SuHqdyMkS56XuzdtkyA9ElcbZREtQOmZ3DXZRhM+4Uof?=
 =?us-ascii?Q?S2+Wnt9+CIMgW9DkSHRxKGRnD3BGFzssIVhF4BELJuC9fvgUPwPtGDCm0aTK?=
 =?us-ascii?Q?IdKyW3r3hioNoawGmW1ymw/mZNxBlEAU21koCbXyzc8tZ9vYVT7JY+UlpfSp?=
 =?us-ascii?Q?GPH1tjiJQGBALY1gwLgpEKDf/sdSqYGlYqpAEdSNQ3czogQBw2/IFykMK+sB?=
 =?us-ascii?Q?nmmZ1M4SuqOPo3sDIJdFdS5DCTjlBFQ2j54Lg780gahV9foftSjZQTTCQf0w?=
 =?us-ascii?Q?rCHBoN3iNeKgQkssxqh15b0R28mwq2Dhmm8Qk6aRQPDnSI8lyr+PT2HFsEo1?=
 =?us-ascii?Q?UiaUrPe6CUmQT8NC/DoOXYoaWIk5e5PR/HKKQ80t1KLVLrOUoe3ckRHSmgyy?=
 =?us-ascii?Q?+rmQjTRujs0ZNzN7njqwiIknJjaQJQJjBhkG9NBre/RzggHlOKQlIcNPG/+i?=
 =?us-ascii?Q?+cBxg4OWT9FIAZw7Sfc3ybrqhfku0DhISehk9wG59+fSE/GBEtUZkpvB6ofj?=
 =?us-ascii?Q?XT5n7TW7S3DVfeb0sf/8t+1OjA0bzbQXqAKrNAPm5948QZytjnzfFEcnQbis?=
 =?us-ascii?Q?ldFlkg+4RNWt0puX66iRd7c/xALN7T1Jt2smAWbZbDHmv4JM7svBLrUT8dsH?=
 =?us-ascii?Q?YirVGD05kIPK6+McPByre2vhqMXqgKjrrONs92UKCGyfEKS7qMinwjDLHYNp?=
 =?us-ascii?Q?JUAGR2t4dyOVEunoYe/mrwMr6fpnQnmyI6UsnDUF/JRVEBOSBUzU11tky64Y?=
 =?us-ascii?Q?zIRergG2LCuIIb+A60aknybLf3yztRjXEnFr8lDpeSBM19wNYzf/UtEVvRmp?=
 =?us-ascii?Q?RjNl7bI/byl4RcaLthfbBhgrGsaSZ1P2ARGf+C69KUIZMvqctJ1IGbXUKkcb?=
 =?us-ascii?Q?YJsaSbiMUWSkcf/qBJQ6eg7dUZ6KwVtQh1cyEuVvZmzgek7O5z/BRswqtzDE?=
 =?us-ascii?Q?K9zv/EoqcRgZ8W73fK1z4X8zfE/aSlCErkZkC/7lZlYDqs/qGAe9W3e/25rt?=
 =?us-ascii?Q?+zWP9yr2XPMApIM2iMvUkohT1CHvtQMnDDJtws9zvJ+gqrbDMP60tyQmETlN?=
 =?us-ascii?Q?P4W1Krgaz9JvNQ+F9vSRJp5AGftnPdXxeqjYjfqrZzmZBNRisvq70zyOrHyi?=
 =?us-ascii?Q?FKOTdGoBqsjLEdKUcr3GfipHnsqFk6NlawFTBpQQgwfJha00lPm7D3aqp2N8?=
 =?us-ascii?Q?RJlqM8nMStjg3KPKw38gvYyNpAofoEDdhdIfQn9vXTKs3hc1W3kxBFmw8eXh?=
 =?us-ascii?Q?YBkepnyaV2cdUlj+LV6wmcrKtQ7BsaQoMqrQOYBUuC3+cUhiCR2cZdI2sCIk?=
 =?us-ascii?Q?0/0Y4+/IfvyD4YczINw9XAjz8/Ya9qo68jjvI7h2hGwhHiorLRiu0awQDBUT?=
 =?us-ascii?Q?rDeMfM9TdA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018e214c-a5ff-48f7-52e7-08deb80dc9ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:24:09.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P87ZNCVN08KvjdYUx2gTZ9Sk3PHyOiirXi9zaVTx66ifps4zfV4PQTGCbpytBA6WQyQVXzJpDh3uVmUmrYb5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

The per-CPU clear in __note_gp_changes() (from an earlier commit)
runs only when the local CPU notices a normal-GP advance.  When an
expedited GP arrives at a CPU whose defer_qs_pending is already
PENDING, rcu_read_unlock_special() may skip irq_work queuing due to the
pending gate.

Clear defer_qs_pending on the IPI target right in rcu_exp_handler().
This makes it possible for any arming attempt that follows
the IPI within the current GP to be able to queue irq_work again,
allowing completion expedited GPs quickly than waiting for one scheduler
tick.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_exp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..f8564a041879 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -763,6 +763,12 @@ static void rcu_exp_handler(void *unused)
 			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
 		return;
 
+	/*
+	 * Clear defer_qs_pending so arming attempts following this IPI
+	 * within the current GP can queue irq_work again.
+	 */
+	rcu_defer_qs_clear(rdp);
+
 	/*
 	 * Second, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
-- 
2.34.1

