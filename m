Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182574;
	b=A7XSbbr0IKi04UntMHoNB3EZXpYVnrow6AYpaemJpUGC+xlhdcBF1rUJQLrHaUXNvL6l
	 m6jIKjGDyfM3X2mOWiYRe/0ibmmA0gaR5WG650mJt63miLUPxVtkYz45gAltR1aj6U8nL
	 aSOYTq4AhNm1/B18rL8r7FfvsnFPZNpPwXCCCMVaREo5DA2ZWvwGx+Rfe6zRFa1/QgGLZ
	 +GTuE89bN0zSYo6QUm83x5pjxr8LxtTdMpezlouZzlegZS7YT1cxUS28KQmDINRABuDYm
	 qvgXizGfRfieWXneM3C+UyR7rcbUsYDUzqyDWF0e1wPIDpOSjKJbuzLyzBW5jLFZzRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182574;
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
	bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
	b=G94obaHG6RLK6D1exx/wUsK5qG7zJQAPlXztR0tqPYcUPk3AAT0PRUQ0qo24dutj49UC
	 Nz3M4htDgXM1qisTU0PsOWGBhPTB7Sdho/E71VzlwQemPJsBo5mkCEWy5F87UnNDJ2OuR
	 pm2OlOyKSTnTCBDBPmmgBJGMfTvW5ll7z6gAi4c6iT4BR/hS+4M15bzScFsOViW7w6Uda
	 52cO+AKCOuIOmu7LHYhw+6jCYWooHX89HT7O+eO2+z3oG7TBRWjUts++Ub9F2N1RoDOlu
	 xtSe5qR0qojez9eCK6pB8lb1LkMIOnJ36ty4D2kZeK9TVRgiFG5XiWVaaRB2EAAVatg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n2PzPnFM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.20
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AC606A322;
	Mon,  9 Nov 2026 00:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71AC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n2PzPnFM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuTzyYtPu4H7em5UE3QEyPPR6iQVLm4wGJklALc/rYwFcA9vR4hsgpX585jZfXQuECDanrGmAYGWQb6jMp0N/bZoCPzPUK6r1l4axgHDtTWCnqi4YEzgxEGcJFxlWmyH3wr2XYhFjlPKAX7Bp1nPDoFkd5nJYfvGAMj5auDPtpY2rdopN6cXySug1DsqEfjliicIbGFugH0eXCnUFZMqucKgd0Y+nOd/Z4Y0w0VSRAPmoPn/aMips4LohzxIo/Z22VRtljEOVOjIA0ZAenCakSB3OTU110iMWrMKS+dItFaP6lqV0If4EqfRR0RO7tMPXhNk/wPvD/b6VNx03ql7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=lYOytGgnIKvpyhX+rEV8FJfuw3fHjKa2h+d5eHer+/Q9j9sXAgbje6r89wcIyhKuI92MFA8hOrNHT8epBsZ64wiJeDMcRFjC7gYHnJ2rKJDz/HKV+MOpA/KKPoRyVoRYu6T3Z/KpdpSuABMw76w5ZOkwYpQCIuDiWHcWzCAkp6Np2GLMMhq0ijjs2TEUtVFS2xNvbzyoRr/RWaLMBe1d5vrQ/E99S4//0BYGmd4GvkhyUJHLOs0nilRJLVW75bpKReKnsP2iFgreJGLzpkDzFQBFZq/Y5y6ygtZWWUmHWOJe2W6GVuf7HzT/XsBwMUR5cd8AeKBTtI3AyJXtsObUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPW24ng8UI3RbdNi64b/B9P9J/O1MRC1nFw7CjGwRx8=;
 b=n2PzPnFMZNtPqf51L8oRatEcNEuc9k1ZWJc2XODCjr8YqL4sznLBz0GOYtEnqBo7nVnQcaAj/3/3vLuhlH8v2GavAzD15aJeIpq1uRWB5n2NlYdOokruQI9szdtlGHib/fW7fpYj99vYj+LbU3JcJVVjZEyAaXGLUuXUgf+UDyrXVdyxb1oOeUTbxtyf5WJxKf2POgEoTQVkfN+R0O+v49EkPMZQbT+u0gU0LnL407Zq83ve9SB6+BBl2nbHzX+bTzkTh7hx92SnVPmbgSyVtdjgeTviFNnqFTlBuoCNB85SmZMK6FTH5WQjkMpDn0xzrqW02KbGxSMRV14+2goHpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:48 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:48 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
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
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 1/5] rcu-tasks: Track barrier callbacks in debugobjects
Date: Sun,  8 Nov 2026 19:02:37 -0500
Message-ID: <20261109000243.3936824-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109000243.3936824-1-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::23) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 446b8462-25fd-44cf-afd5-08df3df4ca17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|11063799006|5023799004|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	X8gq+hLvWZl9IcTnc3eiCU4emsSkciX+DAQ3sOJY8JTYKP/CzNDSmHOL+iPwg6T99Iyyy35rds9ua6meICwcoXmyhSKJVUAYjrosVi/ehuLVZ6z7+kL3dUkE/zCAPouK0mfH1qgvigkXb8xrei19BtKHaUw8/kYNOjv1jAK2VMgI2XgwG+xKsoUtwkj+GMIOWHDFyYIuBRt3wyZfYlfKKk2VMfqte9NPMsBjkix6DcPQceQch0IZqZsmKpw4HbxyI8v9HzjiM8mXSts6RBEYBKn33jbLCOjujUwJdr4srk4ELMM62HwB2jOhEiAyZKexosMzd24PeuXVvp/ErBA2Bxcv1869zrUjkuPxbz4Qjqyox7wuCmGi4VqQclNQRgEuvqOycbdQlvxdUAMhIOwfWcZL+E+hwYwCwgUndMRajwchA5Bi1c8ThKTXXuegWaacRH6W9yT0ynj3Bx1lzrPagtdonf+bAXh2bYZnMQdlLUZPyvVry1ZY5dBj/5sW65b27b2QkhwP9gGz33vCOgT+g1TsFsO2R2DFOL/iyuM7LIkXOm3PMWGldvOGSvhhNZeuz7nfxgK4x0QEDg/AsoqVPUp/7SVgaklLiBWVPCcvM/tsSs6p8++uxCx+nDf3GFadLmu/x1QbLCZa0DIIBVF4lyz7bVng5gjfCFDGedQHJ2jNCUCwty146ZfU1VMZgxkK8KkHb3DOK8HIJA1Ipe9hPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(11063799006)(5023799004)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ma5XPF6adFyLrWgYZy+xOH/ZUBym0hiquUGLiBZ8zSzcCjMEzpXFpqggpKN0?=
 =?us-ascii?Q?pu29+CdaWyyzQlYgXkOZnxn5TZy+7iGYqyRbxShlZSR0XRoBLOkyvpA52rX+?=
 =?us-ascii?Q?fmQAKWQFpFKSQFggbJ+pKAMlq5A2+xZ7OzJDIg3Havj+5uIohE88i5pWgr3m?=
 =?us-ascii?Q?/vzIUSIyUAgoHprom44oTcOaepIX/X6z9E6DrinTyF4J+PUQGn1fL+raHhuT?=
 =?us-ascii?Q?LVTqRbH+HJps5mw9xT3sZnpe8eQcWSuNEe7mbMrhfDl53u4AzSheVzgDFu44?=
 =?us-ascii?Q?APdGuEEjdNMFVtwU5hvNg8QkQpnWI1oUQ+cb9YN7CqAEk7DqBgc1Xj2L0gUc?=
 =?us-ascii?Q?4VfUepJOKnZOX9YDKfVC+UhyHYx7iS6nI2m2v/I+MyLUh4x4smYUjuldKqPl?=
 =?us-ascii?Q?TlZRLNf4McuexO6xv8K/T0BMp7enNfvgWs0cZHTuZtc56ORcnLp9fk7IPVcn?=
 =?us-ascii?Q?AB3S7QW7e73GS8VfSZje0JniHxCInNsjIV7fdKUy10zOKP7TfG3DLebdF3+U?=
 =?us-ascii?Q?+XWTvdE3m712k4iu3uEsaFMwKhf/AHccKUXea8XfIc3w4VpVK9WIh6UI7i2/?=
 =?us-ascii?Q?jpDgMIUhzQtWKredyjI3ogk8lfisLLRSrHx3x9jXP6Uq4IXdwT8Es5hg9v6E?=
 =?us-ascii?Q?wzvbZ96MlamvlxNtSWcHm8/ifdNnNmvkLNcNdIhBcA8FK6bVwABB0pEsKBeW?=
 =?us-ascii?Q?iF+FWZGCVsl4KaF0ARWG+a2cn7XMcZRPe81odacJtxnR9mVLqbhu/isAfrVy?=
 =?us-ascii?Q?XsmGsC1VgvOf97p0EDgc/+GSh9Qv9dMO8mO6SXI2aKd2L/AwEP9CaOPXTdwT?=
 =?us-ascii?Q?dDI0Y+8NHMTxZeygT91tNgxGoo7kKUT1dCMhGxTJDei+qM/tnId5buENxIyI?=
 =?us-ascii?Q?TEDXB/tIa5oIZOZYWIJnjrWGFL3kp0sgBuOBBUJtr9vLiv59+CinICnQJnIb?=
 =?us-ascii?Q?xgTIpsYdALBUk0PamJYv6vhD5D6SWeUD8lmaZB+Nr7vstr9yswalNwtkFrFC?=
 =?us-ascii?Q?agwlrNBAV9Uw3Kf+tj7qbtwrk3usUGkpJ5bs1/YjYLokaz+qcA3Fc9J9LGcP?=
 =?us-ascii?Q?q+/CbM4jtucqjYWlwsh0uK9ot1PQQEHOqvJE/W+HEszB4SZnVOvd8CSoztQ+?=
 =?us-ascii?Q?XpvozdvEYeS5wL11STpzINqwCgH7xCHz7OE3IGGgtMfrQCbrIOPsyL5nlGyq?=
 =?us-ascii?Q?LPwZ4oL8vGk9ql0s4yxs6w9hbTpcfDnXvPqthcrZUsx9TBA1o1tf8f4GCVYi?=
 =?us-ascii?Q?Y4C+H9TGQYcn1fGRe0aTNI05ujr7mZ5Gq1PnsgQF+fVUZO5GXJe7vSlhlsWK?=
 =?us-ascii?Q?7Ht15mTk/KIY/w0eXiXuFf4L9HgqEdbM8vwclRem/CzlrEHdy5u4pQuUKoIA?=
 =?us-ascii?Q?sQTc+gFnPKL6IdnCM8Hit2kQ4Nb8OD/uSLicuC7W67a+xgBGGc/6HF77OTRv?=
 =?us-ascii?Q?GngOkjmMYS7vJOG9ku7gOW6mHo9RAhWTh/dCclqUCRs8lmzfa9yijb7sgSci?=
 =?us-ascii?Q?jXJhhX7NTRDlKKn89tHAKA0DxMTAFrfQfbtjG4JZwgouMwrC0G41E6PVmCI+?=
 =?us-ascii?Q?MAKhu0b8xjkaT/ZS3BEKqqP0uPwLjwR4Qem0FFvMMLdHY/HarE3VUM3uSeAm?=
 =?us-ascii?Q?8EdYScAc7IhWTe5Mh3o3/tvgYbyrp7fsNH/2Jj8al89njkB8DVzSSv987p14?=
 =?us-ascii?Q?yWVl0b7QVIZVVsvTINQwzQtLYx95bdCn7tqz3uac7rttVxlL5HPaGG9B8iXq?=
 =?us-ascii?Q?pBk7q7R56A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446b8462-25fd-44cf-afd5-08df3df4ca17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:48.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkiaPs2b9y5XdqhGWwLsaxy8wlwfs6ipZeGsFza/Lr179OSgjSLwqGGsGtK9EbfUDaTkU5wq2L7TmAruN5eOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

rcu_tasks_invoke_cbs() now unqueues each callback from debugobjects.
However, rcu_barrier_tasks_generic() inserts its per-CPU barrier heads
directly with rcu_segcblist_entrain(), bypassing the queue hook in
call_rcu_tasks_generic(). This produces active_state and deactivate
warnings for untracked objects when a barrier callback runs.

Activate each barrier head before entrainment and undo that activation
when there are no callbacks to entrain behind. Successful entrainment
is balanced by the invocation path, as for ordinary callbacks.

The existing n_barrier_cbs=2 torture test reproduces the warnings before
this change and completes without them afterwards.

This fixes patch "rcu-tasks: Detect duplicate callback enqueue".

Cc: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d060a5c4b6..a20db323612b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -470,9 +470,12 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
+		debug_rcu_head_queue(&rtpcp->barrier_q_head);
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
 			atomic_inc(&rtp->barrier_q_count);
+		else
+			debug_rcu_head_unqueue(&rtpcp->barrier_q_head);
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
 	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
-- 
2.54.0

