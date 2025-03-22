Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BD29D0B;
	Sat, 22 Mar 2025 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742609177; cv=fail; b=ufxXtPSoFajj4/WtlZ+j8nQEdLg6iZa+9K94X3Zqx6E8VgEbFCdph44NI3dS8PIZ1UaikOlZQ2E8i3vC5XBc+olqrT6ifuVN4j6PLGusTw7xiOPucPrHFpTefs3sPOyy3XwPGhNbij9QJsZmSNG53el+/6cUhbCfOpw/5+A9iMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742609177; c=relaxed/simple;
	bh=FL4rhKID5hHn+GmDBDf8W92JwBXmtwXUFOm2ms34nJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LsIiLWtH2Rt7Y3CYbAfmAheeF75QAmfoj1X+TWhOxNgjSgD6Z/BJoRFA/D3D5kGCfssTTEXgQu0E1ZqWoQnNOwjHaM9ZJPE/RgoukoSLYiD8m6WyscMFb51JIvcN7ivZpOnsQrv/JvnTigNZW26yRv1Zz6+MVcceNgs4BYLi9B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cbgFWLom; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cbgFWLom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA+hhinBccw2q3jBGKp+tp5dK/EoU1M1RL4uPIM0oR0lUfmvkxYqPZSyGVNP5PKoZKidaF+zuuaAYaiVIdne4mUY3gXLX6XCekFDu/Vr4BlCD7AuToOWGpu0MNlql6r3Aivg+K/oVvk7vq2fTOt0uiYUXMIzaflaF5hftir9S9EXfwbR2AUKMrIXIyFVvQc+4VT+cGxTQDaqmzbdbFLkWp5DmWQ9TZARCh3HCo1AHQbziz45xwF9cfMTYMVT96+mtCIluTpN23cL3p/2/9yGVF7JyqotiNeZgzBOpAnx/4dLBqrngqCgoXZQgXPbLhUnxl4wrDuK4lWfN+JkXzGRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cStUit3kSqb158mCSTm3Cjb9kxCivsukp7POZVdp30M=;
 b=CnYkQDhzsVrheswD7afpeyRIYCglnt7E3Hz7/E8vbZA+c2+Q8kPlEfrvmrP2To5HN8D/K3b6KnzuKfzVRmryw+G4U73xpddFiMeSVaZwkX4SMmMGPjRLt+f/BmO+HY32uUErUgDWkhKnxlRTI9Rh9rCOjjZYXfbs4VKlmdjWHON7E8KCjzUdKGPnuVw5nOLQBdHT4Up85cIcYc0a1HKe5omBQCArbxfmFtJNH7qJ9jPffy+7yxT/RC3c3v5YNjDJleWjYz+TvD5TA2is4Yo2Pv3KabByxpaKDuPZdu38t+9c7cH8e2BOBU8e+xvQkg/GLI7xBNrlr24Gc8k6dL5e8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cStUit3kSqb158mCSTm3Cjb9kxCivsukp7POZVdp30M=;
 b=cbgFWLomgBAdm4siaTPcMrRiP33bdMMjK8Uk20AJSo9nXkEsIPt/9b/x/JqAQtSSR7emKrxD6lS4WwEUcEzZx0Xs5hWT0g/wQuMjMWjLrr45MWgpmYOROXC7+LTmT3MmV+OpMx6u26qLydIo873FLPlT6zDu/xv2EaJsGW6SRBsVfL5kJsI1oPf8IGgMKvEiRqoN6dOIpO5p6XIQZN2BVMdZGLOLk44n+jAHt0VUm2sDp8NW+57DbSJ9lMKDoFzOAXr/blLwIm8c92D/pb4XWOjWqSlF1quL1uKGVb7bSUwW8eZ+q4rdJcxrt7VjIJ3JbqdvLDigVvHOp4ftMv3TYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 02:06:12 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Sat, 22 Mar 2025
 02:06:12 +0000
Message-ID: <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>
Date: Sat, 22 Mar 2025 03:06:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
 <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 3247416f-73cd-43ed-1574-08dd68e61ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG12elRuVEN6dVJGRzBhbGx2RWNsNWgzQTUwbGt1Y2Q2b2c4aVJHN0Z5eGpY?=
 =?utf-8?B?b25keGIyempsRXl1ZEFpeVFGMjFWcis0WU9wYTBTQVZHOG96MFZUTzFtUnU5?=
 =?utf-8?B?SVBzWlVNQVZob3UwSWJJWFM1R0tpb2VCakJ4d09qQVNucXQvZnp5VVpqcnVM?=
 =?utf-8?B?S0RLMCtWbStpQUtRa0VlOWJNaGNubnJXOEM0Z1RjTmpsWlRNNjV4ODc2TWdy?=
 =?utf-8?B?dVhXVGQ3MzN0cnBaWmczV1UwT0hiWkx6V3JJY2ZXTStQaWJJT2s4VktxcVVN?=
 =?utf-8?B?WVVYU25OeVcxUWx1N1ozaEFjOGk0SnE1Nm5EQldMdzAyUzQ2b3VlZTBGb0Vt?=
 =?utf-8?B?UkFEdnp2Mi91TjNQUlBpaFN1RmpFa3FVVWh2NGlDaTExRUJQazRMU3FIWVdL?=
 =?utf-8?B?OFJTOENRcmp1K083TVNSa25PbmNKKzZpNDVrQzVwUTZrbWFLclhySWxWcE9t?=
 =?utf-8?B?RE9nSERvaW5CU3RGdWVneVEvdzBJemgzUzgyUER0aERXY0Jwd1BTVlFBaEJm?=
 =?utf-8?B?bzlRZzE0VXNURjAvTTdoSC9YaUw1aXd6bkVoTE1tNEZOVXdZMWI5b0g1RTZE?=
 =?utf-8?B?YWdBTTVCNVI5Z3YydHYwaGdUbWp3N0hGTlVBOHpIYnJScWx2MWl3S29pZUJF?=
 =?utf-8?B?Ym9ZYkNnZGxKYlFqRmdNVGg1TElMRWowM3lCd05oVlJsYTBBNFRyUmNBMnho?=
 =?utf-8?B?bEJBbG5MdHpHTXN6T3BtUzVJb3lMQzl6dFN2SjN1ZnMvRDZvdHJVYnRoTTdi?=
 =?utf-8?B?SWpUL0RjbHhGY2s3NXpZbkhNSEJQcjlXRDRpWmFCamNFWkNpQkVUNXZGSXZv?=
 =?utf-8?B?WUZzTjA4SUpFK0NSQW9RVzNjcUJEK2o4eW1kVjR5cHlvNmtKS3FiYTRhNkMz?=
 =?utf-8?B?b2FNSlRRUVJhdDl3MjMxeGY3SFRsK2wxQ3VHQ3VZZlM2RWEvT0tXa1gxNGRN?=
 =?utf-8?B?azFSeVZWVFRZeW9qWDQ1QjRjdGxzdGxkME1tQjFsNlNiZVFycUdzT09NQVds?=
 =?utf-8?B?L2lkNDVFbkxMZXFZZi8zZW5lcUc4VWF2NUV6aUcxdGg1aWJZZHlYU3JRc1hG?=
 =?utf-8?B?R21PQ29rWjZlN09rcThzaEVDODROV3ovaXpsaWI4SmVFcGM2T0VISmdPMGNi?=
 =?utf-8?B?MlhJWjhzTEttMlpBc2phRVJlTlBqR3V5N1RXSVF2VGF3dTNzM2ZpSllTazR3?=
 =?utf-8?B?Z1l2TGhRcUM4T2EzbGFYMmZTeFB6WXJvdTRZcWFWaDhtdk9tQTZtMUJ5Ylp3?=
 =?utf-8?B?TFJrdndRNW9tREVrUzdEYTY2cFdMNFVRWHlTZk1zaUh4SytkckRPVkZHNHND?=
 =?utf-8?B?OWhSUnV2ZlpkNFFSbkI2QjJyWjNldjE0NmQxOW5xTWVxaUtSYXFQVlpYSHh3?=
 =?utf-8?B?MjNWRGxQTW1vcENCNGk3RjhVL2d5Nmc5LzR3SGxSNE5JMnQ5NjgrV3ArZ3Ev?=
 =?utf-8?B?RWJjeFlLUW5jTXNwNUJEczVYWGpNZStUUHB3UG1zSGkvMWNTYXR4dHJoOTZ1?=
 =?utf-8?B?a3d1ejArZkg2enhSbGFHOWJWZ3BiMXN6bElibm1hOFNEN1NteUQ5V3dnRDF2?=
 =?utf-8?B?Sk50OWY2bllGWWxmUjltdnVoaUpzV0JHZCt6WmV4b1RrZ0YrMlJDVzIrL3Rp?=
 =?utf-8?B?K2wvMkU0bTFZOHVZdjdKYWpXWmxGZ3NhbGdhclcrc1h0TXVtZGdCOWg4enc5?=
 =?utf-8?B?Ti9NUnc2QkVlNktQcCtpekFmeFJpY0pBTXVHV21iUlFuZi9WRTBJV2FGem9Y?=
 =?utf-8?B?UW1aajZMNVptak04N2wrYWR4N1kvNkpLMmZaTy80YWI0MWR6MGZVNWhnSlBD?=
 =?utf-8?B?OVd0T1hEeERydmxKNEF0YjFNdkVBaW5QMG02MC9kY05KNkhjOTRkRHRPdDNh?=
 =?utf-8?Q?e/0DYAlNmnRS6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJad0xqODQzcFpxMHNFSGoxL3R0WU8xVXNCSG9QUUVCUVFBWDZiUU5DUzhG?=
 =?utf-8?B?VUVOVHpJdUpNamxnR0c2Q0wxODNyeG1UbXNDWCtuSmdicFJQUzFkSno2SVlN?=
 =?utf-8?B?Q0d6VWo0WkJIYTh6djdjc2NPNENrbVdEcEg4Vys2S0I5ZUpqRHZva3dwbFZ5?=
 =?utf-8?B?KzJ1TFROME9qWFhoMlhqMzg3Tko3dUhxRGN1WUZPTjBnU3B3V0t5UnZORFBG?=
 =?utf-8?B?RkxaWmZZVTMrS0xoeFlMaWY4T3plc2xRRzQzL29JOHplZ0dHcSszekxySkV5?=
 =?utf-8?B?ekIzL2UvZS9IYzZyYWF1UnBCc29UdStibGxHQUJncjV6SHpDdHhrcnFIOWhj?=
 =?utf-8?B?UC9Gc3VsN09ickZPWlZ0Y21jeWM4UFp1czhQbGk5dUdmaXRCL1h6eVdaWTlP?=
 =?utf-8?B?bENDa3dPNExKUXRyVFA1M1VScVh5WnhNWXppN3ExRE0ySVltVHQrV2YrcGtj?=
 =?utf-8?B?Vy9YK2ZZVldzTzE1dVd2ZHpzaFhsTGEvOXk3aktheUhFdVVRakhaSlNSQXVE?=
 =?utf-8?B?SkFzNHdjRGdUZTl6QmEyZm0wY0hNdFg0SEZGSlJZdDE5dktzSUJZMmdwVjR4?=
 =?utf-8?B?cmdSYSt4SnlLOGpXbnZBR3FCd3RTM1k4V3o2Z2owZGZmdGMvbmJSbFcvMks1?=
 =?utf-8?B?bzFMZVJpOFp2cHFpeHNMb0JCSkovcHMvYkw4U0tIcXg0QWUwd05CYWRqMW9X?=
 =?utf-8?B?TkZMYXJwQ3lzU1hiMlBweG02Qy9yb1FmRW51ZVFwQ0ZVcXVmN2JRaTBHNUFx?=
 =?utf-8?B?VEduWk1vOUx4NmQ4b01QQmlKbE83UzJoWXMyeGtGWWNIVERQemFyZEFJa0FF?=
 =?utf-8?B?TWx3bUlvbkkwQUpmTXEwRnhJb0pITytwNEtGRnVCd1FMRWw5VkQzSGxjQUxm?=
 =?utf-8?B?YUhndmNzN3BMN3VKTFF6N0ZVOWRBMVI3K2MyQW1YNTJDaDhzQ0N0RTRZM1hR?=
 =?utf-8?B?cXhPQUZ4Zi84d1NhcExXNUUyQk5uWjgzbDBKZE5Tbk1IQTJ3dmU4WlEvVWxO?=
 =?utf-8?B?dy9ZczlLQ2xsYTJmZGxDbHFoZ29GNmFpZDR6MEdDZE1vTEt6LzA2K0lNK0hY?=
 =?utf-8?B?andVN2p2cWZpNVNqeUpQbkZiVTlDYW5uTXBEWFRoMloweDZKd2dCMlpiZVAr?=
 =?utf-8?B?L00wQ3kxSVNURFk5Wk12WFFOMmVscng0YmhBNDVpWXVsUEZXemtFVm1keURi?=
 =?utf-8?B?bjFremJTcTdReTJrSUZhK01QZVhra2xOWnJDcFNGaDJoUS9WV2d2STVYOXlu?=
 =?utf-8?B?aTZFUkYrZG1Yajg4MDZldzVKYjRuakEyVFZITjZGUVlnc3BwMXlDMDZpWm11?=
 =?utf-8?B?NWs5eDFmM3NJbkJ4SEt3WnYzcTBzdGg3TUs5NmxoSUhiQW5NNzR1VEpDTHlM?=
 =?utf-8?B?bU5GWThOSTg1dGNpa0p4aWtzdm11aGF6RC9qUGNieExKYnhNQVZWVmtOVjVD?=
 =?utf-8?B?Z3Bxa1VrQW9nWDVtS0RWU3kvTEp1cHhyNUcyZ250MzhRZnFNQXRKc3J0SlVa?=
 =?utf-8?B?QTA1SWVwQ3M2R1lWMmdHd1h4RzM2QVVpcUtQc2xLWXNBNUs0M2wvbnI5VW1u?=
 =?utf-8?B?aEFxNHpGQW43azVXOXZNa1lCVURsSVI3eTREejdsUDhRZVVSQU5aRUdEMnAw?=
 =?utf-8?B?K2g5dTYrQWl0MjJqbmYwYWRFMGdKSnJZOGhtQjJPcU0vZ0Z0dnlDcUpkcUFi?=
 =?utf-8?B?SEhaR2VtWUhjL3RsSzBzWlFRZmt0ckRVR1YraktGZU1LNnZNbnIxWmRVRmFa?=
 =?utf-8?B?MzZWVWwvWGZIWEhIK29YZFM4Y0VxKzU5NnhOakM4STg5TENpMXl5ditrVnd1?=
 =?utf-8?B?enphdnptSXkrcE91ZW4xQlN0anZKSnFjWmVsQmd2dGxPdlYrRERyRTZUZW9K?=
 =?utf-8?B?T00yL0dyRHN3MU5jVHYxSU9PeDQ1YndxVDhjMm1RdWVGRUVpU1ZPV2dhYWwr?=
 =?utf-8?B?aE5PczRBVHhSQkcyYm43NXpFMCswM0d1RUtyS3dKTjM1cEpPUTJjbU1SdHhS?=
 =?utf-8?B?TGJMZGw3cFFQOWNHczZUODQyc1lWWDhQSmJmZVliWnJSSldkeVRDSHliWjBv?=
 =?utf-8?B?RnNmUFRTVnEzUXNRd2FDdXZHdm9WRHFqZVRsL1FOWFhvSUZMcjhwdFhwd0ZE?=
 =?utf-8?Q?a5GwGXgoGNQ63bWLcDvNOxhez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247416f-73cd-43ed-1574-08dd68e61ebc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 02:06:12.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni88G0HEctXqZYmTXdVQagC1aO73lywhrtwMXuhkupCiu8wuXSLO78mKQ8BZ+NfRU9qw4hQgowdzVoYg0PAEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

Insomnia kicked in, so 3 am reply here (Zurich local time) ;-):

On 3/20/2025 3:15 PM, Frederic Weisbecker wrote:
> Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
>> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
>>> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
>>>> The numbers used in rcu_seq_done_exact() lack some explanation behind
>>>> their magic. Especially after the commit:
>>>>
>>>>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
>>>>
>>>> which reported a subtle issue where a new GP sequence snapshot was taken
>>>> on the root node state while a grace period had already been started and
>>>> reflected on the global state sequence but not yet on the root node
>>>> sequence, making a polling user waiting on a wrong already started grace
>>>> period that would ignore freshly online CPUs.
>>>>
>>>> The fix involved taking the snaphot on the global state sequence and
>>>> waiting on the root node sequence. And since a grace period is first
>>>> started on the global state and only afterward reflected on the root
>>>> node, a snapshot taken on the global state sequence might be two full
>>>> grace periods ahead of the root node as in the following example:
>>>>
>>>> rnp->gp_seq = rcu_state.gp_seq = 0
>>>>
>>>>     CPU 0                                           CPU 1
>>>>     -----                                           -----
>>>>     // rcu_state.gp_seq = 1
>>>>     rcu_seq_start(&rcu_state.gp_seq)
>>>>                                                     // snap = 8
>>>>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
>>>>                                                     // Two full GP differences
>>>>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
>>>>     // rnp->gp_seq = 1
>>>>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
>>>>
>>>> Add a comment about those expectations and to clarify the magic within
>>>> the relevant function.
>>>>
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>>
>>> But it would of course be good to get reviews from the others.
>> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
>> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
>> because the small lag can just as well survive with the rcu_seq_done()
>> function in the above sequence right?
>>
>> The rcu_seq_done_exact() function on the other hand is more about not being
>> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
>> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
>> least ULONG_MAX/2 AFAIU.
>>
>> So the only time this magic will matter is if you have a huge delta between
>> what is being compared, not just 2 GPs.
> You're right, and perhaps I should have made it more specific that my comment
> only explains the magic "3" number here, in that if it were "2" instead, there
> could be accidents with 2 full GPs difference (which is possible) spuriously
> accounted as a wrap around.

Ahh, so I guess I get it now and we are both right. The complete picture is - We
are trying to handle the case of "very large wrap" around but as a part of that,
we don't want to create false-positives for this "snap" case.

A "snap" can be atmost  (2 * RCU_SEQ_STATE_MASK + 1) away from a gp_seq.

That's within "2 GPs" worth of counts (about 8 counts)

Taking some numbers:

cur_s	s	delta (s - cur_s)
0	4	4
1	8	7
2	8	6
3	8	5
4	8	4
5	12	7

The maximum delta of a snap from actual gp_seq can be (2 * RCU_SEQ_STATE_MASK +
1) which in this case is 7.

So we adjust the comparison by adding the  ULONG_CMP_LT(cur_s, s - (2 *
RCU_SEQ_STATE_MASK + 1)). i.e.

after a snap, if we blindly do ULONG_CMP_LT without adjustment, we'll falsely
conclude that the GP has completed thinking it was due to wrap around, where as
it is possible we just snapped and got a false positive.

So I think your comment is mostly correct then. But I think it may be better to
clarify that the reason we need rcu_seq_done_exact() and that ULONG_CMP_LT is
because we want handle very large wrap around not being stuck in "false
negative" territory as we would with rcu_seq_done(). But that also means we
can't break the "snap" usecase to the introduction of ULONG_CMP_LT.

Unless you beat me to it, I may modify your patch for v6.16 augmented with this
reasoning ;) (Also since I am also working on adding that forced wrap around
test to rcutorture).

Also it is still not fully clear to me what the root node has to do with all
this in your example, because the rcu_seq_done_exact() needs to be what it is
(that is having that 2 GP adjustment) even if the rnp->gp_seq and
rcu_state.gp_seq were in sync?

thanks,

 - Joel

