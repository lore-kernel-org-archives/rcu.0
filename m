Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1F21D3DC;
	Fri, 18 Apr 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992969; cv=fail; b=mnI9dw1YQBo3j08A+jWaJWg563o3c782kjojcYesPqoGWJK6bIP5DOpHcR8KidhynA8AcfVw6eXyd0bYEKCC8ZX6SxoEhkjUZQ850oPQKtkYIqUPwUe0tyfLfnacckpznJUVk1JeKTDIZz7LJiTPC/TKqEzjWjm7f8NZg95nQOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992969; c=relaxed/simple;
	bh=4xavpvhuHomNqz2Or0/ITP+oZuc/VwsxKRYATaaZkwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJ2CTm2B765HkKPuP/P1ZtzQWGIzuVD6tHx5MN7iDBHFed6s9/KGYRaZA/bYaOpOXGK1vpSGBEvOsSI3DxO4DYH7KnHWZE80+wJy8C/QcBimwl31GYsP8rOE4XIQOetmOmd5KXzSbUuUGXXMe28PtCYuh4MiTeFx/QX10+1Htek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQUORBgv; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQUORBgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5XJRDRu86j2LQThBYOWydtdFK+7+V1LAakmlyWFHr24nwsV4ffQqLhQknoph4YcwUk6qSRxy2O4iDWOF4pCoqpG+Xc1OdLQteZuEA480SdEA7EO+JoPlvqgSM7Aoilifz7HqcDMDxMlz+FJUnNkOOdxbtNr9gjm8Xim0KV76Z5pI1+bnfldrwo3savt/2PPBHuWczdLyipf/WaesPeSwFr+mKaZBGZujsVm75WBrlcEQ/eBJGp+yjaPzncAftrkTLTk5wKtZ9jtbY3c9SlfGIJcxB7QANek4V0T5NEiajuor0eoz4Eavc2uPeqOA/n00Az3r2REQMNvokqcAH8Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmiszcyLIH+b1kyyuDzLJVVgcK4hKhFCRLQ9Zc+o9iU=;
 b=F41GcDu6k2d6i9Hv+LI4ViKCCozUZ0cksSjdYLwJAECTfb2hGEe+ge42M5jvsRAMeNYeiiUt/yy9r8PdZOuwhEvk88OohRhIm2+JiPjnp4M3LNgNeLWNjo85z9k00xj6K+c62g5L5/+z15PtBoDe8NpA4smTebubzX2X6v6/e0Mp2zg8a4hFA5Cf2AcauiLM10i1PQC0Y4ziH87VHQ2g/u5xYCOuld30xS6j2BzoPgEO4chNlKwqIuRlBKGRAudepDu6uH2z4UkW+TgcEokyP2UoizZObKZDqQkVlsaYXL6lRuq3BaVBiGeF/bgo805CmMMMNWwOI3bGwnsRAUR8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmiszcyLIH+b1kyyuDzLJVVgcK4hKhFCRLQ9Zc+o9iU=;
 b=mQUORBgvhvs8M4b27vyImFtTj9EWttTuk5znZ+pr88OQLvVgqXORVM+mu48AJQDVmigcI0qvRmWuTAc/NJFQdmD5yFGqKAUxWctNES9c+oddjonPF6QhZqwsZSr6o8rGdrewm6HdH8h55dOvMXAcnhmz+mRGpBJFq8wIRjvtyEQj52+wnVyzMMDXdUS6Ln+Wha6VMr1yqpcjEbftkZ3hnlNfq+8rAQFqq8WWVcTyxtlhVSFJFLASz455rlO0thbfq7Zf9w4tTkMINGpoRdbQhkQt5EwxrKHOszGaCjUgE7we4+tAohKjGhdun83/UQKdw2QIWc+g7Z2vw9z++qWFZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 16:16:05 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:16:05 +0000
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
	Wei Yang <richard.weiyang@gmail.com>,
	Alan Huang <mmpgouride@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH 7/7] doc/RCU/listRCU: refine example code for eliminating stale data
Date: Fri, 18 Apr 2025 12:15:40 -0400
Message-ID: <20250418161542.2429420-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161542.2429420-1-joelagnelf@nvidia.com>
References: <20250418161542.2429420-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:408:111::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: cec2a59d-dcf1-4e0a-e706-08dd7e9451fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1YPg4aMrH6RRPq46SWeSvCDzwIwfvccSfsdzfYLzQPiuc/kHKBd3nTcfrYTL?=
 =?us-ascii?Q?tEJpS4/MzFv3gz3cFn4HfIy3HTZ+7IO+cv1QM25LUm676l9KX+jclvHOBAkS?=
 =?us-ascii?Q?qtPqoHoETCDfCLtuYC7fHlkSn4J/ySaqk1L1hr3gvSuKtFfXM4qa2Ykj80IX?=
 =?us-ascii?Q?w8UWtUSOl2TNTUw8CLyeWL0mnaynAGFb4xZvXKfu+PU72QSzafeNkXwKKXXt?=
 =?us-ascii?Q?XEMXFsp6R3NIDNCaU+Ncm5TSsKkGsB7kAfTI0R9ONJM68Q4/McLVJx6XXwK1?=
 =?us-ascii?Q?vGfyX25RhixMXdsm5NVNWzee+mFidvdip1U+mBjFBenAJWLPnORXX85cKlKp?=
 =?us-ascii?Q?Db4CDNcoNNj9yx2Ax8RlqsZXk9Bfh7aNG3MY4G7t5BmCEJ8iPjL3s5yYNu3Q?=
 =?us-ascii?Q?5+g9AEN2/uctV2j4zDNe71JMsFPEtDXqaUQE9VKrZOvfaefn2gCpUPGmdiV5?=
 =?us-ascii?Q?N0r0F1Y2K68/8IuW0IbJCNPPDctAQFNh9c0uN7hOQSXEjBJRLqg22c3c5AX8?=
 =?us-ascii?Q?HGS4SGZPsitSmrC0DOaOGYrMvaMY63E5yn15zmviWADRlQyo5uDP9UOgW/K7?=
 =?us-ascii?Q?66xALXYwYm1SAssbom6GKsUv8pXAvLFTa7qaynm+7StjgaH7ZJKK61xKgwGZ?=
 =?us-ascii?Q?e7MU3H14NlQdQhGvnZai2nlo5tuhz2qSrkjQHwfkBZb1CUfZ9qsw9xJ7w9t0?=
 =?us-ascii?Q?nL+0pm5v5Xdy1etC8UNRG9aGPKRBl69qnUsVM6lzwg+qvbi6ub10Rm49VFEt?=
 =?us-ascii?Q?eWfGj6XushwsNG7ucrncXyn+d16FF/wLWzl/l1xutlvbQAMbIB6IqX8t7GHp?=
 =?us-ascii?Q?X/l3iBMVPLzqeiIx+gxKfy+DmQs5SUZkmOdzxEEAHQWer8WhqK6E/bbjX6o+?=
 =?us-ascii?Q?S0Bikyr6dChMlD93cTDh+Zne1ejg+RUCZcTch/gGHFvEaoXJ0BhNU8LdB91O?=
 =?us-ascii?Q?puFs55WZMEj4/p2WQVtOUo8dZXNzSxe7KqJGkWkxZWmgTsCvkNFL4a8LqXwz?=
 =?us-ascii?Q?p1O4zCfk/26X/SgzPS2N6B1gyL3P0ysyylzA3b4W5qxxkqvz3nssBha5w155?=
 =?us-ascii?Q?4EqizqWKIbHg3GdBIB4Z2XRZtIcZ6qTHJOA+Dp3FhllRh83z3VuclJQqQaHx?=
 =?us-ascii?Q?x3V3Aa60vpyJ+tKeViBE+S6jnrdOx+nsKYL5EUBFMz1PYxSPpJ4f2HAOEkR2?=
 =?us-ascii?Q?T3GYLRXxvlsxLDe4GVvJYcq8XQfxnAAuiuwZ97H0unenOJ/oKr7K9/hhm8mZ?=
 =?us-ascii?Q?U20yuFilX3KkiwDPHPKi+zlyOM3ioKsWKg1I/9CB8BxXQtpvXHAYuioPSYk/?=
 =?us-ascii?Q?lLcxqhMcibbrR62KnVygFkhXAXlhb18dFjylvSHcuuVAg55BSJyhZdoeZCUk?=
 =?us-ascii?Q?TAvZsfNXDvp1NG9/Zmr81bVpv+lKrW2Sd35kW23r6lV3dhqYEbiHeqGR6gsc?=
 =?us-ascii?Q?axDEbZktpf2TDCp/dAJIjmQXlkiPYiD43Pqh8zy5AwZFpy1IrF4pkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veumIt9XYwNBXLojLB5eNG72pvEVzC7cmezAi0JFjt8TmwsGR4jRP/2anzj6?=
 =?us-ascii?Q?J6JoXeld5ahspyYz9mQwl3vfrZGT0yx7P+zsg6LKk3DZshsNIXf8tNWP+V9r?=
 =?us-ascii?Q?J2UNnMsGIJo4QDuXNc/V0I+p1Xb0X53TjNAvYwP+MVPvjA//nkQCbmP3SSqr?=
 =?us-ascii?Q?IXhISpmbDYy2EjWxL4Np5UUp4vbKp8NLVuL5Crp8O2ked7o18yAfMgb8Usqx?=
 =?us-ascii?Q?0P+vzOVgIxCXfCe1WbUFEs8xw0plXxqM34bihNQ06HOGYAN4j3vdG9214Y+c?=
 =?us-ascii?Q?fT78RFtlvhvLPSlBqwAelBJ6n0VviPt6U8ew8VyR5f7yL1w7GD1xETn2bDM8?=
 =?us-ascii?Q?mdblrc3Rhuk24Em7WwfBSdOJqCIBYFNnXxR9L9uuWKFUQeBHZn+L1bpDZlQs?=
 =?us-ascii?Q?roQ7pusEdOlr+PR4RUOcoRTigpkHtVqzIJ/9z31wnBCz2KcXlvnyMCNgOBoC?=
 =?us-ascii?Q?drgXjAhy/27CE/ds+Bu4C7dPTKzJmmM6FDzvDuufuXEH0XDz1I1bjQ7kz37z?=
 =?us-ascii?Q?IY64FbtAqTAXJ3CixDKaYsB5i7nLJrTyj0b9R0lvbKh/6cyU1mZ1gi7xq4f+?=
 =?us-ascii?Q?4OwUWPIWuF6t2A1248XucTXqKGxETdNbwy7rm7+HlHygaW4yYWtUBrjdHV2+?=
 =?us-ascii?Q?pTG83xcj6tPid++jbupXwP6alSaCOyyninwmtRHPpggvxidKQ/yHvPa5MjSK?=
 =?us-ascii?Q?HoBkwZjZDB4x8kD7fj+C+sEf3kCkPobN+aLUT9C7cKENSZvJ6kjL1y3UYzv7?=
 =?us-ascii?Q?zIlMg0E4MPqF2shbjZ3bucVrq8qgMZXAF5Q6pRtA3a1pY18ttp2+BA4shOtY?=
 =?us-ascii?Q?6fl3h60DW6e7FMyWfAn/kcPeMI4QNqiZBGxbgwdyOogbDgHaUN88zM+b0Rlx?=
 =?us-ascii?Q?SuLzHmc/bQJ7tZOqDzcerN8sVIEot7AIODZeSwrrYyWCEXDFvefI/Hl5c+qY?=
 =?us-ascii?Q?XxvreEgA8oC4CoqlVVwDcEfrXqKxz46FcrwZt7z5r8bXT4PbWYbpinnEPRBg?=
 =?us-ascii?Q?COxx8j0cRwIrRbv85YzQciPigHPfDqLOK6irGtP/y9m2/Lb7WuAwqmCv+/db?=
 =?us-ascii?Q?XDm9eNbhBZ5MbiYQZkfBVZgya1iRpzccoyt4oB1htFhfo6YbUBvNF8ufUtaF?=
 =?us-ascii?Q?yK3KD4r9yaSeOvLgMuLBnAZUMeU/0kuFstOHsVq6YUwe/popmeEP4tLtxFAy?=
 =?us-ascii?Q?EdsTwYtEg7OmrYmzOdXBl8f7y+8ruTUkCHywsUeNUR/41BPNn0lOyhNTC56J?=
 =?us-ascii?Q?gRxXlOWhMJEeKYBq3Xb6R7ZhfD3j/O1Uvs9ZI+I24AnSav+gfW+RMsaRxbIK?=
 =?us-ascii?Q?wtDoyo6XuCustlp4MIFEdXbRvzD6w+SjO/+etrqPeFRA61etVbTw/YuuIcuI?=
 =?us-ascii?Q?9MhjvIQjuYrfsbeo31fw4jbjpwKpkq2bO7WL/remFO5MSFgWzKIN+Jc+4AoY?=
 =?us-ascii?Q?mVLmbNiN8TvDdF3t5jxRl+Wzi3iWKhWBr6LhbYFFF9Cerw0Uf2um4eNlaWG6?=
 =?us-ascii?Q?lDZHD0gWXht/eLCu6gQvi2MQocDRdXFeCw8X0uyuWSPd/EBLzlhQuSnNWb6w?=
 =?us-ascii?Q?xXHlu9BbgLisdPaCkcIU7rWHG4BxFMNdYG8i4X/R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec2a59d-dcf1-4e0a-e706-08dd7e9451fe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:16:05.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asUnHp9OOv1F4EQ5ctoRPsvF6PzfHgoDrNGwIQuTPR0g43rBspSSZOz7YtIeQrjyr16FHAzyYI4HKNYSoYVcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

From: Wei Yang <richard.weiyang@gmail.com>

This patch adjust the example code with following two purpose:

  * reduce the confusion on not releasing e->lock
  * emphasize e is valid and not stale with e->lock held

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Alan Huang <mmpgouride@gmail.com>
Reviewed-by: Alan Huang <mmpgouride@gmail.com>
Link: https://lore.kernel.org/r/20250218005047.27258-1-richard.weiyang@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/RCU/listRCU.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index ed5c9d8c9afe..d8bb98623c12 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
 to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
 ``audit_entry`` structure, and modify audit_filter_task() as follows::
 
-	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	static struct audit_entry *audit_filter_task(struct task_struct *tsk, char **key)
 	{
 		struct audit_entry *e;
 		enum audit_state   state;
@@ -346,16 +346,18 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
 				if (e->deleted) {
 					spin_unlock(&e->lock);
 					rcu_read_unlock();
-					return AUDIT_BUILD_CONTEXT;
+					return NULL;
 				}
 				rcu_read_unlock();
 				if (state == AUDIT_STATE_RECORD)
 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
-				return state;
+				/* As long as e->lock is held, e is valid and
+				 * its value is not stale */
+				return e;
 			}
 		}
 		rcu_read_unlock();
-		return AUDIT_BUILD_CONTEXT;
+		return NULL;
 	}
 
 The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
-- 
2.43.0

