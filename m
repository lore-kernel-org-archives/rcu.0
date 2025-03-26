Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2A25DD12;
	Wed, 26 Mar 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029467; cv=fail; b=rY/OZwnvaGz6nAeHA+mDfmtOWA0C7Gc01k+Ga28Kyu/JWJhfCM6OrA2qFLb4xbKeM4LOe8vzTKUopzaGmQYOt/DgbzhCLeXwtVbncz7+Xf8PT1csTZMb6FXoTiJd+5fWYp0Ibj+LSlHWrUjOOPSXecvCAivPZMCVQcrVLWv8NhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029467; c=relaxed/simple;
	bh=QzStrm5NpjTCY6CgNLxjRudHh2Kw/QtFxfFIUaNqSSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fw7tSOJPnOr4tC5MGpFkvu+J3Fxx9VOVP2p78/DX3d/C2miMLxnF3IMPocw/KODBgyZgSxKV9UHb58+nFupNcCL4Q04E0QT8TuwAROzkJpWUk5hWqvB5GqxMJx3k7sYNtPJ9jfXDcG7AGYdG8ufSyVn3pNw6PiFBKxUn/ba6vFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4GJ3GkU; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4GJ3GkU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ71M/ygX1k4aPTeAh2FsYlN+yV/OFkPK4K+jyExAFy2vH4E0lzG2JnBgGSqUVNBwZfSPfHcX8jAPAfu8ITH8yJkX4PYKeFaSNzGmi4GMJW7eWimOlj23YDAvWSCRs4gUptM5yxGllcyGOe3Ovje1MM9Xo40gwTslbPq6XA7uc98Ma73vkObuZg6X6ROe936IFW9CLCe3OBP5SPbG71+HF+i9Z1+0lYlFoq4f4CrK6PFX5N2cc2K1iD8yG2Mu+qKMLn48glaRSOkshBoF67y6rdSG5du2NuGcXge9+xfN0mPeGJAw04TiiPfgDBxx8i8aX5Ei26ZWwQYgM9zjDCCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzStrm5NpjTCY6CgNLxjRudHh2Kw/QtFxfFIUaNqSSg=;
 b=moMypFNEe/RIJQloplmoQ+Ut6ozWY7ohKllaBxwgcAHVptV7o5zIFi98c9PWWRfMkdiddprU+aqFIQA1hyhyZhSqcJyGo/1dRz+u3gLHy/cNrPQWHjBbTEMOP6UNd4pnBaVyjlZpfYEhEDkgsVHkIrA+HDYh4z3ObpFMxWfueNMrfA2LeMd/WjDePqAOTZNqMSZQ2YJ4v6DC6c7mMJsz7KUUkkFhHnoLH/rYP/1kNYHh6HhnEhxP78u7BFDHdacSUduwqrfyGpTPCXYscWLPVTFz9XK0d1UartvXAd3W5r9tXOdleB/YHuY44TT6Y+pUpKOc+Pn/+iCGqNSr+wvrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzStrm5NpjTCY6CgNLxjRudHh2Kw/QtFxfFIUaNqSSg=;
 b=B4GJ3GkUDdg8tq0VipMQ4j0YLYMnaHiT34O9OjFTlBbhQoEZec7u1tKJepsuv9zCa1OLFjjYWlVuMEDvolv41AAjcwDXI6jAWy7OXg5JaINQW+y7SXs0f58V6883JdoJiG6urUihK0HnE6j83zyP0xaBPQFbdaffepquKDg9QkC5CGt1gv+2lmx1yTcZrMFfIqYKuemE3Rucxjj7mNJqXeGWAgfVx2CTZpA3d4q7tYFhnheFiOsQv1jYr46oPg4YjBREARV2GvAQEXF41B3IItVcOrUUfgsG3cHdPui+06Q3xOPSsjNnG8Qtaqnp4jyIi9iPmlyuHFKYraXi8eIRWQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 26 Mar
 2025 22:51:02 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 22:51:02 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Thread-Topic: [PATCH 3/3] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Thread-Index: AQHbnN59ISZP2m47nECSqRE3ucMewbOGBaWAgAADt6Y=
Date: Wed, 26 Mar 2025 22:51:02 +0000
Message-ID: <1763F3DA-431E-4933-B536-1F921F03E573@nvidia.com>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-4-joelagnelf@nvidia.com>
 <925905dd-e87e-497f-8723-f1f2ca6ecb12@paulmck-laptop>
In-Reply-To: <925905dd-e87e-497f-8723-f1f2ca6ecb12@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
x-ms-office365-filtering-correlation-id: 04593faf-26c0-4c07-0d5b-08dd6cb8af28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1JxcXJkSGtNdmJLenQzVTdTOWxDdXh5MmoyejJ4WC9oczRLNnovVUdPdFBD?=
 =?utf-8?B?MFZ0Ny9jM2YzM2JkUXZ5MDlhQ21qTXNyQXczU0tHOXJiTG01elNQWXhrdnlV?=
 =?utf-8?B?eWk5L2hJU2lvVmc0RGtONmhxSHo1d0FmZUxoV08xMWF5VHlDeGFMSzhYYnRX?=
 =?utf-8?B?V3JxM3lXNFF1RG5YeW8rVnFLZXYvTzNCak90djBlVXVBNlFxcE5NczAxN1k0?=
 =?utf-8?B?em05OU5ZMmdWNzJTT3VNa3VhMDQwRlNnN2FrTmY1VWZuaFdBWFV4cGQ1Tm02?=
 =?utf-8?B?N2NkVVFiL3l4c2Ixa0Jld1FpWkRMSlM3eXFvaFoyWDVVWjlFSUl1eVdIVTY5?=
 =?utf-8?B?SWpFMDJmbVdHMmZDUVo0NkVMVjZWcjlIcktkWExuS0J1dythTkozeFZlSFdS?=
 =?utf-8?B?OTgxc09xVzVvVjdhR2lQWlVOeHpOakxjNUEwMXpKSURkV0tKQmxiNWFYTjFB?=
 =?utf-8?B?S290c1NqM2Z0akZoRkg2cGtTVndzbXM5V2h3cGVCUG8ySDA4bmpSaHo3STN5?=
 =?utf-8?B?R08zNVJwQ0lYeW9tSXQwelYwditNdy8vTHNLelRXMzVqRC9oQWhBazBPRDk3?=
 =?utf-8?B?K2tFYjltOUNUTHhyckVyem1PaHp2dmVxdnlVSDhETG91M01keEFCRktMb2p5?=
 =?utf-8?B?NEhFNUN2dC9XSkNBdmNtU0lwNjJvWkF3YUNTd2xlN25GSUxvTGpjY2pJRFFE?=
 =?utf-8?B?QitSUjl5NDhDNDNHamhpcFQ0WDlGckFtUXlvQWFJK2VFTm5DbzMzS1gzSVFL?=
 =?utf-8?B?bUFlYzhZZjJ4R0Y4SmVTTVh5bWpKZ0RYbXBvTk9GWDJxekY3M0orZk0weEkw?=
 =?utf-8?B?M2p1ckRBN1RRbjJpcWJleGo4bVBwQ1pMa3FUeDI3UnV3RlBiaGJZdDVYbFRD?=
 =?utf-8?B?OE13NFQvMUNzdnJib1FwNDBzaXBTaEtBN0xEWnBNWGdBNzU0QWNXT1VBdEVy?=
 =?utf-8?B?QVFNbW5OVE5wK2FRSUk0VEFHcEVmOEtBdUtQZDl1azN5RU8zT0VTM1luUFBo?=
 =?utf-8?B?L0ZHL3ozU0I1MVlKYkJ4aGdYTW1hSklWY1JvUzFDbFdBc0JlK2lsRjlpUzFJ?=
 =?utf-8?B?cnB3SDd0S25XRU1zMGtRcThKZjBFZU5oR21wQit4Smw4ZHBjSE0xdkQ1NnpK?=
 =?utf-8?B?bFBhY1Y3Smk3OWM1VHFzSWNVOVVCZWR0UkN1N0VOQk11T21xV2Z5a25zTW5N?=
 =?utf-8?B?TEN5T2JzVWo2U3ZiaUxDRHRBaWsvSndub2hOdmVUMjNYL1JIRWlhbVpScVlE?=
 =?utf-8?B?L0Vaa2lLS0pMdmhFSjVzWmx1eDYrcDBxQ0QyTXZabGZza0E5WmxiL1hWNXVt?=
 =?utf-8?B?TFlKVzljdEdFZUVEQ0k4cFYvK01yeE1lcHgya0tkS0dDSE1FZGJHSFdadlJ1?=
 =?utf-8?B?RUtGM2JXTEczVDFFQWsxdFlBcVBNakU5QU12aHl2NWVRNWpyempFY2s4N3h0?=
 =?utf-8?B?QnBPaU5UVzlORlNMcjdockNjT2JrOUJkWEZ2ZzlDd2NBQWUwaWc1YytFOSs2?=
 =?utf-8?B?SFN6aEcwbzVoK2JOSk9XenRUek1qdVdTRVR3T2pTSWtNRnVuS2ExcCtsempp?=
 =?utf-8?B?cEJpZ0pIQnMxNVFiZlF0OFRyMU5xVm01aUs3a1IyVUdOVUQ5YStZK00vdHRn?=
 =?utf-8?B?ZmI2SUVSc1RCZDlUc1JqN1lpem9nWmtDZXJhSmVUVytoeWVwWmxqbXdzMmRD?=
 =?utf-8?B?Q2RhMElHM1JjRXNrbEQwZUpaNVRFbUNNTEVEVmdaRUVqaHN5RVpYSHo2Sjhj?=
 =?utf-8?B?T2laUVAvR1l4L3RqWnpYRWMzcE9YYVc0T1NUZ3lRTDNFSU53QlVsdDA4QU45?=
 =?utf-8?B?KzNGR3FmbGozeC9IdmJZckE0V0lEVGpUU21zT2t3OVJKUFRrcUdsTTJsdWhy?=
 =?utf-8?B?UkV4TVN6S1BTQkZScGtEWVJ3OXl2SzlGa0thaEJmWlk2RnhFdVlPVmRDMFUy?=
 =?utf-8?Q?QNLIPQBm46ljKNyATGOFO7i0+DU4u+v9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkZkenZwSlZlc0xVU0Y5VU8wTzZkQmlzNEFVTE15RGNSaUxEWUlQQmkzQkQy?=
 =?utf-8?B?M0ZaTTdheVdlaEFPdkxpOThNV0lMamU5Zm1ETHhZd3BTclJSY2JDNXFnNm9P?=
 =?utf-8?B?N2o3UEdQVHB5ZWxJMkJiU2gxL1l4bHUvWlRteFNDTTFQMWlVdmJPUDNVUm5T?=
 =?utf-8?B?WGZGcnY4TWpOSTVPeU93ZnBSNCtVS3YveXpPQS8wWDlGNEhRSGd4QjcwUk8v?=
 =?utf-8?B?b29SVEQzNHhJVklwTGtNelFTeFgxOHdPN3JxaHdLUlVVQlBuWXh1SUF4YmZs?=
 =?utf-8?B?dW1lUEJwNjVTSEZsazVKS05jdEJFcnN2cUJrQ2Z4d0xMd3FWNno5aVNhY2p2?=
 =?utf-8?B?TjZJSjdna1VRWFNwMWhoUERDZGFETW1sZEl6RHFBdTNwWVRFdWpoQm12TW95?=
 =?utf-8?B?ZTBDQWlaYW1MRjJXSTh0WUpaM0J4bEVEc2grWm1mSlNONmREMzk4ZEZPY0ov?=
 =?utf-8?B?amVac0JrRzQ0b0crbWhFeWM2elBRd01MK09JKzduV25ZYy9CS1lBekg4MHVt?=
 =?utf-8?B?ZGM5N3hsZUlheVdRWUtlci9LSDJoWVNBK2V6QXBMQ0ozejVhK0ZOeEZqRjFi?=
 =?utf-8?B?Nmw0VXdBVTBrS0VOaWNMT3QxS1VxY1hMbG1UY20zNWdBRjlQMEFTM3Y2OWFP?=
 =?utf-8?B?QUZld1E5eHdKc3d4REZKMTlRMkRtUjdTQTdnRXUxSGRQRTFscFhQdWk0K2N1?=
 =?utf-8?B?NkVLMVRQcDlkWVQ0ckpsYUFUbmloSnBkclpGTllGeEl0Mnp0MldXbC9wYjBp?=
 =?utf-8?B?Mlc2VUNyYyt5NzBOeFcxSzc2NWNBeVZRRUZOSHBxa0g3VlFVRW9RUGhZYUhU?=
 =?utf-8?B?QjV6NGkvRlkzcXF6MDJHSlpZcGVzODZZZ3ViRXNnSUpVNFJ3WWdHaHdiZDN1?=
 =?utf-8?B?Y05odFM0Mi9WWE4xTDk1djVZZzhhMUsyWlVPUjNjWGVKdG9DYWFmODMzZWxi?=
 =?utf-8?B?bWR2NzJCVytKS2xSWk9aR21mUjloZkdvZ2JzMndtMGZNOHdPMlBPZkptSE5w?=
 =?utf-8?B?SzlzZUkxTngrYTJIK040RzdLSW1YUFlhUzJqMDdvUlBvZTZRM3Fmdm5ZQnd4?=
 =?utf-8?B?bVlYN2J3ZDVUQWRTVi92Nk84WFhLQzNVNkJlV3BBYXVZOGl0bU9kM1pKZnpk?=
 =?utf-8?B?eTdReW9aK08razFxMTUwWk5udVRUWlV2M0wwY2NLaHJGam14b0MrdHpBeTVx?=
 =?utf-8?B?MjZqWmlsYXQ4NzRtWnhJdW5SUkNXRmJEdHIrdGRUVEtrdVhUWUxxd3RDZDls?=
 =?utf-8?B?UnlTUW50QmZzQXRXNWEyMkZlQkFFUjgyWmZ2VkEvSGxORlZSOElmQXlDY25Z?=
 =?utf-8?B?VlJMTTdLZUZtTEtPRDZsZHZ5a25GejFtTHpFak9ZK1Y3cTAxZEFmSUhSSnpm?=
 =?utf-8?B?L3BSRE1yZDNrVHZ4UFJiTmNER0xjMmR2YXFEL1MxNVU4Rk5PRWNDQXM3QWZU?=
 =?utf-8?B?VXlaRzFCK1BMODhnVGNWaDhUMVdaMFNmMElWU0tTY3JBV254SWQzZjZIUFgv?=
 =?utf-8?B?dGU4TTVKempWVkpxTmZLMkw3M0ZacFArcTNKZk5aV0hFTWt3eFF2ckdjVTJS?=
 =?utf-8?B?R2ptamwybVZCM3B4VE9LNitEck5HaEluWk95ay93WkJ4NlFWbUlrRlNoRGlQ?=
 =?utf-8?B?bUJvTUgzUTJTaFREczkxUWFEZWFyN0FXdzVHVDZSMWxEYXlvZEIvejdUWkcr?=
 =?utf-8?B?czFGZkJMa2hlVXRRWmhwUTVyb0M0T1QyVDhDc21oNEVvQ05ibjF1cSt6Y2Ja?=
 =?utf-8?B?M3ZaRDNjQ3JmZThKQ3g3dldzVTF2M2NmekJXdFdxSDNZMlZVQmFXU2lqVjdS?=
 =?utf-8?B?OTg1VjhyNUY4VDZXc3lTOXNFU3pySUFKV1hkYWx1V0xyTkIwNU4xejlxRUx3?=
 =?utf-8?B?bS9ucHJqb1N4SERXS3E3cDhURVRod2JicWZXNWpocnJ1L2RHVFlYREhtQ2xG?=
 =?utf-8?B?YktnblVsWEZqd0IyNmV4dFZwdjNJZFk3TmNPcTNYRGxFLzVzS0txVkZadER0?=
 =?utf-8?B?ay9pNlR1dGdRbzZDd0JqSE84SzNnNllwdnUrbXpQMm5xNmFuYlpkOXh4ZEw5?=
 =?utf-8?B?OFNWL1hVbDlvelc2dFI2T3cwRThpbFgxSU5NSG1HZFltc0Z6V2g0ZWlYWUdr?=
 =?utf-8?Q?Fcob2iEUAWzwrbhldN4Cep481?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04593faf-26c0-4c07-0d5b-08dd6cb8af28
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 22:51:02.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVYX/W65gqzZCkl93Hilai52jgIZn6J8OhCZNoQ36feNMMDH0B1IDHZ4aLAkiay/yGH8nRf+dTJXfjGD5JdDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

DQoNCj4gT24gTWFyIDI2LCAyMDI1LCBhdCA2OjM34oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIE1hciAyNCwgMjAyNSBh
dCAwMTowMTo1NVBNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IEZyb206IEZyZWRl
cmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+PiANCj4+IFRoZSBudW1iZXJz
IHVzZWQgaW4gcmN1X3NlcV9kb25lX2V4YWN0KCkgbGFjayBzb21lIGV4cGxhbmF0aW9uIGJlaGlu
ZA0KPj4gdGhlaXIgbWFnaWMuIEVzcGVjaWFsbHkgYWZ0ZXIgdGhlIGNvbW1pdDoNCj4+IA0KPj4g
ICAgODVhYWQ3Y2M0MTc4ICgicmN1OiBGaXggZ2V0X3N0YXRlX3N5bmNocm9uaXplX3JjdV9mdWxs
KCkgR1Atc3RhcnQgZGV0ZWN0aW9uIikNCj4+IA0KPj4gd2hpY2ggcmVwb3J0ZWQgYSBzdWJ0bGUg
aXNzdWUgd2hlcmUgYSBuZXcgR1Agc2VxdWVuY2Ugc25hcHNob3Qgd2FzIHRha2VuDQo+PiBvbiB0
aGUgcm9vdCBub2RlIHN0YXRlIHdoaWxlIGEgZ3JhY2UgcGVyaW9kIGhhZCBhbHJlYWR5IGJlZW4g
c3RhcnRlZCBhbmQNCj4+IHJlZmxlY3RlZCBvbiB0aGUgZ2xvYmFsIHN0YXRlIHNlcXVlbmNlIGJ1
dCBub3QgeWV0IG9uIHRoZSByb290IG5vZGUNCj4+IHNlcXVlbmNlLCBtYWtpbmcgYSBwb2xsaW5n
IHVzZXIgd2FpdGluZyBvbiBhIHdyb25nIGFscmVhZHkgc3RhcnRlZCBncmFjZQ0KPj4gcGVyaW9k
IHRoYXQgd291bGQgaWdub3JlIGZyZXNobHkgb25saW5lIENQVXMuDQo+PiANCj4+IFRoZSBmaXgg
aW52b2x2ZWQgdGFraW5nIHRoZSBzbmFwaG90IG9uIHRoZSBnbG9iYWwgc3RhdGUgc2VxdWVuY2Ug
YW5kDQo+PiB3YWl0aW5nIG9uIHRoZSByb290IG5vZGUgc2VxdWVuY2UuIEFuZCBzaW5jZSBhIGdy
YWNlIHBlcmlvZCBpcyBmaXJzdA0KPj4gc3RhcnRlZCBvbiB0aGUgZ2xvYmFsIHN0YXRlIGFuZCBv
bmx5IGFmdGVyd2FyZCByZWZsZWN0ZWQgb24gdGhlIHJvb3QNCj4+IG5vZGUsIGEgc25hcHNob3Qg
dGFrZW4gb24gdGhlIGdsb2JhbCBzdGF0ZSBzZXF1ZW5jZSBtaWdodCBiZSB0d28gZnVsbA0KPj4g
Z3JhY2UgcGVyaW9kcyBhaGVhZCBvZiB0aGUgcm9vdCBub2RlIGFzIGluIHRoZSBmb2xsb3dpbmcg
ZXhhbXBsZToNCj4+IA0KPj4gcm5wLT5ncF9zZXEgPSByY3Vfc3RhdGUuZ3Bfc2VxID0gMA0KPj4g
DQo+PiAgICBDUFUgMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBD
UFUgMQ0KPj4gICAgLS0tLS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0tLS0NCj4+ICAgIC8vIHJjdV9zdGF0ZS5ncF9zZXEgPSAxDQo+PiAgICByY3Vfc2VxX3N0
YXJ0KCZyY3Vfc3RhdGUuZ3Bfc2VxKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLy8gc25hcCA9IDgNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNuYXAgPSByY3Vfc2VxX3NuYXAoJnJjdV9z
dGF0ZS5ncF9zZXEpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvLyBUd28gZnVsbCBHUCBkaWZmZXJlbmNlcw0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3NlcV9kb25lX2V4YWN0KCZy
bnAtPmdwX3NlcSwgc25hcCkNCj4+ICAgIC8vIHJucC0+Z3Bfc2VxID0gMQ0KPj4gICAgV1JJVEVf
T05DRShybnAtPmdwX3NlcSwgcmN1X3N0YXRlLmdwX3NlcSk7DQo+PiANCj4+IEFkZCBhIGNvbW1l
bnQgYWJvdXQgdGhvc2UgZXhwZWN0YXRpb25zIGFuZCB0byBjbGFyaWZ5IHRoZSBtYWdpYyB3aXRo
aW4NCj4+IHRoZSByZWxldmFudCBmdW5jdGlvbi4NCj4+IA0KPj4gTm90ZSB0aGF0IHRoZSBpc3N1
ZSBhcmlzZXMgbWFpbmx5IHdpdGggdGhlIHVzZSBvZiByY3Vfc2VxX2RvbmVfZXhhY3QoKQ0KPj4g
d2hpY2ggaGFzIGEgbXVjaCB0aWdoZXIgZ3VhcmRiYW5kIChvZiAyIEdQcykgdG8gZW5zdXJlIHRo
ZSBmYWxzZS1uZWdhdGl2ZQ0KPj4gd2luZG93IG9mIHRoZSBBUEkgZHVyaW5nIHdyYXBhcm91bmQg
aXMgbGltaXRlZCB0byBqdXN0IDIgR1BzLg0KPj4gcmN1X3NlcV9kb25lKCkgZG9lcyBub3QgaGF2
ZSBzdWNoIHN0cmljdCByZXF1aXJlbWVudHMsIGhvd2V2ZXIgaXRzIGxhcmdlDQo+PiBmYWxzZS1u
ZWdhdGl2ZSB3aW5kb3cgb2YgVUxPTkdfTUFYLzIgaXMgbm90IGlkZWFsIGZvciB0aGUgcG9sbGlu
ZyBBUEkuDQo+PiBIb3dldmVyLCB0aGlzIGFsc28gbWVhbnMgY2FyZSBpcyBuZWVkZWQgdG8gZW5z
dXJlIHRoZSBndWFyZGJhbmQgaXMgYXMNCj4+IGxhcmdlIGFzIG5lZWRlZCB0byBhdm9pZCB0aGUg
ZXhhbXBsZSBzY2VuYXJpbyBkZXNjcmliZSBhYm92ZSB3aGljaCBhDQo+PiB3YXJuaW5nIGFkZGVk
IGluIGFuIGVhcmxpZXIgcGF0Y2ggZG9lcy4NCj4+IA0KPj4gWyBDb21tZW50IHdvcmRzbWl0aGlu
ZyBieSBKb2VsIF0NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8
ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxw
YXVsbWNrQGtlcm5lbC5vcmc+DQo+IA0KPiBMb29rcyBnb29kLCBhbmQgSSBzdGFuZCBieSBteSBS
ZXZpZXdlZC1ieS4gIDstKQ0KDQpUaGFua3MsIEkgd2lsbCBxdWV1ZSB0aGlzIG9uZSBmb3IgNi4x
Ni4NCg0KLSBKb2VsDQoNCg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngs
IFBhdWwNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBu
dmlkaWEuY29tPg0KPj4gLS0tDQo+PiBrZXJuZWwvcmN1L3JjdS5oIHwgOSArKysrKysrKysNCj4+
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9yY3UvcmN1LmggYi9rZXJuZWwvcmN1L3JjdS5oDQo+PiBpbmRleCA1ZTFlZTU3MGJiMjcu
LmRiNjNmMzMwNzY4YyAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yY3UvcmN1LmgNCj4+ICsrKyBi
L2tlcm5lbC9yY3UvcmN1LmgNCj4+IEBAIC0xNjAsNiArMTYwLDE1IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCByY3Vfc2VxX2RvbmUodW5zaWduZWQgbG9uZyAqc3AsIHVuc2lnbmVkIGxvbmcgcykNCj4+
ICAqIEdpdmVuIGEgc25hcHNob3QgZnJvbSByY3Vfc2VxX3NuYXAoKSwgZGV0ZXJtaW5lIHdoZXRo
ZXIgb3Igbm90IGENCj4+ICAqIGZ1bGwgdXBkYXRlLXNpZGUgb3BlcmF0aW9uIGhhcyBvY2N1cnJl
ZCwgYnV0IGRvIG5vdCBhbGxvdyB0aGUNCj4+ICAqIChVTE9OR19NQVggLyAyKSBzYWZldHktZmFj
dG9yL2d1YXJkLWJhbmQuDQo+PiArICoNCj4+ICsgKiBUaGUgdG9rZW4gcmV0dXJuZWQgYnkgZ2V0
X3N0YXRlX3N5bmNocm9uaXplX3JjdV9mdWxsKCkgaXMgYmFzZWQgb24NCj4+ICsgKiByY3Vfc3Rh
dGUuZ3Bfc2VxIGJ1dCBpdCBpcyB0ZXN0ZWQgaW4gcG9sbF9zdGF0ZV9zeW5jaHJvbml6ZV9yY3Vf
ZnVsbCgpDQo+PiArICogYWdhaW5zdCB0aGUgcm9vdCBybnAtPmdwX3NlcS4gU2luY2UgcmN1X3Nl
cV9zdGFydCgpIGlzIGZpcnN0IGNhbGxlZA0KPj4gKyAqIG9uIHJjdV9zdGF0ZS5ncF9zZXEgYW5k
IG9ubHkgbGF0ZXIgcmVmbGVjdGVkIG9uIHRoZSByb290IHJucC0+Z3Bfc2VxLA0KPj4gKyAqIGl0
IGlzIHBvc3NpYmxlIHRoYXQgcmN1X3NlcV9zbmFwKHJjdV9zdGF0ZS5ncF9zZXEpIHJldHVybnMg
MiBmdWxsIGdyYWNlDQo+PiArICogcGVyaW9kcyBhaGVhZCBvZiB0aGUgcm9vdCBybnAtPmdwX3Nl
cS4gVG8gcHJldmVudCBmYWxzZS1wb3NpdGl2ZXMgd2l0aCB0aGUNCj4+ICsgKiBmdWxsIHBvbGxp
bmcgQVBJIHRoYXQgYSB3cmFwIGFyb3VuZCBpbnN0YW50bHkgY29tcGxldGVkIHRoZSBHUCwgd2hl
biBub3RoaW5nDQo+PiArICogbGlrZSB0aGF0IGhhcHBlbmVkLCBhZGp1c3QgZm9yIHRoZSAyIEdQ
cyBpbiB0aGUgVUxPTkdfQ01QX0xUKCkuDQo+PiAgKi8NCj4+IHN0YXRpYyBpbmxpbmUgYm9vbCBy
Y3Vfc2VxX2RvbmVfZXhhY3QodW5zaWduZWQgbG9uZyAqc3AsIHVuc2lnbmVkIGxvbmcgcykNCj4+
IHsNCj4+IC0tDQo+PiAyLjQzLjANCj4+IA0K
