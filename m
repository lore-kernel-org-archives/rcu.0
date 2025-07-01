Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310EE278161;
	Tue,  1 Jul 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376606; cv=fail; b=uW/LZ7lXV2o/SSetoIYYp8ZwKW+pzBvE5vG0xBIdlDbTf7MyrE0t52814e08dMDi/KwZezszSc4P4umgxNgHLBygntRFAK25tV38q57Ulr3nM1LIz8jCe39RdAIw+6SSeM8Y/nxWxWYx4jqu9JMpdDTLk/W5wQAiA8366e//6rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376606; c=relaxed/simple;
	bh=2OiN1DdB/Vx06wU5NgXaC22ibgRwKOChLL0vGzguIQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUTnIRfIcsJaCq6cJnt1duSDgfV0L5g1IN4KC+uyL6FF+Srgclc3M3bp4sFOANN09OcGvM6x+W3lK6v9jqiapGsCLXIvnMDJjuW/DlaLYtF6gMwVILgHs0Hotql+3USnxSyQIiPpA7USpbctnx7pofiafxVUwibkblAKn3/fJF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPYSIo2e; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPYSIo2e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS26GduF80JE1P2/g80V99m1p6/oK8dQ5l8bS77eu1FQjPuajjFxALfrLP+Dr3y19qNZLOwsFDAUJG5WXVRT4BYlwE6IbetKxGWITwrH47HKX4hpnCo+b2WQnM7/cnN/5/MoJfaI0lTs6MKt1CvjzrmAJezdzYtCeLTNE6AP/HarAnhEi2G5kHxkSwGUwH6EJQrJnQKtXiAzhRdW6aoUur71zfOGb4K3TIOFzG6Kv4JyQTKmOOOzXffHQtFIzwPujFyQD4f6y1e3QvSJcHd2goZYNJcmTRQz2hKsWyFYsRYIekVnLyf/TUa6566vejQRd5xQ9sFeyTCypoN3cQybNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xAUuCkQ8xu2FM9fNPwrnJGD4Y9JjUk0QJBdYSV5w8g=;
 b=SidHiT22jZPY+wpZGIBaPpFJesr+W5g9X6ciisK58XWdPdQR9+NFrO1p7oXqLOawX/kTnZSJIijjH8CI7gMTKrSjUWJwOSQiBy4HuTYMvy/ZK4gYy4C4i8DOAns+wTNoZJButeMKfhSigjblNjFeryQq254eyCQlMFeC7lTVRJvSb+sLI7ozB1Za4FU1V6xS0g7xPAs4nEme5M/SKn6ZIiaCWmXmWloIMGPuWzBcPgB9ysF3HiPNd06iwxBmZ2OMRvbRyMbVi1/QDJAbCytzgC8MVOW8GnqsVOmiA5SsBHI2yT5kimLfcuofj9BlCRx8lvcyks2OkVp3ejjQmEQvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xAUuCkQ8xu2FM9fNPwrnJGD4Y9JjUk0QJBdYSV5w8g=;
 b=FPYSIo2eacVawcqtJFGTinhkdfcuQqVpi4ZqeWGVRHb44dnqy93oZiGjxG1P39sIghgWJYuXLOCs2MHDPhI9pyPZC+BAhoXFcV2VT5sckAkdiZV+JzWwegWAZNrq7yvPhPV+5cES3+Nv9nIoGAlkpte9vLtE0dOxnCXy4raNtjPuJ/+5dYHdHdxUjFMBrYrTSdekBEIG0qvbU8bqKnHB07P/Q99fOy9ju1gLj6rz17hy6+4H4tm2G6WOb78Q7wV851IWMR3OweUj58PLLw7AiB3f99xZQIw9+eg+vtbL0V9vKQTRUT8umsHeranqVKsB6GFhLW7vq3OTfeBxh2Hnug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 1 Jul
 2025 13:30:00 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:30:00 +0000
Message-ID: <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
Date: Tue, 1 Jul 2025 09:29:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Qi Xi <xiqi2@huawei.com>, paulmck@kernel.org,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
 Frederic Weisbecker <frederic@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org, urezki@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
 Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3880366f-a491-4b07-036d-08ddb8a360d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzVxYTRpb3NqSGxCNEZSc0ZHZEV6SWRKQUl3NjJwT3FVKzN3eWc4R2gxOFhr?=
 =?utf-8?B?cUNsYmlEMHN1R25BSE1zQkJyd0dtdGtmbWZ6Y0E1Q2xIcG9oMU1lS3B0Rk1Q?=
 =?utf-8?B?cC9YY1BXWWsrYkltcE9ROVBzRjVqK2RGUW0wek9IUGsrYnEvRG4vcEhyY040?=
 =?utf-8?B?c29rdmZhYTgyQ2hlVWJkdHVoV2dIV1lYa3dhaHoyYnNtTjc5V2lvcG5ObFlt?=
 =?utf-8?B?UlJuck1xWDN6Umh4cFFWNVI1QnJSc2RCWjVRWkZaa2JENVZEbVJzcjFkUk5S?=
 =?utf-8?B?N3hTNFlUbzdNeG9BazA1NURlT0NNVCt4anlVYXBVejcyeTM2dG9pN2kzVnEr?=
 =?utf-8?B?MnBqTG10T3lJWUVibzQvR3V1aGlkcDl1R2FzRGZWd0ZVNFNuYlFSR01DaFZ5?=
 =?utf-8?B?MHZ1bWVNRm4ycG9oSTk2ZGtzdUFFQmI1SXZDd05admJzKzBiQzNhSkpaelpq?=
 =?utf-8?B?NHVMQ2IraWFpK3U0RDgyRzJUVGZvWjBoV1RxQmZvWWNad2ZIcit3d3ppNzk4?=
 =?utf-8?B?NWxIYkZiajhnVCsrUlV2WmdLVVBXazl4SDJUeWNHd3Y0WFlVWHNaNFM5TDNH?=
 =?utf-8?B?a3hQckF6bTAzS3FsWDhxTTUxak93bE0wV09zdTRKVGdkb2owMFBob3pnTXhW?=
 =?utf-8?B?aGI3dHVIaVR1SThNRHlhekRlWjI1Nm91MTBVbGo3a2tyeWd0QU5idzdNTHN2?=
 =?utf-8?B?djQ2Q0U2ak9mSGRzcTVQU1B5ejlVOEQ5bGNyaEhEdVZUOWtZOVNpTXJtT01w?=
 =?utf-8?B?dzYrWmVsVEJZZUZUWXFPSkNvQW5pM1F3QTVlclVPYUo1eUx5N21rZTlqRm5C?=
 =?utf-8?B?RW51VW5KRUFEZmQ0Sks4cU4wYkE3cmNpWWhkUVBkRVFlaWpEcXZpYlkyU0Rs?=
 =?utf-8?B?NEkzU01OYWlEQU5UbFA0RGV6U0EzS2pmSytURzFJME9iL0NoMTNJbWpRVndK?=
 =?utf-8?B?cjlLa3dwUEt1bU45RUdQb01ycjRVOWF0V0o2N3JCbVkzZmZuc0d5a3JMZGdp?=
 =?utf-8?B?Mm0veGlqSnNYbHR0ZXpKN3k4a0VSYTJxV1NQdHhrcU80ZzhOREhyQzYxMCtZ?=
 =?utf-8?B?d2t2b2NsbWF5NDRrU1NkR01lQVE4cjhPVk51eGg3LzVmRkRJSkZ4d3dDREpp?=
 =?utf-8?B?Sjc3TkdlcElrT2tGK1pnTDZ4elg4c1hLUzNrY2psK1dzbnZIYVNLemNYU3gv?=
 =?utf-8?B?cnlNemR5cXN2STQ2YUJIM3c3SFMzWmNEOXJRcDRWY3pIcEtEN3V5MUM0a2Zm?=
 =?utf-8?B?VHNDamNjajhLa201WUdQbGVJWlB5L0lxcGF4c3dwYzlvSFRldStVTk5mQnJr?=
 =?utf-8?B?K1lJVnQrdzF5NHhidytMN3lreU8rRVpwOEtWa2VYZzV5MTRQYktKOHF0LzB3?=
 =?utf-8?B?bnNnUXBJNGlkMUpWbkNnaFJiT3BrT0tXQ0ZWd0puSnNlWGlDekg4M3J0aTl6?=
 =?utf-8?B?RTQxNmxqQjBzRTI1VzNsUmk1NlIwdUZLOUEyYTM1ai9FNTFyY05lc3NjYTVi?=
 =?utf-8?B?ekVmNVRySC9qU3l2eTJEdE56WDNjbm55aCtLMGFmSTNkTno5SnNOVXQweVNS?=
 =?utf-8?B?eWNYbmtDcjh5U21BbFlEeWRhdlRKeFhWMEZ2WDZSckNRci9vU0FSS2U0WXdl?=
 =?utf-8?B?aU9kK25QeGRiZW5mc2ZzMXd2cDJoejBkbEtTZDZZU0ZkczJtVmc3MS9RSW9K?=
 =?utf-8?B?ZUFxbnBxSm5EWTJBcldqeFNVQmg5TFRJTGZ4djZ5YWhPblBONjRLTlJwUnZQ?=
 =?utf-8?B?R0ZyeWNZQURySXkweitkS1hPQnpaR2ZRV08vb2xyTWk1Smc5Si9qU3BRN3pR?=
 =?utf-8?B?a0hER0xwL084WXZURmtvZkFFL1ByQlZsdWE0bi9VREdMTkJaN2h4WUkwcW5v?=
 =?utf-8?B?bndoV0dCcWRDRHMyVW10dDIvd2FzMElWc05NMnFId2JnWldYckRHSERsTDEw?=
 =?utf-8?Q?o7JggP+8ss4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWVTTGpaWG9rV2Zzd3ZtUWk2UTZ5THNpRnc1NTI5OWMzWDZWTE1BMGZpb0RF?=
 =?utf-8?B?ZnNFaytNQU8reFlTakN1OU1sbTEyOVZyNG5zalZGRTR4UzJqZWNFK1JQeFN3?=
 =?utf-8?B?WjFDMDRWeG5Ga0UyR1FaUjFBc1daVjZIeVBoWktIRVhSbWZuaWswM1R2Mm1i?=
 =?utf-8?B?NmdIUGZWbE5GazllUk9Hd3l1ZnBHSHk2MkdudFdhc0J1ODRUdjc2VXFURisx?=
 =?utf-8?B?dFFGSHNlbFdXY2xTcDI3d1NMcjdNOGxLWFFmUG1uNTZKYnpmcFVDRFIycnJo?=
 =?utf-8?B?dGZDWW9mYUN4bUlBTUNlTDM5M1E1T2t0Zy9ydDRPbXhDV05EWTN6cDdYNStI?=
 =?utf-8?B?T3RaMWJiYXBOODJ2OS9zVjM2VU1sWkpBMVo3NjNZRGQ3Z252eVZObW1COG1k?=
 =?utf-8?B?UlpwUlJoSjNzYnVEZ1ZTazNZdHpmQ3V4UE5tTFpJNW92eE5LY3pPMzM2UTJy?=
 =?utf-8?B?M01kRXNSenVpTmJqR2NhRy9IVkl2R21NWTl3NFFTeGxOUTBRQ2dBVGR5WUxx?=
 =?utf-8?B?WkFEbmtGTGpaeTR4OUlCaHhjRUxSbWZSdmducnphWURlc3prMmhvRkdoMSs0?=
 =?utf-8?B?b3d2ZDJSM3VyS1hmQ2hRblQ4dFdCUUkvajk3UE5iZ2pzT2ZPYmZycGlwWXYr?=
 =?utf-8?B?UzR5OHcyUnJZMUZPSUZBcTlRQWxRM2F3US9ncmwyYmRWWktiNkRiS1RBejE1?=
 =?utf-8?B?cmpUTEE5OG1PeU5CWTdJL211b0YvSG9zUVJrM0VOOFE1ZGZDOHE4aXBGakN1?=
 =?utf-8?B?RWhrL1FnRkMzeDJHRlVVdmk5SDJQcmQ5VHZOMzlwY29GZEFxOGNZTVFDUlBv?=
 =?utf-8?B?VldTQ3ZpUml3L2l1OElHS3BVVFBCelhDSjhoazR1allEa1I5aDBneVFseUlT?=
 =?utf-8?B?akJxSW1DR2RpR0hUOHpQRWlzbGZlZ0JmZ1ZtNGU1ZDJNUVB4b3haUURGTm1R?=
 =?utf-8?B?TWZEb2R2dUhNR2IxRTN0QVd5NG1EMzBRTHkyVTJpK2JmSkRkbnJWV1FCajZR?=
 =?utf-8?B?Vkx3cDVDRXFRckVVYkRVUllRR3NlbGd3OEQ5T2RjRXIyV0VsNDJ4VjZ4dFQx?=
 =?utf-8?B?Z004SFpuT3haNlhsLy81ZThkRXM5UE15dnBQeTBqbitPQXVZaTVmSlFsa0N1?=
 =?utf-8?B?Rks1L0ZxbThKZjVZcjNjNnoyOW9EcVVDMTUrQ3JWSklCamdVaXNVRitSYmhU?=
 =?utf-8?B?RmJsV0FVWVJ3LzJ2cmRydFNNbXQ1MHFJckM1R0RaWW9CQ0o5T1RpYU9HSTRl?=
 =?utf-8?B?OVZHOFRSb1lKa1pUaGo4WFdqWUxKUC9PdEdpSTcwS0JjaWd6TGdoUSttRXVx?=
 =?utf-8?B?U0RiUW9oYm1FQnVHaVVTekRhREtweGc3b0xiR1FYVkgybmFpRXhrZVl5Mkcr?=
 =?utf-8?B?cDRpaVFCcnBRRUY2QnR6L1J4TEN6NXAvZ3ROS0Q4Tk9JV0pUekpLamZwM0ZP?=
 =?utf-8?B?Z3czbnV5Vjh0Zi82bDVpME5jR0VrS1pvM1hUYmFLVnNMNG9mOTY2T0JrVXB1?=
 =?utf-8?B?OHdzUllRcm1TYzJmMnRJSk03WVFHa3Zvc1kzZGw5QldBNkR4bjlIVERYeHM2?=
 =?utf-8?B?alU0cVF4TEZPaDIwTjVERGNsdEdvL1VCMERUUS9FR2VBQ3BTbEZjcXdOKzRJ?=
 =?utf-8?B?K3JSVzRGa2FhNE9GU3o4Q3YyVmFlS0o1SGZjUmlDWE9CdW9QUEtNRnhpMWI3?=
 =?utf-8?B?VXZUa2dub0pSY2xnN2UwRk1mZzJQNnc1UmtTQ1pteEJtSVpJUlRwRmYrRHdL?=
 =?utf-8?B?ZnREd0s1aXlMQnhkVXRiWjBnSW5ObHVUTTFsbEFIdi9QejAvVnlHNjhCaDl2?=
 =?utf-8?B?WnFRbHY4eGlMOUlhNU5ZVmxsMUpyai9jVUZaemZaL2pZTW5hSjFTc1VDUlA2?=
 =?utf-8?B?RTBWY0tKUkREbEEvTjRLdFBUSk1EQk5JZmNxd1lTSmVlOUF4NERQa1BsRi9B?=
 =?utf-8?B?U09xT3V3RmpucVVDTDJRa05zSTVGb1YxU01iM0cva1lxY2MwcGpoMkFWN080?=
 =?utf-8?B?MVExbGNtamR1QjFzNWU0R3BLQXU2NFRqblNHcmdaT3k4TG1peFpTNUEzK0dt?=
 =?utf-8?B?am14ZEZ3N0c3eEcwYmErc1NFaWs3cUVqSDZIc3c4KzgzalJLYnUweXVHdnFY?=
 =?utf-8?Q?1DtIwdIJu8izwkmp1FO2mqsEz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3880366f-a491-4b07-036d-08ddb8a360d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:30:00.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq9lDNR4m9DRedpXimCCEIfs90YXcUAt636ODiJeLeUVzTm6VsyLTYqQFmg86gT8HSoVxJeU8cidTn12GMsy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092



On 7/1/2025 5:20 AM, Qi Xi wrote:
> Hello everyone,
> 
> Friendly ping about this problem :)
> 

Ah, thanks for checking. The fix is slated for kernel 6.17.

If you want to test it, could you apply it in advance from the RCU tree?

You need these 2:

https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=6758c93749f8bf09b9282f100c5dd0a5c501f91c

https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=3cd298bf3bb69e3bca6abfe97e1b44ffa37f3dee

Thanks.
