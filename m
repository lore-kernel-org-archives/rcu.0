Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C8288D2
	for <rcu@vger.kernel.org>; Mon, 29 Dec 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766976602; cv=none; b=HrSbv9M3xrXps1pqkPDfKeFX4xTsX1re5LyKkAzzu9pkfCRvefcl4ttTF4Wd3ZaRDs01SCHsdmaO6wSPd3RjEprgHs1yrDg/D8aPrvJkABbE1PiIAh2sL7JEOzWRZyi3VAkbEbSGnsRbudUIfA/FKTOv2X1QGs8y/p0SI1ubIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766976602; c=relaxed/simple;
	bh=ZbLyZ7YLNpObBom6uHN3L6U3AFdIz31W+GcCVMDnzqs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iJyPj5ZVOxiLFvrvUTEqavClI5NoOOTiQ+5GXAFo9HdISwOjExoUmK2HP6dCEf+O91Zo9TsGh45MjPyHLGX/BL6pWGpo+YPDiL1pRKOPrRpFlUQ46iyo7ObgyydDUDswEQqNJLOUqb7mCPE2eDSyG/AJgDZIhO0STMVj7mAkS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=s4xOsScA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s4xOsScA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c2af7d09533so2804148a12.1
        for <rcu@vger.kernel.org>; Sun, 28 Dec 2025 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1766976599; x=1767581399; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h1sBpMAl8b+Tm8ZbG9lvOl1MMOPigKFisaIz5mxJ1A=;
        b=s4xOsScA6Fmew9p5X8FZhqU2Yp5bdWAKgWIzQCMwBERz6ibfOZEXM8o1BP/7ir34K5
         p3Ek4GWMP/oAQMfDgppg+RmtDRVYuA0VWDhVNDiKUCMICVfMX2Kq9It7LX9wZFd//gV7
         c1xDdRplxKA+yuXFEXErHYTozME6B81W+djDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766976599; x=1767581399;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2h1sBpMAl8b+Tm8ZbG9lvOl1MMOPigKFisaIz5mxJ1A=;
        b=lK1HBKcJRDEyTzbSD7p3ItHG8nGrHRN68BwPr430/WOe6bj7Xv4h2Vehu5+hp8n4ug
         GiLBISafpsJACUI2cSDF/IyvT2XfkVNmheEjClYSG4azFbOPSavQbE/kALF/LZSuY9B3
         NS44IpYHLe0Z8siHU2xNEwDM+dRhu0fObw23QvDRQ2H8e7KR+IezLKw76BWb4MJqyRrM
         WSeOpov8T6H+rsOptujorJbAulc6I8T6nowSGqlScHqzciKUepJyCAx8t9jdkIyw08x7
         niElVBcTE2Z/HmoxT4OYUiFScszxagv8BNMTJT8FML1npwpHoSVyihKZJzK4jS/5SeIu
         /WJA==
X-Forwarded-Encrypted: i=1; AJvYcCWBZlEQcmAfN2+BfZn28uC4z8qP4RQuFa6N2aSmngxhhgmzih/IpRrSY6Nftf+2bT1uoqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwygT9QM4j3yv0Osedx2N9mUpcHxbbK2/qqRZuon7L2akIyNqZj
	Gs/4ZRI5TkMiXf2dhawgWG7dUxem3of3Lp4jPj/CiNjQgF9vuDjuu7YsXlH6/+kWqMA=
X-Gm-Gg: AY/fxX5zgCG+eShv4ldROrhsrLJgdnKa/xXCsVvrcyJo+xIK8re2XvbyNCPUMhaS5Uv
	nMJT4CFYr3ssL26zt/gEmJwv2AYqGGKBHSpWO059MbonG0x1S5Nmb8J6TvDSGbUT88aSoxqjNU/
	BzLKP5UAvHIs95Gt20K9jwr1LSKaL0+935P25x4hoMKty8e9ZHzWuQxhmxz/kwv2Ibmwr1/7B+p
	K3KHuZhCnAoWtgwEYYkBy+zg/iKJEjliAFpNGyMG/7efYGWkQCa3vGUA71cPYDpgvS6/CoSSKpe
	ViIXtW4C7kOkF52tGXoQq1sVjMmhgwMG8p/aDCurCDkpxu2QDpFWMm+gVVyHnMlpsA4z8g4nw2B
	RN0svXDvtNORxH1Y8QZes9yrxE9KLZ32jSMHY5IUdXDEvrjWkjZA6ssOMylQ3R7chTi6DAgHc2j
	EZEta3tZn4A6G/Ztvc+MVg1eIGHTRL/mXOvA==
X-Google-Smtp-Source: AGHT+IGA5z+3P7iIiwzIb0CLYNbRtQK9ja0eMqatq9l0TI2G8hg0yFEiG4TFyiY6gzsWSlf2GUZbXg==
X-Received: by 2002:a05:7022:3705:b0:11a:51a8:ec9 with SMTP id a92af1059eb24-121722e8081mr19818227c88.29.1766976598561;
        Sun, 28 Dec 2025 18:49:58 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm85183842c88.10.2025.12.28.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 18:49:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() latency by reporting GP kthread's CPU QS early
Date: Sun, 28 Dec 2025 21:49:45 -0500
Message-Id: <164E7707-758C-44AA-BB75-B6560725C8CD@joelfernandes.org>
References: <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
In-Reply-To: <1033a68f-c17b-4847-819d-7fb4e9e45016@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (23B85)



> On Dec 28, 2025, at 7:04=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Sun, Dec 28, 2025 at 06:57:58PM +0100, Uladzislau Rezki wrote:=

>>> On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
>>> On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
>>>> On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
>>>>> The RCU grace period mechanism uses a two-phase FQS (Force Quiescent
>>>>> State) design where the first FQS saves dyntick-idle snapshots and
>>>>> the second FQS compares them. This results in long and unnecessary lat=
ency
>>>>> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each with=

>>>>> 1000HZ) whenever one FQS wait sufficed.
>>>>>=20
>>>>> Some investigations showed that the GP kthread's CPU is the holdout CP=
U
>>>>> a lot of times after the first FQS as - it cannot be detected as "idle=
"
>>>>> because it's actively running the FQS scan in the GP kthread.
>>>>>=20
>>>>> Therefore, at the end of rcu_gp_init(), immediately report a quiescent=

>>>>> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp(). T=
he
>>>>> GP kthread cannot be in an RCU read-side critical section while runnin=
g
>>>>> GP initialization, so this is safe and results in significant latency
>>>>> improvements.
>>>>>=20
>>>>> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs each
>>>>> showing significant latency improvements (default settings for fqs jif=
fies):
>>>>>=20
>>>>> Baseline (without fix):
>>>>> | Run | Mean      | Min      | Max       |
>>>>> |-----|-----------|----------|-----------|
>>>>> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
>>>>> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
>>>>> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
>>>>> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
>>>>> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
>>>>> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
>>>>> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
>>>>> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
>>>>> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
>>>>> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
>>>>>=20
>>>>> With fix:
>>>>> | Run | Mean     | Min      | Max       |
>>>>> |-----|----------|----------|-----------|
>>>>> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
>>>>> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
>>>>> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
>>>>> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
>>>>> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
>>>>> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
>>>>> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
>>>>> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
>>>>> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
>>>>> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
>>>>>=20
>>>>> Summary:
>>>>> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
>>>>> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
>>>>>=20
>>>>> Tested rcutorture TREE and SRCU configurations.
>>>>>=20
>>>>> [apply paulmck feedack on moving logic to rcu_gp_init()]
>>>>=20
>>>> If anything, these numbers look better, so good show!!!
>>>=20
>>> Thanks, I ended up collecting more samples in the v2 to further confirm t=
he
>>> improvements.
>>>=20
>>>> Are there workloads that might be hurt by some side effect such
>>>> as increased CPU utilization by the RCU grace-period kthread?  One
>>>> non-mainstream hypothetical situation that comes to mind is a kernel
>>>> built with SMP=3Dy but running on a single-CPU system with a high-frequ=
ence
>>>> periodic interrupt that does call_rcu().  Might that result in the RCU
>>>> grace-period kthread chewing up the entire CPU?
>>>=20
>>> There are still GP delays due to FQS, even with this change, so it could=
 not
>>> chew up the entire CPU I believe. The GP cycle should still insert delay=
s
>>> into the GP kthread. I did not notice in my testing that synchronize_rcu=
()
>>> latency dropping to sub millisecond, it was still limited by the timer w=
heel
>>> delays and the FQS delays.
>>>=20
>>>> For a non-hypothetical case, could you please see if one of the
>>>> battery-powered embedded guys would be willing to test this?
>>>=20
>>> My suspicion is the battery-powered folks are already running RCU_LAZY t=
o
>>> reduce RCU activity, so they wouldn't be effected. call_rcu() during idl=
eness
>>> will be going to the bypass. Last I checked, Android and ChromeOS were b=
oth
>>> enabling RCU_LAZY everywhere (back when I was at Google).
>>>=20
>>> Uladzislau works on embedded (or at least till recently) and had recentl=
y
>>> checked this area for improvements so I think he can help quantify too
>>> perhaps. He is on CC. I personally don't directly work on embedded at th=
e
>>> moment, just big compute hungry machines. ;-) Uladzislau, would you have=
 some
>>> time to test on your Android devices?
>>>=20
>> I will check the patch on my home based systems, big machines also :)
>> I do not work with mobile area any more thus do not have access to our
>> mobile devices. In fact i am glad that i have switched to something new.
>> I was a bit tired by the applied Google restrictions when it comes to
>> changes to the kernel and other Android layers.
>=20
> How quickly I forget!  ;-)
>=20
> Any thoughts on who would be a good person to ask about testing Joel's
> patch on mobile platforms?

Maybe Suren? As precedent and fwiw, When rcu_normal_wake_from_gp optimizatio=
n happened, it only improved things for Android.

Also Android already uses RCU_LAZY so this should not affect power for non-h=
urry usages.

Also networking bridge removal depends on synchronize_rcu() latency. When I f=
orced rcu_normal_wake_from_gp on large machines, it improved bridge removal s=
peed by about 5% per my notes. I would expect similar improvements with this=
.

thanks,

- Joel

>=20
>                            Thanx, Paul
>=20
