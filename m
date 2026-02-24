Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337428C854;
	Tue, 24 Feb 2026 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974291; cv=fail; b=poj8iOfPbHni3HMsfos2CIJyJHSzGURe7tt6cjC2s7ZatD8N4uo7cCsNUm9PRp6Vlclx+4UnyJtB8gAYbSFQoPywucA0TjBCuFQVkqO0QeRe7UZfB1qbL3QqJ/WG1hb5mmEUcuDq6gzFHOVuPI+39a1GypNOn2T/k8xiZgY2dFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974291; c=relaxed/simple;
	bh=g67omAcy6eNQoAt2tnHwNgOn7zG9P3nbzvHYshdkWJw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uruu8eiyNNPZ2ChL/Oh9vhsWqwzubn6K7ruGdBmpADPqG+AkJ7TxIFMUAZmLWpgMt54YbtZu40UkWTk10Cowi93jVt9ajm03d3BOZogcTnqp1gF6p7U5ugIPTv+8/k3xjfBJKH7tjC9d11qdJPy9G1K33mEQI8sF7loC2jePss8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8GXfasd; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8GXfasd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzalw4CNDaEJV4f4+w/o949/z3WtFrRfLrcMnqWJdnEKlM95N/qaHbPyvDmgSnfkaegWwggueo5bg155qM7pMFYcl9LaVZJLNhR66t9MTSmhxr5Z5tUhC3SRLHVysDiBVt6N3NBtJtwJ7GyZ14HPRweAHATbH53HcLiUKDv26lEvN6WvzQB4vxKV8eXky1QujiOg/Bagt0mWwQ37pEZlOr6PpWfxcDezoa2tYXE5a+SQzcLJnHCU6v+eZu2cuXkUj24nF6EnfUTQvMzbspkwh6abyvzClc6wXGX4zcQOiqQ7vd3mX+1hEWCNxcP/Atj4uud5FiOdE3jSK2S5aTpmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTd4PkFXsRrCoqsqjXLCIWLxjEwfJqWq/Y0LEeh2uuY=;
 b=J3LH27bm4EG1aNkLyMf4XzVQStD5BawCcU6XmvAXAGycsjhuH8gw6UY+QSLU6cEJ4zAJfEpiucAx5Ea1SoX0d/q5tAfOARCiacgyiZTTsbcBnSoCq1LbU/C/L3YJHg2l9D46AgE+Wo23lpEWSzD+cerSE8kCYCsB8Nab29nrZn8mGpa2xqK1wzWJgPXlsQepAtBkFsyBup9zUGR6e+57f4F1tA6JFbmFJE6IdSN1bHsHrhq2o6jkGSA9fSz3zFlsQhhqth5jHuE4P3XajT1lzTy2EUm2Jg4AJMm27qkkUj70rV6aX4dEEYwt/h4u43xeGl1QuBNIwV0GeVgN1INm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTd4PkFXsRrCoqsqjXLCIWLxjEwfJqWq/Y0LEeh2uuY=;
 b=Q8GXfasdA2OkvOYUp3XXjsEZq8JwH1jLH0cFeiC89na7zriOUf9sGvnW9UKyvpipK6snCV4wgee9JAPIph9ajIh4tnrOX6gG3S2nXc9zBfxjCrdqw2/5+gcTA3/QNITUZKFc7pms9SlDGqy+dt9UzMFcBAhJo16afgbBfdcpsehugyqlwfDFUNj4juw4l80ECupKLqeDA9vJMlVA7vPt5HyPZPvG4a8t+OE0tI09PCSYgKoLo2G1PnT4VIA/yLnxx1kiiIb5Ut6LVW6POkyLswquCEcDrQDOwpZzl5lNaQ7aJmd0M7cnx1Z3wTv71DdDfpyU8KdogtP50le40uzt1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.14; Tue, 24 Feb 2026 23:04:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:04:47 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 0/4] rcu/nocb: Clean ups and rcutorture test configs
Date: Tue, 24 Feb 2026 18:04:31 -0500
Message-Id: <20260224230435.3390963-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c4d17f-d290-4949-b9ea-08de73f91aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7J2W3E1APdoz3u/1E940ByCzibl3hpsUwLt7yj01cyC6DsiFTqgQqb3orlc?=
 =?us-ascii?Q?qlsFrcky3IyzKdG0Onw2XsoHKz9ysDMks98JKCYbQx1YcPKi5n4+PKdUrBRM?=
 =?us-ascii?Q?JrVLSxMmdLzEAUsQk3lJEGlEX6lopH7hx+7UZQiv7oz9wQKzcSoYnxEKfzNa?=
 =?us-ascii?Q?anmJGWXmBEt2onAoiugyMQWpzmnwgzbVWNL1xGo78NIm2H3Ar4exA+saMJyw?=
 =?us-ascii?Q?A4huncrggaK3BQFvVZsrLHvnRmvkVNILyP8snP0ZfWY4BhASBIvsUuNcd/LZ?=
 =?us-ascii?Q?lQIul/76h00i+dMbof0D+f/jI2yDNCLRNSlim8pIa5gZyAONuRtWUN8BPu1B?=
 =?us-ascii?Q?Hghy3aooDb3jKhHMJjlgFU5EDmwD9nsyNK8XqvhCfFTWUHKB0fwQQ3H20GBx?=
 =?us-ascii?Q?fQncgxrSdQiRAx7qLGxxiB1Fg/xtymdv+zND/gmasdI6utHBzT2fl8tCoibc?=
 =?us-ascii?Q?BzKzYdRce8dpHJ9HBjO+rq90t9nT4mvjps2P4IRmylh/8A0VQZADxrw6u8Ef?=
 =?us-ascii?Q?iN/vtuQM6tmJLRS6BG1f4TnBxOXeDWzZ37KFmCstcDil0WtY1gibsimGX74k?=
 =?us-ascii?Q?fYdWslZZxWbHObS5kQj7UMYAW4uOZGVubrPVZbu1Bg+QZa9lXMAmSsjp7898?=
 =?us-ascii?Q?WyGHAMA4i4lHYt19Egqq5VnlngcTuwPTBXOg1oInazuIa+HpDiM6SGExGHcm?=
 =?us-ascii?Q?uHMIPUBCQ+jXPx0tfQ2VWALIuGEcP+PlOyoHtZcD8fYisbczgt93dwhGt6h9?=
 =?us-ascii?Q?Deh7I6BF9RDo6sGG91myXfNksRqmV93TaTVEZ+5VCGZN4riCQNaSXsiPlm0P?=
 =?us-ascii?Q?6GZd2LxX9NzZJyqExRfGcES2ZS806O1Ja7xeO4mymDsXS6+HidpAOIFdzNvW?=
 =?us-ascii?Q?AQJHsI62y9Ygi7QkE88LKb64NAhB1wb/Oii17IKcVrYgOVymbxAWW9MNGifC?=
 =?us-ascii?Q?4Hzp0H3VcLldh97vju/sZBJZ15Kadi7JrHB7M+bBCXvTTQ/6XaOqYDtkA4Gl?=
 =?us-ascii?Q?vJGTNGX31FUhfy6kxcfS2H9Jj2LkQPKTWp+FuBBB56Rcsd+3u/vptE1nPJMb?=
 =?us-ascii?Q?/mDyGPPOdyKJwvdydCoxZgXNzECeJlimYTCBVSQcQZHecU2+oDtY0jiQEpOc?=
 =?us-ascii?Q?8Q+S4DvPudWtIA6oBZBIlLHy9nekzIy2p7z0FMwdojMRxehgDfHkshvWqhJC?=
 =?us-ascii?Q?fnW9yBQsNPPbphJ0+p6+G/kN+m53so8a7f4/kMyrpjS8z0zQZ4jZdMjFsioG?=
 =?us-ascii?Q?ljq2qWimMbDx9iGCq6Om/BhuRxharwwsMGaZMw/2COGmMRcgt6c+XnoPICBS?=
 =?us-ascii?Q?PHrM6YP4GnsmLXJn7ukGIWF57bhy+6mkEymMlxfiXCPQ1kE7PhWdVH5i5XWc?=
 =?us-ascii?Q?PpdjiED3u1f2LDjDYemvuO3zjZTfvCOUwPSqagTyjUAyiSKpb2lZf8DOuRzE?=
 =?us-ascii?Q?4I3HCnegxpQm0kVTTunAM8bguQprkQXiB2NTXIAKWF294JP0uq5HdPDG6BtK?=
 =?us-ascii?Q?KVuA/7KDIoYwoHrFV7rs0+B7wN0KTxr7ECpDXDtnRJOzH0qJ3+ZtHAWU8SWR?=
 =?us-ascii?Q?/G1+S7sL7zae7pyKLCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Rn0TEAyKv75Np/7H/DJl56mwn+2WpkQBBeVQSv+3DWLKIHQI/9Uap7G8/nx?=
 =?us-ascii?Q?KmR2mhCETGz4k69s4oFWhvTqpVj+zagpRJiCwk9mJdmbt1+UOPbBn8hq1TR8?=
 =?us-ascii?Q?dk/AEirOum4Zw4Ut8qUv+ybtae9fhofB/zvUsLpqpKYsu1361EdQDNPprTr1?=
 =?us-ascii?Q?UUTEQfB4nywMAVPcDhfs+9VpOoI+6cj2ecXI8qxo3c2627IPmBqMGqCf3g2a?=
 =?us-ascii?Q?kowogZCMkQlBWWjKTYlD2M8otKwzqHKAYR+boGcJqd0bk45/hWXOGZsnbG8l?=
 =?us-ascii?Q?mPd5alyOmCcjs3A3t0B/dE20PRUoigFzps2CcHV6EzW9pq7FTrQjZ+HObwOj?=
 =?us-ascii?Q?FiUdX5OMTqP4qwxRmsqJ1NyHNIdkiG+oCi597M3EGAP3TiWYfTGtTzX1yIet?=
 =?us-ascii?Q?VqwjnNQ0GcJFIfWpFHM1UpTIjxc9KuQommH1KPiXjde11fM8tiISRE2sUN/i?=
 =?us-ascii?Q?ukHjkQ6M9DZjSA1uJ3+trjshl3xY2e90ZM3YWdrutX1ETmwFxglfRgGx/5Ig?=
 =?us-ascii?Q?VuIl/xn119ceSdAmKJm/+YgEZ/eQksIQKwjhAFX030uXdHh3j6m2XH4jsZMP?=
 =?us-ascii?Q?N+LntCJOOuzrCUS5dVu2l+WrZ1ELzWIb1ztE2L/oNedThLd/xN3W23RerLIu?=
 =?us-ascii?Q?2LtGxmSRBUcfRXmrnUeFLV9uAItrUFu/QmQaovErJx7gJWgvudnIvLSJc+OC?=
 =?us-ascii?Q?L7WZt5P9X+IyLCvmul9aaoUYvkBaFaF2qOEcf81zQTMAwl0c+yDGVa2wfJqC?=
 =?us-ascii?Q?qGF1u33nsct5ntvn7R71H+t3MIbl2f1zRh6B4SV2hsNm23Wj4A+Qfd/OjhsS?=
 =?us-ascii?Q?NRBUScDEpciciUOxHxZSMpWsaJm00JK6U4g9Fa9eWjhLTN1cRG2D04ttxtoT?=
 =?us-ascii?Q?Gs+jAO8dgu2z2ImbfGa3Jv/5g03C3Rs//OGHa8MpezKQBeUwYmPk/GZnEpJG?=
 =?us-ascii?Q?TX7s7RmRe6px6Ix+e45iOKyaQp2aWXFJ4k/4iE3uHrel5/1mqUufbTCfQ3et?=
 =?us-ascii?Q?w4/FASJDX//gXpj/V+EfMRCrrRBoTOw7K/TqDZ1RDYq19w0163hqQCXq/6+a?=
 =?us-ascii?Q?XZrtgY9CKWTWYGEGcgG032eSzyyPouOHsp/3pg2x1K94mHm5pOa6o4zIW0xC?=
 =?us-ascii?Q?PnMq1j1xFfDkZgcGZvsxVhUbHJcB+iDSUKmeXIRpgBXoo5Z/pohA0t+AnDFL?=
 =?us-ascii?Q?R6OplULBC67bvkDzpF9w0eS5oRDgNsb4S2isBxgbpxSVJ28GwTQemsNKH44j?=
 =?us-ascii?Q?Ld4WZtStR1FEYF/GpaFddVYc+3o78PHDrsMC011hBDsRuDzlPyeIATLmwf0T?=
 =?us-ascii?Q?kBlBatZShKojxoMZBHpBWop2HTDXlCHq3bno35x8YhRhizemaZ35tlGGuPZw?=
 =?us-ascii?Q?pCj1EyrNZKEb9bztVZFcAfs5NtHca4LxSFjln1ronFCdsRAEmauaHBJlQkwP?=
 =?us-ascii?Q?7hGGvLgrwgeqKu9Zhy1Sj5Och1P5B55KWnnEseg2Mbt8jqLqRpA533+UASs7?=
 =?us-ascii?Q?GUZfa+HcM3zLznlxOZx5Qih4QW+z3DT/7xks8A/DJ520ejJ+46xHmcSVwdtp?=
 =?us-ascii?Q?qq1LfcAS5kg2oXIaDdvquE83JWCpbTHjW04vPbZFDkyTCJRIpCbFaf34pWB+?=
 =?us-ascii?Q?ZpRrGccepuLCZT1+aCcOwFU1I2osdE3DR0/dJJq+CRuEcgiETE1j3yheZwei?=
 =?us-ascii?Q?Ix2JVRul7+SRw8UNflxj1YSPwxXlcxxYgYF3/wCgxcmvcJsQbAdxYKv/s5wf?=
 =?us-ascii?Q?G4fvnfPKqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c4d17f-d290-4949-b9ea-08de73f91aef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:04:47.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maEcBKes5rmAjkz648MGnuPmBu7Gjd084ShXRWcEWsjXIKuprLGEHBbgO01dqDFVPbofEKmFDHfRYzkYupL49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

This series contains clean ups for the RCU NOCB code and adds new
rcutorture test configurations for v7.1.

The first two patches consolidate duplicated code in the NOCB
implementation. The last two patches add new rcutorture configs:
- NOCB01 exercises CONFIG_RCU_LAZY combined with CONFIG_RCU_NOCB_CPU.
- NOCB02 exercises the rcu_nocb_poll polling mode code paths.
These configs are not added to CFLIST to avoid increasing default test
duration. The series passes overnight rcutorture testing.

Joel Fernandes (4):
  rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
  rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication
  rcutorture: Add NOCB01 config for RCU_LAZY torture testing
  rcutorture: Add NOCB02 config for nocb poll mode testing

 kernel/rcu/tree_nocb.h                        | 140 +++++++++++-------
 .../selftests/rcutorture/configs/rcu/NOCB01   |  21 +++
 .../rcutorture/configs/rcu/NOCB01.boot        |   2 +
 .../selftests/rcutorture/configs/rcu/NOCB02   |  20 +++
 .../rcutorture/configs/rcu/NOCB02.boot        |   3 +
 5 files changed, 129 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot

-- 
2.34.1

