Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18A367;
	Tue, 29 Apr 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888955; cv=fail; b=DhYRZnp3omcvVVsYjEmkpsxeQw1KbwBQQ6PIsZ7jcGDk7KlMWBU88xOk0rDrLcrp4uQEFs6L6pM0PF4LgtojDhwVd3cukhEVvPKWQnRMG6SVWfTgVAaP6iS+f1UCE+T6qQdDgsCq8wzH8Vq9P/e9A76Hs0Bl1QQ4KYGcD0At1eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888955; c=relaxed/simple;
	bh=lmVN7Pegrb7ihiObkJ0/o1oPtOPHOrR4CjQbIh3I3OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D+hLHLjlFaoykTyGrEu52XceFFYZn2f4FGjD9A1LrOSK7soyvcihYQhcW/OVT8ADDnbYV1I1gOUxg2F3RRTLcpFXB9ixLs/yE2DwJ4qS1Ni3SvP1a6+dkavYzYEFIz3fOiFmsyzpja8SJntR8N/OeLxUVeOc3RaBmGGL0UUs364=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fk7wL+XR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WjmxPPE8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fk7wL+XR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WjmxPPE8"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T12vh6014031;
	Tue, 29 Apr 2025 01:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jOGOL6Vf6Y4w0WOMRf
	/nt5ybLOFV8nQQ/w9DW6DpXNk=; b=Fk7wL+XRVGJepvfyfIw+Zn84zCLS9qqW3U
	hdI6oAf0gvsY+wljbiUfH/5X3vc42QmpVHVkTJVRrBfHT99tGUjmHhO1UuBaxzbg
	djuRYPKhFiPcKaimI+RJVX7QZ+GxLVM+JHvMa9t9FryBO4Wm/vDgf/C7DCOlq+71
	opeSVMy9ne+XMertqtrD8CPRKCmoFv7QdbC7XXES9tmR1+Llhd6ki0lrU62eczEX
	lTPBVzx7LmnjrpJo0tbodlEUNZnrjQ0Nd9G9rCIX/Rs8W6anrAG45M7ALPyW9AK+
	13Ei+DmfoA0DPLaFWiskPfN8m4uPRGD24c8KBtAAAR8bBdlio7PA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46amre0059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 01:08:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMsMGT033466;
	Tue, 29 Apr 2025 01:08:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx9666r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 01:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYkheWDY0nIdswoZEXzU/ZEkBb5xdkvsaNxaQBYB5DK/naHtnOoGCs/Hz7OC7nrHJZbmQCor9UUwQ9rVwBa4TAGq0Dd/Ef6F/+I1+GoKDt5vqZpTqiZjDi+4uX1pRa2BpCcQB8pF5Tg938l9zFH+p4SooSnMZB7afFbwF3l9I2H/oVWmagWhJ/TPRwMCpn3u36I+tY+E3sjZyyzSxVMt7gTB+sLkdIZ1qttkz/JJKfWJg9TEk3OMdhF4T//TaNfrZS30kr49r7vbW+gWcr8UniOzcmlCer7f67IS1Omb9MGB2qz0fpbINVyfRhxZfUi3dF47FL5hZVCotueYsu12xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOGOL6Vf6Y4w0WOMRf/nt5ybLOFV8nQQ/w9DW6DpXNk=;
 b=AA2+ccu8pgGaA4hTQiwRAt+86dQTyoDDKQVslosLfV1qU4folwI8UdDnnVc1DU/BXyX3+m/OBXM/+PCMl4xgB1slzGt+Djm9JtZcj/Z2rlOIzzYKFNalzDq4VNxwnFF18MoOER7XDxC4rxIlVTJWAj2l0mHlHoED+BeTwCr0JxIcwNFxO/ixKKNdfmNebZbBt1v/miTQs/DbxBwxY2FlCmaH7tL5FuZB/Tkz5/S+gQGoOMO/fViRxBcroYYmRTZu5wEf0q1owy3QMDyQBcbWUJ3kHSrSr4pdLoQKYPtIKAWA3XLUxrjbH35885KWrk1Ob6pE/t544OQ9yxbISVTBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOGOL6Vf6Y4w0WOMRf/nt5ybLOFV8nQQ/w9DW6DpXNk=;
 b=WjmxPPE85YljRXkdzPjhPYB84HsPKi/rdYN1Keu1Pg2nqlABRG9AnjYX8srz+9Djdov+TYtsdf/HVXxB2xa1z29kNA8Yp+tLXpZ7aW/kPHVtdD2qD6NMyH+QdeyjK6guHN1z20oAdQ7Ot6q1CKgyGy7Cdm4giMzfiMvrJbCfFv0=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 DS4PPF3984739DB.namprd10.prod.outlook.com (2603:10b6:f:fc00::d15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 01:08:51 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 01:08:51 +0000
Date: Tue, 29 Apr 2025 10:08:27 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
Message-ID: <aBAmi38oWka6ckjk@harry>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
X-ClientProxiedBy: SL2P216CA0075.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|DS4PPF3984739DB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abbb566-773a-438c-7cb7-08dd86ba5da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnuATpr/MJ4UFZFFjqEMlSZqcf2k6l7mkZoACFej3cs5dR4GqOZSvPwxrLC2?=
 =?us-ascii?Q?CPGMzOmpvqS4WXgRC+9NZntJwYeoukIoodfpqPk85TDVeVrZC5wfpuzIxppM?=
 =?us-ascii?Q?G/T+t93K5NcuLKeAO85ULAtEnyY5mtnz4fj3otTe2/aLI1kQt9T+7sBizEty?=
 =?us-ascii?Q?RQWJ4WE4meCA61y53cdITkiYHyzk9cY/lPOWPwa3CIV6tTVoUU2eVHjkkURf?=
 =?us-ascii?Q?ixld2DxwbBCpLgXnaNUkwInVOE/D15jBbjQ/9vZCJvg5J4owSRRE/jpkfTTy?=
 =?us-ascii?Q?x+rbSlU+9AQ6vgEIDCjDIuN0zKd4W/QgeOwztKl4RR5t8m12DzzQk10/4DHq?=
 =?us-ascii?Q?t5K6ZMBwrJVUyeDytQSbF0SXOXOrfo+ExJleXz2pPQ7FxQqxRuJFhwB+r6q9?=
 =?us-ascii?Q?JP+cwv1ezadyDdwkqVGe1jGAvfd8e8RL3dRyeNNi0kykxKmZTDB52d35Eo2X?=
 =?us-ascii?Q?gl/DS3d+vzD5VhEv5lc+ynqXNyg2NjMMWJOsfcec1rDqsgoq8JjWcBykeVVX?=
 =?us-ascii?Q?zuLuUnFczKBOP0pFoBxQ9qm/X06Ni/LH/E88BMwiAqMmYlTWbGt351a1xG7K?=
 =?us-ascii?Q?U5lbmVpSHAhi4v9qrx/waYMWRTLFSxBIP9WIgC6xNl9A6kpdidNVWaUq1o56?=
 =?us-ascii?Q?7qMHorY2LkYBA0Kv/8hlk9W0CAVRfsTm7FAubuvO88D+ED08QTjr67Kpx6Bg?=
 =?us-ascii?Q?iOeZ5Qq76HIOemKvnkOwaU3p2tveTpNpTl/ZY0Zt+/uuNFL+hD0WQHh9UNXI?=
 =?us-ascii?Q?4CP6RNAaBuaISuSVKiVuh8xRdD/yMqzD3Y8yumA9/4yB8XZOcA4lj80Tonb9?=
 =?us-ascii?Q?FMv6xqDm47iB1+T6kIPS92pczr1Gw4XPyv8X/RmvRGgyYTUZY9+yZ1KRYP8e?=
 =?us-ascii?Q?ZnjV5JvJVPFe+QzWP3EN4+ry8+UNznOALtl4DPVNZDOGjrWKOat7IJNA4d0T?=
 =?us-ascii?Q?gtMj1S0kwbLp6sojyaE6/o9wM0sed+78g7Pq18xI3/xIdqpKpaq7jNg1BP14?=
 =?us-ascii?Q?XeI7cUck3sSfWq/sWBKCZCUy7DdN/2H9UAS4b9UCInnjTjR28PoEYFuO90k0?=
 =?us-ascii?Q?m3YEDH1sAvL+N3vSVnsPz8C7uMJIatzAUxdSVUmgpJm+qd18hZhwoXpVtrvs?=
 =?us-ascii?Q?vomVIsLmL4UZRQ+D1G8e84r9EmGPB3UUEtnx+seMIWb7FPD7Wti0GLBKg+W+?=
 =?us-ascii?Q?d/Cf4PMS/yO7ZKc/nQqXgjK9FUaaGzqZgVRPNVTKZnigpAQ0aNGsx/4ukt0p?=
 =?us-ascii?Q?JhktrYSM10ysWKembokAqxVuXcsvAyAKydkHoTT7Puyml/+J315fjtji3uA1?=
 =?us-ascii?Q?gkhZY8yoaseQMtPEdb8oHBj+tbSo2nvs7b5ErTTlI3T2ykz6imAqEINTnDer?=
 =?us-ascii?Q?oLLC+UWZ2+egqxJbPrkXh2tG01XMv+AgCE8oXdT3lwOs+ltIGwqiMD2xn9/E?=
 =?us-ascii?Q?wstBf7m9d0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNEcj9ksAOuhY4utvY/Y8qXugN/U4RgkDbEpXOXpKyRNfRA61I71oY4YWadv?=
 =?us-ascii?Q?abHke4u1tt0N1+SR2KHfo99dkV1FRw7NUdcPrvavkOf/AVtfwVenc3B1vB1Z?=
 =?us-ascii?Q?AfZBS28wgFLs1MrLLdwxIhc0SPZJzvzQZeU5GpAACP0cyuP5JXAtQbjm+HKb?=
 =?us-ascii?Q?c5CmDCMnMygB+fQuINeod+8/HEbG4uTR0CzpkfJFNamO6/gZWM1LdC92TlRM?=
 =?us-ascii?Q?SRUzjRTNwTrvlDQazkCQTa6vNMhzaCuJLBOk68Vw2JLHtlYAhLH27OaziLiN?=
 =?us-ascii?Q?YBv83aqgsNw/KbPS9pznaGVz3mr87ul1n0zg/lR7ccaLIk+uGxpPGmJMBCY3?=
 =?us-ascii?Q?dQawDO7f2F3wJPBPDniECeKG2FFURcdAknN/Mo2SYB7ycVEHdw4uRkLIQAcr?=
 =?us-ascii?Q?orrDum5UTfSTp+crjw915ZpIs0d+NA9ynVi7MEkzRb9zq5zZ8Sh0IwxDQIu2?=
 =?us-ascii?Q?xBvorlich7+/rMacMuqgy9zvdY2s2c3PGDMlqA4QRTXsAZCUApR65QEgxiMa?=
 =?us-ascii?Q?PpUDxdMAVPFZ8L5izFTA3ooAymW7YA+urhFqlGboP524VKA8U8qdaom4edlU?=
 =?us-ascii?Q?vArTdC6O6yotVuDDMEBZiEq5Lss7lHithXGLlXmUXMOpkMUjGBLA3AUl3rWY?=
 =?us-ascii?Q?rjemMCOFE6VW9PdTB97Yp0T9bmEAbpbagc3Q4sYGOUFDm6xwozS5IH9clghX?=
 =?us-ascii?Q?IUZqzwVVG2D1+OifnvOh259ptcvWOQpPjKI89lWO803guV4xzVe4MkFD3Vjd?=
 =?us-ascii?Q?WMSNlGXfCUvcXUEidpYXKzbnUZGleztQUjP1jJI53P52EFXo944Cf9UE7eIz?=
 =?us-ascii?Q?xIwN6H82r0sHHqpHKMNu1yI9yvJw8M7bAicMUq0dJ8yQm7HtFhF+HwgIZG+l?=
 =?us-ascii?Q?XdxFkkEcamRM3JERoOPlPGiR77CXjr2wKaKd1DreDTMEwUnWQjufagRQMNZ9?=
 =?us-ascii?Q?sesqjv1co0Cx6DvAJqb4RKUBcFwW7Op9665bdHc5V6MJBsye64TgNbTpxAPj?=
 =?us-ascii?Q?ZktnVIpf4xi8caYZDg7SyHgjOX3b1jylNCEmUqmZ/wKJNL4qUhaKCV7Y24eB?=
 =?us-ascii?Q?/Kpoh0urwxaUg0vVyLmSIIS92TREe9rZEbl9khZsYbDdJzeoSk/IDW9TDG1R?=
 =?us-ascii?Q?PbgL++7XyCLgLhwA5+wkufhC+2Q/aePyBLtLCZ4GXQmiFhcX6dXK8Hb6kGtP?=
 =?us-ascii?Q?HoQ907LF4W1D7dkhfkk4U+cv9/x4t2QTWu7LTHwN30DM/jFEE22LV4cdlVYT?=
 =?us-ascii?Q?pjbVt1dp37fdaad3NyVecgYLkOji4ERMl37XpMsal9Zt0ipPQedIX3WQcV/l?=
 =?us-ascii?Q?lAjfxesSG6e/xpR1BKU/+6iKBbH8KWHLJwVtUwfSx4HOs8Av1JfmNslkb/dJ?=
 =?us-ascii?Q?xij9hsILl4fkFIxPvpYo9besR3GXSKpTo5JTp+UTQtK+m7JEZrX/qHK/yMqV?=
 =?us-ascii?Q?rnsHSL6LNgjtM/FO/A1Klljz+OmqhP5eAG01dtPqOQSGc6iveaybjwIR5B0j?=
 =?us-ascii?Q?6v6rX6KaYbnFRQ908eKF3SIOn1QNBgPzfh0DJmOL8JvskZH94LStT/Kc/ZaL?=
 =?us-ascii?Q?QHs4JwpTS2RD1SQ+YUvo5ndkxOFaz9XwGJ9ecY2A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XihEglFAy3XY0mkv4VDNIq8UWgaHUdBxuFyRVDNT5t/diflj0KJEWZrQkB7WzV0HulHZT4uL+rpqip6R4DyPkMsy4tJmUfjUbqGtFs5PUQp0l8/xl1JiWuhqdTqNaQ5L1QvR+dfv6BnBWd9nNoFzHYqekG+H/7Q0J/AApK8qvLIu/8n5lrlVSSw6MyDToUAyAPlEvHwM8uFjVmX2KS334ho3dpRDGSvHStC8cQKZcBvLSJLzY+GREB3BLE/4GPkQOl12gAOqVJTZdtxloKEOkelFKtZH9G8k2Fbf8v6Fqa1KmdCbQXCB9QfQ1qiMu9pBwRYyO6VIAd5t8MjyK0IQmtB7l9BZTlESIyeRDm4MSXTK3WyJc0W7xlq4GjwkIlYXmaVkyLdCd249NcEjqH+iCllF67MEozDx2hbAN8TfHCPuU54h41z5w1PxuOVpvqeedfMNQFS7zwM2zia++MQaBVvhUANReqKjlj3icQdzmh5TM/Yuj+JqNeeVLMJ95Bww1WSdvnF8fXHmQuxaU8abC7tfAIG4HRwtOB6MZs+Ad+TjNMnRRdMpgi4YYhpCkjcXTGqL6DYuQfVGN9DT/VIfI4Z7l2dLVIL0L2y6mFXi/TI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbb566-773a-438c-7cb7-08dd86ba5da1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 01:08:51.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc7ec3a0I3zxpGymbkiGjjIMy+gJgY/gE4FS1x8iTWGc/RpdmnFM8MK+MRX+FmBDQzHU+UFGpXpJmrXLpYYR2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3984739DB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290006
X-Authority-Analysis: v=2.4 cv=d4/1yQjE c=1 sm=1 tr=0 ts=681026a6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Go37wd9on4-azaSdT40A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ZPHYrLf4bXh7lBhunI5kdwotNIjg6NAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAwNiBTYWx0ZWRfXzyVllxc7G+6s PW60ULp2AZg02FTtPcZyjiCDIuQjnh1gEbekY8BJSnTeiv06WcWOEcGx6w9UgMmWfE7SWr7QfLE KOz+hS4YzJ8TSymvwR2h+aveA+QbdMth5GMfWUrTTrjm1C0I112qApzSiecZpmv2atgYAmeJ5lP
 2mk1HsQfo7hSipHifznBf0EOBzra5aOowLARoLKSk1CMiClxPMGQabHL8ic+QJvS1FMpZCKMvrZ C3W1+nSEhGq4SyUbLedR1awVPkG3mhYga39dT2ND+6jgHUhfTDAyZZU9xrd8vNLtY3GPnqwSAz6 7z38caHLeh4vUo95QSXG0IQ2RO8W87rtkIsHRe2UeKQxICHjb8QgWKx+cLG6FvLSV+7z+az/Z0g wxzaA77V
X-Proofpoint-ORIG-GUID: ZPHYrLf4bXh7lBhunI5kdwotNIjg6NAD

On Fri, Apr 25, 2025 at 10:27:21AM +0200, Vlastimil Babka wrote:
> Specifying a non-zero value for a new struct kmem_cache_args field
> sheaf_capacity will setup a caching layer of percpu arrays called
> sheaves of given capacity for the created cache.
> 
> Allocations from the cache will allocate via the percpu sheaves (main or
> spare) as long as they have no NUMA node preference. Frees will also
> put the object back into one of the sheaves.
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
> an allocation is requested with kmem_cache_alloc_node() (or a mempolicy
> with strict_numa mode enabled) with a specific node (not NUMA_NO_NODE),
> the sheaves are bypassed.
> 
> The bulk operations exposed to slab users also try to utilize the
> sheaves as long as the necessary (full or empty) sheaves are available
> on the cpu or in the barn. Once depleted, they will fallback to bulk
> alloc/free to slabs directly to avoid double copying.
> 
> The sheaf_capacity value is exported in sysfs for observability.
> 
> Sysfs CONFIG_SLUB_STATS counters alloc_cpu_sheaf and free_cpu_sheaf
> count objects allocated or freed using the sheaves (and thus not
> counting towards the other alloc/free path counters). Counters
> sheaf_refill and sheaf_flush count objects filled or flushed from or to
> slab pages, and can be used to assess how effective the caching is. The
> refill and flush operations will also count towards the usual
> alloc_fastpath/slowpath, free_fastpath/slowpath and other counters for
> the backing slabs.  For barn operations, barn_get and barn_put count how
> many full sheaves were get from or put to the barn, the _fail variants
> count how many such requests could not be satisfied mainly  because the
> barn was either empty or full.

> While the barn also holds empty sheaves
> to make some operations easier, these are not as critical to mandate own
> counters.  Finally, there are sheaf_alloc/sheaf_free counters.

I initially thought we need counters for empty sheaves to see how many times
it grabs empty sheaves from the barn, but looks like barn_put
("put full sheaves to the barn") is effectively a proxy for that, right?

> Access to the percpu sheaves is protected by local_trylock() when
> potential callers include irq context, and local_lock() otherwise (such
> as when we already know the gfp flags allow blocking). The trylock
> failures should be rare and we can easily fallback. Each per-NUMA-node
> barn has a spin_lock.
> 
> When slub_debug is enabled for a cache with sheaf_capacity also
> specified, the latter is ignored so that allocations and frees reach the
> slow path where debugging hooks are processed.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

LGTM, with a few nits:

>  include/linux/slab.h |   31 ++
>  mm/slab.h            |    2 +
>  mm/slab_common.c     |    5 +-
>  mm/slub.c            | 1053 +++++++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 1044 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d5a8ab98035cf3e3d9043e3b038e1bebeff05b52..4cb495d55fc58c70a992ee4782d7990ce1c55dc6 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -335,6 +335,37 @@ struct kmem_cache_args {
> 	 * %NULL means no constructor.
> 	 */
> 	void (*ctor)(void *);
>	/**
>	 * @sheaf_capacity: Enable sheaves of given capacity for the cache.
>	 *
>	 * With a non-zero value, allocations from the cache go through caching
>	 * arrays called sheaves. Each cpu has a main sheaf that's always
>	 * present, and a spare sheaf thay may be not present. When both become
>	 * empty, there's an attempt to replace an empty sheaf with a full sheaf
>	 * from the per-node barn.
>	 *
>	 * When no full sheaf is available, and gfp flags allow blocking, a
>	 * sheaf is allocated and filled from slab(s) using bulk allocation.
>	 * Otherwise the allocation falls back to the normal operation
>	 * allocating a single object from a slab.
>	 *
>	 * Analogically when freeing and both percpu sheaves are full, the barn
>	 * may replace it with an empty sheaf, unless it's over capacity. In
>	 * that case a sheaf is bulk freed to slab pages.
>	 *
>	 * The sheaves do not enforce NUMA placement of objects, so allocations
>	 * via kmem_cache_alloc_node() with a node specified other than
>	 * NUMA_NO_NODE will bypass them.
>	 *
>	 * Bulk allocation and free operations also try to use the cpu sheaves
>	 * and barn, but fallback to using slab pages directly.
>	 *
>	 * When slub_debug is enabled for the cache, the sheaf_capacity argument
>	 * is ignored.
>	 *
>	 * %0 means no sheaves will be created

nit: created -> created. (with a full stop)

>	 */
>	unsigned int sheaf_capacity;

> diff --git a/mm/slub.c b/mm/slub.c
> index dc9e729e1d269b5d362cb5bc44f824640ffd00f3..ae3e80ad9926ca15601eef2f2aa016ca059498f8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> +static void pcs_destroy(struct kmem_cache *s)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct slub_percpu_sheaves *pcs;
> +
> +		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
> +
> +		/* can happen when unwinding failed create */
> +		if (!pcs->main)
> +			continue;
> +
> +		/*
> +		 * We have already passed __kmem_cache_shutdown() so everything
> +		 * was flushed and there should be no objects allocated from
> +		 * slabs, otherwise kmem_cache_destroy() would have aborted.
> +		 * Therefore something would have to be really wrong if the
> +		 * warnings here trigger, and we should rather leave bojects and

nit: bojects -> objects

> +		 * sheaves to leak in that case.
> +		 */
> +
> +		WARN_ON(pcs->spare);
> +
> +		if (!WARN_ON(pcs->main->size)) {
> +			free_empty_sheaf(s, pcs->main);
> +			pcs->main = NULL;
> +		}
> +	}
> +
> +	free_percpu(s->cpu_sheaves);
> +	s->cpu_sheaves = NULL;
> +}
> +
> +/*
> + * If a empty sheaf is available, return it and put the supplied full one to

nit: a empty sheaf -> an empty sheaf

> + * barn. But if there are too many full sheaves, reject this with -E2BIG.
> + */
>
> +static struct slab_sheaf *
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> @@ -4567,6 +5169,234 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	discard_slab(s, slab);
>  }
>  
> +/*
> + * Free an object to the percpu sheaves.
> + * The object is expected to have passed slab_free_hook() already.
> + */
> +static __fastpath_inline
> +bool free_to_pcs(struct kmem_cache *s, void *object)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +
> +restart:
> +	if (!local_trylock(&s->cpu_sheaves->lock))
> +		return false;
> +
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
> +
> +		struct slab_sheaf *empty;
> +
> +		if (!pcs->spare) {
> +			empty = barn_get_empty_sheaf(pcs->barn);
> +			if (empty) {
> +				pcs->spare = pcs->main;
> +				pcs->main = empty;
> +				goto do_free;
> +			}
> +			goto alloc_empty;
> +		}
> +
> +		if (pcs->spare->size < s->sheaf_capacity) {
> +			swap(pcs->main, pcs->spare);
> +			goto do_free;
> +		}
> +
> +		empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
> +
> +		if (!IS_ERR(empty)) {
> +			stat(s, BARN_PUT);
> +			pcs->main = empty;
> +			goto do_free;
> +		}

nit: stat(s, BARN_PUT_FAIL); should probably be here instead?

> +
> +		if (PTR_ERR(empty) == -E2BIG) {
> +			/* Since we got here, spare exists and is full */
> +			struct slab_sheaf *to_flush = pcs->spare;
> +
> +			stat(s, BARN_PUT_FAIL);
> +
> +			pcs->spare = NULL;
> +			local_unlock(&s->cpu_sheaves->lock);
> +
> +			sheaf_flush_unused(s, to_flush);
> +			empty = to_flush;
> +			goto got_empty;
> +		}

> @@ -6455,6 +7374,16 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>  
>  	set_cpu_partial(s);
>  
> +	if (args->sheaf_capacity && !(s->flags & SLAB_DEBUG_FLAGS)) {
> +		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);

nit: Probably you want to disable sheaves on CONFIG_SLUB_TINY=y too?

> +		if (!s->cpu_sheaves) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		// TODO: increase capacity to grow slab_sheaf up to next kmalloc size?
> +		s->sheaf_capacity = args->sheaf_capacity;
> +	}
> +

-- 
Cheers,
Harry / Hyeonggon
