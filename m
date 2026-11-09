Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182578;
	b=sJdjdMlQ/+8D6NQBOudU2HKmmKMk6bXAJE1lE5DymxSlwbaLJTLUem7p9xXPWav20u4N
	 eCrIzDvl5XKPYlOnVFOfxRgY4HjrnkVpCuoxN1SUxPWNO9PMYcR0beWI/MECsFF6lyE5S
	 IIYF0/R01fShCe0O+wqNgNHxjRioT6CalROfkCxBDFr5HPtlFCrCxRsoWIrqv2OTtHUFz
	 HjAdSyVovhOqUKzUIM3K+0S3X/BwNBlsdqdNs01m5/ekvm3mQbq+uLHleFuriJmdCxz0g
	 QmNQfWeClTm84X6QfFBb37csy5TdXCjzZxv2zJ7NWO4O6T3syRyyp3Ild42TBRMaceQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182578;
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
	bh=qeuEK2M1n78QDUZL0uPtWXnsxo5z6VrJbxgDuIdRb40=;
	b=nc/zf+wnHA5Ybj23W127mzObXM4mzt7DFSOXLzpJcRaPe6gPtUBk4MfOQQTIUaqiohfi
	 5bQ7N+NtUDlfyne4Bs8t3/ZO18JrCKvR7kL5HlyEDaf/YQ1EE6Lov7ZVPkTkpWQ6RjQfB
	 wMVHr7jZJIlpf9q0AMtkXSq/49Xl4xPYAsIJC8u/bWsQZo5dpglkEawn1XrcI1Doy8aUn
	 pT2OspdiiLWgKttdI1q8HjalLfpbD83GLVEVuFjsitgt1WzvqQHUYpZvy+07iQTr6TXxO
	 mc5aUpR7ujTm+OQbW8n+9CDQG8bEOCsMVZSyLIm06Cpyt3mFRXJdgzIciDvTDW9z/sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j0eNL622;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789D1606D811;
	Mon,  9 Nov 2026 00:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789D1606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j0eNL622
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohs4aduGHBJ44s9leaBYKv/+/gtNAIVnqpdTrN5t3XocT2yIN/lSFuLs4teon78pkSZOOGBcKJryMZexrmMZxD+T7hKT6WOLyInIJHVRn+zvKl/sJsDyh6CcOAl+uehcNAR1puwsmh/uVPPH5hiJ93tb1UJexnk/3moARJ/vAkA0TCmwiIzScbZYoqYWN/UyRiSJ3aXLYbmUJT+nEG8oLJQHkIgNc4pjJnnXE5z36DZMSdK6FBQ2nVN8rQmw3AvL5AuaxuVIQvkTmxFaVCRSgV2k13+A5fGX6GFr/7Ar8QfI2XarkyEzUrqMhtfCwZbGrgK357zEcFEiFevDdglcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeuEK2M1n78QDUZL0uPtWXnsxo5z6VrJbxgDuIdRb40=;
 b=sFV2IkNEF2tFJ3PPiJjWzs/cRxbYdffmO20rogZyxt5TkmIz8U+swwejkcBi1H8TPsEbkwVBRbruk2pQDl7LA9Tdq4dUlfAqLAlm9+UPH0tHnR4BLYZF9B7SMb9xGBjODP1YKCXqf8V4nhLs3gwChm1WAX1p1nnTRbuyvmB6TyQDfuupvTKZpS1hbupCjjwUk+ayOaE62Wz8Z+MgryUnUTpHpkKQzXlA9ZqPbpUS1Fg1xYUSqk9hlOSnI3SLajcZcYeHux0zlR6D8cHhsZNf3mIopuccfrTlpayRc6vNq4Y4VM2Np2JlHb8BJ6pI2tWMF+xBGqajh/xGSlH9CgR3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeuEK2M1n78QDUZL0uPtWXnsxo5z6VrJbxgDuIdRb40=;
 b=j0eNL622xLe6UbYCOOrv5R5/UYwSghKS455HsyLVSzi3/sAIXHpaI+oz1RGX4HDpQ5y7b/G7zS3WKpxTmlC6QRTp/YPm6SiJzCFw7qVAQeap0fVz+Kue8D8u3mBTKO3P9QS/ZpJfhO8No+kovXn/k7ZgyGSlatYcbX/TQalg55neSc+7L9GlSHr5j3tz5veMNCkTSwl1Wk/l/NAuydOcFRotfhUHG4hfeEgcVCx1Qc0GjwG7e6wv6q8pQOI3jGgFzzjYgk+A7E5IWz/3ndDh6ARTIq8ZUn1grBQb6Ina23Vl8cdv9d2asDhduRzwUVwMaA48t9UTw1H51ePgkK4muw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:53 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:53 +0000
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
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH v2 3/5] scftorture: Protect the initial affinity check from hotplug
Date: Sun,  8 Nov 2026 19:02:39 -0500
Message-ID: <20261109000243.3936824-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109000243.3936824-1-joelagnelf@nvidia.com>
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:208:2be::30) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 71439aa5-f5c5-42cc-3917-08df3df4ccec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|10067099003|921020|56012099006|11063799006|5023799004|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	AgGQ8hV1iDGbLX4bgqwYrRFsLlqgL0c1rXnzQy1lQX2RvG4nxdsFJyZVpZLGff8leipd85nNCtP380EVFDUCf3hERWlABfFi79UvGhA9b0wVsZTw+5D8klJS1VlRuN19V9wuDDRkE+dXgUMB3A/6FKEfRjUDcD1LiXYLr36DLLWqHU48XlsVr8UOzpb5tPMryobkQ4BcJvj7iOypDKx8RHVE5YKqgCt//2yfO5/S74wqAMKFexl6CPEK1GyVkmNKANw/5knG5FNTKml9HhsgNCYwKsS5qNncwP1rAtoDBz/Tq2KkLncH//kJeFBTJDH301eM0jFBUThsaCWnzWZMkvNBIX8XjMMLQY4qVscmjeRQ5g7MzDOmSbMS1W2/eqNndd0PKyArN3ABCX9MRV5VRMDvFVTjjwtRnqTMFjppThK/7e9fnb8+hcjQxfgZIRBlBM0zookpUla/hZEU2u7/Yfkyj6y58lvR6lpKIXAOFJUZxQUgU4YG0TlEMBSnrh/7gDZfnqqQkn8bH7SpqKzgW9Hm9uAJo8bM7/MeMsgRcbBGiCWDsluKOgsf/V+vRL8xtORBAG4svDEJVgpeCV9DIY5oXcpqpQ9dAv/xxU1P2VgvJmSQRjWc1tn/oAONLxsT0zBmZPXBQUSTkUJONL+hbhfLeMab0qFcYKqOSt1Cg5OKTQBwGOSPNwHGE5rXz5djAfj1n7TeNuYiuVBI1YDv5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(921020)(56012099006)(11063799006)(5023799004)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bxN1KtPWvbWGLc07xEy2+DGGkFsDUz6fEH3oFsgQzR72dIS6Md2i2eic/f+E?=
 =?us-ascii?Q?YjBj6SX/pLinC3DO7+B+3n5VaWh8Dx0tbWsMeie9DezyAI5w7am3Dfngdix1?=
 =?us-ascii?Q?UZdGL8JmaFutFv0CwCEUJaEAgVYvaDgzaCp1wz7zs/Gmlncqh6htaVGUpMWe?=
 =?us-ascii?Q?8hwcTJuPNct4MU7S5z2VfXX0MR/HsjhOA/6LfWvRtlw09m0dXYAi++OUGl6R?=
 =?us-ascii?Q?oMIiXy6BCKD+KyHerPUFZloBb9nruFQA5/fad25wJp68loe2VPzDqiLlOgzc?=
 =?us-ascii?Q?HzEEvaiIdR5Vnsvvr6pVjOkjtsZqdvfqigB/lab3yuADMot1Xwf7BIrnmUQz?=
 =?us-ascii?Q?O/5hXvOXML6fbyIEO14CZT07D+/mxMijYQAReYLLunq8dhmx/sCzW4rg4OZD?=
 =?us-ascii?Q?P4PTjOtULMAz1ETFhp/D6XSUU3ApHyt6AyXUi8OjQZ9PPDpP3Ad4MHcwa0pK?=
 =?us-ascii?Q?yC8Qd3dcO6uB0MieBne7u5XFR1wvmOMxnKoiYAVGG2ne0IVQ2W0/c1OZ1aej?=
 =?us-ascii?Q?V74X4Lti9pMvGHOldnd73tzM/6YFPhB7Y7Gp6DjZTYtcS+64gKaN7BYOS0AL?=
 =?us-ascii?Q?vH8OPqVkyzl9jtpF/eTZQaq2kwHUDhhd+zX9z/O/+H/8V3GeaT+4ktYyadWN?=
 =?us-ascii?Q?krOw3qtpbUySRwR2+ig8b5RiKLEwm7bld020AbroLnL/UGLb3RQmTkTidOcW?=
 =?us-ascii?Q?nYx+7SbxeNnqkfrEDv4dXeXBtBUczXEFFBWDGYke1691k+Ypm8KmV25teiC8?=
 =?us-ascii?Q?oI5PrciVxA+Bl3uAG/StDTsitQJqR6dkVStDH1RWjcVz7Hsy/xl+v7fgp2Du?=
 =?us-ascii?Q?KkRkZwQ5rYbXkaLE08fHN1qdXs6cHjd1rvIozyLFQVNru8IK+La25eJmX3r8?=
 =?us-ascii?Q?9kSciFW2tBqaJz1Uwmf45J6dZ/BAqMmmw2IBEgsU+HUUjN7U/eZn6TDCXpLJ?=
 =?us-ascii?Q?QBc5LKpyfZr7H9J4Un9epqEXqIZQTNvER2fvV0AtzCayci6JqKZfhPSp5FuT?=
 =?us-ascii?Q?BIa2fTwvYkLnwiJkZUgfS6j82J0PPNhi7AxHn5mfiqmheo0ovF0iE1cqJT7A?=
 =?us-ascii?Q?0EOfUQ9aBf0X2tNFnx7BnpJPrg8Y92YUO1XioLgviB6/rZp5a671lSLl93Fg?=
 =?us-ascii?Q?NctqCQzU2fxbpaXfsBpm0bp3umCjc0v4J1JgowetQ+C3FfRHOcZgM7fK77ZU?=
 =?us-ascii?Q?/zJemZdHgYD8Lnwm9252FR03DMG5OInZc4u8edUAyjCOa0SMFhrpTCZU9BSA?=
 =?us-ascii?Q?tLvtmuxhf1zZytur19+PW+sgP+J0+M/ZWrDlkYftJIurnrFy8zAUXRkuLqYK?=
 =?us-ascii?Q?kmKf6anYjVeyLhUJ96mj9mLgd1CdLdPoZjIjhyw3cKn8ZdecuLD6k4zIKpQp?=
 =?us-ascii?Q?GZauDpqlMVvLvv4ZpMH8lT4pwRERit3e6ERujqn9V3pFij1EglmmD974Q81F?=
 =?us-ascii?Q?VGd61jIZwxB6a34XL9I5ffwML8YWHUVcdZntwGMnp6/rKBfjfVG8GUmv9I+l?=
 =?us-ascii?Q?zdUQsctAbTjOliQN1JjJJY48ABaxu8wCZxsKpn1H1+034fY2XSmRm/k240rl?=
 =?us-ascii?Q?Z8gpWA4pDpakq5Dz1qEKvxoF8IeUKp7WK6/WbiAw1UpDthqcqkkWzSgK2Nk3?=
 =?us-ascii?Q?svM+U64EXeo0tsxu3DRYojyzFH+rbx1tfSZ3VAMGIylzaeAaHUsm4Lz2fzIR?=
 =?us-ascii?Q?IaToPMFrAWON/IpltcHtIDRd1GHkz6OnfeidwekrucqFF0rZ00Cf9Sm/+8uH?=
 =?us-ascii?Q?/ILapIl+6w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71439aa5-f5c5-42cc-3917-08df3df4ccec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:52.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kICVTQmiiWUkrexA/bjUoQlD7SSnDRTiiLU9H/rsvbCF/rNobnve360fZqxN+CExpcEmAqFZFu8T2P16a+xKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

An invoker binds to its target CPU, sleeps for the holdoff interval, and
then warns if it is running elsewhere. CPU hotplug can offline the target
during that sleep and legitimately move the invoker. A built-in test with
matching worker and hotplug holdoffs reproduces this warning.

Check the initial binding while holding cpus_read_lock(), before sleeping.
If the target is already offline, let the existing offline/rebind path
handle it instead of warning about an impossible initial binding. Release
the read lock before the holdoff and test loop so hotplug remains tested.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/scftorture.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index ff9a8271a464..64ee2c5cf51c 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -479,19 +479,24 @@ static int scftorture_invoker(void *arg)
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
 	cpu = scfp->cpu % nr_cpu_ids;
-	WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
+	cpus_read_lock();
+	if (cpu_online(cpu)) {
+		WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
+		/* Check affinity before hotplug can move this task away. */
+		curcpu = raw_smp_processor_id();
+		WARN_ONCE(curcpu != cpu,
+			  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
+			  __func__, scfp->cpu, curcpu, nr_cpu_ids);
+	} else {
+		was_offline = true;
+	}
+	cpus_read_unlock();
 	set_user_nice(current, MAX_NICE);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, raw_smp_processor_id());
 
-	// Make sure that the CPU is affinitized appropriately during testing.
-	curcpu = raw_smp_processor_id();
-	WARN_ONCE(curcpu != cpu,
-		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
-		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
-
 	if (atomic_dec_return(&n_started))
 		while (atomic_read_acquire(&n_started)) {
 			if (torture_must_stop()) {
-- 
2.54.0

