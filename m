Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA0314B72;
	Mon, 12 Jan 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226590; cv=fail; b=ZnKRnVm2TrKtFII4QaUXLb3TwM4tdOyWXbvScPuA2Q5tmTyR3Kl4Dxp5/A27AkdsrHU308pUEx7sS3BwThM0likWDtdlZzAVzIYepM8tXZxTdJJcFmPDZO46M2PrBd8nA8Jly6y8PRQWqPavMn10XGDHcR4mJYBDq8WkBss71GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226590; c=relaxed/simple;
	bh=a26o4l/P/pMSg7IbGFT9YmLRTQylW3wEGKHDsZ75iok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGCmOZLwaniV2pMgQY1kn8FrEzLrmpoT6kRXUQgXuLucYD9C5Wlbs1englCA0HRIe4+RGEpE24JQGkcMbVVhwZ3ter6wuZKhNPJU3ZQNMEZ4C1OAWnfCLTynYNILJ/j0hhoQG9oVRIAwlkdYLMlXOpURypDLKFYDduI8lsOBItY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hUoKeWcG; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hUoKeWcG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY9Xbmd+OyBnD/YyUuyUJ5RE82+LoaU/kSUyzRx19P1NPcZTATCzkikZQHvpiRDpvuFgoZ0bUeXuT+AxX/fqeYMEp4abG3dRWhhuRMqRB9ILxsRUgcOh2X1BriWJYjm7KSG9YgAnsOU5tU4yEJIq5YlyOZdmpuN3H0bGzfXWryhaZZR55g93cp09x2u70HYEbDF7LjIiYnBPJK1Rg8VGBPJj+eybIMrGLO19/Cou5gAjpEiCM+d6Y/MePnsHHIyJ2BtHFDz/Jz0Ej7xYiKvgRKOTvcFu/vSdtqxMDOEN9231ECgCFoRpnYWh+jQimGCBHkbF2P1XvaZjeEY51kpgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26o4l/P/pMSg7IbGFT9YmLRTQylW3wEGKHDsZ75iok=;
 b=KbwvkVA4xaDb/wSt+vm1FOXkSDRref4SA70QNakej324hJoAxcw9NdhkesbHwMzI391Vev5y/knnPlvaA5KgR+onKLIOGayZ8n/X1Qncc9VoZZ+hxp3ZhY0RZrVAKYOhcUgUDl4KDg0xKbmcdIN90Kzxsf5WGd+Ndqqd+yKt8haACzVwz6tm5visaX2Xla67wO8kMeRSKCCmoGD3PqJz+SC8cpzUDuRsuABdqzpqcuioZjT99TWilplcQigNIO9+Tz+uqHnIVbK9S2zogvia/3ifEVwic1IncajHLbOV9t5w5oaAyMIeGm9/+nlyFrtr1Sx9R1+7z1sFBzRl5S2RSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a26o4l/P/pMSg7IbGFT9YmLRTQylW3wEGKHDsZ75iok=;
 b=hUoKeWcGpDetUMzJkYvpNBHb/6uLBwXWW0bbbZx2R7lF9OvVUxGZxJ4itT8ZTe3PK5LVxJkFDaAImQKX9qUBrChJz//douzP7BDojAhLlDAV2wVZUoXWVs6fGf0fj2JSfAYJMIxbvTVgzLr7j3H0e2nropkobC+wy8iTNVqidr29Kou64kfOM5cuT6ZhPGaL4HIGXVJdnG3Jj/tMf8rx8SAVfBU3R/X496XXjCMNhnZokOLCAYxPXpkK97vOBXnyNhitAIAtVKI18bNGQR4nqs+I4HhSN3hz4APAqM7ZQyUcxZrWCyDHNYEOJDC+5xsoCatSVIThHeQi2mZFYq2Fzw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 14:03:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:03:03 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
CC: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org"
	<frederic@kernel.org>, "neeraj.upadhyay@kernel.org"
	<neeraj.upadhyay@kernel.org>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "sshegde@linux.ibm.com"
	<sshegde@linux.ibm.com>, "srikar@linux.ibm.com" <srikar@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Topic: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Thread-Index: AQHcg6gSQ2wH1CXqL0ua+MpkTxEkB7VOkQWe
Date: Mon, 12 Jan 2026 14:03:02 +0000
Message-ID: <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
In-Reply-To: <20260112094332.66006-2-vishalc@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SJ5PPFFA661D690:EE_
x-ms-office365-filtering-correlation-id: f7b16814-322a-4357-d09c-08de51e34d5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGFmQ1NpRHNXZjFNeWk0TXdXdDZQUm96a244dGFkazFUL3VKd3pkcjRjM2xm?=
 =?utf-8?B?a0VYS1hKSDNwWEl0RCt2MW00OXE5S3FLR2EwVUJXeFZmdlpidm1ZNHNqR1B4?=
 =?utf-8?B?NjBVdXZKZnJockdHUVg3TmpPUjcyL2l2eUZtMVFWWlVndTRaako3VWo1OUJy?=
 =?utf-8?B?WGF3emg0SGNtWW9qL1Zaamx1eCtBSWxqa1BWaHZRSUN1S091Vi8yYSt0M3Q0?=
 =?utf-8?B?MXlFbUZtcWlmODY2RGd2NUVneG4yNFZwU2lVM2xqd3BrVDdORGlOc29hZzU2?=
 =?utf-8?B?Y3BZeGlPYXc1bXZHanZ5Vm9kNkVhS2dQSHZrc2MrcTAzdGZ3Z3FtSWpOYTZ1?=
 =?utf-8?B?WWoyREREYW1MU1R4Q0ppQys4aFRLenpjZG1Zc1QzM2o3dUlCcjJmYnlOQzhP?=
 =?utf-8?B?blJqVVhyVzJVblpFTUhWMWtBakFBK0lrTC9XSTlWQ21oUDloU0dvczdQdHpp?=
 =?utf-8?B?OXBGTXUyZVd5d0hpSVl3cnM2SFNRWG5Bd1hERzVZU2hQRmF2RE1IRnpKQzdU?=
 =?utf-8?B?K1VlSXRhNUl4VWltc095bDIwY1FKUFR0UHQ4RnJIRC8yZlppS2hLZjFadEhB?=
 =?utf-8?B?MU9HbWtaTTRSeXlxYXFDaGc5Z0NEcFhRbVdYS2ZNZ0VmT3dsQzM1azh5RHc2?=
 =?utf-8?B?OEVpc0lIdWRiWW83YnQvbUNoUklhZmFlMGhnYTQwclBBclpQNWd3OERpazQ5?=
 =?utf-8?B?NzEwVENNWW0vTnFFTnVXWWxmTG9EdElxTDdoTXdBU1V3akFkcTlyM21hL3pQ?=
 =?utf-8?B?R205Wm5jWmZpU3FadXR3QU83bEVXRnZoekc4SjlCaEdBems3bWhydGdxUXNo?=
 =?utf-8?B?NURwL2sva2VBdE5KYU5qOHJIYzVucm9kL1Z2ZlVYVFNlMEk2YTdnclMwUW51?=
 =?utf-8?B?anhnT1ZCNFJRYkNtWlBMRnZjNy9oaVp3NE10Y09RR1k0ajVZNVRVdGtFK3BU?=
 =?utf-8?B?SXJSQUtmV0VGVVFZU2prNER0Z1RrZjNDNUg1cWlRZk05Mk5yU1Npc3BGYm1j?=
 =?utf-8?B?NXJTTDRhRTc5RzYraUFlbEl1cFJ3T2NyMlZWZFhyL21mRFc1cE5TV1c5UUhZ?=
 =?utf-8?B?NjVacytINDIvbWgrbmc5UUw0N3lVVllIMFNVa1BLUWRDaXpBL21zUjliV3Va?=
 =?utf-8?B?WnNYRGlXWllLOEFOWEJwQk02M1MvaW9PRGNDWWdsZC9iTDlqazZjMDkwUHQv?=
 =?utf-8?B?MktKVm1MQUtQYlZaMk40VkZmQi9FbWlpMFgzdFRyYUdLWC9OcVpSUWdDaVNr?=
 =?utf-8?B?Z21LajhjOEVTSXozbXVqcTBGa0VoV1l4Skl5WWQzd2dKNTYyanVvSVRvVGpY?=
 =?utf-8?B?UGhGWERYVjVNT0FZSkxJdEVjS0FoTGVVRVVmSm1GVkpGWURpWis0bHZPWGRY?=
 =?utf-8?B?a29UUnB0RlpTVFlHZk11amR6MFRXbVpxRndiN1RQUGV5YWcwZGQ0QWg4WEFB?=
 =?utf-8?B?QWp4THlXN3A0ZG5YVUpmQ2daa1FOeDA0ODFoeWFlM1JtVzdPbGxwSldMK2JN?=
 =?utf-8?B?TlhNMWIvYVVIRzJ1enY5UjZyTmxFeXVrSnFvVlgzS2xpejI3NkxNNnIyYVRW?=
 =?utf-8?B?VHZMM0UzQUVva2MvU2lwYW9GSEEwZUZzQlk1VlluNGZYL2l0cHN3ZUFJMW82?=
 =?utf-8?B?UnQxYmczOWpJU0w2bHFaMHNodEowdnB5b2VUWk4wa2R6QTUwN05HMEx6czZC?=
 =?utf-8?B?eDNBNzR1Ti9weVBhUE5KdThVZXo1cUlKWi9KK0NyTGxaVmVwcGVWY3NwTDB6?=
 =?utf-8?B?MkhJenV4ZXJ6U3FGdlFHME9laksyTUhKb1NXZnZhWlR6T1dVT0Q2MkNXbDNG?=
 =?utf-8?B?UEliK01yNzRuYjhqZ3l5a0FwbXZNYW1SWWNucXV4WWdPaXdlYWZhanFwWllY?=
 =?utf-8?B?anBKdzlFcEE2Sjk2RlRBTFpxTzY4U0cxdnVJOTdiRVM5aVFiV205UlAvMTE2?=
 =?utf-8?B?OWJ6b3VxdlB1VWZTU0pMSEprVkMrTXowU2ZZWG9ReGJNVmk4T1R0WUZ0akl1?=
 =?utf-8?B?ZVFyN3pWZ3BOeTUxcmlDcWZHdW5BSU9FUndBM04xSERiSCtScFVubEMvOFFW?=
 =?utf-8?Q?BmhsIg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3Fkc1A2NUg1cXI4ZWVwQ25WcFg3SGdRaktsRkxTS2c4NzdRTTJQeGFTWFlB?=
 =?utf-8?B?alUxR01qZ2plcndZdW1rWHZhYVVBZG14di8wdjA5bzV3aERHam14eGdnZVox?=
 =?utf-8?B?S1pNZHVhSU5VbkJYY1hTbzFPVmNzNHRFYjNOSC9VNGdMUlpPRTNER0hmWGRM?=
 =?utf-8?B?dENTdUc3R0VnWHZCc3NhNFZzRG52R2g0S0M2M096OURkSk5QczBDR3pnNmt5?=
 =?utf-8?B?T3hXWVMvQU5rbTNnQ0x5LytsaUtFTUx2ZXZFSEFDVmdmSXhEcndRaHp0U2Vt?=
 =?utf-8?B?a2FvQlNDUGYzcVRaTmlPV0JUMVBaYkpMZFI5MC9aVTUvd25mMEhJRlJRbklR?=
 =?utf-8?B?eWd0TkZlSEV0VzFOYjFtcUZxaEM5RTc5aXJaT2NUTHZCQWdkbkFKeEtTeXdu?=
 =?utf-8?B?ajhrQzc1UnE1dHRWWUJoalhKdXE1d3BObVZFa2dNVlJWcVJKbVB5WGtMRnVL?=
 =?utf-8?B?cHVhUmpCVndBRVNsYUI5Q09XUGticVp6TGdmSTlzNE1jTmp2OE9jMUxka2Rx?=
 =?utf-8?B?bjVMVk83Z0pScHRqMUwweG42KzVTNFZUTS8vb2JvNHhzNGxQT3FoWjAxZGZz?=
 =?utf-8?B?dHQ2THAyVDVJYXEva0d0S1VIeTk4Skc3blpUd1NORFYzdWpjdVh1T1pXd1Y2?=
 =?utf-8?B?UTRHYTZyQUI2cVVxN3J1a0IwUUN5ejRYTDhxaTlwMnJuREtHQjJYYW8zVERZ?=
 =?utf-8?B?bVpPdmhUc3loN0dGd0QrYzhhajZlVSsxYjFnK083TXdQVWR4ajFlN0UzTUFn?=
 =?utf-8?B?VElnRDFVaEFhdjdVYzdJVldobzcrc2gwVmJDeTdwMTJUdXllaHZiSDVnKy84?=
 =?utf-8?B?eU53eWowWnErd1Eya05URGxXYmN5dEQvLzV2aTdKTWpyWG9JY25BaW5MKzlV?=
 =?utf-8?B?TEVLc3JFTStSZzBncDRHVTJWM1Z1ZUNJUzhIajkzaGl6bTROZnNRNVhHL2g3?=
 =?utf-8?B?QThEUG5ZWE96dk9aZGIzRGk3NmZYNUNZMUsxRVREV3R3aWZlVTJERXJNU1BW?=
 =?utf-8?B?YVhZc3BtTFBHNDM0QW1oclc1M3lMTkpYa3NmVk1leTlLaHZsQWVOc1c1ajBV?=
 =?utf-8?B?WXlPcWdJbzRMUG93eFBxV1FwRkhHSzF1NDdPamQ0MXVCc29QMEFNbnZLTDJR?=
 =?utf-8?B?eS9VL095NXhTR2oyVm83SVlia0tVaWx5SnIyTUxVMnJ5ck91S251K0xLVG51?=
 =?utf-8?B?UmZXaDRsZDQ1ZWF0aUM0eUVFWkJuak5GSE1NWDdXaGg3Vk1HckxMTkxoTlZu?=
 =?utf-8?B?ekFSWGNQcDcrSldrZ1F1cnJ3bmJpbHY2M0Y4aUdieVhNa2psRktHQ050MWpY?=
 =?utf-8?B?RXFUQzA2MjRvRUJhOXRrRU45RTZwaFgydDF4RndBZFkzeHdvd25kRk5xbkRw?=
 =?utf-8?B?SGRtT0oxSE5UeDc0OVFBRnZ6d3lUMHRPSTdvc2U1bVZ5aW9mbTI4NzRvanBI?=
 =?utf-8?B?VDZkUFF1c2lrQWNGZUlBc3lYZTJzWnlVSGhGeFppQTN1RDhMY05VaXBQRDVy?=
 =?utf-8?B?TmEreGJNNkZTMVM2bFRxZlJaM3BoNzVhQTNJL2I5aDN5MEt5c0hFSGplUGl1?=
 =?utf-8?B?elV1WlhFY3VQY3A4NzJhcDZoYndYemMxczh1emRBQlhBaGdhUEZOVGVhUFgy?=
 =?utf-8?B?L00wUVNNbWJ0ZlhKOUJNc1UxbXZnRDI4ZmIwZ092dUlJTFJEWFBFOEhpR1By?=
 =?utf-8?B?ajAxL1R1djhJUHQ3c1V0U3BnNk43VTl1dEtKdzc5MHJIeVlaek82ZDMzbkhL?=
 =?utf-8?B?Qk83T2dlUzJRalZ5YWlFOHdhMjhqUUNTdjVzb0U2YTBUODlndGwvMEZLTEU4?=
 =?utf-8?B?SXpzdkxrRVZJdDhCdGZ4cW5jR0RsVHlXbHR3enFkbzhQL2dSRUY2anpobUNX?=
 =?utf-8?B?ckRLcnRKdnpMR1NEb0Fwb3R3a3lCRTI2YWNNU1lVcHRKbFFvMVl5a3QrWEM2?=
 =?utf-8?B?cWs0QTRNRCtTTEpJMWVaNGNpaE55RVp2RWtqN1dWejB4RWp3UU9FaUdzRVU3?=
 =?utf-8?B?WDlhcXlXZ2Fvdzh3cUZCTkE5V094V0hiN1RabmFzTWl0MkF4ZnNYV2pZQ3Rl?=
 =?utf-8?B?UTJvMDhOTjVlSkI0ejRXa1JrUEVEaytodWVQWVpKcHZLbTJJYUZBdWtkcFBD?=
 =?utf-8?B?T0ZLaWZZb0JMNUFub0NMNWUzNDBibGdnemd2OStZbEpFdy80bGJyRHNpaWxh?=
 =?utf-8?B?VVZIck0xTHp0N2VNTERmcXQvdGNjMzhaWGg0cm5hMzRWc2dKUERORDVrbnpo?=
 =?utf-8?B?bkdTSSttenhBTTc3RnpSM3lPWi9BUGM4cEJZZEorOWpKdmZYNDB1ZE9tTXZx?=
 =?utf-8?B?UTlrc3NoRmxPZ205ZVB5VGl2Z202NHhobG5NSFpvajFvVWF6RjRTdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b16814-322a-4357-d09c-08de51e34d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 14:03:03.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Rp9FsOrhVNYUAywoEW8iq5qNEctbLX3FibQr7UP23LEHT9Kc+4ZGY/V5o0o+yWwpgqZ4Q1GhO8+f9Whp+WSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690

DQoNCj4gT24gSmFuIDEyLCAyMDI2LCBhdCA0OjQ04oCvQU0sIFZpc2hhbCBDaG91cmFzaWEgPHZp
c2hhbGNAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79CdWxrIENQVSBob3RwbHVnIG9w
ZXJhdGlvbnPigJRzdWNoIGFzIHN3aXRjaGluZyBTTVQgbW9kZXMgYWNyb3NzIGFsbA0KPiBjb3Jl
c+KAlHJlcXVpcmUgaG90cGx1Z2dpbmcgbXVsdGlwbGUgQ1BVcyBpbiByYXBpZCBzdWNjZXNzaW9u
LiBPbiBsYXJnZQ0KPiBzeXN0ZW1zLCB0aGlzIHByb2Nlc3MgdGFrZXMgc2lnbmlmaWNhbnQgdGlt
ZSwgaW5jcmVhc2luZyBhcyB0aGUgbnVtYmVyDQo+IG9mIENQVXMgZ3Jvd3MsIGxlYWRpbmcgdG8g
c3Vic3RhbnRpYWwgZGVsYXlzIG9uIGhpZ2gtY29yZS1jb3VudA0KPiBtYWNoaW5lcy4gQW5hbHlz
aXMgWzFdIHJldmVhbHMgdGhhdCB0aGUgbWFqb3JpdHkgb2YgdGhpcyB0aW1lIGlzIHNwZW50DQo+
IHdhaXRpbmcgZm9yIHN5bmNocm9uaXplX3JjdSgpLg0KPiANCj4gRXhwZWRpdGUgc3luY2hyb25p
emVfcmN1KCkgZHVyaW5nIHRoZSBob3RwbHVnIHBhdGggdG8gYWNjZWxlcmF0ZSB0aGUNCj4gb3Bl
cmF0aW9uLiBTaW5jZSBDUFUgaG90cGx1ZyBpcyBhIHVzZXItaW5pdGlhdGVkIGFkbWluaXN0cmF0
aXZlIHRhc2ssDQo+IGl0IHNob3VsZCBjb21wbGV0ZSBhcyBxdWlja2x5IGFzIHBvc3NpYmxlLg0K
DQpXaGVuIGRvZXMgdGhlIHVzZXIgaW5pdGlhdGUgdGhpcyBpbiB5b3VyIHN5c3RlbT8NCg0KSG90
cGx1ZyBzaG91bGQgbm90IGJlIGhhcHBlbmluZyB0aGF0IG9mdGVuIHRvIGJlZ2luIHdpdGgsIGl0
IGlzIGEgc2xvdyBwYXRoIHRoYXQNCmRlcGVuZHMgb24gdGhlIGRpc3J1cHRpdmUgc3RvcC1tYWNo
aW5lIG1lY2hhbmlzbS4gDQoNCj4gDQo+IFBlcmZvcm1hbmNlIGRhdGEgb24gYSBQUEM2NCBzeXN0
ZW0gd2l0aCA0MDAgQ1BVczoNCj4gDQo+ICsgcHBjNjRfY3B1IC0tc210PTEgKFNNVDggdG8gU01U
MSkNCj4gQmVmb3JlOiByZWFsIDFtMTQuNzkycw0KPiBBZnRlcjogIHJlYWwgMG0wMy4yMDVzICAj
IH4yM3ggaW1wcm92ZW1lbnQNCj4gDQo+ICsgcHBjNjRfY3B1IC0tc210PTggKFNNVDEgdG8gU01U
OCkNCj4gQmVmb3JlOiByZWFsIDJtMjcuNjk1cw0KPiBBZnRlcjogIHJlYWwgMG0wMi41MTBzICAj
IH41OHggaW1wcm92ZW1lbnQNCg0KVGhpcyBkb2VzIGxvb2sgY29tcGVsbGluZyBidXQsIENvdWxk
IHlvdSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaG93IHRoaXMgd2FzIHRlc3RlZCAt
IHdoYXQgZG9lcyB0aGUgcHBjIGJpbmFyeSBkbyAoaG93IG1hbnkgaG90IHBsdWdzICwgaG93IGRv
ZXMgdGhlIHBlcmZvcm1hbmNlIGNoYW5nZSB3aXRoIGN5Y2xlIGNvdW50IGV0Yyk/DQoNCkNhbiB5
b3UgYWxzbyBydW4gcmN1dG9ydHVyZSB0ZXN0aW5nPyBTb21lIG9mIHRoZSBzY2VuYXJpb3MgbGlr
ZSBUUkVFMDMgc3RyZXNzIGhvdHBsdWcuDQoNCnRoYW5rcywNCg0KLSBKb2VsDQoNCj4gDQo+IEFi
b3ZlIG51bWJlcnMgd2VyZSBjb2xsZWN0ZWQgb24gTGludXggNi4xOS4wLXJjNC0wMDMxMC1nNzU1
YmMxMzM1ZTNiDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVmMmFiOGE0
NGQ2ODU3MDFmZTM2Y2RhYTgwNDJhMWFlZjIxNWQxMGQuY2FtZWxAbGludXgudm5ldC5pYm0uY29t
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgQ2hvdXJhc2lhIDx2aXNoYWxjQGxpbnV4Lmli
bS5jb20+DQo+IC0tLQ0KPiBpbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmggfCAzICsrKw0KPiBrZXJu
ZWwvY3B1LmMgICAgICAgICAgICAgfCAyICsrDQo+IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oIGIvaW5j
bHVkZS9saW51eC9yY3VwZGF0ZS5oDQo+IGluZGV4IGM1YjMwMDU0Y2QwMS4uMDNjMDZjZmIyYjZk
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgNCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9yY3VwZGF0ZS5oDQo+IEBAIC0xMTkyLDYgKzExOTIsOSBAQCByY3VfaGVhZF9hZnRl
cl9jYWxsX3JjdShzdHJ1Y3QgcmN1X2hlYWQgKnJocCwgcmN1X2NhbGxiYWNrX3QgZikNCj4gZXh0
ZXJuIGludCByY3VfZXhwZWRpdGVkOw0KPiBleHRlcm4gaW50IHJjdV9ub3JtYWw7DQo+IA0KPiAr
ZXh0ZXJuIHZvaWQgcmN1X2V4cGVkaXRlX2dwKHZvaWQpOw0KPiArZXh0ZXJuIHZvaWQgcmN1X3Vu
ZXhwZWRpdGVfZ3Aodm9pZCk7DQo+ICsNCj4gREVGSU5FX0xPQ0tfR1VBUkRfMChyY3UsDQo+ICAg
IGRvIHsNCj4gICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9j
cHUuYyBiL2tlcm5lbC9jcHUuYw0KPiBpbmRleCA4ZGYyZDc3M2ZlM2IuLjZiMGQ0OTFkNzNmNCAx
MDA2NDQNCj4gLS0tIGEva2VybmVsL2NwdS5jDQo+ICsrKyBiL2tlcm5lbC9jcHUuYw0KPiBAQCAt
NTA2LDEyICs1MDYsMTQgQEAgRVhQT1JUX1NZTUJPTF9HUEwoY3B1c19yZWFkX3VubG9jayk7DQo+
IA0KPiB2b2lkIGNwdXNfd3JpdGVfbG9jayh2b2lkKQ0KPiB7DQo+ICsgICAgcmN1X2V4cGVkaXRl
X2dwKCk7DQo+ICAgIHBlcmNwdV9kb3duX3dyaXRlKCZjcHVfaG90cGx1Z19sb2NrKTsNCj4gfQ0K
PiANCj4gdm9pZCBjcHVzX3dyaXRlX3VubG9jayh2b2lkKQ0KPiB7DQo+ICAgIHBlcmNwdV91cF93
cml0ZSgmY3B1X2hvdHBsdWdfbG9jayk7DQo+ICsgICAgcmN1X3VuZXhwZWRpdGVfZ3AoKTsNCj4g
fQ0KPiANCj4gdm9pZCBsb2NrZGVwX2Fzc2VydF9jcHVzX2hlbGQodm9pZCkNCj4gLS0NCj4gMi41
Mi4wDQo+IA0K
