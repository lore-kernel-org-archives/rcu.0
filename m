Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86042FD668;
	Tue,  2 Dec 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764658633; cv=fail; b=cR9EXYOGozHXgORB02MwSGARs1QikAtkUgHkEk0joDQbC/xB9ItbIJSXBFREVx3vpCry4AlsGmXpfgM2UvJcudf+NMJ8S+KkVZnspSKjDh3f3sIs/ACsTJs507R9ANqi/A9xKFMCG+cOReQESCDh1omrhiJfReatRqqxfHK3mYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764658633; c=relaxed/simple;
	bh=Zc1lY6Gfm5SS1n3eEmqS/DdwYBpGbz0Mmh+ZBSsWsrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mzzk1rIys8FxG+wz42h4x9nc02B5rhiiV9GNL2jjtpsBiyIxobS6IpUAygDbivTA08KLsllxosA3J8nH0GEIsQSz5Dkh8cesMhAHuj5VMTOy02cpBHtuquezcwXChe9Gm03L14nSDlcIUhfVJ13v//xFZAwtsnuDitZ4eeJVFGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UTcfMyYk; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UTcfMyYk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8YHVWH2AfLSIbcp1MVWYJ7JzYXfkHU3sOJcCaFLd8ByQ0Wnl+YhL9WKbtHbCrDHA7nx5HL6SxGbwn1RIO0fRsRuS0nSnGVaOZsdEcVEm9GmOyf1aIje2fd7VQG8dZsoM6xJ2CCnud7mAtKx8CEnLqjyDf4NhRbo1oMwFSY5jmjtMIfY26+hhi97mkP4Muo6+nxMgpEIWHXud+NMW8JMT6K7eRgZ/Hci1CG15LVinOaIlO6AAncH2Qtkr0GQpA1pt7btzESGnEI+yJU23wJUhmCHlvzxGhTo5GPljricgAtZXvSDBLQJ/4PqKJUfQuKa427LsCdn9QqtvGSgG6opPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEn5nOVxaZ1KIOSZQ2uZECgXHla6IJ7wwj/QELjKSeM=;
 b=fWuSVV08rSn36jwIfH1YPsnC1whc5Acd1NGpOX1X41gjpZX1Ggs9965YiEjgMGlN85t/TvofNB5L7yHvU1aapoKuPdJCWqHSmXM+rrWXyDANkszTbhjHOAjuaVDHyEe385Xf0FcUoaKkIvkW7u3o4qFRUhEUVMJscVCz7hY60NEjhn0jz2y/rGQj+Tk+jnUURXp4MiNksx4xjE7DkoqNIdXfhNMAp/jZaDz2k0ZcJifveNeCit9Az9YhbQLYaah/KQ1aHJ+ixoNJpeUZ2XkZaa36bt90f/dxR4ZfRftXLwKgdhdWj/q8MyVnxkSX1l/m7nItAsXW4r9eDF+d6vlOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEn5nOVxaZ1KIOSZQ2uZECgXHla6IJ7wwj/QELjKSeM=;
 b=UTcfMyYku1DdpocRjrObwSEkG0wrmzR02QjcjKRNY5QScgB/VmCbkbwdbwiXV9RAh84HR/Sury8Nhx+WYuEXevjFw2CoQLYgmT4gpURGQtAOUE4yBCCi9+r2tvmmkNZ048ZUDpsW3MVIgp5sZfSzxGvDF0v4ysZGrzY/j+SXTUIi/K/jd3g+f8m5mUhnen6F21Txk9KoJWIBEbURxwoWRg7+sHzktUKoGVWAUCKtltbOZhMilU9GEVBmwecrJKxm6BU9Xq7yDSGjtAtDQZQrZC6AgOCT8pna3VIEEnWd9H0iGgyhtQGXKIAq+RCOyV+TAzwO4DAyiL4dm3LFJJxJxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:57:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:57:05 +0000
Message-ID: <00552531-d00a-4e29-898c-86f4474b12a7@siemens.com>
Date: Tue, 2 Dec 2025 07:57:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 stable-rt <stable-rt@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Pavel Machek <pavel@denx.de>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
 <aS4pgDjn1b8coe0r@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aS4pgDjn1b8coe0r@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3871:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e79b11-5c42-4e05-8c8c-08de31700117
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emx4ZTJPa1BpUzJ2SXJyQmlKMnZiRmxKZDkyM0ZUSHNoU0IyaUZPRTlkYWJt?=
 =?utf-8?B?QStKc2dqZHdHWDI1aE9ST1ltMUxFVEUyWndFYWtxVXJ0U0c0NVBSc0c2VzBv?=
 =?utf-8?B?N2ZCQUZGdGtXOVJUTDkrTUpMUzRTOVVyUWlaSmQ2VEQ5VHBWMk1rWXI1NFFI?=
 =?utf-8?B?L0pzWms0L0JTdTdCMWxlSWxzdmhjVW5GOGR4Qk9hYzlaS3lSdFFualdKUXAr?=
 =?utf-8?B?cGRuWDM2QjZZMDJiWUMvcFN4M1RLWjl2eWFMemJYV3VLamg5M3V0MUEzNnp6?=
 =?utf-8?B?RDA4STluQys3dVJjM1JqVysyTzA2QTg0eFBpT1lCQXZQWExOSGt1clNndlc5?=
 =?utf-8?B?cGExM0Z4UXp4RVFvQk9KekhtZEZVY25Ed212TUpCRS9ycFF5V1FVTUhLb1JY?=
 =?utf-8?B?bHFmazc0QUJCNmFUL3ZJbXBWS0NhOWNtRERxQWFRWWtGZUl1azhMcVRlMWZh?=
 =?utf-8?B?NUloa2llb0RhUGtyNHlMdGN4WlpqTVNyZzh5TnNlY0NVemRMckQxZ1FHQXJp?=
 =?utf-8?B?cHpyOHdUT3d1UXdoc3liMDBVZUtLWEVQcmQ4cVRUa2hQNlMyaVlKaU1jOGMz?=
 =?utf-8?B?K3pWSlRGMFg1a2l1RTNxc3k2cjJjOXhRN1NHTE1oUWxzMDVnQVk2YzRvdEQ3?=
 =?utf-8?B?Z3RGbkt4YUpzTXpQVkdYOEdRWkpJY05sL09yMkdxMFV0RDNYSlNqdnZyd3NK?=
 =?utf-8?B?a3oyMUhRck1SSlkvSWRHVytOL3dyays1WWlxWTZaNFlnMkJrNVlpT3A2WXRO?=
 =?utf-8?B?RkJkdHFjVmNuWmFRblJoVUg0N2dDZmhlbC9wdmRlTkhidG02b1hvUHF6ak1J?=
 =?utf-8?B?RzhtZDlXdURVdnJhZVEwZHJ2Y2hmSFBVenRidUpzdklsa1FZOEpacm8xaThw?=
 =?utf-8?B?d0xjL1N3dnlRR2ZodXFDQ2FuNW9pMzlhV1pwMFd2THhlYllDZVRnMmFRM2VJ?=
 =?utf-8?B?c3FNY3g5RHVjZ2FmVnhJanB4ZE9EV2VrODhjZVdKeituRis0RkJrUzN4aGRi?=
 =?utf-8?B?Vks3aGlCa2NOYTE1cUxYbzY5eHltYkMveDBEVW1aeTZoV1BSdHZEd0pWaUhk?=
 =?utf-8?B?SVVVWmFzYVZmYXptMEZKZVBkV2R5RVVUcXZXcFpudGMwL0ZDNjU4TmJhRU8z?=
 =?utf-8?B?Z2FsVi9SZHVOdVUxR1pPRkdNZUJYQklqUU5YT2xqZjJoeW9mMm1rQjVWZ1FE?=
 =?utf-8?B?UWZBUGt3d1FvRkNBd2JtVE9mVjFpclloa0tKdVU2L3lDT3p4ZmdjVmc3aG93?=
 =?utf-8?B?WUMrSmw0R1ArejdXM2dKVHFpakpraTJHeTQrbHljc0hZeGpmRGlkdE5WRFBV?=
 =?utf-8?B?TWFwUHdKbDJSdHVRUElkS3VyZDZrRkdzV3c5emY2cVNHMGJkQnBmUVVJMHlZ?=
 =?utf-8?B?TWQ4QzJlOE9YQ3cwWE9McmpZRWI0NFdlenZ0dVJKcWc5WnJOL25zZzI5MU90?=
 =?utf-8?B?blRsRklnNTBYOEZMUjhsaVVrMHZyWW1VVFh2RTlKQzRobENCcTgvWjBpWm83?=
 =?utf-8?B?amtrak9sbXJhT05hbW5zOHZVdXVWd01XamdSQnRja21zMkNlZmhjeVFpZjAw?=
 =?utf-8?B?UjRvRFZxU2RrYitvNXgvUkhvSVc3VnlUcEs1aUR4OFNzKzRsUSs0RG93R1A3?=
 =?utf-8?B?Rk13VVhHamszdHVmdEw3VnhoZjMrYitlT3ZzY1dyb2I3U0dLem5qQjE4U0xj?=
 =?utf-8?B?V2pHdnIreTh0anFEUzJtbzErQzcxSWZGNkM4V1NqbjhtNmVqZGZmdEJpbkww?=
 =?utf-8?B?UXVaTzNNQnh5NElPbEdaejVuWURlNU50TXdScm5xeFVheGNwaXEvUE1HWjc4?=
 =?utf-8?B?aURVTEVpSitFRUYwalpMY3h3U2YzWXRNbE1WenhpcnF6eE5PTzNYMVNlNkNN?=
 =?utf-8?B?SzdzMDhNWVRhYXBUcHplcjAvVGJCayswRnZDNmVMQlE1em81WllOM242NDNw?=
 =?utf-8?Q?Z3ZeDes4dELycYecFFmj/LF8TstQtVtP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTFhZWd6UVZ3TFZVNlFVazRJc1dLWTZtSS9aREo2U1k5L1p5bHZaTXpRK0J5?=
 =?utf-8?B?TGk5cVpEVU8rV2FMbFYvdlc3LzJhYzRqYVo3MlhDZEJtU1luc3FDYnJLMDdK?=
 =?utf-8?B?eVJFb215RlZUTUlSb3hsWDFSTXNkMmtLbE85VlI4YkVHaTBCZktnVEdGWEF0?=
 =?utf-8?B?bEllU2N3Z1ZUYXZEcFFxM21VS21NNjhRWlQ3TVd5WituSXFOelF0QVVwaDY2?=
 =?utf-8?B?cVBLR1hNRnp6MnJRUDdqQVA1T1JZSjlWQzlJU3Z0SkgvVmJJcUV5bS9yQ1la?=
 =?utf-8?B?S3hiUGhqRmtTNVBHVE50OXNGSFhwYkhFM21NU2hSUGpFYmpKTUpQbkpOUlBo?=
 =?utf-8?B?V3F4VzdOOHR0bVFZUEE4SGlkdSttc2hCekwvWURYd2QxK01UYnMzTU4yOWpz?=
 =?utf-8?B?REkyK3FOcmk0ZUx4YWJ5QkFlbHozWGpqZjliRjhVNmpnTnV1dXBYWXlHRzN6?=
 =?utf-8?B?cUZuemdSTEQ1SFZVbEdpREJLT1F2K0pxSnBFQktJWnVlSWNCQmFXSjI1QlZW?=
 =?utf-8?B?U2pURGFDbWJwTEN3UzNkS1FOaVIzT3hJZEpXRWtqaDhPQzJsR1VuSTh6R1I4?=
 =?utf-8?B?ZFlkMHNRb1lYMTRnZG90RUZDWFpEN0Y3akI5bnlzdmYrRHFrNWxmNE1TQW9t?=
 =?utf-8?B?Q1BPb3B1SjBCekRuMml2VmVKQnR0bCthTmxrTlFyQzdqL2thdnZMc25QN0N6?=
 =?utf-8?B?ZGZ6bEp3VjRKMVhNTWQ4V2pFTUttb0w3TzVuZXA5eVFyL2FjN0w1RFRzVit4?=
 =?utf-8?B?NHY3WWc1cFZIODN4b3JTMW4wUTBMNnI3bVRxc09UZWwvK1pGM1pVcjM4cStD?=
 =?utf-8?B?SmdVRU1icy84aG5xVkpjcVJJOCtnR3JrWVB3OUdObzAwRmx6T0VRWmw4aFow?=
 =?utf-8?B?azVIWnRjRUFybmhLSzBBbVlrdWtybExjSWV5SEFicFV5QmpkMCszNVpvNkpn?=
 =?utf-8?B?K0FqN0RnVVFoaTlOOGRFVlc3YmpBb2FmNjhiT2YrR0d0aTZXaDZiYTRxc0hS?=
 =?utf-8?B?MVhhS2VBNVhKNzBuUjBjeC82clMvdEllZUFkZWZ0aWpKcEJqUWRtOStRVmdP?=
 =?utf-8?B?VnBNQnN4a0tqOWcxQUcyZFlJOHhTTlFMVHZ3ZHVXWGhWRVJUYnNrdzhvM0VT?=
 =?utf-8?B?TXBkek9PR1lzYjNrUWRSRm54MHQyTjRnUGxOMXQ5RUIwUW1qZkIxYkJ5dEdv?=
 =?utf-8?B?NFpHc0w2U3VBZTF6ajkrbmN0cFpQaTZuZk5KRGptWUo0NnRnMHp3dk50SjNO?=
 =?utf-8?B?YWlZejlDektXZTNCeFVDbVNJcWdHSCtvNFVvMEVad3praFdPL0oxTGtVbmVM?=
 =?utf-8?B?Vm03dHBiY3ZQYnVOeGVJVCt1bURoVG1LYjFtQk9aSjd3UWVjNVBTc3RUclRJ?=
 =?utf-8?B?RWZzSFJTNkVFNXFpWnpuci9LQlMxb0lZY1ZTU3VOV1dIWUxocWd1ZTdZY2ky?=
 =?utf-8?B?RkFBbHdXNVpRMk1yUG9nMEppWE0ySUJRZlFuOWd5Z3djMGhhaUpKMjRkWEFQ?=
 =?utf-8?B?ZHRuVmNaZGRmb2dwMERaM2R4cGxhWElGc3NOd1hJOFM3NWpqMjRGRkVOb1R6?=
 =?utf-8?B?eTRiRThlTnF5b2pxcGp1K3g4dlU5OEc3VWhYdFlobldDcW8zejR0TTU1SWRi?=
 =?utf-8?B?Z2VLbE41bVNMK2Z0YllpY1hEOUFXTzdwZFUrSEpLWXNwNzhtQmloZlkzdGhx?=
 =?utf-8?B?QUI1d3V6TEdySExacTFQUWt3K1BiM1Bac2xheWZMcGN2Y2gzSEZmRGhodVY4?=
 =?utf-8?B?RHRxZnRmMDhtY3ZsSkZOQVF0dnBxZ0ZVMEhlV0pDVGp4bUZpRjZSa05nbzZG?=
 =?utf-8?B?dythbS9wQ2Q2WC9ObVVhSVdRUzY5NkRMMjF0TjBjMm9ZdkQ4NElzZmRtY3Mw?=
 =?utf-8?B?RHZYbG1OdGxhQ0xYUmpPenpLOFV2eGFLRGp5enBXZGxybWNOZ1FvdEpTSi8x?=
 =?utf-8?B?SXp4ZjExSTRrR1RTdDl2SjR3Q2dUZVU3YmNCRU9jZW93dUlsd3dqZVFNcjJl?=
 =?utf-8?B?OUJnZDNCZTJ2Nmg1VXlqRkpNNWpCWDlnT0d6REVCZUZYVisrTFBmQVdpS3Rn?=
 =?utf-8?B?RlIxN2RuZW1YRmQvM1pGYnFiSnJ1dWtxaG8zNGR0UWF4c1hJaVVPcGlPMUJq?=
 =?utf-8?B?OURQRStFUVhsWk4zRis4WG1NM3Q2ZG5oUkp4TE9WaElsQzlRRlZuZVNzTVl4?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e79b11-5c42-4e05-8c8c-08de31700117
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:57:05.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7fTSZu7RKkgi49jnAMqP0vd6XfVjUuMHt5ltX/fPFbuZflrOPSIeA+VSlxSJiZQkpBaV6m6lp3Y6/tOwrcUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3871

On 02.12.25 00:49, Luis Claudio R. Goncalves wrote:
> On Mon, Dec 01, 2025 at 10:51:50PM +0100, Jan Kiszka wrote:
>> On 06.11.24 15:51, Sebastian Andrzej Siewior wrote:
>>> A timer/ hrtimer softirq is raised in-IRQ context. With threaded
>>> interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
>>> for the processing of the softirq. ksoftirqd runs as SCHED_OTHER which
>>> means it will compete with other tasks for CPU ressources.
>>> This can introduce long delays for timer processing on heavy loaded
>>> systems and is not desired.
>>>
>>> Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
>>> timers thread and let it run at the lowest SCHED_FIFO priority.
>>> Wake-ups for RT tasks happen from hardirq context so only timer_list timers
>>> and hrtimers for "regular" tasks are processed here. The higher priority
>>> ensures that wakeups are performed before scheduling SCHED_OTHER tasks.
>>>
>>> Using a dedicated variable to store the pending softirq bits values
>>> ensure that the timer are not accidentally picked up by ksoftirqd and
>>> other threaded interrupts.
>>> It shouldn't be picked up by ksoftirqd since it runs at lower priority.
>>> However if ksoftirqd is already running while a timer fires, then
>>> ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
>>> Ideally we try to avoid having ksoftirqd running.
>>>
>>> The timer thread can pick up pending softirqs from ksoftirqd but only
>>> if the softirq load is high. It is not be desired that the picked up
>>> softirqs are processed at SCHED_FIFO priority under high softirq load
>>> but this can already happen by a PI-boost by a force-threaded interrupt.
>>>
>>> [ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
>>>   local_timers_pending() for tick_nohz_next_event() ]
>>>
>>> [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
>>>   softirq is currently served. ]
>>>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> This went into 6.13 and was never backported to 6.12-lts. And that is
>> why you can easily stall the latter with a workload like this and
>> CONFIG_PREEMPT_RT enabled:
>>
>> echo "+cpu" >> /sys/fs/cgroup/cgroup.subtree_control
>> echo "+cpuset" >> /sys/fs/cgroup/cgroup.subtree_control
>>
>> mkdir /sys/fs/cgroup/stalltest.sub1
>> mkdir /sys/fs/cgroup/stalltest.sub2
>> sleep 10000000 &
>> pid=$!
>>
>> systemd-run --slice "stalltest.slice" taskset -c 0 sh -c " \
>>     while true; do
>>         echo $pid > /sys/fs/cgroup/stalltest.sub1/cgroup.procs;
>>         echo $pid > /sys/fs/cgroup/stalltest.sub2/cgroup.procs;
>>     done"
>>
>> echo "1000 20000" > /sys/fs/cgroup/stalltest.slice/cpu.max
>>
>> This triggers a lock-up if a holder of cgroup_file_kn_lock with
>> SCHED_OTHER is scheduled out after using up its timeslice and then
>> cgroup_file_notify_timer fires over a SCHED_OTHER context as well,
>> trying to get this lock, failing and then never being able to reactivate
>> the lock holder again as well.
>>
>> I've nicely reproduced this with upstream 6.12.58 while Debian's lastest
>> 6.12-rt does not trigger because it additionally has the downstream -rt
>> patches on board.
>>
>> How should we handle this? Consider 6.12 mainline with -rt and cgroups
>> as potentially broken, asking people to user 6.12-rt? Or port this back?
>>
>> BTW, the original report of this issue came from an older
>> 5.10.194-cip39-rt16 kernel (based on rt94 for 5.10). When was this
>> feature introduced to the -rt patches? Was it ever backported to 5.10-rt
>> or other -rt versions?
> 
> Hi Jan!
> 
> I failed to locate the original discussion (from v5.10-rt) as the V1 of this
> patchset is a new thread. Anyway, you are correct, the commit below (and the
> other two changes from the series) are not present in v5.10-rt.
> 
> AFAICT commit 49a17639508c ("softirq: Use a dedicated thread for timer wakeups
> on PREEMPT_RT.") was merged initially to v6.13-rc1, it was never exclusive
> to the RT tree.

So, we have this right now in the 6.12-rt and 6.1-rt trees. The patch
(b12e35832805) that enabled the lockup above was added to 4.18. In
4.19-rt (still under maintenance via 4.19-cip-rt), we had ktimersoftd -
was that addressing the issue as well? Or could timers have expired back
then also outside of that thread, thus potentially without SCHED_FIFO prio?

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
