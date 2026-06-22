Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020135.outbound.protection.outlook.com [52.101.195.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C361DF75B;
	Mon, 22 Jun 2026 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150414; cv=fail; b=ZeZrwa2UZyzXW42OCiLyVE+B0zRuxvSXVQBJFqnpVm3vaB1KXfCXKqX96f5W5o/SvZ6oXYp/YqQo/1UtA/nFb0mCBRJCQcxK+cdbyC93TYcPYcHWFbnYQpHo/3zd0YEKn8hz9BhRSVUvma4r+8lTItdj/LoWDKRWkgQ2I3Yt1U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150414; c=relaxed/simple;
	bh=9Aggjln5ExEbrE/R+n5XjMDcDF5cjTxRFZ1yNdZD3/Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MZhxeZrnQYByrsjrkaxri5q9/J5+CCSZo/ObBOKL5DHIMSwI9NAODeJhRE7Ru5FjwKOH1+Klu94ObdMM7RDSh6e3AcqbVhpn/XbAPXG5orFD2zDi2dQXiHzcBzxeaXh/4ipdj50bHlPn1TwHLBcR6xGN40xI9vWihlkPqBhq8To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=j1+40ehX; arc=fail smtp.client-ip=52.101.195.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="j1+40ehX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2UJczmjs/TH5C64l5DcmloqkbdkzzwW/z4OlVkRhnp6FYlGCBi1KZH+dz/ByBJJ2WlpdwXAJvpVDqAR7FEUSKfKX6U3/rFL42mXd35JH1auhXZ4/RgjrFhLjT6xGq8wt6H1RfJ6vxBr5OUr3h+tcvqo6rx3nYAHxm2rTqnnbHjdJ0GdYKXlVDp89MVt8EJwvkIfOnKoAjBPJ65oelE+bEmRLu1VaPVbNYyZGKTRAtPuPcqtol1Wr+akjYKCzo4mM3IHyjVwhOXoof7G8wxtzMlNwkwLnA2bRfEydu7wVBkx5SkhcknCYphQoq45J30nx9jh7bMViPsV5bIwHNr56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+YNyqmW0vzwHITWKGJJx+eUYa8X7GNy+8UG9b9/Sgk=;
 b=MI32pyOYO7MQUdsp0qj9EqLrZuypQi3IZDVHy4LVJ/thw0/NEQ7sWV6YrqsahgpHCghMiyPg8d0TQHfSJFMjKaG6DJTe1A57lGaNVPwByOgS7S7twsqfQjj00gQKnlizbRZWQKPEbbOOgrCbqeoEAVsaynb9g17vFByUVm4Bx8YAkvj6ECm6JxWaNvV0fanOe/UnQKJje3L8erffmCMgjYGK8AsZbPWyOCEEABAUhtF+TBA5VJH2O5KXQKCRm5pZNQFayRP4bViyOQ+N731uymQhets9dG1OmFEjUSWHloFIOR0+JkePMB07AcEHdahUYGArO5xNRvpEWMN6ZUpDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+YNyqmW0vzwHITWKGJJx+eUYa8X7GNy+8UG9b9/Sgk=;
 b=j1+40ehX/XhWhM1geoJQDRSXxuQWyWziRo90GmUwJSMHlpyfPqdnVtJVFl9O82TDuW/eB2wBm9YBqeZrxowz3zuYoJQT4XrLXWLcH0BuWcxaPeSVd5kELmU/zQfPqE1lRVBMSe/ixrs4t86F0IcnJkz+ehfY4LhHQw+09ToaUgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 17:46:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:46:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 18:46:48 +0100
Message-Id: <DJFRLFDNGQDS.AZYO7F05C9A4@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for
 synchronize_rcu()
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Lyude Paul" <lyude@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-3-phasta@kernel.org>
In-Reply-To: <20260622173250.411377-3-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a01a4d2-acbc-444c-529e-08ded0863c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|10070799003|921020|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bwbYwfjwMS39yRReKsIdEAB+BZoamNQJOa9WUR7fIG8PteZjQ8Gv7+3Ozf1zu5wOxqSB2KHaEjkAf3NSZTChYieqofGHkyP2onC9MxIS0lP02KHlTDivxvAN7IA1KQjg50gyXHB3kzUzufYJyJJ6+aSBgoB5Jp+zJnYwU6IOh6IaeqLZn89WJ0Hh0LIcKLdlwbgHuCjlYujc+busgiv5bkQR6JdX3JmOpfcpxd4ng8pDXjFSi2af7jJ6rGyXtE/ySCqbzT0Nz6W5fzvcRWVhyWeeZwjy2tAr0I4RpLf5fnFU1gw+VlS0bL2RmsrS/51zIscE7KcF+TrF0jiFNtRjgbXlCNvc0zLMZN6CNPUEuz5oG0Aoq2QD8h4iOu70mvFLOkmAGqwqlNASCX2qu77xt/6bkxkRghXHwaNpdyYLEAEFuJbgTwJVVX4onilo8V9g6plXyYlerTMUbRXmsutO/KrzW8dA/qb0tBbM7JjLDU5/QcXrcZYnfNxkS3c7RLu2//XHqcu4XSAhykmjlXkKxCnk3y9lJXAZUuMSeM1Ol/uIC7Al4hOOQLCiM45JRZTeyQi29WmjcdvqHXVEbadJMKJjBEKhWfTK3/X6gg0DLe2dEUuYr7ZWSm1/U8MKPhzztXPstYvSI5552XsbU2Ua9kzz+0bAUp2ej7sbCEbkg4TgwArwFCV8eBNVLqb4wMqBKyqipQ9Iy72dEXzIhmCCIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10070799003)(921020)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkg4U1BFSS94d0g2Wi9qY0JDRGpmQ01DTGlNMmFqaHpnUmRIc0M4c2VBdTNN?=
 =?utf-8?B?dHhBakdhZTBoa0wrQlJJVStRYVVkdjlrRTJiUE9hYk9JNGhmd3AxRitST2NO?=
 =?utf-8?B?dTQwTVBuV3plYlkrV3ROcno0dVk3dVpSVmZWQk1weHVCUjdJRFh4ejlFSmQ3?=
 =?utf-8?B?WFBSVjJlYkUxUzVEd2NWQ2M4MVBNMXV1b2VmMHF3YjU3T1MxU1ZFeE9xdmxY?=
 =?utf-8?B?amo1OWl5SzYySk5SVGgvZ0I0dWwvOHg5eGtGKytDQk5kdzJORWthRUNMZTMv?=
 =?utf-8?B?ZkV4amtrblhpYmRuM1RZakZlRS84YUR5T3IzdHhnWXJKWmtpRHk3RnNlT2Y1?=
 =?utf-8?B?MUVFa0l3clFaNXdUbmRaWW9ldXJ3UXVqVEp2R3RLZ2w1STFicDVOUVZ3UHJa?=
 =?utf-8?B?TnhNRU84UDdWd1dsQ1lJVEFNVjVQc1ZKSFRsTVMwb3dPZ05FV2Z0MlhLWWRr?=
 =?utf-8?B?N3hMSmNyRnpwSlZkbm9YUjFXYW9VRDN4d1IrdjUxRVVCQlg3S1R2MmJiQno5?=
 =?utf-8?B?MlBmbkt3djlac3c2eE5JOEJlUXRKcHpZdFlPVzZxZHR3dXJGMzQ4cVhWVXZj?=
 =?utf-8?B?TFhmbEkrNWZ2N0h4WFpXcWJPQmpvT2NNSFVyMEtXMWV0QTA2RkpwVngrQys2?=
 =?utf-8?B?cHZjTDZvSzl6d1RSUUZveUJDQitydk9YaHJYQ3VzaGVtWEFaR014YXdSckRI?=
 =?utf-8?B?VUo1eEx3Y29wS1loaGxvbyszNmJ6bTlQMUZMTUkzd0ZlNE5qWjZLNjlPbU4z?=
 =?utf-8?B?ZXo2VlByd0EyaGdrTGJUWnV0bHQxc01LWGhNRlhzRFB4S042czF4Vkc0QS9R?=
 =?utf-8?B?ZDFGNzliYkhFS2c2QkhWSDdPNGhxM2xpdlBJcWtQWXRCSkhHa05ucytSYVBL?=
 =?utf-8?B?aVRoWHEzdkpHdzhYb1BVREdTMktTMUhjN0hybVVCUEplWm9IWVJaSlZIUlJG?=
 =?utf-8?B?OVJPbFBYb0dvNUU2WCsyUFg2dHUrY0Z3R29ZZEN4dkdxL2dDc2dHSXVycjl0?=
 =?utf-8?B?Z1BjaG1yMkJmVVFvYXh4YjRtTlQzbmVWV1AySmdTQTBTaEtCbXBNNk14OGQr?=
 =?utf-8?B?b01xQXMwT1AzT0RZSE5sQ3hKL0JRbTNidC9JbzJ6ZlVTVDU1YmhPRHdxUVVU?=
 =?utf-8?B?WHlaQ0xDNXZDeTdKTjFpOHFHYVRKVnFqdFd4Vjc2M1lCNWc1SVNNbXZFa0JM?=
 =?utf-8?B?M1ZzdUJTR0hYcjBKbER4VjV2am5Oci9YMm1PQ1JiVTE3d25qQXIrUDIyUnFT?=
 =?utf-8?B?UThzcDRaMUFSRFdZNTljN0xPMmM5NHQzRXJzNXdQcndweG0rVlJLZ2FjMVhV?=
 =?utf-8?B?OWl2RlZ6N1czMFA1YU5aMDBIRG14dXlseDZNRkkrZGVQdXRtOFRqRlJpQmFv?=
 =?utf-8?B?eWVsMzg1VzEyQURaQU9DVmcydlpwVUVBbW9adXlONVdIdmxHYkVjL1JMTGl3?=
 =?utf-8?B?dUtBOUdYZjNCSkhTTzBaRkI0UXo2SVkvckNqMHhtL3BhTCtqaGR5VElwNzBh?=
 =?utf-8?B?a1NXSDJRVFd4dkFjSUVmY3BlQVo0cnhXV2ZPM0tPcUQybXdpNkhZRWJjT0Vv?=
 =?utf-8?B?QmVRaXlMNFlVR28vSUxKdnRBVVJhODY1ZjBIUVlTMmgzemZyYVhEOXVaejEr?=
 =?utf-8?B?cVNib2k0ems3MldWQm53YWo0MzBKMlNlSXNnVk5JOUEvL1U0OEpoRXVBSUl6?=
 =?utf-8?B?QU9xZDlHM3VLUTA5Q0hhWG9BUkZzTHVraVR5MmhuK0h0a3g5UGZ3WGN5b21I?=
 =?utf-8?B?T1JEY3VrMnFkTUJGbDBqcnJYVUNlRXlxNzlNWW96aUpTZUZtQ21UM04zSlE2?=
 =?utf-8?B?YVpja2I2czNTZVhKWXpFck8wSmxITWg1eDc5L0toMTgycmVldzJ0M3BkYzRC?=
 =?utf-8?B?MERsWkNNNFA1bWdTKy9TZXBGWUhDNEdTZ0JuellYbFBOWVZHMERkc0lQZVpX?=
 =?utf-8?B?TkhsU2xnb1hpTzBNRGFZV3loeGpBeENNRlZtZlZ2K1lKK1NpbStsMEZkZDFF?=
 =?utf-8?B?bmVrWmFVcFpWY2YzWVVoeElud3dJWGVDeUZFSmtGR0ptNk1ER3V1WkswdCt0?=
 =?utf-8?B?QUdCNmllWHB1a01ZMGV1eithVzhwclRGSm9OdUJIRnppQUo5NXZEeGUvRklN?=
 =?utf-8?B?TTRaUXdGWVNVK0IyRjhDS3loRUJ6Vm1tc1VaWXhLMTlUZURveWlGL0J2Ny81?=
 =?utf-8?B?S0wycXN6dk84V2NQbUdweVFxS0ZqRFg5d0ZHdjZXOExzQ1lIRTZJczFGL21X?=
 =?utf-8?B?T3REd3BJdEFKTTl2eThGMTJRa0pZRHE1YTFkZHh5TE5jWEt3VDdtQnp6Mm5h?=
 =?utf-8?B?M1dVUWlOZDFPMFUyZTE0ZmtzOTFNWXo4cnowSTJhcGhhMHhEU0Rydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a01a4d2-acbc-444c-529e-08ded0863c86
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:46:49.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGiAsn0CSMzOn9r2CxEsCrbmAa8Jb07RRBIhTGCsIfQKtBapK0dxiXv1mLvr4XT0p/oZnLWcTXAhR9vN7+OSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5525

On Mon Jun 22, 2026 at 6:32 PM BST, Philipp Stanner wrote:
> synchronize_rcu() is a frequently used C function which is always safe
> to be called.
>=20
> Add a safe abstraction for synchronize_rcu().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/rcu.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)

