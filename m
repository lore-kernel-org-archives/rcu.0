Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE6340A43;
	Sun, 11 Jan 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133001; cv=fail; b=NkCnRoE7hvb/2U18ZDPWn0Sou+PVkdVVe8s/LVmNbDdfolq/xUcak7Ws7bHw/5OA/z6i05SPeRCeoY9zf5yyB8XZvW9llDtc72zbd+x0qeU2TQ6KnDhYYSBU2ldKrgo4dms0nVemIOVENYWDBA5cXBn/ooByplIylJKJliF5xY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133001; c=relaxed/simple;
	bh=hMZ7i3xoqIDeceeUo4hDBdLKB4Ipwt3OrASoz1tumiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwGmHSs6YmG7CZhd6Nb1TkJOxtCg2OCoXsIefCdrh20y3xENzCgiJmn9wy5vjXbH49ybrwsnjIiEdQSR6tdrCfdsa7W8O864PPAgwJBe1G79GtSM3LcreA9Vhc0Q0ATNV8feaKEQooNCjZS5F1mcPuIreB4RyvwJIv1jjpw9TDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GueSwZtA; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GueSwZtA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIF05vw706sLw13UzxZhzHt4eHZ+osKcPMZzCDiGkzAN8Ih5t4oQCEa1nOkCNgffK17C/Za1etVPWUlzAEsiOKoEuYnhpJqFI+OLNNsa87b4jofP7FUrQzH/274hNeaoH3GkePzJ1+JayYC8Tni1npa4VhqMP0mh0Tzcur1tzuzwlcjlzZeV0mT800P6MDDnrwrz8TL1UfyKi8h/snD8u4nNqc9CvOAGbvgyHQy5i27x9zVCfPHYnMDsafVTpTCJg9vXiIKGdmYWiQQ5vYDoGPMVXN6gON4ogwVQ33rbGb9n6LUO4rKL8xMbdxSNS5+ru3/tSgko9OK4QIDJ6Su+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMZ7i3xoqIDeceeUo4hDBdLKB4Ipwt3OrASoz1tumiI=;
 b=CezzjMrB+q6ciUFIQQFDTLHKrMLspNBHojkm8eY0nok8avRVHuVwqXoLynZKKrQ0GiiyoXih1Dk31nzjAP5eF4U/S2G+JY/E2azEIzem1fMSUszl0yPVhA/RXUWV33NbQXEJX5wwXdQmonUQBw9OscjPQoa87lFzijbUD/1EUdY+X7PAl5kC0lM7+/lfxLF1a5OJj85R4t/JY4n/tN6bPKEbE9RQS83nAcbJ5Cm589VQpnXWQLw5e2XRhJui5+AZWMkj5xjsBElox6LKL7Z9GETB1vCTsg9n3o0fN8IDG7xIOx6et9p00uG0ExFPt6vJApHIotIDbX9uDPDtRQqq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMZ7i3xoqIDeceeUo4hDBdLKB4Ipwt3OrASoz1tumiI=;
 b=GueSwZtAOicEiHWJazAhslqWC0g3iFLnY5VgozPt9Sj6y4D7bIoL9AKZ3425AYEEYBVMo3E7U0Xy+0SzvSbD6eGbeqHoT8bJIhUoaADAdpQXaqMsK6STIMlBy8f0Ftw1+y/jR6u5y96RvNT2j3E2DF+DuxYClHMoRCp3vQBLVeuDWLXj6fRgbHsrEZ7mXwIBCrQoHc1KJ5QS0BP06mafXMzYlk/2aV1eG/5hAMwaj6F7SxXqaQI9ZktCqqfIGFHk0uz+A/DnTKcDeVfpR26dOYwIUrqJgYBIV3NhOET5O5LAczhg3ZYZFV/LFSirsBrzbFPAw9y+LS8m2aEC9WEhZg==
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Sun, 11 Jan
 2026 12:03:13 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:03:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Samir M <samir@linux.ibm.com>
CC: Paul E McKenney <paulmck@kernel.org>, Frederic Weisbecker
	<frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	"vishalc@linux.ibm.com" <vishalc@linux.ibm.com>
Subject: Re: [PATCH v3] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Thread-Topic: [PATCH v3] rcu: Reduce synchronize_rcu() latency by reporting GP
 kthread's CPU QS early
Thread-Index: AQHceSUNaPI6SUrieESUa77m9eiSu7VM01MAgAAe6VA=
Date: Sun, 11 Jan 2026 12:03:13 +0000
Message-ID: <9B61E99F-0D5B-4811-B634-E86387EF4D61@nvidia.com>
References: <20251230004124.438070-1-joelagnelf@nvidia.com>
 <02d29108-e145-4513-a378-e2dc353b1ef3@linux.ibm.com>
In-Reply-To: <02d29108-e145-4513-a378-e2dc353b1ef3@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8056:EE_|CH2PR12MB4104:EE_
x-ms-office365-filtering-correlation-id: 0faf2ca4-c57a-495c-649e-08de510965a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkIrellIUGdTbmt6M2hmVlFOUDVGWWhxdE5ldzRoTG9XajBoMDA2eThNODlu?=
 =?utf-8?B?VzVNSlE4YkQ0MzVOMnAxMTFDU1gxNEFJUVREVkxUUlRTNVhtRUFGazNMSjk4?=
 =?utf-8?B?dTN5R3BnRWpvbWhOTjBadTJzQlF2QlRJeEZxS1F0bnNIVkJ4QzY0M2xtV0p5?=
 =?utf-8?B?VnVUZXJXSTdKNHY5WnBIeHFDbUMyalpHM1U3b3NFV1RtbGJNdDhSMUZIZy9I?=
 =?utf-8?B?UXNUL2dDdmJvNFNJSXA1QjFiQkFEQVBxbHRvdWdzeGN4NUNDN0ljeXZZa0Nq?=
 =?utf-8?B?N0xyYlVuWnpmRlRRcTJYYi9kU2VQQ0tOTWw0Um4wTU9aVUFncVZPbU53aDN3?=
 =?utf-8?B?ZCt2ZXpJZUl3ZWR2VEhKQXZXejB4ZndTTlZVS040N3VMVVRudEpPcjNzYklT?=
 =?utf-8?B?azMvRFI4RUZiWHFYTnU3dkl0ZC9KQTZUTXB2djFUdWVIaWlUaGZSd1NRelEr?=
 =?utf-8?B?ZFZRSzR3V2RiWDAxT1dkMVZIeVZNUFVWNXMwV3F6SzhNTFhvMzhoWWpFR0hk?=
 =?utf-8?B?TCswQlhrTUtrTVcyeVUxVkdMaFVQSjIwdzQyQllNdnBFRlA4d0thQU92Wno0?=
 =?utf-8?B?aWxEekpaeUYvTVJ4RFR5WjE4VlNvV1BpUGZrSWVKYi8rQ0dGM2U4MmpEN1RC?=
 =?utf-8?B?aWI4V3ZHZmhqbUdaU1Y2Wi9KbWQvMWw0cjJKanFQSEtUZDYyOVVYL3A3UW9J?=
 =?utf-8?B?R05MODRpcVVKZnUxSDRCSGhiZzNWbHBlRGVGbnQ0Q3JsdEtaL3BGZUVWbzJS?=
 =?utf-8?B?NFZKc1RYWExxVWJVSmdwWUFSalBxRVVuQWlIUG8ra0pDeFNld3AvU1lXTkJt?=
 =?utf-8?B?Z0NQMnA0N3JIN0szVnhMTTlNVVo1emwvd0pXUjFkZ042dloxcEtQejVPZ3RT?=
 =?utf-8?B?d1FINGNuelFycFQ0WUwrem9GNEJYVmViZFcwa3IwWm9uY1JTOGgvdjcrcldG?=
 =?utf-8?B?SFZhNGFoRE1jazdwcWhNaTdLeW1ibm1oV0p5eHJnK2JnMmpGN3daajFDcVNy?=
 =?utf-8?B?QnJiQXdqTlpnRHJmTkZWbEJseWN1YXBmTHR0TnhRY1VpTHdaNU94TCsvL2x6?=
 =?utf-8?B?dDNOVUpUY01aY0FjT2dLZlJBTHoxRE02cHJJVkEzZ20zbkQ3RzNFZzRoUHFQ?=
 =?utf-8?B?ZkZCSWcvMmFDTy9RSm44VXdJajhEc3RwRTlFZml5S0sxa1crcEcyUW1JR1NN?=
 =?utf-8?B?VlllTFp3aTU2TkJJNTZzSjNwUFB1SUZ1aUJZUkdPdVJVcXRLR3lJMnVnWDJr?=
 =?utf-8?B?RnA0dTNPZFBtZ0tHdzJpTGRXQVBpVkd4SmNPMFBhRXBPdllKb1EyWXZ6WGZo?=
 =?utf-8?B?b0JqQnBBOGluUUsyNkNYQnI0OFAxUGx6Z29HUTMzNy96c0hiRmxmbUs0dE9p?=
 =?utf-8?B?TTlKNnppWTZTUFQwVk91a1JLZHdvRjk2dkRtSHVBSXdlUkRZNHpOVDU5b01p?=
 =?utf-8?B?OXA5VDZzd3NxTFZET1J5NWhoYURzR2F1OVk3cEIwME1oTzlUMnB6RklpT0tX?=
 =?utf-8?B?K0pTRWRLYVVwUlFRd2JTcWZpTVJudmlFQ1VUd2VBbU80Q29sVEU0YzA1aXY5?=
 =?utf-8?B?UG1hZFMrRTFrTmhYZUF4V0puUFZGS0FFSnVVUXJNb2NkZGF0Z1pISjdVVFRi?=
 =?utf-8?B?cS9sbzVrOVJiejlWQ0NpZXFHMVZDaWl3ZzkzZ2NtbHdLYVRVUGF5aTQyZVli?=
 =?utf-8?B?WU1wbkRUYmhjTSt2M3ptZmhCalZPRVVKaGJ0ODJZZldtb25NMWJCSDRzSWNF?=
 =?utf-8?B?SGJENm54Zi94WG0zYUlpb1VUUlpvUVBsaWp4Q3lvTHlFbmIwSXdVNlEraUV5?=
 =?utf-8?B?YTYzWFdvUjBIck9mb0lJaWxGVmJNY2tRRkU5RS8ydFd1eEkrMEdSbzVGTDJ5?=
 =?utf-8?B?OGcrdERST3praUxyQzZsNlNDVFduV3BmK2RuaTBuTlRGNGF2UFl6TXYyOE5T?=
 =?utf-8?B?MnZ1RktOUndzMUVqWm5Nb3U1amkxMTkvTzc3UWhDNE9EdVFTUVpWd2NMMnRK?=
 =?utf-8?B?WlAvaGNzcGZBVFpBeEVwalp0eUcxZ0NNalNTZ09PRHI1S25kcldSNG8xTVZW?=
 =?utf-8?Q?BRFmZk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkxEQWxJUDJvZXNCODNiT2hYVUlkcjEyWkVtb25ZelpncU5GUmpCQkhWOXZY?=
 =?utf-8?B?M3VPY0VFWTF2OGpEMDlSaW05K3ROZkJJaFhHaVFyVlhmYmZ6akVIeWNkNXZZ?=
 =?utf-8?B?Q3h1Nmx6eEJsQjVLMlJaeHdCdndtb2ZKUzJCbUtINXF4TDE0a0F0Z0cwcXJF?=
 =?utf-8?B?aG94MWkveUcrK2tIL2YzR29zZ3BkQWtDMFE0Z1U0TzhaaGZmbXZZSC80eTVp?=
 =?utf-8?B?MFFJd3ptNTA5bzh5SWZqNEZJSVpkWGkremQvTHYvM0taSHp1d2dhSnVRbkhG?=
 =?utf-8?B?YTJYZGgxZkJra2ZJTXk3aUxHRzh0aVM5bGZuRzd2RWFLNmFQb1RsNWxPaWR2?=
 =?utf-8?B?RU9VSzRlaU4wd2pTVk10QUZKSTRjdDNRVTF2SjJ2TUdCRmVmVXllV3p2YWdn?=
 =?utf-8?B?bC96Z2swbm1RcUhQeXJWaklKcWtyN0lCdm5qK1RXQVVUaWZITEFGdlFReFc4?=
 =?utf-8?B?bVcvNTU1bWFvNHR3cUZTNTFnNEpBSUlJRUsrRmtlakdZaHNHUzhKbmpFYk02?=
 =?utf-8?B?M1ZvQ1RPN2hMb2hTNDdvb1lWck5pUGVGbVBoaHNqaUtqNjhhZGFjMktoVXVO?=
 =?utf-8?B?NWRnTmh2V2JJdTl3cmhMRHF5VGp0WXBvQmlTcXdBVm1IRU5COVhZcmhGWTI2?=
 =?utf-8?B?VitxTk5NOThFU1lHMCtFRzUzU1FGLzUxRFBESnhFdlFsVGQyTjBhalpWczNG?=
 =?utf-8?B?aVljbDVZWVVOblJpRFVtZVFRTFgzRFl3Mmhsdk1rSXRKZ290UGVXZTNBYnRC?=
 =?utf-8?B?OXlQbmFFNllKZEtUZnIybGQ1czh4cDhOb0QzSzZkTDVnb1BUZlp4NytUblpW?=
 =?utf-8?B?UUlHd1VaVUI4bzg2Ull4V0k4L2dJS3FaWjhjVXE1MWNucVRJcHEzQWhJcXpM?=
 =?utf-8?B?U2pNVlo0cG12MHNwVXRmTUlseEhxVmVOUjA3VnVsK2dLWTJjdjJKZGFYQnJU?=
 =?utf-8?B?MjJjc3JPQWlLTnZqQWM1b09va3FxZ0xqNmJUZzlBSTJGcE9RakM4VFdGWkFW?=
 =?utf-8?B?a3JiQ1VIOWQrTStnOXk3cjdwUnRmWUpFaHlmUUhmTm1vRHp1NlhEQnNITUF5?=
 =?utf-8?B?Qlcyc3pMMkJOM09mQko2UCtpd2xLZGUvZUgwcmlpZ05ZNERmYmpZZFRMTXNO?=
 =?utf-8?B?S2ZaMWdRSTkrMDFqUHcvdWNEbkJvTnlzRU1wUXluK01qYkFieVNtSzJ2Rjdn?=
 =?utf-8?B?SGpQYjMwU25EbDVRV2YwMWFTUEc1ZmVmendoRE40NlpJQWNkSndBeVBCb215?=
 =?utf-8?B?VzJILzhkZU1QNkFsek9TMFlvS3F0OTd1R3krVDFRdlRwcGpGcGVINDZBVXdO?=
 =?utf-8?B?cnJ4bFFjWGhBM1MveEFoank3WUExaVdyQ2EyTVRsc0taTVVoNkVUM0orM1dV?=
 =?utf-8?B?blc5YkNKWHNXQTBicm5OVkMyRUFhNlF6S3owcnROaVNRVHNrSXBUeS8zNnlh?=
 =?utf-8?B?QUpvMnRwdDFKbWxVeElFSlUyS2xQdGNFTDRJdDVrazNNaEQ2Y3d6UkdRVkZa?=
 =?utf-8?B?VmovdWVXektJKzU2TG0xd3NhM2krVTdkVW1tZnFuWEJUeHVaZnlPRytYVktC?=
 =?utf-8?B?ZlJvQVlXeHRONEVxTUpBZkI5QmoxMmJRWmF6b0hnUUs1R3hFbEM5WDduR0ht?=
 =?utf-8?B?TmZWRTBmVWxHaDkwK2JwdGtkaHpvdGIzSG52anBtN3pzbklFT0dDNTMyN3RH?=
 =?utf-8?B?UEVFNzVqQ0FJb3VUdUV3UCsyRFJnU1VHS1ZEbW4wWXQ2NWhPcVVoWmF4Z0xa?=
 =?utf-8?B?WDBwSWdjSWprVnVBdDBVdTRtczJyUUJBM04rM3pDMzQ3dmNKOUNXWDVBNmQ1?=
 =?utf-8?B?TnRvS1pQNzRFMjJRSEpKM2p6UzhsaXJDUzdMdlJwR2ZPWmI5Vk1HMWp4ZlRU?=
 =?utf-8?B?dHNZVmxDMk5MV1VnVzN3dUpHbUVqckRWbURxSGlLT2RCcHF2V0Juc3FvWDlO?=
 =?utf-8?B?YXE0cWRiOHhNRDNvT2VKbjJ6RGlVaWNReUxHdUZqWXNZMXk3alJleUU5UkJT?=
 =?utf-8?B?NzhDSDdNaFhHeXBUOU9ud2tYWnE2OTh2T0hoYTQ4dW05cGV5bVFaS1JNaGxN?=
 =?utf-8?B?N0VvS3FFd2kvMHFjdXRSM1U3dmpYSTNWeWkwUEpveXNUdE5uY1dGZnp2ejhI?=
 =?utf-8?B?VHdhdFR4aURPWW5hVTA2Y0luSGxlRzQyREd6c1NRRTNIcERmdm12dGt3cksv?=
 =?utf-8?B?UG5MWndDOThMM2V4UFFZK3I4UXdteUdUWHdpa3ZHaFlXUW1SY1I1VDBMWWlm?=
 =?utf-8?B?OGlveHF4b3VzSktlZHZYY1JiRytSWVVuU0tFckdQUEFhakR6TiszSVhyOFVl?=
 =?utf-8?B?U2ZLY1VjYUlPL0JKOWR6dTlhbW9TU2lXVUdaL0lmL2g0eW5kdDJyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faf2ca4-c57a-495c-649e-08de510965a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 12:03:13.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahD85HY1+3XOmErNemfIFn47CogVoRRjJbPTCvcMGIlC/Qffu2OAe4KQEJ+Ttbx5qHSuUKQ+m3b02yxq+C2pBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104

DQoNCj4gT24gSmFuIDExLCAyMDI2LCBhdCA1OjEz4oCvQU0sIFNhbWlyIE0gPHNhbWlyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiBPbiAzMC8xMi8yNSA2OjExIGFtLCBKb2Vs
IEZlcm5hbmRlcyB3cm90ZToNCj4+IFRoZSBSQ1UgZ3JhY2UgcGVyaW9kIG1lY2hhbmlzbSB1c2Vz
IGEgdHdvLXBoYXNlIEZRUyAoRm9yY2UgUXVpZXNjZW50DQo+PiBTdGF0ZSkgZGVzaWduIHdoZXJl
IHRoZSBmaXJzdCBGUVMgc2F2ZXMgZHludGljay1pZGxlIHNuYXBzaG90cyBhbmQNCj4+IHRoZSBz
ZWNvbmQgRlFTIGNvbXBhcmVzIHRoZW0uIFRoaXMgcmVzdWx0cyBpbiBsb25nIGFuZCB1bm5lY2Vz
c2FyeSBsYXRlbmN5DQo+PiBmb3Igc3luY2hyb25pemVfcmN1KCkgb24gaWRsZSBzeXN0ZW1zICh0
d28gRlFTIHdhaXRzIG9mIH4zbXMgZWFjaCB3aXRoDQo+PiAxMDAwSFopIHdoZW5ldmVyIG9uZSBG
UVMgd2FpdCBzdWZmaWNlZC4NCj4+IA0KPj4gU29tZSBpbnZlc3RpZ2F0aW9ucyBzaG93ZWQgdGhh
dCB0aGUgR1Aga3RocmVhZCdzIENQVSBpcyB0aGUgaG9sZG91dCBDUFUNCj4+IGEgbG90IG9mIHRp
bWVzIGFmdGVyIHRoZSBmaXJzdCBGUVMgYXMgLSBpdCBjYW5ub3QgYmUgZGV0ZWN0ZWQgYXMgImlk
bGUiDQo+PiBiZWNhdXNlIGl0J3MgYWN0aXZlbHkgcnVubmluZyB0aGUgRlFTIHNjYW4gaW4gdGhl
IEdQIGt0aHJlYWQuDQo+PiANCj4+IFRoZXJlZm9yZSwgYXQgdGhlIGVuZCBvZiByY3VfZ3BfaW5p
dCgpLCBpbW1lZGlhdGVseSByZXBvcnQgYSBxdWllc2NlbnQNCj4+IHN0YXRlIGZvciB0aGUgR1Ag
a3RocmVhZCdzIENQVSB1c2luZyByY3VfcXMoKSArIHJjdV9yZXBvcnRfcXNfcmRwKCkuIFRoZQ0K
Pj4gR1Aga3RocmVhZCBjYW5ub3QgYmUgaW4gYW4gUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0
aW9uIHdoaWxlIHJ1bm5pbmcNCj4+IEdQIGluaXRpYWxpemF0aW9uLCBzbyB0aGlzIGlzIHNhZmUg
YW5kIHJlc3VsdHMgaW4gc2lnbmlmaWNhbnQgbGF0ZW5jeQ0KPj4gaW1wcm92ZW1lbnRzLg0KPj4g
DQo+PiBJIGJlbmNobWFya2VkIDEwMCBzeW5jaHJvbml6ZV9yY3UoKSBjYWxscyB3aXRoIDMyIENQ
VXMsIDEwIHJ1bnMgZWFjaA0KPj4gc2hvd2luZyBzaWduaWZpY2FudCBsYXRlbmN5IGltcHJvdmVt
ZW50cyAoZGVmYXVsdCBzZXR0aW5ncyBmb3IgZnFzIGppZmZpZXMpOg0KPj4gDQo+PiBCYXNlbGlu
ZSAod2l0aG91dCBmaXgpOg0KPj4gfCBSdW4gfCBNZWFuICAgICAgfCBNaW4gICAgICB8IE1heCAg
ICAgICB8DQo+PiB8LS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwNCj4+
IHwgMSAgIHwgMTAuMDg4IG1zIHwgOS45ODkgbXMgfCAxOC44NDggbXMgfA0KPj4gfCAyICAgfCAx
MC4wNjQgbXMgfCA5Ljk4MiBtcyB8IDE2LjQ3MCBtcyB8DQo+PiB8IDMgICB8IDEwLjA1MSBtcyB8
IDkuOTg4IG1zIHwgMTUuMTEzIG1zIHwNCj4+IHwgNCAgIHwgMTAuMTI1IG1zIHwgOS45MjkgbXMg
fCAyMi40MTEgbXMgfA0KPj4gfCA1ICAgfCAgOC42OTUgbXMgfCA1Ljk5NiBtcyB8IDE1LjQ3MSBt
cyB8DQo+PiB8IDYgICB8IDEwLjE1NyBtcyB8IDkuOTc3IG1zIHwgMjUuNzIzIG1zIHwNCj4+IHwg
NyAgIHwgMTAuMTAyIG1zIHwgOS45OTAgbXMgfCAyMC4yMjQgbXMgfA0KPj4gfCA4ICAgfCAgOC4w
NTAgbXMgfCA1Ljk4NSBtcyB8IDEwLjAwNyBtcyB8DQo+PiB8IDkgICB8IDEwLjA1OSBtcyB8IDku
OTc4IG1zIHwgMTUuOTM0IG1zIHwNCj4+IHwgMTAgIHwgMTAuMDc3IG1zIHwgOS45ODQgbXMgfCAx
Ny43MDMgbXMgfA0KPj4gDQo+PiBXaXRoIGZpeDoNCj4+IHwgUnVuIHwgTWVhbiAgICAgfCBNaW4g
ICAgICB8IE1heCAgICAgICB8DQo+PiB8LS0tLS18LS0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0t
LS0tLS0tfA0KPj4gfCAxICAgfCA2LjAyNyBtcyB8IDUuOTE1IG1zIHwgIDguNTg5IG1zIHwNCj4+
IHwgMiAgIHwgNi4wMzIgbXMgfCA1Ljk4NCBtcyB8ICA5LjI0MSBtcyB8DQo+PiB8IDMgICB8IDYu
MDEwIG1zIHwgNS45ODYgbXMgfCAgNy4wMDQgbXMgfA0KPj4gfCA0ICAgfCA2LjA3NiBtcyB8IDUu
OTkzIG1zIHwgMTAuMDAxIG1zIHwNCj4+IHwgNSAgIHwgNi4wODQgbXMgfCA1Ljg5MyBtcyB8IDEw
LjI1MCBtcyB8DQo+PiB8IDYgICB8IDYuMDM0IG1zIHwgNS45MDggbXMgfCAgOS40NTYgbXMgfA0K
Pj4gfCA3ICAgfCA2LjA1MSBtcyB8IDUuOTkzIG1zIHwgMTAuMDAwIG1zIHwNCj4+IHwgOCAgIHwg
Ni4wNTcgbXMgfCA1Ljk0MSBtcyB8IDEwLjAwMSBtcyB8DQo+PiB8IDkgICB8IDYuMDE2IG1zIHwg
NS45MjcgbXMgfCAgNy41NDAgbXMgfA0KPj4gfCAxMCAgfCA2LjAzNiBtcyB8IDUuOTkzIG1zIHwg
IDkuNTc5IG1zIHwNCj4+IA0KPj4gU3VtbWFyeToNCj4+IC0gTWVhbiBsYXRlbmN5OiA5Ljc1IG1z
IC0+IDYuMDQgbXMgKDM4JSBpbXByb3ZlbWVudCkNCj4+IC0gTWF4IGxhdGVuY3k6ICAyNS43MiBt
cyAtPiAxMC4yNSBtcyAoNjAlIGltcHJvdmVtZW50KQ0KPj4gDQo+PiBBZGRpdGlvbmFsIGJyaWRn
ZSBzZXR1cC90ZWFyZG93biB0ZXN0aW5nIGJ5IFVsYWR6aXNsYXUgUmV6a2kgb24geDg2XzY0DQo+
PiB3aXRoIDY0IENQVXMgKDEwMCBpdGVyYXRpb25zIG9mIGJyaWRnZSBhZGQvY29uZmlndXJlL2Rl
bGV0ZSk6DQo+PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFsIHRpbWUN
Cj4+IDEgLSBkZWZhdWx0OiAgICAgICAgICAgICAgICAgICAyNC4yMjFzDQo+PiAyIC0gdGhpcyBw
YXRjaDogICAgICAgICAgICAgICAgMjAuNzU0cyAgKDE0JSBmYXN0ZXIpDQo+PiAzIC0gdGhpcyBw
YXRjaCArIHdha2VfZnJvbV9ncDogMTUuODk1cyAgKDM0JSBmYXN0ZXIpDQo+PiA0IC0gd2FrZV9m
cm9tX2dwIG9ubHk6ICAgICAgICAgMTguOTQ3cyAgKDIyJSBmYXN0ZXIpDQo+PiANCj4+IFBlci1z
eW5jaHJvbml6ZV9yY3UoKSBsYXRlbmN5IChpbiB1c2VjKToNCj4+ICAgICAgICAgICAgICAgMSAg
ICAgICAgIDIgICAgICAgICAzICAgICAgIDQNCj4+IG1lZGlhbjogMzcyNDkuNSAgIDMxNTQwLjUg
ICAxNTc2NSAgIDIyNDgwDQo+PiBtaW46ICAgIDc4ODEgICAgICA3OTE4ICAgICAgOTgwMyAgICA3
ODU3DQo+PiBtYXg6ICAgIDYzNjUxICAgICA1NTYzOSAgICAgMzE4NjEgICAzMjA0MA0KPj4gDQo+
PiBUaGlzIHBhdGNoIGNvbWJpbmVkIHdpdGggcmN1X25vcm1hbF93YWtlX2Zyb21fZ3AgcmVkdWNl
cyBicmlkZ2UNCj4+IHNldHVwL3RlYXJkb3duIHRpbWUgZnJvbSAyNCBzZWNvbmRzIHRvIDE2IHNl
Y29uZHMuDQo+PiANCj4+IFRlc3RlZCByY3V0b3J0dXJlIFRSRUUgYW5kIFNSQ1UgY29uZmlndXJh
dGlvbnMuDQo+PiANCj4+IFJldmlld2VkLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtl
cm5lbC5vcmc+DQo+PiBUZXN0ZWQtYnk6IFVsYWR6aXNsYXUgUmV6a2kgKFNvbnkpIDx1cmV6a2lA
Z21haWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9lbCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZA
bnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gIGtlcm5lbC9yY3UvdHJlZS5jIHwgMTIgKysrKysrKysr
KysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMNCj4+IGluZGV4IDc4
YzA0NWE1ZWYwMy4uYjdjODE4Y2FiZTQ0IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3JjdS90cmVl
LmMNCj4+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+PiBAQCAtMTYwLDYgKzE2MCw3IEBAIHN0
YXRpYyB2b2lkIHJjdV9yZXBvcnRfcXNfcm5wKHVuc2lnbmVkIGxvbmcgbWFzaywgc3RydWN0IHJj
dV9ub2RlICpybnAsDQo+PiAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBncHMsIHVu
c2lnbmVkIGxvbmcgZmxhZ3MpOw0KPj4gIHN0YXRpYyB2b2lkIGludm9rZV9yY3VfY29yZSh2b2lk
KTsNCj4+ICBzdGF0aWMgdm9pZCByY3VfcmVwb3J0X2V4cF9yZHAoc3RydWN0IHJjdV9kYXRhICpy
ZHApOw0KPj4gK3N0YXRpYyB2b2lkIHJjdV9yZXBvcnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0YSAq
cmRwKTsNCj4+ICBzdGF0aWMgdm9pZCBjaGVja19jYl9vdmxkX2xvY2tlZChzdHJ1Y3QgcmN1X2Rh
dGEgKnJkcCwgc3RydWN0IHJjdV9ub2RlICpybnApOw0KPj4gIHN0YXRpYyBib29sIHJjdV9yZHBf
aXNfb2ZmbG9hZGVkKHN0cnVjdCByY3VfZGF0YSAqcmRwKTsNCj4+ICBzdGF0aWMgYm9vbCByY3Vf
cmRwX2NwdV9vbmxpbmUoc3RydWN0IHJjdV9kYXRhICpyZHApOw0KPj4gQEAgLTE5ODMsNiArMTk4
NCwxNyBAQCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIGJvb2wgcmN1X2dwX2luaXQodm9pZCkN
Cj4+ICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1JDVV9TVFJJQ1RfR1JBQ0VfUEVSSU9EKSkN
Cj4+ICAgICAgICAgIG9uX2VhY2hfY3B1KHJjdV9zdHJpY3RfZ3BfYm91bmRhcnksIE5VTEwsIDAp
Ow0KPj4gICsgICAgLyoNCj4+ICsgICAgICogSW1tZWRpYXRlbHkgcmVwb3J0IFFTIGZvciB0aGUg
R1Aga3RocmVhZCdzIENQVS4gVGhlIEdQIGt0aHJlYWQNCj4+ICsgICAgICogY2Fubm90IGJlIGlu
IGFuIFJDVSByZWFkLXNpZGUgY3JpdGljYWwgc2VjdGlvbiB3aGlsZSBydW5uaW5nDQo+PiArICAg
ICAqIHRoZSBGUVMgc2Nhbi4gVGhpcyBlbGltaW5hdGVzIHRoZSBuZWVkIGZvciBhIHNlY29uZCBG
UVMgd2FpdA0KPj4gKyAgICAgKiB3aGVuIGFsbCBDUFVzIGFyZSBpZGxlLg0KPj4gKyAgICAgKi8N
Cj4+ICsgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+PiArICAgIHJjdV9xcygpOw0KPj4gKyAgICBy
Y3VfcmVwb3J0X3FzX3JkcCh0aGlzX2NwdV9wdHIoJnJjdV9kYXRhKSk7DQo+PiArICAgIHByZWVt
cHRfZW5hYmxlKCk7DQo+PiArDQo+PiAgICAgIHJldHVybiB0cnVlOw0KPj4gIH0NCj4+ICANCj4g
DQo+IEhpLA0KPiANCj4gDQo+IEkgdmVyaWZpZWQgdGhpcyBwYXRjaCBvbiBwcGM2NCBzeXN0ZW1z
IGFuZCBvYnNlcnZlZCBjb25zaXN0ZW50IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cy4NCj4gDQo+
IFRoZSB0ZXN0aW5nIHdhcyBjb25kdWN0ZWQgb24gUG93ZXIgTFBBUnMgdXNpbmcgMjAgY29yZXMg
KDE2MCBDUFVzKSB3aXRoIFNNVCBlbmFibGVkIGFuZCBkaXNhYmxlZC4gQWxsIHRlc3RzIHdlcmUg
cGVyZm9ybWVkIG9uIHRoZSBsYXRlc3QgdXBzdHJlYW0ga2VybmVsICh2Ni4xOS4wLXJjMyspLCBh
bmQgdGhlIHBhdGNoIHNob3dlZCBtZWFzdXJhYmxlIGltcHJvdmVtZW50cyBpbiBib3RoIFNNVCBj
b25maWd1cmF0aW9ucy4NCj4gDQo+IFNNVCBNb2RlICAgfCAgICAgIFdpdGggUGF0Y2ggKHMpICAg
IHwgICAgV2l0aG91dCBQYXRjaCAocykgIHwgSW1wcm92ZW1lbnQgKCUpDQo+IOKAlOKAlOKAlOKA
lOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKA
lOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlOKAlA0KPiBTTVQgT04uICAgICAg
fCAgICA1MS42NjIgICAgICAgICAgICAgICB8ICAgICAgNzUuNTQwICB8ICAgICAgIDMxLjYxJSBm
YXN0ZXINCj4gU01UIE9GRiAgICAgIHwgICAgNDQuMjQ2ICAgICAgICAgICAgICAgfCAgICAgIDU5
LjkzMyAgfCAgICAgICAyNi4xOCUgZmFzdGVyDQo+IA0KPiBQbGVhc2UgYWRkIGJlbG93IHRhZzog
VGVzdGVkLWJ5OiBTYW1pciBNIDxzYW1pckBsaW51eC5pYm0uY29tPg0KDQpUaGFua3MhIEJvcXVu
LCBkbyB5b3UgbWluZCBhZGRpbmcgdGhlIHRhZyB0byB0aGUgYXBwbGllZCBwYXRjaD8NCg0KIC0g
Sm9lbA0KDQoNCj4gDQo+IFRoYW5rcywNCj4gU2FtaXINCj4gDQo=
