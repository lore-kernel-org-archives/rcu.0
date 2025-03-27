Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4AEEA9;
	Thu, 27 Mar 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095324; cv=fail; b=uJCbBKsMXnmWK9oTa9HJgdv8dYsQcaNoCZjSLFRVGZz8D0pOwOv5YhQJHKSKakPTLmeJSRo+m8MNxqyLuBFER7HVKdiog84rJrtEQMfTJILQhhZQiUEmAa5jvZFG8lvTz7KCsRGs0pmy/k+B/cpVIIUJclRlAZ0Vgl1uhVPDXm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095324; c=relaxed/simple;
	bh=+cu/fhdRm/d3s6Da53LhqeOl1p+jKyPCp07q3L0gCu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=syCv4ygIRxIEfJ2w82TD6IrJ03yLxfybsJk8LFPDjNwBBbMLB3k4yPHWUCEnTMIW+6/mQYvjZ+lf2udcjCbDzGhllxIPu9HinJESKcbKhmd8MTlg4fpM+SehwcGZrjjn4G66mG1Xd+x+/lDadMXzMZgVJTe5tOcpYo7eY76Cf90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1X4dJmU; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1X4dJmU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrKh5qC6UCwoI96ecbcvdCpp3916zqzTccPDEvyZBJWMO/sbOGVrujki8kQhbStfAOXEUFhyqL/5hu2yUWN672KCk46OvEh/g0DvqCJ8to2f6DPUcaiyMezjzxAeLrq+xzDJUvtCed1ZyfpaXjBQqCXQhhXlgnSBwAczNrLo7ibxcv0WQsLvDpM6scdH/v6EKM3qsILbhtxLpvSFEcmGFr/68nel8K/5ulahG+RzyTg7PwyN8KreHeDKdr4oOqEQzHYWPkax/WkFcZblVbkNTKLy6JzKnNLDWyj68utnr7BHhWweMFGSzs+LWd9kBsAT7FzHKyOiNLynhosvZTRrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cu/fhdRm/d3s6Da53LhqeOl1p+jKyPCp07q3L0gCu8=;
 b=gKRvx/IabU9YAfkmm1ot6Q/DDVEGOBtsKmRm0KR8pSv+DA/pihciYVeyNZnvHmBF7jVUd1f/sKUJPSeETYhs8sVUyFJDhEtQ7lM6VQ7S0UARX2u9nlp8tlup1xpFwMAVAii0ZgP9HxnLgIsiL0Y5m+nGqfE/kFyi+hfCDAR7F1kFwm4Q7VsxpwHgGBEVOiZwhiFd4+G67jOIfUo81Y+Q8Lexx85b5yElGzgm6M3LRd0bOrCaPN7U8L6Ly1cW46AMDt4gstXzWvUEXyf9LcYAmIQuteHlArPCOU7s9qBHz4Bof8uiAGTq1QubydukCmVKPV3rLiNVMaGU0NL/uFDQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cu/fhdRm/d3s6Da53LhqeOl1p+jKyPCp07q3L0gCu8=;
 b=k1X4dJmUy7g7L1M0r7giVx9DQgl/YV5jYnU3ASCcvRDxczfRQUpEchT62tMukx4HlM2h457WQX50OWqn65UPKBo2TyiGj6QXG8ibzmXmenIqqrVEHmlLGGhX68LFcbT+3H9PoTvALZirZgwIFyU82E4Y4V4gxrNX28UOqt22uTPt1H2cTLDfpi0gTIKJ5FPx6VHQSbtvW0+fumppTurr7yWGrgTOHA603vZWu5PJA+DnLqokoFxEMCft2oqKFIDWDp2ys5s5qmOYDjgI2PPi+uaXbaSzuEqA8/Fl4J+cTKSi43sNjYaqGEXkBxXKTgpbh+rZa31+aF/0+fFlEqQ82Q==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:08:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:08:35 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: qiang Z <qiang.zhang1211@gmail.com>, "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader
 primitives
Thread-Topic: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader
 primitives
Thread-Index: AQHbkeuhrgpwA5NJIk+aTeTN8ez/Y7OGbBWAgAC5qACAAB81AIAAB1uAgAAFmxs=
Date: Thu, 27 Mar 2025 17:08:35 +0000
Message-ID: <1F552A07-5799-4228-ACE2-0A8706F1D814@nvidia.com>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
 <20250310183809.3576320-5-paulmck@kernel.org>
 <CALm+0cWn_wh_QnR0k-QDVTwgdBdXTEd1Xtk5SM+T27ejCchPJw@mail.gmail.com>
 <762ee713-a38f-49e5-aa4a-57e4a4da687c@paulmck-laptop>
 <9ac94cda-3962-44d4-80e7-94555b104cf2@nvidia.com>
 <f7349c37-1496-4d23-8863-3cb75b538a23@paulmck-laptop>
In-Reply-To: <f7349c37-1496-4d23-8863-3cb75b538a23@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|CH2PR12MB4182:EE_
x-ms-office365-filtering-correlation-id: 15fad16b-91fd-498e-fffa-08dd6d52025e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UU9PZWFrNHVhWG94T0NwNFdYc1JsUENWb3lleG4wZDBvTzAyNjI3Ynd6dGUv?=
 =?utf-8?B?MWlhSHUzSmt0MW5wTGNwekwxeVY4ZFpwMlBLRjBYYUF5d29hSWpJNGFjNHNU?=
 =?utf-8?B?TFJYUEluZ052MS9kK0Z4dVFtZTVKeEJYdURjVnczZjFmMFJ2SnN3RVRkTi9O?=
 =?utf-8?B?THl5OE95blJ5MTRIWXdUN0xhTE1URlJpQlZXTC9Ua0NJZ0ZjRnlzWmN6Sjhs?=
 =?utf-8?B?TTU0UDVLdjhoS2JRWkp0RVljTXV4cjhSNkF6QVBHSEphbFl6M09VdWduYkRo?=
 =?utf-8?B?Q3pCeVVzNSsvNktGZVBLYUJtRXJ5NDdFQVR1UGduUGNCRXhHK1BmRmNTKzZa?=
 =?utf-8?B?SkFsK29aREhGc2EyQXI1UituZy9tdWFqeTFXMS9IQWdGVFdsRXZMVnRkRW1D?=
 =?utf-8?B?Tk9CU3F1cU45U01MRVVFcnB2Zm43K0huVkpHMmgyK0RoWlBvSmZyMHU4K0xi?=
 =?utf-8?B?VldxUTF4WXFVZXMxVUp1UmVJbDVTZGd6V0E5cGdRaUUrc0dTOE9OU0tKdjZT?=
 =?utf-8?B?cUw1UUx5dkIxVlJqVGtacFNxQUVGanM3R2M0Y3I2aSs2bXVnOWJ6ZVV0MjRp?=
 =?utf-8?B?Z2V2dG9md0JySlFoQndtRHFzeHl5ajU4N0krMGNhOCtqdlVEOHIwUUlQSEdO?=
 =?utf-8?B?cG9TMWxQeEJ2eS94aFZ1LzFyanF5UThlditMTFlZcnEwM2dRMGRZc0lUUFc5?=
 =?utf-8?B?K012NjJRNDlJOS9EMG9GNjJ5VlZOdFA5TWZlOWlERnJGNW9PcHIvV05WeG1B?=
 =?utf-8?B?ZjZ6bFdwaDhyTGx4SngraG8xa2lrRzd0Q09GV0hoOExJTktCcVpFZXNnR3Fp?=
 =?utf-8?B?amkzUTQ2MHRsckpCb243RXZ3bHpPcmZSbzNscEZJOFk3V014amtwOWY1Wm84?=
 =?utf-8?B?c1ZhdWdycDVWR2VNTnhqV0JrSmRvMCtIZ2dWUGNZZTQ3a0x4TGNrTXVqMTU2?=
 =?utf-8?B?M1l2SERSVUhuZmFUWnhIOE1JZEdnV0VTZTQ4NllSWGkrYjBWRUlGRFZZaXFx?=
 =?utf-8?B?R016OTdVQkVTYkZuczFrc2hPZWtJaGJhWFZLSHJQNjBnVFFvY2F0SUpXbU13?=
 =?utf-8?B?V3ZaSEJNM01nck9IZzdiZFdCQk1EaXVVVDE5K1czcGVFNHM0YjJrelZPOGFi?=
 =?utf-8?B?TzVnVGZHZHVOR2laZkFHVlZpYnBlZThVd1d6emdkbTJVL3JGSDBRVFIzT2Vo?=
 =?utf-8?B?V1cvTjkvbW5rR3pQV0NkaytQUndlelBUb1pTaVNNRnBFcUtSOTVHOUoxS3M3?=
 =?utf-8?B?Vktaajc0Q3dtNkFZNkpIbmt6eXBHZm1DckE5QWRtS3FSTGZpWTZtNzd5RXRM?=
 =?utf-8?B?MmtjbUFBNGxHbEhqclMzZDVKQnVQZEtsRHhqWTJnSjlpdmJ1SWUxeUN4SE9I?=
 =?utf-8?B?b2Z2VExmQk1lbUtPcGp2eXY4cC9PTUZvb0NuVmtJeDFhaGhuRk8yWFd4U0o0?=
 =?utf-8?B?RVh0enRybmxpOXkxamtBbC9aRnJUMzU2QTdIVlM3Z09QeEF5Y3ZiMEJhcUYr?=
 =?utf-8?B?dEx2bGlLL3VVa1lvb1l6ZFpuZHAvTEM0SlFlWlFaa1dNRkREeW85TjdRZWw4?=
 =?utf-8?B?RE02RnlGOG8ySkJBNTJ0WkNzbGNGdFVNUDdlR3lCSWVrdmVob1hBclhJdnM3?=
 =?utf-8?B?b0Q3KzJ2eFVPdEZua01GcW5PNkgrRDFkZ0lFR3hTZ3p6NHdaSTUxOGtGbnE2?=
 =?utf-8?B?ZVNRRHIyZnZYVDV0eC80cFhFN09vaTVKTnZGU2VvNEFyQkc2b0VQaVZSUzBM?=
 =?utf-8?B?OXVZUThoZStCWlNaRi9RejFjdTQrWjFYSG1VUWxNdUY1R3daRHR6WHpoOFUz?=
 =?utf-8?B?R3Jrb1BhYi9JbDBkanBEQ3ZBN0srUHhoNWJSVFlQMWlDUlJEdzJSaHJPbHNL?=
 =?utf-8?B?bHVRL1pXVldKSVpkSVM0ZEJiTXo5NmpXNXAybFZvU3FZNmVwYUpNdVFuTTlK?=
 =?utf-8?Q?HQsIjjVB7N2O2Zwp+I+GqcD6pIjdj4PJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0dUL0Z3WUVZTWdhQ1lxRUg0Sk5lZTdPTzBsQ0tOK1dJNUhzOXFieUFNd0VO?=
 =?utf-8?B?R01kNThCRUFmeFJQc1FGc015R2JPWDB0UWpmdzAyUjBaeTZGek5yYXc5LzUx?=
 =?utf-8?B?clFUQllmRjRqOXA3WWFxV2FPdTBnZFhWeE8wWVRab3lzUlZtWWNQNVpSSDdq?=
 =?utf-8?B?Qy9pSHMxeHJCVGRBRzliVitTcTJwbHVBcHlsWHZKRGFXY09jaktHNDhsUjJ0?=
 =?utf-8?B?TC9pU3AvR1N2V2VKTkFZSitzYTh6WXRlck9FajNQbzJqekdPM29UZHNMT0lX?=
 =?utf-8?B?ZUlsaFBkVElxUmprZDY0QUp1TWdIVWp5eWZzRG5IazgvMHNmc1FZVVNkMGFT?=
 =?utf-8?B?SUdLdFNVN3dWOTF0R3NqeE4wUkV5emxjZEMxNUpNbDlUMDBLMEJVM2ZGSTh5?=
 =?utf-8?B?RUpZb01TaUVhUFZxWEVpRFVqa0hWLzBwTnBreXdlOVRuTDRIUDRGZVI3bFZ1?=
 =?utf-8?B?QlZpZHk0WU9FVldaOXpuM2JFZXgzcWk1Ry9ESTNIcjkwamFxNHViRHBVRGRn?=
 =?utf-8?B?UGErSnI3OHdEYUpwdWhNNDlMZFpybmt0b0txcWFlazA2NUhKVnFRRmdMMVdQ?=
 =?utf-8?B?eTY4TUE3dlorZ2ZoRUlYdXAwNVpZaUtnekhLUGo0aXlXcGsxYk1FSElSZXR5?=
 =?utf-8?B?RVo0a2xXUGJxOWpma1RyMlVOR0RacnJnVklYaWV2TUdJOGE0ZnNzQnpKS1Yv?=
 =?utf-8?B?WWl0UnNkc1F0dDBZOFhNN1M5MXpPV2NIZGJCVS9DWUhKTnk5VmVoZ2daMDI1?=
 =?utf-8?B?NlRGQzRzakpHV1lqZFhvWFhyckxlTHhIUERLVjl1ZkdxSUp5dTQ5RjlNdHl4?=
 =?utf-8?B?MVVpTWRBZnZmbDBOcnlZNE5vT2RGRkVYdHUwOHRVamJlTkdHNjhrRC9wd2U3?=
 =?utf-8?B?U01VMElmdW8zdlgzcU5XMkVpc0ZkbU5nK2phbnlHcC9VOS9OM0pXcFJTZjdP?=
 =?utf-8?B?Z1ZsUjNSQUhLQkMvekJoSFRKRzlpVUJkRmZNeENoOFNYZzVmRnNNS3NqUDJa?=
 =?utf-8?B?b3RhREdqMlhYSTNVUzFkMmd6aE5LNU1Oazdid0hodS9Pa0pMc1Zid08reUl2?=
 =?utf-8?B?OUVJa3U3YTBJNTVXcVpNaW9xQ1FzWkRsZkJCVmhVZEZLMWZTZVhERmdxWDcz?=
 =?utf-8?B?NEl1Wk5aTlB1ZWlQL2lWYVNSN2FtMnZYZmsxV3g4SHN1dW1KelR4eGlrVXhN?=
 =?utf-8?B?NEF2YUtURG8rSFlUUXdWQ1FNZUM4MFdnc0VhWTF1WUlqamhONmFkeW9Zd2RE?=
 =?utf-8?B?dnRUYTBWallFYlFlOSt5LzQxbmgxdkYvQzI2QUlzYUcrWE5heitIVzRmMExF?=
 =?utf-8?B?cVhXTzQrYi9Xdk9lY2l1UHlKb3IrMzlzU1JZN1hVVWZpcTZRb3BrVnVQaTVR?=
 =?utf-8?B?M1d6L3J0V0thSmpaMGRvZkNuamNxVDN5ZlhXOCtpZWtjNkxCcDA3dmI0VDF6?=
 =?utf-8?B?YjEycXV6SzV4NW5EQ2dTbXFHWC90UEJNaE1ablJZaFBRNGwvY29IUlVDOUxM?=
 =?utf-8?B?dytWQTNMbVpQZTJ2SFhWc1czL3RYTUt1TkNpZ2o0T2N0Mzc4bm1tTHByUlZ3?=
 =?utf-8?B?Q2FOYzZIejNWdStoV3R0U3hlQ1V2dDhvOW5pR0lyQmpXMXRUSVZaZnVGQ200?=
 =?utf-8?B?a1dJOWtjdjRQcWJGTWprbUdpa1FtNDVOMEdMeU5MTnJZWGNHSlNZYmVZYjZ1?=
 =?utf-8?B?d0VQZWtNdzMvQ1hiTk9pU2hDN2hhc01ZcWJ4dWoxYzhielN5eU1xV0xZMGF6?=
 =?utf-8?B?NjZVdS90ekFxL2pIRUxIVWtYa25UZ1hWU1ZKdkVWYWxGUWxOZGZ0ampwbmRw?=
 =?utf-8?B?ejcrcVZqK1NodVBSUTVOcUFDMFI4VmxydXFmdWVTaTcwNktsVGR5dFVXVUEv?=
 =?utf-8?B?SkdoeWRERmVmcFVyUERNMCtvV0JDcmc4ZnlGcGczTmtGdm5CWGplTVFYcE43?=
 =?utf-8?B?NWFjQ3hTUlgxdVNQOGl6TWp0QkZlMGZkRUVPbzg1V1dyUTgxVmNCK1k5TCtj?=
 =?utf-8?B?VkoxSGZGakZIRDQrRjczTkFhUU1HaFpIdFhNWWExUVFDUTZWU3lVOGFYQjl3?=
 =?utf-8?B?Z3F2ZkRwMzBwNE1HeTBoaUFNY3lEQldiamNDMnNETWNTNTJ6N0hmNDlHNUtK?=
 =?utf-8?B?L2g1RFRpYXFUK2h3ZDR6RFRnV3RLZkd1S3hTRmd5NlZ6OGt4aFJFd3QwQlZU?=
 =?utf-8?Q?0KqV6qYXAdqIKgcGY0slRyURA9O8JhHSnuoyZnUqIEqy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fad16b-91fd-498e-fffa-08dd6d52025e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 17:08:35.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UEkLCa0bTVmKeSfdjAQKe2jY0Fbz6d8c+vaF+04vGrG+O30dmm1XwpGOyGXiDBdiGQG2AmKSPeN52WlEsVHFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

DQoNCj4gT24gTWFyIDI3LCAyMDI1LCBhdCAxMjo0OOKAr1BNLCBQYXVsIEUuIE1jS2VubmV5IDxw
YXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBNYXIgMjcsIDIwMjUg
YXQgMTI6MjI6MTJQTSAtMDQwMCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+PiBQYXVsLA0KPj4g
DQo+Pj4+IElmIHJ0b3JzdV9ocnQgdGltZXIgaXMgc3RpbGwgaW4gdGltZXJfcXVldWUsIGludm9r
ZSBocnRpbWVyX2NhbmNlbCgpIHdpbGwNCj4+Pj4gcmVtb3ZlIGl0IGZyb20gdGltZXJxdWV1ZSBh
bmQgZGlyZWN0bHkgcmV0dXJuLCBzbyB0aGUgcmN1X3RvcnR1cmVfdXBkb3duX2hydCgpDQo+Pj4+
IHdpbGwgbm90IGJlIGV4ZWN1dGVkIGFuZCB0aGUgcnRvcnN1cC0+cnRvcnN1X2ludXNlIGNhbm5v
dCBiZSBzZXQgZmFsc2UuDQo+Pj4+IA0KPj4+PiBIb3cgYWJvdXQgbW9kaWZ5aW5nIGl0IGFzIGZv
bGxvd3M6DQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMg
Yi9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYw0KPj4+PiBpbmRleCAwNGQ3YTIxNzNiOTUuLmVjZjNk
Mzc5N2Y3ZSAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMNCj4+Pj4g
KysrIGIva2VybmVsL3JjdS9yY3V0b3J0dXJlLmMNCj4+Pj4gQEAgLTI1MDIsOCArMjUwMiw3IEBA
IHN0YXRpYyB2b2lkIHJjdV90b3J0dXJlX3VwZG93bl9jbGVhbnVwKHZvaWQpDQo+Pj4+ICAgICAg
ICBmb3IgKHJ0b3JzdXAgPSB1cGRvd25yZWFkZXJzOyBydG9yc3VwIDwNCj4+Pj4gJnVwZG93bnJl
YWRlcnNbbl91cF9kb3duXTsgcnRvcnN1cCsrKSB7DQo+Pj4+ICAgICAgICAgICAgICAgIGlmICgh
c21wX2xvYWRfYWNxdWlyZSgmcnRvcnN1cC0+cnRvcnN1X2ludXNlKSkNCj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsNCj4+Pj4gLSAgICAgICAgICAgICAgICh2b2lkKWhydGlt
ZXJfY2FuY2VsKCZydG9yc3VwLT5ydG9yc3VfaHJ0KTsNCj4+Pj4gLSAgICAgICAgICAgICAgIGlm
IChXQVJOX09OX09OQ0UocnRvcnN1cC0+cnRvcnN1X2ludXNlKSkgew0KPj4+PiArICAgICAgICAg
ICAgICAgaWYgKGhydGltZXJfY2FuY2VsKCZydG9yc3VwLT5ydG9yc3VfaHJ0KSB8fA0KPj4+PiBX
QVJOX09OX09OQ0UocnRvcnN1cC0+cnRvcnN1X2ludXNlKSkgew0KPj4+PiANCj4+Pj4gcmN1X3Rv
cnR1cmVfb25lX3JlYWRfZW5kKCZydG9yc3VwLT5ydG9yc3VfcnRvcnMsICZydG9yc3VwLT5ydG9y
c3VfdHJzLA0KPj4+PiAtMSk7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgV0FSTl9PTkNF
KHJ0b3JzdXAtPnJ0b3JzdV9udXBzID49DQo+Pj4+IHJ0b3JzdXAtPnJ0b3JzdV9uZG93bnMsICIl
czogVXAgd2l0aG91dCBtYXRjaGluZyBkb3duICMlenUuXG4iLA0KPj4+PiBfX2Z1bmNfXywgcnRv
cnN1cCAtIHVwZG93bnJlYWRlcnMpOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgIHJ0b3Jz
dXAtPnJ0b3JzdV9udXBzKys7DQo+Pj4gDQo+Pj4gR29vZCBleWVzLCB0aGFuayB5b3UhICBJIGhh
dmUgYXBwbGllZCB0aGlzIGZpeCB3aXRoIGF0dHJpYnV0aW9uLg0KPj4gDQo+PiBDb3VsZCB5b3Ug
cmUtc2VuZCB0aGUgc2VyaWVzLCBvciBzaG91bGQgSSBhcHBseSB0aGUgZml4IHRoZSBwYXRjaCBt
eXNlbGY/IE9yDQo+PiBwcm92aWRlIHRoZSBuZXcgcGF0Y2ggaW5saW5lIGhlcmUuDQo+IA0KPiBZ
b3VyIGNob2ljZSwganVzdCBsZXQgbWUga25vdy4gIElmIHlvdSBoYXZlIG1vZGlmaWVkIGFueSBv
ZiB0aGUgb3RoZXINCj4gcGF0Y2hlcyBpbiB0aGF0IHNlcmllcywgaXQgd2lsbCBwcm9iYWJseSBi
ZSBlYXNpZXIgZm9yIHlvdSBpZiBJIGVpdGhlcg0KPiByZXNlbmQganVzdCB0aGF0IG9uZSBwYXRj
aCBvciBpZiB5b3UgYXBwbHkgdGhlIGNoYW5nZXMuICBJZiB5b3UgaGF2ZW4ndA0KPiBkb25lIGFu
eSBtb2RpZmljYXRpb25zLCBpdCBtaWdodCBiZSBlYXNpZXIgZm9yIHlvdSBpZiBJIHJlLXNlbnQg
dGhlDQo+IHNlcmllcy4NCg0KVGhhbmtzLCB5b3UgY291bGQgcmVzZW5kIGFzIEkgaGF2ZSBub3Qg
Y2hhbmdlZCBvdGhlciBwYXRjaGVzLg0KDQotIEpvZWwNCg0KPiANCj4gSSBoYXZlIHRoZSBkZWx0
YSBwYXRjaCBiZWxvdywgd2hpY2ggSSBoYXZlIHB1c2hlZCBvdXQgZm9yIGtlcm5lbCB0ZXN0DQo+
IHJvYm90IG1pbmlzdHJhdGlvbnMgYW5kIHdoaWNoIEkgZXhwZWN0IHRvIG1lcmdlIGludG8gdGhl
IG9yaWdpbmFsDQo+IGxhdGVyIHRvZGF5Lg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVGhhbngsIFBhdWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gY29tbWl0IDU1ZmNh
YzVjYjNmYzk2NDc5ZDkzNWRiNjQ4Yzk4NTAzY2IwYTk0NGINCj4gQXV0aG9yOiBQYXVsIEUuIE1j
S2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IERhdGU6ICAgVGh1IE1hciAyNyAwNzoyOTo0
OCAyMDI1IC0wNzAwDQo+IA0KPiAgICBzcXVhc2ghIHJjdXRvcnR1cmU6IEFkZCB0ZXN0cyBmb3Ig
U1JDVSB1cC9kb3duIHJlYWRlciBwcmltaXRpdmVzDQo+IA0KPiAgICBbIHBhdWxtY2s6IEFwcGx5
IFogcWlhbmcgZmVlZGJhY2suIF0NCj4gDQo+ICAgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNL
ZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1
L3JjdXRvcnR1cmUuYyBiL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+IGluZGV4IDA0ZDdhMjE3
M2I5NWQuLmVjZjNkMzc5N2Y3ZTEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvcmN1dG9ydHVy
ZS5jDQo+ICsrKyBiL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+IEBAIC0yNTAyLDggKzI1MDIs
NyBAQCBzdGF0aWMgdm9pZCByY3VfdG9ydHVyZV91cGRvd25fY2xlYW51cCh2b2lkKQ0KPiAgICBm
b3IgKHJ0b3JzdXAgPSB1cGRvd25yZWFkZXJzOyBydG9yc3VwIDwgJnVwZG93bnJlYWRlcnNbbl91
cF9kb3duXTsgcnRvcnN1cCsrKSB7DQo+ICAgICAgICBpZiAoIXNtcF9sb2FkX2FjcXVpcmUoJnJ0
b3JzdXAtPnJ0b3JzdV9pbnVzZSkpDQo+ICAgICAgICAgICAgY29udGludWU7DQo+IC0gICAgICAg
ICh2b2lkKWhydGltZXJfY2FuY2VsKCZydG9yc3VwLT5ydG9yc3VfaHJ0KTsNCj4gLSAgICAgICAg
aWYgKFdBUk5fT05fT05DRShydG9yc3VwLT5ydG9yc3VfaW51c2UpKSB7DQo+ICsgICAgICAgIGlm
IChocnRpbWVyX2NhbmNlbCgmcnRvcnN1cC0+cnRvcnN1X2hydCkgfHwgV0FSTl9PTl9PTkNFKHJ0
b3JzdXAtPnJ0b3JzdV9pbnVzZSkpIHsNCj4gICAgICAgICAgICByY3VfdG9ydHVyZV9vbmVfcmVh
ZF9lbmQoJnJ0b3JzdXAtPnJ0b3JzdV9ydG9ycywgJnJ0b3JzdXAtPnJ0b3JzdV90cnMsIC0xKTsN
Cj4gICAgICAgICAgICBXQVJOX09OQ0UocnRvcnN1cC0+cnRvcnN1X251cHMgPj0gcnRvcnN1cC0+
cnRvcnN1X25kb3ducywgIiVzOiBVcCB3aXRob3V0IG1hdGNoaW5nIGRvd24gIyV6dS5cbiIsIF9f
ZnVuY19fLCBydG9yc3VwIC0gdXBkb3ducmVhZGVycyk7DQo+ICAgICAgICAgICAgcnRvcnN1cC0+
cnRvcnN1X251cHMrKzsNCg==
