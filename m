Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF1273F9;
	Wed, 13 Nov 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517252; cv=fail; b=ErBeSr/FxIf7XG3tgAfZ/yjT4OTwjhkUAUdKq0KVd0128FE5XLgvixGfdRTBrQsvZ4A9MKH+nSTCXnhIsj6iQF4udJH2Hm9J1uZaKOB4q6gQuOb5QChioK+1fxTdWOzfgY0D624NJuaisuSjTS08M/1ebgVK5WrPlhaDzvYEnRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517252; c=relaxed/simple;
	bh=gaOFLNsBVdCnsddvAxkrQLaaDQWtEdBnxtlPlpNXJXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WiZd6MpG9SODfj4lA0t7seUxO7FBn+LGuE/KHPcfQWv8nmzovlJ1EmxllRw2hqyTE5kvFCKYEGvnmODXqBM2OGr+m1auUgPxhVsGqQRQ6acPxuBuds2T9UiyyAmCFk3D1ftwmN4mXNPz4vChQVanqlWgLh9TT8UC2clE9UvxX9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5knkm4hj; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5knkm4hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCsVSYfY0kuuul0sZLXwBdJjItJh6vBmrldxUl6rXEfWrw4ttXQQ/uFmxJJits/CkEJhzZ9UmyQUtWXT+Bt9kNWSIAAGspSjAlJMTmS7RLtCikYdQlJJcog7Yh+yONXboEADtH9iZSpgSgKxErPRhz4I867TVuMqKxfIsu3HnD6ltTCiC4Wtm/gzy4Isg3132tvp6Ot39Vr9xPuHj4S/bUp7aTTboDaZTG8avXqhFwJotXscX5v1Aikqz+YMFu8BzYXK02k2qYBdRCEqO9VtnsVwXcLX16HPvwtco1dHVgiWbUM3Jo3cS0PMmZ1qQ1NawtOfPaKsMqUHm7k/097GpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0wQW7ZVa24UHy4W0G7urcfoWnleRXWXNyQI/yAEk8I=;
 b=T7NOTzz9r71HHLs2jN6viVmXHRijZFYcu8P32CRwQudc5cDuUaNm0/hhEEjb8eS8MGQKmd6kRa4piolg9CASLGt/3bxoC9+13/NjqcnkHppeHnmvWQEQj1/1Pp0L1F9nwTk8HzQe+OFu1vJ1WGmhc9CFr2HEtoHFeuyy6QhNywsFY2cCabzV5M4wrRvjpNV7WN6r4QXatb3hzlZQLiDJmn2fTSfaYe9T7k2/ncC8ZM1qjt2T2Q+4+svpyckPI8vOPQZ0FO/rZGE2Z3FJpGRJerkDod3tJZ1oeqMLhGqPbxmoCGRr6BcrGIypTxtC+YBJYC5EZXnve/URT3nxfvOWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0wQW7ZVa24UHy4W0G7urcfoWnleRXWXNyQI/yAEk8I=;
 b=5knkm4hjCecvnh4DIlH5z6NeR3ptBWSR0jkju4jX4O/jW/JeftxEQEtUd5zHvsV3dvqARD2QHWUj5fp4KELtmcPuyN22XdGQWUCtXtAktqTSXbpm2LWInVbeLluG8yNtwB06bJEy7enJ4z+yFU7+JTV5oUloJnIPRXiJN/guJ7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Wed, 13 Nov 2024 17:00:46 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:00:46 +0000
Message-ID: <f5d6114c-b03f-4faa-b210-c7090e20afa6@amd.com>
Date: Wed, 13 Nov 2024 22:30:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20241113110009.65256-1-urezki@gmail.com>
 <20241113110009.65256-2-urezki@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241113110009.65256-2-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 173a069e-5ec5-406c-88cf-08dd0404b72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZwcW53Z2Y2VE1ZbGNvK1lGNmtDS1Z5K3IzN01NNFdOVnBBck9QTlcxZ1Vz?=
 =?utf-8?B?YkIweWZDRHpZZzFCSGRIWE9YaXhvNTlXUDBCWGFsdUZyODY4SG5KSEdkNnNQ?=
 =?utf-8?B?ajVJY3hoRHQ0UjFCTWlHOERLdEdPZld4cDlaT1ZiQzl3bHM2K3RuZ2hHTytL?=
 =?utf-8?B?NkdTZm8wT1RBY3E5d0hzTG51MXI0ay8zSmt0VGQ0bGRjSjVrcDBBTUppRXZX?=
 =?utf-8?B?REZEQU5UazE0WjRRM3cvTmNEYXR0SjlXNFFreHN0U0xkQzJKQjNFcHBpSUNr?=
 =?utf-8?B?RHBoaDIxVlU2UXQrbHlvTjNzUXg5QjduNFV2eVcrbFNwQnBTcXhwTmdzNk52?=
 =?utf-8?B?UFBMRUZIZThSdjltK2ltYUpuQnpPKzJTcHZWY0czSDhReCtmRWxZVmRPaXhq?=
 =?utf-8?B?ZENJVlBvNmpkTXJiRk1VRFNzWXh6TGxldmFIMm5aNDluQUo2WTBSYjBzM2lO?=
 =?utf-8?B?Z2NkdFEzeFl3SGVyTkR3cjdNd2ZhRWEwdTF1akRZKzU3Y290b1VHdndISXJq?=
 =?utf-8?B?U20xYlNqOXQzL3hIUXlFM25QaXN3cnZFZHJ6aDhQcVhvWWw4UzNZTWZlaklw?=
 =?utf-8?B?cXFmZnJLcEdYdkxINnM1d0xCRXZZakxZbEhmUEVQMUZEdHRCaDN3MnFERnh1?=
 =?utf-8?B?djRjUTkySE5JOGtuS1RWc1hUWi9LNXMvTm1meDFzNnZseit0d3VSWGNpUmRS?=
 =?utf-8?B?S1ZPaVFJRy9SSkZDZ2NENDdLVUV4SUxNMzlTNC8yTEowOVZQU2FES1J2N0NI?=
 =?utf-8?B?OEJEYUNnelljOVN5MkdOc1JkdDJVMFNEV1BVM1lYME5EcHJYbTBGSkxSQ202?=
 =?utf-8?B?aUR4WUZLaitUc1orclNHWjU0WkdyUjlWeXhremNPaEYzTzZuMUhPMEZsK3dr?=
 =?utf-8?B?OFhHdzV3NzlRNGcwdVVtL2N0azlHNDZCcjZISzhQNmJyM0ViRk9pWkZhUXJK?=
 =?utf-8?B?eXZxUHQ4OTFkZERaa0VTRHhOcno3MXd6N1ZvcVBaVU5HVVFNZzBRWlNvcXUv?=
 =?utf-8?B?ejZXWkxYUEhMdDJ1Q2tqSWp6QWZsZ0xnNUpyODlJckZCckE5RnB1bjhTR1k4?=
 =?utf-8?B?MkZSNHV4eXhZUUZJd2JxZ1g4VTFHKzJmR05jcUlsb1hMR3ZQOUdqczZuTkVj?=
 =?utf-8?B?cXhPK1YraUdJU3dnZ0ZHZU1EWjNTeXpQYlVIbVJmZE1FT3Fodi85b2xFUFhZ?=
 =?utf-8?B?MHgyRE5OOTBQc3o2S1YwL01hNElPQ3VQRGZ5Nm00M2VaS3EwNjJKUUw5bHh6?=
 =?utf-8?B?TFB2STFuYkVyWXZvSHFXWitwaDFwUWxIcXpYQ0E2T3p2TFlQUkwzYWd6RHVh?=
 =?utf-8?B?b0Vyb0F5enQ5WkZyS200NmtZUGRsSHBKTmlMT0VSRDc5ZjUwMXhiTERsYmVD?=
 =?utf-8?B?R2c1ZVUzSjlzR2FnSFd3b1J5M3hodXpHTk0rQjJ4d09IcitUNXhzTVhOOWow?=
 =?utf-8?B?b3V1akdBOFR1UVdqTmI2SzZmdjFUUCsxL0pCdllhK1E5QVliZW5IcFc0bm5s?=
 =?utf-8?B?NWVFYXlGeVpJdDlHMm5NWTFzbzFPZ2ZVTXBTZ2R2L3BNK1d0a21oQktRRnpO?=
 =?utf-8?B?SGFZVkE3TmRlZkpPajI1Ymw0WTRNdFNrZkJjN203L0xRWjFhUjkxUjBud1FN?=
 =?utf-8?B?RUdyaGRkaVlqWDlCcGdQY0xHMWR5cjlxQUdBUmdnK1dvOVNGRnI1bDJETzZJ?=
 =?utf-8?B?RlJKWFBuNUVnWEZ6dDVJMXlzZG13OUF4QkxCdU45VnhjdWY3QXp2STdQdHpD?=
 =?utf-8?Q?Pu+DssyYP+ZmiJndElPBS/qSuXOawjJCAlL7JFh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVc3MDlpT0FUcG9LOHgzTzRQekZEU3c4cnhzME01UldpNUNVQnhFaFNZWm1C?=
 =?utf-8?B?NWNseWZVeGs4L0tyQ3ZWUi9HOERabFFxT1RqcTFaZEcyMnMxc1Y5bzlLMGpK?=
 =?utf-8?B?WEtCMGJHeEJ1QXNtbFhpVTRUWk5XVkh5UXVpSXBjRWFHV3Q3R2svM2I1U3pH?=
 =?utf-8?B?dTdmNG9yMUNQbVBkMElwUTJMejJXN3R4dHQ0TTNrUFJObjZOd1hLYm5jb1Jm?=
 =?utf-8?B?NUJpZ3VnWVBndUNoZFJRekZLTTJGdkllL0taL0xNVXQ3Z2hNU0oyTklzdE9V?=
 =?utf-8?B?dmJqTndxM1NvQnR0RnZDUE1NRUhXeE1obnR6M1d2OFFNMVYxbUh4SjM5ckRo?=
 =?utf-8?B?bDlWR3RiM1NEbnRra3JpWFBCTm53dHlBMlpuanRrZjl5dVNnM0w4eXVjZ2hJ?=
 =?utf-8?B?RkNqOU9hWmJOeDc1aGc5Z2RrN3NjSmYyYVl0UkNveWVZZEVjaS9UdFBCN3BM?=
 =?utf-8?B?VnExRG9IcVdYaGZtMjZCNW5sUXpocmJTK21Md0gwenlDU2oxa2lPckJFUS9I?=
 =?utf-8?B?THpickxXb0xnYnpuZXE0OGhjMG0rNlBoTUw0aXlZMHp3TzJ5YkY2YmExUHd2?=
 =?utf-8?B?NDZHNDFkRmtEMGwzY0Jxd0FUZjVMNXkvTUNoNGdyUWRpRkMvZkNmVkJnU2g5?=
 =?utf-8?B?S0JxVWhaSlFLV2wxU2RMOS8rOVdIVmdlVUx0QzhhQUh3TFFLS1BvSlNvUG4x?=
 =?utf-8?B?ZjdWZXVidFpyZS80UkJXWjdLTFRMTTVFMkRLZWZBeVpsNTc2eGFFWUF5N2U2?=
 =?utf-8?B?aW9pVS96K1NRaFhxMXpneTdhWUVMMVF3cVdnbGdGQmE5T05MSnZQLzhyTW5v?=
 =?utf-8?B?RWNLVWJ3N0hEYnJrZ2lTdmRMcmhzRmV4TmxqeDEydncwQkk3T2pSNmEwYkdM?=
 =?utf-8?B?amttcFkyODFzYWY2SG40Nmx3VWp5SjVYakMzTFFJR2lzTkIrZGE1M2psRzly?=
 =?utf-8?B?R1lPeUhxWnNiU0MrYjFtNDdDa0MrckI2cnhJYTZFL1ZwN2FxdzJ5QUI1VklE?=
 =?utf-8?B?dk5wYnlGQWR5cUxpTHFoc1czdmtCUUEyRDlaRTMrZmFqamdwcGI4dkRxMlBh?=
 =?utf-8?B?NHd6TFlsVzIzT2xHa21JTWlteWR5Wks2TUVoTTZNRWxmZi94VFd4ZXVta1pp?=
 =?utf-8?B?UHJwaDJVRmttY3YxSUVtZFBISlBRbmJlRmhURXpTNFRONE5vRk1KY2hyNTQ1?=
 =?utf-8?B?c3JINURSNDhwUDJMdURFcUZoY2tFQUFRSUhvbVNUcHdVaGt0YkVpVklOQUYr?=
 =?utf-8?B?eGd5RG5XeVZVQ1ZwaldLWVhWbXI2dDUzUWZMZkN6Wm45UXNRTzlUNkxrQTlW?=
 =?utf-8?B?dnk0dkw4cDdkZGg5dXk5aWV0R2dKY09IMVJyZnh1TVpNQnU2OVM3NjRhb1VH?=
 =?utf-8?B?bkU1UVQ4bjhhOC8xN3FVdmZnd29LNm5maUpRdlVVT29lZlFKVDArQmhaeVpV?=
 =?utf-8?B?eFR0V0ZRNHQ2aXlTemUwSElUaW1Xc2krSjhEOTZqL2NURG5NQUZhSzZ0eUNa?=
 =?utf-8?B?TmZkckEvRi9wNTJmay9LYmFLY1R3Q0lNYkJjQmtIZWlQWTNnVkUxOEpBcVpj?=
 =?utf-8?B?Slh0ZFJRRCtmYzVCUGJPMzdpSDQzb1liMW5iMXNMRzJzampPZktGWUsvMENq?=
 =?utf-8?B?V2lodm1RcGhYOStHSk9laS9aK0pzcTJNa3lDVmtvRjdUdXRYTE9VUUQyNVNU?=
 =?utf-8?B?eVFvZllXQVBTbWVqT3hCdytiTEhLZnZRYVFrZFFaRGQ2OGxETnVPRjB0TmlO?=
 =?utf-8?B?QjBQQjNRYnVOR1Z6dU9WTTFGUHJvYlBJUTBZOEpXQkpUU3psOHJWK0QwbjNZ?=
 =?utf-8?B?VVBqdUQzZUZJK21IMzBKNy9tSlpXR2tyZ1lNdTJUSERkRlZIYXhMcG0vOHhP?=
 =?utf-8?B?dWo4WjBNa1o0eGtlWTQ4Wmg4c2xwWmNVZytnaE0yZERqV0RnMHpoN2tQQkpn?=
 =?utf-8?B?R25QMktKUFBnQW0zcUYyNTNrQmkvZnVmaFk4WGRaSUxrWHM3Mys4eEFLNnhL?=
 =?utf-8?B?U1IxWWZEcnlwa3NUVFEvR2ZsaSt2WC9kVDF5VXZLOWtDbU9oQnhFYnNuZTFQ?=
 =?utf-8?B?L1ptM3JHbHpmemp0TjRDak1XdVVXQTdXcG5YY00xWTdaUjdmUmVrRnRNS0tn?=
 =?utf-8?Q?DQALpG/9cBfh6hpkMQQsCUZuZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173a069e-5ec5-406c-88cf-08dd0404b72e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:00:45.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwnbSqCER6hLQw9SoBmY6SPYyFxfL3RVqO0YwPU3vGtzn1ollIeWoB9UN3hIk/5sF/MMuw6xm/jn74KMubbwPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072



On 11/13/2024 4:30 PM, Uladzislau Rezki (Sony) wrote:
> There are two places where WARN_ON_ONCE() is called two times
> in the error paths. One which is encapsulated into if() condition
> and another one, which is unnecessary, is placed in the brackets.
> 
> Remove an extra WARN_ON_ONCE() splat which is in brackets.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---


Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj
