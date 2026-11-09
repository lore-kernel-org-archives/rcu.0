Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182572;
	b=MpTwKK/VDPJ+iWPhXQd9nXapnclNSbJOUTBWjgt9FcF3f8c3vIcEoe3eWAnMcf1QCaVb
	 E0xPjg+xhF0oMvhk5jB4RJlPQGnw71/966uPfKn+RqTfz4BdD2kX2OIllv0xzb9vW0iVi
	 a3WYSPa7HI51mKCt0d+xFuEZoF+blZpvaHcogUDCV+HGojwd+L8fUnmj2FiukHMjR/LGO
	 IRudzxZYVrFHsNXpyU5jVnXlkTw3giq3QY1Am9gQ+yerNeUz23t6o8KpHTFIX9q4QsJjt
	 MouGTDCVRXvS8yJ5wtLmOA/HUPZBs5ozX0Ga/qh+mtWe6u5Bbp8iiWtLdPlKUHm/mTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=E2FsH1+r05GquPZxtw58ygl8ooy4kW60kDS5uggEL6c=;
	b=1tC06n+Tqz8jdBYMHqrhJXOsNn70w6S8GIZswjcUt2Iu4ENzBCBjvDKB8+Gn7YR6DWtF
	 42uG6rwc9Azjgt8STkD1BdJO9sKuRWnjFql65GxWAEGdjxLRRi86fkTWAbuuV2BFRWXQg
	 KciQWs/wDktPw/vBPJFWDGou210TxBkGKZwKrPeP/xrqgEros9cMzWMQ7k3V/kdrf34wz
	 13n4mhdWrEPEGgLDvUJxxx9aoyz2QdzReRTYMWHqHT6wMTTaMeqBybetMExvKFBOsTnyp
	 AAnKQy9UkhzIPcfeRQxTCXYN9G7sc8WVvLdwdM8e7khEEtQ3A1elJGGtJ9AhUYE08CQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="j7snV/yk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.35
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF63606A31C;
	Mon,  9 Nov 2026 00:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j7snV/yk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqagoAz0hWkSyn78I4XhrAOFWHrD5scBGSEEyTcvw/qvdtE8ZrzilcmmtuM/K/xn21FmQG4mI299b8+LUrYT2+T3Alhm9JGZlNdY1TF9R7Up/9q4NkUXfcJA34Oc+3VoX+j5hB+GAdMfsOv83iNHeQ6D6biWX/NDhhUxV3EPhHNwZY5daka7ta+BIMSN/EqHQYk/NZUIwiKCFhDaIqs3LLG0GUNMYQRBnWClNK+gDQRq5DCJOqCFp9GTFtz2LRKUJ5+cZJTwoUyeS99SxH710x48qbjpm4EofWh/Y8YfLpGVSlO3pcqxxjEtvN9/qbzyHgR9pRFbrFtUExvO5VXwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2FsH1+r05GquPZxtw58ygl8ooy4kW60kDS5uggEL6c=;
 b=xWGtKec/sNBCbv7hLSbaGYj+pajzYw6k6GhaqnW671apznX4b5Z2OghcoTUGZsiCpRckyP/a/+4Qi7Hn0/0Y14ilq2Jr8zw2eSUKGjnajiF4/xHIk36Xa0ztN1qTpdKXcT1Id9eWgKVRS1/2gbJmCv0LkUUxagMx8zAW24EslcT2yXnjIO8DP8ZsgDR39bPwiprj+hnlad2DQPd98YVHawUbz8QNxS3Gf0aFnOKf3B0zmUhRvqmBPCzJzINBN+OopIAwtnlCwGXyfQFDC3pm70qCCEWrmhIpxP+ptpeq0GcHUXhZfvlbwDow3Tn5++0mpa7g3OvDLq5tmz/f1DuW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2FsH1+r05GquPZxtw58ygl8ooy4kW60kDS5uggEL6c=;
 b=j7snV/ykbREt7YY8LpDm88VGpWI3fswQ/56p6IbjRaisEBnEZTf3OItbN3WY1TImxgMdoS3dFIpi49q60nexN+MGI1onHuqOD+dWvQppqdbb3F49xHCcnY66aYF/3ea1eHrtqirvHzrhF6Hq5QghmxzlFpPTVdnJGozVMlaEmQz9jMCG7VnJXfa5Ya/r7PnozxuHojPSmtq8H7MPZ2iZrVi381J6jEP5H+ZaHT7KqaCqTTcgXmTeyKg8FgDbfc0Dud9tjqK3OkHfZf/qLBJIMmWqJfIVJCUzT1qIjl+wqcKxIy/dGUdFUs9F2OfB5jt6vLvp0mqgOns7uiIe9NW8Ng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 00:02:46 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 00:02:46 +0000
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
Cc: rcu@vger.kernel.org
Subject: [PATCH v2 0/5] My torture test related fixes for v7.5
Date: Sun,  8 Nov 2026 19:02:36 -0500
Message-ID: <20261109000243.3936824-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To DM4PR12MB7742.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1445bb4a-38ad-4db4-e90d-08df3df4c8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|921020|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GPVC3AuyUc2m7xNHb5ZpHfzrFWBMAdl6uBlDaVEUStKpWvV1J056NUy5j5bPq7XJpuyujgEdOc8gcJhg9yxY/oqGUMUy0WCQBcrqx9LXAim9+AIb5vQONdDU1V2Z7YFsZDqezK2XS9vFmNm3DqibcddP5QZX9DFOr55w0a36syu2uSAnGG1smZ6gYBYZzELlqAPnHNGYu5P2TmCsz31HfBwcaRIlKcPH+bv+Aa4aa27rA/sfK2Gf4kl5fX0HiproQyqLxzCq6D6soN1aCOMtWvEzY6R74CVXvtlKKY6Ya3UbaLomuxAcrnsv1Wvm0a5Aiq3Ot881Wtrcm2Ye88vl9xlcCYVLymRNxEVz1AtUvw7UiOk+0hLmAhRFiNe7m5DrJySl8B5VFfteuceVpbvfPEks7TSLl0xS5bP2CkUD19++UZ3ZS12UcnvG1BbNc9LtMcahmbI3Wzmcl/HIIsSTpsJlNd0azSiRrp5xf9oWv8hC8LlImNL9tagE75JMhxemtW3KqrmyRnU4IIVCouAKyx5yvZ5zQe4hgrVoQOa8VmXm4U1XImXgmOsZkorfGl1F+zLN12F7/ZgfobbZZUV+R9meG1kg45lEbwUHz0qWiYKpC3vSBKRGwSFC3P1i71HeUvn4vtJOI+BvLtZu3Sm0HaMQBdF5hZ3jMqfe935iWHsMntwOf3Bs84IZdVR7OuVrlDdeJz3ag5+EN+rUiPqs5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj1J7rmVaIH/eco3qqfPa920T7X/6CO8Vvlfue11km/oLkmdUM6msi1ewP40?=
 =?us-ascii?Q?KQBIkAcnErQT5YwgrUkG4G0TkSu3TWSoESN3ndYWelYAyswSWfQ+lcKU57Sg?=
 =?us-ascii?Q?dH0bnfz+jLhvV7Y8Oh36vrfDHXaqfrx7LUsp6GAPlUSM7xq7IY9ettxC4lxT?=
 =?us-ascii?Q?snbds4toOOBoFkRkcUf9gK12HtwIQMFVcEEnvNqbfx5V3HGIKIm+wVoWkbT7?=
 =?us-ascii?Q?uMWyS2JQOIJZPpYdugDboAXlEWBZi8WEmASdJ+FoLqDYaVAKBhnhMKBd9bBy?=
 =?us-ascii?Q?DdZSpP24yGwaqhqcXGKKTUfHRqAoAOR2Wp7Q9mrboMKzJuZUbuYyABcaQdyX?=
 =?us-ascii?Q?aJE84X9Vg6Vlui61T2VSev89xv/6717rOufVA4lnivllSPb3Mgf7mlCpSLMB?=
 =?us-ascii?Q?ZpjDzqmNA3GGGlAXEot+gns1A2KQi3JBO+QQbCza4+ONt26X6/v6NDd11WiT?=
 =?us-ascii?Q?GK6fH6uvxbCynhekDEZDsUUYrZb5vGJ7NWjKcHK03lp+DBB5yV7k7OODNm5f?=
 =?us-ascii?Q?OVJFdWarW1XTzebDffmg47cIuz4eo177j9i0MSYu6RmHJriama64YBWNDXVW?=
 =?us-ascii?Q?Z87zJI/jcr4+1E/UP2iLA7HoR7MRN7jxytZ5q1zTntJYQ3mBx4ijK5v1GTTF?=
 =?us-ascii?Q?6754bhY/Y8mKXkyG4qm4eM8W+G4WY8LCaJZsfWHWzJcgWqcQbw04nqw2zFCp?=
 =?us-ascii?Q?XSlR9NQ0D4x+ERNm4whuUEn0F6AJp29O/8SSkzr1ZIyX59CDB5RIKNsaEEWG?=
 =?us-ascii?Q?Ns/VZMHR5s2CuNQGzUc8vEzcylFzPCgAHVb6bZfm0HUu74zt/95FgnJTGhxX?=
 =?us-ascii?Q?awuKeqCW2Or03/ddjuMLWpnoSapqIpH0V6QsyMA2x2zBqfEj9I3jrs/E9jbb?=
 =?us-ascii?Q?9G6XWQW4m3SeGn/8eegEeg1jGDsaR00IoOpSCEp83RKl+1noZyoos+8V62ge?=
 =?us-ascii?Q?3bWCm8meJa/aMW4AI5qd/oPqkGSLf3VEP6zgAAaIwtq+M5ibNIBknAZ67vmP?=
 =?us-ascii?Q?iPdRLoy4/lrQGCkoWvVXH40nl4wPwIi0IGEqX0eIsSDmtXOiBt54CEPztVmr?=
 =?us-ascii?Q?WVChP106NhPxFuKWhQEph9pOPyYdjphRzjG89HXgjLrBxettuviEOnKZ9H9H?=
 =?us-ascii?Q?E9UH35AYTUAkIvDa7CX+VDSIBSKe2UjSlFrgeyj+dgZbOnzl5uMu8+TIqUo6?=
 =?us-ascii?Q?SdiQP+5Ss62HR/4iZyTMqr6C9HduMBYseG8pzbnUgt5n5OTCjmMm/pXqBlVM?=
 =?us-ascii?Q?wwA5fH0xUlCLJS5/pOBxly5lQ/wW7hxxjHshZrE0O2NWTbaAGP3GQzaP4WTZ?=
 =?us-ascii?Q?Q036MZa9ptxrsCJmoHS1w/BCq9P6848pocxjJiHWRVjm8DKN/vET4rZaa/dH?=
 =?us-ascii?Q?vdPKbr/lgQMvfaEjh8OgbBZ9Nu0W66mtgCqDAcM04pbFbHerlKs+WUGmwgDd?=
 =?us-ascii?Q?nNEI2W1ECmh5xTNr/YUJO7cfKH/qe21VGMLLP8HMmDVVyqc3Jv/QA3IB0tgV?=
 =?us-ascii?Q?ghvRhhdTLADFP7vIz+cKtG7REMP+yuwpaz2nab0QPDr1eNhe9wKCFGiF9O/+?=
 =?us-ascii?Q?yC0GAv0gDE1A+MhTGdolRcG5m9LKwC8Ib8YcS/GDTHZf9ZZucuKZpO7VaqD+?=
 =?us-ascii?Q?OkYUotlACP4o3v59TmxZmfYrj7e3RUJjBrLcdW/Rlj3xIo1kcFRTfofTZ+ts?=
 =?us-ascii?Q?+vXReApz1HjBLJZ9nM+0DU7hQlIfSihhezlu2Boce/6buiD479tgRouQ5bCU?=
 =?us-ascii?Q?HJzbvqPfrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1445bb4a-38ad-4db4-e90d-08df3df4c8b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 00:02:46.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vPXzGvKhKYY1Q/OHwa6OyD3C8Rk4QHoL+fXxMj8r2aphbD/7qVgdrVSAWoyC/XVgtoRsabzEFehoEFu3WpUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

Some test related fixes for v7.5 from me. Sending a v2 as I had to add a
MAINTAINERS entry to fix git send-email.

Joel Fernandes (5):
  rcu-tasks: Track barrier callbacks in debugobjects
  scftorture: Reject empty workloads before starting helpers
  scftorture: Protect the initial affinity check from hotplug
  kasan: Avoid an unrelated RCU warning in the callback test
  MAINTAINERS: Add scftorture to TORTURE-TEST MODULES

 MAINTAINERS             |  2 ++
 kernel/rcu/tasks.h      |  3 +++
 kernel/scftorture.c     | 30 +++++++++++++++++++++++-------
 mm/kasan/kasan_test_c.c |  3 ++-
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.54.0

