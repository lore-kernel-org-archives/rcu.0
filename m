Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDB17A309;
	Sun,  6 Jul 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751829430; cv=fail; b=tp7teOeBOfwPvEtkd3WUduob0AGFXPkHL4jO/0bC6kfagjDXY70EGWHfPMD6mQqvBOMaQjxpK+geXcnC9kcCQ+zmHOKQtz6BUHZEzj4r5O/5Gqd5AiJKQLrTjTqlFN5Br7iQ/n8IicfCfZ8Fon0URc4JoJpw5Gy7VUifg0noaj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751829430; c=relaxed/simple;
	bh=UtgQufAws2vk7ZI0QQkQxwAwa0dWoqNLNUA09KSgeds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cc4C8xXnxozj/Mvq5OKFYZx4eq4+ZgaIJXcdghvkmVkq9ynP2dyGOR+ozUF/e2AI7ahv0PJlU5Agjw644WAir3xuBckS/A9gUNClZA/HG+HtYV3QgzXsZ1f2fw6IaDBoShbqFObx7xlFTjTfD6mj+hMeeNOZmE+bPtr04qeJYmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5AP3vh1; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5AP3vh1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZWNzgjwVR7TAxJAFM9AUdY3sPC5+jEBmKBQn1W2roWnOvjrR+v4btx7O5YJ2HMyO9IvQ5cs4YFZ9XjY3EnnrSl5Rgq6a1abOypX7kE1HvUKMhlBNkC2SM0jTNh7iGLliOVEJEnJDOTMzVIgtZ/IGAHhU7zs74OBNLatv88BGWZP9h23AmElnes58HxTrgaKoldHZylT8fNvFRCKUbUvuYQp+J00L0Ttp1DVeXORQOb7FHcoDBOgrXmm0k5pfrF2pw0Fr2l5Pp81GquUNqFyD4L4O94cd/eXLfS8lKTo5Zo4fOJOpmK2Zd79hVX9K10Ebo+GPFSX5mZ1xuQLxfNytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvBc8sFMdBGtk5sPuA+BrPJvAmsY4Fb9XudjztDGZcA=;
 b=Eqnw7gyuRmvoNJgPsYhEdGRNRjtgZTpU1jhnSNRdryl15lS9lcYWH21Ha0dv3a7ML0FVnBo7jk825ygyNQOu7KlWqgEY7g+N+OszJDAf27KSGN1M6mU2zwxjVuGCRU/f0sYJRKbH2jUBJyDFrUCbLRE7oi8+j/b6eOSMj9bGGEaYGZYh+RTrbntETSnVMtBemIiFAMu4Fov/1ZLgOcgRa8KO3yBrYqW8LcmsySyEU0wLoS1UvGPsJHu4UusDbDjnG26LtXd7eY0FjwaFkTHDXdBzQGjFasXFjkk75VN/rhPqjZdLTZi/QAViVVRGHWu94y0/SZ0q1m0rHxJda5DKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvBc8sFMdBGtk5sPuA+BrPJvAmsY4Fb9XudjztDGZcA=;
 b=Z5AP3vh17z+nTfULJX5HEsxUl0oCaihKjXYq5AT8Mroie3/8IEMQmOCvqE76HL133w53r5uf2GkJZO6ePLYRFaRA9LJnj0XuZBP+7Y+ReEXvnoEYbwVCjI39e3JctwaI1XXb5NNF4dgaTBZkWizIZmtsQ3RvV1hCIpubncBaDnr22fsJE+BYtXdVQ99f09aq0IXqhcxcEA2qeL5VnynW97K6NETmEYcMDndAVbvOaeawd+P7abcO+ulKB9wg8JMWhbnwCaxnoQJV3zwjgFEKnYmwFNBRyawRVlfegQPZx5kmMP5YWtR6Eh3d3HVGWGI6XxzRruW49MoaVy7IZlJyMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sun, 6 Jul
 2025 19:17:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 19:17:02 +0000
Message-ID: <52679e35-c6a4-4e0c-876a-a80a1a9b2bd8@nvidia.com>
Date: Sun, 6 Jul 2025 15:16:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] rcu: Refactor expedited handling check in
 rcu_read_unlock_special()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, rcu@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <20250705203918.4149863-2-joelagnelf@nvidia.com>
 <941d82f3-1c09-4db2-ae22-a80d04227673@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <941d82f3-1c09-4db2-ae22-a80d04227673@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f5c009-159b-4120-27b0-08ddbcc1b02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anUwSkxwM2RwMjV5b2t6aFhiamVGVEN2c2ptdUhvUUNNSzhvK0RBcXZSTnlw?=
 =?utf-8?B?TjEzczYyM0tpaW1SekFjRmZlT0lRTGIzOWduajl4NGw4dndyVG4wWjN2ZmtW?=
 =?utf-8?B?TGFWK1JVUU9vY24rT0dtcTlFOWFMWU9CbGtsS2xQcWhTTEtwVTVSMzl4OEc4?=
 =?utf-8?B?VXgrZFFVaVBwOEk0K3M0TmZvMXZKeHhyNktkRmd1WDc1bGVPZGZpL25uRGpL?=
 =?utf-8?B?VzVqaTVQTktsZGJVYjBMRW9HV1ZJRlFvVk1NemdPdzlxenJHYnREYXBCeTY1?=
 =?utf-8?B?ZnVvV2pMdWUzQllMR3FUcDB6aEFTb2dUVk56N1docGJXM3pTU1ByY0tlOWlP?=
 =?utf-8?B?bWpVT09WS1FZUHlRak9IbXV1amlKKyt6bHIyOCt4RUU0NE1PU1llWTZoRUYz?=
 =?utf-8?B?NnNPMEtPRE5VaFV1TXNvaUxtVGt0VStvRGQ5cVF2UEdMS3VjQWtvMlJWV2gr?=
 =?utf-8?B?RHZadlRJWDJjZ2hXWm92RFFYNHlFWmNGbkZBb0ZJZzNZRUFzaitudFFmZ05m?=
 =?utf-8?B?RjZxSk5JMFg4OGdxYUhMMzF1Zko1RlM3YS83Y2Jpd3Izbkp1YUZKZitubFAr?=
 =?utf-8?B?NUttTUZTclRERFhMb0dhTzYwenFjSVBaVEU3azdPbzdtY0RnN2xHWlMzSXlm?=
 =?utf-8?B?UndLSzN5SkR5S09pdlV4SW1rOWdqOXVFcGF4a3k3NHIzMHdLK256b2daNkgw?=
 =?utf-8?B?b2VyclQwaFppcnp6ZG9Za2EzNGxsUjljVlNldytEUDBQMXU2dHBmY2NvQUV4?=
 =?utf-8?B?L0lER1JidTJneDB5dkkzZHFySEN2b3FJZVo2Wm1YTDVBRFhib3FNWkhneVcr?=
 =?utf-8?B?OHQwZkc2Nk01SUtlelhkZ3RyNEk1QzlsMlRYaFBVQUlQa1dLakJZYSttUjhl?=
 =?utf-8?B?SnVOYWNabWFJN1VwSWhFSGVnQnpGVFNDNXcrNjZaRVBjZFhFSjcrSFMrNTV2?=
 =?utf-8?B?ZmNYOGRxbG9Rd2xXNlZIK2wyT3FjS29QTVA0OHJ1K3htTFdGU09YcHhXOUJN?=
 =?utf-8?B?RUl4dHhuNmtzSWkwUVIvTDNnYzFHNkNQQkw3cVhxb25kd1BZbGJrSHVJV1Br?=
 =?utf-8?B?ajhYSzZMeXRPNElnaUZUVktUcS9rMWtTL2w0TG5UQ2ZBWWxtQU1wYnVSZzVX?=
 =?utf-8?B?U2M2TGxCbjRuNzJvVVlyUnJzam8zU09SdjVLSDNpY1pORzN3NTJCT1hKb1pt?=
 =?utf-8?B?cGM3QU9lNlZHTlpSMS8wNThBeFlELzFLY0JERWNsekVneVFwbmljTHNNZ2dM?=
 =?utf-8?B?WGJLOEVUTFBxUlZyaGJqR1QvbXRncmJjOWpxWDByMUV4Y2lpL20xaEVRaURm?=
 =?utf-8?B?TllsdVZIVmZ5dVQzM3QzU2c2U2pxd0wrSndpK2FDMXJYcFpId0dEZEkweFg2?=
 =?utf-8?B?NmJQVDBQcytFdy9nQld1TXNnNG10NExqKy81b0FaSEJZajJOZHdkR0pFbnVv?=
 =?utf-8?B?K09FR1p3dWFVMGFPblNxQVNvL2cycWkzbWt6UVVIUnFWTjRURXQvSFdabllh?=
 =?utf-8?B?SXdMVGFHem13NklLS3o3Z1pnOW5tSzdrcmR6TXhsZVhhOTBoTzlGYjEvUnc5?=
 =?utf-8?B?cjJFZHZSL29qcTFhTkJMTGx6aDhlNkdMVXNjOHA2ZitBaGxBcGthVDRrVG5U?=
 =?utf-8?B?b0JpWGlESUcyUmdyZlFvNCt3V24xM2p1MW9kSS9sZjU0TWE3VDNPcWZ0bnlU?=
 =?utf-8?B?SVlYNkliZUUyOGRsYmhybks1ZzRLNFZWRFA4T3oybW1hWlIyOUpBZlZGOXoz?=
 =?utf-8?B?S3ZoWFdEOXR2SERmZ1NFRC9QYWFRTFczTFhCQklEcE9qYWFhSCsvZTVOb2RC?=
 =?utf-8?B?ZThWc2JtajJXcUUvR3l1aUdkUDhBWVhlNTFkaUg3YWIrN0JJZUxqeXIxbnor?=
 =?utf-8?B?OHQyUFFZTzJWams4cDhpYzBER3ZqZ2RjSDVOb1hVVU1PSGpGdWd2UDJ6UTZV?=
 =?utf-8?Q?zpv2fPxH48c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEdDbTQyUWdYODhha2hQOWtpSHB1c1NITUQwQ0dxTHdQZEJvbmxSblgyQWtP?=
 =?utf-8?B?TlhuT1pOMkRzWXl4bW1RUnBhSE1wcVVid0pPN0ZVTTVCZ1drUTRuTDA2dnFX?=
 =?utf-8?B?MWhnUVdrdTJiNmR0NFQ0VExxRW45K05Ea09FNWhNVWxlOTUvbWVNS3diYTFY?=
 =?utf-8?B?U0duRUxCR0lIS1o0allBZVMxYWorYzJwZWJ4c1pCenl3aEIyNkt5VDlFZVcw?=
 =?utf-8?B?Q0xKMVIxQXMzMC9PTlQvajUydi9LcEtpaHdzOENXcWU3SFE1UVIzUm5JNHFB?=
 =?utf-8?B?ckJFNVFBWHBiOFJqZHBKQ3hhUnE2L0U5emVXMFk4NCtUT2c3MnJXOFVsYThG?=
 =?utf-8?B?UzNpeS9LVmtlMytaQlEzN3R3M3BLMnloV0hCbEJYTFB6VVVuSW5NNkpFc2FC?=
 =?utf-8?B?U3ZXZnZ4clZ6TVYvV0w0cXd4OTUyMzBrTDdFeWc5K0p0eXZUcXhINkk3VUR0?=
 =?utf-8?B?aFdVT0o2dGVqZ1NmR2t3eG1namkyQk82Sk5rbzBYa2ZGQVNPcHRlTHF6d1V4?=
 =?utf-8?B?Tk9PeVlqdTViUlVLOXc3NmlYeFhidUJWVVRiWk1CTFlTSkNYWE03dTBScXR3?=
 =?utf-8?B?OVhiNStkcFFHZEJiaEc2Nis1WG5WNjlySHhmWUtiSVVVTmtTakJoZVlZY2pD?=
 =?utf-8?B?UUZNRUpWZ21xeHZLUS9PK1o5Vkx0SWhyVTBJeVorUUxoYzBkYVRKUzc3dlRo?=
 =?utf-8?B?dGRmMVNWSHI4dzlYemd2UnVwRkhwRWh6V01idlBMelBEQk1nYkpWY3BxSTdx?=
 =?utf-8?B?V1lDZGFRbllKUnlvaEFpZ3FWK2ZhTmN0ZUpXR09yTmdOK2tjdmcxZ1VjT2xU?=
 =?utf-8?B?STY3QjhqREppOUxNUjYvenBNM21ENE9EUmgrMFM4NE0venBGMDV2RDc0Q3p3?=
 =?utf-8?B?YTVIeGVyZjlwbk9rRmQwOHNqZG5NWndXakhFWmVhMUxrdnpTT054Vm52dGJQ?=
 =?utf-8?B?ME56ZlpCKzVYcGI1QVJsNXhReVg0cDBpQVZIYjZDSnpiTm5GT2c4Y0l3RFYw?=
 =?utf-8?B?Q0VHcEtGVlhvNmJrN0NXY0gwWkdIOHdvSi9qUHZSamwvVEZKMWliQm4wUDI5?=
 =?utf-8?B?NTZXN3ZabVAwa0dHOUtlNDM4MEpCUVFVbnBQdVJyY2szekpaR0VVcGU5YitB?=
 =?utf-8?B?Nk9KR1ViZFRwcHN4RFdJZ2J3ai92Z1N3WGtjU3ByREpiYWdXbVNaRWsyOWFx?=
 =?utf-8?B?Z3RzTGJnZnR6N1Qzb0lNL05JUFRUMnU2a3NRZnJoN1A3RElQTzc2eU5YYTJT?=
 =?utf-8?B?ZXZlcEE2OGx0ZTF6VnhVR3BrcFowczNRcUgyTzQraUVqZDQ2UC9CVi9NdFV3?=
 =?utf-8?B?T0RWWkJtN1kvRU4rQXlsbUhFOGxFSkgzSmxwUE1qR1Q0Zis4ZGI3MExpbU1C?=
 =?utf-8?B?cTU0ZkIxNmNSam81bjArNWdabi96L25jQmMraHFJbkVqMzBnd3UvbHQzL3Fl?=
 =?utf-8?B?c3F2b25CRjcrRzRtaUM2WWtaTXQzMURRZS90aWFSOG5zandIOFZFMWdZQ2RR?=
 =?utf-8?B?MWZyZStxUS9hNlMyTFV2bUg5UEVBWjF3ZlV2dndPcjhkS1B0M205MlVLWDQ3?=
 =?utf-8?B?NlZpYVQ1V0ZSODVicllqVnFmTmlqZDg1YjZtNnFBaDVNNkozczNUR0Myd1lC?=
 =?utf-8?B?WHQ0dVVmS2hzaVFQUTNGc3FmTjd1blorUktEcW1tZVlHR1l2WGV5WHVwN0Zp?=
 =?utf-8?B?LzNxb0dCTDJDczBhNm5yTlJmRW9wdThXcWRqZ01tbzluejZUVTZQN29MV3p2?=
 =?utf-8?B?ek1WVGZCUU13aDZqWllsbFYyZy96Zk40SUlTSStMMmFuZTY1blBtSUFmMEYr?=
 =?utf-8?B?U2tWb2l5dThWWWtiT3Y0MkJkY2w2M3Bob2YwaFRGMXR3Rmt0ZkFWcVBjQUF2?=
 =?utf-8?B?VG1MY2JjZUkvbmtNa1NPSzFzMjFjejhXZjZRR3lOeGZ5SUZ5OW9oWnpnZDNK?=
 =?utf-8?B?NXRKazdDd0VVKzJBQXBIczNQRE9Ecno1M0JXN3Q2TzlySEROUU40eDl5OUJH?=
 =?utf-8?B?R2xWNUd2Mi82OFh3YWxSTVlTSVJVcG1vbTNMdnNzVUlhdnhzbWhCWFRIK2hs?=
 =?utf-8?B?d00yZGE0cDVUd241SVlZVWc1L2YwM1doVldyWFI2dEp2OG9QVUY3SElleXlE?=
 =?utf-8?Q?Jr+XHfJQdi+ajRi2JOmQeUpz7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f5c009-159b-4120-27b0-08ddbcc1b02b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 19:17:02.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMZnPUAvfIr9+hYOHjk6+Xmlo9Qcmjd+tJfV7BkBi55UVN19aygeZPu3hmvWcGQk3lmYq8FnYoAR+m6bqIyyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Hi Paul,

On 7/6/2025 1:18 PM, Paul E. McKenney wrote:
> On Sat, Jul 05, 2025 at 04:39:16PM -0400, Joel Fernandes wrote:
>> Extract the complex expedited handling condition in rcu_read_unlock_special()
>> into a separate function rcu_unlock_needs_exp_handling() with detailed
>> comments explaining each condition.
>>
>> This improves code readability. No functional change intended.
> 
> Very nice!!!

Thanks!

> 
> Some questions and comments interspersed below.

I replied inline below:

> 
> 							Thanx, Paul
> 
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 80 +++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index baf57745b42f..8504d95bb35b 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -647,6 +647,72 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>>  	local_irq_restore(flags);
>>  }
>>  
>> +/*
>> + * Check if expedited grace period processing during unlock is needed.
>> + *
>> + * This function determines whether expedited handling is required based on:
>> + * 1. Task blocking an expedited grace period
> 
> This is a heuristic.  What we are actually checking is whether the task
> is blocking *some* grace period and whether at least one task (maybe
> this one, maybe not) is blocking an expedited grace period.

Makes sense, I changed this to:

 * 1. Task blocking an expedited grace period (based on a heuristic, could be
 *    false-positive, see below.)

And the below comment to:

        /*
         * Check if this task is blocking an expedited grace period. If the
         * task was preempted within an RCU read-side critical section and is
         * on the expedited grace period blockers list (exp_tasks), we need
         * expedited handling to unblock the expedited GP. This is not an exact
         * check because 't' might not be on the exp_tasks list at all - its
         * just a fast heuristic that can be false-positive sometimes.
         */
        if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
                return true;

Hope that looks Ok.

> 
> Why not an exact check?  Because that would mean traversing the list
> starting at ->exp_tasks, and that list could potentially contain every
> task in the system.  And I have received bug reports encountered on
> systems with hundreds of thousands of tasks.

Got it.

> 
> I could imagine a more complex data structure that semi-efficiently
> tracked exact information, but I could also imagine this not being worth
> the effort.
> 
>> + * 2. CPU participating in an expedited grace period
>> + * 3. Strict grace period mode requiring expedited handling
>> + * 4. RCU priority boosting needs when interrupts were disabled
> 
> s/boosting/deboosting/
> 

Fixed, thanks.

> 
>> +	 */
>> +	if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
>> +		return true;
>> +
>> +	/*
>> +	 * Check if this CPU is participating in an expedited grace period.
>> +	 * The expmask bitmap tracks which CPUs need to check in for the
>> +	 * current expedited GP. If our CPU's bit is set, we need expedited
>> +	 * handling to help complete the expedited GP.
>> +	 */
>> +	if (rdp->grpmask & READ_ONCE(rnp->expmask))
>> +		return true;
>> +
>> +	/*
>> +	 * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, all grace periods
>> +	 * are treated as short for testing purposes even if that means
>> +	 * disturbing the system more. Check if either:
>> +	 * - This CPU has not yet reported a quiescent state, or
>> +	 * - This task was preempted within an RCU critical section
>> +	 * In either case, requird expedited handling for strict GP mode.
> 
> s/requird/required/  ;-)

I meant "require" :-D. Will fix.

> 
>> +	 */
>> +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
>> +	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
>> +		return true;
>> +
>> +	/*
>> +	 * RCU priority boosting case: If a task is subject to RCU priority
>> +	 * boosting and exits an RCU read-side critical section with interrupts
>> +	 * disabled, we need expedited handling to ensure timely deboosting.
>> +	 * Without this, a low-priority task could incorrectly run at high
>> +	 * real-time priority for an extended period effecting real-time
> 
> s/effecting/degrading/ to be more precise.
> 

Fixed, thanks.

 - Joel

