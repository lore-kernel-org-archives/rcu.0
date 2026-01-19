Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50D1D5174;
	Mon, 19 Jan 2026 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864351; cv=fail; b=ToFeUB76IZO/nQIMVkKerTN0XJIPo1t6T0XkFfDHhPffAZ9BigniHByznQmlIqWNEJtqjbUlfAoUt191lIK9sBSAaA2HwKGBanZRfzKdPHvcV1afDIu1KfXWd0sORF6bDI6y7xqz/km4Pm/KUcTPaAaeqMBvbVznuquOYxMMZSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864351; c=relaxed/simple;
	bh=KZ0AWBVsjMQ9f+AODMQmXqkHfiNS8+ENleQw1u+e3nU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AoSl01i7z3fHYyYQllPLNJLL5b9/zzG1ErNCLPOrU9aPXsOqRtFpwgitjJ4FP2ouuUkiYoFC+Db2FAZyFpf6dlB9q/q7Pz6SbLn7TijNlKDqEfs0hSgysoGIwojuayzaYwHTFKZ30qTmJFRZwOdpEDGOjTpCmfpUmqik8b/oQMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CrG1zGll; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrG1zGll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzWsvqGmW7GOPDjn60KBEiipnGSSeSuW5M02mDkv0dqafgAKz+g91uO6mMaaFUPq5w9dyQFL6lDIpEaR/F4B6FVoMSnL8GdyrWnDcvxyb+SCqdApKM/yI2iUVTN68epeWEiVUUJZrrbTczE/iRPrRZ+oPdnXuCOyjxWTH/BRe689tR+GmYbzlVPSQXznWejlPuiFWnSJmKD9XNA9cMxpRuWaHA3I71xYKrnQ5a2eNFH03VwHYwLc2la3/qePCtO4AS/YbFwLZzYmbizli1enxua/n02oo5CbBmK4z1A3FHrEqCJcYZxJAQnuZAJI0DCqoBPwnVoW/E5LYPN5faNgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrmf5CUV5/ffQ58UTWApsB7Lfdmbd0ZRCTKTelkB208=;
 b=ls1gSJeOF6TlEbsJr2i3LEaHBADCjqjLU/xzmPyH2LysL7RabTjSIwTMEO/P8/PVfzExKKKf1S0PPdKXp7JviCzMfS/pIsTk9dwdipgWPljwaTF+rxXrHoxGRf9PsOPs2IxPf6P3loSgKkckGu692fDbSK5JAYUba6Dm7eIPmjg/LHOBOn4JrGODQ8ReYVj+sOTRHPjFYUGLVcosLdlBrIg1DcsZcdv02bL+RzUBKriUXhiQmEX7No+z/ZsTpoj3TK/kUWvhaC4i+j5T41j1vON20tu1PPPTZ+ZhBYZ1u8Vi2DgklnJDxLZKEbeIyzlbgFJRrPek4JeKa3UaCQdL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrmf5CUV5/ffQ58UTWApsB7Lfdmbd0ZRCTKTelkB208=;
 b=CrG1zGlljCnwEBCBlBAxWsxslalTWXyA76y51Fe9+PQNfHynNpj7inzeG/HakCybDiytYIjLjd2Sq4GHx8pZJft24w2L7UuVen+ymswMLAGsE6cLVBuI+k8DzYrv0RMWnwf0DkPpry/zac/c0vrRmM67bWQ1LGXA/D5ggAKJORuEfrYO24qkEBlWGijLNTvCCz5agWhE64V8W0vQbOU1zXeP/ULwtocjKP8V3XUab63k9r1QUci0fM+9XxNhtKkGq6jht2jUiB7mchJi0tLz1QbdzojW9i0joeWoR5js8PDDOo4llXy9XySf1rhD3ZJFp8hU1qirEPH3kdG2kxK8jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.10; Mon, 19 Jan 2026 23:12:27 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 23:12:26 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v3 0/3] rcu/nocb: Cleanup patches for next merge window
Date: Mon, 19 Jan 2026 18:12:20 -0500
Message-Id: <20260119231223.989409-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d7f539-6136-43ba-ddc9-08de57b0361a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvOakbJPMJhLItYS4wl3I51ZpvV6VKTcY79VAICmfaW/RTZPXfZWTdw/STBQ?=
 =?us-ascii?Q?GBBLTHQU3+jgfLUTXHMRTShsEULL+MXO2MkI7C03CcsmOOs83CRSRc9C3FYb?=
 =?us-ascii?Q?G2oAWducWa5y/C/b+jcKWQt04inD+CfrNjaIX4iPaCl8fqfeRKudFKL/kT9W?=
 =?us-ascii?Q?togokTxm8WmNKfv4ACPKwcjHCWVKMiy6v+XGxrUzlbtzO3Lc9Z4P3XrS2tX1?=
 =?us-ascii?Q?ZrPBrzIcTwvv0cKBvGl62nkf4G3cR4n+psm6cwXv7EDOVHTwKTjGSlKJdN/P?=
 =?us-ascii?Q?X9b754TlWWGh+bGOfqPBtpr8lhQF48JiKTiIDbeDjkJS27SMq0FB6S4COcQz?=
 =?us-ascii?Q?NRwe7jjYq+jShvjRft6SY7/o2CECZZHUUHqyl5tMVtqbYNk+jrLx7E2f7wAk?=
 =?us-ascii?Q?m/XBHJo/Y7WYLVzplQ9XlWIuNC98ZJoaN8V+j5aQEuoTmGFev0/+S0QAO/Sj?=
 =?us-ascii?Q?+YmA+7Jek0VYoTfdEqZdoahn5tIQo+wP8Zd4nw9KlyOp7nX1TQPF17lo9JdB?=
 =?us-ascii?Q?myN6nMqjPMVrm0CZ/oxYl5d+Yic4PX7rFYy1jKn9rs1rjQDrignqUHrTrLM4?=
 =?us-ascii?Q?nrjraVYocz9XXCxggHGXbJDczfKhLzwhW54pU45FuT9QmAMxD+v0jDK/PViB?=
 =?us-ascii?Q?w11MTjbr0zBxKB0m6kTfgXYyyUOMj/GcGMP8707mBnSxkk9+M1vgTgYkEO1M?=
 =?us-ascii?Q?hQy6iuDgJb29hCOce3AkElLdkVWagILCt6dt5XgOo5PYRVZon7UG3xVKR5aW?=
 =?us-ascii?Q?V7vCLf7qAUBi7ssCrXTZfQWOSSIW0MpsCmBFIXsRk3VEZ6+hvFN5qqPGAT98?=
 =?us-ascii?Q?roc1r5pG4mrL4FDDE6tyPnBUKxaLapO/QfPI1EqNdThUdAuuZxuqo53sQ5uw?=
 =?us-ascii?Q?GLzO7VkmCxwI2vRLetrJhsSNLNVuFQYP/jcyOOxhEaGNbH40zAy9069g2PBm?=
 =?us-ascii?Q?d0lDX5TE//c7OSi2nF1VpYLPNDU6erU24oWI4UC6tgZEPebZTG8siwNaktvU?=
 =?us-ascii?Q?BqBuAM/1dliy1TqlkJKvIKGamKa6Gy0Sq7i6HPhGTHh1viw6P9nG4GNKk7HI?=
 =?us-ascii?Q?crbhJR/5FNiD8zLy+nw7ITQ/ySWU3vKP0H6YumghoQ0ioFWHGyTlVYGBwc0y?=
 =?us-ascii?Q?0hJdXlc+cwoB8BDnVyn9OMlXC6+BMOvtFN/9LXrhvbocSX3uzAdfyNQWplR6?=
 =?us-ascii?Q?l/InB2GuvTvha43nXSAm/zUDRuOe1wM41RtGqvBS1Pa3fLh8P6p5Cjh7LpOo?=
 =?us-ascii?Q?LVatSIZODwDOWb05WItVaRMm9sMd99D0d8woiErqlZRGoTIPk0jEZSMtXUAX?=
 =?us-ascii?Q?jwdrKANsxT5objqqQvT2DJ1vrAqNTTLvsydd+TH4EkzT5jC9xmYiXa2/9tQJ?=
 =?us-ascii?Q?jrBNlnKVW5L3e1FundjyyAZHk5H1tlSBMKampBUhivD7ju6Q4tjNDckXO/9a?=
 =?us-ascii?Q?wdNVPs6ovYv08/2fd0dxV9rzR8az24UqDFsjKJ7GMeOPqe9SCzm2f5H6+1IG?=
 =?us-ascii?Q?hHm9tCYbppJreEdCDVxHBDTVBevpjqvtEcbtlzmYTb8UiazwNVHpUTcF+NKb?=
 =?us-ascii?Q?ihhyYB1LhQSEqUN50pQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Skls/lqyuVNn5vbENj62X1Zyjir9NTmlZVeuhEZHOvhcvS8laGA2fDvqHlef?=
 =?us-ascii?Q?vbfQbH49k0FTBBpAt3rsfaYMFliqUcxQZjiMWh9AMtf1mhN0y/N0k3p3LZiN?=
 =?us-ascii?Q?SuOXuWH+3ppAXRQrSOm+ngYgkYUc1FzhpbosgqIxKiKeUEOuJY2SJAf6WOW1?=
 =?us-ascii?Q?uaYAQWxywsvQtg2ZDZjjOGTBRgvj+M1quB6ShGXUtKSdqYWUtq40gfOBHp2B?=
 =?us-ascii?Q?4k7yXy+8n9w/crNpgaLCi9Ro71vF7Zb6puanFzx0oYeAKBjQwofGXf+eHWmd?=
 =?us-ascii?Q?kiQZpbgk9yNU/0pJY1sCRZRBNPmDl2IhYXLl7CqUMeM3Ut5LkAjc5QpD7oir?=
 =?us-ascii?Q?lvhPbCBvCTtUlGXafxPF7U+UzmGs1wutGikUOtyMxEXhyME/nIOR8ey0STDJ?=
 =?us-ascii?Q?l72OQBWVokz3uF4I9Ezlt+tsKHzPpiji5OZcvjApVLwBm33Jhx0tEeAJQ86O?=
 =?us-ascii?Q?NriKctK3o03lL3XBGEiTyyEOs2Z4by5fd67o5kkRR+c46OZSj7frPhj9IXRt?=
 =?us-ascii?Q?mykSNXRrh3O7ga3u9kXBhjvz+53WSHiN9yiwQBLmUWMD622cYeyXVZdArXdp?=
 =?us-ascii?Q?wWAEkYAsP07lkVbcPcQLV5ty4bHYwMsVbH2XTqPXfTNgGQsVCrdGW6Fma6fq?=
 =?us-ascii?Q?6A/G2RjB+XkTvgAHmkGyoxBtyhJ0Jn42AcLsUMFZcyGawhO8/WagZdAS5XkX?=
 =?us-ascii?Q?NhQsFPb2sIHnTHsuiXZvvVehAXii+zQmFBPqW5exagNLs+YUo/ZsCYE4ozbf?=
 =?us-ascii?Q?6KhZEEXg+2fWlirrcVVNcwYsBKjnl9R9Yqy37YkToo8lD5t9aylHITfy7Ciy?=
 =?us-ascii?Q?m9oiqOz5y0Ne+x4yRIkz1/TmeGxw9Fh+I/wCbmtudorzFZO8gaNKRKaXjPBd?=
 =?us-ascii?Q?ZkCKwUapba+kJHr007WiWBDP9i0qn8sFMizvnjOpFJmHbM/L8K5Dw5j9jA7m?=
 =?us-ascii?Q?cq/7QKv+qFWStFc5t8+kiEQTZtml10eoofnlrXq1Edcble+4ALZXV+VwUzDE?=
 =?us-ascii?Q?1EeAaOQuOsCCyd/9+RF8JxD6K4ow9SUgYH6J7ot2pVuD+W5PJZKhYz8bhuXY?=
 =?us-ascii?Q?VmuJdPYlejrQGw30GtOtk3y+Y/KmgFEmU0Eju0tQI6znqkmDgnX8GX+oXTaF?=
 =?us-ascii?Q?KzFewXcWL+x7u57HpBC3A7lbdXJXKZ2YMwoi2ehvpZ3E2iw4LhB37q1XsmT8?=
 =?us-ascii?Q?AMkfajtE7En79UICFnsV1TJDsSTd9bl+ET1X9iEu3LyFN58vJZYfGdPjGO1G?=
 =?us-ascii?Q?rFWFORE1pDKToR033o4CEucLDm2nihnq0O0RJamUn7sS30IXuf5rEywFsqOV?=
 =?us-ascii?Q?n+rWCVOMlpA4mRv8Pa1z61S4itIJM2wyKW8jGWxuOnShnvTNFo2M/K2D2/oc?=
 =?us-ascii?Q?3QeDviZzUIJs+CBuytV2MEMEbnyQil1CPKwXa3pIOMOefomsBziH6MEgmsmB?=
 =?us-ascii?Q?uZo4qSeFpFx1Oxg7jkyoXY1OelS04EEeSF1AFIXH6yQ2mSTSyB13XyET0gS9?=
 =?us-ascii?Q?Y2oBifUkoXgixwvSaESbIO0z0aMijpPcmihzclqpH1E2YmLrFZTDpr3ZenM9?=
 =?us-ascii?Q?DrsU6sw7ADo+2Vd4ZotZB2IzL8PSm+75XPtFLYcsmw1/EozIgG6AMkemme+h?=
 =?us-ascii?Q?Qc7TnaeSUXAqUn4HswtnIFBkIhhDtlhtLlXBr+vR9QmA9FqIhzvFIUz0SgeQ?=
 =?us-ascii?Q?+PqFwUJuKdK4ACB6MQBvJo+wnmkyy/vFk6pE5+5MRX5w2n5/3+GVeinL4v8h?=
 =?us-ascii?Q?gxzFZ+pfgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d7f539-6136-43ba-ddc9-08de57b0361a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:12:26.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CLC/Dy9mDXZZNyeT3/bmKX2fgsR4BAdVf06nogVsfwRyh9tZeOqsi30PGsTNGJjTs9QhsGSMHhH7zsytNIuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

These are a few nocb related cleanup patches for the next merge window.

Also Frederic please object to the second patch ("Remove dead callback overload
handling") if you would like, but I think based on our discussion I have
implemented your suggestion, so it should be good.

Changes from v2:
- Dropped patch 2 "Add warning if no rcuog wake up attempt happened during
  overload" as it was not needed since we removed the dead CB overload handling.
- Replaced "Add warning to detect if overload advancement is ever useful" with
  "Remove dead callback overload handling" per Frederic's feedback - instead of
  adding a warning, just remove the dead code path entirely.

nocb rcutorture scenarios passed overnight testing on my system.

Link to v2: https://lore.kernel.org/all/20260114173154.1701056-1-joelagnelf@nvidia.com/
Link to v1: https://lore.kernel.org/all/20260101163417.1065705-1-joelagnelf@nvidia.com/

Joel Fernandes (3):
  rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
  rcu/nocb: Remove dead callback overload handling
  rcu/nocb: Extract nocb_defer_wakeup_cancel() helper

 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  3 +-
 kernel/rcu/tree_nocb.h | 80 ++++++++++++++----------------------------
 3 files changed, 29 insertions(+), 56 deletions(-)

-- 
2.34.1

