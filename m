Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C829E0E0;
	Fri, 18 Jul 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832278; cv=fail; b=nN3X6S7W6AoR+0RuwQDu4KHBdZDyu8DJN0O24FIsl/v3Fn7V3KmCzOgrTp2EoZtbVCg270HLJSug/gnryqXD3c5ALMpOaNGlU9gzOaO27dT5/iv8d2stjVLIAqoWt9yhdlG2lF3OZKm8DXFcYOZomsSB4O7DdfBvpv+rzsaOaig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832278; c=relaxed/simple;
	bh=iwyo13uWEmg5xib739RfVypZJpdaJvWh/pLPKccgi60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o79FCIXH47wWzKmkAENo/xTyzzJqfC9+4ayvI8Civ2Sc6UfY/y3EMpntzmaUwUKEO0R5e/5shFOI3iyuAsNLln+KEws38QInMJDudOcYyoVswUs7Hb3YcuyHN1n9di2EJRcJWYduJeVlCBrqzUpo99PbgBHgWoJr4x1m6cbmW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=evoy7M4p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zNO9JeGq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="evoy7M4p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zNO9JeGq"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fieQ029726;
	Fri, 18 Jul 2025 09:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9Ikxa7gFGYTn2mxG8O
	dszYcB18khgdOBfxluO7r7d5Y=; b=evoy7M4ppkeEpTRzfi0ehP7gBskZJv0bNG
	wbFTWQw3cfMq6DFASH3ee16ieYmomCh6TEzDe5bb0f9JXt9oA+W0a990cA5S3YH7
	AnOZC4UYFaSpHiaBcFHJp6E2t/wwlNdLHAOdqhOWAE6m5I0qsmkdwQx8A5GAQoLe
	A/N1gh4rPY43jKT9bFJVbAdZz+eqjOrmuf8VKEPB6JeaL+wbRetA/158q26Mgky5
	yDjYcPeEcj5BCgqlByJEdxuH9+GcsZfc91UDDPMkn2CImQ6uz0EZpinRdcdJlEHG
	OlW0lADtY3gWLKh9en6sv3NFNfY9KZACN5yt/q1UV3NeM3Pt4UkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr14k6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 09:49:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8G4rG024809;
	Fri, 18 Jul 2025 09:49:42 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dtn4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 09:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcsAi8CyJXBokpJn00mEwrm7x2GcsIvlDXdsRueoNY9eNi2158sT1rjnCywx3kzPQ097ay2B6ZcHGphrih/sfZ0HEZ7b1pynSYcCNcU+7nEwCeocl73DuHgrdNlxneI0KEQ1+IH8TU5g3y0G5t67tZekZyM1kFCYKijiapof0vhCAFRQ4SRGC06GYReaCQrvcQRfeFkhVSgj8Hn1EFQEx2pqTLjHX2v1NRVSo7bAja3ry+WogU8gqbuzCZ5P2aG/1xLbcFXlsBifDutBQ6DKz/hUnEwuuNs+LdkTqGfb4m2FgfbR2VUKJwJSbTn7PYqJtc45x+iRbwrCucJ8T0zDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ikxa7gFGYTn2mxG8OdszYcB18khgdOBfxluO7r7d5Y=;
 b=SevWMBDfV06MYwPKieHrGQ7zK1rd5kVAeDwfx1PgamcaaXdH2sSG+1j1eYvfvUoFnxftZERLr2sH393dYZCSkLQQUTe0OV+vt5yEP1+T7dnioX6UgVdRvi1yxNeozh7oB4QIWBy3dtH3P/fS1CKwl6GtEiMXFxOk6tUgeAGlsior//TLkW/EDu6ILbAJUKEXUnVrFHhhhzigkHyhfk2pRA7d4eKh7DGi7+4tpjplCm0WwRE3JMMga4LmQZUvwjqYyCczDZTjn5rDv1Qbgc2bFlQwQ5rQKkvcz+HVSxqzt5br0MeDv6zLpyrWaDTNH4o3c2aGOwV0hYfoOHwjF3f7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ikxa7gFGYTn2mxG8OdszYcB18khgdOBfxluO7r7d5Y=;
 b=zNO9JeGqB3UwCcYnFl/ZQKhHkOyl8LPIoLBJvK8w1HQNoBqr0k3Rz+XJYoCzKIfB8Vdx2fei0Vn3KNkcvb3GKJ+8RH6bi0IPXpDWzlJ3WMRtc5y5kk5RAJ5VpGVgsI16Ftm9xOZydE8S2y+dFc8wmdD9ol84/4Z2hlUILQedw2Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 09:49:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 09:49:38 +0000
Date: Fri, 18 Jul 2025 10:49:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Barry Song <baohua@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
Message-ID: <f837a5cf-895d-4639-825c-3d12bfe75425@lucifer.local>
References: <20250718024134.1304745-1-ye.liu@linux.dev>
 <d68d1947-3ef5-4171-aa0b-73f7189b74ab@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68d1947-3ef5-4171-aa0b-73f7189b74ab@arm.com>
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 734f8ce3-abac-4ea4-7741-08ddc5e06925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wAW0oUlhAwydZoYBPNkBHjiYmh6n7O6a64KSywd+eg1iYsezAEtFld/KScN?=
 =?us-ascii?Q?lN62Fzx5AQr0gagLLC3bQsO6ASq1GpC+Cr0Tu0sl/CQdsNakiY/AHBlUbkYa?=
 =?us-ascii?Q?neeb0oBHuVnBkkVCtiBELNCiSLT4oXHnAufO6x5TRTAU7QiwHHdEWwt0l3+p?=
 =?us-ascii?Q?fj2ciEqGDSH4VMdPW8j64z05rFSol5sYuLvP1dDEsmLQNcy/YttcsEepjbEF?=
 =?us-ascii?Q?JANgxc4QE3goucgihMg1gBW8xu0aP0okTh1xtwLGJCZGGrYdcw7+mhk8Uthd?=
 =?us-ascii?Q?orX6FgweqGhu2Q0EP2z4wfdMDxHoMRSW/BlxNT9YumZrgHTpeWhMQzgTDLR9?=
 =?us-ascii?Q?wHl6sBRrfhjfp3VZcRU6tTLxdKTymsNdgLTqCKJk5IxQlKE/z4FX8oHlXa9v?=
 =?us-ascii?Q?T9V4gwv6tY4ZrZeT0g8u1PRUu5KfZCAV8tNh1m+9BuDd/HTqg9icHiEI68SA?=
 =?us-ascii?Q?NaPYvrWuMHENxK1Q5SjdnsxWAkfH+nJIEB1bnBLXMdywKYl68s3HbwfC2xib?=
 =?us-ascii?Q?wfKukiC7B7n5mHGrQBmH6bH/nH7dNPzokBHuiauWVDpA81KekshJNOTRdxZB?=
 =?us-ascii?Q?OSr+oNuKedbWD6o2BzhJMLfPPEi/n+16k12Nad4xgEW4a6wNgLSHFSZx1jet?=
 =?us-ascii?Q?GbQmbIFfG9TYLJXQhgmZxUOHyi24+PZX/7a3FY1ndLuxzQ7982TF7Y+y9hD6?=
 =?us-ascii?Q?j0s4KqCUQooXze+1v24KtziiComuYOpH/vxXHqs26f8uZBHaC+NzHyHiFcfu?=
 =?us-ascii?Q?2k9R0MWmrOC8++M5q2GCca1TLP1XLFzu+oKly/9GRiTawBwwiAgK6iNyyn4+?=
 =?us-ascii?Q?7yZDxbsNCEd4vdpjNFGF6KIt4gkRizmpdoAAZqrlfF3z79y7AsunkTglNux/?=
 =?us-ascii?Q?WhL+vjKS5OOKclFVL3nBZinWjHGzG/r42MrBSO88L4UCLrG1x27d/gjL+Vo+?=
 =?us-ascii?Q?1X/XUdRkt5S84wJH4dfPja7UH0efdyN9TYRk8jm/697W1MxCG8eJ34ODezjB?=
 =?us-ascii?Q?0DuuvSf8BO35B4E7njndM1m/K9Y/XZL3CZvNacFHnMkvTKCGi5uvD7guL8iS?=
 =?us-ascii?Q?2fnWAve7T9OTlYwJeOcsJxNKkf5cCUyghMGf6v8FAdulMmPqDI5x0dnPCdcU?=
 =?us-ascii?Q?XqRJ2V87JCdENU47FBA3YGrUUOlOvaLdtwoidjmF9NwmuuLjeze6gRtbZt2c?=
 =?us-ascii?Q?iDmEbUL7L5EfYion8JUwzoXUJa5h0U+vVX5p71q/eKeW91kaSenHiIgftydM?=
 =?us-ascii?Q?yXBQQn44Z7gonsfe+zx6xZJEW7nqFtxzEeYwaPz0gAnQFtnoAvnbIJZYbtkB?=
 =?us-ascii?Q?mpsqyg9PZ6xZLPPesEZb8ADXGuGIY2PitiqVJb89iRqoOvx3NGjim285rUnP?=
 =?us-ascii?Q?JfJfu9fpcLGM6f13aLYTq6E+VvpKR/ml7xkRQ0OT/OnQ5J2VA0kn9ey6fQa0?=
 =?us-ascii?Q?emO59DYU1es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFddeFPYbpvZ4613sZ/PbBLlDxlDy6MsvNAWB3XbW1Sq4HLsP/UbeRF9CaeF?=
 =?us-ascii?Q?18hAAyiNqAgQChcUVIDx71FsdqVzE3OfY6jP7GjUGxB5ZmrK0r3Mg0ElI9Bq?=
 =?us-ascii?Q?kxA32/qSL07p3tkvxv4a89KtEdsRa7hnKTNsZfaMBGODUdkVNHEFgAQd+paZ?=
 =?us-ascii?Q?xn8Vcila59e18O6alf3c9PDowOdytMbAbfsTfwn1aZN1RKvwR5Rwx0VPPIOK?=
 =?us-ascii?Q?NuJE24DiUzfay8oB39Vq63DKCHewb4djzo+RC0Avewl10T+pB3A2nE7S6+jB?=
 =?us-ascii?Q?KZYnWtjxppwIUtvz/K9j3fapIemen0uRn5/yvRpkBKfzuQ9bjqhQHFxDWgN8?=
 =?us-ascii?Q?UR7d3/O5ltWgd9XSA9Dp7f0gZM/JbcGDQjZYAqPM2qdIRugK3Z/mxKt84IaV?=
 =?us-ascii?Q?CQhs5A9GNVR70ExSxMmG02c2xWfN+rEPPNTXqymdkjHBJRsgSUN9DqoYjEar?=
 =?us-ascii?Q?/Vc96wL9LCgyorTOjJsJPAftkjvtrYpoPE5ov9h5lG5bnijAdAAB17hDUixi?=
 =?us-ascii?Q?MZ4P+PkIGT78U6mm0Cff0BCQecf0ftAXkg1JMK6rWW1JO/FsBs1aM9tqpwzL?=
 =?us-ascii?Q?pWFP/9mFJx2cwaDpzjaNPcSg2evC2+GeJTxncx31Jhb+zLzNljQXIPwNW5J6?=
 =?us-ascii?Q?Sh2oUU8ir520OWKPr8nN2NRJt6eMp4KO7RrbIxYwrKaitx6rfkd5XCYYrLGH?=
 =?us-ascii?Q?VbSjJ1Ll9eaQ/wUoJB1ooETZajsjMzHzaqhU5tGMHiEe6R39zmPiXISLfbAF?=
 =?us-ascii?Q?F1f6huARA2VR4icQEYikzFJoS8QJ7wRlXb8WzeKKjQnpkZOw+K07OMPf0fiY?=
 =?us-ascii?Q?QlmKoPRB7lAoWVCxEJppDix1S/ICSvTXdkancGs/pS9hcgilpCTARUz4bCle?=
 =?us-ascii?Q?B8LBAwJ3TrOd8LFU1zpdiOJi+iTt/VBD9EURIxbFTd0zozfXW10R4oP7+m0N?=
 =?us-ascii?Q?Jl5AyZMSIYPJ5xhn69NQYqyKygy5BK6A+8iscMb+gcV1ZMBhvXyXGDKRMLN8?=
 =?us-ascii?Q?tTCGMyC6gals0SwVAbQ54eL2e+LyyoHsr5lmDR1Rr6h/6tRKG702s7BJXO9N?=
 =?us-ascii?Q?nBZtZYafJivNiSGCSk3xVDs8yTkLI0qhbcyYghZne8/17hbX5Owhz8ieF74H?=
 =?us-ascii?Q?4yhmg3BOmujRk6PiUHSpmX0Io2KEcM7M3jiZXni4K9xJtOxlM0g1jEEzexV9?=
 =?us-ascii?Q?vCbhKlT1QtPV4PiGti7ziNbN8ROLqZl1FLJCh+QsTZeRT/hy2fbOZnSyUfo2?=
 =?us-ascii?Q?ejIQcrM7blXwEN24B6CMt4zhtER9Fs1qhg4mR+yymJoft9UALd7VzS0vDoy2?=
 =?us-ascii?Q?EABhzG+xIGKCALQn3dFYxezlDvAAEUovNk+QLfjq6lPBQ39VbfHakDXOUmVy?=
 =?us-ascii?Q?357gWRPPU2FDCTH+BVV8HGz8QS4iQj5rytuUkyj94+CEuiUlYzUKA/N7Rn1k?=
 =?us-ascii?Q?KWYVEJ05fgcMud6ArNEMo5qPC2FiD3H4duvQt9mKkthdickK/R14d/kybV08?=
 =?us-ascii?Q?LeMsLT50dJwuC2+o65tKp/VPDOy0jbJI0GsBbvcIJnezTeMSZ5b9YMGWchES?=
 =?us-ascii?Q?z8jpdL94S9alu3/th7zcrCvzd15ArE7OXi+cpHkzsNT+94kdperUA4BAolKs?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ae7YDF+K+31isJbPNh0RtYocysL/8xPA2bqqONuv3IlXp5TtUr10JXbiOcrNF+bpyFxDpA45UT6CSYoGnWjcaWl5j+dWZ6xL5w3ZOQLXl2IPZ1w1scpnwhvLosVNfuBjcT1xwZVccomN/J2FEXgtJHZEbyfEkyoJJxvhY/YlDNhkjf+WuC7pVD/0gJN/iWe75FLoZ4b9gUs7icLsFb0WR1+g6P5ZCR/daQFBZoYQ3ftg/4i6bSERjnirMMB/0h53HQF5lTvjcq2bpvQ0FUMSoE10N9OjyJ4x1QmG0mI6EfWD5DHPVsgXoOFFWcHXR4A9NsUPwMX94eABonoXrzSkGRCxEMFWQn+qjfddpG1+hoLLMU0uePwHVEuGyQ72qDqfyioGNMNVHwphrQ8Slbc/cN+LCrSBPZO6Ny6TVkuTiZLJF4Y+DuoUXWvrpEz/MBpTVHNeTTH5XQ6tA4yYwppoYVzMCnuQhQarm4jBxpOOMefsuF2gUgpBSiATci5hEWqgSpNMgacrOrCfKB2kBN3PtlPOBqWx/2LO2ZYXHBpXxP8zz8kVhFotywLKzgplBRlNyfs8Il87femA/KyWP7KaiDvU92+weVAqO5TLA7UY3bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734f8ce3-abac-4ea4-7741-08ddc5e06925
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:49:38.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoRRAp7Cs6t6vc3lN/OHDUnnfIhAHbg25Hd2+KkzI2PZeWuQIyaoSp8jkXW8aeHB/E8gTmDtiKJKUsVMLB8F4jQlTKlI3zzKf7JR9hzkgns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=656 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180077
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=687a18b7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=4CF1J_o0HdSBwsZnYvYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0ksMR4vOtxIWGnb0-MLp-bRukwdhKMOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NiBTYWx0ZWRfXwMfRVlt/Tz23 TDpiteK/6UrjlghZbeHizah/3iSoccuZRz5lTJtZqG8MpSYQCsdWA4ZOH7cWVhJuZI9ZbDwcnRv D93I7arS+8eNzpVyV+kDs/z9khM3lWBg893QsW5x1U4wKCdoFx/4Z4p8akY1Nda+BUnIoRUyMzN
 7GRdizZfZdzrd7Q0G0k/QIBDv2JEz21Tf6aSe02+JSW2uoZGDCWIT8Eg6/ZPbHQzy/98UKGbsw4 oQRi4hj9/cd4b1n2azLO7npYW9w7I1MJrZ9wOizM/ujb5cjOALJpmWNipiEica3buHquFrthggA mrlTOX0kYLrM3QYVU2t0zIT+xADfXZxLcRDhhQDihfoOy8wayiMCSQY7fJG0k3+xZONj2apaKf9
 ZZf0mLIIt6yJg9odqytj+a/kCrnmirNDrdfjvcBN/8nfV8xd7wFD9xKm3V0NHHQm39xHs/vS
X-Proofpoint-GUID: 0ksMR4vOtxIWGnb0-MLp-bRukwdhKMOa

On Fri, Jul 18, 2025 at 03:16:55PM +0530, Dev Jain wrote:
>
> On 18/07/25 8:11 am, Ye Liu wrote:
> > From: Ye Liu <liuye@kylinos.cn>
> >
> > Replace repeated (20 - PAGE_SHIFT) calculations with standard macros:
> > - MB_TO_PAGES(mb)    converts MB to page count
> > - PAGES_TO_MB(pages) converts pages to MB
> >
> > No functional change.
> >
> > Signed-off-by: Ye Liu <liuye@kylinos.cn>
> > ---
>
> sh and x86 have their own pages_to_mb, drivers/target/target_core_user.c too.
> I guess no one likes to clean the kernel :)
>

*A wild Lorenzo appaers*
