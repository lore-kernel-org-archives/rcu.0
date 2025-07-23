Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05E19CC3D;
	Wed, 23 Jul 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281143; cv=fail; b=IWYFxVCnyUjpuO05BE1c3nH6nertOafKf9KbSD7yO//k5aaYbtsUboMP5AKb7WURDRrfIGDgvCt3ppqJxOsCATfH/7L9nN0k6jTLLyr2ktKV2EmwBmWX55CMxfkk3X2phEXpjg/MeIoEC2o4fcqNwrdSf9TjjjqWFOEBSQ5vmPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281143; c=relaxed/simple;
	bh=g5yxDW4XAXC9oF2kTU0lr2UMLb6LcMxEzbZQ6gByx1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aQvlsT9XDDYVmErRYL6DwBALBasxQXF4i3FCpBOY95P4pMiYxRyQIwkFKsyA5gkCgoziML2LDVlR0kyNnD4WrjRYvZXYc41euW+5BLPHWZeqSMcCLSKJik29ItWgcR9mkG13Y8hUryUzsR4kSd93730jptaXxp/stbvzKfb2PzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I749SZ2X; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I749SZ2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFhn736LkhEdOEXLm7FfHRkSWx8IqhQtMi9hrsTviEBkBw/f0ceGPwTp4mZbfj2czeWxTG4yYBWREsmjG25DTLYui7+/ognUuaLcohZ/Srh+SYgVoxihy8NraGg8phPsanD2wYJAIsP7nW3fUwj9TybXH7S7GqnucaB5T+sDkZRAgaI+laJM4QY4gntacNhqSheOcBLwQxPSoR03fyia5u1BS6BkOaYmjLW7WsaKq1m3rTCnlh112exsdSUDa2DnGaLcJ/kTCKsDe3Ot7eE5/tqyqwGt9FKLIN2mSPvSUjY2q05NO3st1J80NRLyl5cie4tM/albnXcqy26U3SsfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZYs1xl2XJDfbmaZyoT7XQ2mNCt2E46c/pY314Z4wtQ=;
 b=yaMQfcRNPhOWhMXrakEpKWdwLBTverFXGI9n5OwSO1glXP9ny0nKL0LZatrbvdWZRmZ1AONgZNfRj0A8q8uCqPcubJKgu/VgwGm7kaqIva4LkDXi4Rx1xNGZqVWqZF6siAhbkFVhoHS1Gywj4o5eYX+hIkMVVTnQQc6qbKEEGYQLqxme9+xkC2G6Z3YiwA9SKRnwlSJGovf28fRIdSkjRCyVBWUoRWMrGFfFYLgT5O8imeO8MH4LuEiQBLBXHnD+Qsrbw0eD0Gmp6lqqLHLNvcCz/zOhBrBTvjIQLU07phSmhgrnmRxXuqCyBuSZM2HTwuOPygK5JB+XwHdfmBWL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZYs1xl2XJDfbmaZyoT7XQ2mNCt2E46c/pY314Z4wtQ=;
 b=I749SZ2Xiqbxa5+6s/8dUumrH762sPZaDbig07l9aW1S6+iUZSPptSWWdTwvWuE17KxcWPkM4b3IMMQRiWH3KsryBu83WjOYjXyc84n6+7slJbEipua0szlwgNy8aezVkgcllxiPIz24MkNGDepo0F/QV36GKSUEEbE1OX+cPQJEHSCke2yv7JT6ajAVq4h+9LrZ858NNoTBAaJVkosRU96xU9uvk7lMvIYxCkJDDSybnHrTSQY74Kin+B51WxyXvCJO0xM08xWFpq+9/NGzYynIT4kvo5pi6s2TyZP4xBP2O54t5k1hRkwcPUtbVkfm/u0dMA7jIKRkNpw3RcpVbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 14:32:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 14:32:18 +0000
Message-ID: <092ec583-9ad4-4d37-8dad-6008267a56a3@nvidia.com>
Date: Wed, 23 Jul 2025 10:32:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix delayed execution of hurry callbacks
To: =?UTF-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>,
 "frederic@kernel.org" <frederic@kernel.org>
Cc: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
 =?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
 <Cheng-Jui.Wang@mediatek.com>, "josh@joshtriplett.org"
 <josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "weiyangyang@vivo.com" <weiyangyang@vivo.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 =?UTF-8?B?TG9ycnkgTHVvICjnvZfno4op?= <Lorry.Luo@mediatek.com>,
 =?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
 "urezki@gmail.com" <urezki@gmail.com>,
 "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>,
 "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 wsd_upstream <wsd_upstream@mediatek.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
 <aHj79rtgLm-7tT9E@localhost.localdomain>
 <2c69ead1047ff7b7671b8b577fe69884870f66fd.camel@mediatek.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <2c69ead1047ff7b7671b8b577fe69884870f66fd.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: a11b35c8-e6ed-41ef-66e9-08ddc9f5b9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFB5UFhYMTB2MFlvWVBZZW5BT1V5YmxnRklsamlBeHlXSkdGVFN3UlhLUzZM?=
 =?utf-8?B?OW9ZQ3UvRlZMa0ViZCtxcXRnb1RmaEZBNFdtVW9wTUhrbkpRL1JMK203NDVk?=
 =?utf-8?B?ZUxjaDZ6Y2N6MlAyN29aNWQ5QXc3L2dURlFCUVo3bGx3MlNJYzBidlJmbUFO?=
 =?utf-8?B?U0lwZjh3UEpDR2pScXVKL0NLZ05CZFBMYmdUTXRSN2NLRm90clAvb09MY00x?=
 =?utf-8?B?dm1IWm54WURmNi9TVUcyZStJZFZrZFlucUpmdmFkSXhmaEE5U2R5SUVvUDFB?=
 =?utf-8?B?MFkzTXpIdVY0am1sVHRBc1E4bHZDbzEyN3RJTTFqdk5JZTJCazQ2aktuYTdY?=
 =?utf-8?B?MkZDdXY4ZmFkR0ZwcFVkMW5iNlRMQjJYd0JXbWVpQTBISUloWXloZnR5Nytx?=
 =?utf-8?B?T1hYaTRtbzhuWG1ZWVpWejRYYmN1UEF6Q1ZxNUZ3aDNHWW10WE9ZMmVxWEtK?=
 =?utf-8?B?Mk1HZWxIWkJpK0dNSDBzMHQ2ZG1xWjVEVDhpdEJ4RkNRRkxSWkxhaFBMVWtD?=
 =?utf-8?B?QzhyQzhXZktkZkI2Q1dwMmxBSVhCWldaZ1pZUjJEVzZIYloycmNnKzFnbHlQ?=
 =?utf-8?B?ZHFZY2orOGNVNnJMd0xSaG5EcTJXYmptVjlDYytIanYza0p5dWZVL2pFZXEx?=
 =?utf-8?B?Mk0wY1hJSmZBNEFPWlpUdy9IQnpaSE11ZVJDZ0o4NlRUM0t1MTNVOWo3ZXZ6?=
 =?utf-8?B?NjB5VHBFOE4rVUp5ZG9razl3ZmU4dGpKN05XME9TWjN6UGVCa0ppVjFjV21T?=
 =?utf-8?B?MlJmL2dSQzF2RmdoNk4ycmNqT0ZYYnVva3lWdHg4SmtHWitrWGNuR3ZpUnVN?=
 =?utf-8?B?SklOaFFaVmRJNUhJOXFDUzJhL3dudjZ2VVBkN081VUZkKzB5RjE1Q2JVbFRZ?=
 =?utf-8?B?bkl5Nks0ZW5mSUQ1U0xlUFd2UUFLYjdSY211eEFQVlRHSUdSVkhkMVk5bVZJ?=
 =?utf-8?B?NGlLQVl5aGRUbjgxOWhRaWtYN2dyWjhqRjNXWkoxQ2srR2JuaVBDSkpCUGtY?=
 =?utf-8?B?Y2o0YnlUK3FLZmxCelYwRjRmT0QvMlZkdVd6MTVEeEVuMFU3d1cxT0RjSUQ4?=
 =?utf-8?B?bVJZbTJaM3gzUkozMEcyL2xaZlg5Z05qT00zQkUzeHJuZDhGc3F2RHVHcXMx?=
 =?utf-8?B?Z1RULzZCMW1pRjJrQlFGdDhmYkhQT2o5S2dsUVFOTFcyUFNzSE51dktRN3Ra?=
 =?utf-8?B?Rzh4ZGhvVUpSUno3U0lGM3N2aG9iVkNUMFdnZUJUdy84cUd2cCtFcDQ2UnJJ?=
 =?utf-8?B?RXFUSDFJRzI0QlRYWldyRVFCRXFnc1VwbEx0WlkrSzhBTktKcCtyVTNPUHpE?=
 =?utf-8?B?M0ltSVJaY1A3cFJhWjF1VFZUdWRhelVtUVNsRTdESVE4Sm05Y2k5WXVmTG1I?=
 =?utf-8?B?bjYxVis5OU9mbko2aG02akJBdWJUTnlvandXcnIySVJIK201bkxuYmFteDNw?=
 =?utf-8?B?aHNUWWpJZ2VnR1pOZHhSUksvRlNJMWVneHl1UUNVVE1hTmtwNi9HRkVVMTF4?=
 =?utf-8?B?NWVmdDdmT2tRZXliVWd4NjNYRFh4K2RmWngyMCsreXdDdzY4Rjd5VE9DMzNa?=
 =?utf-8?B?emtjSldQZ01TbkdGUXdrRXEySWs4Q29BR0k1L2liMG91S1c0YjROcjRoRlAz?=
 =?utf-8?B?U3h0NzRYWkk5R0F6enFGRFV4VzBaNERyaW5EeFVpZWwxd3poVDFwQkRna1Mz?=
 =?utf-8?B?ekJrVCtabmxQbVhoSUVDTDAyZTh1dE53eDN5bldVank2TXR5aHl1MEtRMTFu?=
 =?utf-8?B?WmxxZm5XZXJpQ3kwdjgwa1dVS0ljaXF1VWcrbXpMTFhVdVNJaEt1ajV4RDdD?=
 =?utf-8?B?bkYwdzJXSk83bkkySUgwOWZmRUxxUTdUY0wydEVZRzJJREpMS3hXR2RlY0Nx?=
 =?utf-8?B?SzRrTEkvZklWNGJpaVYyZlR0MkpLOXFNcUQvc3BjdFU3Zi9GQlFCL1FKZnQz?=
 =?utf-8?Q?nfruHoioL5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTRsMllmSHJOLzlUTGFOUmJhbDk2WGJCTHQvWEFVODFjTWk0dTBNUkhYUzRO?=
 =?utf-8?B?cVExY1VVSDQ2a2E0c1RzYnVCL0JuS3BBZXBzdnRvcjVFb3ZMQVo4KyswZEpE?=
 =?utf-8?B?NXp6RFVjM0JDSldpbHJmRnlKajZER2t5a3RWeDZ4dlhmRUdDVGozMFZKcXQ0?=
 =?utf-8?B?eGJKcXFGL3JId2ZHTWFGY3Nia1Z2K25TMlVHaC9Vb1hMc2owMTRkTlVkTjlV?=
 =?utf-8?B?eFBYc2ptbTF3R01hSXNJME50NXBiRzVIb044bXFCVjIrbGUvYitMRW1FdFF1?=
 =?utf-8?B?enpBNlIvUFRCQ0xkV2lLTmwyY0FiaUovYzFwMlRQN0pGOW1mRWgrRXUyWTVQ?=
 =?utf-8?B?WmFaRVVjTGN6djZORnpJV1doRE4yMWlna2M2dmlkeVNVZ0RXQVNjd0dNT2pa?=
 =?utf-8?B?SS8yaGd4RDVpUEQxVS9hZXlBaGlpSnVvcXo3emNQUW9hRGpZOS84TVJKdnE5?=
 =?utf-8?B?T2hZaTl5R3ZnTWxlSm03cGdDdENtTWduN2l0eHRDM2pVRmFoeVhKcHJzZVN4?=
 =?utf-8?B?OUcrSzB4VHc5aE8xSVR4VHVuZisybURlS2xiTE1Qc1JOZzI1NjFjMnB3OVIy?=
 =?utf-8?B?ZlZ2TVF3RjAvM2RFR05aQUdwUTdjcVhxS0pxT09NN01uWlhQaXZJaCtqTW1F?=
 =?utf-8?B?TDZmZ3VneWp4WGE5RUEzbWN3SE1RRGhQZ1Q5N1NrRFRoTkhBK1hEek5iYnBW?=
 =?utf-8?B?bk0raTJUWlo2NEZPL2lIOTZHME1EYnkrWVZPWWZiNzVTUzhmenpadmFXdC80?=
 =?utf-8?B?Z0tIMDE4cGpDeG1FVGxqUGNyZjBheDlxMk1OU295S1pNb1FrN1p1OWNHaGZH?=
 =?utf-8?B?UmRHNTZZVEFqeEJDQ3Q3eG1Ib0xqeVI0aFJIRGg1RXdEaWgweUc3b1dEUTQr?=
 =?utf-8?B?a0lwZGlxTWNncVZITEZpWnUwYnVpbUlwU2M1bG40SDlhWlhmOVZrakxvZkJu?=
 =?utf-8?B?bitaN0hkM1hpeTFHdXNOOGRSMktnaStjNm1mcERodWUyZmwzeEVEQjFBd0gx?=
 =?utf-8?B?a3dnZXExQzNuU3Jya2FNczc3QTFGOUxrOVVuK1ZPKzlNMWw2VUlIOXdWbmZJ?=
 =?utf-8?B?MSt2VmozS0hJVFU2dWg2R2hFeWM4aHRmWDc1NjVWdlpMaVYxdWd6ekUycWk2?=
 =?utf-8?B?Mm9sY24yNTg1R244OVFQNjByVkdXSW1XY252TXVDa3kyRllxSkpFSmY4aWs2?=
 =?utf-8?B?ZWdiYmZGSnlBVU9ZZ2dRWmJWQzQ3bERNaHBwbTQxWkdRcFAyc1VmRElXRU1T?=
 =?utf-8?B?NnlKcG5jR2NyWllDT0x0RkxpeFFlUi90bWZZU0JhWWhQNnFtTHV0OHF2d2xs?=
 =?utf-8?B?Q0JqVUVqY0t4T1dKTXFsZ3hWMnRBSzRHY3FDamF2ZHdaT1FXQjdITWwyWkY3?=
 =?utf-8?B?eW1CZmJWVzVva0Uzc3pNY2xvVFhqSjBibjZONjI4V0dFWE5oVThnRENTeTZ5?=
 =?utf-8?B?ZGFuVGFwc2NHRVRUUEJ1bTNSN016MWZKS0FuK3dtcURPZjdYdE9OUEE2c3pl?=
 =?utf-8?B?ekhmbm1BVUtKaGF6c0tQenhNMDlUWnVYbFdhaHNscUFlWVZhR1JlWGlsTVZN?=
 =?utf-8?B?Y3FLalgxcjltNkFFY2xPRnlIWDhhOG44VVo1SWNIcUNpZTJNTUxXRGsxbUpq?=
 =?utf-8?B?Yzc2MVNmUVlYZXlMODZ0MU05RHFOUGp4Q2MxajdWRkNVVVljWWhjazBFakh6?=
 =?utf-8?B?Ykdidklra1JJT1FNWEJUVTZmZHlySzM4NXN6bEpoZ3hvUUlhdmdOcWU0RTIr?=
 =?utf-8?B?SnRZQVJkSG9ROG4vZVlhaUM4M2tmRlN2Z0poQXhpVWtJNkViY3o2S2d3MExI?=
 =?utf-8?B?N3VRUmxKbVZzOGI5bWZvMjVpSTJIb3MxaWFDNHEyeEl3dEk2RU81ek9NV1Q3?=
 =?utf-8?B?ZFQza0lWMG1neDlaOVVqRkNQMzYrdHM5NU9IcTV4VUVXSHRoUWZWNzVTQzgr?=
 =?utf-8?B?MXdoTGIvTEdJZEdOL2QyTlQ5VGlFUnV5Z2h0aUpibXhUNjhMMWVzT2hSSWhF?=
 =?utf-8?B?S1BuNGdCREl4YytYTU5Da0VuU3FjUnptOEdFL3FPWnhacnJoOXBXVm1oSnFz?=
 =?utf-8?B?ODRCOEloRGx6RFdKQ0k0bTdRcm5VWVgrMFlLdDBFZUNxTXpaSUs3ckVURFZU?=
 =?utf-8?B?YmErTUx4ZWUxVDZ6ek5FSzhnbUtJeEd2RUtsQ2FiRmI0L3A0KzZxK2xDUFVB?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11b35c8-e6ed-41ef-66e9-08ddc9f5b9f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:32:18.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOnq8pGThYiBOisei+s1qGp1lnj8BFA5lEnxq4bP+0e2pgSmr8Mc11pT14Ivdl39r7JfTbQwXgT5jCVV/+PFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356



On 7/18/2025 5:10 AM, Tze-nan Wu (吳澤南) wrote:
> On Thu, 2025-07-17 at 15:34 +0200, Frederic Weisbecker wrote:
>> 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>> 
>> 
>> Le Thu, Jul 17, 2025 at 01:53:38PM +0800, Tze-nan Wu a écrit :
>> > We observed a regression in our customer’s environment after
>> > enabling
>> > CONFIG_LAZY_RCU. In the Android Update Engine scenario, where
>> > ioctl() is
>> > used heavily, we found that callbacks queued via call_rcu_hurry
>> > (such as
>> > percpu_ref_switch_to_atomic_rcu) can sometimes be delayed by up to
>> > 5
>> > seconds before execution. This occurs because the new grace period
>> > does
>> > not start immediately after the previous one completes.
>> > 
>> > The root cause is that the wake_nocb_gp_defer() function now checks
>> > "rdp->nocb_defer_wakeup" instead of "rdp_gp->nocb_defer_wakeup". On
>> > CPUs
>> > that are not rcuog, "rdp->nocb_defer_wakeup" may always be
>> > RCU_NOCB_WAKE_NOT. This can cause "rdp_gp->nocb_defer_wakeup" to be
>> > downgraded and the "rdp_gp->nocb_timer" to be postponed by up to 10
>> > seconds, delaying the execution of hurry RCU callbacks.
>> > 
>> > The trace log of one scenario we encountered is as follow:
>> >   // previous GP ends at this point
>> >   rcu_preempt   [000] d..1.   137.240210: rcu_grace_period:
>> > rcu_preempt 8369 end
>> >   rcu_preempt   [000] .....   137.240212: rcu_grace_period:
>> > rcu_preempt 8372 reqwait
>> >   // call_rcu_hurry enqueues "percpu_ref_switch_to_atomic_rcu", the
>> > callback waited on by UpdateEngine
>> >   update_engine [002] d..1.   137.301593: __call_rcu_common: wyy:
>> > unlikely p_ref = 00000000********. lazy = 0
>> >   // FirstQ on cpu 2 rdp_gp->nocb_timer is set to fire after 1
>> > jiffy (4ms)
>> >   // and the rdp_gp->nocb_defer_wakeup is set to RCU_NOCB_WAKE
>> >   update_engine [002] d..2.   137.301595: rcu_nocb_wake:
>> > rcu_preempt 2 FirstQ on cpu2 with rdp_gp (cpu0).
>> >   // FirstBQ event on cpu2 during the 1 jiffy, make the timer
>> > postpond 10 seconds later.
>> >   // also, the rdp_gp->nocb_defer_wakeup is overwrite to
>> > RCU_NOCB_WAKE_LAZY
>> >   update_engine [002] d..1.   137.301601: rcu_nocb_wake:
>> > rcu_preempt 2 WakeEmptyIsDeferred
>> >   ...
>> >   ...
>> >   ...
>> >   // before the 10 seconds timeout, cpu0 received another
>> > call_rcu_hurry
>> >   // reset the timer to jiffies+1 and set the waketype =
>> > RCU_NOCB_WAKE.
>> >   kworker/u32:0 [000] d..2.   142.557564: rcu_nocb_wake:
>> > rcu_preempt 0 FirstQ
>> >   kworker/u32:0 [000] d..1.   142.557576: rcu_nocb_wake:
>> > rcu_preempt 0 WakeEmptyIsDeferred
>> >   kworker/u32:0 [000] d..1.   142.558296: rcu_nocb_wake:
>> > rcu_preempt 0 WakeNot
>> >   kworker/u32:0 [000] d..1.   142.558562: rcu_nocb_wake:
>> > rcu_preempt 0 WakeNot
>> >   // idle(do_nocb_deferred_wakeup) wake rcuog due to waketype ==
>> > RCU_NOCB_WAKE
>> >   <idle>        [000] d..1.   142.558786: rcu_nocb_wake:
>> > rcu_preempt 0 DoWake
>> >   <idle>        [000] dN.1.   142.558839: rcu_nocb_wake:
>> > rcu_preempt 0 DeferredWake
>> >   rcuog/0       [000] .....   142.558871: rcu_nocb_wake:
>> > rcu_preempt 0 EndSleep
>> >   rcuog/0       [000] .....   142.558877: rcu_nocb_wake:
>> > rcu_preempt 0 Check
>> >   // finally rcuog request a new GP at this point (5 seconds after
>> > the FirstQ event)
>> >   rcuog/0       [000] d..2.   142.558886: rcu_grace_period:
>> > rcu_preempt 8372 newreq
>> >   rcu_preempt   [001] d..1.   142.559458: rcu_grace_period:
>> > rcu_preempt 8373 start
>> >   ...
>> >   rcu_preempt   [000] d..1.   142.564258: rcu_grace_period:
>> > rcu_preempt 8373 end
>> >   rcuop/2       [000] D..1.   142.566337: rcu_batch_start:
>> > rcu_preempt CBs=219 bl=10
>> >   // the hurry CB is invoked at this point
>> >   rcuop/2       [000] b....   142.566352:
>> > blk_queue_usage_counter_release: wyy: wakeup. p_ref =
>> > 00000000********.
>> > 
>> > This patch changes the condition to check "rdp_gp-
>> > >nocb_defer_wakeup" in
>> > the lazy path. This prevents an already scheduled "rdp_gp-
>> > >nocb_timer"
>> > from being postponed and avoids overwriting "rdp_gp-
>> > >nocb_defer_wakeup"
>> > when it is not RCU_NOCB_WAKE_NOT.
>> > 
>> > Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
>> > Co-developed-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
>> > Signed-off-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
>> > Co-developed-by: Lorry.Luo@mediatek.com
>> > Signed-off-by: Lorry.Luo@mediatek.com
>> > Tested-by: weiyangyang@vivo.com
>> > Signed-off-by: weiyangyang@vivo.com
>> > Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
>> > ---
>> > The regression is first observed by wyy in the Update Engine
>> > scenario
>> > with  CONFIG_LAZY_RCU enabled. there is an additional delay of 4–5
>> > seconds during the heavy ioctl API call, waiting for
>> > percpu_ref_switch_to_atomic_rcu (RCU hurry CB) to complete.
>> > 
>> > Initially, we suspected that the percpu_ref_switch_to_atomic_rcu
>> > function itself was taking too long. However, after enabling some
>> > custome and the following trace events: rcu_do_batch,
>> > rcu_nocb_wake, and
>> > rcu_grace_period. we found that the root cause was that rcuog was
>> > not
>> > being woken up in time to request a new GP. This led to the delay
>> > in
>> > invoking the hurry RCU callback (percpu_ref_switch_to_atomic_rcu).
>> > 
>> > Environment:
>> >   Android-16, Kernel: 6.12, 8 CPUs (ARM)
>> > 
>> > Configuration:
>> >   CONFIG_TREE_RCU=y
>> >   CONFIG_PREEMPT_RCU=y
>> >   CONFIG_LAZY_RCU=y
>> >   CONFIG_RCU_NOCB_CPU=y
>> >   CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
>> >   rcu_nocb_gp_stride = -1 (default is 4 for 8 cores)
>> >   jiffies_lazy_flush = 10 * HZ
>> > 
>> > Contributions:
>> > Tze-Nan Wu:
>> > Collaborated with Cheng-Jui to discuss which tracepoints needed to
>> > be
>> > added, jointly analyzed the trace logs, identified the root cause,
>> > and
>> > proposed this upstream change.
>> > 
>> > Cheng-Jui Wang:
>> > Provided many valuable suggestions during the debugging process,
>> > repeatedly found breakthroughs when we were stuck, and helped
>> > identify
>> > the root cause.
>> > 
>> > Lorry Luo:
>> > Assisted in verifying whether rcu-hurry-callback was executed too
>> > long
>> > or deferred, supported with testing, and helped with communication.
>> > 
>> > Weiyangyang:
>> > Main tester who discovered the regression scenario, confirmed that
>> > enabling CONFIG_LAZY_RCU caused the regression, and verified that
>> > this
>> > patch resolves the issue
>> 
>> Nice team work :-)
>> 
> Thanks :)
>> > 
>> > Note:
>> > With my limited understanding of lazy RCU, I am not fully confident
>> > that
>> > this is a real issue. In my opinion, hurry callbacks should not be
>> > delayed by other events such as firstBQ trace event.
>> > If my understanding is incorrect, I would greatly appreciate any
>> > guidance or clarification from the maintainers.
>> 
>> Your understanding looks quite right!
>> 
> Glad to know I was on the right track.
> 
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> 
>> Since the issue is there for 3 years now and was introduced with
>> the CONFIG_LAZY_RCU new feature, it can probably wait a few weeks
>> for the next merge window.


Nice, thanks!

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

I suggest let us add the Fixes tag too so that stable gets it.

thanks,

 - Joel

