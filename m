Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0125A640;
	Wed, 14 Jan 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380902; cv=fail; b=N3W1HNAzL3NitB2HwXsO9XlxVAOUshVPIc9ElpmISjiRqUhlWD6nWNfHZqP7yuDTc7WkZJxouFAWdJSAjIsgLW//qU5NXmK3An/A6NnDbjWW4qlpliE8/cRWF+8d7EjHxKuZke0dhRNvTkStoCHRjLCEKMijZMscn1tPOZXaFqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380902; c=relaxed/simple;
	bh=6zsGKpRk4+KOzmnEoHOVhlFPbBYppCT6HATfIoaKOzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GpXMmeaCDDEqfxEEo8WrLh7kCAsy+WWqg0kiz+G2x/ooBVy06CaHQwLWj8lxiStEeeSWwK0nBY+OUZTM2V12AMGCdlhPm0zftOxbZ8wMwDCCxBZJWeWnQ80ybNEsFGDVUB+sYQvw2eZtr5Dtg1HWW43Wlm9aVgMs58b4BSPklkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eu1VQ/jj; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eu1VQ/jj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eolGINeFszlPigoAP7009C0oG8zAwbcnYmqIqj1I763gf89b4yu9QMQ1kxbANaP4BoUtqDSda69jdf8SNPjorF9F467F1t633HsFD2Up4JN1qdQbT60dBvsA/A3bnkyXWP4d9zBQwlzOGy4J5KorvK/FzNaN3934+OpcB36f5cp1fCsgf64plsJvSi0N2j/eKhVnFgzjFjApsiC+hD7eXoIjmYLYrtEimFslcsLncXdEbYVHhRyU+d+1JKPgjjjV8V5GLax+Wrg4zl0DHknSkVZAY1+VsqYYPUfpgNpkAx03HIMMdHkTQMGbVUFSOqeagwX6t7qHR9A8KD71QFhZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGG3sja0poGvz2bBMg5K7v0ATcsNMLddA2PBuDKWsuc=;
 b=GC4ZKTmAFvoYvrGrNZ7jPU6n6zg0y+Qa2aYMvYPI3AZvxzHdO6k1TZ6bYA+sffJW9PU2cE/tvGYQH101tdMnNd26Qshsnjk79OYRc8BuhiEXaK8xIISfLdIAGg5lRHVLmEBooUZGbPe8bAz8d5meI5nYtd+RFE/nROyjINzr17mGMFOpzk8d7DLm0f+zGuTTeuJkN9g9qy4AGppEHrt9+Hfw07bozhGzown4j87/iEf0KK9z+tSFXMqshkZQBIxDmSCMcpwR0JczlTJ6RvVzCiHkcUnayCBDHZass1GnELS3HIPyXEmimEgSvgNzxdNsF8UBo5LLS2+bZ5Ge6HGBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGG3sja0poGvz2bBMg5K7v0ATcsNMLddA2PBuDKWsuc=;
 b=Eu1VQ/jjndvjZll/R+0ERgdrahFYxqEOrRf8VNKujt1qIERj6Tp/QdThB6QbG3Lc6MbZhlTcIuv/nyi7uLLSETa9nx9bVf9bDaigHM36Y/qDTIX/iA2A/82cQ4/Gll8+4B1g2z6nPgI/gVRpD2a3Kk8XpQBDWRlsaxrjpB5XVWCP/gpCpxs7cd/MyjFJrDBMQ3QCmMqW38My6EUTwPAHq8Bk7IPRb3u7fLtlx1+pD74LYRhoFXFsa8WXCig3HQbfcO9u+dyrTcPmTs+5v3jUlJMhmu3jWQ5dWq0C1C6aTK9IXKgAK3c07R0p2EunCvseHiOmQ8vwkrdhuGA1x3KtBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 08:54:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 08:54:45 +0000
Message-ID: <a1a6ae5b-6304-46f1-b29c-07dcf76fb747@nvidia.com>
Date: Wed, 14 Jan 2026 03:54:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: paulmck@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Uladzislau Rezki <urezki@gmail.com>, Vishal Chourasia
 <vishalc@linux.ibm.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frederic@kernel.org" <frederic@kernel.org>,
 "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
 "josh@joshtriplett.org" <josh@joshtriplett.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "srikar@linux.ibm.com" <srikar@linux.ibm.com>
References: <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com> <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
 <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
 <37372899-9CA4-455D-83EB-79A07294D34A@nvidia.com>
 <a0f38f55-01bd-4b0a-866a-3f213f6e7cd8@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <a0f38f55-01bd-4b0a-866a-3f213f6e7cd8@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b80334e-6722-44a9-3a76-08de534a90db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFBWK2psclpKZWhQMWN1UWhGU1NYTXd6QmJvRE9pZERwOGlnVkNLK2doREl4?=
 =?utf-8?B?a2FHSjF2eWV3OXFEVXBJWDhYT1RGZlA4dE5aWDJBNU9rT09RMDR4cUZxTmx0?=
 =?utf-8?B?eURpYkswVnVDMGJvbGhZNEtQOVBxR1dWVFZTd3RjMzVxWnArYit1c1lMNlVS?=
 =?utf-8?B?aUl6VytTTVc2a05lSU5SdjZhWGtsSmtrTEVheVlXdmQwcWxQYzNZdXQ1bXBE?=
 =?utf-8?B?N2dBbWtLYXVtakxLb2t1MmlabTg3VTZWL0l0aktKVEhnY2k1QkRCYU9ORmVH?=
 =?utf-8?B?S0F2RDRXcFYraVg5bnZmWmFObkh2QVpIbFM2QUxjdjdSaG1XZXc1T0xoYmha?=
 =?utf-8?B?WVhwNTFjNFE5bjg4NFZrZGxGQlVFK0VGVEVySVFWUW01RkkyUHhXTDMvQUV4?=
 =?utf-8?B?bnhUTEZvNUovZ0RZYUdYM2hiOHY5ZXRoMS9SL3poNWxJL2EzRXluT2phYkdh?=
 =?utf-8?B?WkJoVXhNRmwwNWZVNTF2bnVkZlFrZUZYVjdaM083ZDgzWUZDWTRaQityVGZD?=
 =?utf-8?B?Yjd6U21mL1B0MFE1MGxHNzBUdWtzSGZxUnRMT2p0N2JBcS9HV1N2WmUyaCtz?=
 =?utf-8?B?ZTlyYU1NN0NuWkNvUUNyT3ZhL01LMEFPWkh6aGQwME52NlRObWVnaTRHU21Z?=
 =?utf-8?B?NXBLdEpYb2hoRGJEUy9ETkpUQjBBWmpXaXZ2bG9kTG56NnJ5WG96LzVnOVpa?=
 =?utf-8?B?ZEhkS2svYVlCUnFrQkNGbmxiNUdKTEZCWUgyS0RoWHhBVFhvZUVrbHlLRVI3?=
 =?utf-8?B?ZnUvYUx5bGFWWVFyY3FWT3NIc3VvUFhHMmRMT0U1Slh3UzMxYlhSdE5Ka0JQ?=
 =?utf-8?B?SHpCVEdDNnVFOFlIMUN6czBlOXFvZnhMbUFaZlQ4RDJFMEF4ZzNsWUJvZGlp?=
 =?utf-8?B?UzBuWHRBQThYUFU3VkgvMTkzT1FLV0RUR2haSzBhZkNOQytlTi90Kzc4cUdJ?=
 =?utf-8?B?cHdTYkVjb1BvYzZDbUdzNHRETFJ6RFIwdDI0Y3VaN1hKSWdxOFRNcHVRZnNW?=
 =?utf-8?B?dEtQbG9yUXNLU0V5QXNOZGFxbVFuOUN1VzJocXpsYnh2a2g3Q1RmYWV6Q3ZY?=
 =?utf-8?B?SnN1a1dSKzBrRHM5dmhUL0pvYW5OV3RycEpCN21HT21lSDRRblJTMFRRd2FB?=
 =?utf-8?B?Y05ETHZKdkFUQURWbEhIcy9TWmluMlFmUFJVYURwVzNWQ2I0TUR1UWhBSnRh?=
 =?utf-8?B?YitpVklYN0pLd21DZkVyTDhYTFZaeHQyRGJPUVpuM08vSkdyMXRXVHBNU3JV?=
 =?utf-8?B?WVFmaC9EVENDc2VNbnV1cElKcjNaMXN2d3VNazJRMWJIS3BjaXVnVzhxY2JK?=
 =?utf-8?B?aE15WWNlekdscUpwYVdlNTBxbU1MUmQ1WEpKNWd0UXNCVEt2aXNHMUwyYVkz?=
 =?utf-8?B?WUJwVUQ3ODhnclRPN2xPOGdiaGRDOHVWc2lsY3l4cUlXR2NFMFprS2o3ZnZ2?=
 =?utf-8?B?YXU1T0ppN0Ntcnk0WHA5OE1mWGVZSTVwZlhhSXlSdWwvU3FvTkpyNmVSQmtk?=
 =?utf-8?B?T0hPb0xUSlh6N0JvckhvQlNsOGZURUJzeWhjc0NaMHZzd3NVYjZWdzNTL2JB?=
 =?utf-8?B?Y280aDhUK1RSdStNZ3NqTlRNdkorcmswUVJhTXQ5UGhxNlByYkxONTNiQXRI?=
 =?utf-8?B?WXNUUXpiT3JjSWVsMC9ONnhLTUZDenJibWlxSEFHMUIyZ05HRFpncmUxdGEv?=
 =?utf-8?B?a1UzaWxDTDE3bmNrdGtJVkJ5MU1HL1VjVExqY3ZqMXB5RDJaZnMzOGNPRUZm?=
 =?utf-8?B?dkt2a1ZveDBSSklhQTdacWhTZW9kY3dkVzZGZ0FsYnlIeUxWemE0MmcwN2Nj?=
 =?utf-8?B?Y29PWkhKQVFIRWtsY2puWXhNOE5ReDFNdVlYYUFuWVRoMHUyU2VnZFpnUk5F?=
 =?utf-8?B?OHRpdjFtREc4THhObFk1R1A1cFkvYmx4ZnRzZ2UzR3hOTFRUajZrNlNoL1Ey?=
 =?utf-8?Q?PWL2ZFpd4txDnxUGtJDCgG9C0bI1S8rd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW9sT0ZDaXB1OVhRdUlLbzk4K0pqellqdTFiRjVTUnI5b1JjVGhRd1N1VGJi?=
 =?utf-8?B?TjFVazI1YnJPOWVaNlcxTzVGbnhZRlhuTjlldGMvQVRXVWNFUjYwYU5TYWdI?=
 =?utf-8?B?TmZaMzJwLysyaXlNSG5UN1U3bW5JNnBRdzFzc2dpdFlNcXhpcllFMThhU0Ri?=
 =?utf-8?B?WmNLVzJpTHZtbU9IZ0FEMUw5dmRwM1JacGhZMUY0bUZMSVY2eTFJOTZpbGRl?=
 =?utf-8?B?RnhmYS93cCtqM21DanZacFJYYTFrQzgzejBKblFLL3pGMnpzK3pWTVliMDR2?=
 =?utf-8?B?ci9IUFlEZ3RCUXpRVTJpSWpxMnVPRVdVN0IwdVFRK0E4dk9hNlJDcHk4OHNW?=
 =?utf-8?B?anEzYlplMTBmM1hpeS9HeTR3ZkIyekhqKzFocUkrLzJQK1VITFlKL0JkMXJT?=
 =?utf-8?B?a2ZnZ1ZvQzhMNjMvb0RDaGllZWVGQVNnai83UjNWYUZKWkg2aEdLMjdoWFBn?=
 =?utf-8?B?UEREUGo5OStSMmNzdE8xTUIyZnF6UytJWFkvRG9wZUpnR2FwU0xSQU0rYjhD?=
 =?utf-8?B?YTZSaloxSENNVXJyWHFtL3loUlhCbGJWcnYvQWQzQk9wR2lNTmUxQ0VXTk9u?=
 =?utf-8?B?elBwS3lHOWlvSTdTRVJrQVdKUFNhTUl6aGJZZGxqcWV2TERDTENKT1lKVWp1?=
 =?utf-8?B?RE1ldnhQS0ZTT1lsSCtXQVdzS0NsUmZvVENkN2lDaHErWEl1RHNKWit5U2RT?=
 =?utf-8?B?Q29YSnBDdnRjRkNIanU0d1Z0REsyOTcybkUyQ2ltRTJiNlBhV3FyU28vV1hQ?=
 =?utf-8?B?TS80NUdVYVFBSW9mN3p5eElXZTdDUlBnVW1GODhoSk1INVFiRE83Y1orZWQ4?=
 =?utf-8?B?SVc0Zk84K0hOaWhPRUI2WncwUDY3c3g0cWRvcVdFYmdjU2gvR0Z4MDJ2c1RM?=
 =?utf-8?B?L2hCZmhRR1dvMldOOUR5WGhFTUdhTWljbHQxZk0wQlVLV0dFeHkwMWwwcnhC?=
 =?utf-8?B?Zk1FTHVYNkFNR1pITEY3Wk0xVmR5RUdDTXZ4QTZVVjJidXY3YUlZR1J6bnVl?=
 =?utf-8?B?TWV6RU5jREJLWXE2ZkxUOElONWIzNGYyWDZKUnVxTWxmVTZOZWU4YnVSeklK?=
 =?utf-8?B?TXpwYWtITlBwSGc4UVdBbUs1LzhSY25Ccy9rMzN2ZktMbW5aN2pQeVpCd0FF?=
 =?utf-8?B?dVFCM0xrWGpJTEQ0aE9HcmlGb2pHVFIzSCt3cW44bVBxRElBWnlxL08rdTRz?=
 =?utf-8?B?VFdzd3FrREMrSndtc3BmQTVIWFlmbHBqU2NsWlRUdzV1UGlWVVo4eDhBQllQ?=
 =?utf-8?B?UmZiN0JYZlFRTUROcjJwTHFrNG1ZTTdnK3c0cENWTUJxYUo4aGNIdk9DZUY2?=
 =?utf-8?B?M3JTVi9SbkRnZ1djQW1iVXZlbkFFTlF4anczNUxHdTh6b05Ga0QzRXhhQ01V?=
 =?utf-8?B?OGV1L2lFTXF5Q0RUa21vUW0wVVhSbmVCNjRWWDVwck0ra0gxdnVoa3RKVWpU?=
 =?utf-8?B?UlhIejdhNTFMNlVWKzEvVHNQRUIyTTBUcTlEQ0JheUYvOEQzNTBuMUVDbGlE?=
 =?utf-8?B?Y0tSQmdSRWFQUUwxZzljT1pvUkNXQmI4TWk1WDdMQUdwN0xWUnkvU3p4RTJ4?=
 =?utf-8?B?U0pzTnRVeG15T0NsT21jemhWMHdlMUJHMWROTjFNOWdKOERXc3h0WFl6cFFS?=
 =?utf-8?B?SFNHU0hqRnNoMFYzTkV5eVE3QjJ5MlBEUVRwY3F2c2RTdWFDMjdyN2lZb3ZS?=
 =?utf-8?B?dnVOclJVS29CYjhNTWhRekVzam1iTXVBOWYwK1dlTGQ0QlV1aWJjZjB2cWIr?=
 =?utf-8?B?eDloUUxtZktrQUMxWlBweFlNSUxBMHBnbmRFRjljVkdWcUhhbVEwTzVJN25w?=
 =?utf-8?B?dG82NkZHalZmQ2xmb3I1T056d3E5WlRnS2U1cEZKYU1ab0toTFpJNnB0MDNQ?=
 =?utf-8?B?eFFCT21lN0NSbFcweGREdTVrcGxBRkVXM0JjSVpzSHNlUDJUNzhlMEdtNGw4?=
 =?utf-8?B?SlFHdENZblVXenZvODhmSDlBWitaQzNOYTRXc05HS3ZudmN6cC9JWDcxVXkz?=
 =?utf-8?B?ZHVGMW5sdE5rQUxocGlDYnFWSXFrZkZsTjY3NUVhWmZZeU9MdEZ3NHhjK21Y?=
 =?utf-8?B?clp2OVh6MnpoMTZHUzFjeU1xMUs5TGNaSEpXaFQxK1FGYVZwdDY3dTVIVExk?=
 =?utf-8?B?cUVEK3dKaGdVTDRCOE9SdHY4UDlvMVZnSkZNUndsMmpJb0M2c0lVYWRqZWNi?=
 =?utf-8?B?c25CaUpFbENMTnZlSWRFZEw0OEMwczZQRkkxU1lJRFRFNnVwdGxST3kzYU9o?=
 =?utf-8?B?RUZsWmc3SkRyTXhaVEl3b3loREsyTFJrNGVUakM0Y1JRVWVBaXFqYWdOejBr?=
 =?utf-8?B?VE5qSENEbks2diszV3BDeWRDQjd3Q01NK01pdnRUbzRhQU5PR1oxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b80334e-6722-44a9-3a76-08de534a90db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:54:45.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLWLWDBZ14JvnXux4bVoYRWl7WwpHJrvK40892OTBrNxErmrQ36ezKWjNbHAM7BzjfNObJLy8MxgTWCwhBXGNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427



On 1/13/2026 11:00 PM, Paul E. McKenney wrote:
> On Tue, Jan 13, 2026 at 08:57:20AM +0000, Joel Fernandes wrote:
>>
>>
>>> On Jan 12, 2026, at 11:55 PM, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>>
>>> ﻿Hi.
>>>
>>> On 1/13/26 8:16 AM, Joel Fernandes wrote:
>>>
>>>
>>>>>>>> Another way to make it in-kernel would be to make the RCU normal wake
>>>>>>>> from GP optimization enabled for > 16 CPUs by default.>>
>>>>>>>> I was considering this, but I did not bring it up because I did not
>>>>>>>> know that there are large systems that might benefit from it until now.>
>>>>>>> This would require increasing the scalability of this optimization,
>>>>>>> right?  Or am I thinking of the wrong optimization?  ;-)
>>>>>>>
>>>>>> Yes I think you are considering the correct one, the concern you have is
>>>>>> regarding large number of wake ups initiated from the GP thread, correct?
>>>>>>
>>>>>> I was suggesting on the thread, a more dynamic approach where using
>>>>>> synchronize_rcu_normal() until it gets overloaded with requests. One approach
>>>>>> might be to measure the length of the rcu_state.srs_next to detect an overload
>>>>>> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
>>>>>> lightly loaded conditions, default to synchronize_rcu_normal() without checking
>>>>>> for the 16 CPU count.
>>>>>>
>>>>>> Thoughts?
>>>>>
>>>>> Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
>>>>> unforgiving of pretty much any form of contention.
>>>> Makes sense. We could also just have a single list but a much smaller threshold for switching synchronize_rcu_normal off.
>>>> That would address the conveyor belt pattern Vishal expressed.
>>>> thanks,
>>>>  - Joel
>>>
>>> Wouldn't that make most of the sync_rcu calls on large system
>>> with synchronize_rcu_normal off?
>>
>> It would and that is expected.
>>
>>>
>>> Whats the cost of doing this?
>>
>> There is no cost, that is the point right. The scalability issue Paul is referring to is the
>> large number of wake ups. You wont have that if the number of synchronous callers is small.
> 
> Also the contention involved in the list management, if there is still
> only the one list.
> 
Even if the number of synchronize_rcu() in flight is a small number? like < 10.
To clarify, I meant keeping the threshold that small in favor of the list
contention issue you're raising.

Thanks!

 - Joel




