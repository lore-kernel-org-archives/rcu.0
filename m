Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F92C21F7
	for <rcu@vger.kernel.org>; Mon, 29 Dec 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767040617; cv=none; b=u9khFRfPiU+7IGDdYzFFzwjd+TTDoOrsdxORpR5EpUJsRNO8plU8tdsyhsOxTyLtl0e585Zk0n+/azm5XSDRWvGmp7Z26GEv/nPwXA9bXNrniGZ/FLtCgTDhA7eD/GUF7Zt0LJY1BUNv+3Y05866p2SQuJTvkb4cvoITAEgONwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767040617; c=relaxed/simple;
	bh=4xawZ7EuzVrDdEWTzi/86OtBMKCvwE4p5nnjJtYb9d0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fPdrutdgpKvLy1STfx3E6s7P7IeQAzuC1dDiFDkm5JWXpiDNQrA5tiujx04cSIH9s44h+JIN6SiLGsyxt2sy27PtK3mLFvB6+b1fRfQoetB2AnFjRgOQZGh9JWBqAA0BgNg+3Fv9y5YdYwBr5NSqAITHll7RsGhTlk1JK3R/gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=GCRAIl5t; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GCRAIl5t"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8bb6a27d407so907358985a.0
        for <rcu@vger.kernel.org>; Mon, 29 Dec 2025 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767040613; x=1767645413; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmODKxLKg8F3u3m6jiipHg9gspCQmacOU/P97q66JTk=;
        b=GCRAIl5txs/hj/bbsXac67BE2JBclUg0wZ5DeqF1EOEFEqlXH07oJkEWC6mN6M9QDd
         4fcjy2mxsQv185hmIro0RprZKGY4BkeZChMbAr8flKjv58HqwXB15LSVVRoBbFUsNDWm
         i2NG115xjXQIuYrOL6u9dJew98TBU6PHjb8aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767040613; x=1767645413;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmODKxLKg8F3u3m6jiipHg9gspCQmacOU/P97q66JTk=;
        b=PkKSMD1zh+zxMXR47/gyeegF6F4XQPXXdjlITAj+exhN9enJr0MYGwerybOG/V5bBb
         M0MSBI09GOcDLTNFVoYoWl9e9jaH0rWyBbwxu8jT1oFbO1UDtCIux1sLC9KX+nb4bg9b
         YBDSpfRqXy1F1Vvk/HXz4bnkkUhEzTsSBm3ncGvOV/f1nYQ34bzA9V9e9/Ml185RPgy0
         sBrWZA2dj+1VDkdIxgvS4keQooDJ9ML8m9X7AhCWYdQRMMltDceC4BB7IHM3tqk4+MDx
         OVJxQ3aCkyVZanZxWeBey0XxoavsZB3Mnp9VqKl8hJHRtAm9zFTA1wqranyX1pih/WUB
         3qKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFMsy26W04164G/CEZsgBbQmA4ZNfZYgCXIdm464pCVePnSZtoQ35JU1tYL5NNoctkGPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCiSNVww7j2+ZFF5AcPpIOQsmykX8XuP9jKG3bHAuPoPnN+gd
	1gGmU+JtjFZFxuO1cMPbupiRn4d4sZ3j334jhXEOkRAMAQl1ZuY5BbG8bBmpkMj6fyM=
X-Gm-Gg: AY/fxX6wgQWY4f5Q6YIKa9cjDH0HukCGXWdRR7/Rk0Y834qO9vzPE7q5FnROd0B+1z9
	joH1zhnlvkJkt9jQTmzA3iiSFBJ2HL1t+BBqjqojdiB6dCLK7AEil5wwOl2Yqyk1tDhIewK99Px
	PrJa5Z9RnwW8SstqkbQxM6POfPiqr43cn3D1L24Yw43GtBfSsTRsrRIa+Or/NhWVHusH24frYcC
	BjacLP4apJsmtSIcF/MdJkO430vZDpp8gCSxTaJzL4XCssIYcKhEb7N/5UfScxb9cUrtqvaqx20
	L+7RVzJlCYoGh1bzG2/fOnLVCa5S/Wxa4gv/724aAFeU7ZCJfKC9Vjq5XplQsQgr+Su/aRUy98P
	x0SkTD7oMUYJ/zyvCfyrz6FT0k4R+CrAtaaHYC915pn4xYv3dXzwYCk23t8qSt9QSWvLOuX4zyN
	Tjp/hvBdm3nJ63mYV7T8zOtLjevNT3abp9pHRJ9GOMY5l8+w==
X-Google-Smtp-Source: AGHT+IFcfbEFWR1hzTMBp1o+IAqtouU8BsCxq609SLjgXpi5yWeLHR5V00Ld0QIGd0rkZFJfYx35fQ==
X-Received: by 2002:a05:620a:7005:b0:8b2:e598:e319 with SMTP id af79cd13be357-8c08fd22e6bmr4877036285a.49.1767040612781;
        Mon, 29 Dec 2025 12:36:52 -0800 (PST)
Received: from smtpclient.apple ([2607:fb90:b3ad:c4fd:98e2:de7a:8559:692])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm2461454385a.4.2025.12.29.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 12:36:52 -0800 (PST)
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
Date: Mon, 29 Dec 2025 15:36:39 -0500
Message-Id: <501F3B9B-C5A2-4537-A8E2-50D33164EFD5@joelfernandes.org>
References: <f1efe6ef-46e6-4ea7-a3cc-de7ac9ac3b4b@paulmck-laptop>
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
In-Reply-To: <f1efe6ef-46e6-4ea7-a3cc-de7ac9ac3b4b@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (23B85)



> On Dec 29, 2025, at 12:02=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org=
> wrote:
>=20
> =EF=BB=BFOn Mon, Dec 29, 2025 at 05:25:24PM +0100, Uladzislau Rezki wrote:=

>>> On Mon, Dec 29, 2025 at 07:53:59AM -0800, Paul E. McKenney wrote:
>>> On Mon, Dec 29, 2025 at 02:28:43PM +0100, Uladzislau Rezki wrote:
>>>> On Sun, Dec 28, 2025 at 09:49:45PM -0500, Joel Fernandes wrote:
>>>>>=20
>>>>>=20
>>>>>> On Dec 28, 2025, at 7:04=E2=80=AFPM, Paul E. McKenney <paulmck@kernel=
.org> wrote:
>>>>>>=20
>>>>>> =EF=BB=BFOn Sun, Dec 28, 2025 at 06:57:58PM +0100, Uladzislau Rezki w=
rote:
>>>>>>>> On Thu, Dec 25, 2025 at 09:33:39PM -0500, Joel Fernandes wrote:
>>>>>>>> On Thu, Dec 25, 2025 at 10:35:44AM -0800, Paul E. McKenney wrote:
>>>>>>>>> On Mon, Dec 22, 2025 at 10:46:29PM -0500, Joel Fernandes wrote:
>>>>>>>>>> The RCU grace period mechanism uses a two-phase FQS (Force Quiesc=
ent
>>>>>>>>>> State) design where the first FQS saves dyntick-idle snapshots an=
d
>>>>>>>>>> the second FQS compares them. This results in long and unnecessar=
y latency
>>>>>>>>>> for synchronize_rcu() on idle systems (two FQS waits of ~3ms each=
 with
>>>>>>>>>> 1000HZ) whenever one FQS wait sufficed.
>>>>>>>>>>=20
>>>>>>>>>> Some investigations showed that the GP kthread's CPU is the holdo=
ut CPU
>>>>>>>>>> a lot of times after the first FQS as - it cannot be detected as "=
idle"
>>>>>>>>>> because it's actively running the FQS scan in the GP kthread.
>>>>>>>>>>=20
>>>>>>>>>> Therefore, at the end of rcu_gp_init(), immediately report a quie=
scent
>>>>>>>>>> state for the GP kthread's CPU using rcu_qs() + rcu_report_qs_rdp=
(). The
>>>>>>>>>> GP kthread cannot be in an RCU read-side critical section while r=
unning
>>>>>>>>>> GP initialization, so this is safe and results in significant lat=
ency
>>>>>>>>>> improvements.
>>>>>>>>>>=20
>>>>>>>>>> I benchmarked 100 synchronize_rcu() calls with 32 CPUs, 10 runs e=
ach
>>>>>>>>>> showing significant latency improvements (default settings for fq=
s jiffies):
>>>>>>>>>>=20
>>>>>>>>>> Baseline (without fix):
>>>>>>>>>> | Run | Mean      | Min      | Max       |
>>>>>>>>>> |-----|-----------|----------|-----------|
>>>>>>>>>> | 1   | 10.088 ms | 9.989 ms | 18.848 ms |
>>>>>>>>>> | 2   | 10.064 ms | 9.982 ms | 16.470 ms |
>>>>>>>>>> | 3   | 10.051 ms | 9.988 ms | 15.113 ms |
>>>>>>>>>> | 4   | 10.125 ms | 9.929 ms | 22.411 ms |
>>>>>>>>>> | 5   |  8.695 ms | 5.996 ms | 15.471 ms |
>>>>>>>>>> | 6   | 10.157 ms | 9.977 ms | 25.723 ms |
>>>>>>>>>> | 7   | 10.102 ms | 9.990 ms | 20.224 ms |
>>>>>>>>>> | 8   |  8.050 ms | 5.985 ms | 10.007 ms |
>>>>>>>>>> | 9   | 10.059 ms | 9.978 ms | 15.934 ms |
>>>>>>>>>> | 10  | 10.077 ms | 9.984 ms | 17.703 ms |
>>>>>>>>>>=20
>>>>>>>>>> With fix:
>>>>>>>>>> | Run | Mean     | Min      | Max       |
>>>>>>>>>> |-----|----------|----------|-----------|
>>>>>>>>>> | 1   | 6.027 ms | 5.915 ms |  8.589 ms |
>>>>>>>>>> | 2   | 6.032 ms | 5.984 ms |  9.241 ms |
>>>>>>>>>> | 3   | 6.010 ms | 5.986 ms |  7.004 ms |
>>>>>>>>>> | 4   | 6.076 ms | 5.993 ms | 10.001 ms |
>>>>>>>>>> | 5   | 6.084 ms | 5.893 ms | 10.250 ms |
>>>>>>>>>> | 6   | 6.034 ms | 5.908 ms |  9.456 ms |
>>>>>>>>>> | 7   | 6.051 ms | 5.993 ms | 10.000 ms |
>>>>>>>>>> | 8   | 6.057 ms | 5.941 ms | 10.001 ms |
>>>>>>>>>> | 9   | 6.016 ms | 5.927 ms |  7.540 ms |
>>>>>>>>>> | 10  | 6.036 ms | 5.993 ms |  9.579 ms |
>>>>>>>>>>=20
>>>>>>>>>> Summary:
>>>>>>>>>> - Mean latency: 9.75 ms -> 6.04 ms (38% improvement)
>>>>>>>>>> - Max latency:  25.72 ms -> 10.25 ms (60% improvement)
>>>>>>>>>>=20
>>>>>>>>>> Tested rcutorture TREE and SRCU configurations.
>>>>>>>>>>=20
>>>>>>>>>> [apply paulmck feedack on moving logic to rcu_gp_init()]
>>>>>>>>>=20
>>>>>>>>> If anything, these numbers look better, so good show!!!
>>>>>>>>=20
>>>>>>>> Thanks, I ended up collecting more samples in the v2 to further con=
firm the
>>>>>>>> improvements.
>>>>>>>>=20
>>>>>>>>> Are there workloads that might be hurt by some side effect such
>>>>>>>>> as increased CPU utilization by the RCU grace-period kthread?  One=

>>>>>>>>> non-mainstream hypothetical situation that comes to mind is a kern=
el
>>>>>>>>> built with SMP=3Dy but running on a single-CPU system with a high-=
frequence
>>>>>>>>> periodic interrupt that does call_rcu().  Might that result in the=
 RCU
>>>>>>>>> grace-period kthread chewing up the entire CPU?
>>>>>>>>=20
>>>>>>>> There are still GP delays due to FQS, even with this change, so it c=
ould not
>>>>>>>> chew up the entire CPU I believe. The GP cycle should still insert d=
elays
>>>>>>>> into the GP kthread. I did not notice in my testing that synchroniz=
e_rcu()
>>>>>>>> latency dropping to sub millisecond, it was still limited by the ti=
mer wheel
>>>>>>>> delays and the FQS delays.
>>>>>>>>=20
>>>>>>>>> For a non-hypothetical case, could you please see if one of the
>>>>>>>>> battery-powered embedded guys would be willing to test this?
>>>>>>>>=20
>>>>>>>> My suspicion is the battery-powered folks are already running RCU_L=
AZY to
>>>>>>>> reduce RCU activity, so they wouldn't be effected. call_rcu() durin=
g idleness
>>>>>>>> will be going to the bypass. Last I checked, Android and ChromeOS w=
ere both
>>>>>>>> enabling RCU_LAZY everywhere (back when I was at Google).
>>>>>>>>=20
>>>>>>>> Uladzislau works on embedded (or at least till recently) and had re=
cently
>>>>>>>> checked this area for improvements so I think he can help quantify t=
oo
>>>>>>>> perhaps. He is on CC. I personally don't directly work on embedded a=
t the
>>>>>>>> moment, just big compute hungry machines. ;-) Uladzislau, would you=
 have some
>>>>>>>> time to test on your Android devices?
>>>>>>>>=20
>>>>>>> I will check the patch on my home based systems, big machines also :=
)
>>>>>>> I do not work with mobile area any more thus do not have access to o=
ur
>>>>>>> mobile devices. In fact i am glad that i have switched to something n=
ew.
>>>>>>> I was a bit tired by the applied Google restrictions when it comes t=
o
>>>>>>> changes to the kernel and other Android layers.
>>>>>>=20
>>>>>> How quickly I forget!  ;-)
>>>>>>=20
>>>>>> Any thoughts on who would be a good person to ask about testing Joel'=
s
>>>>>> patch on mobile platforms?
>>>>>=20
>>>>> Maybe Suren? As precedent and fwiw, When rcu_normal_wake_from_gp optim=
ization happened, it only improved things for Android.
>>>>>=20
>>>>> Also Android already uses RCU_LAZY so this should not affect power for=
 non-hurry usages.
>>>>>=20
>>>>> Also networking bridge removal depends on synchronize_rcu() latency. W=
hen I forced rcu_normal_wake_from_gp on large machines, it improved bridge r=
emoval speed by about 5% per my notes. I would expect similar improvements w=
ith this.
>>>>>=20
>>>> Here we go with some results. I tested bridge setup test case(100 loops=
):
>>>>=20
>>>> <snip>
>>>> urezki@pc638:~$ cat bridge.sh
>>>> #!/bin/sh
>>>>=20
>>>> BRIDGE=3D"virbr0"
>>>> NETWORK=3D"192.0.0.1"
>>>>=20
>>>> # setup bridge
>>>> sudo brctl addbr ${BRIDGE}
>>>> sudo ifconfig ${BRIDGE} ${NETWORK} up
>>>> sudo ifconfig ${BRIDGE} ${NETWORK} down
>>>>=20
>>>> sudo brctl delbr ${BRIDGE}
>>>> urezki@pc638:~$
>>>> <snip>
>>>>=20
>>>> 1)
>>>> # /tmp/default.txt
>>>> urezki@pc638:~$ time for i in $(seq 1 100); do ./bridge.sh; done
>>>> real    0m24.221s
>>>> user    0m1.875s
>>>> sys     0m2.013s
>>>> urezki@pc638:~$
>>>>=20
>>>> 2)
>>>> # echo 1 > /sys/module/rcutree/parameters/enable_joel_patch
>>>> # /tmp/enable_joel_patch.txt
>>>> urezki@pc638:~$ time for i in $(seq 1 100); do ./bridge.sh; done
>>>> real    0m20.754s
>>>> user    0m1.950s
>>>> sys     0m1.888s
>>>> urezki@pc638:~$
>>>>=20
>>>> 3)
>>>> # echo 1 > /sys/module/rcutree/parameters/enable_joel_patch
>>>> # echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>>>> # /tmp/enable_joel_patch_enable_rcu_normal_wake_from_gp.txt
>>>> urezki@pc638:~$ time for i in $(seq 1 100); do ./bridge.sh; done
>>>> real    0m15.895s
>>>> user    0m2.023s
>>>> sys     0m1.935s
>>>> urezki@pc638:~$
>>>>=20
>>>> 4)
>>>> # echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>>>> # /tmp/enable_rcu_normal_wake_from_gp.txt
>>>> urezki@pc638:~$ time for i in $(seq 1 100); do ./bridge.sh; done
>>>> real    0m18.947s
>>>> user    0m2.145s
>>>> sys     0m1.735s
>>>> urezki@pc638:~$
>>>>=20
>>>> x86_64/64CPUs(in usec)
>>>>          1         2         3       4
>>>> median: 37249.5   31540.5   15765   22480
>>>> min:    7881      7918      9803    7857
>>>> max:    63651     55639     31861   32040
>>>>=20
>>>> 1 - default;
>>>> 2 - Joel patch
>>>> 3 - Joel patch + enable_rcu_normal_wake_from_gp
>>>> 4 - enable_rcu_normal_wake_from_gp
>>>>=20
>>>> Joel patch + enable_rcu_normal_wake_from_gp is a winner.
>>>> Time dropped from 24 seconds to 15 seconds to complete the test.
>>>=20
>>> There was also an increase in system time from 1.735s to 1.935s with
>>> Joel's patch, correct?  Or is that in the noise?
>>>=20
>>=20
>> See below 5 run with just posted "sys" time:
>>=20
>> #default
>> sys     0m1.936s
>> sys     0m1.894s
>> sys     0m1.937s
>> sys     0m1.698s
>> sys     0m1.740s
>>=20
>> # Joel patch
>> sys     0m1.753s
>> sys     0m1.667s
>> sys     0m1.861s
>> sys     0m1.930s
>> sys     0m1.896s
>>=20
>> i do not see increase, IMO it is a noise.
>=20
> Even better, thank you!

Thanks a lot Vlad and Paul, I will include these numbers in the respin as we=
ll (with Tested-by from Vlad).

- Joel

>=20
>                            Thanx, Paul
>=20
