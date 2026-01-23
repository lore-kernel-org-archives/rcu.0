Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E313352949;
	Fri, 23 Jan 2026 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131815; cv=fail; b=NbGtQhnFSCPc3tZ9OGwGnwACnyWM2FlbF+cv6o8bLbBbpEAny0pXgygUD8UgghDXCYyP5BRPpbGxKVU6tdlVmZ0elZEf4cCYGQG2mpRHU+PwF7cTJMgqME3qcGaDWh2st3gImgbbqRze3/+XdJ+ySMiqVdkhtR7tAzJKsJxJJmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131815; c=relaxed/simple;
	bh=6rmpIY1LEnsveInOLrDu7p+n35VPumOoJPHjQ0SITs8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L7HvIU5rWSmi64eeXvwAxVQtJrit9AcfIKL+qhOMdJUrQ309Xva9O0OmIMFVr/eVapD8idjOB2teAzZHnkndqAwKCjumTytLIFXIGiJZF07XaMLNv7x0kClM2qABUinaOaNVIsgzUQhxCOX1G68y+/rnjDAJH1L6SVblPVUb7S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OrlC4g9P; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OrlC4g9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh/8C04ORyUxJgamkJwetCnh47fYpuMX3nQJ45NvOJWssAvb5kOOTUJhzv20Wp3Cd7I6lYOuxOmGMxI6hSQvJqiXMDnD4PgtLL4zL0PCFi1JuMwiiDE0Tnpb0QUp4kBhbv+qSXpobsFlty9o+G3E7AKCqok0a8OtIYee6xbqUXYXzPEOgIyOSlmfMhPb5cL40tl/wquCHXq9z0nc42oO9gDIK87c9YaD+Ic7ZKgrr3XBJfW4auE9AcH9oUm8Cq8uMoyf3nqOa7qP6p/SI6IT/eKPIuf9EJVu75EfPlucXeE5B8oKq4arTAQSS34B01FeQqgrD9ARM+8hnsgJS83v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asRQEjwwykr3WURoS3VriApMUl4XYsJwS90DCcqPZwk=;
 b=lyV87DIpA65KYKx8He7cpzJnxhounkMd8gsqZEmpJUE5b6vivuERaLkPK2xc3/jx9CUfJT/+aIGUBZ/SGjcX1ErncKuLk8dYn0KRRFA3N0g3HRCf9nbDXUWPqbCxI/VlUaquFmqNXYyNhzX8Hu3/X12xo+sBdpx+ALxBC34lAouuZBOwDeNUfkY8KU4j13QoXoIHxA0y/6wRaZLSyYZbn5rSuTQwssMLIX1RDgjGLXcX7YmeucBRHj+WM/ybZ6wiUZj27P6tRspN2yIbjGmE/B1jQawcheN3PM4FVIeQxTD8hsAbwkDowE0fnjEAG1BWU8cwXfa1Yir30mOOcMjHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asRQEjwwykr3WURoS3VriApMUl4XYsJwS90DCcqPZwk=;
 b=OrlC4g9P0iei21TBnQwQc1a5YIL95y7Slns6cLdyfySgAsl4JFP3H/4bXw+L4prGW9ugQxJ+Iv+whjpS0Q8YdNazk1+cAz+5FDi3Dnh+MVcKOhXt7a2n6wTXjWbZEfYl4cjwulwvY3EXCA4CTk9lc3SEcCCE0jgPRT7/FzUI7x2A0507Vc273eTLMxiL93tX49WNuYxzITwFBKaSgt+Fd0Rs9Tx2AECRe2lhKRez/QHiKPmoikPhF1QYDuehguSDVs2k2252nV5+okJwaV5Zw219cnsyQxyztkfIgTELaFtTfNNRsAmpiGV11CNqcMTg+uVdl6bSn5MY52HPIKVgFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 01:29:43 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:29:43 +0000
Message-ID: <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
Date: Thu, 22 Jan 2026 20:29:41 -0500
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
Content-Language: en-US
In-Reply-To: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:52d::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: e55eddac-7a2f-44a5-9834-08de5a1ee268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWV5a0NSOWNtV0padDd3RWZnT0doOWhpK2pVTmU0TnRQQjlOUUp1cE9XZDRI?=
 =?utf-8?B?MWV3ZElJbHlmVkhjTllWeTJEdk5DSDFRdXFwMzNUYkNYMjdFbUhzZURUSm10?=
 =?utf-8?B?OForVVRpalBwa0RRQllFSTc2WEo4MWVRS0l4Yi9tZnJjbHdVR0xBNjd3MWM1?=
 =?utf-8?B?UmE4bksxOU9OYTdGRk5GWjM1anVkM0l1VGxWZFB1Z2lOQVNnNytmdlh1WTFT?=
 =?utf-8?B?WlB1VC9yNVc4MFhMYk9JM0NvWStMdm5GSlJMV0VWSnVXYytsRWl2dzJrbFoy?=
 =?utf-8?B?Z05NRmIxd01RVlo5VkhrV0lISVR5MmI4VElzVDNSS0pRRlVBcmM3am5qZ2hK?=
 =?utf-8?B?c0ExaEw3cEhsRklpWFJtTnVnVitLUFlocC9PUHgxbDZCTmh5Znh1b3dzSkhV?=
 =?utf-8?B?TWZ6U3FaRXBjUFRla0tEYWRPL0hwMTdWZjI0RTRWcHJ5VlhPMWd1a2RhOU1B?=
 =?utf-8?B?cnRMWS9WYlkvMHl6Ky8vRFM0ZEczcmJPaWhpcUZEaXhuL0VBdEpMVzdVdGll?=
 =?utf-8?B?OGJaKzR1VDc0a2tPSW5aWlRSbXRycXIyS3ZRQndiNHppTlVTTzVHMnlsTE80?=
 =?utf-8?B?d3FORTY5T0Nsak9aYUd0TTBWSUdYWk1MUzg2Y2k2WEZWelhMTktXWGNDOUdN?=
 =?utf-8?B?Ung1VE5DOFpONnNSMWJJQ1Jtb1dNUi80U09jdG5ZZWQyeGNNUVBQZmo5N1NF?=
 =?utf-8?B?c29HZG93bENLUmNxV1V3elZYMit1ZUxpUC9sOTlYSmhkMlR3bzlnOHdCUUVU?=
 =?utf-8?B?OU8wNzFBcFBCVU8yM2hJbVJhWkJveFhOUnZWd21Kb21SdFhEVmpvdW5nN0lJ?=
 =?utf-8?B?RjUzZkdRMmFKVXU5RnlVbVBGbG83YjhPOEhHbERtbUIxTWlLbUtTbUFEZCtW?=
 =?utf-8?B?VFdZK3BhWldFbE1NR1hyWU5rNWNCUWlOSzJFNC94QXYzTkJGRFo2NC9CRXYv?=
 =?utf-8?B?VUMyOHZrN3VSM0JDTnZiSVY3d0JSSDR6L1dPU2cxMHQxL0gwR0VNSmRZUlBJ?=
 =?utf-8?B?ajQwbkQzdUlld3pRcUJLUnRMZU1XNWYyMnlEVElEbS8vaFlXTmwvZzV4dy9s?=
 =?utf-8?B?amQ1U241T1hkNm9ValYwY2lONXZjcCs2QjJrbEI4Rml6Y2J1ejlFaVdrT1Ir?=
 =?utf-8?B?aTJDd1piV2ljOU96Y0JIMTVKaFFPeUVyVUMweXhXaFRUMXpWNTY3UWtBb3Bw?=
 =?utf-8?B?NVowdEJLbGE5MTVUdTJNM285T1BjR2VFODQxR3ZqQnMrYk51VW03bkxKMGd6?=
 =?utf-8?B?K0VjbkJCNDlrdTVrZjh2cnhES1ZkMFIwN0tEZ2lld2ZReGFsaWo2cmJyQU5E?=
 =?utf-8?B?bnA1UnF3b24remNZUTROVFdhYlBxb1VKWTZtK0YrcDBOcnFlODIrcVlxYTRn?=
 =?utf-8?B?UXJGVGE5bnh1MzZGQ0FsdXhzTmFjaTV6N2RJMWh3Q21GYjl1ZjRpZ1hpTzZy?=
 =?utf-8?B?dE9WUjFaY0I4dUJmU0NUWm9JZnFsMDRmODNVNVU4U1NKUlBKbTVoem9lQjFs?=
 =?utf-8?B?M1ZybnJTM201a1B3SUpmRmdqYVhpVjg1dW5XVG00cEltbkg2Y1IvU3pQa1k2?=
 =?utf-8?B?Z2VucUhIR09waUpuNTNxWHhHNXl3RFRIQm1IakZQZHJkWUJXcG8rL2x4S0Vs?=
 =?utf-8?B?aDRvY0lERnJqYmRINnJkWk1WVklBNE50akhNTkdLOFVDcWhpV1FncWZsdmRU?=
 =?utf-8?B?Q2lnRXZKQktSSmlMZ1BCMzFCVGxMNFR2bTdhMzd1L0hBSEdjdW8zeUNzcXRw?=
 =?utf-8?B?K1NCMHRTcnQyU0Z0TGdJSUVmemIzSFFkbm1pU2JtVDVXM1kybVl2cC9YR0dq?=
 =?utf-8?B?dTBibHorTEJKZWhSRU5WTmJwdkwwSDRJVC9WbXJGQ3Z0WUo1K2dJeWlrYWVo?=
 =?utf-8?B?L2FaTnEyTk8vMnUzTnF4b2JadDc1elIwS1VIQnNmbHhvQzhrN2M4NThyRjMv?=
 =?utf-8?B?Uk50ZzFlWXdJTkNlWVRpcnkxL0F5YnVEdmhubTA1b3FmSjRwWGpHSklvaWYw?=
 =?utf-8?B?cFpkVzhDR1JxcGQ0Z0FwMkFVMFhud2hyNTJWeFVkd2MycUxsbnFicnlsV0t5?=
 =?utf-8?B?TUJ3RGcrSEwwQnFoRElDTXFlUEhJVzR2TStlbThQaXN6bzRhbUZWbTcvd1J5?=
 =?utf-8?Q?NNEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nno2SkMveXl4VDNjOEJRV1poQmNRYnpsNlplTjVacGRRYkRBK0dwZ29LY2hD?=
 =?utf-8?B?KzZQWmxzbkZGL3ZtT2ZtSlBjcTJHdjF6WTU3KzdPN2U5QXczWmhncUV2TVl1?=
 =?utf-8?B?OWRZNUlNMFk0eExCY0Y0a0RSaExpa3cwREtVZFp2VEFWQXZJZkpqRVM3andP?=
 =?utf-8?B?cFZGVldSUE1WMnJhYWJwOUR1SXpXMUpId3JQaVNCeW1CNWFxd3pRclZJSVRl?=
 =?utf-8?B?TjVqMzVYd3pPSXZlVXgxdER5S2RwVmtqZ08rcm8xUmQyQ2NBK0VOUkkrbDk2?=
 =?utf-8?B?WEd6UFNydm85NDF4ZWhtMGF1eXJoUWx1dG41TGM1R29JSjRXOHhYQUd3eTBH?=
 =?utf-8?B?V3VHQUJtdmtRL0E5YTRKbW1RalVUU215aG1yT2hTbC9zOVdWYU1LbERjcXUr?=
 =?utf-8?B?OGhqVjc5QUhMcjIzOVB6VjFmVkxoT0k4U0lHNDJlenRPUkg5NTlzRU1BT2RT?=
 =?utf-8?B?OWhncEwwSGhZNWlVYUZMSU04cHdFcWFxZkQxdHdlbVlkbGVDUmY5cks2YWll?=
 =?utf-8?B?cytYNmowTndhb0xtOUlDYm12dFB0SnBJZitDM2RGRXBMRUl0ai9LTWdzdmp5?=
 =?utf-8?B?QW4zYmJPQjFZTk5XSXljcVRuN2NXbFFqS1NKY0cxK0h4WjNONmRnanlrRERR?=
 =?utf-8?B?aGMzU2tma3ZrMW1IS2hWVkJRd2dxemFMeFRVcHJlUVRWVThQcmlqd1QzK0sx?=
 =?utf-8?B?ZzhvaGRRdTJWVkZ5a3A1NzJYYVRUQnRWM2YxWkp5YUdPRGxJUVdwTmMza2dC?=
 =?utf-8?B?cDh1a2lzd2VBWmp4NnZGME4vNmJkdHdya0JuVXhBcUlVOFZ6NGtYS3lmbGVK?=
 =?utf-8?B?TVQ3VFhPbXRCUWFrdkpody8wZHl3SUFoZmFhTE0vYXpNLzVLWDJFbDJGMDNR?=
 =?utf-8?B?ZUpTZTQraldvV1Z6dVJQYXBUWExUKzJaZ2FDTDlLQStLK2xvNGkrY3JTZXJH?=
 =?utf-8?B?MVBVd2dmemxkdFpteis2QUJiSnhxdzFVYnVyUG1qcUU1Rkcyek54aEo1RVRn?=
 =?utf-8?B?MTFYUThGeXFMcVdpTkNxNVM0UjZCK1BtWmRoRzlWYm9qclNmKzJVSDVteVBa?=
 =?utf-8?B?alZMVGJOTzUzamFucUFTelFpSmJ1Y0M2dXVOejJNNUNpUjJReEJ1bUhzNFVz?=
 =?utf-8?B?UThCKy9YL3d3cFdJMTN1bUFjQU9pbE80cjJQRTkzMXNudFE4YWVCN3lJN29G?=
 =?utf-8?B?V3BiK04xaExOVzdLTkN0b3phMDUrRG9ZTG1KZzBwK1ZldlhsVlpDYVZKa29F?=
 =?utf-8?B?RHp6cUZmY1BXa1UzSVh1cERLOHhMVldyU0E3UHJ4N2JmZHl2V0xjRlk2Mytt?=
 =?utf-8?B?dEs2bEJlTlRMc2xBYjRHRU5ldk5IRUxKRndJR0hHSG0yQkpMVDIxYXBOK1dK?=
 =?utf-8?B?Mm5sNi9nMjdkZDAxeWxNcTYyK3d5dVRmUjJ6UWZXRCtsYjdUUEZ0UE9BTC9M?=
 =?utf-8?B?ZUpFdEtYUlBOSjYvT1B1bFgydlIyODJpdUZIMGg5dWZCRXRGaEtFWjRpZklH?=
 =?utf-8?B?MWo1WUVNcXM1aGp1cERPa2VtcFBEejRLNFdabHg1cytJVXNPaVhESUFtV01P?=
 =?utf-8?B?U3RCSHplUlY5WG1sUzlGT3M1WDhwSjhLZGIyb1YvOTdYQ3dnbGVJa1htcE9E?=
 =?utf-8?B?L2I2b1NxWURWNVFlMi81U2dqbUdsTG4xdEdsOVJTV2JmUGU4QTd5SktNTUdK?=
 =?utf-8?B?NFVaa1cvN1Q2WVBHWms2WW9OZ3J4ZWlDekRRd3g2MWVUZVpsZENrZzFkQnZp?=
 =?utf-8?B?Tm9OVW8zSlRIYWE4blBhbHFMaG9ONkVzanZhMFhtSVRoNlNTdmtHWjBManBL?=
 =?utf-8?B?ZVh2WndkNUlQMTlxdXhyNzNGSGVoTHdYblNMZjZsTnRyZm41SjBOK085Ujl0?=
 =?utf-8?B?Ylo2Wkh5Wjl0VXJMcTBLNlRjUzNzWVZ3Q1JyZlFZMC9vZlpRR3lxN3B1MGNx?=
 =?utf-8?B?VzFXS0tOTHBQcTR0em9LK2JubnBlRzVrTENaMmd3RTZZTkUyQW5iQllGWGdi?=
 =?utf-8?B?WXJ3ZUZieU5EOE5hUUljWk13c3pYMFlTNUdMN1l2aElQekR1UkFpVFRxUEo5?=
 =?utf-8?B?N1k3RC9vdGVZQzJqNVhYVjgrdmVtRWEzeE0rR0owQlBrMFZ3VXozTzd5cGc1?=
 =?utf-8?B?NFhldXVnZ2dnME1jeUthVGlFTjE1bGZhWUdYQzRpL284K1FzNUJGNTgybWEr?=
 =?utf-8?B?NVpZR1NxYkpFSU1sR3lIUS9mdDBnd0FxeDBIYXJib09Vc0diMTlpblZ0QzlT?=
 =?utf-8?B?N0tuY1FCejRtYW1NRFUrUGJXQWdQWWM4RXdSQi8vS2tLeUdxdlNMSU5GRWt5?=
 =?utf-8?B?eHFVMnNsUjJ6UUN1MWlQcmJhQUJ6YWU0dmZ6VGV4emFpWlBLZTZlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55eddac-7a2f-44a5-9834-08de5a1ee268
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:29:43.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtsQ19MESQmgJKHxSsaGGNq5WyLmaf4quYMZL8HgXVLFanXOXtNF0+89JnAGbQyZlJzaQxH6XUPkN8jg+2WH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

On Jan 22, 2026, at 7:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Thu, Jan 22, 2026 at 06:43:31PM -0500, Joel Fernandes wrote:
>> On Thu, Jan 22, 2026 at 01:55:11PM -0800, Paul E. McKenney wrote:
>>> On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
>>>> -    } else if (len > rdp->qlen_last_fqs_check + qhimark) {
>>>> -        /* ... or if many callbacks queued. */
>>>> -        rdp->qlen_last_fqs_check = len;
>>>> -        j = jiffies;
>>>> -        if (j != rdp->nocb_gp_adv_time &&
>>>> -            rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
>>> This places in cur_gp_seq not the grace period for the current callback
>>> (which would be unlikely to have finished), but rather the grace period
>>> for the oldest callback that has not yet been marked as done.  And that
>>> callback started some time ago, and thus might well have finished.
>>> So while this code might not have been executed in your tests, it is
>>> definitely not a logical contradiction.
>>> Or am I missing something subtle here?
>>
>> You're right that it's not a logical contradiction - I was imprecise.
>> rcu_segcblist_nextgp() returns the GP for the oldest pending callback,
>> which could indeed have completed.
>>
>> However, the question becomes: under what scenario do we need to advance
>> here? If that GP completed, rcuog should have already advanced those
>> callbacks. The only way this code path can execute is if rcuog is starved
>> and not running to advance them, right?
>
> That is one way.  The other way is if the RCU grace-period gets delayed
> (perhaps by vCPU preemption) between the time that it updates the
> leaf rcu_node structure's ->gp_seq field and the time that it invokes
> rcu_nocb_gp_cleanup().

I see the window you're describing. In rcu_gp_cleanup(), for each leaf node:

     WRITE_ONCE(rnp->gp_seq, new_gp_seq);   // GP appears complete
     ...
     raw_spin_unlock_irq_rcu_node(rnp);

     /* vCPU preemption  */
     rcu_nocb_gp_cleanup(sq);               // wakes rcuog

So yes, in this window, the call_rcu() CPU could see the updated gp_seq 
and have rcu_seq_done() return true for the now-completed GP.

However, even in this window, advancing callbacks doesn't help:

1. We advance callbacks from WAIT to DONE state
2. But rcuog is still sleeping, waiting for GP kthread to wake it
3. rcuoc is still sleeping, waiting for rcuog to wake it
4. Callbacks sit in DONE state but nobody invokes them

So the critical path is unchanged:
    swake_up_all() -> rcuog -> rcuoc -> invoke.

I guess this is the redundancy argument - the window exists, but
exploiting it provides no meaningful benefit AFAICS.

>
>> But as Frederic pointed out, even if rcuog is starved, advancing here
>> doesn't help - rcuog must still run anyway to wake the callback thread.
>> We're just duplicating work it will do when it finally gets to run.
>
> So maybe we don't want that first patch after all?  ;-)

Do you mean we want the first patch so that it can remove the code that 
we don't want?

>
>> The extensive testing (300K callback floods, hours of rcutorture) showing
>> zero hits confirms this window is practically unreachable. I can update the
>> commit message to remove the "logical contradiction" claim and focus on the
>> redundancy argument instead.
>
> That would definitely be good!

Thanks. I will focus on this argument, then. I will resend with a better 
patch description in the morning.

>
>> Would that address your concern?
>
> Your point about the rcuoc kthread needing to be awakened is a good one.
> I am still concerned about flooding on busy systems, especially if the
> busy component is an underlying hypervisor, but we might need a more
> principled approach for that situation.

Hmm true. There is also the case that any of the kthreads in the way of 
the callback getting preempted by the hypervisor could also be 
problematic, to your point of requiring a more principled approach. I 
guess we did not want the reader side vCPU preemption workarounds either 
for similar reason.

One trick I found irrespective of virtualization, is, rcu_nocb_poll can 
result in grace periods completing faster. I think this could help 
overload situations by retiring callbacks sooner than later. I can 
experiment with this idea in future. Was considering a dynamic trigger 
to enable polling mode in overload. I guess there is one way to find out 
how well this will work, but initial testing does look promising. :-D.

--
Joel Fernandes
