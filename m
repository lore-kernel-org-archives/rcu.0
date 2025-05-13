Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC420FABC
	for <rcu@vger.kernel.org>; Tue, 13 May 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137436; cv=fail; b=A4RAStTUmpli1B2LvkYzAd37vCO2hdvq0LvCli8kJf3yIlUcNYaDi5NOrwE/5Ou8DJBYHhB1O9p1Y+1UTq2Jksgyqqf4koIkakZeRloiJvSmARXM0lJX+ghJAVnhJXl6gzbZLrP/O1VLRx1Z9N5XPKSyVnO2Vma/YhvSUbtJm7A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137436; c=relaxed/simple;
	bh=3tXPGeEIkwhvqEqD1ApHoEMu3jduE3QJIu+KVB2jaaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTkFGWeDHA8VR4UHuSUkQsQlhsRSZIJlghiZr2Xk0jJzvpgzFfhjYEHaZ2By8xEqFKKuv0I0OkDVedVjct2EbSxbzzOOojqpBupozNHVU8npLWoXb0aiRJ1UEkPfI/SJ1ShcV0+66LDPRRGaRbo0fU2k9ChJyQLQNl/MbkQw/Sk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PrH5N6NP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PrH5N6NP; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PrH5N6NP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PrH5N6NP"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cIRlbYMgbRpxRCepUJ13KMUGE/tS14UDwQYIaf0YRBEPVBbnA5n6/1ziOb9SG7Hd+lfS870DllTV05K2rRBvnFRrMOVsQX3+ALApHTSMODxj/iNEAM3OqI9ZDh9eLWfCK5jNAf3P2XYau4hdWb0FUZrMiDUi+3GfBys2uT+G5qUOQnpa+Obgm7gxXukIPyBm3B0fEBKT1jaNz+yYpjeKr/1m3dva3x5zEX0pWwx1XvVXIkKePjOwVSJs0pQ1z0j9DjVhTF0pbHPZlr7cs26ndoR/RoNP/jHEzBF4QNRsOe+YcsZ3Iia6P7jouXxxkWcMlK7LVNGmTAgexzWslWK03w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGR9YmemZ7oH0mYb51CV46oREA3ZeXlGvS82gbHMzXQ=;
 b=KHGzlL97AQryecpJnKLBANcv0UKSTr4ZJlzje75Iont8waqm9b0JZcNjGM+0jEKGl6ZG4bR15gOME/K4C9ErsDucjLsY10NDddlr5Usjs7OQ/XFv2B2n1bjEo1rzr33Hz0nSyMOJC63vCTdLkMe+8jVvA7ViX+LLbTiZUaq14bKdL8MuXFvKCJe5WrD3pa3d5+j1IaF6IcK7GTBbPM0Y0ZI4x1b3ZGQWjnxb3yp5Qih7I9sXTTRGyhKmwaGlhWNZjKnwb7SsKXnlU7enLFb18ZzqPlMyZfx+mu+npZhpNfJxV2m0NBsrnd5wjGVrsM1wIV1YtBv9kZEQRuOScBLKRA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kzalloc.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGR9YmemZ7oH0mYb51CV46oREA3ZeXlGvS82gbHMzXQ=;
 b=PrH5N6NPiufwP11nBUIPFxm8uC0Bb5kO7Ed1v20n+2wKgALAeROH3C8gbdHR8hB5VPFyRNHCK0FnWxGflRwxXf9KKu7EJKZQqR7FgG5GpAGUHV9V1S7pGvZboT0i4tuqqyJdi74Qp3AYkhBDJwyhdFOZEOiWDg7IGtb1bolcI/I=
Received: from DB8PR09CA0027.eurprd09.prod.outlook.com (2603:10a6:10:a0::40)
 by GV1PR08MB11179.eurprd08.prod.outlook.com (2603:10a6:150:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 11:57:02 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:a0:cafe::1c) by DB8PR09CA0027.outlook.office365.com
 (2603:10a6:10:a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Tue,
 13 May 2025 11:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via
 Frontend Transport; Tue, 13 May 2025 11:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs9bpZbTBVQjm8uWr/WnwCDa7VjPMQMc6ezqLwharXQoIVLFlCDlwLJNovEoKeuaOvFqve92NUUtxhfZOVh+HxMb1ucXw/4JC1OH/EBcX7NBe82frEaclFo51PIMM34fvCJaQplZrtmcNJ/TjVnhXGyM0ZlAqtvsK9+XVuR79tp/ABStqr4s6/L96DcF+b7MyzVuU14OwwnWDh7bhDSETBBSExcNqDwC8vXElLxwn+rGN56ozvjovwVsH3oUWv2+rTSFtM+FhA1R0Ig2aEiqI/bOxUnFuQnL1AL+CixAKDTO/4gTeFKGIq0+43UQXKUss4UJ4ncr6ZjVHdRuL0+POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGR9YmemZ7oH0mYb51CV46oREA3ZeXlGvS82gbHMzXQ=;
 b=PA6NlyCWLUPFkYpPjHmIu+tYYup1HVdO81TYq8laR0AGMkVrmg14vFG2Uppcdsn4Bs42tsATgXzZ9t+Dm43pa2DuMIQeR36rMmH2KKyIvog+/PPkEgG9O4opDXKgIquy9ZiizNB0/wRa0KLd0g/Svnbq5SGq4YNzRXqDmK4zJxyjik5J+X6lHT3rs5TCfN4cdiGzhwG4gLXA6FT/psSY3N4MT8KPYUVI9oInDjYv4qxaLkZWGoLIOLTpRW9QYaGm4SO1K4i2b4yLkX403DaANgNM7yH0PdcqBSTzaHXm6oWg7V0Mr9mBC8Rt10I1tEgTUZHw32UXT3rMmBqneZpaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGR9YmemZ7oH0mYb51CV46oREA3ZeXlGvS82gbHMzXQ=;
 b=PrH5N6NPiufwP11nBUIPFxm8uC0Bb5kO7Ed1v20n+2wKgALAeROH3C8gbdHR8hB5VPFyRNHCK0FnWxGflRwxXf9KKu7EJKZQqR7FgG5GpAGUHV9V1S7pGvZboT0i4tuqqyJdi74Qp3AYkhBDJwyhdFOZEOiWDg7IGtb1bolcI/I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10730.eurprd08.prod.outlook.com
 (2603:10a6:150:162::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 11:56:28 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 11:56:27 +0000
Date: Tue, 13 May 2025 12:56:24 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, byungchul@sk.com,
	max.byungchul.park@gmail.com, rcu@vger.kernel.org
Subject: Re: [BUG] RCU: Kernel panic on execute from non-executable memory
 (binderfs + stress-ng)
Message-ID: <aCMzaBwKea98TtO6@e129823.arm.com>
References: <8bdfa4fc-0e4a-4965-bc29-6ab6c1573ef6@kzalloc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8bdfa4fc-0e4a-4965-bc29-6ab6c1573ef6@kzalloc.com>
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10730:EE_|DU6PEPF0000A7DE:EE_|GV1PR08MB11179:EE_
X-MS-Office365-Filtering-Correlation-Id: e08cb86a-a028-4a07-095a-08dd921544fc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?okaXDpiVYpNu3hFfNfmfmmDO2g01TE8erXN2GoWd7mZgq765S/9mZwXpTLHF?=
 =?us-ascii?Q?RhyJaKSKOHOWtUV3PSFfy/U50+pOLnvoE/qsU70j3kGDfkcEzWWtnR4mkClu?=
 =?us-ascii?Q?bZz3FEhtTBxPcq4MH4SxyM3e9Gm7i/a4tMfVqvLvHC8ia3B7fyAOafYtrApM?=
 =?us-ascii?Q?ElohdwXFz2Qwpwusuc7majozQSTAJGaFBGR6bcIzQvH4X0X2R0Mjkqtcv61X?=
 =?us-ascii?Q?l8GcCgiRoy8Uk6sDsZvOA9ZIXFicF7Nf80Fd+xuLV0wjIk3Tg6fBZXlJUxOD?=
 =?us-ascii?Q?/HYN9yTJHWwcRl4yOKXQxWghK4sQPaua0G2PyQDOYAU8XBtXJ5NCUTAPmJtQ?=
 =?us-ascii?Q?VvW7xhs7pCjVeiModqZMANIPOdzxx3N8bL7xSsqWsIhoWpPmKx3Ced4DJ7Nv?=
 =?us-ascii?Q?GvFus1XsosXlQnhBzT8oYZHqdIweIxxWQ0EJZF8VXYQMZtjKT/YQVBovUEZd?=
 =?us-ascii?Q?q2NVUWzihhPWQAdDrA4J6Gi9tX/a2Icr1+gzeTgnSpOrAldcUTLDnI/0lXo9?=
 =?us-ascii?Q?CxqoI69u4Wx98xPC2SKVP14Hn2ORTO9bzo6A6pIFmJCSrrQfAMfb78jTcJ2u?=
 =?us-ascii?Q?VFRob9IuoTnlvcnSluHd4ZdgJ/NT/iXT5fn9LhYTljVnjtHb20cpC8tclcxh?=
 =?us-ascii?Q?Fk2fWlFSi4FHfy7uQ4vClZTaJT+mf8Pykkt6O3ZV0JAUhc3n3N3GIQin7A/2?=
 =?us-ascii?Q?31bSXv3nY81x+d2/CKr3SmR85FSmJgzGcbTvGxyB0AUwBuOBu2wsryWqdqQ7?=
 =?us-ascii?Q?H4b4u43B0GPk4aWm++jy47EApQUiJUbKSSQ0f0kYR+/4J2STRzjb3GsW4Dwf?=
 =?us-ascii?Q?5patw2LVPo2cMirA+bfR08YVzHaJK3zp40GI3xayh2kpaDmocah/06OHwgg4?=
 =?us-ascii?Q?p9pGt6qU+h0POiD9L6VQrpEgtRtVYG3o0hCnUQGlAeiA4LwpwLzXtlx/GZrm?=
 =?us-ascii?Q?qTZ0kDe9SBEln6zJnm1ABbQxKRDcDL57MrsRP60UrnaI786WPVpT9D6S//Bw?=
 =?us-ascii?Q?65cqOizrjk1EFrPAYpbmJ/2xllDLW3Eqm7I/zjSY0yGzWDyjw1Iyk7bzQIse?=
 =?us-ascii?Q?4HivPYUxzBTuQgz8LFxnsfB4ymsCfZbFc++XJAnc+VskQy7BnY5hyThVYik9?=
 =?us-ascii?Q?l8VACYm9R2ITobIZQzZQTQ/p+gXiNm8rvpXBciPTXlOsROG31Zc2CZiebmco?=
 =?us-ascii?Q?JBWpwtqpbYe7Qact0WP5B9EueStAhx9+UiEsgEGOT+tsWuDkGvhLW4GZ7RYB?=
 =?us-ascii?Q?6CHJE1lAoBIQmoPi3WTAiR3fHyZC6ftt8TH2TT8OHEM+OBl8tpw710dY0CJr?=
 =?us-ascii?Q?aG3vxNS/ZUkdvXzWsZoa+7P1QXZyhuk+4qQwiBels0B6DX4AOpoUSscztGO7?=
 =?us-ascii?Q?xprgryt1rJnTSrtOTt3Tk5zikaDUBdRthuVZMN+aryxPJ9s/0t97rrenudzP?=
 =?us-ascii?Q?/Kt2iBorvoU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10730
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f0f46cf1-ab6f-4664-c716-08dd92153127
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|7416014|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uRzVrslE8zX4ONT5fc9JcirLIpDcBFAyHSuSNoJISIamytndkfYmZRY9VS7c?=
 =?us-ascii?Q?gDR+VDGd4adcygiUZS7eOXS1WLt61A93um4yVfFf0hX4RMJYB4rbR20pcupo?=
 =?us-ascii?Q?c+cUjmDuvdB6e1cydVl5nsEh99VsFOIDetfzd4v1sMWHTrUajLfkFvZun86O?=
 =?us-ascii?Q?dHU8XrSbzlyqRrPZHaImwC7q3Lj452ydUTX65Obn1DtItQG/u+2uqp6G4dZq?=
 =?us-ascii?Q?NuEDC++25q9xUv+UWzVIw5G5REozfcnYObQrN9a51aXjMJTP81rnM947tUsf?=
 =?us-ascii?Q?nN1QAH6C5IcL3RATsnVEjmlYox9R1W3Zg8u01xcz+KhT7BvgykM3CE8eMxOd?=
 =?us-ascii?Q?YUPDPS9cufzKTxx+34Fpbc0q8Y7oufDLBNAQItaZF379/nbpye8dqYYJG6w0?=
 =?us-ascii?Q?uxn/SWKI/VBFBB2l1LeL3eRqOIDQrM3EBuMvVVVeEdcYp9rqc8bezUJzWCA8?=
 =?us-ascii?Q?Bu2TjcebzUCLDT7H2tOvjD9uLHkGyaYDwj9XgGvb+Bn3s1KVe9CHcXrg+88G?=
 =?us-ascii?Q?lImgmoM/VdIlM4fPMZ7lqENcxWAQJP5DbtLxH5EvIU0u+mtMAE38ZNaQH53S?=
 =?us-ascii?Q?TMG0fIv7Cpx7gr5SFvY+ngl3B+CzJ2rQMmVm0QK71IOb7YH46mdEvScYI3+o?=
 =?us-ascii?Q?6YtWaYBv00icNpGPCyhppbRAUNkG4A9aCIjKi1fUeQmxU5gB5ZeSFk99jXSc?=
 =?us-ascii?Q?cM58+f7OSuX5zBzHEksA89qBn4aIRga4gAhMW074yTz0q3ZSKb3O0AYEvPhG?=
 =?us-ascii?Q?xjRr9bLeWBwvVRbRpwC/4bDHcxnRBjtBIkknJYb/jNkagQ5H/yPW0h3/qFqL?=
 =?us-ascii?Q?SsGU5l4e7v1ossIzqrcvZMiM2fCYL4exf8H3/5ZoDHupEPByX5LXsu2wz/KO?=
 =?us-ascii?Q?cSOlsW7VpOhwGqiD0+rdJYfp0iaqEgtcS2Xk5fOHJIhWXjygq6B8yjShJ0bQ?=
 =?us-ascii?Q?so+urp0+avQ5SYEoS9hifz0bNqcKiX2ArBIQA5n2S669D0koB8QkCuTxTVYy?=
 =?us-ascii?Q?OFaZYMqYOajj8ChyucvWXfFgYtR1SHEBDLnXz1m+SM4fz13SyZ1t0gsDPBvu?=
 =?us-ascii?Q?B2+U3Hj7GoRBCv+MqbIaL0+ImVuDwd2eGau6qY5PYEnlfbLzxNd29nA4WxcQ?=
 =?us-ascii?Q?fRxw11TcF1014KQfwbD00vzQQNqNJ/9kcpDuILrVNGcgcVekKqJAmPeKS64e?=
 =?us-ascii?Q?IYvusDIih+9yCK4Reu1GGC773e1EY8H4ZgIMuj4PlWDWCw+sPXE50GD22dKz?=
 =?us-ascii?Q?/sfzvqvgW0DEdtmjlxgXSJu1ZS9PoaZIbAL/5Vo8zhOFeS5Msgo3ebaBdt5n?=
 =?us-ascii?Q?L5eO/CsdqXzq8YcZfpqFgvmEUDDOxV10luddVW+D8pbM/oZaR+IB6HsTB39n?=
 =?us-ascii?Q?+8l9bgqrx4kt3lbs3+ppV8mrvOVmVzO1eihy97+AIv2r81UkBBXZbjl5jo4b?=
 =?us-ascii?Q?onrFvudf8QXa4ii2TMdPmv7l86E3kDGwzOloBZxXkepeNlOc3bJsQe1ub7sU?=
 =?us-ascii?Q?04WKBrxrYopL7Bh5j80D3lW0OjO2lF9ysE8P?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(7416014)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:57:00.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08cb86a-a028-4a07-095a-08dd921544fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11179

Hi.

> Hi all,
>
> I encountered a kernel panic in the RCU core subsystem while running a st=
ress-ng on a virtualized ARM64 system.
>
> This panic consistently occurs regardless of whether I increase or decrea=
se the memory size.
>
> The crash seems to originate from rcu_do_batch(), jumping to a pointer (0=
xffff00003a114000) that appears to be non-executable.
> The PTE for the address confirms XN=3D1. Given the heavy binderfs workloa=
d, I suspect there may be a use-after-free or dangling pointer involved in =
a callback invocation.
>
> Platform:
>  Architecture: arm64
>  Virtualized environment: Apple Silicon M2 (Apple Virtualization Framewor=
k)
>  Kernel version: 6.15.0-rc4+
>  Attached Config: CONFIG_PREEMPT_VOLUNTARY=3Dy, CONFIG_KASAN=3Dy
>
> Reproducer:
>  sudo ./stress-ng --binderfs 8 --binderfs-ops 10000 -t 15 \
>   --pathological --timestamp --tz --syslog --perf --no-rand-seed \
>   --times --metrics --klog-check --status 5 -x smi -v --interrupts --chan=
ge-cpu
>
> Crash details:
> [ 1977.262956] Unable to handle kernel execute from non-executable memory=
 at virtual address ffff00003a114000
> [ 1977.262980] Mem abort info:
> [ 1977.262988]   ESR =3D 0x000000008600000f
> [ 1977.262998]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [ 1977.263008]   SET =3D 0, FnV =3D 0
> [ 1977.263017]   EA =3D 0, S1PTW =3D 0
> [ 1977.263026]   FSC =3D 0x0f: level 3 permission fault
> [ 1977.263036] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000dfd8=
8000
> [ 1977.263047] [ffff00003a114000] pgd=3D18000000effff403, p4d=3D18000000e=
ffff403, pud=3D18000000efffe403, pmd=3D18000000effad403, pte=3D006800007a11=
4707
> [ 1977.263088] Internal error: Oops: 000000008600000f [#1]  SMP
> [ 1977.263097] Modules linked in: pcbc lrw xcbc wp512 nhpoly1305_neon nhp=
oly1305 libpoly1305 michael_mic md4 streebog_generic rmd160 crc32_generic t=
wofish_generic twofish_common serpent_generic fcrypt cast6_generic cast5_ge=
neric cast_common camellia_generic blowfish_generic blowfish_common ecrdsa_=
generic des_generic libdes aegis128 overlay isofs uinput snd_seq_dummy snd_=
hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib=
_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nf=
t_reject nft_ct nft_chain_nat nf_nat nf_conntrack rfkill nf_defrag_ipv6 nf_=
defrag_ipv4 ip_set nf_tables qrtr sunrpc virtio_snd snd_seq snd_seq_device =
snd_pcm virtio_net snd_timer snd virtio_balloon net_failover soundcore fail=
over vfat fat joydev loop nfnetlink vsock_loopback vmw_vsock_virtio_transpo=
rt_common zram lz4hc_compress lz4_compress vmw_vsock_vmci_transport vmw_vmc=
i vsock uas polyval_ce polyval_generic usb_storage ghash_ce sha3_ce sha512_=
ce sha512_arm64 virtio_gpu virtio_dma_buf apple_mfi_fastcharge
> [ 1977.263372]  fuse
> [ 1977.263387] CPU: 2 UID: 0 PID: 27 Comm: ksoftirqd/2 Kdump: loaded Not =
tainted 6.15.0-rc4+ #1 PREEMPT(voluntary)
> [ 1977.263398] Hardware name: Apple Inc. Apple Virtualization Generic Pla=
tform, BIOS 2075.101.2.0.0 03/12/2025
> [ 1977.263406] pstate: 21400805 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D-c)
> [ 1977.263416] pc : 0xffff00003a114000
> [ 1977.263443] lr : rcu_do_batch+0x2dc/0x860
> [ 1977.263457] sp : ffff800080143c90
> [ 1977.263462] x29: ffff800080143cb0 x28: ffff000048608000 x27: ffff00003=
a114000
> [ 1977.263478] x26: ffff800084442000 x25: 0000000000000000 x24: ffff80008=
43d9b18
> [ 1977.263492] x23: ffff800082150ac0 x22: 0000000000000007 x21: 000000000=
000000a
> [ 1977.263506] x20: ffff000030e08000 x19: ffff0000af4cfe00 x18: 000000000=
0000002
> [ 1977.263521] x17: 0000000000000000 x16: 0000000000000001 x15: 000000000=
0000017
> [ 1977.263535] x14: 0000000000000004 x13: ffff0000af4cfed0 x12: 000000000=
0000002
> [ 1977.263549] x11: 0000000000110009 x10: 0000000000ff0100 x9 : ffff80008=
385a580
> [ 1977.263563] x8 : 0000000100000100 x7 : 0000000000000000 x6 : ffff80008=
03f89bc
> [ 1977.263577] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000=
0000002
> [ 1977.263591] x2 : 0000000000000000 x1 : ffff800082a4aeb8 x0 : ffff00004=
8608000
> [ 1977.263605] Call trace:
> [ 1977.263611]  0xffff00003a114000 (P)
> [ 1977.263623]  rcu_core+0x2a0/0x4e8
> [ 1977.263635]  rcu_core_si+0x1c/0x30
> [ 1977.263646]  handle_softirqs+0x1b4/0x588
> [ 1977.263661]  run_ksoftirqd+0x5c/0xf8
> [ 1977.263670]  smpboot_thread_fn+0x27c/0x490
> [ 1977.263683]  kthread+0x2ac/0x318
> [ 1977.263697]  ret_from_fork+0x10/0x20
> [ 1977.263714] Code: dff29fc3 00200000 dff28fc3 00200000 (48608000)
> [ 1977.263723] SMP: stopping secondary CPUs
> [ 1977.264081] Starting crashdump kernel...
> [ 1977.264090] Bye!
>

This problem seems not related for RCU or architecture but some datarace
in binderfs while it removes its device on unmount.

Could you test it with below patch?
In my test, it seems being fixed.

@@ -79,6 +79,7 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);

 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);

@@ -6929,9 +6930,16 @@ const struct binder_debugfs_entry binder_debugfs_ent=
ries[] =3D {

 void binder_add_device(struct binder_device *device)
 {
+       guard(spinlock)(&binder_devices_lock);
        hlist_add_head(&device->hlist, &binder_devices);
 }

+void binder_del_device(struct binder_device *device)
+{
+       guard(spinlock)(&binder_devices_lock);
+       hlist_del_init(&device->hlist);
+}
+
 static int __init init_binder_device(const char *name)
 {
        int ret;
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index 6a66c9769c6c..a6ae4edc4ed5 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -588,4 +588,12 @@ struct binder_object {
  */
 void binder_add_device(struct binder_device *device);

+/**
+ * Del a binder device from binder_devices
+ * @device: the new binder device to add to the global list
+ *
+ * Not reentrant as the list is not protected by any locks
+ */
+void binder_del_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..a0779a8338d7 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
        mutex_unlock(&binderfs_minors_mutex);

        if (refcount_dec_and_test(&device->ref)) {
-               hlist_del_init(&device->hlist);
+               binder_del_device(device);
                kfree(device->context.name);
                kfree(device);
        }

--
Sincerely,
Yeoreum Yun
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
