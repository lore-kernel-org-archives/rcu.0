Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D725B0A8;
	Sat, 18 Jul 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394950; cv=fail; b=ISjXzkkdo79N1520a5bwz8QFbGFqbszU8yyZjCKnhzKPzm8zFEvjo0Q+6fGDuo/PHBiHnq1XQVqanULk9TAbPJfF2cATeXqTBeFMRgd3FSNfn8RgB+wE/K2iJiketEhfadcV/H08tYXeObLYRquVXUTKYAnnUHPwBo9OLrJcYm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394950; c=relaxed/simple;
	bh=zdqb1GJl0RpDNf2ll0WKrfizkgQ+2REWhbizQEtCYVo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KVWYUHz/vpnpJ+PLYH5rnGQFy979qDy28sYYlR5xblNNtllzHFAtYVIMIihSQmE/uSMWvvdVlNaRq/4yGKuNtJKFENO70ntbPlaYEAZ432/mmi4n3i76THaMp2uV03kZbFT8DRso/28+l5y2H+6Up0rK5MJcTuyta+M2k8cT9tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Is21aXQX; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Is21aXQX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS8xyclkl8KPwm+m31gDX+mfjbILu/Txqb3LS8wtE74VmLdeaFdd8QlMpUlQIgzy/aCj4NPUmrL+LfOk6MwG1jDmsAWfY0gnoeeJYxFL6zt2DF6SwurWatdp7gzDDQZG2oaP2BfAXWinDksK/IcKpb/ht7uK8amvQLHIQdIAK17mwuE/1K+66CvpQ/NG1SyevZmEtg5q4+1z8tPsFekcECn3+/HTiS4ZMevLJDXsvPLE1PV84a8GMzYZPugpNyem2Oe12VnEP86MqcCGG6N8U7HnpSUhMAYFM1ysUOBdKrJuM3E0D0ehTl364Ryl9UAYKtkzUCsZl1noxB3E2Ap/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIIkLL9qVCCnQztmsVa5M5gO6/XWiTqw3wDWj9rGUcA=;
 b=bhayFgYarxYLydUXxaVytlJQZx5dvqLJW3xQaw0qqS+QOTBg9SdQkCGx/X0mBGirBMiFH7WikOSIcMxvOypn21yn3gxDcXfrNgVlFvNGcEfMINi2HK3t+Y+y631EjTsWZHnZPZ8qscVQ0UGgZDf31alt9KtpxoQCIK9pwKwodv6jrm8uMJKuRinY/zV+YhQZLAuCyJe5PicsS6ZKhCS3a8TJFwNale16gxVu+ICXGFR1y3Il8A4E+lvlhYeJb+DW2FWcUb0nV8zLhY0RLG3Qay/wpo5X+M1uYPbPkh9NY0Izg7ku0kc3y8XevIFNv35sYDfDR0BbvTMM8UFLGzP/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIIkLL9qVCCnQztmsVa5M5gO6/XWiTqw3wDWj9rGUcA=;
 b=Is21aXQXQxsTaaqMz42kDfGSlocrKsToEmd1Hob+L8lBWjdMdobH/+zoN9/v4uc8sEyXC9zFmL0ozzxWtO7m41+86Kk06sS6ihYDwdz9I99TTxHqAHLeQpo2o2U7rbquNHymajTeay3XfM5GOjU6C/OZJwWVCtFLFQwnt9nAQGpqeiQxHP0sUPM1kW8KSCTDXi4dbHbJZp4DNCs+QqMJ23JBJHdi0HmVy8F582fdg0ka8SdY8gUsIjQuNQGVaSIURZH4Qtitd8lD0mMHxJo+lJYPF8uVN6YlOmVLS9fh+Q8h726xxpGLuDNTsShs1x3r+H+doKCzCu63DOPLYhm4hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Sat, 18 Jul 2026 17:15:44 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 17:15:44 +0000
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
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH v1 0/6] RCU and torture fixes and cleanups
Date: Sat, 18 Jul 2026 13:15:31 -0400
Message-Id: <20260718171539.3781595-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e9e5b1-61ee-4ff2-5515-08dee4f033be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|921020|10067099003|56012099006|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rkS/J1MJL/C9qjpUVS4ipMMUp3beZjZ9d7H96mDpT59WknOHBkxcjBbiOFglx8kPgGIjQMrc+23PUWlP2n2cIvupTMUmfU/hhfyIbg1DfLF+YIRg0bpkmXAkMwafaHoMfu+VS7Bi56G21A8Jxqf81oVQg1W8M89URdZ0AttXunLkc/JBsSf8M/Z2ZQcxKwf9jMU7csZWy5vhuozOqVYqZDNyBakz5/+i2bS97mxSyveQyNxyn7BWzq34Pqra1zarTjKLUYnPI6kBfKpT81JyhC+6H3DNAGs0xZw1N+Grsw3CZXQCiO0gB6PcI5jgenp75bG2C+8TwIhnEwnjk3pq4U/3GmnpxQqAhgpP4j2utElstRaPKKm75kYNdefh1xb+pUHkgiWI8sEoAoP2WQDECpsjHfLs0KsrszydBWx0WRASinq8qNV0EsfpZffpPsdSHWDhAYCDVdjBnth4bzo7ZsZ8ix+ja0ozDQAqWVXoTbRfnMAXww5HnVcfunxqiioTcPPv3x/trJnWBBPDoSjO0gK7KtwLgI92cfS3EyPRn3Rb3IJ/XJG0g5MbXFlaH4JoxfKHx/mFj487EIUkNJRU3YlndwaNFXSD2IWPpY/u4R8ZkkWcKYlUO5/Y4+yVybh5fT4sVKgkZ05C4mx3F1BrgjP5mOsFDxSMaX6hyMdCa/2YvTSU7sdPPZaM0vyT0H5FQ4QD62XHbhrFwbeRWDF+xg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(921020)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Xfr+JN+vO1B3pSyEJGpD2KSDgcGsLPl9EPIeBmcYxehAVCJ/b3yGXra/osh?=
 =?us-ascii?Q?P4+Phx9euQmeWWuF4fg98NSVv34hV32HcYX+j0nvSEl1qCHpWFIjhEQ6zfTN?=
 =?us-ascii?Q?gepOiWnPNJNiklcFvXASbXE5Q8utkihEuMTBLler0F1v2+2suv6tUKVvKwPB?=
 =?us-ascii?Q?ipdhOVvC8tsI8QDg1GplhYg3W0E4MAK+1BzaBvwVY8nywetA3SxiiCFOOGiE?=
 =?us-ascii?Q?nXmJAEpMFibLbdBTRfNz86Ps1D886Qcnr9hdKBmWNImolLxt4lTNEIF0BVoU?=
 =?us-ascii?Q?5eHFQezrt6zRhffHApPLM/zXOBRXgr0HlPDUygKabAkHS/BSc36C3CPp2s3y?=
 =?us-ascii?Q?L4394WWW0RCKEeyPyCT6GYPzMVGLybbIC4847ESS1Weq2RFhLbFGQYQaJHu8?=
 =?us-ascii?Q?+JJz5fXDDxCLFV+YOR8LHuDXsgB8NX5/+sV81a49q+aQ1vkIRyoSsGQsOWzv?=
 =?us-ascii?Q?hzALphDxzsvMrCyLSDxqapZSgHLGN1+D5UX5/tTDH5W8cYwGwAiAvvkYhOeH?=
 =?us-ascii?Q?5Nnooh+HBi7DennMBioWcPv6ESyCs18NzkTLnDa4Nro0J7MMwWsYy9xbmBMn?=
 =?us-ascii?Q?HG+To6BE09Fc7FYDa6oMCuXbwhXwZAXkf2y+908QxeE1TN92Fkj23o10jFKt?=
 =?us-ascii?Q?5QARlVumTOXWUMph1zYVFzwZvH3VtUmIlp3YzEmUZaXoDs4wahw1GIK+8tz+?=
 =?us-ascii?Q?py4iK4r430OXC40viUiArasv5ub2KBCxCcbL02TiSyHVRv69evxGVQqVIuxn?=
 =?us-ascii?Q?UmtlAsMzCwdFotJAFvNQIG1QuSGRyu4Pt2nZZ6CPBqb2rLJlKLHLbvYu6H+F?=
 =?us-ascii?Q?SdJ59qlrKwbrhAy32CeK9pcL8Kg5+vGv7peIuBulhMYmThaYFwsDVkrMivQZ?=
 =?us-ascii?Q?v9GYivSle3JdY9fi+lrk5jvRAOQesS/n+8VRgPfmmdgfaqGiHMHbwE54Cfhw?=
 =?us-ascii?Q?9+QG88D5OKD8KAwAw9pVc6zHGaO4EFECOuTOmcbSNmBuRPaz85RmRrWnQVwP?=
 =?us-ascii?Q?TCZZ02Yq0xp1XYF4Cdifw5sBIfybCQCQ7+ZEXeRjRYJdkYVe3HRDdjmH+qYL?=
 =?us-ascii?Q?hk2GfJwi9A1gfvpHO/luXzQKym2pi4d5QEzzenYrPuHukpR2UmWJHuyrKwp4?=
 =?us-ascii?Q?GCrizBcbb1oOMSYJl7/uE5EF/Xoy+NFqjS7gacZdWhPYFw3MUs6hFdX9K201?=
 =?us-ascii?Q?ZswJ9ld8tt5mxZQH4xLjqymoRCVhLVIObyqU18rSh7eFeGAXeE2xwYYlEa/y?=
 =?us-ascii?Q?Mz6/FhZ+wm4PufnPOCibZLUtw+hqNrSKl1Heg0TrSon2G7bGPMTovZ8zvoUQ?=
 =?us-ascii?Q?vDgl9zaq158vzV7Ryqzlp1meiwh4AzfRA4+eW3e/wTH5ggGpyFQZuAmWxmKX?=
 =?us-ascii?Q?MhiRTgv6uT6W4aPSi0mr1HwPc+RMV9QaZRFVwIZTLjwG6uyV6ZnqB17BenXs?=
 =?us-ascii?Q?gwbLvKSBwACMqEKH97ZfkRMw4t9VTojDIhwSj5yERKcMljfr093jruJnNaaA?=
 =?us-ascii?Q?+7+ctbp12ula3xs6YTVGlQRrKThKkpZIS1nAHjwYWYkKMeDZrZ61CCFqDciq?=
 =?us-ascii?Q?iCEHLKt4d24B+Gi8RcZV7SGa0kZ2WfFKXacYQG/9y4MXLn4SWUGOGs8EkiuO?=
 =?us-ascii?Q?7ClnyygBFE+Ql2US/gqnviee9je3AIECn/MdNoV0MpXzyxDefXRtd5fOR/24?=
 =?us-ascii?Q?cQzKxFQXfFwFf1MoUGuTMxWrrCnZscJMM1TdKygp+Rw9evRyd+4UzfHsk7J4?=
 =?us-ascii?Q?471Mi7SWJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e9e5b1-61ee-4ff2-5515-08dee4f033be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 17:15:44.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGG0F4B8nqWvgQsAWh03ph00Pipp0obyMOD97GgLNuhUp3hPohlHOwI4DPnN5+YKQzbe8Rkr8FM2wIoH5q0ZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

This series contains miscellaneous RCU cleanups and torture-test fixes for the
next merge window. Tested various rcutorture and scftorture scenarios.

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-torture-simple-fixes-v1-20260718)

Joel Fernandes (6):
  rcu: Remove unused expedited_need_qs field from rcu_state
  rcu: Remove unused rdp parameter from trace_rcu_this_gp()
  rcu: Remove unused func parameter from callback-enqueue functions
  torture: Don't leak shuffle_tmp_mask when shuffler kthread fails to
    start
  scftorture: Count single_rpc offline failures in statistics output
  scftorture: Make invoker threads actually wait for all threads to
    start

 kernel/rcu/tree.c      | 33 +++++++++++++++------------------
 kernel/rcu/tree.h      |  3 +--
 kernel/rcu/tree_nocb.h | 10 +++++-----
 kernel/scftorture.c    |  3 ++-
 kernel/torture.c       |  7 ++++++-
 5 files changed, 29 insertions(+), 27 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.34.1
