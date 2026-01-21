Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297033A9E5;
	Wed, 21 Jan 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025065; cv=fail; b=NfoYrMJ7OP4TApVqLD5XzTJ6ruifCl8DnpuCzT8VWfX47fAq5HR051CGCPNzZrOPkNYQcqCiU+LhXlHtDwvvL8b7LdOr0GHQW7bTuD1EJsKq0LfU+ApMEC3d2C07hUNFoOI7S4gHvbz2D5UFF0gnnN/0XT+a+8pM3izjA+3mS+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025065; c=relaxed/simple;
	bh=is1FB/pDWmNSNMfx3MZBYgl1qNMVdNSt9HyloeMozrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KeSbr9CMhTRCral8bwsSksnYYP9XLNITR3ckD6IRuN85e3mpUUeloB5AURPrmOhCJfmqUVjyq94lv7NhbbjMdjzWgy0vOVMvP9uWwfnKMxoFWGEIjOXAzI29Y0VBfOpRE0eKjOxry2zEdEMTkpYqWBLOTf+8h/IXRmTHSVsusH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRlc2esG; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRlc2esG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9yOWp67iZhFbC/Txs0vbLrA8VtHd+buEn32g2nWE8xqep0rcBc9t16w6qSdK6FGfvMJkj8ZAg9WH6bAmUhX9BkgULYoHfZnxBGDCjQpE8mTpePU3ZHo5TztpKXy/UPAFnzWXfOb+lDhrkcm13jeUIZrUZkYIDc9qGt34G131iPofeiBkl0fmgSyDklEzHU1wsH91VLIZOp0nlK5pPANO46i8Ov+j/BmcOJhPa2ZiwgHaq6KWO0j9cQjdunOaefisFnB1OAcL9UiMEtOGYJPUFUJj8/PEu1obJkL8zSL+iN1VXk4GXUduTRdmuGOGt/7w+xGnGdMO02ftOWpAxS5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yrZiui56dzYvbb/z4FJRaPoltTNcoPUMV5q6+zxwmg=;
 b=RTwsZ1nMvGQPSzsdc9DCSSGBKaPLFgbuuPhGAHLTcG42rEjk+u73NkqcusYwUAIg8Nk0mMxSe8DdqeBdYr5kftwlJsgsvenSwtijM9qEoTboc7Q1WQO0grRzdmU63Jcdypq81ThduesyxM2v6Th1jDGWEKArUK7ox80/5eFKmqV8c/75qrNIoUIEreF2ICXjmTgiDre93ypWFp7cMlZyOpuXvuwhXfzCTdxTJFbO35bV7zLhmJRJ2KEQRLMZF9FngPTEIH2HWOPjPqFsNJBsRJRDnfW1NRlRPRGRyh/xXUY12c5rJKdwK8eaB3yjlkq7Bg9Ijtpwms6La2LYOhB0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yrZiui56dzYvbb/z4FJRaPoltTNcoPUMV5q6+zxwmg=;
 b=VRlc2esGOfwnEsW1d1pK3sosf4CB98foGvJm3l+3FEXfBHHRdi0dqjWvcB87XohH22nH00gdZliHLKjd8g51xZ6sDyTjTkUa66gVyw8gVbkQkByTY7doB3Te4jXxQoYoCIYDxHdVEeqkcXC/RgvlOnRwFPkLJ5CFfrt8TYdQv7dGepjEQQvu47F05pJAtM68cEgiV1hJ6vc3Xm58hvpVbl6zfH3PrXIBB4jM8pab379C3qRJqSxwQiaM4nmWrgFbMnawzuZVxz9A7KiCurG9vNSlLzjEKHAJKXBjINd66nNQOCPcHisoqB20F2EGwq68sDvu6Ndux2NpLRWso5yKQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:50:57 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 19:50:57 +0000
Message-ID: <cddea3f4-4041-491c-87f8-0ffba948a3b6@nvidia.com>
Date: Wed, 21 Jan 2026 14:50:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 0/3] rcu/nocb: Cleanup patches for next merge
 window
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <f568bee5-9cda-40bb-977a-a9063bd2c611@paulmck-laptop>
 <be3df000-915d-4fa1-b7e4-231df1344815@nvidia.com>
 <78a11bfa-4613-450d-bc3c-238e0b44557b@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <78a11bfa-4613-450d-bc3c-238e0b44557b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 392f78c4-9e6c-4f8d-16e6-08de592664c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZibG10cDlNNEVVb0dqVzJCNXdWTmtBaXFxdlRYT0kzYkZLcHpvN2pkeU4z?=
 =?utf-8?B?aTlUdHJOMStxaXk2MnA4UmRoWk5FeFJCeS9MTjhsUTEzMnJ0YWxNUnFOZWhn?=
 =?utf-8?B?Q0FGNCtDSXFTaENISm1LY09JTXhxeEh3dElHcnpHOFhkR0xQTVFJOHlYZ05P?=
 =?utf-8?B?TnpKRVcvUU5tb0tUTWlvemh5RVU0Vy9vM3kzOCtFSFlHUXlaRUFHSGZCdUlG?=
 =?utf-8?B?ZSsvV1hERlpwUFdGTjQ4ZlAvMTNaekxJcG1iaURJZHpZUnZqbDBzaGRLbFBp?=
 =?utf-8?B?ZTJrSzdoRzdvNVh0YzdBVURMOVdiSEFUK3QzNkhqQjU0aVJmQ0Q1RXZXdXp0?=
 =?utf-8?B?aHpNbzExTVQ2Sm9lRENyVUp6bGtpZmdDYXBsWUZoVFQvUnR6Vk5OcjZ0Vkt4?=
 =?utf-8?B?VjJwY3ZDVGRkL2pvU2I1ZjJ2b3MzVUE3V1hqaFdPMDRiYzl0QW4rdG9MeXNE?=
 =?utf-8?B?SS9FcjdMZHRheUpKeldFTHJsbTlSckdmUEhOcE1zNy9BdDhqVEF5WE5pVGVs?=
 =?utf-8?B?R1BzNGhaS1h4L3VZVkl6TTdINkZKd0xGVzd0bEk1THBEM2xHUnBxOVUrQ0Zv?=
 =?utf-8?B?YWJSMzAwYlpjWXh0cjNHUk0yS3pkdUlVOU1wRXRsSUtVektHUmRwRU1wblRY?=
 =?utf-8?B?MDhsZGZtN0hxZ2FVUnlpRThxY2dxaVZzLzI1bWQvNnFrMVgvNHlXMjFMcUs2?=
 =?utf-8?B?YlBZUGMzVEhBOTRtSnJQeU9xRUcyQXFvbzFaQUJ1V295TnYxNXl6ZUwxN1Fo?=
 =?utf-8?B?eWFjVG4yL2QxeXNRbm1Kck5SWENLYnAyYWpLOFp4dnVrWlVpeHJXUzhEMUly?=
 =?utf-8?B?WkNXeDhuRWVuTVFla3VkOWdJYU9mWnRFeW02dmVlNXd3TzA0cVI0Q0JiemFQ?=
 =?utf-8?B?KzhrMk5kY0lTK3Fla2xqcUNTbGpzdVRtWU4rSjFsV094T2QvRXpSUTJ1N3hQ?=
 =?utf-8?B?RmV5QVRrOWRLTTd2TEtZTXlTcHhZSWVLRHByK1pFRm5yYVd5T3Qrb1ErUFlV?=
 =?utf-8?B?NEZMUXVEaVk4c3VQVFRBN2dsVWNEMUhQYVU4TFBWM2E5dldIcVpVcmptRkhI?=
 =?utf-8?B?bmZ0dUhla3ZBOTZuazVHcEY0QjRPdWlHWit6LytrMXp6ZTNENHg2Vk1FN1Bm?=
 =?utf-8?B?UWhxUThTR1ZGODZYMTNyT2VnMU5QeWpSbnQyODlwMXE0OWpoSzJBMENZUTJz?=
 =?utf-8?B?L0xveWNuMUFPTkl2dXozMHhXYUIveFhITXRudlk3ZytuTC9QeTdvNm81Wk12?=
 =?utf-8?B?SW1hR0NZdkFuUzdEc3NMaTcyRXIxNGlLQlF1MEkyYUcwb2t2aFBjNU1mTUZl?=
 =?utf-8?B?SVBXUnpJMW1uOW52NEUyc0YyYkpnbUNaMXRMbGhQLzU3eFFkU3hLVDhpNjdE?=
 =?utf-8?B?aXlsMXo0a0RkK0pjUkpJTUx6MHBsdytvWkY3T21qMlU0MjRya0hhOHN2dnFj?=
 =?utf-8?B?MUJ0WTEySGFhRXk4STVYbUdSVHRBVU13N3NUYXE5dzA3TldvUE5jV0xnRlFn?=
 =?utf-8?B?ZWRTNG5iV214eGdDWmVDSzZ1S3dQUWt2dkpkR1BxcjhPbWVxSFNrdzIxVHJy?=
 =?utf-8?B?bFBEaTJnWXUrdmJjWWVWd0NCT2g5bkFYMk5BZmlNZ3F0ZVhjWWRvWjR2WG5B?=
 =?utf-8?B?MUNnKzd2SGRSMVl6akJPaE1ZaTBCSkEwUXF6MytZWTJkMHorbkNyclpXdU01?=
 =?utf-8?B?cEdYbEE5ZG5TM2lMUE1CVXNlTGZEME54NkdqRWovSklTeWFTOEYwOVZvcUd6?=
 =?utf-8?B?M2wrWW1vVjBwUDVCdEQzWFM5NUpmRm1vVDZLZldFMVNMOVRXczF4TjhTMjlN?=
 =?utf-8?B?OE5pRFcxdHhUWWszelhOdkFhcFhaZ2RWalVRQ0NqeGY3SE9EbUk4aTdRUGov?=
 =?utf-8?B?eGxHc2hiREtadG5HRXFqVU9tNUsyOStNREx5NDJOcVY4V1VEMFh6dktqMmFQ?=
 =?utf-8?B?SDlqc0hQWUZaSkJKbVM5bldXOUo5YWtTU2JBc0JUWDlGR0JlbzdrWGpqQWh6?=
 =?utf-8?B?cXYrMmJpOUZUNHdrNkFpeVZ4d2FWbDRLWmFHYndhajdKcGZ2TDY5eHJRb2Rj?=
 =?utf-8?B?WUVLTWwvUFBNTVRDWlBpUUg3SisySWRRZHlVN0FWdHpSVFEzTTdTMmtYbXlz?=
 =?utf-8?Q?g6kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L04vUE00TGJmNTFBSUFKYm5RZVRTWWIyVWdGelNvNFowaFVKOUNhOElHOGdU?=
 =?utf-8?B?ZTNieWRxbkJ5UFBwVGdUbXNWOTN2aWRnMTgwWnVSN3FLeWVld2ZvcFdjNFd4?=
 =?utf-8?B?MnhoRVl5T2E5U0VVYjhkSDRtSzRkdU9vZStxeG15OE84b3BDQTloSnkza0tp?=
 =?utf-8?B?SHhOdm1OVUlidU5pRm1yaXg0SGF5WXRBNnRtVDZuRHNzWXQ4cEZ3T2loRXVy?=
 =?utf-8?B?R1UxTjhZZDB1SDhZVlBiM090RGlUclRzMnJWNVd3cFNwck1YMnFET2J3L1lY?=
 =?utf-8?B?TnF6Y28yVlFacHhGSzNsY2grWHAxOFZtVmZ3TWljZkhnazl5Ym05NncvYmtB?=
 =?utf-8?B?S01lVnlpa0FZQnVqUEVQbkZqYWorc0NJcXdZK0cyOEowbUIxdmhkWCt6empa?=
 =?utf-8?B?SmprZE5mSG11WllDbWtvREIraTBkY1lCN2cxNFlZTWR1a3hSbnovbGZWcmFZ?=
 =?utf-8?B?V1JLeW5Nckhxd3JHV3YvRzMzUlNuc3BTWUswRzVxQnVQUGt4S3pRQ0ZNMHQx?=
 =?utf-8?B?US9UajQzUHBuZEJTNU5ZRXdkeFZoNWpyQ3R5T3FoUDUvUlo2UlNLTWY4NHQz?=
 =?utf-8?B?ZVVRZkFscFJ3Ym1KWWNpU0xtQm01ejB3U05sUHd3VWcwRmMxWm4yVjdqT0p1?=
 =?utf-8?B?ZWgvWmJHb0FXRHVwMU52bTRBYmFPZysxUnArb1FPbnU4YjBpLzM5TVhUc3lO?=
 =?utf-8?B?NGRSRWp2MGE5NUhsY3V6L2dLeGx1b01STkpiSzBRMkgxNEpUK1YzaW9DVncr?=
 =?utf-8?B?R2xMZ3pienlqK0lsN1RiT0ZnaEdZeGhEeXVKRW0vd2FOdG1oZkgzMGZDeHNI?=
 =?utf-8?B?WnhyUjJmdlZoT29DZ1RxWDVsNzV1b0Y5TktSMi9wY3NHc1RHRnZINVlHcjVI?=
 =?utf-8?B?MHQyQ1pnUUkxL05QaTZwYjlYbEVicDVGclkzOHlycUh1UFRycnpUU2Z0MjFs?=
 =?utf-8?B?a1lwVmZKSWVPRGhTSEYrRjBOR1g2alJlcWVpbEkzYk80dEVPMVpJczdrSjB1?=
 =?utf-8?B?Mm9qY3ZFa0ZLMTBjY1d3aElUdXZlVE1Kb0RRa1RYdW1BUW0rV0RrK3MyMEFv?=
 =?utf-8?B?R1ZCSFFBY0JhRWdTWGtVckhCVmJYNzRGRGhwaXdNUWJiWTZydmxUbnAvTC9L?=
 =?utf-8?B?RmZTTEdtaVQ3cXhmL2cxUHg2Y0prams0eTJqdEZXOHhSWFNNWjIxRUJpam9X?=
 =?utf-8?B?ckpJbzgrcERGWk52SjJkd01iMG9VMWYyL0o2SEttVURNMjBFUnpjZk1iMXFT?=
 =?utf-8?B?aTh4VElDTUpnWkhMaFRmVzdzWUlHUE5aUHVnNGd0NTJ4NmcxK1Z4bllkQWRF?=
 =?utf-8?B?WDRzUWlrVDY1OHVBNU9IYkZ3Nnllb1hqV0hzbEFPYm15ZkpSMXZNSHNNNEJX?=
 =?utf-8?B?SWJxcjhDNmR5c09KUE0xRlhmYXdpbEpDZ1JCNmVoeW8zNk5jRGxRQlVMenZU?=
 =?utf-8?B?Y2xmZ2luTmtoMTMrNzJsaUl6MlExQXNZTkd4Y0Q4czdQWDEyTWhlUVd3VmZS?=
 =?utf-8?B?ZzJnS2FMMXIwNmFMc3hxc0d4WTRWZFdqVSsxUjJlRDU3SThPMVBLTXoydW5v?=
 =?utf-8?B?eUsyS1l3ZEJwMmVOMEhVc3RRNGxrRTB2WjI0NlJQZnBLZXJrQndIWGY5OUxi?=
 =?utf-8?B?SG1VWXRudEJ2K3ZZeW9mdVBLdXh1SmNGOHJXQmZZRlFZcjFBVG1UNFhEbVRB?=
 =?utf-8?B?NEpjRU1Rb1ZvNnFEd0tPblZ6eTNwOEN5c28yWThDdXVEUktFbnlTa0JpMEdC?=
 =?utf-8?B?cHlCMXhLb0dVYUh0QzQyQXoxdENOZElwdXZWNWJwUnd2SVh2ZXpJVjZ4bGkv?=
 =?utf-8?B?b090cGV6ckRWdXg4aG5GTDN5Tk5aN2NTZWMvQlhQS3czang2ODgva3ZIUUZ5?=
 =?utf-8?B?cGN4RlJ1aWt3ZWgyMFBPN3FiQklpOW0xRXo0V3lJMDlCOHozUENqdWl1ajdh?=
 =?utf-8?B?Y3BWLzVFL1ZJU3dOVTZQWTZRZzg0TzlrcDQ1cDdqU2VtUmZ5UEpBNzJsdnd4?=
 =?utf-8?B?STdVSVZ4aVdtcmcxMHFYbzExUTN1dXMzbGNHL0xUaU1EdFlwMmVobTYrT3Jy?=
 =?utf-8?B?UmpQZ2lnZGxaa2wvajBZSmYveVhKSW9ablRJNmQ4Uzl4aVBEaWZEL1ZtTUk2?=
 =?utf-8?B?V25TZERjaEYySWNpNVJSUVFnd2M1WHU1QnBzT1I4OVJsbHpLd1hGSUg4ZlBL?=
 =?utf-8?B?bnB5cXQ3cG5KOS9qSTVpMk9TeWJjaktkbmtFalhERUMxTjc3ZzJRckd6d1JV?=
 =?utf-8?B?dlBoWG5JQjZTa0Y3ZFNVUTA5Y2hKZVpaM1o4NHEzbkMyVW9HQVUyU3lCUlls?=
 =?utf-8?B?bnlmMExMVlhyWGE2dGY0K2g3YzhjSXp1Y2tia3JjcmhvK2RSR3NDZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f78c4-9e6c-4f8d-16e6-08de592664c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:50:57.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOgQZh2wWY0biW+B+w3XYGUeWQi0UwSXZHZipTwEayD3jWXRCpOju1e8+i0C0Mloz9JP3zr6PHrwsMhz6OPduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6



On 1/21/2026 2:41 PM, Paul E. McKenney wrote:
> On Wed, Jan 21, 2026 at 02:13:56PM -0500, Joel Fernandes wrote:
>>
>>
>> On 1/21/2026 2:09 PM, Paul E. McKenney wrote:
>>> On Mon, Jan 19, 2026 at 06:12:20PM -0500, Joel Fernandes wrote:
>>>> These are a few nocb related cleanup patches for the next merge window.
>>>>
>>>> Also Frederic please object to the second patch ("Remove dead callback overload
>>>> handling") if you would like, but I think based on our discussion I have
>>>> implemented your suggestion, so it should be good.
>>>>
>>>> Changes from v2:
>>>> - Dropped patch 2 "Add warning if no rcuog wake up attempt happened during
>>>>   overload" as it was not needed since we removed the dead CB overload handling.
>>>> - Replaced "Add warning to detect if overload advancement is ever useful" with
>>>>   "Remove dead callback overload handling" per Frederic's feedback - instead of
>>>>   adding a warning, just remove the dead code path entirely.
>>>>
>>>> nocb rcutorture scenarios passed overnight testing on my system.
>>>
>>> I reverted three of your earlier patches in order to apply this, only
>>> one of which I am really confident in.  Please check my -rcu tree to see
>>> if any of the three should be added back in, and I am starting tests in
>>> the meantime.Age	Commit message (Expand)	Author	Files	Lines
>>
>> Per your latest /dev branch
>> (https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev),
>> you have the latest 3 patches:
>>
>> Extract nocb_defer_wakeup_cancel() helperdev	Joel Fernandes	1	-8/+11
>> rcu/nocb: Remove dead callback overload handling	Joel Fernandes	1	-12/+0
>> rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path	Joel Fernandes	3	-36/+18
> 
> Thank you for checking!
> 
> And just to double-check, all of the patches that I reverted are obsolete,
> correct?

Yes, those patches were from v2. You have correctly applied the latest v3 version.

thanks,
-- 
Joel Fernandes

