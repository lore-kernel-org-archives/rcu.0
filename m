Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182581;
	b=BuueSUrkBRJsQzvBCbV/vPNZQWKIVjkyG0cRnpq1mw9Dpuju9CkszaEESEsb6CeLaeES
	 qJJb0vFlhBvM4wsi5Ns95j/BdqGTmnUYT9rqEdCUYxuNDbcTQEiaXXHzdAwlBeoSL2x2e
	 L/lh+OjP38ftVU7nIOxl28gYVKDxMB4OM/DCbFLnmG4pKBWdilQTOi43XvfEoQ7LB6vdP
	 P3yvITx/5EPLBnGXkC1BvRpq4tSw6ylUexDPlV8vCcWz1Bz4fqD5DUvFacvDHFyHVLUeA
	 x/CN5NHXBciIit/Cv33Qv0Y4PxP/Igw4JxdCoCdnFK5TO0RbhcRh1ORZboc2pgiSQwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182581;
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
	bh=IpWZS9cPNLpCpEb8Lx2dVgIBiAiU2xuD/6ks6S4rHHg=;
	b=dYgs1yaJqiEicEvppvnjpSmqK+siHTcHmhSA4WOhE9Lv2iFQYarNkYUa+Qs2DJy8htek
	 cCmFeOCzsUEMkHZtVVCghSr9/SsJDinTfSmluS8gKpLntZzXpfKCiD4zAnDpJyxO8L7pk
	 PVQ13gTxHQu87m35gZnxm5hvQPVnn13T8MLUmGZwpGkc4UmWb/DripMEpR08rRj07a+Y0
	 Yau1VURetL8ZoSeINzXJbZUhCZVV6825BlY+IIGICTIpKb+eS2HpB6lIjWI0z2D2x0RLR
	 06NtcGXb0KV/kigr1dgPv4iH9I0ySfy6RJoeoBBHuSSKcut3GLSbyis17ZQdwKzLW9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fBPiL6bY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.13
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC5606D827;
	Mon,  9 Nov 2026 00:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EC5606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fBPiL6bY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdXV0yTEJ4raZ6lFTV1uGD4AVeAkn9V0kdR9+UjOBLnJ6OnrXp7zu36e4OltoQVO8EWHoS8cq2yAWzD+z+NrCFhMOZUlCSeG82M7/Ud/iiegIDWAR5ga+XVuYaMIcMgnvyq8IXQyEhL07fp6pc8TFk5Pctrog1cH2T0Erh6J2WJQFw3lF7encwwCvl6keFNedkzaJv77zyAClaElfuqjVO6NtZRM3I9XHjiitBrZAdWGUz1SMwWxUaIs9bVq+upqGXVhlCdp8YJPW7i4hgxsN8yagsFtoUApXAU8MRosTGpHK9Y1vK1DvQSU5UJ/cgCDKbmIpU0hOszNGJH7tJAFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpWZS9cPNLpCpEb8Lx2dVgIBiAiU2xuD/6ks6S4rHHg=;
 b=AMhMC7AU1Kf55KLXm67YWZ6Sj06LipaaUMCcd2QldCOuh88MnUA36eYeZU1a1Pesszg470j8E7vEIWXYYvwLjfAomk0E/TJQcvXTKf6m1AXoVvB7EmgY6QBMjxW6gUMrQLrN96I+cTzNDI6Nxi3eCglnI8WPiwbWUeh4Ss8lY1dElYXh6KdMJ0rFlBwbUwSIRtM/3hO+n8GWwxhV5TQHMZCDVGsXyhNT9sPqpGnb+xu6lh60l+Fj8+xCZfQiqYDkZjjhOJ7WMzZZzN7hIMG13lqpCJckaJbl4pBCGZ0XkxYOcukoWGYQEtqM1oCEEL6n134k2AYuYWExNzjWJC7A3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpWZS9cPNLpCpEb8Lx2dVgIBiAiU2xuD/6ks6S4rHHg=;
 b=fBPiL6bYUbQRMvIJ49/ttS7EaatWncF8rVjmKcCxUvJcvheDz5qhidzBW3hmj2ZmkfVTYOuigUdN8K0VdIyuoqBDOIqx+YEXZiyW3W/KKnBdVQSr/O8om3UauNDQ3W+yN97bhnoX5gcWHpIq+rUB0KkV1uBZBntOloZloO59ck0yGa7JQujamNYs2jqH+wq4d+6Si6HX++DN4Xpjkk4hivPbdd1JoA3arcfPr9giV0uNocBGWxwTU2lkfTuqmyZvinALyj0/nYkAFBI5nm8gXKXL7zOkZJh9uMMAVG/UHgjnaDFdFk8JXPFiJYogGRtQDOQqEB4Zb36qU2kwD4CMTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:56 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:55 +0000
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
	Zqiang <qiang.zhang@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v2 4/5] kasan: Avoid an unrelated RCU warning in the callback test
Date: Sun,  8 Nov 2026 19:02:40 -0500
Message-ID: <20261109000243.3936824-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109000243.3936824-1-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|DSVPR12MB664020:EE_
X-MS-Office365-Filtering-Correlation-Id: bb953252-2f2e-4052-d3de-08df3df4ce48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|10067099003|921020|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QzXe9ccafNydvW2KHAhjctAgl5YhW6RE8F7T+1HBSX2x13BEB4z4Dw3c0+OtnPo5rIOU1NmKNkX3Qx7r7r4Uyu/DznS0/sLwveGzyevnrvUVCYXhcL3lq2R7mVOAQ6jr27VKc/A6Yhufp3lKRhtFV3ZT20PJowf6GUn0xdfBYZO0J2MkxQYkVYKQFBAG7ysUg6lY/ktSrB7GTzA5IoKIYX2VYZ1AX1GZpGwc5YjmZBZeX71aIP0DVJHoPIdUbVZuPe6dC6w6+klHIpw9edWenWUt2IWDX5/DDouxtPDobW2RWDqJ8SBk7RA8YRv1xCl3nkAfd8dh2ef/P/+SfDNH/sPQF5sk2v576PtI25MqT0myQEwzHo25z2Wp5YV1ppF4bnEcvA2CMsP9kadVDfXbcfEHMtLvgg55RimTvi+kj3M2pyKWEdkZIg/hF5T1zRSdy1LCbYsgYgc/QsugjV2UWZyH+tvJ1KNbZJL6Xf8NIwtcYkpUcIQI2QVjq+KndgBxZNgPwqILJXE1SlmDcxlOkS17YDUwh8RIB8W47pVE5Lw9DRtEPD49WahOlo3mzAcfNBMGvLj5fvMw9P8emyvuaROljvIoXTKqfXtqVFhR53DA+S3n+WhAwvKcC32Q0m9msLR3ra0TdhMMfElBJpte+FJ8BuTniwmq8P+HnaK64TPBaYcUAFUEvt0oCOcwcjyXr/47qibGHAvi0tc6xxT/BA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009221227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZaFsXwaDLjyUxjrz83t/8s/k73zw+9InhYCifMfHlmRtc7qWcFyErPMKCVW?=
 =?us-ascii?Q?YbBN8qH6E0yXxCX8M7GXYNM/1fpji58V4NXkS0EAZvhibpPx9a5d0SezJMxl?=
 =?us-ascii?Q?r4+ZqSwv9Vr3BHV8wd3ieBb456i/zqf/lKPK9hNU6WN/oHq0Uf62eHCe7qmQ?=
 =?us-ascii?Q?JB2dbQprMazrjmRkAXuAZldABWcMNl3413IjGgQ362GAfHMXV9oHQnKOAxFe?=
 =?us-ascii?Q?p7f9HWmKGX2ch9ldoY3TWs+3T/CMCvZLlHvL1ic+UJCmpXRlC0cSY6/mwqk+?=
 =?us-ascii?Q?50z9hKKWbYsW1fs9mmawa9Mh2H2sD/mi3vfaCzCTnBETlAZEnJlthX/EfVsA?=
 =?us-ascii?Q?CiG4wSWjbVlqVBUadkUJHqwZ68SLHLgD5TcPbwySJIhVhRv2VUC1MEKdPJDF?=
 =?us-ascii?Q?MEDAUEH54G2piWLdUR3eEZ7j4alubQbuTGS7GbZBMDJTDN3MX48sGtJEwyPR?=
 =?us-ascii?Q?XKCoqqkNsIEr/vpBBLM0mWV9unUTCCVU9bII37anUPcT4HFVNPqixqaTj6Q3?=
 =?us-ascii?Q?ZtkUvsgoIymUA27kfw8a2riH4wN5ZOLvfzeYskEHo4MBiVy/6ZTnDDnf4x76?=
 =?us-ascii?Q?pw/5GWfxe5W1ISo1uXyC31oKOl8xJb5iyBYqo5NdHc0fqsgZMuHY4mXPG3mq?=
 =?us-ascii?Q?SFm3he4nh6DN217vmWckDIzuOji+HEj+TChXaxc6djYAmoSEsNYjtgzH8ckP?=
 =?us-ascii?Q?08psRJWtYrJPHjgeHG/tl7E3n6qvKxPnbyOqypmTw3gar22I0m6V1nQ19ETb?=
 =?us-ascii?Q?RMXVFFks8AZ0HTO/r054MMBOpl7hWwoHnwnP9t8A3AOXFk7CBtuAhbsQJCqK?=
 =?us-ascii?Q?oUCxh97d7Jyt9uakOdBJzktraYjQIYfiEMU0sSLGH2TgMwMSrqj24yEWmJgH?=
 =?us-ascii?Q?DRcc4Tg47l3hQU4vXb1AlIKjGZ2FC7V99RuTTCapFUv1SeCr7HQJId3EDaUK?=
 =?us-ascii?Q?LpG1SR9F3lg5FJqoabUXQu4Sfde7tuxBDVgP+Kng3bKBnZN80OBAYBToAji/?=
 =?us-ascii?Q?fGvTB0zXVgpyVXtQP4yvqnlz7lKfazn9rlmrJf5e20KCPIExLWHAsnLnHnyK?=
 =?us-ascii?Q?c1OH05pk8LkYYie4DDsB4BUfEaE0jVT+lJcrgPCh/HQ790L8u5QYbI7fUYTE?=
 =?us-ascii?Q?yy943DPZ9bQdIPm8PWcRwpN4uigCEeXcjN5EDRgQa8ANr9Qy3Crwh9qwwmpp?=
 =?us-ascii?Q?HhRGhpBr3rekxjcNeFB8aXIxSJp4S2SgFfLzEGhwvSyOHO6karDGXOpkjiU6?=
 =?us-ascii?Q?vGoWeKTDeDQV0e++vdbxD8e1tC8WoOHu36RDgimaphoZybIjyowED1P6EQtI?=
 =?us-ascii?Q?DfqMaadaDODpNqjRgstMEBBpUh3+lA946jNXSj3fnZKFeKfC+4oTRUkgyP+t?=
 =?us-ascii?Q?hJehPesjxG5J8ONMYT5MOJGAi1jzL23nUyUwJZs2U0+VtBlf2+ST+YAbLHIO?=
 =?us-ascii?Q?DJcSB9RmAl89RrNXqkRRD57USHxExam7RXSPk1Sbvz4y8LOH3tda1zoKo2ui?=
 =?us-ascii?Q?Bpl/oIxpQCPha6ohFu6p7s1CBBzj01aYjVq/DaS9ZdBgiqAqWGPngUmsO9ph?=
 =?us-ascii?Q?0MQQbkEgIdIHYIVex44QOzIXc+r5qAdSmkNkMuorTtxQ1joh0MkSIa8cFG0R?=
 =?us-ascii?Q?r/u6ez2MoArCvQC6vgQ0tvazTX9dwO5wrBZ0LxFvNLd1kHZ4xS07YEPuyEvP?=
 =?us-ascii?Q?+fWp5iRTjKpT5vYgGQdyLGCFoUY2L3pVv/PvAuZ3pZYbzFr+oGpz2JWr0yoj?=
 =?us-ascii?Q?LOOjoH1mBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb953252-2f2e-4052-d3de-08df3df4ce48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:55.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+Lky/AvzQfdUcFeF3Hgz2Pl7ByD0ZEVoLDuJjQTkdwvb6ImQ9pUaejzB0MoGzReWF2ZRnZ0b99XzeWVFGwu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB664020

rcu_uaf() passes a false protection condition to
rcu_dereference_protected(), which produces a suspicious-RCU-usage
warning before the intended KASAN failure occurs.

The pointer refers to a fresh allocation that has not been published to
readers. State that protection condition explicitly, leaving the intended
tests intact.

Test:
Built with CONFIG_KASAN_KUNIT_TEST=m
Booted Qemu guest (8 CPUs), ran modprobe kasan_test filtered to kasan.*rcu_uaf*

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 mm/kasan/kasan_test_c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be3..4e23765d722c 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -967,8 +967,9 @@ static void rcu_uaf(struct kunit *test)
 	ptr = kmalloc_obj(struct kasan_rcu_info);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	/* The freshly allocated object has not been published to readers. */
 	global_rcu_ptr = rcu_dereference_protected(
-				(struct kasan_rcu_info __rcu *)ptr, NULL);
+				(struct kasan_rcu_info __rcu *)ptr, true);
 
 	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 			call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
-- 
2.54.0

