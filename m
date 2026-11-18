Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994482;
	b=VWpGvRceSK9DutTbJ4yal0H8jY5PcXlbdXf4WK7+nwd3p2nfK2HyjhpLEXC+IfMcktLM
	 qlNSRL/ZROS243wQsiOV4+2GLk2QheklIRn1GnHAF4mmaRP03Q+3sCpDBjLhAW2d7EjWk
	 mKPxLeKxwJVjHZUzFZOz4C4DTUHf/6OdwfB31EgAWd4kUWnVajSwOmH3YSrfriG57mDas
	 T3H0McSHpO7/+zUrKXdmND++eoA+webLK5Hy3LP3UcURPXXyH9chexfqKAIX9KLRAGeV4
	 1RsMNedg5ZiccQog6FhnrlRQ82kE9uqGdHe33Mo0nx6rpHeGVXj+UxiOGmraTdH0vvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994482;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=apD2UOX7altQANUp4gNW7XwKkuOeyp3KBP6iA9GLpxE=;
	b=k8cD6wlKViuN6aDhXr/zC7+nTX/LlYgYMme+spyAaSyXv4gA+w0QqHASwbL8t4p3Pu/o
	 /X6UT7uZvXaNrW/+UkI5K9hDbthEYpzHZBod9GNDQXH+waQJQIjQXD/IaEgQZo9GHMhVE
	 a5oq6Usu5IgI7zJRJKzPiqTo9ySdjjfV2dSYEVSeF2po1Q4CAPQ0sVGhpZPKcIerKj7I8
	 I0jAcv4vH8bWcl4xRtONt5VxzWTezU+0RyoLg0KR2Qu66ZSTImP9m3VjjJ5zEcYNkLSRj
	 r4O00AsfTd/v6Tf4w+pu8ZS7Vi3VemjJA5MycCSCQRM/MYNPsi55GfUJ7BHVu6f2i0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rxg5D1GM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.1
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010001.outbound.protection.outlook.com [52.103.20.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B62606A320
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 09:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B62606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rxg5D1GM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEmDbBmIVRBqbTxgn1L1N6gClCsoEhCfQr+M3lRigJeJrUP+IBPwmOENLlblcAVXJ9Y7Dq+0DqTo2pVz+7vY5Lro9Dl+lR4JD6B8zHKGlGb1nS9DFD5OVCcpbCKMCvtTtKfODKJQOF4hxmkIU0faZDr0zgz/qOLkBIS+9O1P2Tb1X4IdXCY6tuassiPwLlLrOV23a2BP4AVKMVli4HN40kgx02zNPfKuhUdAZDgHOVy8QW3OsCHfK1i9cWKBCGFh/nk74ZBTuKg7On2LIhtDjh2a+v2oIVlfZBo2nCSqVyCTJD4fZpzzODrLHRfdGHvz7teDbJ7hzcGosMdK/Qxs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apD2UOX7altQANUp4gNW7XwKkuOeyp3KBP6iA9GLpxE=;
 b=bCyBfTPB4sJhKLvDfahzgwVSbTyyjSV32MxeHfawAmfR4JG4eB9lWpWAnD4yldtNQICiybzhcI07nv9ACIiFEOgIY4uRylbXfUCtNujcDjpqzaf3P9zXs/lVJG7cw5V3mKj42f2KklX1hYg+XfD3p3pZpBRCBxt3F7cnP8mHiKSXaIDoazWDvVqtvQ9QI7WCPjNw3dbYJsaTw1Hncchj1bw7KpYcWZl+FIfJQ3vbI0H510zaIKHto3nXj8LZAka9L9FFBD419nNUwDFqIq6jsrPntWJOdR3O7o7h2pXJL/dqxR81PeHNHslTGePoKuCcMmo/ODvHzykFyR3VWaEj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apD2UOX7altQANUp4gNW7XwKkuOeyp3KBP6iA9GLpxE=;
 b=Rxg5D1GMiQEd3Y+yem644UpZT0kBKiRGouCrSv2EsMCkVuucYRpG5dvdi28WVzcrWvM5BRk2mHtEswjOavTRSTrddtQtc/jrz39alHmFfUGgyHTKOyoZ6HELLADi+lsYlhuoA/vN3dZW9LR3F0ZSPsukuG3hpnwyPD65FHFn0FRrVNaJ9WzLL2jGIlyHGC0657K5P6NJ0VHd8wX7NE8yywt84igxqTaekogrrS7E9q2sL8Ywhcp8ky7Gx2e2sXr2/Im0qnYhQhZ+6IEhH/cFrAgXijrRmtGEb3kJMX3DkAQCLQcPms5gJF4KWSNKy/Cn8LsWGHfKtOdSIb58bG7Oow==
Received: from PH0PR01MB8022.prod.exchangelabs.com (2603:10b6:510:285::6) by
 PH8PR01MB994791.prod.exchangelabs.com (2603:10b6:510:3d3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.1; Wed, 18 Nov 2026 09:34:40 +0000
Received: from PH0PR01MB8022.prod.exchangelabs.com
 ([fe80::636b:602:574e:c02f]) by PH0PR01MB8022.prod.exchangelabs.com
 ([fe80::636b:602:574e:c02f%3]) with mapi id 15.21.0662.000; Wed, 18 Nov 2026
 09:34:40 +0000
From: Rogge Ohta <roggeohta@outlook.com>
To: "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC: "paulmck@kernel.org" <paulmck@kernel.org>
Subject: [BUG] rcu: Wait-queue list corruption followed by cgroup hangs on
 Ubuntu 7.0.0-43
Thread-Topic: [BUG] rcu: Wait-queue list corruption followed by cgroup hangs
 on Ubuntu 7.0.0-43
Thread-Index: AQHdd0AI4qakTEq/WUCzHLtsffRiVA==
Date: Wed, 18 Nov 2026 09:34:40 +0000
Message-ID:
 <PH0PR01MB8022450E2462F326C65F5C22B67A2@PH0PR01MB8022.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR01MB8022:EE_|PH8PR01MB994791:EE_
x-ms-office365-filtering-correlation-id: 278a5714-d926-4fa3-b7d3-08df45572b56
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxO9kp0A7o9T2vDYZh5rORcnsFet8jr+MB4CEa3/7siFg3AeAKhAR3FJnNPMGb8jT++rgq/daL7xNjw4w7LPGXdT0dTlCICdVQKecUA4DhJxn/tMETuTItgAgxe/qx3m6ROYtDD1ZzrCYSzj6ubJwOaSWk43iyBStzde7ab4dt0kTVgjDe0ExYLVAZKwpOBcNef5irR4usdkgQ5aHF25rfFTUPzKBYAbYSVEh+M4htK29YvpIrVA/QRJuVwTLX939aaEDSjjbNPinW95JcK+QS52fsvL5sUjlgxyYmBX7VH+WIM1dD/Dtyzv3z/bdiBAxh5Bx+hHpw7sedT0COrNuYiDxRISCkiTeXB/5RxeVBK5lpQex9CWMPhx1jKTUpSs0nKxjA8kfNVkQ/2oMVRrOO8BvyGY/Fcn1b/qinCdjRZ5ixuuMASYurcFCKhChoMwbS9QJ4BpvfUqLejNMToq5MO6Qq80aKI1y3HWcsHahlXnpPnhIae5KM4ZZIRWuYjb2CvcMs9+IJdhpNHy8He2FqmUAKBeOuVMaUqLF8fcoEHXXwI3SYYgDvmNRXOUHIGM1MOPfG8Ww83oj9/3bEAJZ+bKy6fG/11FqStzKfnxdIzssnTuKiMYu842z9vssVACaW3Tb2LX5obNFwW55q2kY0FxPw252aiVddHdvRL08ftq/oa7PR1vAx3TPuUlvUO/zLo6/uTdoPVuJh50SRJwJj8SmVvAmezcq9VUx1MKKnMgNs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|12121999013|15080799012|5062599005|8060799015|8062599012|31061999003|38102599003|19110799012|20031999006|13031999006|39105399006|25010399006|4140399003|440099028|3412199025|102099032|31101999003|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?gDkIp9EpI+kGk/qMyBGV2UC7ZRVTDpOsiaJBksOEz5ZfpVk6/4/WUZQ3?=
 =?Windows-1252?Q?TEjvrR1cQbCX7376kk+x6NSqbRAJqf6WomRQ/3OF4g4Oe6t3aNY2Tvrq?=
 =?Windows-1252?Q?nQK6IYPO+nox+qR1xtf1snb0V9S9maxGQpRRcVTtUeL0D731Q4N2htol?=
 =?Windows-1252?Q?a0f52LSrGsQHzdfX8D/zqyYwRwPqFZw7OWNag1HfIzoeB+hVNQDDdG29?=
 =?Windows-1252?Q?Uz25zBH4CWeQxSuSoSvitkWRE3Jd8/YXTjoBCGhaXZuy21nv1nVa5l4Q?=
 =?Windows-1252?Q?6ofOnz+yJhvht0OyoAbdb7aGNulvt/2TiReyEMkG2b+aLNqgMR60S414?=
 =?Windows-1252?Q?MgorvsNkoAt5G3AH8E7WXe44Y/m+SIsLC1snYYz8qftd0bhC5mlLV8gJ?=
 =?Windows-1252?Q?XmNs4vc5sZCoKUKk70pgQ6u+VCAtoiIHUiEscxrfd+MDhMO8ipsq9qpg?=
 =?Windows-1252?Q?zX9ZfYZFY49bCFwAGUvw/Ooh+U1b+k7AqYS2HfXd91kyCylJlzUT/37R?=
 =?Windows-1252?Q?7NO8Glsp6oyT61LF5f82vASVbdI2lu3dKcUgwrxheSYznMF7KF60tB/k?=
 =?Windows-1252?Q?YiyOD6q8aRL9ZJL4iY/PVpDP1q3jgnID65y7aZopZ0+EUyWvbMqPPFHN?=
 =?Windows-1252?Q?E94hwxs/V4PzEo7o+pHdpuGKqXxo2QMJ8+Ktc+bFi1eCEc2Kbb8CBimG?=
 =?Windows-1252?Q?eVOzFDB7MFPsqLF2CyCh558eoAFGBz+KwDHctvkiCMBfWKwnwHLZRXAr?=
 =?Windows-1252?Q?Gf6/Zix0oMdFp8cQMT31eSKcVp4HBy3lZm8j5AymxRi5LGCXrsRrQ6o1?=
 =?Windows-1252?Q?D3DRqGk0iCLdkE/mNfypUFa3ypc02R/LwsmFJZlAKjcY5Rj6WqZnjT+D?=
 =?Windows-1252?Q?nrm6RBo0jnh/cDFLSq9x/MbyEPdYGnOO63xRrp7jgGBQry6iAZjgI9v8?=
 =?Windows-1252?Q?yljoPMdwKfk6pkzLcLo1WrTGuiuMcgWKZ4qbOtKiOTSreWnz5LXye+uY?=
 =?Windows-1252?Q?WfNHlxQyh6/HZ+Zxz0rzRAEFbKEqEylkTbSNJQGE4PV1gmEENIxAWJXv?=
 =?Windows-1252?Q?dYYDvgKIrHettm6kiqc/dQVyd9+Dwo8tHnLEB0hV1q8P8JRcZP6DKtzM?=
 =?Windows-1252?Q?vHRy5D4kpNjIgMfmofXGx3Lk6TU+JtiC/iK/XxQyk8XYgtK4/aW2K8SC?=
 =?Windows-1252?Q?QhS58DjukbaFRp/+k3Xi6DcQjMLcZJ+5LIa+NicqQ+/5QShnoxOgJSql?=
 =?Windows-1252?Q?RUz6lHxcFLCRRi0+AQNrJLN4iZknavZoZuq3G8Xz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?gXB+EwQH+Hom91++CAcN+nNjTQFc3fMr69jwYBv9T/kAVXhCKa61WBX1?=
 =?Windows-1252?Q?plX/dQ86n8oOmeA4Ol+B+YZ5B1LcLWHIfSJAd1wMTJQvnPuUdlD0GtH1?=
 =?Windows-1252?Q?TrXJNaQaVeIiTFvW2iDBQh8PCaIp5QSwu5omfwCTNerhDCQCDhV7x8sH?=
 =?Windows-1252?Q?YcC6yhjaPDUQP7I0DmZFPwwj98zTHluxsuQfdwlYx0TiR/G1MAaMjDI5?=
 =?Windows-1252?Q?KcSafvURflVjeQEV/lguvmEdE3WEmez0bbE+fT6ULo3R6mM7y0KTC7MJ?=
 =?Windows-1252?Q?8lxgQ6fYVGvhshz9MqV4kdHtppbCr7eqb9VByq72aFEFSpCxxOcvjb6Q?=
 =?Windows-1252?Q?rCJn2kpXzyg9P3CbVRCmY6/zec1Zw8htBSjpJU00MC3MLERawz3syrBP?=
 =?Windows-1252?Q?2GbDX5wq1doVvwA21vLWZiMhgKDsFVNSDfJLGlgjhyS6iZpR4h+WEKuB?=
 =?Windows-1252?Q?vGLvFAvA4r06hu+sRdWVmPVRp5csJfarzey9npX33avYlwvaf1bj3abJ?=
 =?Windows-1252?Q?JormevPWJOsIbuh+W6+Xcm78AbNat0v0vhZhf/CM4SAuCveXZLVIvO2U?=
 =?Windows-1252?Q?lOGHKO6PJFmDKgCOcCSVVfXEEHSdDtVyFQhnmsvEnxn+CXMq/+XJYJuD?=
 =?Windows-1252?Q?AXEjIcbSHSP+uRgCXpubgX9bdUZ5d96Td9Fma18b0mWa90S4duEvvbFg?=
 =?Windows-1252?Q?sCKspPmIaXPsgGkwgWYSwCAPhhwJRQDXuccFsvxqSZo6SowC++fc0Z6Q?=
 =?Windows-1252?Q?LnhQQSRBsEa2IaLxjhg1OgisfWqpEYF4hUGPenghYKQ2diNX1GLbvgrI?=
 =?Windows-1252?Q?F3SPsbJTtXJ9BD4EqC2xCf12Mjy6rOPswqcNfA7ZXlBrYAaezT9KXeSM?=
 =?Windows-1252?Q?BigVRJNd6DkGsPxp/6g0N4vcL7FZcQVGGgCXZj3NveltWLSMQAfcPYql?=
 =?Windows-1252?Q?4NVvNOsAtAywJPwjoGjN5jyqhPFKQgMyB9S6SqiWckXccZZbo2rHT1q9?=
 =?Windows-1252?Q?NHdOpz6Y4jW3Et7gWJrd86GVX1HUO7egISsWXxAbWJqIOGnceaKt+9qh?=
 =?Windows-1252?Q?13oZggptkJlc3nJSJ0C3EOHJ4bVu2VWyoWw4yL3khsxa4ZEoyYeTmEAD?=
 =?Windows-1252?Q?g30G83gRRIXu4DnDsdKQCjpMw6XTqo2PEzHauwbR0Oh2ZSf9BThZKpqG?=
 =?Windows-1252?Q?6/6wGBHXQ75B5EMITN3rqne9fetzQtIQnVMMszXIvT8lPEbbb9PDMYhS?=
 =?Windows-1252?Q?P6U0nfd5pDSFqlctWOf7u2KvQLCS9QuydDI4v99TxtBiEWqhz7sWNRto?=
 =?Windows-1252?Q?fqHoLSpxil2M5EdfYXgGftzOx5TUIzxq/EZEuiT4SIon//+dwtxTntiV?=
 =?Windows-1252?Q?BtGsBrXeAvtKSfMY5qd946okrebFvEpvo7HyWvLaqUUFx++3U/S6JazN?=
 =?Windows-1252?Q?b4qYiS+YM2mx9k3RRgi6n2EkQ9oEGWUGILQVBzslRzNfexNxLP3ElwR0?=
 =?Windows-1252?Q?2ufdN/0s?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8022.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 278a5714-d926-4fa3-b7d3-08df45572b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 09:34:40.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR01MB994791

Hello,=0A=
=0A=
I observed an RCU wait-queue corruption warning followed by a system hang o=
n Ubuntu 26.04 amd64. The kernel was 7.0.0-43-generic, Ubuntu package versi=
on 7.0.0-43.43 based on Linux 7.0.14. The system is a Gigabyte X870 EAGLE W=
IFI7 with BIOS F13g.=0A=
=0A=
The first warning was list_del corruption in rcu_preempt, with rcu_gp_fqs_l=
oop() calling finish_swait(). Using the symbol table and BTF from the same =
kernel build, we resolved the queue-head address to rcu_state.gp_wq.task_li=
st. The waiter=92s prev pointer pointed back to the waiter itself. Sixteen =
subsequent insertion warnings showed that the queue tail still referenced t=
he same stack node.=0A=
=0A=
A later hung-task trace showed a process blocked in synchronize_rcu() while=
 writing to cgroup.procs. PID 1 and several runc processes were waiting on =
the same cgroup mutex. New SSH sessions and container health checks timed o=
ut while some existing services continued to respond. A reboot restored nor=
mal operation.=0A=
=0A=
This happened once. I do not have a vmcore or a reliable reproducer, and I =
have not verified it on a mainline kernel. The initial write that corrupted=
 the list remains unknown. Does this signature match a known issue? If it r=
ecurs, what additional evidence would be most useful to capture?=0A=
=0A=
This report was drafted with AI assistance from the recorded logs and kerne=
l source. If it leads to a fix, feel free to credit me as follows.=0A=
=0A=
Reported-by: roggeohta roggeohta@outlook.com=0A=
=0A=
Thanks,=0A=
roggeohta=
