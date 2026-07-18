Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AC331EDD;
	Sat, 18 Jul 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394951; cv=fail; b=ZrVfTCM8anBf3pLdIYGadKmUnkjObmdaD78hjGlJh8Hv5gc6xYZ6uhMjisRo5HzJD//QfA/+T4Zy8BMZj+euznRoKao3stdg/8HY8EElhNYWhiKEzIjMf41YB0d0x3zP+rJrRzdqk6j2DSUJroDhkLuc7bH59e7V0XFFSm9vNYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394951; c=relaxed/simple;
	bh=bdVN+9SCE+WKLTbQMY3xrVsnPeXF7kpGlue4ZLS8IYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvYKJkswmn9be9mY53KHF19sR7HF2iR9oNrjGuqfvCedWu0ppd8om+Rhj0bJ82kEGOtjFpfXWUAu3ui9JRXjQxl3PG4c6IlEJ3NDwqe54pae/KTCqPcfjspGzeNxakTXUz55Jlzb2l0Nk67fvgatSQubZOoiyFUBY/QRtQm+/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQLe7WDk; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQLe7WDk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyulq2JPRopySWkl2po2UxoSLL3x58n1V2GpORVrXZaID0DRE2C+qGdyARpCKmkkIwC2k9OOxMjIk55LTRf3umej/N40bxo9mnjqIgUfXuP5ICakr1yR+vkIpnFPLIN23zb4hF6nH10TeFfMqyMEN3Db9xBzrB9pji/gOOxmzbr6Zeq/KzGx2oMYJoczQyMCvkfjFnqfyn1OoVED89yqEI9IgYDWmHr/IgzfzneJwr5JXQxrf9z4jC1z0wzjJMt2msc0+nKUOiJHxOPSASOlo0w0fuNmM86DnCwkfCJX9WJdmjmZg9H1r6afRIQKFPRYXAd9TYLcCIUHV9a3nsj/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcLIXrmPKru1fxO4fA2mob+wBFLvuLJK5CJdRBNcNV4=;
 b=HQz9sVVi+E7KwWO1rwexB9Dt+93FSK4qRkXgFEz4ucOSGOn9peSdvSJc0YBimlcFoPO9vcMXNBxMb0tXguFT3HkZiB8fbkiV6bSRYL9XCjsdugA30jD1mv3jv4A6NOUAIirHhVw2yGCCwhXfwMWL/uWi9/CIhQvQNeJBHK7wnmpPzmaIXLfL00N6JlgJvcW+vTnxPxuxbNfQ09gcHabsUNQ0OzWUVtIDywNfXxBRPP4awGpJlQzj09HlmKwBBk6vo7c8EFSLYTE9iKRfMetTa8TURG6Myse8Nq/OTbwF5pWbTse8gPZpttBKTnn5X6cKK+7j4ibNQYbiVYFVAqCWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcLIXrmPKru1fxO4fA2mob+wBFLvuLJK5CJdRBNcNV4=;
 b=MQLe7WDkRsGzblBN/Bwm/EOJWZYkrXHq53+ugd0gs7Fzpb3II8bNx4MhLcY1iLGeANckU4LhfE27mtw2v3h5asJUPYWy48njq9qlZV0pVQKjCQc/TPa3lME/EN8BCdNGQGQQPuqNEDbmsHTQQB1+cmMCO3vKbo76BJgu2YFGcVvLbFRVD+vgzO8egDhR3PcUTmaBVYo3crqMErFIYjWD+3neTnTudNCXXjfZ7xfxnaBNJAIQWmk7ZIx9pgyYp5C9w30/dTynnrhKMdsWTFM2QhflCqIFwssCztMkmeWA3+kiIsbA5N5BDIE9ubKO95doSQZbZLNNAQhXN6HYPh08iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:15:46 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:15:46 +0000
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
Subject: [PATCH v1 1/6] rcu: Remove unused expedited_need_qs field from rcu_state
Date: Sat, 18 Jul 2026 13:15:32 -0400
Message-Id: <20260718171539.3781595-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718171539.3781595-1-joelagnelf@nvidia.com>
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e78f7f40-41a6-4461-de1c-08dee4f034d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	7EmVZWC+HjyYTJ19997od4K79lhDMXMbSEVQAHqyDrm9fiSFZFHPZShbgzZHzGDRsDwQdOS4znFgBZx6EdoGfaqRxV28ZJkOzxydr1mSXkA91vVV8pqVqGNthhdO2JYC3fjP67I38c+K14eVaW3MNNpZqJZgPMmQZ1xZyH32Veb7AhbA11xS7OJjLTJEWwgBklw/ALYU8NIxkqjPneEfnYM3VIog3BNzZ6AcQUdfwpNH0G2qT2h0Doi5eiNr0BLgDL1HPGk5QQYXtA8E2wyusi66s4jowYEkFC69dnleIMiko3mF1uF2V1LmsrIk6eYZfqnuHjKijNSQTG7l/gIU3GIzR79HEm5HS4HF9+UxiMj3d8MmiuW1UTGQqPAV0wqBNBonOkMR+nvt2dZT+al8F5tZJdhGJrySf9SofCoo+56LBIU9O7UrKWeHN856ScEvvPPTHj3Xk3W4U5f8teQXAnuc57ux0h4I7FKlb7jMGup5GSHsCPjjCm3RVF4cncuNPwZh1gmJnYMdPwPrAl2hvkr5zk3XC9EsEGPSgfGRbbOHY6WlXNlYkhhWUeC5yGLDjUdShYXwXbOaFbKXBtkrejnGF0NQFnfqicCSKebCMBWT8JFf5dV1oaJnUmTdHy8sz9c7vkiNJ7GKx0zHB2DwFVo6LAOdpHNWmuHLzenUvEZUKvTYgckaa9zx6SSG/tYWvzBALmipf+9+YvPv/bnMDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2G+i5acIGGiKS6Ar9dQRCCEU4OmiLUlURjCiwKDw6KtDpu8oq9c04jyX2Xt?=
 =?us-ascii?Q?zX+CDexkycFWZ+dxp7aG1I9EAT5qzWVP0NX8LLfaj29NKt2NwcBAV3R7uL5a?=
 =?us-ascii?Q?bXQgHodBJhBovN0SJY5Oakl5RSwKCAp1TpUv8OvdP8V2klUXF/dxmue/OZ0k?=
 =?us-ascii?Q?CqLoK/euW97/TTqeMlvTQpaJVOXDra8s4apoHIBoOLdQAatQm6H6KizkK6mF?=
 =?us-ascii?Q?wOUsqpG3xHKNS+qY1u/TnKiMjKfaOt8atIndJcH3HqzrkcVIlqhUyDWLOvwT?=
 =?us-ascii?Q?wfDV6i282Q68auadsMGPL77Cyt6n08xbr8O8XIij24PvqcUfkMFWscgNxD23?=
 =?us-ascii?Q?7GWcuEHqCzbhoULn0g3oq/A2B5B0HFAjxUsbGcMDJwOFVQ+rkuJHr/Yg9Be0?=
 =?us-ascii?Q?OT3gzH22630CbG4LbBvzyCQjWownsVesb4AordHIkZhVEsg5Sx1gVwZizZxM?=
 =?us-ascii?Q?4OBFCBfvfR20BOFd+t4MtdFbfIPi7nT+fMt1N8potP61dTXXPrmGuKBMeT8j?=
 =?us-ascii?Q?vIX/RkhOB+1ECK7+AZpbAReahamvE7Dr/J8G6e6H5iUIAjLTuUR50SPo7y1P?=
 =?us-ascii?Q?4JjHx5G54Kc8TPj3z3v0pHeV1c/vP06pEZGtv/WK/A+F1iNreeLebWa6u6UM?=
 =?us-ascii?Q?/gaoXkjB5azFHE6Mu3P6OVBDJ1YSqGbKvZSXHlIYKEEABwcQxFbSv1cFqpCa?=
 =?us-ascii?Q?GLJDFfPg1NjUlMBty7CYyOmeE8+nDafJ8UAQTvIwaeWF6hePeHpFt2MG9wZE?=
 =?us-ascii?Q?hAV0aOxDP6IIPynYKHeW2imLsxgo6pH/66kQ5elpUL4pFMYYeWAYx+pNzbbM?=
 =?us-ascii?Q?FvMFhfG/hRNW7N1LnPq5egvvNqCBLDsqWNXrEhI26s8JHWK0cZcKzyrZl0rr?=
 =?us-ascii?Q?9FCNOaLK+de6fZrPfoJpjV7G33UlQJ7dy3T6VpRjILEZFvOUvuK14CwLs8N3?=
 =?us-ascii?Q?C5foFnJJFmwL6OXsA9HFfKJ8/VZEWbGzXnOUe+rHPFiW4JUxB8IjRWnw3Ors?=
 =?us-ascii?Q?yKogWBuYoLFbNKFVu4KyUBi7EUlWYA/o8VOurVi4DF7IojcT6wJVgXdFIleo?=
 =?us-ascii?Q?C4Q7LdznnOB6HMeYp8/RVKtLqoPinE3x81I2fx8tySzRFzPdCGHWMLB8vCS/?=
 =?us-ascii?Q?8Y+6TeNT+sJWb+mipmIv65+DfU3Cv1EcxTg7xek+tBzewTH7Y6cV9i4OmBM9?=
 =?us-ascii?Q?wluw4AJLS/5qp0rrxSBOkJMSrS6rOpuztjuZMhUl9SzQ4WjEsq9unrDa3gHd?=
 =?us-ascii?Q?EXYNV926UAH9fFohypyYKI30zUl5dfqukPHR2I1mwurUB+q5maqWUwT4Md+g?=
 =?us-ascii?Q?tUGqOpiatlOn4vvZw71fC7+40qo6RPnueeKP+QOe4bJtSC8IRxtdoFfpfhnR?=
 =?us-ascii?Q?nFe0AXwXRyMjEQWIZkZvv+qfR4yco8j2FJL3PIZytwALGFRb3DLmaHSntmCw?=
 =?us-ascii?Q?1RVLtoDM/Dyy/qhASHvv2jkjXo/ooFsINnc9B6Au5tTTXpILufaYstu9729N?=
 =?us-ascii?Q?SSo0g4IeitfpMs48EFwxYgZFGngQpgbhRTDrvOjwqSXjlgcZUMXs2fFsgXQm?=
 =?us-ascii?Q?eLyq2lzdHul0HbYu1TzhNCYWlHb9KK0dal/BvIcWDVhmRkVJTuhFBpAbEobx?=
 =?us-ascii?Q?0Y10GtQme5sT9blfVxRMlRgMe12kowAnuCm+f9beNBS4MOiHE3Hf1knu7tvH?=
 =?us-ascii?Q?i9m+4CtGq89CMt+BqPQgiW3UkkoK73aoghG4FzaA2NIIcKe0tSLtqURJjJA1?=
 =?us-ascii?Q?QKdj3+rtZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78f7f40-41a6-4461-de1c-08dee4f034d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:15:46.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjFKDBxzFLfJEdSAY46gYAgqqef6SKLDkJ0JI7LN+nO/su4Y3gG8bQ+qxKNK0UDCl2GlkPiIF5n98UbZY8zm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

The ->expedited_need_qs counter was part of the old expedited
grace-period machinery that spun waiting for each CPU to check in.
The current implementation instead tracks holdout CPUs via the
rcu_node structures' ->expmask fields and waits on the ->exp_wq[]
wait queues, so nothing reads or writes ->expedited_need_qs any
longer.

Remove the field to avoid wasting space in rcu_state and to keep
readers of the expedited code from searching for nonexistent users.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb1..beb86e39909a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,7 +386,6 @@ struct rcu_state {
 	struct mutex exp_mutex;			/* Serialize expedited GP. */
 	struct mutex exp_wake_mutex;		/* Serialize wakeup. */
 	unsigned long expedited_sequence;	/* Take a ticket. */
-	atomic_t expedited_need_qs;		/* # CPUs left to check in. */
 	struct swait_queue_head expedited_wq;	/* Wait for check-ins. */
 	int ncpus_snap;				/* # CPUs seen last time. */
 	u8 cbovld;				/* Callback overload now? */
-- 
2.34.1

