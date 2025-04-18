Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96A213E97;
	Fri, 18 Apr 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993250; cv=fail; b=dqUAzLe7t5swqWmVzdnWmheKg63zk2Z7ZcDI/P/cOBjd1lPb88oBwJeLcXTaSEei8eyE5HBrEqUGTZO75EM0PfdX9dUmuvY637ctfTGncFW36XyrkgbCdOWNUTdtP0BMq+1d7yxWy7h5NqA47/4PUyWuXPf5RXzKKkDIRImKFj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993250; c=relaxed/simple;
	bh=pY/ZYDnpQqa2dBXascNjbBU8YhkvTh9hrRL2f756wQc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bmzRoovabBnwc1IYPXQniaZ7CarOY/gk885UiG/522W1lXcCrRuGcx8HaB0rEc4+9Jsn1E1Tqj2smlrvimrnQxFV1lT+FDn66ttNbzIJ4Fwks3rRdDkZVA2Z0tIq5Je0mTxxgunZ0dIhIfbYdv6/anilmntd0M13PXU8Df/0lLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhMcc8v4; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhMcc8v4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIMlgYuKzJEu5upowqlJ09hkw3ImZ9mMIzEgVQjamb9LM+OUbqL0XP7SUA+RVQC7EgpZactfwA0AXs7Q2I76+ed2d455r6MsJ91h+8syoqE1og729M85/nNWpdRBTKQDz1eXOdeZWM1DIN0ld+NxTlyDetTuAUl1egGT2oLRRWV/1Kq/QgbCkTXqy2TfVOD83AsSZZghMrqoWUnWMV+GFql+SW19MwUUPBDtDwuAnBwdTslisVQpErUHDNYMrRgvHQ9LSJyKYClVDJD5I/MS+2q7q3+eSoSQ8gcvytySXovuI5wygkAayflnzafwl6WThJeetax5/5Kz2Lwc/++HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=918TkvPSZUVBJhOM4xTNjydI2fybwlT6sZrVCr4bwyQ=;
 b=ohy00ry3V4CCNQSRuuhuBaor2PV6GAOH6s5n7X0hGsMeqczJRchWlo03O++iUbe7JQIA9xeZ1S65Kmw9EW2zBvUvFl3Sb+LimvD5IQTAb4qLYUxgKTKBTAX93Gegm2gU17QX/WhwqHZV8u3firwqsjPUCz3z9j4VLotg4/q5LdPLpKN4mn1peFYC4hxeGC+53g9qUdJak2eWEJJ1z+gG49lOhc171xT93qF9ilsasq2VwlyeJCE3Cuq0Y42MwYqzpvZzWzEaTOCpj6jCRUorZjaBUaiuQ4ajTaAkHOk5U7mH7Lu8ReSQ1E57o0w2wL295/y5h5hEiEa45DVLpYBk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=918TkvPSZUVBJhOM4xTNjydI2fybwlT6sZrVCr4bwyQ=;
 b=OhMcc8v4edMgRxxOsMpnmq3bfI2Sldo8Oqk9IqEckz7YQbIQDQTabX7wn5gtv+ccachJ8bFYnP3/ENlC2DXQB0s4Ss4rsf2fGezs6NZxCRvfe4j6ZTl8YYao7ArokPUZfVYAYrAiB8LkIW7B8KBb2S1TsmI1kvyXJ94/IXt3OxpUkr5IfnMcTTJF9eq2O1/XQk39v1jKbSGAsHLjgPhmqF4p+hIZqKL9dyGkLSftCMmGjHJ3A1cLHwA4SyVwgAQTucMTA3SiIFWLKxnZgjUe2uAOgBAVilnOn2/b5uTuDrR75C67CMVMXTR/ofi/0VS/d+xxscBlRwJanjyUpF0rYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 16:20:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:20:46 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 0/4] Sequence counter related RCU changes for v6.16
Date: Fri, 18 Apr 2025 12:20:36 -0400
Message-ID: <20250418162041.2436282-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 88020e77-f6ca-4e46-fa25-08dd7e94f9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6hxXLeQEAbAmejSIsuPMD23F0aRTmHdpaw9NWFDzfbl177pDNT5La66ICmn?=
 =?us-ascii?Q?kRbG0emH5wZSMsLUxJFyzjj5VDB/vUdQVhNDZgVKRvBoKAPB+biNhLNIPiLQ?=
 =?us-ascii?Q?I2fxFjjY19qBbv/8BI6m1igFYTL0vnWBMjF1F5pyWWA2/RL0Qr9r3yMkCfTx?=
 =?us-ascii?Q?e0l401P9zqbAqnsCe+b3mLG4ohCw2Wu+YWgVjBPUMF+0OrX3I5SV0284AnOg?=
 =?us-ascii?Q?sRxAaxDuxzvZ2oJNh13o6MV8o4Zfzdxf9Oy4yPhK/TKt1u4jgqUOQB+B2uyj?=
 =?us-ascii?Q?TBTYV33ufH9SCedOzSCX+eBuF5ule2djWBXz/a3yeKG+NN7z+QtVcyaGz5JB?=
 =?us-ascii?Q?d4007Pr6GyHSHoDfmDo3GyHOoj8gl0KnyR0f51Jr2/Tgcpk4hBbiNnBl++WY?=
 =?us-ascii?Q?L9sCCtcSGCPRrlgbSml62UH8QBBMksOYK4FalCEFVx8z9ZgYO/A9l6mm/x9G?=
 =?us-ascii?Q?tmqbrsJGg1wnCr4qwVHTrU61FcnLQnCJOMWbPxHs5GqvgQGQixljjbsZZJr5?=
 =?us-ascii?Q?nMSuihQQ4RisaLPkFHivTruLjf3I23/+mxwUAy850+GU3HVO+ur/dtL+Uxei?=
 =?us-ascii?Q?JzGKm1XdiKjwsz5xS565jqMljAv5rr4/2d8T+L78VV/Lq+b6LkQNK0HJY2gL?=
 =?us-ascii?Q?V8nfSNUea8e5Y+fgHaphhfk2UbvYg9PbWOYWcApp/X11+cItSDwwKhJ5YwGY?=
 =?us-ascii?Q?WOmVwN241x1vofYWytKcivmU97ZZkYlaJ22BNyjU8i1B3fKVaChj3ZNTfOKH?=
 =?us-ascii?Q?ypVumbVlJQSPeK04yMTeSp4wApP2GTJfOdO8z4iOF4PWILNpQvO2cNjpQ2Ld?=
 =?us-ascii?Q?GhblfFHCX2V5c1xjiD10VuUySwUisAR0bUTi3HCWBYpTlYT07IMnuUSYZYtU?=
 =?us-ascii?Q?ipwDR9l+/ttXLlqLIJRoY9kp3bv9B7AiECEgeY5Op76NhiM4HKU2Z2c+s2Tp?=
 =?us-ascii?Q?1TzAuYhzeP2AtByulPA3+BJWYPwSUChAj3cMiat5Sc8a3PdoarOj569d1LEC?=
 =?us-ascii?Q?8lPT/5IzRHzgjL3It7sVDBvxBXmhaYIfFkJnSlibt13HuTSl0fjDqAadNddq?=
 =?us-ascii?Q?RcP2ZmolD70DGDvtl844a4zjPp4MLgGGcm0zcZYXQzp/ptH3AFGwB92oY35g?=
 =?us-ascii?Q?c93F0Tjlh9q47Fvxc6Rci0NlRGPhrbone/SxmTJRtd8i4wS7yMrEITRPUbrC?=
 =?us-ascii?Q?gFP5Twu8WSrUljcRk59RlOWl2/S++obr1+sq2cseqEi95ccmD6sA66GJiHOW?=
 =?us-ascii?Q?BOicT6KPOefYzfmGeAdyeoiW81UoRsNJEMsu936445fbLY8nPJ53Qr+jzkVq?=
 =?us-ascii?Q?zlD+yZIXR03324LvmVhXgaBzSRCVuoADN2tsN+KfR7Ahl6LBFgzo/giWT2vi?=
 =?us-ascii?Q?oC60clocXKx/zSYVNOrndCtPzYpb8kWfeUoZXvUgQ+OajNE0Yl8mreVIe5bO?=
 =?us-ascii?Q?YinXFsYyUQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHWtg+kC47OdipGR4Fyj866OR3zsx5krKWcsoW4W7sSDq2WFBsP8DxAL1P0J?=
 =?us-ascii?Q?K4f3dsRRLOMO0tO9/Ra5qTub7d2giNN6VrogdDL5klnPnd6rXCvqDh66htdX?=
 =?us-ascii?Q?fZQA8wgJXBaYa9IXX6fA+SW/tOVBRwCPPiSkzFGffcER76nqJR0fQr8UhquZ?=
 =?us-ascii?Q?Z7ub6Fs8ENwW1zyzRvrYkZSS+vxNnNlNfz0ajpRZsBvUFvu1gxuaaAiFxwTz?=
 =?us-ascii?Q?5HW6/LPQ07aYfU6UQtT1ECoNEUPFCX5bD8JU6XQEir5brQRPVg1J1ZxFBhrE?=
 =?us-ascii?Q?xvBMThBTPpLpxX1acoHLrjOUUiQbOsyTZure+H/29jUskJ5Vplxsct5PPNZK?=
 =?us-ascii?Q?tLyu7GtFhcsxfDFJESebWi1zevx1Vuvqa1zj22nmWYVJNStK4xxJHLt0Ir5v?=
 =?us-ascii?Q?uGzToIp1Eo7vojN+T7gS26/cRO/zSlrnOou1J8k+EjZ5WCHX9dh0BVy0noqH?=
 =?us-ascii?Q?Pym5FdJDcq+Pqtl1YQS9/k+7+ZDnqjRYB8zShDT5VXg0JQSc6bWpvd+hbyhQ?=
 =?us-ascii?Q?OlcF8fkKwQDjpTqq8vOO13XxdgdikAi7/B79nYhvbfPZXUmynUSyI5SMJZKW?=
 =?us-ascii?Q?pClneV15SZ5EC33uWfuIgwfALxeaO+BlW0a5x7iY+aAUYKN83Fa7OehQh4uG?=
 =?us-ascii?Q?UH1B282jpFhtuSPSFlEWK608JKun2l7pzA+Ovz8ZNtmUeWG4mGVOEndPSKjR?=
 =?us-ascii?Q?tWyFWAONVHRYiy2/hBrunWuz2akqbPqGbdtUimGgclXC49Zugejah01I0OwH?=
 =?us-ascii?Q?dMDCgw7XcV4fmq5ZeF4xJ34eOAywps/RR9jhHtpstV9zhg7Q/aSd/amO7bo0?=
 =?us-ascii?Q?0ifyvdHnzD//VIMQ1Ud1ElkXOv8QUxwJGAEqCOqfWGB0O5UyUwKDazHhv+au?=
 =?us-ascii?Q?f/hYmlkCcvukMFKm7C0IoAnAaIOHdp+M2wBPoEma3xMmlWzeXWgKWDboFlB7?=
 =?us-ascii?Q?SvS5rkBktQaOpayA/DgUJV0UiVAkGp/gRJqEu7A859p32y0FZwwL8SC+eit6?=
 =?us-ascii?Q?e8cAmhRSOjsDFj8FLUbsxQPItRA4KbAXE8o2+PbNkfg67qaj/a989MyCdZA6?=
 =?us-ascii?Q?RckvoSrs31ZDVyhRp1Ia0ntB0fIjsWpqWDC4BFcCkEFhlWPxHmtNSGlcPdsu?=
 =?us-ascii?Q?j6fyLgBkiQA3XWzPY//BQxCKKSgbtDJWaDGz/mvqDhYlcPAgXm5KxYKL+ku2?=
 =?us-ascii?Q?nLpv+eJpWw6GQm8KLz7lHb7/7PMFM65nNJB6FUg3Z7E9ON2V5325Pyhj1bTO?=
 =?us-ascii?Q?Ck+2Pk3s7SAuznLw/51d7BNAAn70fjeeVey3i2VzPSoab6xXh2maN/GjTzxU?=
 =?us-ascii?Q?or5Z+APMYpVKm39xhs7Wrp7n8j2TwKxiSkBOaY50HuRDey+8CJocfbCNzHjs?=
 =?us-ascii?Q?qxj+/qw6M2GzhDbXk5434FAIz5Vb42FCTHZCBgZ4jEdRa1wErfbr7n/7YWkQ?=
 =?us-ascii?Q?Ocvfs37PGd2wWg3ONR8PTW9DlipUt+uCKfKOZHv+R3QzyR6zWIM5MqEUam7v?=
 =?us-ascii?Q?2kxn0HXR3rNw/Ju8rxzb87x4Zamap30i7Vo9xVtW8XeDRtlj9MSWm3axF9W7?=
 =?us-ascii?Q?4kuZp5ecmpuKf85McNPLXcaw9HB5cTZ7wV5YKqCG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88020e77-f6ca-4e46-fa25-08dd7e94f9a5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:20:46.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fofqbflfE1c/y0SC39598sq6z0UqNbJ+NTjCVjdkDIS0PmCTcasR8go7Yg+5EXxr/j1IgH7YEGkTIsqXOaxJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

Hi,

Please find the upcoming sequence Counter related RCU changes. The changes can also
be found at:

        git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git seq.2025.04.18a

Thanks.

Frederic Weisbecker (1):
  rcu: Comment on the extraneous delta test on rcu_seq_done_exact()

Joel Fernandes (3):
  rcu: Replace magic number with meaningful constant in
    rcu_seq_done_exact()
  rcu: Add warning to ensure rcu_seq_done_exact() is working
  srcu: Use rcu_seq_done_exact() for polling API

 kernel/rcu/rcu.h      | 14 +++++++++++++-
 kernel/rcu/srcutree.c |  2 +-
 kernel/rcu/tree.c     |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.43.0

