Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B4313E32;
	Tue, 23 Dec 2025 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450659; cv=fail; b=gDVr0TCn26gcmLaEZxwLQtduv0ClfKw3zlLDYF377JS3oQIBeS15++uSTdyOAlD1Wo71tQHGaJUSHCie4ZF56W2UcUh48TFpjPLyBrQyOEDZ/7NuyBmqh+SieIOkYnnL53sjLAEJHYS1Eb8cY/ZY7Qfe9GzNRRo05+60yZBzXsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450659; c=relaxed/simple;
	bh=zZmCHHxE12Xl+U/kIjemn4KcHPe8PLuuyOohzyOBRDM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DlgLa+kZj2AOpljuAVvNSJ4P9VQGnoclVykP+1unRbuqYF2d4PwqqGqiSe2CFY+upd347vTLZuqiUItqCaEaNk4BW1jU7t/UTUpcsSn68oLTBeTsTO4Np9rXE0KEo9nE9CZ6C5ZStK3REP0IyK1kZ+0C4cRyjMj4DsymkPdBlDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnkflIaI; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnkflIaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFw1oRNzWSkcq7OBbdA2A6kIGRAeQB7kzEil+zKUBp37w7bZkQRolNzeNjrhk1JpXehlfr69movi8lWxakWrLIKg/Js/jwJaZeOmFhi7HWP+23OhhwuVDk/Wig+nQoUmYIs6hEQiIfv7LGPoSyUBZBZ+VSthPTgmvAFW82xk/094+W0DUv9FJqqx7ktwRVcX3ChrpojASBFiWWiMLSWfrLGKc8X7vMqrTCtZFHHKpjoDdDq17B/XMV82WYmwqWJpvwOC2mc8BIhNWLS2V1rK27c/sgq3TgEA9da4WdahTZKbs/2yKIEHLJUdQ7Nh/qwkuPnZLmoCwnLQc+YsGTJBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExyYqXTbuKFFJWkhE+InWbwLlfe98axGWyKqeF8G9dQ=;
 b=H8OETMFxvtZnQTokC0WpQ235KghFDXV8N+d4L9xicoHq9VgNBj1PsPLg3BifAcpVOMV0WyGbDp0H1sJCVk7VR8Jbk0YjEwETBe47k88mnh8TH8ecz8Wc8RXyNGe7QyqpJdDUtJKCxN3f3kbPtedl6hCSbzayt0hYxp1QO/vYX4ch2RMHgDGW8cNiha+5nJttATaSqNLdSMgCd9m53Av6namY6D9T+DflWFeiwsIKj8uEzIpR0rXwJVMdmQUyghZBXef1EnkF1gHwZPJYxWYyspdKlAAlF4/pDDQn4JatwshUJuT/C2fau0rTel3jwoPT0BAHAopSr9OswSKEUP9oWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExyYqXTbuKFFJWkhE+InWbwLlfe98axGWyKqeF8G9dQ=;
 b=pnkflIaITnW1yin/5l7Q7i0MUGj5HKDQuE5XHIjbmVpv9dIipxtZU3X0DTtb7P5ybMG92bEQXjgIlNcTq40n8VyCaAdFq7iZQC0arbKdEFWBmN1zdHSE/ZjwgFdudsRRcrMjmB1TOuQvrnJeHgUQ/8z2EZ7+l/RddxGRltTbi53DGYNkW0kBXFZLdgbUUVSHQCnIB2b8P2LI5hIaOR641HlrYG3LplGg+kf9Qvcn4HvsoqP0Y6+kUoT+J5Elv49P7naZbNNEDh3irT7bbXpJSnXSKyTmHhOn4V6/TYGZRmTcHLnCyuKrJQOI/KxiNUfzeUlisxKFjCie045iUbHtmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 00:44:15 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 00:44:15 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Fix operator precedence bug in exp_current() invocation
Date: Mon, 22 Dec 2025 19:44:07 -0500
Message-Id: <20251223004407.61147-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f79856-78a9-4138-1902-08de41bc660d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYKkJUJ6HiY7zhf+7a3kBkZeXrbBGuMLyBws7u3PidXU7MvHWNZrAmYoxyNT?=
 =?us-ascii?Q?SmqrYwq3Er4Oup1mGFvqBToMZkxSnn3oOteMrRP4PRQeIHO4VtkAU0CXtow6?=
 =?us-ascii?Q?MMEDfqz/Bs00SGFqJo8PYPsL4UP28p09EYGQU1lmtp1IuTUTHCe86ZDNsZ96?=
 =?us-ascii?Q?rgyfxcRACzCZgBCXixM9swY4hgOY/9htTt7STckD3UUV0oy8R5Jon3BSuZ6q?=
 =?us-ascii?Q?MneJwqZRWhzdurs/g0C9csjhNEQpIWCsA+4yh4ARGvm1f7UcMX0dS9vYWyOp?=
 =?us-ascii?Q?eU3XjoCx7AQUB6nWGB+9/kkhuYsiGFLojha8Wb823vVUi8+1KDcIAgpSOWwM?=
 =?us-ascii?Q?4JLAbMT18dvCt92sIa4mILm95BtCcgf8+1T4xEroxK02EvheWS3doaISQ7mq?=
 =?us-ascii?Q?DZnONAhsYguLH2/NXIO7aK4QdOEeBdmM7CnHy08G2nBtPiR0fP5jtxtCZthR?=
 =?us-ascii?Q?IWvsZ2DMUvea9H7PXFV1TJiP1CLbL35HxjcKXxdBekZn7PnjJhcYkGMVmVDa?=
 =?us-ascii?Q?oL622DUgei70K39EJ6DaIZdFxKR/+4ISy4S6uhAxD982ah43fVXUjJcGgdxZ?=
 =?us-ascii?Q?dGY1DphEFEjkmSVcArszWUG4/cQ4pdZCUGYQRKawRYOcBXr+oTfq992pCnTC?=
 =?us-ascii?Q?Mfh9KTm5IRda6u8dteKZFQeq30HBZlB+hOGgseOm2NtR7gh3rGg7JYn++vEh?=
 =?us-ascii?Q?cUTQEHxpZdSTmCg8WhmaxCTZ/fwzC2IJqfeLSD5jl2iMqHk9Fx3Blto1WLuq?=
 =?us-ascii?Q?dhqAgpEFGAK+Pq4JTJJaPsfBtP2eqfnDbzV3u8nMIbptnQP/PR5bxmLIF4Ya?=
 =?us-ascii?Q?dVewqPy3ZGdNWUo1sESJadCtIJPCZgl/iZAH7jNYg60EVygj42xSNff49NY1?=
 =?us-ascii?Q?JiWwyuhhssLFKmYw9iy+4ZbE/tW0QmJy/I+frGaLwNg/oN8IehCYAUj35nNT?=
 =?us-ascii?Q?zIpQ9+0jyCtvM31m+c8P0QtubTHtlhlDq+j3kGyOJGqaJP3h2kfyOTEgxxiV?=
 =?us-ascii?Q?f9Jpja4mZfDwGN/AAt1k2irSfK/izi9me7GP0GQM3GTvlTGE6OCQKpAudxSE?=
 =?us-ascii?Q?Ywm2O028fCFv7chifr7s8MKcon9XB4CHrrun/3rEynYPRimxuraKbl2DHFvz?=
 =?us-ascii?Q?Td4sQtwnVMDg8Orsm5YB8pXsspxkW5S4ZaF+qcYfjGrR1XUyaGD2pj3pndsp?=
 =?us-ascii?Q?DnH2iKmP0WBBn+wWNOhiG+pBU3BpFr4oxY+oVIh4C8D1VtuSP6sL2wYGUUhe?=
 =?us-ascii?Q?W1QJ/eQDxbjVoSqTJlcZ+qwvgb86zqlaHkZR78bp2gTftonAP8AbLM6iDUtB?=
 =?us-ascii?Q?OZvWz8UH5H32jM4bAZJsv6saAumOLrzqL2JZ4aqB/ShmlMxgl3EHWTjkRhUI?=
 =?us-ascii?Q?qftiCwlcEIRkG1e2N3Y2VWgguUbW5vSoi6biHbHBz+c6ho6IgthcobgqcWhZ?=
 =?us-ascii?Q?mJ1I9r8sIsPHroGAC7i1zkdE2Zrc+AFKEpjASC0ep0owgrOFrbTMHpIf3YZi?=
 =?us-ascii?Q?fpdC0O6klSF5Rns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ti98MIEfyp5yaUB9/KwyslFRaOaZdwENUkwX1DA9OMZnaRc2S/7s4fp8wfw7?=
 =?us-ascii?Q?rasQ3OgG+l+WnQEQ6AZj2bH1rCBah9NorK/cC98eLQjh2n4EbXlpfB01EG6Y?=
 =?us-ascii?Q?hKQArukcaHiozb+7hqfHopXVGwLJprE5U6tcJwE94zbdvGDBS27LL4uE+AkQ?=
 =?us-ascii?Q?ON9NPDOXT2cgv9S6WOr70RwEpoWN8mISd0ypRcwSdzUlGknl40+MiH/fSFmZ?=
 =?us-ascii?Q?EfEaKKpLAyu1raAJ4DkNIn1Wk4evAMrGOXHkiUDpJMaU4P8b9dcHuRCp4tNe?=
 =?us-ascii?Q?CYVI2GYlCB0Jmvmxapf4SqdHymScfKnVryzLE/KHdWF7e0cTpzBQNNd224ny?=
 =?us-ascii?Q?Q/HgmnFSMKT6YMBBRTRHh4vdyFOxq5wjocXcoYUAROflyLhMyqwMmDUBN4LX?=
 =?us-ascii?Q?raUaJQYSYny5om1CP/ILoks1OwWcLbrSU/dWB0g/uPfd6PVRUd6O/JDps/LW?=
 =?us-ascii?Q?FDbKpFRqH5KYWjAHrxCC886aTWVPM46kl9wf4GrddX2we1lu5vjLDYkEREY4?=
 =?us-ascii?Q?ACRrqRHV/mK5/1pOcs5X1f3nsUFHgsLxxlbSF9qq+FnE0640vHwDMxuWiX8d?=
 =?us-ascii?Q?fsuP1262K4xPepoFd2DZZnavkQZvn7QBSovCE7G6iMIAkZVRkPFo5ZJ/3Knn?=
 =?us-ascii?Q?G2/XKZWHDDBTb4WL8O4L79wS9tqo7pfsmcy8oZRPfFfi6G00q5aMD3KaCDqb?=
 =?us-ascii?Q?wlhq/hovweN9TQPjdXd0OuKeOD/9PE7DHrqPezb8GHXQFo7BWPJVGtahxKVl?=
 =?us-ascii?Q?kk5IsC/qjwpALERqhmfTmOIX7oDBvGCpvMSRYOm/8aEhN7t3XOYtvpKcdMw9?=
 =?us-ascii?Q?Pv45ym2595lJtrAQIaJs/BPWL4CP+9EwT1xtSJFdFonR8CxSzklaXdmlk5Ho?=
 =?us-ascii?Q?fPXQyVq5tzhbGyRa5KNoqEHWMsziNHB9tPzlacyCzrFuWz8Wl4sc77YfRhFU?=
 =?us-ascii?Q?wLOrJUHPShccxRmihqnoW+b+bCEe7JfP8IOAgLlRPuJR5ma+u/HywXS4Iy+y?=
 =?us-ascii?Q?4BVEVPYu+URxzrZjs4l0aKAqYAWLJ5lAyHDmx7xWo/4uv1hXO5xay8RxElvy?=
 =?us-ascii?Q?M3ugobNQhm7BNBVsb1bT/kJhy5r28YgvoypbT7/RgMBR8jhC1AntoZdyxRVL?=
 =?us-ascii?Q?/eKmDmTvgbeRlHxkX6Oduc6vWqMGMeyVrAQOiljwCu599cwV3K7jL+JuYsAD?=
 =?us-ascii?Q?8+a1T5XpiLC1xdudkOKz20ZR+dwWWzjC1BsS8G1Tuo3UbUjn0ma3h/DnDFDE?=
 =?us-ascii?Q?LvAinNQUBz+6oy+T/Sg5XTIDM1/7hXA8FnSP/WiSXVmC7iCZIUsIWWtZkG9r?=
 =?us-ascii?Q?F04Sx/YigqxSzIorobEvsunDrysnXNFPWazavyh0UT6yngsMbo7pVRGCddFR?=
 =?us-ascii?Q?HgCdj/yk+HlaePhae+5fIK1lpME9lTtEg0imaQF0j04pUti1xCcw7+1h/DZn?=
 =?us-ascii?Q?U+B5k2iIRpxZTY/DLOh0jkojOYxKQJHEsu+DmbuS2xYdqk39s+RC1Av0mrQk?=
 =?us-ascii?Q?DxKOk9Uw6s62aAZCwDeYlpBxLCqSisDqcsYAbt4nre+QdfkAU7BjAQuwVrNv?=
 =?us-ascii?Q?60llK+UR/Fjmr42LOIremVup4wD7mw7+I9MqO5vhY7MFgu7nQelQSwR5NQIk?=
 =?us-ascii?Q?pSZqccxSO4IK7tx+tCyNcsz96YoEMUFb9uhBrl7ftpZzG4MNr8EzyoTZrKMb?=
 =?us-ascii?Q?+yXr9kSDsvsnngcsos8JB2gNVvg2I+2VWP3HZjFgmWtspJulrZ2RKB5/FS91?=
 =?us-ascii?Q?kyp+6XBaWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f79856-78a9-4138-1902-08de41bc660d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 00:44:15.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BZk2ktQlhBPDwjiKrVfkHqgPIHlaXegkQFlCP6G7qGXywNkKYdE80f7unoIypGXUQRBzizTQ+v3O/QMHHS4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

Fix incorrect operator precedence in the conditional that determines
when to call exp_current() during torture testing. The modulo
by 0xff appears to do nothing.

Fix by adding parentheses:

    !(torture_random(&rand) % 0xff)

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 82588ceed9da..9873a1d54c46 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1749,7 +1749,7 @@ rcu_torture_writer(void *arg)
 					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
-				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+				if (cur_ops->exp_current && !(torture_random(&rand) % 0xff))
 					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					gp_snap1 = cur_ops->get_gp_state();
@@ -1771,7 +1771,7 @@ rcu_torture_writer(void *arg)
 					cur_ops->get_comp_state_full(&rgo[i]);
 				cur_ops->start_gp_poll_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
-				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+				if (cur_ops->exp_current && !(torture_random(&rand) % 0xff))
 					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
 					cur_ops->get_gp_state_full(&gp_snap1_full);
-- 
2.34.1

