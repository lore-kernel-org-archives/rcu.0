Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DE188704;
	Mon, 24 Feb 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384308; cv=fail; b=TP0ZkAcFoRQw5arOnxLlve2MJ6PwpYwkAXq6zGFD3AGkP7NJvj34/YhlI5HnlQrI9KD0g8HxB9HnL/WXwcwVByMAWDoItx/dkvCuxrmJPcnDFHlYUnZEMvHUYqx9USUkAPO5gl28nTELgHC90WYP3Xp8BrKsMEsd6cHj1nv/00M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384308; c=relaxed/simple;
	bh=fvilGR1C1gNjrWtXxW39IzkVXc1q+xWsbGKEeJDY5LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKvoctEG4dpLa+R9jBPLGQmiJPZrCBn2MrNak5BFs2+OvgYaZzQs3j/yq0Y7KYvJhUmvVJvT/VBv8gs44RVfpRiWblnxmZorfp7Y+jlyCo2kaYirMc812oVJDiTUycz4i90BZ65Er6S1th8cW+AjrdAyYcPQ3o29VJg8wu0dnDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JE7RgYJS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GaIT5fP1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JE7RgYJS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GaIT5fP1"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7fS1w012923;
	Mon, 24 Feb 2025 08:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gYgUama6g9A5PLGqHj
	TRDhDRwLIs2kVEkqwNfFNBWoU=; b=JE7RgYJSkUW3pZTFNUVhjLuVGtSF9/Lqtz
	S4v0SAyncrzp7Dg6pzcWfZ0f965h6xvCdMwgofGxWZubYwQFjp9kX0raZJRdrXk/
	fh8cW+Gl4dr6cS8LrUMkVtVJRMMjzXqAvXiilcqxlRSG2Mu1rbsGjXaqY/LlF/H6
	/O9rrNOh/KxPTeUaibQUcNq12iYWkujQPKrF5OjKN6Sexd14C1fZXJZdM0oD5vih
	xDg26Lqw2ao/MmdOaH4zv9hSCq1WWFOSRyS3+XUXj9XhE2O1VZC4zGHM6BdU8XOz
	yXceqnn8aDe+HsFN4sCzxUcW6Z4QYJ4g2/bPDho6zXQjeHv2SX2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gaj1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:04:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51O69pIm002792;
	Mon, 24 Feb 2025 08:04:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517kc78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajVZQQFi6HlIu5Ezw8LgkQbJ1uTRagKsSrRg5Kb51BKSdjuUSa2/JpSC6Z+Z9A8lRDcw2+k4AKZenNF2RkOPstzjO5KrHy/lUjTTljBrfTYcRAva+3woVRrIKbLys9EzDBPv85vaGs4HhxtJ5aewEoPEhZY9tpfghXjJilMpA1tI/GLEq9Z58rEGDeh9Ma8m97P1pr04wOiuArZ9s9hQIAzPfms0tlgMnBHM4VWJ+kjnBRzN0dRT/rqOiINzBxos6TiAEDiWAW06PRle6whdRrtOpACyKvXH/4eJbZ0OWrLm8tKkc+5NGHJ4IABlJXPSfNHXp2hukGJP8/Md2y2PEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYgUama6g9A5PLGqHjTRDhDRwLIs2kVEkqwNfFNBWoU=;
 b=unFyEinOKOydupyJatkkzLb6xYd+4mNdEe0QoTXK30/IG+DlbtiCkQSRNF55WIXnY/O9qGdgZUdVqa0JkFM51LXzdEHYZv6WjqcqEZbZLWu7/8vAkHlFQPlEDqVnopFwEfYWq2yNmrS6OeDE4lnIhoiSkm+hGtJ7fuQFImuNQV83rhpEXUH630dmcNajYclq/UqDviupY0UqJjJI+0sgCBfFgMVKw12LSCBz92/DirPdKy56TgTK5tQRYeVoh+YUPcEeBJxtQo3Tp4afsIukmuDAgYj9TaGBCvHJrfkr4V8Xmwnc9LJLXypo6FhaidIGHq8oUDlnJWosZW2h+rk5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYgUama6g9A5PLGqHjTRDhDRwLIs2kVEkqwNfFNBWoU=;
 b=GaIT5fP1+5yZ9AsLvHH34tM88QjnyeHIkvE3ctK+MImNRjKyF1WizkD3eg6FBa3zV4XyU6K6BeFQxdS1TnDrHxFPFabTb3e0vq3cD9vb1JpOLCvkIyrxPqEkYdFlXxhkCZ8hduVkfjwQ6is0kmJPWo3H6aJJ8BcG6wUvLPhVUYI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB7375.namprd10.prod.outlook.com (2603:10b6:8:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 08:04:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 08:04:38 +0000
Date: Mon, 24 Feb 2025 17:04:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 01/10] slab: add opt-in caching layer of percpu
 sheaves
Message-ID: <Z7woDjICqD0fkghA@harry>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-slub-percpu-caches-v2-1-88592ee0966a@suse.cz>
X-ClientProxiedBy: SL2P216CA0190.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b776e5e-db7e-4635-dc0d-08dd54a9e24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6m4YCDofmZ8C7bLCKZIQ2FLgnijZCxAuZjo5tszRw4+mOGBzc8Y+J4hx9kI?=
 =?us-ascii?Q?WxZ3ssVqG+ONpYw8EFBdEYVg9MM/Hne253wYg6BkM3l+Al2SPR6a7ROmdsyW?=
 =?us-ascii?Q?33G86u8mz79mRkZwl7Gu9ZEWCZ9gPzEsybvMYl9CgkuOSDwInqVx3DzMzDXg?=
 =?us-ascii?Q?9cKaVlvKXuXOc9nixUvGAnXTXDYo+EvN27Q11OjoqbVJhVnerWFEYHxA7WAv?=
 =?us-ascii?Q?Cp51mwLeFAucY6FS001QuNYkCQ/phUstvhl7hqjmbjE0IwU4pU609ZPIBOUw?=
 =?us-ascii?Q?rKshzkIHrDkfOjlx3X0h753cUf94wqExGdnSnsqt9uVdTB4YpucKKFf4jfwc?=
 =?us-ascii?Q?AXyT4cs/TKT80mB6INrxMotf4aaYt8SxZX+gc36k/aM8nglnG1I+2sP6T7/m?=
 =?us-ascii?Q?AdtDeAGKUc4J6AcWtqyEcJCu4HLxa8BWgbdBoJOA1f9MHoWDb7YMkZ7R0L0P?=
 =?us-ascii?Q?ML2/YH/FsRP1hCdE+4vtiLmlZFvBvDZCRc2YD71tsA4n/HUQmItCmyNgYtHY?=
 =?us-ascii?Q?wvcK4xdXnfxdsxjK0P96hnzHoqx8XgG3DwmJKTrxSbiI6bKu/Ngn/GwI2FH7?=
 =?us-ascii?Q?uLdl2h7WdPLFWahygslrxmgzt+Ny3+oEb27S1aGsJZhnriCzHgsym0nsws0S?=
 =?us-ascii?Q?iCoMalsvoyOItZnufnSJMvbdnctTrlCltm4ukLvRMuVDOZcnb0c8iQXunh2D?=
 =?us-ascii?Q?5DpA4HIx6NziGcB4NBTaqCJDqvK+Ic5f71cQAIlPuhvNaHVqYMOqO4J29JmH?=
 =?us-ascii?Q?IRpiZz/Za2DxU/Grj5cjxDcm7tukviRDQQNpQP6ekzljVTuP8DCoSuiE+EXa?=
 =?us-ascii?Q?FUkuVwKlMxyrytCB5UoXtRzHUgKzsYsSnM4Oa872+9Q1vu4Cyf7gQwheP/FD?=
 =?us-ascii?Q?tzc+dsTZDxCe/F0HXVTirCb8fg4jdjMsyvz0rVQfWZRo5OnAI6MD916LM9p2?=
 =?us-ascii?Q?gzAW4UfhkmvUGI+P+xqO6MHMO6XCtUD22q62ZnhhKFZ618+TR4fhaUv5WaxZ?=
 =?us-ascii?Q?rpHsWcBuJvK9X0tAlSBloCok764kUiJzxrJsscy6haSJAlNGPk5YRaO9oB0R?=
 =?us-ascii?Q?J0c3s9tjV42jqiARC9PxPLwYGOafdspoQ89tSN4bBkTeVns/FW8LATZiJmxm?=
 =?us-ascii?Q?jjGKlwsaROAg7nWSkQyhqh/3hsKPXdlNKVMlenVapUG+B2ou2StW2PmLcfUE?=
 =?us-ascii?Q?f0ObHx0tNQj7FmuDWj+jXicx8dX6G7z6N7o8nptA4Hc9dPKfDgsXcyuzigbK?=
 =?us-ascii?Q?mVE93j0YYeRXmtPqdM/6XkQtZj4Ki7i7xu90p3NPuUhHMnkGJ/+gH7BirdAj?=
 =?us-ascii?Q?qNWVqw1dwAll5DalGpaf1jI/HMvhpv7bS1N8jawhmByzXrY5DIHe5v7394r5?=
 =?us-ascii?Q?DVf4mwWDSlxIcSu6cIgb5INThwuw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Z6B42dfdPhe90taaF5SFRYk83ThxwG2MxGbWGR4qGeCL+Hy19cFgP2fboee?=
 =?us-ascii?Q?Cr0ueXwoB2cuhI1vOdu8MOWUsvZGdeMijOJHXNY5pLu+BijnK3KbRVUXoyfj?=
 =?us-ascii?Q?VHuQN9EJbUYDlDAIhZ0qfaqN8G+7JXuATxhuIghoXCqW9mPlC4KYEW5RlujF?=
 =?us-ascii?Q?tE8+qa3dOZBELu30SWSmVI1+8T7gSfTVBB0+ft3Pa8t/iYe2Tdv4hrnnPx9F?=
 =?us-ascii?Q?78XBJtIKf/7N7XU/FA1wAp0UoiWHLaJ8+xLB89+YX8nQxl/vkciZj2E/dAkF?=
 =?us-ascii?Q?7Mqmf1QY3F5hZZkTWWzmDbiwkDxZ2SIX7CX/oUmIPhD8D1TDBDP6XQJla8qF?=
 =?us-ascii?Q?Gvnv8aGlxHDt7nDd07L72bclxeWyAEcApUlRFB/c7vbRfh8WTImPeM6SEU+E?=
 =?us-ascii?Q?dQ82WA7Td85jNknig43UvFUknOpnw3zSGegvTg/ZRXBkaKVJk+txAh+70/FY?=
 =?us-ascii?Q?ejBrzP37JoSWbfFV0Q+uBH7ahZ0ZfQpHSjy23jM2F1TJGfQT9T83bWTrQAzO?=
 =?us-ascii?Q?JJLnS2CC5T3+nBuOcKx8XZPkYNH75+YxLI5qRQtcSj/z/SIU1FfBh1iUSlT3?=
 =?us-ascii?Q?EyLqLQuLBgegPcwzmcJFHzsC5w96Y8nnsl3M+5FQUnw0ZaW8QvbUwkU+9Vae?=
 =?us-ascii?Q?gOsuDdNl6v7CWw6qYfz3YloeIvCo/xXjt/uzBu84ZZarwUV6FrWQUYQDW0f7?=
 =?us-ascii?Q?WQhUr9IslU1fkpu58cwLtHLPPF6IH66nny9omXCqn3WhoqqXzFfZis9ah0WB?=
 =?us-ascii?Q?8xKAPbR12PB/FWTMaFXylOahsotZXiS2GKM8aHqBP/LY1rEJzLYZaUw7pekT?=
 =?us-ascii?Q?r9+D9bY34fUvedCaJ4g5tQfjeW2ZHJVCDQN1XS/4+RVERLsGQBmW/Is1pbog?=
 =?us-ascii?Q?P7AZ+mtZ0PXnFyEWxBGwWKzQI1tnDv6d7V5/Gga5igXB79hVMau2HFXBi8Ds?=
 =?us-ascii?Q?AiWeUqJHlZbiQ8Am70JSPrJ55AIffR9w3pm4OQ08llkUKtk71mdRJ24fbX+9?=
 =?us-ascii?Q?FsF1qyh018cMv0IaCtnqRWBgKgFC7KR3wZogvl1dxoSRnrKW7ajxF7aLbcRI?=
 =?us-ascii?Q?PshPw1XcBUBT9WseuFA6eFrrNrslPVd/2D1vzYQeAmOPjT1sJSib/ytpwjl8?=
 =?us-ascii?Q?IBaYlUQZydplN5J/9F/P2P8vjeh54jAfaPiqj7b7zIH5pGolcwfNDaXXkVRk?=
 =?us-ascii?Q?UznB7EaX17w9KJSRRgtKGEtELLSDbs3zusGUdxxUcbIA6KASq27jHuy6ctXc?=
 =?us-ascii?Q?n5hoNwyE4mf4q8+071MQfraFbpYzgzo2xq90FpENSbk0JpTp335CL4wGFCV7?=
 =?us-ascii?Q?eSDw5P82IHWmlhZbFU2akdXEAKn9l/FVm5pVqGQH8178iPIx/Bfi1pnbnXBD?=
 =?us-ascii?Q?cbiIbGRnWFAgna7PnVGSFicXOzNba/255N8/gqhXCdToJ9o68I/s1S+Bob58?=
 =?us-ascii?Q?zpi6QghUU81zmzaOxmU1Q/dBBVhuYhLaIkPWjtmFNlP3R+XU4DvG/jWpCLFN?=
 =?us-ascii?Q?lGE/2AvE1PRZh9fm1PM1j/BS0Du9n7X3Abw55d0t8vWoIxJAf7W1Vrc2SK9m?=
 =?us-ascii?Q?j+d3vdw0eAecN/MTRFMDEemMKLkqawwMD2ReeAaY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1HXDxKoHbhrodvBIV8WC/eKW2DKNyEvITSTEKgCQGscmwY8WCJk+AxEOL4lqi4sFgd+8Rpy3pp8ExY+isLHlZgm1aJH3+czMoZBJ4topoGKTLsdg8b0gKek3COaIjqqHmLpcMQvHlmg7gz3KXqDfxEmzCMZfiyeV72mxU8xSwXmsmxDj9hOChOgLLa1LxX2110oJuYoh/O5+8m4G2LPtYaSzLGi4XiHFUtdjpSydaTervb1lbmPbovutmDLi9sJk6Jra/72QPo/VUi9KuUWBOX+F+rJxLZC7QPS5goimoZ6ju1NnbJPoURPlUHOUrAyr+o+5a6HyGPkvYH3Bmui3xOl4Jzf6odb2QnZLas5HtW4BJqBGRs5jJrzZah4VWNukYv6ZYwkTMdeSSt8oJcxjGGcJeazfvOGcuaPOUFOiuqqYV8gjVe86w5ZfKvp2b1kdaqBjwR9AmBPb0aBkhdMIFVZLZt72bNW3L6UfgVsr2zuGG62275jUfGRgJr6QtK/KQ4/eA8dzMv3oqQhNaUearsZQRXycBPUaKe7oxYRe3Me1s2isuG+0RZF4Rd2n6ISFQqth12VPwyylAbIUA1c4O9tVSJC/lcK4wETDgtg1CiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b776e5e-db7e-4635-dc0d-08dd54a9e24b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 08:04:38.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+xhBlt6dnZkpQO6VT6RqpexoFcjES3E9VTHtH5dl7HcyLqJOWoDyGN4wgeuH9hqOe7tpAhRmkQzHkG2VKwDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240058
X-Proofpoint-ORIG-GUID: 5WmcWfNgLmgJuv9A5PEe3_akeY0zxbs6
X-Proofpoint-GUID: 5WmcWfNgLmgJuv9A5PEe3_akeY0zxbs6

On Fri, Feb 14, 2025 at 05:27:37PM +0100, Vlastimil Babka wrote:
> Specifying a non-zero value for a new struct kmem_cache_args field
> sheaf_capacity will setup a caching layer of percpu arrays called
> sheaves of given capacity for the created cache.
> 
> Allocations from the cache will allocate via the percpu sheaves (main or
> spare) as long as they have no NUMA node preference. Frees will also
> refill one of the sheaves.
> 
> When both percpu sheaves are found empty during an allocation, an empty
> sheaf may be replaced with a full one from the per-node barn. If none
> are available and the allocation is allowed to block, an empty sheaf is
> refilled from slab(s) by an internal bulk alloc operation. When both
> percpu sheaves are full during freeing, the barn can replace a full one
> with an empty one, unless over a full sheaves limit. In that case a
> sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
> sheaves and barns is also wired to the existing cpu flushing and cache
> shrinking operations.
> 
> The sheaves do not distinguish NUMA locality of the cached objects. If
> an allocation is requested with kmem_cache_alloc_node() with a specific
> node (not NUMA_NO_NODE), sheaves are bypassed.
> 
> The bulk operations exposed to slab users also try to utilize the
> sheaves as long as the necessary (full or empty) sheaves are available
> on the cpu or in the barn. Once depleted, they will fallback to bulk
> alloc/free to slabs directly to avoid double copying.
> 
> Sysfs stat counters alloc_cpu_sheaf and free_cpu_sheaf count objects
> allocated or freed using the sheaves. Counters sheaf_refill,
> sheaf_flush_main and sheaf_flush_other count objects filled or flushed
> from or to slab pages, and can be used to assess how effective the
> caching is. The refill and flush operations will also count towards the
> usual alloc_fastpath/slowpath, free_fastpath/slowpath and other
> counters.
> 
> Access to the percpu sheaves is protected by local_lock_irqsave()
> operations, each per-NUMA-node barn has a spin_lock.
> 
> A current limitation is that when slub_debug is enabled for a cache with
> percpu sheaves, the objects in the array are considered as allocated from
> the slub_debug perspective, and the alloc/free debugging hooks occur
> when moving the objects between the array and slab pages. This means
> that e.g. an use-after-free that occurs for an object cached in the
> array is undetected. Collected alloc/free stacktraces might also be less
> useful. This limitation could be changed in the future.
> 
> On the other hand, KASAN, kmemcg and other hooks are executed on actual
> allocations and frees by kmem_cache users even if those use the array,
> so their debugging or accounting accuracy should be unaffected.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  34 ++
>  mm/slab.h            |   2 +
>  mm/slab_common.c     |   5 +-
>  mm/slub.c            | 982 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 973 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index e8273f28656936c05d015c53923f8fe69cd161b2..c06734912972b799f537359f7fe6a750918ffe9e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
>  
>  /********************************************************************
>   * 			Core slab cache functions
> +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +
> +	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +	if (pcs->spare) {
> +		sheaf_flush(s, pcs->spare);
> +		free_empty_sheaf(s, pcs->spare);
> +		pcs->spare = NULL;
> +	}
> +
> +	// TODO: handle rcu_free
> +	BUG_ON(pcs->rcu_free);
> +
> +	sheaf_flush_main(s);
> +}

+1 on what Suren mentioned.

> +static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
> +{
> +	struct list_head empty_list;
> +	struct list_head full_list;
> +	struct slab_sheaf *sheaf, *sheaf2;
> +	unsigned long flags;
> +
> +	INIT_LIST_HEAD(&empty_list);
> +	INIT_LIST_HEAD(&full_list);
> +
> +	spin_lock_irqsave(&barn->lock, flags);
> +
> +	list_splice_init(&barn->sheaves_full, &full_list);
> +	barn->nr_full = 0;
> +	list_splice_init(&barn->sheaves_empty, &empty_list);
> +	barn->nr_empty = 0;
> +
> +	spin_unlock_irqrestore(&barn->lock, flags);
> +
> +	list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
> +		sheaf_flush(s, sheaf);
> +		list_move(&sheaf->barn_list, &empty_list);
> +	}

nit: is this list_move() necessary?

> +
> +	list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
> +		free_empty_sheaf(s, sheaf);
> +}

Otherwise looks good to me.

-- 
Cheers,
Harry
