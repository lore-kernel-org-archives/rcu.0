Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00E2777F3;
	Mon, 12 Jan 2026 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256687; cv=fail; b=tecW/vq7fcNW1/M5VO1KVohCuyfcWmxaIECJChsZzqzoRP3JVIFz1ExHmT2sMsxTo+pLg7ivHX3NBILd6Me9Xh0ziFnwxPomTftL5pfKqO9BlOSGy79a7FX4gcZxJwf4bbBHyK3looEs4bU59QGSsnxug6LBroIQ+GrENfFsAy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256687; c=relaxed/simple;
	bh=lWKQYAM1aBFKeBi2Bfy8t7p97MG7vC+QBe9k3PEbmRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TULcVyKHPweL9i86AJFsucqsC6+Bq/8SMyq4cVEYLQrrBOpFskqzTtHQX8uEGIUPxS+GxaYAtLIUnw702k0DTivtguzE0IoZDaJiCSJaDMaGpPftS5eB1Ac/zhO/8DBt3BQRhD3Q3SH33EWOPgzpSsJi+M3a61X+ej4JqTaciDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oU63nhc/; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oU63nhc/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5G/Ozn55UgdxsThaynvSLTjmCe0EsYIs7SBCV0NdeAzoKJ+qgFBtezofetA381M+71n7zNjoPWwRgRHsbPzLLHuPnGK5Lfnyyxc5IPFeLsHKGXPkonZ3Gy9Lxh3TpJN+r1MJvw1rjhgoilBxXXzXBfJFqFszXcmTMIDX6VWsFB/TbbrPlVBZxJU/IW0idS/1N5uKgOcidX6S7CaOACOKj0WOxfX6jAsrinwvnBnwHa3P6RI/FDTCJsr53cejMNECIjGIwxKQVRjDyrZvnHj9+TP2rc1prFGC3gY6ulzGCSk+23ASQRJnQ/Hnaf67ozNUedPhrCztlStRSf1aiJNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YQusm3Vy0ztvyO1bNZNZCm2KOtwOA2PFuPi+Iq1DgA=;
 b=e2nBGNBY8cNkW0nYCnnujdbMmtGUtYULNIBHPBY2TTQmiQM4z3hg3X7cjRcyVZYpK6CDl/ntmH3AWI4f6F2N4ELJqeC1OixxttK/2VzpNHMXVQIm6KBjFQPNnAOILDx+vbU9V1h/S1hXr5cmEyjIisyg7IJCQ548Ure7WLHsCjyU2iL/hAKVptx0Izv+4MQ6EqhxnUPxr4mCWSIfysh+SZnVuaQn5xsH1K8naF2P2ecgKD8EHR9aYoaZ0uEd+zD+YY7JuLgd7xZfDLHba/nlRiA1SlBchPjPy2doQHNf6uwCbkhN3yUobM7+48pAu62U398zwOMUkbcX2CWlmGMbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YQusm3Vy0ztvyO1bNZNZCm2KOtwOA2PFuPi+Iq1DgA=;
 b=oU63nhc/YATYMFwfKLYfGNd4u+UN6XSDqNzNINeRhprbOrlZkUr8OyqW3J3FC95biwfJGE0GUyTPbH/G/mk5QGxyafbZCboe+K1WGa5B94LNNfej5iO1lGphBFe3T9gXb99UU5DZg+o9LnGA5y5i/pVOXWY/bDBwjoc6b1qQ+NyZk+bWZqSHLOvpYSMzbxBewoaCKvH/rc1W3CgTWPRffXQFxxB/QljPkmrFkwGY31gPOZ8r5WrALY/oqCa3VIQNIdRQD19TQ+EgmEk84mmYk4SCwNxA3gZOQJ8gJ9FBIfvQrlKmq6jEppGhNWj0HKUWL8LP+SIFpnuVhSEOJma1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 22:24:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 22:24:43 +0000
Message-ID: <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
Date: Mon, 12 Jan 2026 17:24:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: paulmck@kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frederic@kernel.org" <frederic@kernel.org>,
 "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
 "josh@joshtriplett.org" <josh@joshtriplett.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "srikar@linux.ibm.com" <srikar@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d933ef0-fcf7-4729-0730-08de52296258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REEycEdOK0lGdnI3bzBCZ05nNkJwbEw2ZTRxck15cUlVOEVyRHJGU0dtUjIw?=
 =?utf-8?B?SHRzT3VSdWxOQzJGN2loZG5GQVYwWmZBL2NtWVhxc1czV3VSYTFQek5YZkF5?=
 =?utf-8?B?L1BDbEJRUU8xRjc5V3VrZ0pWdmYwL3dHT2JqM0lkbjJncm9KVnhaSWF1UkMw?=
 =?utf-8?B?TVNKM0o1U2ZNOGExRFpOOVZqWHEraUNwZlM5QkpLNEl0VU5QRG4yQzlhNkJi?=
 =?utf-8?B?VkkxLzF4M3FLYUVRaGxlUlIrSi85NnJWamZMRVZsWlpjY29aLzRZMzVnZW1x?=
 =?utf-8?B?YzhKVEE4YVdBNGhTcFlKVGczMDlua2RhSjlhM3VlQVRRcFhjYkpNVTVFajZJ?=
 =?utf-8?B?dXMwR1dPNkVjM2NwYVdnOE5aQVdqMFVrVUgwSXkxWnd3VWZtRmdJdHBOUllt?=
 =?utf-8?B?L3M5N3AxdWJDcmw1Zy9XQVNpSWFQaDlCdnRRb1NMYmlSOFRUd3h1VDVRSndF?=
 =?utf-8?B?T1IwOSswNDVKelRPc2hadC9XR0dQYUJSM2FUZG8vUDlidHdrbUU4YlhFM2o2?=
 =?utf-8?B?OWEyazB2MUdjMWdUVFQwUmdLMFFTRU93cHFLSERDM1YyMnBiTERTTGdKdTFn?=
 =?utf-8?B?elg4dm1abkVUZE1wOFRVbmNiOTFHRlo4Q1luVXFFVmIzTTVIM3pLUGlIak9R?=
 =?utf-8?B?NVQvbysrWXNZdVZGM0NDaFJ5SVVvS09ESHBrS2txQUc0elFaM3BIZUNrbjND?=
 =?utf-8?B?alpiTFVaT2RGRHRTSXF4WXpvYUN1K01raGVCRm40ZUxZMCtjUGdka1RIMmtR?=
 =?utf-8?B?RkhjQkdUQzkwRHMzMW1RSnN1V0tVYllTWGh1UnM2eFJ0MkluN3o1YWNHekFS?=
 =?utf-8?B?SWpmeXRwQSt2QWNhKzFPeUVZOU5HVnJCQ1VyTUlUL1dRQkhVWE81c0c5U2k4?=
 =?utf-8?B?OXc0YTVoeGlhL1NwUWljNThBQzVtNDZhY1QvWWpnWnNpU0J4SStWSFU5Y0VV?=
 =?utf-8?B?RmFScG1HN1pTRWxSUy9XVWpJZ29JRzgreXFVMS9GekNyZkJCaXJTb3RMakVO?=
 =?utf-8?B?SEFlOVV1NEFKaE5Ec0VNQ3o3M29BbFJMYUlscTVBVlJGRnhia09xNXpUSmly?=
 =?utf-8?B?Z3RZSVNhdzI5M0sxSzhXV25JRWlvNjBQMFZRWXJSaWZLenVjdldoK29HM0pj?=
 =?utf-8?B?b1pSVW9oaWplR21PVU9uV1NCWnJpYkk0bTBZa29HUTdXelBkNFIvTlJ2ZkVx?=
 =?utf-8?B?VW5WT0JBSFJodGI2Vk9yTjZydHJqK0hKQkJWaHdFS0drdkJubVZ6eEhyc1lp?=
 =?utf-8?B?bkpqUGtRMEJ6ZjJ4NkJrcS95RU1mVzZxQmhKSUtTNFpBRFhRQ3NvcGU3bnor?=
 =?utf-8?B?WUpia0hZeDYyR3k4LzRjeGZkd0NtSkpXOTZlY0wrZDh3L0R4TDAvQkUzd2J0?=
 =?utf-8?B?bHlDY1BGUkkyQ0hOaFFJdHFzSWczdXRUTHZXRzk5NEkxQ2FrVFpnVm1ZcDdu?=
 =?utf-8?B?dTFYL1QvTERMV0dmdWRMMXQ4RDhDU1h3M1RUOWgxWER2NkhkT3E4RjJGZEdj?=
 =?utf-8?B?MzUrREFOcnp4WUZFS0NRcFRLRVFVSk1RWm1KdEcxRWFzaktEVW9udi9Wa2tH?=
 =?utf-8?B?Z3Zid1F5djlHcy9seUZzK2pEUUNwUDVkTjRLVGQvTDFtc0tEVWtCb25VVmJk?=
 =?utf-8?B?MkZkWktoOWV5b0hxQ2VQYTVDTFF1TFFhMlhndlVKYWNxVXZpWkU3cmluNUhz?=
 =?utf-8?B?ME9Id2QvREhucDViQzhYVWVTNUw1TjcyWks1WUJpSE03MUFwQTVMY1pJWHMr?=
 =?utf-8?B?NHhSYVIrZVY5d2kwaVoyZFhkZ1BvQk5DME5PSFo3V3R5NEQxQVF1cGhTaU5i?=
 =?utf-8?B?clVKYjUwOExPMGpIN2t0dTRWYWR5ZWQwamF4UkIyUGFQZTZuZ3hCeDZTb2hG?=
 =?utf-8?B?T01kK05JMkc2K2N4dU1jUk4wVWMzRHJtTFhTdldiZE94a0FuMHdBL2xLbmdi?=
 =?utf-8?B?bkRZYU8zUFI2cjNIS21nb3F5bVo2cnk1ZjRFQ3pwZnU0RkJ4ZWJXcDZFNDZa?=
 =?utf-8?B?R3RLUjVhZkJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGxKYTYwalROdHlxM2dCQzNOTDZzQXIwNDc1SkhKVk5kTkpDRUxrOXplZnlG?=
 =?utf-8?B?M29aeEpOZHZncFdjdjhVT29Vb3ZobzBlaUFINGFKWHRBVUNXdTFBbEhuYWRF?=
 =?utf-8?B?RElrOUxkOHJmd25XM01UM1I0R1NXUlhSUWZFUW9SbXNoc1BKek9qdzk1V28v?=
 =?utf-8?B?a1RpaFNzN1pvOTR0ZEJHdXkrQjNaWHJyVEV1cGZpTzZyZXhmdW9Jb1ZFKzI1?=
 =?utf-8?B?Q2ZiTVdIeGhMaTVKWVB2eXUrOUl2ZVRubTdEUk0vYVNLWnVFNmxNeXQvUFAz?=
 =?utf-8?B?THdXamg0L2Y3VGhmYTBzR1lvVmhQek9pMytBdDV2cGpmcXJObklWdGtXNW5q?=
 =?utf-8?B?WVU2aUkwd0s4YitacVNjUkhvN29laDA4bjlrL0dzNEhVZHp1am4wYlA4VUtD?=
 =?utf-8?B?WFp1dlo4U2ZuMHNDQWxNeTkvaWFwMWszeVRlbnFRL0k5Y2VvaUlDdktzZE1S?=
 =?utf-8?B?ZUxFK0lTbmhnek5sS0MxVzIySTlGTFFlc0E0bGMrWWhLK3hLQmpmbmVWd0Rs?=
 =?utf-8?B?ZjhRN1FXQ20rNDZUZVBEbTdWWWg5cVcwakNFNS9PZExXblVjOXlqVGpQTXNH?=
 =?utf-8?B?bWJscThFQTNRRFdta3JDZVo4YXZxQ0NFQmN0NDZ0ZWg4RHkvVXV3QmdyRGg2?=
 =?utf-8?B?dWhTbmhsN0dJUXZQekViLzFERGNWejJCSVh3Z2lUUjdMOGdTQmMrWHQ0MzNu?=
 =?utf-8?B?WVdxY3dqdElMQWlmcFVlVm9FRFlPbzBTZkQrczZQaTRGL2ZYNWtGMzIweTRR?=
 =?utf-8?B?RTExOW9IT1pPc2FoQmJNV3g1WDJtWFBuTUMzOVlpN1Y3eVJYdjNJb0d3VFo0?=
 =?utf-8?B?dUhzMXBRK0hxb2ZjaG1XMVN4NXBOQWxKdVpBWDFnVnJPN2dXazkzY0daZzFl?=
 =?utf-8?B?eERDMWg2Y1dJTTdDYlJGR20xcXJRc2NvWXhnMkpEL3NINjkzMWZwNmpJQzRP?=
 =?utf-8?B?TU9VSEhoc3lldUp1aXo1UlBqVnJlZWFBZThWWHBqWmZadEMxd1hwUnN6dWh6?=
 =?utf-8?B?L3dQbElSY3RlbEZNTEFzaHBNbUFObWxveUdGdlhqVTFpQTlrSS9yRktJTzFW?=
 =?utf-8?B?d2xWSmZva29uYlB0NXd2RmNrck5aRk1JajJHMHpyUi9neEpBMjhpUmxZS3J3?=
 =?utf-8?B?dU1yTjVKSXNtd2VaRDgxbXNLUkZXOUQ5Qm44TmhWaGkzYlFjd2I2ME5BWExr?=
 =?utf-8?B?K0FOT2xnM3QxTkNXWCs5OUxpa1hrNTZwcG42bnYxanZUcWV0TVRIK2dBMlA1?=
 =?utf-8?B?SENKL1pRVG01T29HZGFHRHRPd0IxMkk2TER4SDFiM1did3ZLbGM5eHVWeHRt?=
 =?utf-8?B?dlk4T2greGlObXNsei9KbU9nZEF1V01oZXA2c3NjalBQS0huRXRjTEJJblla?=
 =?utf-8?B?c1UxTTgrMFoyYWlxNlhJaXVuaE1FNFNobm9hUGhDVWFDTFJkbnlicmsrb2pi?=
 =?utf-8?B?RTJ3Z01MZm9PdXhFWGNtS1dVK2Z5NXZkTjNsaUZJWTFqaGNXa3ZDNVZ5dFR4?=
 =?utf-8?B?Z2pYQnk1czdFTWI3ZmZhQ3gwOHZEZnNKUFB1WGFkWjN0azdJdjRlUkRCWEMy?=
 =?utf-8?B?TmtxQWk3bjg1M0ZUSmpwYWo0Q1VFNlhYZDltTE04elRwc1JOQW9Tb1pOaGxu?=
 =?utf-8?B?RDBIaldPVWNEY0Nha3RmNEVtWXl0QmcwSGZRcVNqZUtLT2tMb05TRitoaUpW?=
 =?utf-8?B?Wmg2TkJDRnlVOWZUVldwWk42YVJNcGx1N2w4UXNPbHBuMDhhZDFLMlJMTis3?=
 =?utf-8?B?bmt4OTRCMjQwZjZheE5zOFZBR3lBaUZGbEtJS3E5ekwwaXhTVmVTek9Wa3NF?=
 =?utf-8?B?Skh1dnk1ci9RUEVaRGpuQUlKeFhtUThiSXdVcHhJREZHS0VDMFRlcGg4RjFw?=
 =?utf-8?B?M1FCVk1Td3hEV1BUNFBwcldyR0kxLzZJZTRQcHJLYlFPUSsxZ2Yxb1FRd2xC?=
 =?utf-8?B?azV1Y2lnZ3hOQWliaXg4a3I2QTNySUhVclNIZlhzV2Q0S2lyZDlraURSank5?=
 =?utf-8?B?b2hZZHhRYnUvYWc4RXliaEgrK1FQa05kWmFvT1NaUnRXdW1Fc0N2M2NES2pC?=
 =?utf-8?B?eS9EWHJzaEdJcnJreDVPMjE0RGRyMExZSTRRU1kzOUR6OVowRUJsdk9Eb3lt?=
 =?utf-8?B?dmlNTFQ0Z0ZyUTJPcFcwV2VXeGpDN2x1QWJ4ZHpUeGY5dzJHVXI4UVVZSnJY?=
 =?utf-8?B?VDBPVE03cElEMExySTNGek4xRjhoVjBlbTREeXd2Z2J6Z2EwNUJNMVJ6UU9W?=
 =?utf-8?B?c0tTZ3NobHhCa0RnN1ZNWHp3VmE3SjdTNlMwbXpMVmQraHM4bFhyVXVwdENZ?=
 =?utf-8?B?WXZ0aFc5c1dyVW85eWQySUJvd29VVENJSDJrbnJLeEVjVUdmQ1MrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d933ef0-fcf7-4729-0730-08de52296258
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 22:24:43.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5brjKfzMInQbAhz+KT/ia2j47hgQAujWjLnGrrxM1leUR9W++jbOPispLQbjmCl7rkxAP2JKa56wQ5QL8+I4Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972



On 1/12/2026 11:48 AM, Paul E. McKenney wrote:
> On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
>>
>>
>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>
>>> ﻿Hello, Shrikanth!
>>>
>>>>
>>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
>>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
>>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
>>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
>>>>>> systems, this process takes significant time, increasing as the number
>>>>>> of CPUs grows, leading to substantial delays on high-core-count
>>>>>> machines. Analysis [1] reveals that the majority of this time is spent
>>>>>> waiting for synchronize_rcu().
>>>>>>
>>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
>>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
>>>>>> it should complete as quickly as possible.
>>>>>>
>>>>>> Performance data on a PPC64 system with 400 CPUs:
>>>>>>
>>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
>>>>>> Before: real 1m14.792s
>>>>>> After:  real 0m03.205s  # ~23x improvement
>>>>>>
>>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
>>>>>> Before: real 2m27.695s
>>>>>> After:  real 0m02.510s  # ~58x improvement
>>>>>>
>>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
>>>>>>
>>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
>>>>> your "expedited switch" improvement.
>>>>>
>>>>
>>>> Hi Uladzislau.
>>>>
>>>> Had a discussion on this at LPC, having in kernel solution is likely
>>>> better than having it in userspace.
>>>>
>>>> - Having it in kernel would make it work across all archs. Why should
>>>>  any user wait when one initiates the hotplug.
>>>>
>>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
>>>>  though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
>>>>  We will have to repeat the same in each tool.
>>>>
>>>> - There is already /sys/kernel/rcu_expedited which is better if at all
>>>>  we need to fallback to userspace.
>>>>
>>> Sounds good to me. I agree it is better to bypass parameters.
>>
>> Another way to make it in-kernel would be to make the RCU normal wake
>> from GP optimization enabled for > 16 CPUs by default.>>
>> I was considering this, but I did not bring it up because I did not
>> know that there are large systems that might benefit from it until now.>
> This would require increasing the scalability of this optimization,
> right?  Or am I thinking of the wrong optimization?  ;-)
> 
Yes I think you are considering the correct one, the concern you have is
regarding large number of wake ups initiated from the GP thread, correct?

I was suggesting on the thread, a more dynamic approach where using
synchronize_rcu_normal() until it gets overloaded with requests. One approach
might be to measure the length of the rcu_state.srs_next to detect an overload
condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
lightly loaded conditions, default to synchronize_rcu_normal() without checking
for the 16 CPU count.

Thoughts?

thanks,

 - Joel



