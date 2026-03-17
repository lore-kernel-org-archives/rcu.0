Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F1396596;
	Tue, 17 Mar 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782613; cv=fail; b=UCF7+nESF9O2gYHtB/fymuzNv7oJWuUPCLnmXN0AdmiKEN7rWoewwNsIe3epfCUG5eph7qK1ysvJLE6WURNSLO2KNAg+p80lcxA6MehQ3yrm6rNS4xTb9k/22U4Io5lAkYTz/yMO5hzrRoeudZ/ZNdOc/oM/yYOI8s/jrcvTmto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782613; c=relaxed/simple;
	bh=9AOfnSliWPNr9gpSMpen0co4PlQSIXFnZyBKx+VK5/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uG25vIXiU/6Rkw2BiqMh62xAOklNIRoeVK29XE084lr9p1cqK124RmqG9RS585lmFb7F+HUZtjM+fVwb7wdzy86MQZDFoKJpp7OBj4ashzuYIscHFqqlIYdiuCAnOzEmv41htrYwgDtik6yCSeFnrc0pIrLRgPzRKqZGV6Bn2Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yt8pm+LC; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yt8pm+LC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C37CzEUvYJEIqmJZ6mWALfgNcVPqW2vB9UTiwYTuotX0U5DD7zUv7SYiiRyASuBptr6GoyYSoWZXLjoBz2/DeodjDdoFXPmW7VzshTBPqP/0zwe7aeM37/WwFuGHD0++UXjtiapwbQToBea1HRF3OMcDOmCmUzkeyl9qfUoASCiV7X6WrnA954xYd7f3FmG/1IrcOblEeakJ+FmXKUnKH50Z29CxAyrXiIn0Ev4gUS3tLpgkqeDOGPZVLDji9ZCo7rHxNLNFexdIrCFQ6a8Ccecp2uRSp7j0jPJaPeruHF9xm27yAUeRO9Q3H66zB5x+eXfksouHgTHkTOaN70x77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yes9JLDlgtMWFK2j3ZMA+IpmOshOVuQMo4cm0+ZPnLo=;
 b=Sf7LxwcjMC965S1BnuVv8zKhbEKhpINZe3nHnd7FyLZtOExbMjzLrR6N+/O93Q4iemQUbhCINfXf0iCgCwp2vK6/80Fm/X0jeeCP5y3xllRS88zVae2jZJzSXtltV0F+pAMRfeXz6Kx718YHeCwEJeDhT97Zdbn5bfFZFEj7ZVrdlM9MoCSsmsEy2ZYfyf8rQQvVi3w5r0QTp0vT0z9J5jSrP73iOwq5WMGsGENAzVXTdqnk6DzvQHD/lj7Y72Ko4pFUl4SQAlRn7ujMKJ+/RRWWGWJilvaesYeAvGvMjMGAzkixklpcBfSQf60kHQeVgkjEC7CupsSBrslUuDARSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yes9JLDlgtMWFK2j3ZMA+IpmOshOVuQMo4cm0+ZPnLo=;
 b=Yt8pm+LC7oOrfUa657LEPGjgi3DFdszVM7+97AmkxNL3JtVYtIQG9MCqug15MW/KOXULvmfWxEo/FAgKaxQaQKq48d4UV8aCVBRbPhGCceGuXPfhTE9/Xn34dDAsRLCFweEK0qUEFjb3KRkKeCqBY6M+38GRR869Xa1clT4qXasBFXWDiYQY1yuYQ/VpIHfY//lIptlpRQR5xQtpwNJr54KgPsCExw6STXtiaG37lWIr280kbTH+6kBJHeVz3IZJIWqRkl4+nYr5Bgvs71jKjk924Ma63/Ke3k7F49wLiju3SV4kgYE1D80C2JthGfO0H0lxW6erUYgdIRDFoc3TIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:23:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 21:23:25 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next v1 16/16] torture: Avoid modulo-zero error in torture_hrtimeout_ns()
Date: Tue, 17 Mar 2026 17:22:17 -0400
Message-Id: <20260317212217.1527644-17-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317212217.1527644-1-joelagnelf@nvidia.com>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0010.prod.exchangelabs.com
 (2603:10b6:207:18::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: cd62e556-a549-4ec0-044c-08de846b6c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d79oeb23moLgH0+MePbc8VFVFP5MdmtIikY5wH2WXlHIsxoywzh5HRj+ZJdWjadOeL+lIVbs14fkVLzljznJQjErq1isJtUD2DHFbxhujFNJK8EWOJlcvcKUVUMuT2qmnzoy+aGQatrnwiiC+wIC33yJJVjO8Sap18pyz2l8mE9j1hJybFK1+2CMBfdE6bK5fzJnUi7L7SWSpB12LfLaN00iOAkvjmWrV5ry+wzXwymrgKLBzgjj3DatJMPRsy6AimPmFD/et/+P/sjrYsDt/c2mhc5uteP2DEGHr0Xn9tFWVsIUX4gGSOWtU/LVEj9LU6fRyi7AJx2vxrsAhZe6Bd6kQ2xf5Q3ox1who6w9y1LTqWnyrk04ipBKAeCXDQylDg+BUsj5/3pGgP0kG1THxvXHPQHx8ZakY19n/QNAprvpL7kYYPIB335WxQRPGyMdkW4GvSDpNphz00Zyw1+MSeAiTF/9X2mKZ/HkayT2rlL+XFB+TF3/PFM+tRtWqq98KAtDNgDCuEDj7uSv+qUtW0aNGdT7y+G3OXhbxH3t31PSLxb09a4pga+z2AwutvmpCfoo83zOCcGbvKJva3W1R9Xs5jyK6tuW98CfQQUORR6Y3N1sRKbShlWgzixzBuFOcVQM1FUq2WtuibgWMBdY28ITLrB7W1IxaKRi2x2SOyVRze378UKwn/O/suKPncey4dtkYGkVvZUYTO1rkeNTv7AWwk9/xVyR0TAzFgOc7Bc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCzX7YZ00n0swNIT0/qsbSzgHIxKksjDMQf+Vv5LVG6+wsyMP5p9Ls45S1Gn?=
 =?us-ascii?Q?6Kv1rL1Z3tqXzfiPPs8O2DeHX+Yq2sFXp0IBPRhr9b3QdlDlTmE0Trix8reY?=
 =?us-ascii?Q?onoYZ9DSOLxsNl19JNchlg3TDFQ/JWkadX1CZ2ZgcaXUeymYqKg9wkivr6uh?=
 =?us-ascii?Q?lkEqcy8QISgj2xC/y58+zZLbA2OQPnN52qQZI+eKN1xQJSceUeStfr6s9jmR?=
 =?us-ascii?Q?FxkOLwjU8poqUqQFN0euC9VY9PbfCjMTSGUblcLaDclX7Iln2PtGaZJRXlTs?=
 =?us-ascii?Q?xxM0kS2MWeweaZyjqWmn5GLYQxydohw5nxmYfVmVGnUavUzWQBFH+GjEAfjt?=
 =?us-ascii?Q?QFJzA7MxjGfv4CiBNjO0CkDY4lvMhGVyAG1D2fdAIGmTcH5kAQCGg6b2VgCU?=
 =?us-ascii?Q?dAkh7LONWwHb9jxa03ETcWyFcYS7KalqXO/M6Dw3b79/YKmAewTANANh11re?=
 =?us-ascii?Q?OUXFXZDuCrHuE6cqdEJBioCyz7uPtfTIUNoqBG1KPgPtxBfR8XEhpJwSih7u?=
 =?us-ascii?Q?GO05iYrT/CjXGpDq45gzogBKB0vpbTvCvnMJlhYFtmL1AuJTQ7CgATRO7OPH?=
 =?us-ascii?Q?NBPW2pCBdXw5xIOlhemVM8EwDCfteL0jfzY51fbqY+9bikmc8JaQC7fgni7U?=
 =?us-ascii?Q?OpVH/pzsp39j7jWtmINnEvcV1s9DCwlND2hQXXf9ntNWhE6ml4TrHYwIhZ8J?=
 =?us-ascii?Q?Ltr7nxkee1bQEEf0L3035v1k891A8bWfWpJbdCcZpN1lxECiX36/fiLEMLZH?=
 =?us-ascii?Q?fGltx6sX2Mh3gtoCa84DFwF0Q2DPK8qeOSNGVZNKokckHhAR4vHqxVIwlMyt?=
 =?us-ascii?Q?WkSslzo8pDDQeDik7tKSfxe5xLq9xpYTactgBw2wJPRJ01TBIzrhBO2QqTWF?=
 =?us-ascii?Q?NwAAv5nTC3jj5y4nlNPhx8kHZg8VyGnHc+7RyRmMqc9gpwupBthlv2ywcI9i?=
 =?us-ascii?Q?qn5ogY+R5oWrSxDu/KhX7pa3BWa2GSrP/+DRj4STrfGdqqmwZUUw6krouasp?=
 =?us-ascii?Q?6hWslq9CPZEr0dZNZKl3tmAIXahKhspYR7ZNKWSLqfzma19tFWF8QAM9qhBY?=
 =?us-ascii?Q?IDlJKAf91qPWwFpWcLjAmPHErTSywYlymTppgjj8XOMKDti10khmOTr4psVT?=
 =?us-ascii?Q?CgLl0wxGwN2LbxiVupgSAlxKvLNN/sM2NC/omOOGB1yZyVIs38EpSLpEXcNZ?=
 =?us-ascii?Q?8HxRUX4RR62w4RVepCvPm03wtBnUOWs7J66Ixna3Ta52UMwZszx5CmDQplKb?=
 =?us-ascii?Q?1M5VGo7KtKviNYQgXyMu7AMq4Q+1A/4+mUlAFpUw11vN7fsN81WTrXz8DpOe?=
 =?us-ascii?Q?XuYL+HK8oU/vmypvsO4NpPZ6NYk/q9qVHBx3X6meSAkeIF/qGD0GIfkQkb79?=
 =?us-ascii?Q?07ikQT2lPu4oF6mhaUr+BLS0SypchsDUxqzyt95doV0kQHt4zzoF83mUjB1Q?=
 =?us-ascii?Q?zWd0KRIittaalaW3FbDCu5tzJHG4oSDr3LIeM43LT0aoIMUnO5Lnz3oOd4AW?=
 =?us-ascii?Q?3e6Gi1rEtrG/tsWcoab8WePko/yWUMjSTOpFz8mS1+J0mhAq3T2qMtXR5YZO?=
 =?us-ascii?Q?vPhY9Hd8OoZS3xmwSJZKLkIRGG/U8G5ZT69uC6qSuLWGTLp7jzBO6JmMYcZq?=
 =?us-ascii?Q?8AeGq72FiR5hV/PTjDWFwlVuxyEqelGnkxtqLZd+p3cQpM059kBZdHGueR/A?=
 =?us-ascii?Q?2mO7TnaFNDQ7J/e8sqdrG1yKrNGyNrC4/O6kWqs4mH3mm/uumXGI6411SpGg?=
 =?us-ascii?Q?QK9YMIgm+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd62e556-a549-4ec0-044c-08de846b6c70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:23:24.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MO4THYR1pkcKSGTBOGu2QW8U+3R6difnxpy1d9vbqvXLWJgHwFaY/yxD9FoRIYQiy47fDhqhENnaTkHCVQrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, all calls to torture_hrtimeout_ns() either provide a non-zero
fuzzt_ns or a NULL trsp, either of which avoids taking the modulus of a
zero-valued fuzzt_ns.  But this code should do a better job of defending
itself, so this commit explicitly checks fuzzt_ns and avoids the modulus
when its value is zero.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index ec3370986976..62c1ac777694 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -93,7 +93,7 @@ int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, const enum hrtimer_mode
 {
 	ktime_t hto = baset_ns;
 
-	if (trsp)
+	if (trsp && fuzzt_ns)
 		hto += torture_random(trsp) % fuzzt_ns;
 	set_current_state(TASK_IDLE);
 	return schedule_hrtimeout(&hto, mode);
-- 
2.34.1

