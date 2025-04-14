Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B327455;
	Mon, 14 Apr 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642593; cv=fail; b=I2cBRzu9z4p9LNi9CaAlWdqkpkp54RMLZS/4Lkq/Vzdd/SDBxrX7fatrOijTq+0RM6Oc+lO6DWGvm+p1rEQQ2FZzFLfu4vMOXYIuYO6H7I98104MemmGJnxLRv8eQEjKbaJJyNhjuH0HToZ4mBV9ZO64Wc3GMFcrQt9M2+qP1x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642593; c=relaxed/simple;
	bh=KwRopzNJy1H86Pe7O8qPEwlJxydMjIWWCPA9Ceihr/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvSw2t8LUDSJkzTc6RH9EcKs6EeOnx8Kf0OPF51DKRuoY9KW7fu3Ebd42BM7X6m0zBS/Z8Q/p9qywOh95eST7BZy+iyu5edjyliCkbKcXt+E9LrNnTKR1foNylcIExbxCvaLpdVcfEXg0JdrokQqfgny71HdiYxfWmOhq1A0aMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQIdLsAv; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQIdLsAv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDPHPAzQ0DLNOaCv71ncs9DO6QQt3GXmNuMTFT8zWMIFPTUJYBgzaxQN7z2DAJc5AgKUJUFq+rHtwNXV6Ko180BSC4Et2kw+pQyCbyT7A9xudPetDJDSbzfE57MrWjPBmJ7z6cryUnDWHxQ4yVAKVXtZsvcy8xVisfXjYdkqLoqclPeIPmyzxFlRILybQcBljPH349Qjju6t24TzbStvkbCY2UIEAzSOeGMwil2R/0G0+b3f58ZQziw+m/yNP/99m135vLGFb0KGfLX24NAef7rBaCaOgYM45prEYZatRlW7e5PRtQQtQhCPRWTaTnV/sllJHytyyv8PZ+0IBzhI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ2YAmnK0ETJ724JSrzCZwPL9bwnzZ4lMXYuHDknVOQ=;
 b=aHjdxTsvnbadvHQGeg4tr9BMHw4CrQb+XF7QmZCdp/ECLFnjS4AKNoJgYZ0p8CMortF5YbSnQJCUStsHq7K0ykxFqmJVcGjMMNl+tOydU8CuFmcVCcM0BmpTMsPs7xYS/xJzIKbBlPTBacAlwbYTaZoGInA5TS3u8/IgU3vtKd3kWNLbZbfnp5T0+jgkrqa8IbREskwg3bbqveaMvdNiPUYmdCQrHirI//UDzYM1WdjRPxrrXFfR9YjhhgECa4v3IhlDd7Kk/qhLOL41wN38/SwkQmSjfLVmhXtA9K5xtLC4UMw0C8eLomXR/vK+w4NQbnIHfw4RmNyoH2Y3fiRqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ2YAmnK0ETJ724JSrzCZwPL9bwnzZ4lMXYuHDknVOQ=;
 b=fQIdLsAvEKFWXp3W/R7ZL0EMzQ/nzqIgNbp1mwJ4/gZYU5pTwTvYBbkD70mx5gDUUZEpDCDBOc5qT8VsLDt7Jds1VbY4F2ILQR83fyttq5JRevCTBP85gs8tRojjvhupC9cydnsBI4WeEnX+RfGk44lgOZ7iZcBRGEMdQea0FrW9qU3UQblPWfiREkmq/qu6IyOSD9duiPpTxpmnCymWmHIJraymW3U4L74NiW2UPLjTj5xoUkx9lAmeN1paEnRmbtlk3OtXBGIxW1hdyYHu3f//z4G55cn/pt40a2m74a27gHSicdPzFdVZWWo25hGPZQ1nEg+l86F8kNNGaVOvog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 14:56:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 14:56:27 +0000
Message-ID: <8435b865-289a-488d-baab-3ba819b3cad5@nvidia.com>
Date: Mon, 14 Apr 2025 10:56:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
To: paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
References: <71ab408c-a01b-43a9-993c-4a55294e15ef@paulmck-laptop>
 <BE7C948D-5238-48C4-93E1-1BAE4CBBD391@joelfernandes.org>
 <75bdde29-55f7-4210-a3ea-ea859a0e3a1a@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <75bdde29-55f7-4210-a3ea-ea859a0e3a1a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0730.namprd03.prod.outlook.com
 (2603:10b6:408:110::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5846fd93-b529-4380-912a-08dd7b64883d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVRSSVpSaXRaMENzcWxGeko3Q0hSb0ViTFk0bmYzam1ycXZHQVFTaG5PRUFK?=
 =?utf-8?B?WVQwTE9yWW5PeWFOdTB3ckMvME5DWjg3c2xGamUrZEVvdm1VZnNScWI5czVM?=
 =?utf-8?B?RWlZOUF5a1M0YWtXa240YU5iQjFMcmNLZklUbG1ubUlBNDVQc2tCUHJYK2VV?=
 =?utf-8?B?TE5JcGQ3YW84M3dtZEtvN05ZUW5uR1FTM3V2Y29VQTQ4Ty9qSWxocWRXUFYx?=
 =?utf-8?B?RTJtU1BXdnFvSmdNaTluV0NIbm9zQWF1ekZobmFrT3pVdlhaQXBHdmdKTTNE?=
 =?utf-8?B?MU1ZZ093SUlxYTRyb3pJTDZyUHpVNGhRQm4veDZ6M2hVQlB2WW9BbjkzSGhj?=
 =?utf-8?B?bVhLVERXdjVPaEI2RDdKbE1hbFpIYWwySVMzUmJ3Wk5MMEZoRm9jRnJNRUE5?=
 =?utf-8?B?YlR2N1dkU09uSzFZR1VYUHJmcTF6anoyUXZXTjRKOXFoc3ZyT1h1WFBUU0sy?=
 =?utf-8?B?c3BMckd2a1ZUR2V0SGR0dUNEZnU4bWVCSTZoQ0tYRVVnUkhjbndHYVRVb1Vz?=
 =?utf-8?B?SC9ZeEJDd09iUmxCUjMvNTZ4WW9uSEFlOThNWVhzdDhXeXV6WW4vS3l3Mlkv?=
 =?utf-8?B?U2VyWWlTSXBzWkVPOHNiQ1d0S3Y1UnJoNVIwZmE2YTd0QnJYMWIvbG9oazA1?=
 =?utf-8?B?cUdxbWlsSmxzVlJHWkpOVHNFN2xxVkVQZG9mT1U3YmJPSko1WFcrTzVscDhs?=
 =?utf-8?B?Rk4zcU9MOUZBOGM1UnVZZDA3YkI2cFM0MitBSzloSWJPTkt3ZjFIWURhLzRJ?=
 =?utf-8?B?T3QzWlgrT1F1a0RwRVYwSkxQaUxPd1V3QktPdkR0NnVMUzR0d1ZPOXRKTEpC?=
 =?utf-8?B?RXk3aWlNREZjcVhlZFVFVlFkMUZxYVMra2NzbGpPaklsOExjQ2s4a3VmSEtv?=
 =?utf-8?B?OGJuVEZraUp1dnJ4eWUvRXBSOUs4R200VlUyeTZOWDRzL1hTaXJTMGplZGRI?=
 =?utf-8?B?NThGcGkwb0tyekpwMVNzMjRoenNlY09oYUxEY1YxYUpjNTRqZTZZV2kzdklV?=
 =?utf-8?B?YVlBdldLWnF3M3hmTndibU01OWpaWGtmZi9LMUFtM1pZNTlLNnBLV3VJMW01?=
 =?utf-8?B?VHViR2c3eTh2UFl5WXZWWkljNU0vbVh2emlzM3BJVHBIb0E0VjBFcjRQZUFh?=
 =?utf-8?B?OUV2RDMyNmxWSTdkakszVmtPeFowclUyZElHTWEwRFZZNjlHZ0FGWElJME5z?=
 =?utf-8?B?dGJJZFFMbHJ2K01KS1F0Q1Brd3B3Y3dHQWhMeGx3TEF1NCtLcVZEWmJwdmxi?=
 =?utf-8?B?VWdQWTcxOWRVRmVrVHkrczV5dmZlMUpRdjFIK3FpeXZLQm5jTUM2anRZYkZu?=
 =?utf-8?B?TE9nWXVZWE5zbFR2NEhUVmEwVFRSUzM2UFZWVkx1UElYU202SDcwcUFuNzFz?=
 =?utf-8?B?TGZPcFgySUFRcC9lQjBuZWszVXV4UjVXRWFuOVAxcFQzRnB1STZnb01qSXpL?=
 =?utf-8?B?c2tLaHM3dVdVdkZxOTM4bkM1TExFYUFGWndPSkU2RUU1ZURQQ1BHZDFzbWM0?=
 =?utf-8?B?VHptSGw4clBoR1ZmT1lOZjdQNGxBcXAzZ1VsSUVmYzRHang5QlFtL3dsaU5C?=
 =?utf-8?B?bUx4eStvditHSVJiL3NpUlRVYXpHWFhYaUdKMWdYVlZGdkxXcG9QaWMvNEdu?=
 =?utf-8?B?eGJLMGJTWEg2UjdBaW1HYmxCaDh4UU81MUNHZ01DVXNKMDA5MldVck5wRDdG?=
 =?utf-8?B?UHEyeHUvM3BXZlhleGVyZTYwTTdGWUFDZWZpT3d6aWF3V0UxTm1sSFlBeTlM?=
 =?utf-8?B?SkJPZzBUMnY5RHBWKzNSUHIrYVc3eXRyUDlpaGJTU1ZTbjJ1NG5Hb2s3RzF4?=
 =?utf-8?B?Zmh0cjcwWlFncElTS1FuWEwxRmNjbXNsbGlaTXZKclVQZ3JvZFRKRitFYzdv?=
 =?utf-8?B?SVVoZGQxK1Zab2I3azN6Qzl3MnBNczV2azZNYzNYa1Zkd2pKbUg4MlpRMERO?=
 =?utf-8?Q?oPhI0DQLzvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXYxZDB0cUl2ZDFKU1VXd3pqUFZ2ZHJtQWtqYUtTeVE2MGhBN0ZRRnlycnoy?=
 =?utf-8?B?TUZHc2JERUZheEp0L2ZNRFhjbHduTUFnNjU0RjNsbDV3TEJZcWVrOU1nR2dn?=
 =?utf-8?B?Ynp6T3dPNm9wRm5xZDZJTU9SQXJ6SE5vK21TcTNtYU9NWHRoT2RzSWVuZGtm?=
 =?utf-8?B?V0dzQjBCZGwzQ2UzWE5lVkZZM0x1K3FzUytuSm9xM0JWZ1QxcW13M2VZZEQ1?=
 =?utf-8?B?dzY4VTFZU0dGUnpFM1hYUnVrRVphQ2JaSVVtVW1FTzh2UWpKRlBOdVJLMThZ?=
 =?utf-8?B?R296L0N1am1ZZmlKU3BsclJROG9yb0VOaEk2b3NiVlhzUVc3akNnLzZGOUpI?=
 =?utf-8?B?blFnNStJaXpSVlYyanFUSElKZ2JQTTJ3VkNaRWJpS1hBQ0Y0dXBpamU4NFpF?=
 =?utf-8?B?Q3VxK2pYUE1yLzVlVy9ZeXIxaWJEbWh6dDg3Uzd6eGFTbFVVdUpzTXg3WXhr?=
 =?utf-8?B?QkljNFU1cVlIaU1EZFhUNnk3VlJreXg5cEZVWmN5NmJoR0FUbzUwRmFISmFZ?=
 =?utf-8?B?cHQrbXVjNzY3SEJlQThCcG1CYkQ2emJldHYwMUpoOFB2ZUEvZVVQMmY4UEs0?=
 =?utf-8?B?ZUtnbmVEellrMS8wakpTTnNnVWVrRFEzRjNwcFVkaUJXeDlDTVNvd3JaQjlm?=
 =?utf-8?B?aXBKUHg0VnFHN1NVZE93aE5wcG1uTkxGd1ZPb05CRWJpNjd3WE84ZUtlc09U?=
 =?utf-8?B?aFEyemorZGNVY3NCdVNyOGZ5UWU4amJTUHY3ZFF3VnhYVERHVEdFc2VIbkc3?=
 =?utf-8?B?SzVjREdrLzV1WmZmbUk3T21tT3hhYkZ1T1FGY0ZYSC9aR0dTZkc3Q280cXZ2?=
 =?utf-8?B?blUrV0lPQTNraGJ4a2RuMGJRYVNYaWVXY20rbFZ6U2VMbE5HaVdMcDBsZVJq?=
 =?utf-8?B?QUV2WXpRTk5FcXNXbW1uVUNpSStnWmFhZzJkOVVSV1NvdGNPMG53ZVBVZGVi?=
 =?utf-8?B?WG1xMEpFRERKRDA2bE82SVdQUlVVYWpxZEUrY2pGc2o4Rmp5UjlzWXd3NVlI?=
 =?utf-8?B?dkJDU2htUGZUZk1PbzlLRk9xcGg2emd3WFNCR1pZZHRQQk5iMFdVUHh3R1dJ?=
 =?utf-8?B?U05GTERCZlQxZFBpbEZ6M0hpMFhpUzZOWHZhTUsycTNSRlhaa0pDL0RTTmxB?=
 =?utf-8?B?SXRyeC95Q3doUjhaekhxaG9lZzZhaE4yR3hFZjlSbW5YYVZYb0ZyY2p0OGZR?=
 =?utf-8?B?UzRzNDl0elF2dFozaXM5ay83SWJ5czVuWWJXSkJUWlZwUk1PWHZMeTNUZm1v?=
 =?utf-8?B?K3U3TSs5eWR6K000RUhpUlptMllyMnVGMWhtQXFXSng5ZWVhZ0xCL3pFWGtT?=
 =?utf-8?B?STdMVjlsbDEvMXQ1VWdIREN2RGoxOUFselk3VTN1TnYyajBRcHhUWkE0TmZr?=
 =?utf-8?B?dnFYeVhzbmFQc21yRzdSc2V2SkJZbWpCa3NXbTB1TjlkWGFZRlROR1lOdHBD?=
 =?utf-8?B?cWhvRVZwSU05VU1mRVlTZUdsL09lT0UrT1dGSThSRGJicnBOdEcyeDdLc0lS?=
 =?utf-8?B?dDkrbGFHeG1zU1Qzc2FldGF3RFJFL3FIbFBJV0lTZlh4enhWcU93dDAxQkk5?=
 =?utf-8?B?QnVIWXY5R1Nza2JpaGpiQmdoYjdRbVhmdmFTR1pLWnpUOVhnMWpoNkV1djhm?=
 =?utf-8?B?bEg3V3NDMjVxNzJ5RVozTlJ5QXM5c3o0NVRWOWdnSnpEdEZwdjNEYjZLQ1o2?=
 =?utf-8?B?TmZsVnk3bmdKa283VGtjdGpQV09jYWQwcFAwTDZKcnJvSXlSOXY2aTFram9T?=
 =?utf-8?B?TXE1OGdtd2dtODR1RzlnZjBsSFZnNXlsNGpCTW9pMWZhNFZ0N0k3YjhQcjJB?=
 =?utf-8?B?RGpFaXZhWFNuL3U5UVhzb2N4em5aRTh5SHEyYkFhWkFPUWVxbXQ3UisxY2ps?=
 =?utf-8?B?N1QySUdjSFRrK3RUVUZyWWZHUFlqN0dTaFB6MDdzWVhNWmhZczdzVXBDSDhZ?=
 =?utf-8?B?U2RvMlNONXlrRlpLMDdOc3E0SkRZTGhKNzZ2bmNoU0Ntd0w4MFF0Q0dZQ2Fy?=
 =?utf-8?B?bHc5NWJYZm1TMS9ZbEhOcll4ZTBFMHJVYmIwTys5TXFUd1NuWTJCUVRMWkpD?=
 =?utf-8?B?cmI5THUvbVoyeElJZDhWSE1TVmRWbUIyZlpTZ2NQMUhEcGU1M0tpNDhQRUJh?=
 =?utf-8?Q?YmZJylKH/biT5Xq+JTe5OMBjJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5846fd93-b529-4380-912a-08dd7b64883d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:56:27.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYbRVJOH4G39/QOELYnMdUQ7iZ+i1VIQnha1VKZva9pwENLEQoXNlcLzHuYbn/iRfLIJy91muUzK5lr6TO+F+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332



On 4/14/2025 10:24 AM, Paul E. McKenney wrote:
> On Mon, Apr 14, 2025 at 08:07:24AM -0400, Joel Fernandes wrote:
>>
>>
>>> On Apr 11, 2025, at 3:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> ﻿On Fri, Apr 11, 2025 at 05:36:32AM -0000, Joel Fernandes wrote:
>>>> Hello, Paul,
>>>>
>>>>> On Fri, 11 Apr 2025 05:33:16 GMT, "Paul E. McKenney" wrote:
>>>>> On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
>>>>>> On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
>>>>>>> On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
>>>>>>> Currently, the ->gpwrap is not tested (at all per my testing) due to
>>>>>>> the > requirement of a large delta between a CPU's rdp->gp_seq and its
>>>>>>> node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
>>>>>>> set. This patch by default > adds 5 minutes of testing with ->gpwrap
>>>>>>> forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
>>>>>>> just 8 GPs. All of this is > configurable, including the active time for
>>>>>>> the setting and a full > testing cycle.  > > By default, the first 25
>>>>>>> minutes of a test will have the _default_ > behavior there is right now
>>>>>>> (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delt
>>>>> a
>>>>>>> causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
>>>>>>> at least add a little bit of testing for > usecases where ->gpwrap is se
>>>>> t.
>>>>>>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>>>>>
>>>>>>> Much better, thank you!
>>>>>>>
>>>>>>> One potential nit below.  I will run some tests on this version.
>>>>>>
>>>>>> And please feel free to apply the following to both:
>>>>>>
>>>>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>
>>>>> And this happy situation lasted only until I rebased onto v6.15-rc1 and
>>>>> on top of this commit:
>>>>>
>>>>> 1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.1
>>>>> 6' and 'rcu/torture-for-6.16' into rcu/for-next")
>>>>>
>>>>> This got me the splat shown below when running rcutorture scenario SRCU-N.
>>>>> I reverted this commit and tests pass normally.
>>>>>
>>>>> Your other commit (ARM64 images) continues working fine.
>>>>
>>>> Interesting.. it seems to be crashing during statistics printing.
>>>>
>>>> I am wondering if the test itself uncovered a bug or the bug is in the test
>>>> itself.
>>>
>>> Both are quite possible, also a bug somewhere else entirely.
>>
>> I may not get to debugging it for this merge window so I am leaning to defer it.
> 
> The usual cause is use of an rcu_torture_ops function pointer without
> having first checked that it is non-NULL.  But I suspect that you already
> checked for this.

Oops, I am not! You are right I think it broke since the movement into ops and
needs this which I missed for this call site (though I did it for the other). I
could repro SRCU-N without it and with the fix it passes:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 74de92c3a9ab..df6504a855aa 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2412,7 +2412,8 @@ rcu_torture_stats_print(void)
                        pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count,
cpu)[i]);
                        batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch,
cpu)[i]);
                }
-               n_gpwraps += cur_ops->get_gpwrap_count(cpu);
+               if (cur_ops->get_gpwrap_count)
+                       n_gpwraps += cur_ops->get_gpwrap_count(cpu);
        }
        for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
                if (pipesummary[i] != 0)

I will squash the fix into the patch and repost as v4.

> 
>>>> Looking forward to your test with the other patch and we could hold off on this
>>>> one till we have more data about what is going on.
>>>
>>> This one got lot of OOMs when tests of RCU priority boosting overlapped
>>> with testing of RCU callback flooding on TREE03, as in 13 of the 14
>>> 9-hour runs.  Back on v6.14-rc1, these were quite rare.
>>>
>>> Ah, and I am carrying this as an experimental patch:
>>>
>>> 269b9b5be09d ("EXP sched: Disable DL server if sysctl_sched_rt_runtime is -1")
>>>
>>> Just checking to see if this is still something I should be carrying.
>>
>> I think since it exposing boost issues, we should carry it! However since it is also noisy, maybe for short term we not carry it in any trees since we are getting close to posting the topic branches.
> 
> I am carrying it in -rcu, but marked "EXP" so that I don't post it or
> send it along in a pull request.

Sounds good to me.

>> Do you see the same boost issues or frequency of them when carrying it on 6.15-rc1 without any of this merge windows changes?
>>
>> By the way I have to rewrite that EXP patch at some point based on a review of it but functionally that patch is good.
> 
> I just now started a short test with it reverted.
> 
> Oh, and yours and Boqun's latest passed overnight tests except for a
> few Kconfig issues including the PREEMPT_RT pair:
> 
> 75cf58ef310a ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and 'rcu/torture-for-6.16' into rcu/for-next")
> 
> This is a known Kconfig issue in torture.sh, fixed by this -rcu commit:
> 
> 2e26af16b7b6 ("torture.sh: Force CONFIG_RCU_NOCB_CPU=y for --do-rt configurations")

I already merged this change
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/for-next&id=a3204f778cf7e37c7344404768398b4f9d43a368

But you saw issues in your testing even with this?

Could you rebase on top of my for-next branch so we are on the same page? Tag
next.2025.04.11a

I believe you said you were going to rebuild your tree, but were waiting on testing?

> 
> There are also Kconfig issues with a few of the KCSAN rcutorture scenarios
> that I am looking into.  And torture.sh needs to be more aggressive about
> reporting these...
Ok sounds good, happy to add these to my torture-for-6.16 topic branch once you
post them.

thanks,

 - Joel


